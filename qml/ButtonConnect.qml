import QtQuick 2.13
import QtQuick.Layouts 1.13

ButtonAction {
    id:                     root    

    property point loc:     win.height, popup.visible, 
									mapToItem(win, radius, height + 1)

    lineHeight:             1
    text:                   target.interfaceState + "\n" 
                                    + target.portName.split("\n")[0]
    textColor:              target.interfaceState == "Connected to" 
                                    ? "white" : "black"
    pixelSize:              height * 0.3

    onClicked: {
        if (popup.visible)
            popup.visible = false
        else {
            var l = target.portList()
            l.push("Demonstrator")
            popup.portList = l
            popup.visible = true
            }
        }

    // popup -- list of available devices
    Item {
        id:                     popup
        parent:                 win
        x:                      loc.x
        width:                  root.width - 2 * root.radius
        y:                      loc.y
        height:                 col.height
        z:                      1
        visible:                false

        property var portList:  []

        Column {
            id:                     col
            x:                      0
            width:                  popup.width
            y:                      0

            Repeater {
                model:                  popup.portList
                Rectangle {
                    width:                  popup.width
                    height:                 root.height * 0.6
                    color:                  index & 1 ? root.color 
                                                : Qt.darker(root.color, 1.4)
                    Text {
                        anchors.fill:           parent
                        color:                  "white"
                        font.pixelSize:         root.height * 0.3
                        horizontalAlignment:    Text.AlignHCenter
                        verticalAlignment:      Text.AlignVCenter
                        wrapMode:               Text.Wrap
                        elide:                  Text.ElideRight
                        text:                   modelData.split("\n")[0]

                        MouseArea {
                            anchors.fill:           parent
                            cursorShape:            Qt.PointingHandCursor

                            onClicked: {
                                clearState()
								target.setPortName(modelData)
                                popup.visible = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
