import QtQuick 2.13
import QtQuick.Layouts 1.13

ButtonValue {
    id:                 root

    property int        n               // parameter index
    property alias      p: root.value   // binding to parameter
    property var        popup

    strs:               paramStrs(n)
    defval:             paramDefs(n)
    onValueSet:         setSendEditParam(
                                popup && popup.ganged ? n | 0x180 : n, v)
    }
