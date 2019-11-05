// AudioInput.h

#ifndef AUDIOINPUT_H
#define AUDIOINPUT_H

#include <QObject>
#include <QQuickItem>
#include <QAudioFormat>
#include <QAudioInput>
#include <QByteArray>
#include <QIODevice>
#include <QList>
#include <QString>

class AudioInput: public QObject {

    Q_OBJECT
    Q_PROPERTY(int     depth   NOTIFY depthChanged   READ depth   WRITE setDepth)
    Q_PROPERTY(bool    enable  NOTIFY enableChanged  READ enable  WRITE setEnable)
    Q_PROPERTY(bool    offset  NOTIFY offsetChanged  READ offset  WRITE setOffset)
    Q_PROPERTY(QString port    NOTIFY portChanged    READ port    WRITE setPort)
    Q_PROPERTY(int     rate    NOTIFY rateChanged    READ rate    WRITE setRate)
    Q_PROPERTY(bool    stereo  NOTIFY stereoChanged  READ stereo  WRITE setStereo)

    QIODevice*      m_device;
    bool            m_enable;
    QAudioFormat    m_format;
    QAudioInput*    m_input;
    QString         m_port;

public:

    explicit        AudioInput(QObject* p = nullptr);

    int             depth() const { return m_format.sampleSize(); }
    bool            enable() const { return m_enable; }
    bool            offset() const { return m_format.sampleType() 
                            == QAudioFormat::UnSignedInt; }
    QString         port() const { return m_port; }
    int             rate() const { return m_format.sampleRate(); }
    bool            stereo() const { return m_format.channelCount() == 2; }

    void            setDepth(int depth);
    void            setEnable(bool enable);
    void            setOffset(bool offset);
    void            setPort(QString port);
    void            setRate(int rate);
    void            setStereo(bool stereo);

    Q_INVOKABLE
    QStringList     portList();

public slots:

    void            handleNotify();
    void            handleStateChanged(QAudio::State state);

signals:

    void            depthChanged(int depth);
    void            enableChanged(bool enable);
    void            error(QString message);
    void            offsetChanged(bool offset);
    void            portChanged(QString port);
    void            rateChanged(int rate);
    void            samples(QByteArray samples);
    void            stereoChanged(bool stereo);
    };

#endif // AUDIOINPUT_H
