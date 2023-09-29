// MidiWin.cpp

#include <QDebug>
#include "MidiWin.h"

/* explicit Midi::Midi(QQuickItem* parent = nullptr); -------------------------
This initializes everything that doesn't get initialized when a device is 
opened.                                                                      */

Midi::Midi(QQuickItem* parent): MidiBase(parent),
        in_device(nullptr),
        in_head(0),
        in_next(0),
        in_tail(0),
        out_device(nullptr) {

    // Clear input buffer headers, set up pointers to input buffers.
    memset(in_hdr, 0, sizeof(in_hdr));
    for (unsigned i = 0; i < BUFN; ++i) {
        MIDIHDR& mh = in_hdr[i];
        mh.lpData = LPSTR(in_buf[i]);
        mh.dwBufferLength = BUFSZ;
        }

    // Create Windows manual reset event for input.
    in_event = CreateEvent(nullptr, true, false, nullptr);

    // Create a QWinEventNotifier to translate the event into a signal.
    in_notifier = new QWinEventNotifier(in_event, this);

    // Tell the notifier to call the in_process() function on this object.
    connect(in_notifier, &QWinEventNotifier::activated, this, 
            &Midi::in_process);

    // Create Windows auto reset event for output.
    out_event = CreateEvent(nullptr, false, false, nullptr);

    // Clear output header.
    memset(&out_hdr, 0, sizeof(out_hdr));
    }

/* Midi::~Midi(); -------------------------------------------------------------
This closes the port without generating any signals, and deletes the events. */

Midi::~Midi() {
    
    close();
    CloseHandle(in_event);
    CloseHandle(out_event);
    }

/* static void CALLBACK Midi::callback(HMIDIIN h, UINT m, DWORD_PTR i, --------
    DWORD_PTR p1, DWORD_PTR p2); -- This calls the member version, called 
Midi::in_callback.                                                         */

void CALLBACK Midi::callback(HMIDIIN, UINT m, DWORD_PTR i, DWORD_PTR p1, 
        DWORD_PTR p2) {

    reinterpret_cast<Midi*>(i)->in_callback(m, p1, p2);
    }

/* virtual void Midi::close(); ------------------------------------------------
This closes the port.                                                        */

void Midi::close() {

    midiInStop(in_device);
    midiInReset(in_device);
    midiInClose(in_device);
    in_device = nullptr;
    midiOutUnprepareHeader(out_device, &out_hdr, sizeof(out_hdr));
    midiOutClose(out_device);
    out_device = nullptr;
    }

/* void Midi::in_callback(UINT m, DWORD_PTR p1, DWORD_PTR p2); ----------------
This processes a MIDI input event. A Data message is rearranged into a 24-bit 
integer with the status byte in the high-order position. A LongData message is 
converted into an index into the hdr and buf arrays. Other messages are 
ignored. The message is placed in the in_messages queue and the timestamp is 
placed in the in_tstamps queue, and the event is signaled. If the queues are 
full, a Data message is silently discarded, but a LongData message overwrites 
the previous message.                                                        */

void Midi::in_callback(UINT m, DWORD_PTR p1, DWORD_PTR p2) {
    unsigned    i, t;

    // Reformat as integer.
    if (m == MIM_DATA)
        m = ((p1 & 0xFF) << 16) | (p1 & 0xFF00) | ((p1 >> 16) & 0xFF);
    else if (m == MIM_LONGDATA)
        m = reinterpret_cast<MIDIHDR*>(p1) - in_hdr;
    else
        return;

    // If there's room, add to queues.
    t = in_tail;
    i = t + 1;
    if (i == QSZ)
        i = 0;
    if (i != in_head) {
        in_messages[t] = m;
        in_tstamps[t] = unsigned(p2) * 1000;
        in_tail = i;
        SetEvent(in_event);
        }

    // If no room, LongMsg overwrites last message.
    else if (m < BUFN) {
        if (!t)
            t = QSZ;
        --t;
        in_messages[t] = m;
        in_tstamps[t] = unsigned(p2) * 1000;
        SetEvent(in_event);
        }
    }

/* void Midi::in_process(HANDLE); ---------------------------------------------
This is called by the main thread when the MIDI input event is signaled. It 
processes all messages in the input queue by emitting them as signals. If a 
long message is encountered, its data is copied into a QByteArray and the 
buffer is given back to the device, unless it was empty, in which case it 
assumes the device was being closed and unprepares it.                       */

void Midi::in_process(HANDLE) {
    unsigned    h;      // temporary
    unsigned    m;      // message from queue
    MIDIHDR*    mh;     // header for long message
    unsigned    t;      // timestamp from queue

    // Allow further messages to set event again.
    ResetEvent(in_event);

    // For each message in queue...
    while (true) {
        h = in_head;
        if (h == in_tail)
            break;
        m = in_messages[h];
        t = in_tstamps[h];
        if (++h == QSZ)
            h = 0;
        in_head = h;

        // If long message...
        if (m < BUFN) {

            // Process any buffers lost because of overrun...
            while (in_next != m) {
                mh = &in_hdr[in_next];

                // If non-empty, discard data, recycle buffer.
                if (mh->dwBytesRecorded)
                    midiInAddBuffer(in_device, mh, sizeof(MIDIHDR));

                // If empty, unprepare buffer.
                else
                    midiInUnprepareHeader(in_device, mh, sizeof(in_hdr));
                if (++in_next == BUFN)
                    in_next = 0;
                }

            // If non-empty, process long message, recycle buffer.
            mh = &in_hdr[m];
            if (mh->dwBytesRecorded) {
                processLong((char const*)mh->lpData, mh->dwBytesRecorded, t);
                midiInAddBuffer(in_device, mh, sizeof(MIDIHDR));
                }

            // If empty, unprepare buffer.
            else
                midiInUnprepareHeader(in_device, mh, sizeof(in_hdr));

            // Next message.
            if (++in_next == BUFN)
                in_next = 0;
            }

        // If short message, process.
        else
            processShort(m, t);
        }
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
    MIDIINCAPS  ci;         // input descriptor
    MIDIOUTCAPS co;         // output descriptor
    int         i, n;       // index and count
    QString     ni;         // input name
    QString     no;         // output name

    
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

    // Find input port.
    n = midiInGetNumDevs();
    for (i = 0; i < n; ++i)
        if (midiInGetDevCaps(i, &ci, sizeof(ci)) == MMSYSERR_NOERROR 
                && ni == QString::fromWCharArray(ci.szPname))
            break;

    // If not found, or can't open, return false.
    if (i == n || midiInOpen(&in_device, i, DWORD_PTR(&callback), 
            DWORD_PTR(this), CALLBACK_FUNCTION) != MMSYSERR_NOERROR)
        return false;

    // Find output port.
    n = midiOutGetNumDevs();
    for (i = 0; i < n; ++i)
        if (midiOutGetDevCaps(i, &co, sizeof(co)) == MMSYSERR_NOERROR 
                && no == QString::fromWCharArray(co.szPname))
            break;

    // If not found, or can't open, close input, return false.
    if (i == n || midiOutOpen(&out_device, i, DWORD_PTR(out_event), 
            DWORD_PTR(this), CALLBACK_EVENT) != MMSYSERR_NOERROR) {
        midiInClose(in_device);
        return false;
        }

    // Prepare headers.
    for (i = 0; i < BUFN; ++i) {
        MIDIHDR& mh = in_hdr[i];
        mh.dwFlags = 0;
        midiInPrepareHeader(in_device, &mh, sizeof(mh));
        midiInAddBuffer(in_device, &mh, sizeof(mh));
        }
    out_hdr.dwFlags = 0;
    midiOutPrepareHeader(out_device, &out_hdr, sizeof(out_hdr));

    // Start input, return success.
    midiInStart(in_device);
    return true;
    }

/* virtual QStringList Midi::portList(int typ = 0) const; ---------------------
This returns a list of the names of all existing ports that support both input 
and output, optionally followed by those that only support input if typ bit 1 
is set, and those that only support output if typ bit 0 is set. Since Windows 
may give paired input and output ports names that differ in a few characters, 
typically "IN" vs. "OUT", this scans both lists looking for names that match 
except for up to three characters. In the final output list, these ports are 
listed with three newline-separated names in a single string. The first name is 
the user-friendly name, consisting of the characters that match between the two 
names; the second is the input name; and the third is the output name. For 
instance, a typical Windows name might be:
    "MIDI2 (Acme Synth)\nMIDIIN2 (Acme Synth)\nMIDIOUT2 (Acme Synth)"        */

QStringList Midi::portList(int typ) const {
    MIDIINCAPS      ci;     // MIDI port descriptors
    MIDIOUTCAPS     co;     //  containing port name
    unsigned        i;      // index
    QStringList     lis;    // combined list
    QStringList     lisi;   // input port list
    QStringList     liso;   // output port list
    unsigned        n;      // count

    // Get list of input names.
    n = midiInGetNumDevs();
    for (i = 0; i < n; ++i)
        if (midiInGetDevCaps(i, &ci, sizeof(ci)) == MMSYSERR_NOERROR)
            lisi.push_back(QString::fromWCharArray(ci.szPname));

    // Get list of output names.
    n = midiOutGetNumDevs();
    for (i = 0; i < n; ++i)
        if (midiOutGetDevCaps(i, &co, sizeof(co)) == MMSYSERR_NOERROR)
            liso.push_back(QString::fromWCharArray(co.szPname));

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
            int n = max(im - m, om - m);    // longer mismatch
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

/* bool Midi::sendLong(QByteArray m); -----------------------------------------
This outputs a long message, and returns true if successful, false if an error 
occurs.                                                                      */

bool Midi::sendLong(QByteArray m) {

    out_hdr.lpData = m.data();
    out_hdr.dwBufferLength = out_hdr.dwBytesRecorded = m.size();
    out_hdr.dwFlags &= ~MHDR_DONE;
    if (midiOutLongMsg(out_device, &out_hdr, sizeof(out_hdr)) 
            != MMSYSERR_NOERROR)
        return false;
    else {
        WaitForSingleObject(out_event, INFINITE);
        return true;
        }
    }

/* bool Midi::sendShort(unsigned m); ------------------------------------------
This outputs short message m, and returns true if successful, false if an error 
occurs.                                                                      */

bool Midi::sendShort(unsigned msg) {

    return midiOutShortMsg(out_device, 
            ((msg & 0xFF) << 16) | (msg & 0xFF00) | ((msg >> 16) & 0xFF)) 
            == MMSYSERR_NOERROR;
    }
