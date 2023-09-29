import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id:                 root
    color:              "#C0000000" // black, 75% opacity
    anchors.fill:       parent
    parent:             win
    visible:            false       // not visible until explicitly enabled

    // Each checkedState is either 0 (off) or 2 (on)
    property int val: (ck0.checked ? 0x001 : 0)
                    | (ck1.checked ? 0x002 : 0)
                    | (ck2.checked ? 0x004 : 0)
                    | (ck3.checked ? 0x008 : 0)
                    | (ck4.checked ? 0x010 : 0)
                    | (ck5.checked ? 0x020 : 0)
                    | (ck6.checked ? 0x040 : 0)
                    | (ck7.checked ? 0x080 : 0)

    onVisibleChanged: {
        if (visible) {
            ck0.checked = debug & 0x001
            ck1.checked = debug & 0x002
            ck2.checked = debug & 0x004
            ck3.checked = debug & 0x008
            ck4.checked = debug & 0x010
            ck5.checked = debug & 0x020
            ck6.checked = debug & 0x040
            ck7.checked = debug & 0x080
            }
        }

    MouseArea {
        anchors.fill:       parent
        onClicked: {
            debug = val
            root.visible = false
            }
        }

    Rectangle {
        anchors.centerIn:   parent
        color:              "black"
        border.width:       1
        border.color:       "white"
        height:             col.height
        width:              col.width

        MouseArea {
            anchors.fill:       parent
            }

        Column {
            id:                 col

            CheckBox { id: ck0; text: "<font color=\"white\">main onRx" }
            CheckBox { id: ck1; text: "<font color=\"white\">TargetEmulator input" }
            CheckBox { id: ck2; text: "<font color=\"white\">schedule" }
            CheckBox { id: ck3; text: "<font color=\"white\">param thinning" }
            CheckBox { id: ck4; text: "<font color=\"white\">gangs" }
            CheckBox { id: ck5; text: "<font color=\"white\">TargetInterface tx" }
            CheckBox { id: ck6; text: "<font color=\"white\">display sysex contents" }
            CheckBox { id: ck7; text: "<font color=\"white\">state, portName, id" }
            }
        }
    }
