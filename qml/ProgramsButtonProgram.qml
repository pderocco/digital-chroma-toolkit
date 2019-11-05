import QtQuick 2.12
import "Util.js" as Util

Rectangle {
    id:                     root

    property int num      // program number
    property var prog     // stored program object

    height:                 (parent.height - 11 * uSpc) * 0.1
    width:                  (parent.width - 6 * uSpc) * 0.2
    color:                  currNum !== num ? (prog ? colNorm : colEmpty) 
                                : !currProg && !prog ? colScr
                                : currProg && prog && Util.compareTimestamp(
                                        currProg._time, prog._time) ? colUnmod
                                : colMod
    radius:                 radBtn

    property bool big:      parent.big

    Text {
        id:                     text
        anchors.fill:           parent
        anchors.leftMargin:     uSpc * 0.5
        anchors.rightMargin:    uSpc * 0.5
        elide:                  Text.ElideRight
        font.pixelSize:         fntProg
        text:                   prog && prog.name 
                                        ? num.toString() + " " + prog.name 
                                        : num.toString()
        textFormat:             Text.PlainText
        color:                  dropProg == num ? colHilite : "black"
        verticalAlignment:      big ? Text.AlignTop : Text.AlignVCenter
        wrapMode:               Text.Wrap
        }

    Rectangle {
        id:                     linkFlg
        visible:                big && currLinkMode && num === linkNum
        anchors.right:          seqFlg.visible ? seqFlg.left 
                                    : linkNumBg.visible ? linkNumBg.left 
                                    : seqNumBg.visible ? seqNumBg.left
                                    : parent.right
        anchors.rightMargin:    pixData * 0.5
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:   pixData * 0.4
        height:                 pixData * 1
        rotation:               45
        antialiasing:           true
        width:                  pixData * 1
        color:                  colLink
        Text {
            rotation:               -45
            font.pixelSize:         pixData * 0.8
            anchors.centerIn:       parent
            text:                   "L"
            color:                  "white"
            }
        }

    Rectangle {
        id:                     seqFlg
        visible:                big && num === seqNum
        anchors.right:          linkNumBg.visible ? linkNumBg.left 
                                    : seqNumBg.visible ? seqNumBg.left
                                    : parent.right
        anchors.rightMargin:    pixData * 0.5
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:   pixData * 0.4
        height:                 pixData
        rotation:               45
        antialiasing:           true
        width:                  pixData
        color:                  colSeq
        Text {
            rotation:               -45
            font.pixelSize:         pixData * 0.8
            anchors.centerIn:       parent
            text:                   "S"
            color:                  "white"
            }
        }

    Rectangle {
        id:                     linkNumBg
        visible:                big && prog && prog._link > 0
        anchors.right:          seqNumBg.visible ? seqNumBg.left : parent.right
        anchors.rightMargin:    pixData * 0.2
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:   pixData * 0.2
        height:                 pixData * 1.4
        radius:                 pixData
        width:                  linkNumTxt.width + pixData / 2
        color:                  colLink
        Text {
            id:                     linkNumTxt
            font.pixelSize:         pixData
            anchors.centerIn:       parent
            text:                   prog ? prog._link : ""
            color:                  "white"
            }
        }

    Rectangle {
        id:                     seqNumBg
        visible:                big && prog && prog._seq > 0
        anchors.right:          parent.right
        anchors.rightMargin:    pixData * 0.2
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:   pixData * 0.2
        height:                 pixData * 1.4
        radius:                 pixData * 0.75
        width:                  seqNumTxt.width + pixData / 2
        color:                  colSeq
        Text {
            id:                     seqNumTxt
            x:                      pixData * 0.25
            font.pixelSize:         pixData
            anchors.centerIn:       parent
            text:                   prog ? prog._seq : ""
            color:                  "white"
            }
        }

    DropArea {
        anchors.fill:           parent
        keys:                   ["pr"]
        onEntered:              dropProg = num
        onExited:               dropProg = 0
        }

    MouseArea {
        anchors.fill:           parent
        cursorShape:            Qt.PointingHandCursor
        drag.target:            dragMessage
        drag.threshold:         4
        drag.smoothed:          false

        property bool dragActive: drag.active

        onDragActiveChanged: {
            if (!dragActive && dragProg != dropProg 
                    && dragProg % 100 && dropProg % 100) {
                target.txProgSwap(
                        Math.trunc(dragProg / 100) - 1, dragProg % 100 - 1,
                        Math.trunc(dropProg / 100) - 1, dropProg % 100 - 1)
                dragProg = dropProg = 0
                }
            dragMessage.Drag.active = dragActive
            dragMessage.visible = dragActive
            }

        onPressed: {
            dragMessage.Drag.keys = ["pr"]
            dragProg = num
            var p = mapToItem(dragMessage.parent, mouse.x, mouse.y)
            dragMessage.x = p.x - dragMessage.Drag.hotSpot.x
            dragMessage.y = p.y - dragMessage.Drag.hotSpot.y
            }

        onClicked: {
            var n = (num - 101) % 100
            var b = (num - 101 - n) / 100
            target.txProgLoad(b, n)
            }

        onPressAndHold: {
            dragProg = 0
            pop.num = num
            pop.visible = true
            }
        }
    }
