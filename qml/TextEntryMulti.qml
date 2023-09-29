import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id:                 root

    clip:               true
    color:              textArea.focus ? "#C0C0FF" : "#FFFF80"

    property alias text: textArea.text
    property string init

    function changeText(text) {
        textArea.focus = false
        textArea.text = text
        }

    signal accepted()

    TextArea {
        id:                 textArea

        anchors.left:       parent.left
        anchors.right:      parent.right
        font.pixelSize:     0.5 * uHgt
        selectByMouse:      true
        textFormat:         TextEdit.PlainText
        wrapMode:           TextEdit.Wrap

        onCursorRectangleChanged: {
            if (y < -cursorRectangle.y + topPadding)
                y = -cursorRectangle.y + topPadding
            else if (y > parent.height - cursorRectangle.y 
                    - cursorRectangle.height - bottomPadding)
                y = parent.height - cursorRectangle.y - cursorRectangle.height 
                        - bottomPadding
            }

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
            if (!text.slice(cursorPosition).match(/[!-~]/) 
                    && (!cursorPosition 
                    || text[cursorPosition - 1] === "\n")) {
                focus = false
                text = text.trim()
                root.accepted()
                }
            else
                event.accepted = false
            }

        Keys.onTabPressed:  {
            ;
            }
        }
    }
