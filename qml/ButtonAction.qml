import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {

    property color          baseColor:  "white"
    property int            col:        0           // passed to Layout
    property int            colSpan:    1           // passed to Layout
    property bool           dimmed:     !enabled
    property bool           enabled:    true
    property bool           hilited:    false       // forces hilite color
    property alias          italic:     text.font.italic
    property alias          lineHeight: text.lineHeight
    property alias          text:       text.text
    property alias          textColor:  text.color
    property alias          textFormat: text.textFormat
    property alias          alignment:  text.horizontalAlignment
    property alias          pixelSize:  text.font.pixelSize
    property alias          pressed:    mouse.pressed
    property int            row:        0           // passed to Layout
    property int            rowSpan:    1           // passed to Layout

    color:                  hilited ? colHilite 
                                        : dimmed ? Qt.darker(baseColor, dim)
                                        : baseColor
    radius:                 radBtn

    Layout.column:          col
    Layout.columnSpan:      colSpan
    Layout.row:             row
    Layout.rowSpan:         rowSpan
    Layout.fillHeight:      true
    Layout.fillWidth:       true

    signal                  clicked(var mouse)
    signal                  pressAndHold(var mouse)

    Text {
        id:                     text
        anchors.fill:           parent
        textFormat:             Text.PlainText
        font.pixelSize:         pixData
        lineHeight:             0.75
        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        wrapMode:               Text.WordWrap
        elide:                  Text.ElideRight
        }

    MouseArea {
        id:                     mouse
        anchors.fill:           parent
        enabled:                parent.enabled
        cursorShape:            Qt.PointingHandCursor
        onClicked:              if (mouse.button === Qt.LeftButton)
                                    parent.clicked(mouse)
        onPressAndHold:         if (mouse.button === Qt.LeftButton)
                                    parent.pressAndHold(mouse)
        }
    }
