import QtQuick 2.13
import QtQuick.Layouts 1.13

ButtonAction {

    signal valueSet(int v)

    property int            newval              // new value to set
    property int            value               // bound to whatever is to be set
    property var            strs                // string table
    property int            defval:     999     // default value (999 = none)
    property bool           selected:   value === newval

    dimmed:                 !selected
    text:                   strs[newval]

    onClicked:              valueSet(newval)
    onPressAndHold: {
        if (defval !== 999)
            valueSet(defval)
        else
            mouse.accepted = false
        }
    }
