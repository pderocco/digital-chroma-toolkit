import QtQuick 2.12

Grid {

    property int bank

    property bool big:  parent == full

    anchors.fill:       parent
    rows:               10
    columns:            5
    flow:               Grid.LeftToRight
    padding:            uSpc
    spacing:            uSpc
    parent:             bank === bankSecAct ? lower
                      : bank !== bankPriAct ? null
                      : bankSecSel >= 0 ? upper
                      : full

    Repeater {
        model:              50
        ProgramsButtonProgram {
            num:                100 * bank + index + 1
            prog:               app["p" + num]
            }
        }
    }
