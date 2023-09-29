// UartReceiver.cpp

#include "UartReceiver.h"

/* void UartReceiver::bit(int v); ---------------------------------------------
This processes a received bit, which can be -1 to indicate an upstream error. 
It emits a character value of 0..255, or -1 to indicate invalid input, or -2 to 
indicate a break (33 or more consecutive zero bits).                         */

void UartReceiver::bit(int v) {

    switch (state) {

    // Invalid state: wait for 1 before start bit, count zeroes.
    case -1:
        if (v > 0) {
            if (zeroes > 32)
                emit character(-2);
            state = 0;
            }
        break;

    // Idle state: wait for 0 start bit.
    case 0:
        if (v < 0)
            emit character(state = -1);
        else if (v == 0) {
            accum = 0;
            parity = false;
            ++state;
            }
        break;

    // Data state: accumulate character and parity.
    case 1: case 2: case 3: case 4: case 5: case 6: case 7: case 8:
        if (v < 0)
            emit character(state = -1);
        else {
            if (v > 0) {
                accum |= 1 << state >> 1;
                parity = !parity;
                }
            ++state;
            }
        break;

    // Parity state: include parity.
    case 9:
        if (v < 0)
            emit character(state = -1);
        else if (v > 0)
            parity = !parity;
        ++state;
        break;

    // Stop state: verify parity and stop bit.
    case 10:
        if (v < 0)
            emit character(state = -1);
        else if (v == 0)
            ++state;
        else {
            if (parity)
                emit character(-1);
            else
                emit character(accum);
            state = 0;
            }
        break;

    // Break state: wait for 1 or invalid.
    case 11:
        if (v != 0) {
            if (zeroes > 32)
                emit character(-2);
            if (v < 0)
                emit character(state = -1);
            else
                state = 0;
            }
        break;
        }

    // Count consecutive zeroes.
    if (v == 0)
        ++zeroes;
    else
        zeroes = 0;
    }

/* void UartReceiver::setEnable(bool enable); ---------------------------------
This sets the enable flag. If turning it on, it initializes the parsing 
state.                                                                       */

void UartReceiver::setEnable(bool enable) {

    if (m_enable != enable) {
        if (enable)
            state = zeroes = 0;
        emit enableChanged(m_enable = enable);
        }
    }
