import QtQuick 2.13
import QtQuick.Layouts 1.13

Item {

    // Caller must set this
    property alias text:    text.text

    // Caller may override these
    property int            col:        0   // passed to Layout
    property int            colSpan:    1   // passed to Layout
    property int            row:        0   // passed to Layout
    property int            rowSpan:    1   // passed to Layout
    property alias hAlign:  text.horizontalAlignment
    property alias vAlign:  text.verticalAlignment

    Layout.column:          col
    Layout.columnSpan:      colSpan
    Layout.row:             row
    Layout.rowSpan:         rowSpan
    Layout.fillHeight:      true
    Layout.fillWidth:       true

    Text {
        id:                     text
        anchors.fill:           parent
        color:                  "white"
        textFormat:             Text.PlainText
        verticalAlignment:      Text.AlignVCenter
        horizontalAlignment:    Text.AlignRight
        font.pixelSize:         pixData
        font.italic:            true
        }
    }
