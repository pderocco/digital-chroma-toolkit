// MidiBase.h

#ifndef MIDIBASE_H
#define MIDIBASE_H

#include <cstdint>
#include <QByteArray>
#include <QQuickItem>
#include <QString>
#include <QStringList>
#include <QTimer>

class MidiBase: public QQuickItem {
    Q_OBJECT

    Q_PROPERTY(bool     autoOpen  NOTIFY autoOpenChanged  READ getAutoOpen  WRITE setAutoOpen)
    Q_PROPERTY(bool     outSense  NOTIFY outSenseChanged  READ getOutSense  WRITE setOutSense)
    Q_PROPERTY(QString  portName  NOTIFY portNameChanged  READ getPortName)
    Q_PROPERTY(QString  state     NOTIFY stateChanged     READ getState)

protected:

    bool                autoOpen;       // true to retry open every 500ms
    bool                isOpen;         // true if port is currently open
    bool                outSense;       // true to generate Active Sense bytes
    QString             portName;       // name of port, empty to close
    QString             state;          // overall port state
    QByteArray          sysex;          // input system exclusive accumulator
    int                 timer_in;       // Active Sense input timer id
    int                 timer_open;     // open retry timer id
    int                 timer_out;      // Active Sense output timer id

   void                computeState();
    void                openPort();
    void                processLong(char const* d, int n, unsigned t);
    void                processShort(unsigned m, unsigned t);

    virtual void        close() = 0;
    virtual bool        open() = 0;
    virtual bool        sendLong(QByteArray m) = 0;
    virtual bool        sendShort(unsigned m) = 0;
    virtual void        timerEvent(QTimerEvent* e) override;

public:

    explicit            MidiBase(QQuickItem* parent = nullptr): 
                                QQuickItem(parent), autoOpen(false), 
                                isOpen(false), outSense(false), 
                                state(QString("closed")), 
                                timer_in(0), timer_open(0), timer_out(0) {}

    bool                getAutoOpen() const { return autoOpen; }
    bool                getOutSense() const { return outSense; }
    QString             getPortName() const { return portName; }
    QString             getState() const { return state; }
    void                setAutoOpen(bool open);
    void                setOutSense(bool sense);
    Q_INVOKABLE void    setPortName(QString name);

    Q_INVOKABLE virtual QStringList
                        portList(int typ = 0) const = 0;

signals:

    void                autoOpenChanged(bool open);
    void                outSenseChanged(bool sense);
    void                portNameChanged(QString name);
    void                rxLong(QByteArray msg, unsigned tstamp);
    void                rxShort(unsigned msg, unsigned tstamp);
    void                rxTimeout();
    void                stateChanged(QString newstate);

public slots:

    void                txLong(QByteArray msg);
    void                txShort(unsigned msg);
    };

#endif // MIDIBASE_H
