// ManchesterDecoder.cpp

#include "ManchesterDecoder.h"
using namespace std;

/* explicit ManchesterDecoder::ManchesterDecoder(QObject* p = nullptr); -------
This provides valid default parameters, and initializes the state.           */

ManchesterDecoder::ManchesterDecoder(QObject* p): QObject(p), m_depth(8), 
        m_enable(false), m_offset(true), m_rate(24000), m_stereo(false) {

    initialize();
    }

/* void ManchesterDecoder::initialize(); --------------------------------------
This reinitializes the decoder, clearing out any old state.                  */

void ManchesterDecoder::initialize() {

    level = period = 0;
    polarity = false;
    state = -1;
    t25 = (m_rate + 2400) / 4800;
    t75 = (3 * m_rate + 2400) / 4800;
    t125 = (5 * m_rate + 2400) / 4800;
    }

/* void ManchesterDecoder::process(int v); ------------------------------------
This processes signed 16-bit sample v.                                       */

void ManchesterDecoder::process(int v) {
    int     h;      // hysteresis threshold
    bool    p;      // previous polarity

    // Count sample.
    ++period;

    // Compute filtered rectified signal.
    level += (abs(v) - level) >> 6;

    // Apply hysteresis equal to one half of the level.
    p = polarity;
    h = max(8, level >> 1);
    if (v > h)
        p = true;
    else if (v < -h)
        p = false;

    // If polarity change...
    if (polarity != p) {
        polarity = p;

        // If period is too short, emit -1.
        if (period < t25) {
            if (state >= 0)
                emit bit(state = -1);
            }

        // If period is too long, emit -1, 
        //  but precede with 1 if there is a short period pending.
        else if (period >= t125) {
            if (state > 0)
                emit bit(1);
            emit bit(state = -1);
            }

        // If period is typically long, emit 0 bit.
        //  but precede with -1 if there is a short period pending.
        else if (period >= t75) {
            if (state > 0)
                emit bit(-1);
            emit bit(0);
            state = 0;
            }

        // If no short period pending, record that one is now pending.
        else if (state <= 0)
            state = 1;

        // Otherwise, combine two short periods, emit 1 bit.
        else {
            emit bit(1);
            state = 0;
            }

        // Reset period counter.
        period = 0;
        }
    }

/* void ManchesterDecoder::samples(QByteArray samples); -----------------------
This processes the samples, synchronizes to the clock transitions, extracts the 
data transitions, and outputs them as 1 for rising edge, -1 for falling edge, 
or 0 for indeterminate. The last occurs during silence, and frequently during 
the initial synchronization.                                                 */

void ManchesterDecoder::samples(QByteArray samples) {
    int     t;      // temporary

    if (m_offset)
        if (m_depth == 16) {
            int16_t const* b = (int16_t const*)samples.data();
            int n = samples.size() >> 1;
            if (m_stereo)
                while (n--)
                    process((t = *b++, t + *b++));
            else
                while (n--)
                    process(*b++);
            }            
        else {
            int8_t const* b = (int8_t const*)samples.data();
            int n = samples.size();
            if (m_stereo)
                while (n--)
                    process((t = *b++, t + *b++));
            else
                while (n--)
                    process(*b++);
            }            
    else
        if (m_depth == 16) {
            uint16_t const* b = (uint16_t const*)samples.data();
            int n = samples.size() >> 1;
            if (m_stereo)
                while (n--)
                    process((t = *b++, t + *b++ - 0x10000));
            else
                while (n--)
                    process(*b++ - 0x8000);
            }            
        else {
            uint8_t const* b = (uint8_t const*)samples.data();
            int n = samples.size();
            if (m_stereo)
                while (n--)
                    process((t = *b++, t + *b++ - 0x100));
            else
                while (n--)
                    process(*b++ - 0x80);
            }            
    }

/* void ManchesterDecoder::setDepth(int depth); -------------------------------
If depth is 8 or 16, this sets the depth, and emits a depthChanged signal if it 
changed. Otherwise, it emits an error and leaves the depth unchanged.        */

void ManchesterDecoder::setDepth(int depth) {

    if (depth != 8 && depth != 16)
        emit error("unsupported bit depth");
    else if (m_depth != depth)
        emit depthChanged(m_depth = depth);
    }

/* void ManchesterDecoder::setEnable(bool enable); ----------------------------
This sets the enable flag. It trying to turn it on, this calls initialize, and 
refuses if it returns false. If turning it off, this emits an extra 0 or 1 bit 
if a transition at this point in time would cause such a bit. If the enable 
changed, this emits the enableChanged signal.                                */

void ManchesterDecoder::setEnable(bool enable) {

    if (m_enable != enable) {
        if (enable) {
            emit enableChanged(m_enable = true);
            initialize();
            }
        else {
            if (period < t125) {
                if (period >= t75)
                    emit bit(0);
                else if (period >= t25 && state >= 0)
                    emit bit(1);
                }
            emit enableChanged(m_enable = false);
            }
        }
    }

/* void ManchesterDecoder::setOffset(bool offset); ----------------------------
This sets the offset to either false or true, and emits an offsetChanged signal 
if it changes.                                                               */

void ManchesterDecoder::setOffset(bool offset) {

    if (m_offset != offset)
        emit offsetChanged(m_offset = offset);
    }

/* void ManchesterDecoder::setRate(int rate); ---------------------------------
If rate is between 8000 and 96000, this sets the sample rate, and emits an 
offsetChanged signal if it changed. Otherwise, it emits an error and leaves the 
rate unchanged. It also calls initialize.                                    */

void ManchesterDecoder::setRate(int rate) {

    if (8000 > rate || rate > 96000)
        emit error("unsupported sample rate");
    if (m_rate != rate) {
        emit rateChanged(m_rate = rate);
        initialize();
        }
    }

/* void ManchesterDecoder::setStereo(bool stereo); ----------------------------
This sets the stereo flag to either false or true, and emits a stereoChanged 
signal if it changes.                                                        */

void ManchesterDecoder::setStereo(bool stereo) {

    if (m_stereo != stereo)
        emit stereoChanged(m_stereo = stereo);
    }
