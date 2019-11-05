import QtQuick 2.13

MouseArea {

    property alias pressedCursor:   switcher.pressedCursor
    property alias releasedCursor:  switcher.releasedCursor

    CursorSwitcher {
        id: switcher
        }

    onEntered: {
        switcher.entered = true
        }

    onExited: {
        switcher.entered = false
        }

    onPressed: {
        switcher.pressed = mouse.buttons & Qt.LeftButton
        }

    onReleased: {
        switcher.pressed = mouse.buttons & Qt.LeftButton
        }
    }
