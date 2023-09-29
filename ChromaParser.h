// ChromaParser.h

#ifndef CHROMAPARSER_H
#define CHROMAPARSER_H

#include <QObject>
#include <QQuickItem>

class ChromaParser: public QObject {

    Q_OBJECT
    Q_PROPERTY(int enable    NOTIFY enableChanged    READ enable  WRITE setEnable)
    Q_PROPERTY(int numprogs  NOTIFY numprogsChanged  READ numprogs)
    Q_PROPERTY(int prognum   NOTIFY prognumChanged   READ prognum)

    char            buf[62];    // data buffer (1 larger than valid program)
    uint8_t         chk;        // checksum accumulator
    unsigned        cnt;        // bytes in buf
    bool            m_enable;   // enable
    int             m_numprogs; // number of good programs emitted (0 to 50)
    int             m_prognum;  // total number of programs received (0 to 50)
    int             state;

    void            processPacket(bool ok);

    static char const header[];
    static char const scratch[];

public:

    explicit        ChromaParser(QObject* p = nullptr): QObject(p), 
                            m_enable(false), m_numprogs(0), m_prognum(0) {}

    bool            enable() const { return m_enable; }
    int             numprogs() const { return m_numprogs; }
    int             prognum() const { return m_prognum; }

public slots:

    void            character(int ch);
    void            setEnable(bool enable);

signals:

    void            badProg(int prog);
    void            data(QByteArray data);
    void            enableChanged(bool enable);
    void            numprogsChanged(int numprogs);
    void            prognumChanged(int prognum);
    };

#endif // CHROMAPARSER_H
