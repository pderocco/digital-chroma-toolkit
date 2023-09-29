import QtQuick 2.13
import QtQuick.Layouts 1.13

BarSlider {
    id:                     root

    // Caller must set these
    property int            n               // parameter index
    property int            p               // binding to parameter

    // Caller may override these
    property var            popup:      null
    strs:                   paramStrs(n)

    // parameter number to send
    property int            nsend:      popup && popup.ganged ? n | 0x180 : n

    defValue:               paramDefs(n)
    maxValue:               paramMaxs(n)
    minValue:               paramMins(n)
    sigValue:               paramSigs(n)

    onPChanged:             value = p
    onValueSet:             setSendEditParam(nsend, value)
    }
