import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {
    color:                  bank == bankPriSel ? colBankPri 
                          : bank == bankSecSel ? colBankSec 
                          : colBank

    property int bank
    property int col:       0
    property int colSpan:   1

    Layout.column:          col
    Layout.columnSpan:      colSpan
    Layout.fillWidth:       true
    Layout.fillHeight:      true
    radius:                 radBtn

    Text {
        text:                   bank ? bank.toString() : "current"
        anchors.fill:           parent
        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        textFormat:             Text.PlainText
        font.pixelSize:         parent.height * 0.75
        font.italic:            true
        }

    MouseArea {
        anchors.fill:           parent
        cursorShape:            Qt.PointingHandCursor
        onClicked:              selectBankPri(bank)
        onPressAndHold:         selectBankSec(bank)
        }
    }
