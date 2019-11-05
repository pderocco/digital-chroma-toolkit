// MidiBase.cpp

#include "MidiBase.h"

/* void MidiBase::computeState(); ---------------------------------------------
This recomputes the state string, and emits a signal whether or not it changes. 
The states are:

    "closed" -- the port cannot be opened, and autoOpen is false
    "waiting" -- the port isn't open, but timer_open indicates a future 
        attempt to open it is pending.
    "open" -- the port is currently open.                                    */

void MidiBase::computeState() {

    emit stateChanged(state = isOpen ? "open" 
                            : timer_open ? "waiting"
                            : "closed");
    }

/* void MidiBase::openPort(); -------------------------------------------------
This first closes the port if it is open, and stops Active Sense timing. Then, 
it attempts to open the port. If successful, it starts Active Sense output 
transmission if enabled, and if that fails, closes the port again. If 
unsuccessful, it starts the auto-retry timer if enabled. If it closes and 
re-opens the port, it signals a state change to "closed" or "waiting" followed 
by a change to "open".                                                       */

void MidiBase::openPort() {

    // If open...
    if (isOpen) {

        // Close device, report state change.
        close();
        isOpen = false;
        computeState();

        // Stop Active Sense input timing.
        if (timer_in) {
            killTimer(timer_in);
            timer_in = 0;
            }

        // Stop Active Sense output Tx.
        if (timer_out) {
            killTimer(timer_out);
            timer_out = 0;
            }
        }

    // Otherwise, stop auto-open timer.
    else if (timer_open) {
        killTimer(timer_open);
        timer_open = 0;
        }

    // Try opening device. If successful...
    if (open()) {

        // Report state change.
        isOpen = true;
        computeState();

        // If Active sense output is enabled, start Tx.
        if (outSense) {
            timer_out = startTimer(200, Qt::PreciseTimer);
            txShort(0xFE0000);
            }
        }

    // If unsuccessful, and auto-open enabled, start auto-open timer.
    else if (autoOpen)
        timer_open = startTimer(500, Qt::PreciseTimer);
    }

/* void MidiBase::processLong(char const* d, int n, unsigned t); --------------
This processes the n bytes at d as a received sysex or fragment thereof, with a 
timestamp of t. Data are accumulated in the sysex array, and receipt of EOX 
causes the contents to be emitted as an rxLong signal, after which the array is 
cleared. If a new sysex is started while one is already pending, an EOX is 
appended and the signal is emitted before the new one is saved in the array. If 
data bytes are received while no sysex is pending, they are discarded.       */

void MidiBase::processLong(char const* d, int n, unsigned t) {

    // If no pending sysex...
    if (!sysex.size()) {

        // If buffer starts with 0xF0, record in sysex.
        if (d[0] == char(0xF0)) {
            sysex.resize(n);
            memcpy(sysex.data(), d, n);
            }
        }

    // If pending sysex, and this starts with 0xF0...
    else if (d[0] == char(0xF0)) {

        // Append EOX, emit signal for pending sysex.
        sysex.append(char(0xF7));
        emit rxLong(sysex, t);

        // Record buffer.
        sysex.resize(n);
        memcpy(sysex.data(), d, n);
        }

    // Otherwise, append buffer.
    else
        sysex.append(d, n);

    // If it ends with EOX, emit signal, clear sysex.
    if (sysex.size() && sysex.back() == char(0xF7)) {
        emit rxLong(sysex, t);
        sysex.clear();
        }
    }

/* void MidiBase::processShort(unsigned m, unsigned t); -----------------------
This processes short message m, with timestamp t. Active sense bytes start or 
postpone the timer_in timer, while everything else is emitted as an rxShort 
signal. If a partial input sysex is pending when a non-realtime message 
arrives, an EOX is appended and an rxLong signal is emitted before the short 
message.                                                                     */

void MidiBase::processShort(unsigned m, unsigned t) {

    // If Active Sense, just start or postpone 300ms timer.
    if (m == 0xFE0000) {
        if (timer_in)
            killTimer(timer_in);
        timer_in = startTimer(300, Qt::PreciseTimer);
        }
    else {

        // If non-realtime, and there's a pending sysex, 
        //  append EOX, emit signal, clear it
        if (m < 0xF80000 && sysex.size()) {
            sysex.append(char(0xF7));
            emit rxLong(sysex, t);
            sysex.clear();
            }

        // Emit as short message.
        emit rxShort(m, t);
        }
    }

/* void MidiBase::setAutoOpen(bool open); -------------------------------------
This sets the auto-open enable to open. If it changes from disabled to enabled, 
this tries opening the port.                                                 */

void MidiBase::setAutoOpen(bool open) {

    if (autoOpen != open) {
        emit autoOpenChanged(autoOpen = open);
        if (!isOpen) {
            if (autoOpen)
                openPort();
            else {
                if (timer_open) {
                    killTimer(timer_open);
                    timer_open = 0;
                    }
                computeState();
                }
            }
        }
    }

/* void MidiBase::setOutSense(bool sense); ------------------------------------
This enables or disables outputting of Active Sense bytes. If this is turned on 
and the port is open, an initial Active Sense byte is sent, and a timer is 
started which sends another whenever it times out. Sending anything else 
postpones this timer.                                                        */

void MidiBase::setOutSense(bool sense) {

    if (outSense != sense) {
        emit outSenseChanged(outSense = sense);
        if (!sense) {
            if (timer_out) {
                killTimer(timer_out);
                timer_out = 0;
                }
            }
        else if (isOpen) {
            if (!timer_out)
                timer_out = startTimer(200, Qt::PreciseTimer);
            txShort(0xFE0000);
            }
        }
    }

/* void MidiBase::setPortName(QString name); ----------------------------------
This sets the portName to name, and emits a portNameChanged signal even if the 
name didn't change. It closes the port if it is open, schedules an attempt, 
to open it 500ms in the future, and signals a change to the "waiting" state. */

void MidiBase::setPortName(QString name) {

    portName = name;
    emit portNameChanged(name);
    if (isOpen) {
        close();
        isOpen = false;
        }
    if (!timer_open)
        timer_open = startTimer(500, Qt::PreciseTimer);
    computeState();
    }

/* virtual void MidiBase::timerEvent(QTimerEvent* e); -------------------------
This handles Active Sense input timeout, Active Sense output timeout, auto-open 
timeout.                                                                     */

void MidiBase::timerEvent(QTimerEvent* e) {
    int     t = e->timerId();

    // If Active Sense input timeout, stop that timer, emit rxTimeout signal.
    if (t == timer_in) {
        killTimer(timer_in);
        timer_in = 0;
        emit rxTimeout();
        }

    // If auto-timer expired, try opening port.
    else if (t == timer_open)
        openPort();

    // If Active Sense output timeout, send Active Sense byte.
    else if (t == timer_out)
        txShort(0xFE0000);
    }

/* void MidiBase::txLong(QByteArray msg); -------------------------------------
If the port is open, this postpones Active Sense sending, and sends long 
message msg. If an error occurs, it tries closing and re-opening the port.   */

void MidiBase::txLong(QByteArray msg) {

    if (isOpen) {
        if (timer_out) {
            killTimer(timer_out);
            timer_out = startTimer(200, Qt::PreciseTimer);
            }
        if (!sendLong(msg))
            openPort();
        }
    }

/* void MidiBase::txShort(unsigned msg); --------------------------------------
If the port is open, this postpones Active Sense sending unless msg is an 
Active Sense, and sends short message msg. If an error occurs, it tries closing 
and re-opening the port.                                                     */

void MidiBase::txShort(unsigned msg) {

    if (isOpen) {
        if (msg != 0xFE0000 && timer_out) {
            killTimer(timer_out);
            timer_out = startTimer(200, Qt::PreciseTimer);
            }
        if (!sendShort(msg))
            openPort();
        }
    }
