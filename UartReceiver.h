// UartReceiver.h

#ifndef UARTRECEIVER_H
#define UARTRECEIVER_H

#include <QObject>
#include <QQuickItem>

class UartReceiver: public QObject {

    Q_OBJECT
    Q_PROPERTY(int enable  NOTIFY enableChanged  READ enable  WRITE setEnable)

    uint8_t         accum;      // character accumulator
    bool            garbage;    // garbage received before current program
    bool            m_enable;   // true to enable
    bool            parity;     // parity accumulator
    int             state;      // state
    int             zeroes;     // number of consecutive zeroes

public:

    explicit        UartReceiver(QObject* p = nullptr):
                            QObject(p), m_enable(false) {}

    bool            enable() const { return m_enable; }

public slots:

    void            bit(int v);
    void            setEnable(bool enable);

signals:

    void            character(int character);
    void            enableChanged(bool enable);
    };

#endif // UARTRECEIVER_H
