import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_mode      // number of Cutoff LPHP parameter
    property int        p_mode      // binding to Cutoff LPHP parameter
    property int        n_tune      // number of Cutoff Tune parameter
    property int        p_tune      // binding to Cutoff Tune parameter

    params:             [ n_mode, n_tune ]
    nRows:              3
    page:               "/help/Filter_tune_cluster"

    property bool matches:  p_mode === twin.p_mode
                         && p_tune === twin.p_tune

    onMatchesChanged:       chr.gangsCheck(matches, gangBit)

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "mode"
            }

        ButtonValueParam {
            col:                1
            row:                0

            n:                  n_mode
            p:                  p_mode
            newval:             0
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                0

            n:                  n_mode
            p:                  p_mode
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_mode
            p:                  p_mode
            newval:             4
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_mode
            p:                  p_mode
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_mode
            p:                  p_mode
            newval:             3
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                1

            n:                  n_mode
            p:                  p_mode
            newval:             5
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 2; col: 5 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                3

            text:               "tune"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                3

            n:                  n_tune
            p:                  p_tune
            popup:              root
            }
        }
    }
