import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_trigger   // number of Trigger parameter
    property int        p_trigger   // binding to Trigger parameter

    params:             [ n_trigger ]
    nRows:              4
    page:               "/help/Envelope_trigger_cluster"

    property bool matches:  p_trigger === twin.p_trigger

    onMatchesChanged:       chr.gangsCheck(matches, gangBit)

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "trigger"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                0

            n:                  n_trigger
            p:                  p_trigger
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_trigger
            p:                  p_trigger
            newval:             116
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_trigger
            p:                  p_trigger
            newval:             118
            }

        ButtonValueParam {
            col:                3
            row:                1

            n:                  n_trigger
            p:                  p_trigger
            newval:             120
            }

        ButtonValueParam {
            col:                4
            row:                1

            n:                  n_trigger
            p:                  p_trigger
            newval:             122
            }

        ButtonValueParam {
            col:                5
            row:                1

            n:                  n_trigger
            p:                  p_trigger
            newval:             123
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_trigger
            p:                  p_trigger
            newval:             117
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_trigger
            p:                  p_trigger
            newval:             119
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_trigger
            p:                  p_trigger
            newval:             121
            }

        ButtonValueParam {
            col:                4
            row:                2

            n:                  n_trigger
            p:                  p_trigger
            newval:             124
            }

        ButtonValueParam {
            col:                5
            row:                2

            n:                  n_trigger
            p:                  p_trigger
            newval:             125
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_trigger
            p:                  p_trigger
            newval:             126
            }

        ButtonValueParam {
            col:                5
            row:                3

            n:                  n_trigger
            p:                  p_trigger
            newval:             127
            }
        }
    }
