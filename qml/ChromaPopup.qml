import QtQuick 2.13

Rectangle {
    id:             root

    // Caller must define these
    property var    params                      // list of parameter numbers
    property int    nRows                       // number of rows of controls
    property alias  page:       help.page       // help page URL
    property string title                       // title text
    property string titleGanged                 // title text when ganged
    property var    twin:       null            // gangable twin popup, if any
    property int    nParams:    params.length   // number of parameters 
                                                //  represented by controls
    property int    gangBit:    1 << (num >> 1) // bit position within gangs
                                                //  (set to 0 if ungangable)
    property bool   ganged:     gangs & gangBit // true if ganged

    // index of popup within popup list
    readonly property int num:  chr.popups.indexOf(root)

    height:         (1 + nRows) * uHgt + (1 + nRows + nParams) * uSpc
    width:          clusWidth
    color:          colPopup
    border.width:   1
    border.color:   "white"
    parent:         chr
    visible:        false

    // relative position on size change, on integer 0-999 scale
    property int xoff
    property int yoff
    onXChanged: {
        xoff = 999 * x / (chr.width - width)
        if (mouse.pressed && !dragged) {
            dragged = true
            chr.makeNonmodal(root)
            }
        }
    onYChanged: {
        yoff = 999 * y / (chr.height - height)
        if (mouse.pressed && !dragged) {
            dragged = true
            chr.makeNonmodal(root)
            }
        }
    onWidthChanged:     x = xoff * (chr.width - width) / 999
    onHeightChanged:    y = yoff * (chr.height - height) / 999

    // set true when dragging occurs
    property bool   dragged: false

    Drag.active: mouse.drag.active
    Drag.dragType: Drag.None

    MouseArea {
        anchors.fill:       parent
        }

    Text {
        id:                 text

        text:               ganged ? titleGanged : title
        x:                  uSpc
        width:              parent.width - uHgt - 2 * uSpc
        y:                  uSpc
        height:             uHgt

        color:              "white"
        textFormat:         Text.PlainText
        verticalAlignment:  Text.AlignVCenter
        font.pixelSize:     pixTitle
        font.italic:        true

        MouseArea {
            id:                 mouse
            anchors.fill:       parent
            drag.target:        root
            drag.minimumX:      0
            drag.maximumX:      chr.width - root.width
            drag.minimumY:      0
            drag.maximumY:      chr.height - root.height
            cursorShape:        Qt.PointingHandCursor

            onClicked:          chr.dismiss(root)
            onReleased:         dragged = false
            }
        }

    ButtonHelp {
        id:                 help
        x:                  parent.width - uSpc - uHgt
        width:              uHgt
        y:                  uSpc
        height:             uHgt
        }
    }


