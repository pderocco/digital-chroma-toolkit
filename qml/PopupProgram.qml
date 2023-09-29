import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import "Util.js" as Util

Rectangle {
    id:                 root
    color:              "#C0000000" // black, 75% opacity
    anchors.fill:       parent
    parent:             prg
    visible:            false       // not visible until explicitly enabled
    onVisibleChanged: {
        if (visible) {
            nameEntry.changeText(name)
            descrEntry.changeText(descr)
            }
        }

    property int num:   0           // which program is being popped up

    property string name:
                        app["p" + num] && app["p" + num].name || ""
    onNameChanged:      nameEntry.changeText(name)

    property string descr:
                        app["p" + num] && app["p" + num].descr || ""
    onDescrChanged:     descrEntry.changeText(descr)

    property string time:
                        app["p" + num] && app["p" + num]._time
                            ? Util.formatTimestamp(app["p" + num]._time) : ""
    onTimeChanged:      textTime.text = time

    /* send_prog_params -------------------------------------------------------
    This sets parameters p and p+1, which are expected to be either the link or 
    sequence bank and program, with the popup programs's bank and program 
    number. Then, if v is defined, it sets the link mode to v. It then closes 
    the popup.                                                               */

    function send_prog_params(p, v) {
        if (num >= 0) {

            // Break num into 1-based bank and number.
            var n = num % 100
            var b = (num - n) / 100

            // If bank is "current", use bank number 0 instead.
            if (b == currBank + 1 && (!bankPriSel || !bankSecSel))
                b = 0

            // Set bank and program parameters.
            setSendParam(p, b)
            setSendParam(p + 1, n)

            // If value specified, set link mode.
            if (v !== undefined)
                setSendParam(n_link_mode, v)

            // Dismiss popup.
            root.visible = false;
            }
        }

    MouseArea {
        anchors.fill:       parent
        onClicked:          root.visible = false
        }

    Rectangle {
        anchors.centerIn:   parent
        width:              parent.width * 0.4
        height:             12 * uHgt + 16 * uSpc
        color:              colPopup
        border.width:       1
        border.color:       "white"

        MouseArea {
            anchors.fill:       parent
            }

        GridLayout {

            anchors.fill:       parent
            anchors.margins:    uSpc
            columnSpacing:      uSpc
            rowSpacing:         uSpc

            // Title
            Item {
                Layout.column:      0
                Layout.columnSpan:  4
                Layout.fillWidth:   true
                Layout.fillHeight:  true

                Text {
                    x:                  0
                    width:              parent.width
                    y:                  0
                    height:             parent.height

                    text:               "PROGRAM " + num
                    color:              "white"
                    textFormat:         Text.PlainText
                    verticalAlignment:  Text.AlignVCenter
                    font.pixelSize:     pixTitle
                    font.italic:        true

                    MouseArea {
                        anchors.fill:       parent
                        cursorShape:        Qt.PointingHandCursor
                        onClicked:          root.visible = false
                        }
                    }

                ButtonHelp {
                    x:                  parent.width - uHgt
                    width:              uHgt
                    y:                  0
                    height:             uHgt
                    page:               "/help/Program_popup"
                    }
                }

            LabelCluster {
                row:                1
                text:               "name"
                }

            TextEntrySingle {
                id:                 nameEntry
                Layout.row:         1
                Layout.column:      1
                Layout.columnSpan:  3
                Layout.fillWidth:   true
                Layout.fillHeight:  true

                onAccepted: {
                    text = text.trim()
                    var p = app["p" + num]
                    if (num == currNum && p && currProg 
                            && Util.compareTimestamp(p._time, 
                            currProg._time)) {
                        setMeta("name", text.trim() || null)
                        target.txProgStore(Math.trunc((num - 101) / 100), 
                                (num - 101) % 100)
                        }
                    else
                        writeMeta(num, "name", text.trim() || null)
                    }
                }

            LayoutDummyV { row: 1 }

            LayoutDummyH { row: 2 }

            LabelCluster {
                row:                3
                text:               "description"
                }

            TextEntryMulti {
                id:                 descrEntry
                Layout.row:         3
                Layout.rowSpan:     4
                Layout.column:      1
                Layout.columnSpan:  3
                Layout.fillWidth:   true
                Layout.fillHeight:  true

                onAccepted: {
                    text = text.trim()
                    var p = app["p" + num]
                    if (num == currNum && p && currProg 
                            && Util.compareTimestamp(p._time, 
                            currProg._time)) {
                        setMeta("descr", text || null)
                        target.txProgStore(
                                Math.trunc((num - 101) / 100), 
                                (num - 101) % 100)
                        }
                    else
                        writeMeta(num, "descr", text || null)
                    }
                }

            LayoutDummyV { row: 4 }
            LayoutDummyV { row: 6 }

            LayoutDummyH { row: 7 }

            LabelCluster {
                row:                8
                text:               "timestamp"
                }

            Rectangle {
                Layout.row:         8
                Layout.column:      1
                Layout.columnSpan:  3
                Layout.fillWidth:   true
                Layout.fillHeight:  true

                color:              "white"

                Text {
                    id:                 textTime
                    anchors.fill:       parent

                    color:              "black"
                    textFormat:         Text.PlainText
                    verticalAlignment:  Text.AlignVCenter
                    horizontalAlignment:Text.AlignHCenter
                    font.pixelSize:     pixData
                    }
                }

            LayoutDummyH { row: 9 }

            LabelCluster {
                text:               "actions"
                row:                10
                }

            ButtonAction {
                row:                10
                col:                1

                text:               "select"
                onClicked: {
                    target.txProgLoad(Math.trunc((num - 101) / 100), 
                            (num - 101) % 100)
                    root.visible = false;
                    }
                }

            ButtonAction {
                row:                11
                col:                1

                text:               "store"
                onClicked: {
                    target.txProgStore(Math.trunc((num - 101) / 100), 
                            (num - 101) % 100)
                    root.visible = false;
                    }
                }

            ButtonAction {
                row:                12
                col:                1

                text:               "exchange"
                onClicked: {
                    target.txProgExchange(Math.trunc((num - 101) / 100), 
                            (num - 101) % 100)
                    root.visible = false;
                    }
                }

            ButtonAction {
                row:                13
                col:                1

                text:               "store stash"
                onClicked: {
                    stashBank = Math.trunc((num - 101) / 100)
                    stashNumber = (num - 101) % 100
                    target.txProgWrite(stashBank, stashNumber, stash)
                    root.visible = false;
                    }
                }

            ButtonAction {
                row:                14
                col:                1

                text:               "delete"
                onClicked: {
                    target.txProgWrite(Math.trunc((num - 101) / 100), 
                            (num - 101) % 100, null)
                    root.visible = false;
                    }
                }

            ButtonAction {
                row:                10
                col:                2

                text:               "link upper"
                onClicked:           send_prog_params(n_link_bank, 2)
                }

            ButtonAction {
                row:                11
                col:                2

                text:               "link upper unison"
                onClicked:           send_prog_params(n_link_bank, 5)
                }

            ButtonAction {
                row:                12
                col:                2

                text:               "link unison"
                onClicked:           send_prog_params(n_link_bank, 3)
                }

            ButtonAction {
                row:                13
                col:                2

                text:               "link lower unison"
                onClicked:           send_prog_params(n_link_bank, 4)
                }

            ButtonAction {
                row:                14
                col:                2

                text:               "link lower"
                onClicked:           send_prog_params(n_link_bank, 1)
                }


            ButtonAction {
                row:                10
                col:                3

                text:               "link external"
                onClicked:           send_prog_params(n_link_bank, 6)
                }

            ButtonAction {
                row:                11
                col:                3

                text:               "link internal"
                onClicked:           send_prog_params(n_link_bank, 7)
                }

            ButtonAction {
                row:                14
                col:                3

                text:               "sequence program"
                onClicked:           send_prog_params(n_sequence_bank)
                }
            }
        }
    }
