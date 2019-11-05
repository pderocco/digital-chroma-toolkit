import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    id:                     root    

    property int col
    property int colSpan
    property int row
    property string name:   "default"
    property alias busy:    popup.visible

    property point loc:     tls.height, popup.visible, 
                                    mapToItem(tls, height, height + 1)

    onVisibleChanged:       if (!visible) popup.visible = false

    Layout.column:          col
    Layout.columnSpan:      colSpan
    Layout.row:             row
    Layout.fillWidth:       true
    Layout.fillHeight:      true

    radius:                 radBtn

    Text {
        id:                     text
        anchors.fill:           parent
        text:                   name
        textFormat:             Text.PlainText
        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        wrapMode:               Text.Wrap
        font.pixelSize:         pixData
        }

    MouseArea {
        anchors.fill:           parent
        cursorShape:            Qt.PointingHandCursor

        onClicked: {
            if (popup.visible)
                popup.visible = false
            else {
                var l = audioInput.portList()
                l.unshift("default")
                popup.portList = l
                popup.visible = true
                }
            }
        }

    // popup -- list of available devices
    Item {
        id:                     popup
        parent:                 tls
        x:                      loc.x
        width:                  root.width - 2 * root.height
        y:                      loc.y
        height:                 list.height
        z:                      1
        visible:                false

        property var portList:  []

        Column {
            id:                     list
            x:                      0
            width:                  popup.width
            y:                      0

            Repeater {
                model:                  popup.portList
                Rectangle {
                    width:                  popup.width
                    height:                 root.height
                    color:                  index & 1 
                                                ? Qt.darker(root.color, 1.2) 
                                                : Qt.darker(root.color, 1.6)
                    Text {
                        anchors.fill:           parent
                        font.pixelSize:         pixData
                        horizontalAlignment:    Text.AlignHCenter
                        verticalAlignment:      Text.AlignVCenter
                        text:                   modelData

                        MouseArea {
                            anchors.fill:           parent
                            cursorShape:            Qt.PointingHandCursor

                            onClicked: {
                                name = parent.text
                                popup.visible = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
