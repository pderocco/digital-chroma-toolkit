// ChromaParser.cpp

#include "ChromaParser.h"

// Constants ------------------------------------------------------------------

char const ChromaParser::header[] = {
        '\xF0', '\x08', '\x00', '\x4B', '\x59', '\x7F', '\x33' };

/* void ChromaParser::character(int ch); --------------------------------------
This parses data character ch, which may be -1 to indicate an invalid character 
or -2 to indicate a break. Everything between breaks is given to 
processPacket() for validation. This merely accumulates characters in the buf 
array, counting them in cnt, and accumulating the checksum in chk. However, the 
buffer is only one larger than a valid program packet, so anything beyond that 
is discarded. Also, if an invalid character is received, it doesn't even buffer 
any additional characters, it just counts them. When it calls processPacket(), 
it passes a parameter indicating if it had found invalid characters.         */

void ChromaParser::character(int ch) {

    // If no characters received since the last break...
    if (!state) {
        if (ch == -1)
            state = -1;
        else if (ch != -2) {
            buf[0] = chk = ch;
            cnt = state = 1;
            }
        }

    // If at least 1 invalid character received...
    else if (state < 0) {
        if (ch == -2)
            processPacket(false);
        else if (ch != -1 && cnt < sizeof(buf))
            ++cnt;
        }

    // One or more good characters received...
    else {
        if (ch == -1)
            state = -1;
        else if (ch == -2)
            processPacket(true);
        else if (cnt < sizeof(buf)) {
            buf[cnt++] = ch;
            chk += ch;
            }
        }
    }

/* void ChromaParser::processPacket(bool ok); ---------------------------------
This processes the packet in the packet buffer. If the length of the packet is 
less than 30 bytes, it is simply ignored, since it couldn't possibly be a 
program. Otherwise, if ok is false, indicating that one or more invalid 
characters had been encountered, or the packet isn't a valid program packet, a 
warning is emitted, and the program is counted in the prognum property. 
Otherwise, the real program data is emitted and counted in both numprogs and 
prognum. Note, however, that before the first program is emitted, a Syntech 
sysex header is emitted. This also resets the state and packet length to 
zero.                                                                        */

void ChromaParser::processPacket(bool ok) {
    char    result[1 + 59 * 2];

    if (cnt > 30 && m_prognum < 50) {
        ++m_prognum;
        if (!ok || cnt != 62 || buf[0] != 60 || buf[1] != 1 || chk)
            emit badProg(m_prognum);
        else {
            if (!m_numprogs++)
                emit data(QByteArray(header, sizeof(header)));
            result[0] = m_prognum;
            for (int i = 0; i < 59; ++i) {
                result[1 + 2 * i] = (buf[2 + i] >> 4) & 0xF;
                result[2 + 2 * i] = buf[2 + i] & 0xF;
                }
            emit data(QByteArray(result, 1 + 59 * 2));
            emit numprogsChanged(m_numprogs);
            }
        emit prognumChanged(m_prognum);
        }
    state = cnt = 0;
    }

/* void ChromaParser::setEnable(bool enable); ---------------------------------
Tis turns the enable on or off. When turning it on, it resets numprogs, 
prognum, and the packet parsing state to zero. When turning it off, it 
processes a break to ensure any pending packet is processed, and if any 
programs had been generated, emits a MIDI EOX.                               */

void ChromaParser::setEnable(bool enable) {

    if (m_enable != enable) {
        if (enable) {
            state = 0;
            if (m_numprogs)
                emit numprogsChanged(m_numprogs = 0);
            if (m_prognum)
                emit prognumChanged(m_prognum = 0);
            }
        else {
            character(-2); // pretend break was received
            if (m_numprogs)
                emit data(QByteArray("\xF7", 1));
            }
        emit enableChanged(m_enable = enable);
        }
    }
