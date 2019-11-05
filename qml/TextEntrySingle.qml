import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id:                 root

    color:              textField.focus ? "#C0C0FF" : "#FFFF80"

    property alias text: textField.text
    property string init

    function changeText(text) {
        textField.focus = false
        textField.text = text
        }

    signal accepted()

    TextField {
        id:                 textField

        anchors.fill:       parent
        background:         Item {}
        font.pixelSize:     0.5 * uHgt
        selectByMouse:      true

        onFocusChanged: {
            if (focus)
                selectAll()
            }

        onVisibleChanged: {
            if (visible) {
                focus = false
                init = text
                }
            }

        Keys.priority:      Keys.BeforeItem

        Keys.onEscapePressed: {
            focus = false
            text = init
            }

        Keys.onReturnPressed: {
            focus = false
            text = text.trim()
            root.accepted()
            }

        Keys.onTabPressed:  {
            ;
            }
        }
    }
