import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                     root

    title:                  "COMMON sequence"

    property alias text:    value.text

    params:                 [ n_sequence_bank, n_sequence_number ]
    nRows:                  1
    nParams:                1
    page:                   "/help/Common_sequence_cluster"

    function seq_text(n, p) {
        if (!n)
            return "previous"
        if (p && p.name)
            return n.toString() + " " + p.name
        else
            return n.toString()
        }

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "program"
            }

        ButtonValueParam {
            id:                 value

            col:                1
            colSpan:            5
            row:                0

            n:                  n_sequence_number
            p:                  n_sequence_number
            newval:             p_sequence_number
            selected:           p_sequence_number

            text:               seq_text(currSeqNum, 
                                        seqNum ? app["p" + seqNum] : null)
            }

        LayoutDummyH { col: 2 }
        LayoutDummyH { col: 4 }
        }
    }
