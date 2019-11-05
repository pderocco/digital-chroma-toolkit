import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {

    property int col:       0
    property int colSpan:   2
    property alias cursor:  mouse.cursorShape
    property alias text:    text.text
    property alias pressed: mouse.pressed

    Layout.fillHeight:      true
    Layout.fillWidth:       true
    Layout.column:          col
    Layout.columnSpan:      colSpan

    Text {
        id:                     text
        color:                  "white"
        textFormat:             Text.PlainText
        verticalAlignment:      Text.AlignVCenter
        font.pixelSize:         pixTitle
        font.italic:            true

        MouseArea {
            id:                     mouse
            anchors.fill:           parent
            }
        }
    }
