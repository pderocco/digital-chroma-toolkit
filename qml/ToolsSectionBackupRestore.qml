import QtQuick 2.12
import Qt.labs.platform 1.1
import QtQuick.Layouts 1.12
import "Util.js" as Util

Rectangle {

    // bank - selected bank, 0 for all
    property int    bank

    // brDir - selected directory
    property string brDir:  Util.urlToFile(config.brDir)

    // busy - true while busy
    property bool   busy:   app.backupMonitor || app.restoreMonitor

    // count - number of programs processed
    property int    count

    // message - error message, if any
    property string message

    // total - total number of programs to process
    property int    total:  bank ? 50 : 450

    height:             6 * uSpc + 4 * uHgt
    color:              colSection

    GridLayout {
        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        // Row 0 --------------------------------------------------------------

        SectionTitle {
            text:               "BACKUP & RESTORE"
            colSpan:            11
            }

        ButtonHelp {
            col:                11
            page:               "/help/Backup_restore"
            }

        // Row 1 --------------------------------------------------------------

        LayoutDummyH { row: 1; col: 0 }

        LabelCluster {
            row:                1
            col:                1
            text:               "bank"
            }

        ButtonValue {
            row:                1
            col:                2
            value:              bank
            newval:             1
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                3
            value:              bank
            newval:             2
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                4
            value:              bank
            newval:             3
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                5
            value:              bank
            newval:             4
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                6
            value:              bank
            newval:             5
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                7
            value:              bank
            newval:             6
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                8
            value:              bank
            newval:             7
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                9
            value:              bank
            newval:             8
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                10
            value:              bank
            newval:             9
            enabled:            !toolBusy
            text:               newval

            onValueSet:         bank = newval
            }

        ButtonValue {
            row:                1
            col:                11
            value:              bank
            newval:             0
            enabled:            !toolBusy
            text:               "all"

            onValueSet:         bank = newval
            }

        // Row 2 --------------------------------------------------------------

        LayoutDummyH { row: 2 }

        // Row 3 --------------------------------------------------------------

        LabelCluster {
            row:                3
            colSpan:            2
            text:               "folder"
            }

        ButtonAction {
            row:                3
            col:                2
            colSpan:            10
            enabled:            !toolBusy
            text:               brDir
            onClicked:          dlgFolder.open()
            }

        // Row 4 --------------------------------------------------------------

        // progress - Optional light green progress bar, visible while busy, 
        //  shows "x / y" values, where x is number of processed programs 
        //  and y is the total number of programs.
        Rectangle {
            Layout.row:         4
            Layout.column:      2
            Layout.columnSpan:  6
            Layout.fillHeight:  true
            Layout.fillWidth:   true
            color:              "white"
            visible:            busy

            Rectangle {
                x:                  1 + (uSpc >> 2)
                width:              (parent.width - 2 * x) * count / total
                y:                  x
                height:             parent.height - 2 * x
                color:              "light green"
                }

            Text {
                id:                 progressText
                anchors.fill:       parent
                textFormat:         Text.PlainText
                font.pixelSize:     pixData
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment:  Text.AlignVCenter
                text:               count + " / " + total
                }
            }

        // msg - Optional message box, in same location as progress bar, 
        //  visible while not busy and "message" isn't null.
        //  Clicking it clears it.
        Rectangle {
            id:                 msg
            Layout.row:         4
            Layout.column:      2
            Layout.columnSpan:  6
            Layout.fillHeight:  true
            Layout.fillWidth:   true
            color:              "white"
            visible:            message && !busy

            Text {
                anchors.fill:       parent
                font.pixelSize:     pixData
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment:  Text.AlignVCenter
                text:               message
                }

            MouseArea {
                anchors.fill:       parent
                onClicked:          message = ""
                }
            }

        // "backup" button.
        ButtonAction {
            row:                4
            col:                8
            colSpan:            2
            text:               app.backupMonitor ? "cancel" : "backup"
            enabled:            !toolBusy || app.backupMonitor

            onClicked: {
                if (!busy) {
                    count = 0
                    message = ""
                    app.backupMonitor = backupMonitor
                    target.txProgRead(bank && bank - 1, 0)
                    }
                else {
                    message = progressText.text
                    app.backupMonitor = null
                    }
                }
            }

        // "restore" button.
        ButtonAction {
            row:                4
            col:                10
            colSpan:            2
            text:               app.restoreMonitor ? "cancel" : "restore"
            enabled:            !toolBusy || app.restoreMonitor

            onClicked: {
                if (!busy) {
                    count = 0
                    message = ""
                    app.restoreMonitor = restoreMonitor
                    if (bank)
                        readAndSendFile(bank - 1, 0, brDir + "/01.chr")
                    else
                        readAndSendFile(0, 0, brDir + "/1/01.chr");
                    }
                else {
                    message = progressText.text
                    app.restoreMonitor = null
                    }
                }
            }
        }

    // Dialogs ----------------------------------------------------------------

    FolderDialog {
        id:                 dlgFolder
        acceptLabel:        "Select"
        folder:             config.brDir || shortcuts.desktop
        title:              "Program folder"

        onAccepted: {
            config.brDir = folder
            close()
            }
        onRejected: {
            close()
            }
        }

    // FUNCTIONS --------------------------------------------------------------

    // Called when Program Write is received from Chroma.
    function backupMonitor(b, n, sx) {
        ++n
        if (bank)
            writeFileAndRequest(b, n, brDir 
                    + "/" + (n / 10 | 0) + (n % 10) + ".chr", sx)
        else {
            var p = brDir + "/" + (b + 1) 
                    + "/" + (n / 10 | 0) + (n % 10) + ".chr"
            if (n < 50) {
                if (n === 1)
                    qtutil.dirCreate(p.slice(0, -7))
                writeFileAndRequest(b, n, p, sx)
                }
            else
                writeFileAndRequest(b + 1, 0, p, sx)
            }
        }

    // Reads file called p, sends Prog Write with bank b number n.
    //  On error, stops restore operation.
    function readAndSendFile(b, n, p) {
        var p1 = p
        p = qtutil.fileRead(p)
        if (typeof p !== "string")
            target.txProgWrite(b, n, p.byteLength ? new Uint8Array(p) : null)
        else if (!p.length)
            target.txProgWrite(b, n, null)
        else {
            message = p + " \"" + qtutil.fileOSPath(p) + "\""
            app.restoreMonitor = null
            }
        }

    // Called when Program Write Meta is received from Chroma.
    function restoreMonitor(b, n, sx) {
        ++count
        ++n
        if (bank)
            if (n < 50)
                readAndSendFile(b, n, brDir 
                        + "/" + ((n + 1) / 10 | 0) + ((n + 1) % 10) + ".chr")
            else
                app.restoreMonitor = null
        else
            if (n < 50)
                readAndSendFile(b, n, brDir + "/" + (b + 1) 
                        + "/" + ((n + 1) / 10 | 0) + ((n + 1) % 10) + ".chr")
            else if (b < 8)
                readAndSendFile(b + 1, 0, brDir + "/" + (b + 2) + "/01.chr")
            else
                app.restoreMonitor = null
        }

    // Writes sx to file called p, or deletes it if sx is empty, 
    //  requests bank b program n if valid, stops if invalid or error occurs.
    function writeFileAndRequest(b, n, p, sx) {
        p = Util.urlToFile(p)
        if (sx && sx.length) {
            var err = qtutil.fileWrite(p, sx.buffer)
            if (err)
                message = err + " \"" + p + "\""
            else
                ++count
            }
        else {
            if (!qtutil.fileRemove(p))
                message = "can't remove \"" + p + "\""
            else
                ++count
            }
        if (message || b >= 9 || p >= 50)
            app.backupMonitor = null
        else
            target.txProgRead(b, n)
        }
    }
