// MidiWin.h

#ifndef MIDIWIN_H
#define MIDIWIN_H

#include <cstdint>
#include <iterator>
#include <QByteArray>
#include <QString>
#include <QWinEventNotifier>
#include <windows.h>
#include "MidiBase.h"

#define BUFN    512     // number of long message input buffers
#define BUFSZ   256     // size of each long message input buffer
#define QSZ     1024    // size of message input queue

class Midi: public MidiBase {
    Q_OBJECT

    HMIDIIN             in_device;          // device handle
    HANDLE              in_event;           // data arrival event
    volatile unsigned   in_head;            // queue head index
    unsigned            in_next;            // next buffer expected
    QWinEventNotifier*  in_notifier;        // event notifier
    volatile unsigned   in_tail;            // queue tail index
    std::uint8_t        in_buf[BUFN][BUFSZ];// array of data buffers
    MIDIHDR             in_hdr[BUFN];       // array of headers
    unsigned            in_messages[QSZ];   // message queue
    unsigned            in_tstamps[QSZ];    // timestamp queue

    HMIDIOUT            out_device;         // device handle
    HANDLE              out_event;          // output completion event
    MIDIHDR             out_hdr;            // header for sysex output

    void                in_callback(UINT m, DWORD_PTR p1, DWORD_PTR p2);
    void                in_process(HANDLE);

    virtual void        close();
    virtual bool        open();
    virtual bool        sendShort(unsigned m);
    virtual bool        sendLong(QByteArray m);

    static void CALLBACK callback(HMIDIIN h, UINT m, DWORD_PTR i, DWORD_PTR p1, 
                                DWORD_PTR p2);

public:              
                     
    explicit            Midi(QQuickItem* parent = nullptr);
                       ~Midi();

    virtual QStringList portList(int typ = 0) const;
    };

#endif // MIDIWIN_H
