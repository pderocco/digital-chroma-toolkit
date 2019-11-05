import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id:                 root
    color:              "#C0000000" // black, 75% opacity
    anchors.fill:       parent
    parent:             win
    visible:            false       // not visible until explicitly enabled

    property alias text: text.text

    MouseArea {
        anchors.fill:       parent
        onClicked:          root.visible = false
        }

    Rectangle {
        anchors.centerIn:   parent
        width:              content.width * 0.4
        height:             text.height + 2 * uSpc
        color:              colPopup
        border.width:       1
        border.color:       "white"

        Text {
            id:                 text
            color:              "white"
            x:                  uSpc
            y:                  uSpc
            width:              parent.width - 2 * uSpc
            textFormat:         Text.RichText
            }
        }
    }
