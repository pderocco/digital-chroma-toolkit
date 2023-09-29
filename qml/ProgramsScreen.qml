import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {
    id:                         root

    // COLORS -----------------------------------------------------------------

    readonly property color colNorm:    "#FFFFFF"
    readonly property color colEmpty:   "#C0C0C0"
    readonly property color colBank:    "#C0C0C0"
    readonly property color colBankPri: "#FFFFFF"
    readonly property color colBankSec: "#80FFFF"

    // Font size
    readonly property int   fntProg:    height / 40

    // BANK DISPLAY -----------------------------------------------------------

    // selected bank numbers
    property int    bankPriSel:         0   // current
    property int    bankSecSel:         -1  // none

    // actual bank numbers
    property int    bankPriAct:         bankPriSel || currBank + 1
    property int    bankSecAct:         bankSecSel || currBank + 1

    // current and previous bank
    property int    oldBank:            0
    property int    newBank:            0

    Connections {
        target:                         app
        onCurrBankChanged:              selectCurrBank(currBank + 1)
        }

    /* selectBankPri(b), selectBankSec(b), selectCurrBank(b) ------------------
    These are called when b becomes the primary displayed bank, the secondary 
    displayed bank, or the current bank. They use 1-based numbers, with 0 
    meaning "display the current bank", and -1 meaning "don't display".      */

    function selectBankPri(b) { // 0...9

        // If b is already primary, close secondary.
        if (b == bankPriSel)
            bankSecSel = -1

        // Otherwise, if b matches secondary, move primary to secondary.
        else if ((b || newBank) == bankSecAct)
            bankSecSel = bankPriSel

        // Select b as primary.
        bankPriSel = b
        }

     function selectBankSec(b) { // -1...9

        // If b matches primary...
        if ((b || newBank) == bankPriAct) {

            // If there is no secondary, do nothing.
            if (bankSecSel == -1)
                return

            // Move lower to upper.
            bankPriSel = bankSecSel
            }

        // Select b as lower bank.
        bankSecSel = b
        }

    function selectCurrBank(b) { // 1...9

        oldBank = newBank
        newBank = b
        if (bankPriAct == bankSecAct) {
            if (bankPriSel == 0) {
                bankPriSel = oldBank
                bankSecSel = 0
                }
            else {
                bankSecSel = oldBank
                bankPriSel = 0
                }
            }
        else {
            if (bankPriSel == newBank) {
                bankSecSel = bankSecAct
                bankPriSel = 0
                }
            else if (bankSecSel == newBank) {
                bankPriSel = bankPriAct
                bankSecSel = 0
                }
            }
        }

    // DRAGGING ---------------------------------------------------------------

    property int dragProg:      0
    property int dropProg:      0

    // COMPONENTS -------------------------------------------------------------

    // title
    Text {
        id:             title
        color:          "white"
        x:              2 * uSpc
        width:          parent.width / 2
        y:              uSpc
        height:         titleHgt - 2 * uSpc
        text:           "Programs"
        textFormat:     Text.PlainText
        font.pixelSize: titleHgt * 0.625
        font.italic:    true
        }

    // bank and help buttons
    GridLayout {
        id:                     bankButtons

        columnSpacing:          uSpc
        rowSpacing:             uSpc
        anchors.verticalCenter: title.verticalCenter
        x:                      parent.width - width - 2 * uSpc
        width:                  13 * uHgt + 12 * uSpc
        height:                 uHgt

        ProgramsButtonBank { col:  0;  bank: 0;  colSpan: 3 }
        LayoutDummyH       { col:  1 }
        ProgramsButtonBank { col:  3;  bank: 1 }
        ProgramsButtonBank { col:  4;  bank: 2 }
        ProgramsButtonBank { col:  5;  bank: 3 }
        ProgramsButtonBank { col:  6;  bank: 4 }
        ProgramsButtonBank { col:  7;  bank: 5 }
        ProgramsButtonBank { col:  8;  bank: 6 }
        ProgramsButtonBank { col:  9;  bank: 7 }
        ProgramsButtonBank { col: 10;  bank: 8 }
        ProgramsButtonBank { col: 11;  bank: 9 }
        LayoutDummyV       { col: 12 }
        LayoutDummyV       { col: 13 }
        ButtonHelp         { col: 14;  page: "/help/Programs_screen" }
        }

    // bank panes
    Item {
        id:                 full

        x:                  uSpc
        width:              parent.width - 2 * uSpc
        y:                  titleHgt
        height:             parent.height - titleHgt - uSpc

        Rectangle {
            anchors.fill:       parent
            color:              colSection
            visible:            bankSecSel < 0
            }
        }

    readonly property int   halfHgt:    (full.height - uSpc) / 2

    Item {
        id:                 upper

        x:                  uSpc
        width:              parent.width - 2 * uSpc
        y:                  titleHgt
        height:             halfHgt

        Rectangle {
            anchors.fill:       parent
            color:              colSection
            visible:            bankSecSel >= 0
            }
        }

    Item {
        id:                 lower

        x:                  uSpc
        width:              parent.width - 2 * uSpc
        y:                  titleHgt + halfHgt + uSpc
        height:             halfHgt

        Rectangle {
            anchors.fill:       parent
            color:              colSection
            visible:            bankSecSel >= 0
            }
        }

    ProgramsBank { bank: 1 }
    ProgramsBank { bank: 2 }
    ProgramsBank { bank: 3 }
    ProgramsBank { bank: 4 }
    ProgramsBank { bank: 5 }
    ProgramsBank { bank: 6 }
    ProgramsBank { bank: 7 }
    ProgramsBank { bank: 8 }
    ProgramsBank { bank: 9 }

    PopupProgram {
        id:                 pop
        }
    }
