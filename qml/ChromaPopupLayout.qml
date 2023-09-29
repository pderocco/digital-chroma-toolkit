import QtQuick 2.13
import QtQuick.Layouts 1.13

GridLayout {
    x:                  uSpc
    width:              parent.width - 2 * uSpc
    y:                  uHgt + 2 * uSpc
    height:             parent.height - uSpc - y
    columnSpacing:      uSpc
    rowSpacing:         uSpc
    }
