import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
    color:                  "#E0E000"

    property int col:       0
    property int row:       0
    property string page

    Layout.column:          col
    Layout.row:             row
    Layout.fillHeight:      true
    Layout.fillWidth:       true

    Text {
        text:                   "?"
        anchors.fill:           parent
        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        textFormat:             Text.PlainText
        font.pixelSize:         parent.height * 0.75
        }
    }
