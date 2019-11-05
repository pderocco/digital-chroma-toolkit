// MidiMac.h

#ifndef MIDIMAC_H
#define MIDIMAC_H

#include <cstdint>
#include <iterator>
#include <CoreFoundation/CoreFoundation.h>
#include <CoreMIDI/MIDIServices.h>
#include <CoreAudio/HostTime.h>
#include <mach/mach.h>
#include <QByteArray>
#include <QDebug>
#include <QString>
#include <sys/types.h>
#include <sys/socket.h>
#include "MidiBase.h"

#define QSZ     0x10000 // size of message input queue

class Midi: public MidiBase {
    Q_OBJECT

    MIDIClientRef   client;             // client representing this program
    uint8_t         data[QSZ];          // input queue
    MIDIEndpointRef dst;                // currently open output
    unsigned        head;               // input queue head index
    MIDIPortRef     port;               // input port for this program
    semaphore_t     sem;                // output complete semaphore
    MIDIEndpointRef src;                // currently open input
    uint64_t        startTime;          // wallclock time when port was opened
    unsigned        tail;               // input queue tail index

    void            callback(const MIDIPacketList* pl);
    QString         inputName(int i) const;
    QString         outputName(int i) const;

    virtual void    close();
    virtual bool    open();
    virtual bool    sendShort(unsigned m);
    virtual bool    sendLong(QByteArray m);

    static void     inCallback(const MIDIPacketList* pl, void* r, void* c);
    static void     outCallback(MIDISysexSendRequest* req);

signals:

    void            inputAvailable();

private slots:

    void            processInput();

public:              
                     
    explicit        Midi(QQuickItem* parent = nullptr);
                   ~Midi();

    virtual QStringList
                    portList(int typ = 0) const;
    };

#endif // MIDIMAC_H
