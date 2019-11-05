import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_tune  // number of Pitch Tune parameter
    property int        p_tune  // binding to Pitch Tune parameter

    params:             [ n_tune ]
    nRows:              1
    page:               "/help/Oscillator_tune_cluster"

    property bool matches:  p_tune === twin.p_tune

    onMatchesChanged:       chr.gangsCheck(matches, gangBit)

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "tune"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                0

            n:                  root.n_tune
            p:                  root.p_tune
            popup:              root
            }

        LayoutDummyH { col: 2 }
        LayoutDummyH { col: 4 }
        }
    }
