// AudioInput.cpp

#include "AudioInput.h"
#include <QAudioDeviceInfo>
#include <QSysInfo>

/* AudioInput::AudioInput(QObject* p = nullptr); ------------------------------
This initializes the format to 24KHz mono 8-bit.                             */

AudioInput::AudioInput(QObject* p):
        QObject(p), m_device(nullptr), m_enable(false), m_input(nullptr) {

    m_format.setChannelCount(1);
    m_format.setCodec("audio/pcm");
    m_format.setSampleRate(24000);
    m_format.setSampleSize(8);
    m_format.setSampleType(QAudioFormat::UnSignedInt);
    }

/* void AudioInput::handleNotify(); -------------------------------------------
This is called at the period rate during input. It reads the available samples 
into a QByteArray, and emits it as a samples signal.                         */

void AudioInput::handleNotify() {

    if (m_enable)
        emit samples(m_device->readAll());
    }

/* void AudioInput::handleStateChanged(QAudio::State state); ------------------
If the QAudioInput state changes to anything other than active or idle while it 
is enabled, this turns off the enable, stopping the input, and emits an error 
message.                                                                     */

void AudioInput::handleStateChanged(QAudio::State state) {

    if (m_enable && state != QAudio::ActiveState 
            && state != QAudio::IdleState) {
        emit error("error reading");
        setEnable(false);
        }
    }

/* QStringList AudioInput::portList(); ----------------------------------------
This returns a list of the names of the audio input ports.                   */

QStringList AudioInput::portList() {
    QStringList     p;

    for (auto d: QAudioDeviceInfo::availableDevices(QAudio::AudioInput))
        p.push_back(d.deviceName());
    return p;
    }

/* void AudioInput::setDepth(int depth); --------------------------------------
This sets the depth, and emits depthChanged if it changes. It rejects depths 
other than 8 or 16.                                                          */

void AudioInput::setDepth(int depth) {

    if (depth != m_format.sampleSize()) {
        m_format.setSampleSize(depth);
        emit depthChanged(depth);
        }
    }

/* void AudioInput::setEnable(bool enable); -----------------------------------
This sets the enable. If it goes from disabled to enabled, this attempts to 
open the device specified by the port property, or the default device if port 
is empty. The format is adjusted if necessary, emitting signals for any 
changes, a QAudioInput is created to receive the input, the format is set, the 
enableChanged signal is emitted, and the input is started. The buffer is set to 
4KB, and samples signals will be emitted every 1KB. If the enable goes from 
disabled to enabled, the QAudioInput is stopped and deleted, and the 
enableChanged signal is emitted.                                             */

void AudioInput::setEnable(bool enable) {
    QAudioDeviceInfo    i;
    QAudioFormat        f;

    // Ignore if no change.
    if (m_enable != enable) {

        // If starting up...
        if (enable) {

            // On Windows, enforce signedness.
            f = m_format;
            if (QSysInfo::productType() == "windows") {
                if (f.sampleSize() == 8) {
                    if (f.sampleType() == QAudioFormat::SignedInt)
                        f.setSampleType(QAudioFormat::UnSignedInt);
                    }
                else {
                    if (f.sampleType() == QAudioFormat::UnSignedInt)
                        f.setSampleType(QAudioFormat::SignedInt);
                    }
                }

            // Get input device, emit error if unavailable.
            if (!m_port.size())
                i = QAudioDeviceInfo::defaultInputDevice();
            else
                for (auto d: QAudioDeviceInfo::availableDevices(
                        QAudio::AudioInput))
                    if (d.deviceName() == m_port) {
                        i = d;
                        break;
                        }
            if (i.isNull()) {
                emit error("no such device");
                return;
                }

            // If format isn't exactly supported, get nearest.
            if (!i.isFormatSupported(f))
                f = i.nearestFormat(f);

            // Make and report any changes.
            setDepth(f.sampleSize());
            setRate(f.sampleRate());
            setStereo(f.channelCount() > 1);
            setOffset(f.sampleType() == QAudioFormat::UnSignedInt);

            // If format is invalid, emit error.
            if ((f.sampleSize() != 8 && f.sampleSize() != 16) 
                    || 8000 > f.sampleRate() || f.sampleRate() > 96000 
                    || f.channelCount() > 2 
                    || (f.sampleType() != QAudioFormat::SignedInt 
                        && f.sampleType() != QAudioFormat::UnSignedInt)) {
                emit error("unsupported format");
                return;
                }

            // Create QAudioInput, monitor its state changes.
            m_input = new QAudioInput(i, m_format, this);
            connect(m_input, SIGNAL(notify()), this, SLOT(handleNotify()));
            connect(m_input, SIGNAL(stateChanged(QAudio::State)), 
                    this, SLOT(handleStateChanged(QAudio::State)));

            // Allocate 1024 * 5 frames for buffer.
            m_input->setBufferSize((1024 * 5 / 8) 
                    * f.channelCount() * f.sampleSize());

            // Set notify interval to 1/5 of buffer size.
            unsigned m = m_format.durationForBytes(m_input->bufferSize() / 5);
            m_input->setNotifyInterval((m + 999) / 1000);

            // Try to start device, set enable if successful.
            m_device = m_input->start();
            if (m_input->state() == QAudio::ActiveState 
                    || m_input->state() == QAudio::IdleState)
                emit enableChanged(m_enable = true);

            // Otherwise, emit error.
            else
                emit error("can't open device");
            }

        // If stopping...
        else {

            // Record as disabled, so stateChange doesn't emit enableChanged.
            m_enable = false;

            // Stop, close input.
            m_input->stop();
            delete m_input;
            m_input = nullptr;
            m_device = nullptr;

            // Now emit signal.
            emit enableChanged(false);
            }
        }
    }

/* void AudioInput::setOffset(bool offset); -----------------------------------
This sets the offset mode to true or false, and emits offsetChanged if it 
changes.                                                                     */

void AudioInput::setOffset(bool offset) {
    QAudioFormat::SampleType t = offset 
            ? QAudioFormat::UnSignedInt : QAudioFormat::SignedInt;

    if (m_format.sampleType() != t) {
        m_format.setSampleType(t);
        emit offsetChanged(offset);
        }
    }

/* void AudioInput::setPort(QString port); ------------------------------------
This sets the port name, and emits portChanged if it changed.                */

void AudioInput::setPort(QString port) {

    if (m_port != port)
        emit portChanged(m_port = port);
    }

/* void AudioInput::setRate(int rate); ----------------------------------------
This sets the rate, and emits rateChanged if it changes.                     */

void AudioInput::setRate(int rate) {

    if (m_format.sampleRate() != rate) {
        m_format.setSampleRate(rate);
        emit rateChanged(rate);
        }
    }

/* void AudioInput::setStereo(bool stereo); -----------------------------------
This sets the stereo mode to true or false, and emits stereoChanged if it 
changes.                                                                     */

void AudioInput::setStereo(bool stereo) {
    int     n = stereo ? 2 : 1;

    if (m_format.channelCount() != n) {
        m_format.setChannelCount(n);
        emit stereoChanged(stereo);
        }
    }
