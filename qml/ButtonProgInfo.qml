import QtQuick 2.13
import QtQuick.Layouts 1.13
import "Util.js" as Util

Rectangle {

    Layout.fillWidth:           true
    Layout.fillHeight:          true
    Layout.row:                 row

    property int row

    radius:                     radBtn
    antialiasing:               true

    function text_color() {
        var p = app["p" + currNum]
        if (!p && !currProg)
            return colScr
        else if (p && currProg 
                && Util.compareTimestamp(p._time, currProg._time))
            return colUnmod
        else
            return colMod
        }

    property color textColor:   app["p" + currNum], currProg, text_color()

    Text {
        text:                   currNum.toString()
        textFormat:             Text.PlainText
        width:                  parent.width
        height:                 name.lineCount < 2 ? parent.height * 0.6 
                                                   : parent.height * 0.4
        color:                  textColor
        font.pixelSize:         height * 0.9
        horizontalAlignment:    Text.AlignHCenter
        }

    Text {
        id:                     name
        text:                   /* currChg, */ !currProg ? "(scratch)" 
                                        : currProg.name || "(unnamed)"
        textFormat:             Text.PlainText
        x:                      uSpc
        width:                  parent.width - 2 * uSpc
        y:                      parent.height * 0.35
        height:                 parent.height * 0.6
        color:                  textColor
        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignBottom
        font.pixelSize:         height * 0.5
        lineHeight:             0.8
        wrapMode:               Text.Wrap
        elide:                  Text.ElideRight
        }

    MouseArea {
        anchors.fill:           parent
        cursorShape:            Qt.PointingHandCursor

        onClicked:              target.txProgLoad(currBank, currNumber)
        onPressAndHold:         popup.visible = true
        }

    PopupCurrentProgram {
        id:                     popup
        }
    }
