// MidiWin.cpp

#include "MidiMac.h"

/* explicit Midi::Midi(QQuickItem* parent = nullptr); -------------------------
This creates a local port for receiving input.                               */

Midi::Midi(QQuickItem* parent): MidiBase(parent), head(0), tail(0) {

    MIDIClientCreate(CFSTR("Digital Chroma Editor"), nullptr, nullptr, 
            &client);
    MIDIInputPortCreate(client, CFSTR("Digital Chroma Editor input port"), 
            inCallback, this, &port);
    semaphore_create(mach_task_self(), &sem, SYNC_POLICY_FIFO, 0);
    }

/* Midi::~Midi(); -------------------------------------------------------------
This closes the port without generating any signals, and deletes the MIDI port 
and client objects.                                                          */

Midi::~Midi() {
    
    close();
    MIDIPortDispose(port);
    MIDIClientDispose(client);
    }

/* void Midi::callback(const MIDIPacketList* pl); -----------------------------
This copies each packet into the MIDI input queue, preceded by the 32-bit 
millisecond timestamp and the 16-bit length. If the FIFO overflows, entire 
packets are discarded. The tail index is updated once for each packet.       */

void Midi::callback(const MIDIPacketList* pl) {
    unsigned            j;      // tail index into queue
    unsigned            l;      // packet length
    unsigned            n;      // packet counter
    MIDIPacket const*   p;      // packet pointer
    unsigned            t;      // timestamp

    // Copy FIFO tail index.
    j = tail;

    // For each packet...
    p = pl->packet;
    n = pl->numPackets;
    while (n--) {

        // If packet isn't empty, and there is room for it in queue...
        l = p->length;
        if (l && l + 6 <= (head - tail + QSZ - 1) % QSZ) {

            // Copy timestamp into FIFO, after converting to milliseconds.
            t = (p->timeStamp - startTime) / 1000000;
            data[j] = t;
            if (++j == QSZ)
                j = 0;
            data[j] = t >> 8;
            if (++j == QSZ)
                j = 0;
            data[j] = t >> 16;
            if (++j == QSZ)
                j = 0;
            data[j] = t >> 24;
            if (++j == QSZ)
                j = 0;

            // Copy data length into FIFO.
            data[j] = l;
            if (++j == QSZ)
                j = 0;
            data[j] = l >> 8;
            if (++j == QSZ)
                j = 0;

            // Copy data into FIFO, in two runs if it wraps the queue.
            if (l >= QSZ - j) {
                memcpy(&data[j], p->data, QSZ - j);
                l -= QSZ - j;
                j = 0;
                }
            if (l) {
                memcpy(&data[j], p->data, l);
                j += l;
                }

            // Update tail.
            tail = j;
            }

        // Next packet.
        p = MIDIPacketNext(p);
        }

    // Tell main thread that input is available.
    emit inputAvailable();
    }

/* virtual void Midi::close(); ------------------------------------------------
This disconnects the input.                                                  */

void Midi::close() {

    // Disconnect inputAvailable signal from processInput slot.
    disconnect(this, &Midi::inputAvailable, this, &Midi::processInput);

    if (src)
        MIDIPortDisconnectSource(port, src);
    src = 0;
    dst = 0;
    }

/* static void CALLBACK Midi::inCallback(const MIDIPacketList* pl, void* r, -
    void* c); -- This calls the member version, called Midi::Callback.     */

void Midi::inCallback(const MIDIPacketList* pl, void* r, void*) {

    reinterpret_cast<Midi*>(r)->callback(pl);
    }

/* QString Midi::inputName(int i) const; --------------------------------------
This takes a zero-based input number and returns the corresponding device name 
and port name, concatenated. If the two names are the same, it only returns the 
single name.                                                                 */

QString Midi::inputName(int i) const {
    UniChar         b[64];  // Unicode endpoint name
    MIDIEndpointRef e;      // source endpoint
    unsigned        n;      // endpoint name length
    CFStringRef     s;      // CFString object

    // Get source, return empty string if error.
    e = MIDIGetSource(i);
    if (!e)
        return "";

    // Get source name.
    MIDIObjectGetStringProperty(e, kMIDIPropertyDisplayName, &s);

    // Convert to Unicode, return empty string if too long.
    n = CFStringGetLength(s);
    if (n > sizeof(b))
        return "";
    CFStringGetCharacters(s, CFRangeMake(0, n), b);
    CFRelease(s);

    // Return as QString.
    return QString(reinterpret_cast<const QChar*>(b), n);
    }

/* virtual bool Midi::open(); -------------------------------------------------
This gets the number of devices, reads the name of each one, and looks for a 
match to the current portName. If a match is found, it tries to open the 
device. If successful, it prepares all the headers, adds them to the device's 
buffer queue, starts the device input, and returns true. If unsuccessful, it 
returns false. The portName can either be a simple string by which both the 
input and output are known, or can be a three-part string separated by 
newlines, where the second and third are the input and output names, and the 
first is a user-friendly name which is ignored by this.                      */

bool Midi::open() {
    int         i, n;       // index and count
    QString     ni;         // input name
    QString     no;         // output name
    QString     s;          // a port name
    
    // Split paired names.
    i = portName.indexOf(QChar('\n'));
    if (i > 0) {
        ni = QString(portName.data() + i + 1);
        i = ni.indexOf(QChar('\n'));
        no = QString(ni.data() + i + 1);
        ni.resize(i);
        }
    else
        ni = no = portName;

    // Find input port, return false if none.
    n = MIDIGetNumberOfSources();
    for (i = 0; i < n && ni != inputName(i); ++i);
    if (i == n)
        return false;

    // Get source. If unsuccessful, return false.
    src = MIDIGetSource(i);
    if (!src) {
        src = 0;
        return false;
        }

    // Find output port, return false if none.
    n = MIDIGetNumberOfDestinations();
    for (i = 0; i < n && ni != outputName(i); ++i);
    if (i == n)
        return false;

    // Get destination. If unsuccessful, return false.
    dst = MIDIGetDestination(i);
    if (!dst)
        return false;

    // Clear input FIFO.
    head = tail;

    // Get starting time for timestamps.
    startTime = AudioConvertHostTimeToNanos(AudioGetCurrentHostTime());

    // Connect inputAvailable signal to processInput slot.
    connect(this, &Midi::inputAvailable, this, &Midi::processInput);

    // Connect source to local port. If unsuccessful, close and return false.
    if (MIDIPortConnectSource(port, src, nullptr)) {
        close();
        return false;
        }

    // Success.
    return true;
    }

/* void Midi::outCallback(MIDISysexSendRequest* req); -------------------------
This is called when an outgoing sysex transmission is complete. It signals the 
semaphore to indicate the output data have been consumed.                    */

void Midi::outCallback(MIDISysexSendRequest* req) {

    semaphore_signal(reinterpret_cast<Midi*>(req->completionRefCon)->sem);
    }

/* QString Midi::outputName(int i) const; -------------------------------------
This takes a zero-based output number and returns the corresponding device name 
and port name, concatenated. If the two names are the same, it only returns the 
single name.                                                                 */

QString Midi::outputName(int i) const {
    UniChar         b[64];  // Unicode endpoint name
    MIDIEndpointRef e;      // destination endpoint
    unsigned        n;      // endpoint name length
    CFStringRef     s;      // endpoint name

    // Get destination, return empty string if error.
    e = MIDIGetDestination(i);
    if (!e)
        return "";

    // Get destination name.
    MIDIObjectGetStringProperty(e, kMIDIPropertyDisplayName, &s);

    // Convert to Unicode, return empty string if too long.
    n = CFStringGetLength(s);
    if (n > sizeof(b))
        return "";
    CFStringGetCharacters(s, CFRangeMake(0, n), b);
    CFRelease(s);

    // Return as QString.
    return QString(reinterpret_cast<const QChar*>(b), n);
    }

/* virtual QStringList Midi::portList(int typ = 0) const; ---------------------
This returns a list of the names of all existing ports that support both input 
and output, optionally followed by those that only support input if typ bit 1 
is set, and those that only support output if typ bit 0 is set. Since the Mac 
may give paired input and output ports names that differ in a few characters, 
typically "IN" vs. "OUT", this scans both lists looking for names that match 
except for up to three characters. In the final output list, these ports are 
listed with three newline-separated names in a single string. The first name is 
the user-friendly name, consisting of the characters that match between the two 
names; the second is the input name; and the third is the output name.       */

QStringList Midi::portList(int typ) const {
    int             i;      // index
    QStringList     lis;    // combined list
    QStringList     lisi;   // input port list
    QStringList     liso;   // output port list
    int             n;      // count
    QString         s;      // port name

    // Get list of input names.
    n = MIDIGetNumberOfSources();
    for (i = 0; i < n; ++i) {
        s = inputName(i);
        if (s.size())
            lisi.push_back(s);
        }

    // Get list of output names.
    n = MIDIGetNumberOfDestinations();
    for (i = 0; i < n; ++i) {
        s = outputName(i);
        if (s.size())
            liso.push_back(s);
        }

    // Build list of names in both lists.
    auto istr = lisi.begin();               // lisi scanner
    while (istr != lisi.end()) {
        auto ostr = liso.begin();           // liso scanner
        while (ostr != liso.end() && *istr != *ostr)
            ++ostr;
        if (ostr == liso.end())
            ++istr;
        else {
            lis.push_back(*istr);
            istr = lisi.erase(istr);
            liso.erase(ostr);
            }
        }

    // Append list of paired names from both lists.
    istr = lisi.begin();                    // lisi scanner
    while (istr != lisi.end()) {

        // Find output name that best matches this input name.
        auto ostrbest = liso.end();         // best match found so far
        int nbest = INT_MAX;                // length of best match
        QString common;                     // common part of both names
        for (auto ostr = liso.begin(); ostr != liso.end(); ++ostr) {
            int m;                          // first mismatching char
            int im = istr->size();          // past last mismatching istr char
            int om = ostr->size();          // past last mismatching ostr char
            for (m = 0; m < im && m < om && (*istr)[m] == (*ostr)[m]; ++m);
            while ((*istr)[im - 1] == (*ostr)[om - 1]) {
                --im;
                --om;
                }
            int n = std::max(im - m, om - m);// longer mismatch
            if (nbest > n) {
                nbest = n;
                common.clear();
                common.append(istr->data(), m);
                common.append(istr->data() + im, istr->size() - im);
                ostrbest = ostr;
                }
            }

        // If good match found...
        if (nbest <= 3) {

            // Resulting name consists of three newline-separated parts:
            //  name with mismatching chars removed
            //  input name
            //  output name
            QString s = common;
            s += "\n";
            s += *istr;
            s += "\n";
            s += *ostrbest;
            lis.push_back(s);
            istr = lisi.erase(istr);
            liso.erase(ostrbest);
            }
        else
            ++istr;
        }

    // Optionally append remaining input and output names.
    if (typ & 2)
        lis.append(lisi);
    if (typ & 1)
        lis.append(liso);
    return lis;
    }

/* void Midi::processInput(); -------------------------------------------------
This slot is invoked through via queued signal from the CoreMidi input thread. 
It processes all the MIDI input packets in the input queue. Each packet begins 
with a 32-bit timestamp and 16-bit nonzero length, and contains either a single 
Sysex or fragment thereof, or one or more complete short messages without 
running status. Each Sysex or fragment is given to processLong, and each short 
message is given to processShort.                                            */

void Midi::processInput() {
    uint8_t     b;      // byte from queue
    unsigned    i;      // movable head index into queue
    unsigned    l;      // packet length
    unsigned    m;      // short message
    unsigned    t;      // timestamp

    // While packets are available...
    i = head;
    while (i != tail) {

        // Parse timestamp.
        t = data[i];
        if (++i == QSZ)
            i = 0;
        t |= data[i] << 8;
        if (++i == QSZ)
            i = 0;
        t |= data[i] << 16;
        if (++i == QSZ)
            i = 0;
        t |= data[i] << 24;
        if (++i == QSZ)
            i = 0;

        // Parse length.
        l = data[i];
        if (++i == QSZ)
            i = 0;
        l |= data[i] << 8;
        if (++i == QSZ)
            i = 0;

        // If packet starts with data or Sysex...
        if (data[i] < 0x80 || data[i] == 0xF0) {

            // Process long data, in two runs if it wraps the queue.
            if (i + l >= QSZ) {
                processLong((char const*)&data[i], QSZ - i, t);
                l -= QSZ - i;
                i = 0;
                }
            if (l) {
                processLong((char const*)&data[i], l, t);
                i += l;
                }
            }

        // Otherwise, send each short message in packet.
        else {
            while (signed(l) > 0) {

                // Fetch status byte, begin to assemble message word.
                b = data[i++];
                m = b << 16;
                if (i == QSZ)
                    i = 0;

                // F4 and up are single byte.
                if (b >= 0xF4) {
                    processShort(m, t);
                    --l;
                    }
                else {

                    // Append first data byte.
                    m |= data[i++] << 8;
                    if (i == QSZ)
                        i = 0;

                    // C0...DF and F1 and F3 are two-byte.
                    if ((0xC0 <= b && b <= 0xDF) || b == 0xF1 || b == 0xF3) {
                        processShort(m, t);
                        l -= 2;
                        }
                    else {

                        // Everything else is three-byte.
                        m |= data[i++];
                        if (i == QSZ)
                            i = 0;
                        processShort(m, t);
                        l -= 3;
                        }
                    }
                }
            }

        // Update queue head.
        head = i;
        }
    }

/* bool Midi::sendLong(QByteArray m); -----------------------------------------
This outputs a long message, and returns true if successful, false if an error 
occurs.                                                                      */

bool Midi::sendLong(QByteArray m) {
    MIDISysexSendRequest    req;

    req.destination = dst;
    req.data = (Byte const*)m.data();
    req.bytesToSend = unsigned(m.size());
    req.complete = false;
    req.completionProc = outCallback;
    req.completionRefCon = (void*)this;
    if (MIDISendSysex(&req))
        return false;
    semaphore_wait(sem);
    return true;
    }

/* bool Midi::sendShort(unsigned m); ------------------------------------------
This outputs short message m, and returns true if successful, false if an error 
occurs. It uses MIDISendSysex, which works since the message is complete.    */

bool Midi::sendShort(unsigned m) {
    MIDISysexSendRequest    req;
    uint8_t                 buf[3];

    buf[2] = m;
    buf[1] = m >>= 8;
    buf[0] = m >>= 8;
    req.destination = dst;
    req.data = buf;
    req.bytesToSend = m < 0xC0 ? 3 : m < 0xE0 ? 2 : m < 0xF0 ? 3 
            : m == 0xF1 ? 2 : m == 0xF1 ? 3 : m == 0xF2 ? 2 : 1;
    req.complete = false;
    req.completionProc = outCallback;
    req.completionRefCon = (void*)this;
    if (MIDISendSysex(&req))
        return false;
    semaphore_wait(sem);
    return true;
    }
