// WavReader.h

#ifndef WAVREADER_H
#define WAVREADER_H

#include <QObject>
#include <QQuickItem>
#include <QAudioDecoder>
#include <QAudioFormat>

class WavReader: public QObject {

    Q_OBJECT
    Q_PROPERTY(int depth    NOTIFY depthChanged   READ depth)
    Q_PROPERTY(int enable   NOTIFY enableChanged  READ enable  WRITE setEnable)
    Q_PROPERTY(QString name NOTIFY nameChanged    READ name    WRITE setName)
    Q_PROPERTY(int offset   NOTIFY offsetChanged  READ offset)
    Q_PROPERTY(int rate     NOTIFY rateChanged    READ rate)
    Q_PROPERTY(int stereo   NOTIFY stereoChanged  READ stereo)

    QAudioDecoder   m_decoder;
    bool            m_enable;
    QAudioFormat    m_format;
    QString         m_name;

public:

    explicit        WavReader(QObject* p = nullptr);

    int             depth() const {
                        return m_decoder.audioFormat().sampleSize();
                        }
    int             enable() const {
                        return m_enable;
                        }
    QString         name() const {
                        return m_name;
                        }
    int             offset() const {
                        return m_decoder.audioFormat().sampleType() 
                                == QAudioFormat::UnSignedInt;
                        }
    int             rate() const {
                        return m_decoder.audioFormat().sampleRate();
                        }
    int             stereo() const {
                        return m_decoder.audioFormat().channelCount() == 2;
                        }

    void            setEnable(bool enable);
    void            setName(QString name);

public slots:

    void            handleBufferReady();
    void            handleError(QAudioDecoder::Error e);
    void            handleFormatChanged(QAudioFormat const& f);
    void            handleStateChanged(QAudioDecoder::State s);

signals:

    void            depthChanged(int depth);
    void            enableChanged(bool enable);
    void            error(QString message);
    void            nameChanged(QString name);
    void            offsetChanged(bool offset);
    void            rateChanged(int rate);
    void            samples(QByteArray samples);
    void            stereoChanged(bool stereo);
    };

#endif // WAVREADER_H
