import QtQuick 2.12
import Qt.labs.platform 1.1
import QtQuick.Layouts 1.12
import AudioInput 1.0
import ChromaParser 1.0
import ManchesterDecoder 1.0
import UartReceiver 1.0
import WavReader 1.0
import "Util.js" as Util

Rectangle {
    id:                 root

    property string     badProgs
    property bool       busy:       audioInput.enable || wavReader.enable 
                                            || btnAudio.busy
    property string     error
    property bool       fromFile
    property var        progs: []
    property var        sysex
    property int        sysexn

    function appendProgs(f) {
        progs.push(f)
        progs = progs.slice() // to generate progsChanged signal
        }

    height:             7 * uSpc + 5 * uHgt
    color:              colSection

    GridLayout {
        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        // Row 0 --------------------------------------------------------------

        SectionTitle {
            text:               "OLD CHROMA IMPORT"
            colSpan:            11
            }

        ButtonHelp {
            col:                11
            page:               "/help/Old_Chroma_import"
            }

        // Row 1 --------------------------------------------------------------

        LabelCluster {
            row:                1
            colSpan:            2
            text:               "source"
            }

        ButtonValue {
            row:                1
            col:                2
            colSpan:            2
            enabled:            !busy
            text:               "from device"
            value:              fromFile
            newval:             0
            onClicked:          fromFile = false
            }

        ButtonValue {
            row:                1
            col:                4
            colSpan:            2
            enabled:            !busy
            text:               "from file"
            value:              fromFile
            newval:             1
            onClicked:          fromFile = true
            }

        // Row 2  -------------------------------------------------------------

        LabelCluster {
            row:                2
            colSpan:            2
            text:               fromFile ? "input file" : "input device"
            }

        ButtonAudio {
            id:                 btnAudio
            row:                2
            col:                2
            colSpan:            10
            enabled:            !busy
            visible:            !fromFile
            }

        ButtonAction {
            id:                 btnInput
            row:                2
            col:                2
            colSpan:            10
            enabled:            !busy
            text:               Util.appendStar(Util.urlToFile(config.wavDir))
            visible:            fromFile
            onClicked:          dlgInput.open()
            }

        // Row 3 --------------------------------------------------------------

        LayoutDummyH { row: 3; col: 0 }
        LayoutDummyH { row: 3; col: 2 }
        LayoutDummyH { row: 3; col: 4 }
        LayoutDummyH { row: 3; col: 6 }
        LayoutDummyH { row: 3; col: 8 }
        LayoutDummyH { row: 3; col: 10 }

        // Row 4 --------------------------------------------------------------

        LabelCluster {
            row:                4
            colSpan:            2
            text:               "output file"
            }

        ButtonAction {
            id:                 btnOutput
            row:                4
            col:                2
            colSpan:            10
            enabled:            !busy
            text:               Util.appendStar(Util.urlToFile(config.syxDir))
            onClicked:          dlgOutput.open()
            }

        // Row 5 --------------------------------------------------------------

        // Optional progress bar, visible when chromaParser is enabled. 
        //  It shows vertical stripes for each of 50 programs, white 
        //  if not received yet, green if converted, red if failed to convert.
        //  Superimposed is the successful and total counts, or error message. 
        //  It fades out after a few seconds when chromaParser is disabled, 
        //  but can be shown again by clicking on it. If long-pressed, the 
        //  list of failed programs is copied to the clipboard.
        Rectangle {
            id:                 progress
            Layout.row:         5
            Layout.column:      2
            Layout.columnSpan:  8
            Layout.fillHeight:  true
            Layout.fillWidth:   true
            color:              "white"
            visible:            busy || error

            Row {
                id:                 bar
                anchors.fill:       parent
                anchors.margins:    1 + (uSpc >> 2)
                Repeater {
                    model:              50
                    Rectangle {
                        color:              index >= progs.length ? "white" 
                                            : progs[index] ? "light green" 
                                            : "pink"
                        height:             bar.height
                        width:              bar.width * 0.02
                        }
                    }
                }

            Text {
                anchors.fill:       parent
                textFormat:         Text.PlainText
                font.pixelSize:     pixData
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment:  Text.AlignVCenter
                elide:              Text.ElideRight
                text:               error || (chromaParser.numprogs + " / " 
                                            + chromaParser.prognum)
                }
            }

        // Lower right button shows and changes state. While idle, with no 
        //  errors being displayed, it says "import", and starts the input 
        //  operation when clicked. While running, it says "cancel", and aborts 
        //  the operation when clicked. While idle, when there is an error 
        //  showing in the progress bar, it says "dimiss", and clears out the 
        //  message when clicked.
        ButtonAction {
            row:                5
            col:                10
            colSpan:            2
            text:               busy ? "cancel" : error ? "dismiss" : "import"
            enabled:            (busy || !toolBusy)
                                        && !Util.hasStar(btnOutput.text)
                                        && (!fromFile 
                                            || !Util.hasStar(btnInput.text))
            onClicked: {
                if (busy) {
                    audioInput.enable = wavReader.enable = false
                    error = ""
                    }
                else if (error) {
                    qtutil.clipSetText(error)
                    badProgs = error = ""
                    }
                else if (fromFile)
                    wavReader.enable = true
                else
                    audioInput.enable = true
                }
            }
        }

    // Dialogs ----------------------------------------------------------------

    FileDialog {
        id:                 dlgInput
        defaultSuffix:      "wav"
        fileMode:           FileDialog.OpenFile
        folder:             config.wavDir || shortcuts.desktop
        nameFilters:        [ "Wave files (*.wav)", "All files (*)" ]
        title:              "Import input file"

        onAccepted: {
            config.wavDir = folder
            btnInput.text = Util.urlToFile(file)
            close()
            }
        onRejected: {
            close()
            }
        }

    FileDialog {
        id:                 dlgOutput
        defaultSuffix:      "syx"
        fileMode:           FileDialog.SaveFile
        folder:             config.syxDir || shortcuts.desktop
        nameFilters:        [ "Syntech sysex files (*.syx)", "All files (*)" ]
        title:              "Import output file"

        onAccepted: {
            config.syxDir = folder
            btnOutput.text = Util.urlToFile(file)
            close()
            }
        onRejected: {
            close()
            }
        }

    // Processing objects -----------------------------------------------------

    AudioInput {
        id:                 audioInput
        port:               btnAudio.name === "default" ? "" : btnAudio.name

        onSamples:          manchesterDecoder.samples(samples)
        onError:            error = "Audio input: " + message
        }

    WavReader {
        id:                 wavReader
        name:               btnInput.text

        onError:            root.error = "File input: " + message
        onSamples:          manchesterDecoder.samples(samples)
        }

    ManchesterDecoder {
        id:                 manchesterDecoder

        depth:              fromFile ? audioInput.depth : wavReader.depth
        enable:             audioInput.enable || wavReader.enable
        offset:             fromFile ? wavReader.offset : audioInput.offset
        rate:               fromFile ? wavReader.rate : audioInput.rate
        stereo:             fromFile ? wavReader.stereo : audioInput.stereo

        onBit:              uartReceiver.bit(bit)
        }

    UartReceiver {
        id:                 uartReceiver
        enable:             manchesterDecoder.enable

        onCharacter:        chromaParser.character(character)
        }

    ChromaParser {
        id:                 chromaParser
        enable:             uartReceiver.enable

        onBadProg: {
            appendProgs(false)
            if (badProgs)
                badProgs += " "
            badProgs += prog
            }
        onData: {
            if (data.byteLength == 119)
                appendProgs(true)
            sysex.set(new Uint8Array(data), sysexn)
            sysexn += data.byteLength
            if (data.byteLength === 1) {
                error = qtutil.fileWrite(btnOutput.text, sysexn < 5958 
                        ? sysex.buffer.slice(0, sysexn) : sysex.buffer)
                if (error) {
                    error += " "
                    error += btnOutput.text
                    audioInput.enable = wavReader.enable = false
                    }
                }
            }
        onEnableChanged: {
            if (enable) {
                badProgs = ""
                error = ""
                progs = []
                sysex = new Uint8Array(5958)
                sysexn = 0
                }
            else
                sysex = null
            }
        onPrognumChanged: {
            if (prognum == 50) {
                audioInput.enable = wavReader.enable = false;
                if (badProgs)
                    error = "failed: " + badProgs
                }
            }
        }
    }
