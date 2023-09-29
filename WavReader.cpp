// WavReader.cpp

#include "WavReader.h"

/* explicit WavReader::WavReader(QObject* p = nullptr); -----------------------
This installs handlers for some signals of the QAudioDecoder.                */

WavReader::WavReader(QObject* p): m_decoder(p), m_enable(false) {

    connect(&m_decoder, SIGNAL(bufferReady()), 
            this, SLOT(handleBufferReady()));
    connect(&m_decoder, SIGNAL(error(QAudioDecoder::Error)), 
            this, SLOT(handleError(QAudioDecoder::Error)));
    connect(&m_decoder, SIGNAL(formatChanged(QAudioFormat const&)), 
            this, SLOT(handleFormatChanged(QAudioFormat const&)));
    connect(&m_decoder, SIGNAL(stateChanged(QAudioDecoder::State)), 
            this, SLOT(handleStateChanged(QAudioDecoder::State)));
    }

/* void WavReader::handleBufferReady(); ---------------------------------------
This reads what samples it can, and emits it in the samples signal.          */

void WavReader::handleBufferReady() {

    QAudioBuffer    b = m_decoder.read();
    emit samples(QByteArray(b.constData<char>(), b.byteCount()));
    }

/* void WavReader::handleError(QAudioDecoder::Error e); -----------------------
This translates a QAudioDecoder error into a WavReader error message signal. */

void WavReader::handleError(QAudioDecoder::Error e) {

    emit error(e == QAudioDecoder::ResourceError ? "can't open file" 
            : e == QAudioDecoder::FormatError ? "invalid file format"
            : e == QAudioDecoder::AccessDeniedError ? "file access denied"
            : "unknown error");
    }

/* void WavReader::handleFormatChanged(QAudioFormat const& f); ----------------
If an invalid format (sampleRate < 0) is selected, this does nothing. If a 
sample size other than 8 or 16, or a sample rate outside 8K to 96K, or a 
channel count greater than 2, or a format other than unsigned or signed int, is 
selected, this emits an error. Otherwise, it updates the format properties and 
reports any changes, and starts the reading.                                 */

void WavReader::handleFormatChanged(QAudioFormat const& f) {

    if (f.sampleRate() < 0)
        /* do nothing */;
    else if ((f.sampleSize() != 8 && f.sampleSize() != 16) 
            || 8000 > f.sampleRate() || f.sampleRate() > 96000 
            || f.channelCount() > 2 
            || (f.sampleType() != QAudioFormat::UnSignedInt 
                    && f.sampleType() != QAudioFormat::SignedInt))
        emit error("unsupported audio parameters");
    else {
        if (m_format.sampleSize() != f.sampleSize())
            emit depthChanged(f.sampleSize());
        if (m_format.sampleRate() != f.sampleRate())
            emit rateChanged(f.sampleRate());
        if (m_format.channelCount() != f.channelCount())
            emit stereoChanged(f.channelCount() > 1);
        if (m_format.sampleType() != f.sampleType())
            emit offsetChanged(f.sampleType() == QAudioFormat::UnSignedInt);
        m_format = f;
        }
    }

/* void WavReader::handleStateChanged(QAudioDecoder::State s); ----------------
This sets the enable property to the state, and emits the enableChanged 
signal.                                                                      */

void WavReader::handleStateChanged(QAudioDecoder::State s) {

    setEnable(s == QAudioDecoder::DecodingState);
    }

/* void WavReader::setEnable(bool enable); ------------------------------------
If the enable changes state, this sets the source filename in the decoder to 
the name property when enabling, or an empty string when disabling. The actual 
start of decoding occurs asynchronously when the file format has been 
determined and handleFormatChanged is called. This also emits the enableChanged 
signal.                                                                      */

void WavReader::setEnable(bool enable) {

    if (m_enable != enable) {
        m_enable = enable;
        if (enable) {
            m_decoder.setSourceFilename(m_name);
            m_decoder.start();
            }
        else {
            m_decoder.stop();
            m_decoder.setSourceFilename(QString());
            QAudioFormat f = QAudioFormat();
            f.setCodec("audio/pcm");
            m_decoder.setAudioFormat(f);
            }
        emit enableChanged(enable);
        }
    }

/* void WavReader::setName(QString name); -------------------------------------
If name doesn't match the current name, this sets the name and emits the 
nameChanged signal. In this case, if it was in the middle of reading the file, 
it turns off the enable.                                                     */

void WavReader::setName(QString name) {

    if (m_name != name) {
        setEnable(false);
        emit nameChanged(m_name = name);
        }
    }
