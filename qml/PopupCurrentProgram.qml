import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12
import "Util.js" as Util

Rectangle {
    id:                 root
    color:              "#C0000000" // black, 75% opacity
    anchors.fill:       parent
    parent:             win
    visible:            false       // not visible until explicitly enabled

    Connections {
        target:             app
        onCurrProgChanged:  updateText()
        }

    onVisibleChanged:       updateText()

    /* updateText -------------------------------------------------------------
    This is called when the popup visible changes, or when currProg is changed, 
    and fills the name, description, and timestamp fields if the popup is 
    visible.                                                                 */

    function updateText() {
        if (visible) {
            name.changeText(currProg && currProg.name ? currProg.name : "")
            descr.changeText(currProg && currProg.descr ? currProg.descr : "")
            textTime.text = currProg && currProg._time 
                    ? Util.formatTimestamp(currProg._time) : ""
            }
        }

    MouseArea {
        anchors.fill:       parent
        onClicked:          root.visible = false
        }

    Rectangle {
        anchors.centerIn:   parent
        width:              content.width * 0.4
        height:             9 * uHgt + 13 * uSpc
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

                    text:               "CURRENT PROGRAM " + currNum
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
                    page:               "/help/Current_program_popup"
                    }
                }

            LabelCluster {
                row:                1
                text:               "name"
                }

            TextEntrySingle {
                id:                 name
                Layout.row:         1
                Layout.column:      1
                Layout.columnSpan:  3
                Layout.fillWidth:   true
                Layout.fillHeight:  true

                onAccepted:         setMeta("name", text.trim() || null)
                }

            LayoutDummyV { row: 1 }

            LayoutDummyH { row: 2 }

            LabelCluster {
                row:                3
                text:               "description"
                }

            TextEntryMulti {
                id:                 descr
                Layout.row:         3
                Layout.rowSpan:     4
                Layout.column:      1
                Layout.columnSpan:  3
                Layout.fillWidth:   true
                Layout.fillHeight:  true

                onAccepted:         setMeta("descr", text || null)
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

                text:               "store"
                onClicked: {
                    target.txProgStore(currBank, currNumber)
                    root.visible = false
                    }
                }

            ButtonAction {
                row:                10
                col:                2

                text:               "exchange"
                onClicked: {
                    target.txProgExchange(currBank, currNumber)
                    // Don't dismiss
                    }
                }

            ButtonAction {
                row:                10
                col:                3

                text:               "scratch"
                onClicked: {
                    target.txProgSet(currBank, currNumber, null)
                    root.visible = false
                    }
                }

            ButtonAction {
                row:                11
                col:                1

                text:               "stash"
                onClicked: {
                    stash = Util.encodeProgramSysex(currProg, false)
                    stashBank = currBank
                    stashNumber = currNumber
                    root.visible = false
                    }
                }

            ButtonAction {
                row:                11
                col:                2

                text:               "recover"
                onClicked: {
                    if (stash)
                        target.txProgSet(stashBank, stashNumber, stash)
                    root.visible = false
                    }
                }
            }
        }
    }
