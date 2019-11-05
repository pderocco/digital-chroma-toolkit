import QtQuick 2.12
import Qt.labs.platform 1.1
import QtQuick.Layouts 1.12
import ChromaConverter 1.0
import "Util.js" as Util

Rectangle {
    id:                 root

    property int    bank: 1     // bank selection
    property string result      // result message
    property int    toFolder    // true if output goes to folder

    height:             13 * uSpc + 10 * uHgt
    color:              colSection

    GridLayout {
        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        // Row 0 --------------------------------------------------------------

        SectionTitle {
            text:               "OLD CHROMA CONVERT"
            colSpan:            11
            }

        ButtonHelp {
            col:                11
            page:               "/help/Old_Chroma_convert"
            }

        // Row 1 --------------------------------------------------------------

        LabelCluster {
            row:                1
            colSpan:            2
            text:               "input file"
            }

        ButtonAction {
            id:                 btnInput
            row:                1
            col:                2
            colSpan:            10
            text:               Util.appendStar(Util.urlToFile(config.syxDir))
            onClicked:          dlgInput.open()
            }

        // Row 2 --------------------------------------------------------------
        LayoutDummyH { row: 2; col: 6 }
        LayoutDummyH { row: 2; col: 8 }
        LayoutDummyH { row: 2; col: 10 }

        // Row 3 --------------------------------------------------------------

        LabelCluster {
            row:                3
            colSpan:            2
            text:               "tune shift"
            }

        BarSlider {
            Layout.row:         3
            Layout.column:      2
            Layout.columnSpan:  10

            value:              config.tuneShift
            defValue:           chr.paramDefs(chr.n_tune_shift)
            maxValue:           chr.paramMaxs(chr.n_tune_shift)
            minValue:           chr.paramMins(chr.n_tune_shift)
            strs:               chr.paramStrs(chr.n_tune_shift)

            onValueSet:         config.tuneShift = v
            }

        // Row 3 --------------------------------------------------------------

        LabelCluster {
            row:                4
            colSpan:            2
            text:               "invert"
            }

        ButtonValue {
            row:                4
            col:                2
            colSpan:            2
            value:              config.lever1Inv
            newval:             1
            text:               "lever 1"
            onClicked:          config.lever1Inv = !config.lever1Inv
            }

        ButtonValue {
            row:                4
            col:                4
            colSpan:            2
            value:              config.lever2Inv
            newval:             1
            text:               "lever 2"
            onClicked:          config.lever2Inv = !config.lever2Inv
            }

        LabelCluster {
            row:                4
            col:                6
            colSpan:            2
            text:               "selective"
            }

        ButtonValue {
            row:                4
            col:                8
            colSpan:            2
            value:              config.lever1Sel
            newval:             1
            text:               "lever 1"
            onClicked:          config.lever1Sel = !config.lever1Sel
            }

        ButtonValue {
            row:                4
            col:                10
            colSpan:            2
            value:              config.lever2Sel
            newval:             1
            text:               "lever 2"
            onClicked:          config.lever2Sel = !config.lever2Sel
            }

        // Row 5 --------------------------------------------------------------

        LabelCluster {
            row:                5
            colSpan:            2
            text:               "voice count"
            }

        ButtonValue {
            row:                5
            col:                2
            value:              config.voiceCount
            newval:             1
            text:               newval
            onClicked:          config.voiceCount = newval
            }

        ButtonValue {
            row:                5
            col:                3
            value:              config.voiceCount
            newval:             2
            text:               newval
            onClicked:          config.voiceCount = newval
            }

        ButtonValue {
            row:                5
            col:                4
            value:              config.voiceCount
            newval:             3
            text:               newval
            onClicked:          config.voiceCount = newval
            }

        ButtonValue {
            row:                5
            col:                5
            value:              config.voiceCount
            newval:             4
            text:               newval
            onClicked:          config.voiceCount = newval
            }

        // Row 6 --------------------------------------------------------------

        LabelCluster {
            row:                6
            colSpan:            2
            text:               "tune spread"
            }

        BarSlider {
            Layout.row:         6
            Layout.column:      2
            Layout.columnSpan:  10

            value:              config.tuneSpread
            defValue:           chr.paramDefs(chr.n_tune_spread)
            maxValue:           chr.paramMaxs(chr.n_tune_spread)
            minValue:           chr.paramMins(chr.n_tune_spread)
            strs:               chr.paramStrs(chr.n_tune_spread)

            onValueSet:         config.tuneSpread = v
            }

        // Row 7 --------------------------------------------------------------

        LabelCluster {
            row:                7
            colSpan:            2
            text:               "pan spread"
            }

        BarSlider {
            Layout.row:         7
            Layout.column:      2
            Layout.columnSpan:  10

            value:              config.panSpread
            defValue:           chr.paramDefs(chr.n_pan_spread)
            maxValue:           chr.paramMaxs(chr.n_pan_spread)
            minValue:           chr.paramMins(chr.n_pan_spread)
            strs:               chr.paramStrs(chr.n_pan_spread)

            onValueSet:         config.panSpread = v
            }

        // Row 8 --------------------------------------------------------------
        LayoutDummyH { row: 8 }

        // Row 9 --------------------------------------------------------------

        LabelCluster {
            row:                9
            colSpan:            2
            text:               "destination"
            }

        ButtonValue {
            row:                9
            col:                2
            colSpan:            2
            value:              toFolder
            newval:             0
            text:               "to bank"
            onClicked:          toFolder = false
            }

        ButtonValue {
            row:                9
            col:                4
            colSpan:            2
            value:              toFolder
            newval:             1
            text:               "to folder"
            onClicked:          toFolder = true
            }

        // Row 10 -------------------------------------------------------------

        LabelCluster {
            row:                10
            colSpan:            2
            text:               toFolder ? "output folder" : "output bank"
            }

        ButtonValue {
            row:                10
            col:                2
            value:              bank
            newval:             1
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                3
            value:              bank
            newval:             2
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                4
            value:              bank
            newval:             3
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                5
            value:              bank
            newval:             4
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                6
            value:              bank
            newval:             5
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                7
            value:              bank
            newval:             6
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                8
            value:              bank
            newval:             7
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                9
            value:              bank
            newval:             8
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonValue {
            row:                10
            col:                10
            value:              bank
            newval:             9
            visible:            !toFolder
            text:               newval
            onClicked:          bank = newval
            }

        ButtonAction {
            id:                 btnOutput
            row:                10
            col:                2
            colSpan:            10
            visible:            toFolder
            text:               Util.urlToFile(config.chrDir)
            onClicked:          dlgOutput.open()
            }

        // Row 11 -------------------------------------------------------------

        // msg - Optional message box, visible if result isn't null.
        Rectangle {
            id:                 msg
            Layout.row:         11
            Layout.column:      2
            Layout.columnSpan:  8
            Layout.fillHeight:  true
            Layout.fillWidth:   true
            color:              result == "success" ? "light green" : "pink"
            visible:            result

            Text {
                anchors.fill:       parent
                textFormat:         Text.PlainText
                font.pixelSize:     pixData
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment:  Text.AlignVCenter
                text:               result
                elide:              Text.ElideRight
                }
            }

        // Lower right "convert" button.
        ButtonAction {
            row:                11
            col:                10
            colSpan:            2
            text:               result ? "dismiss" : "convert"
            enabled:            !toolBusy && (toFolder ? config.chrDir : bank)
                                        && !Util.hasStar(btnInput.text)

            onClicked: {
                if (result)
                    result = ""
                else {
                    var s = qtutil.fileRead(btnInput.text)
                    if (typeof s === "string" && s)
                        result = s
                    else {
                        var t = qtutil.fileRead(
                                btnInput.text.replace(/(\.[^.\\\/]*)?$/, ".txt"))
                        if (typeof t === "string" && t)
                            result = t
                        else {
                            converter.convert(s, t)
                            if (!result) {
                                result = "success"
                                timer.start()
                                }
                            }
                        }
                    }
                }

            Timer {
                id:                 timer
                onTriggered:        result = ""
                }
            }
        }

    // Dialogs ----------------------------------------------------------------

    FileDialog {
        id:                 dlgInput
        defaultSuffix:      "syx"
        fileMode:           FileDialog.OpenFile
        folder:             config.syxDir || shortcuts.desktop
        nameFilters:        [ "Syntech sysex files (*.syx)", "All files (*)" ]
        title:              "Convert input file"

        onAccepted: {
            config.syxDir = folder
            btnInput.text = Util.urlToFile(file)
            close()
            }
        onRejected: {
            close()
            }
        }

    FolderDialog {
        id:                 dlgOutput
        acceptLabel:        "Save"
        folder:             config.chrDir || shortcuts.desktop
        title:              "Program output folder"

        onAccepted: {
            config.chrDir = folder
            close()
            }
        onRejected: {
            close()
            }
        }

    // Processing objects -----------------------------------------------------

    ChromaConverter {
        id:                 converter

        invert1:            config.lever1Inv
        invert2:            config.lever2Inv
        panSpread:          config.panSpread
        selective1:         config.lever1Sel
        selective2:         config.lever2Sel
        tuneShift:          config.tuneShift
        tuneSpread:         config.tuneSpread
        voiceCount:         config.voiceCount

        onError:            result = message
        onProgram: {
            console.log("program", number)
            if (toFolder) {
                var r = qtutil.fileWrite(
                        btnOutput.text + "/" + ((number / 10) | 0) 
                        + (number % 10) + ".chr", program)
                if (r)
                    result = r
                }
            else {
                var b = new Uint8Array(program.byteLength + 6)
                b[0] = 0xF0
                b[3] = 0x14
                b[4] = 0x44
                b.set(new Uint8Array(program), 5)
                b[program.length + 5] = 0xF7
                target.txProgWrite(bank - 1, number - 1, b)
                }
            }
        }
    }
