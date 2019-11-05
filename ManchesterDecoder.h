// ManchesterDecoder.h

#ifndef MANCHESTER_DECODER_H
#define MANCHESTER_DECODER_H

#include <QObject>
#include <QQuickItem>
#include <QByteArray>

class ManchesterDecoder: public QObject {

    Q_OBJECT
    Q_PROPERTY(int depth   NOTIFY depthChanged   READ depth   WRITE setDepth)
    Q_PROPERTY(int enable  NOTIFY enableChanged  READ enable  WRITE setEnable)
    Q_PROPERTY(int offset  NOTIFY offsetChanged  READ offset  WRITE setOffset)
    Q_PROPERTY(int rate    NOTIFY rateChanged    READ rate    WRITE setRate)
    Q_PROPERTY(int stereo  NOTIFY stereoChanged  READ stereo  WRITE setStereo)

    int             level;          // level detector
    int             m_depth;        // bits per sample
    bool            m_enable;       // true to enable
    bool            m_offset;       // true for offset unsigned samples
    int             m_rate;         // sample rate
    bool            m_stereo;       // true if stereo
    int             period;         // period counter
    bool            polarity;       // current input polarity
    int             state;          // parsing state (-1, 0, or 1)
    int             t25;            // minimum short period (25% of bit time)
    int             t75;            // short/long period threshold (75%)
    int             t125;           // maximum long period (125%)

    void            initialize();
    void            process(int v);

public:

    explicit        ManchesterDecoder(QObject* p = nullptr);

    int             depth() const { return m_depth; }
    bool            enable() const { return m_enable; }
    bool            offset() const { return m_offset; }
    int             rate() const { return m_rate; }
    bool            stereo() const { return m_stereo; }

public slots:

    void            samples(QByteArray samples);
    void            setDepth(int depth);
    void            setEnable(bool enable);
    void            setOffset(bool offset);
    void            setRate(int rate);
    void            setStereo(bool stereo);

signals:

    void            bit(int bit);
    void            depthChanged(int depth);
    void            enableChanged(bool enable);
    void            error(QString message);
    void            offsetChanged(bool offset);
    void            rateChanged(int rate);
    void            stereoChanged(bool stereo);
    };

#endif // MANCHESTER_DECODER_H
