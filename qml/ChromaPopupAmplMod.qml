import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_sel       // number of Mod Select parameter
    property int        p_sel       // binding to Mod Select parameter
    property int        n_dep       // number of Mod Depth parameter
    property int        p_dep       // binding to Mod Depth parameter

    params:             [ n_sel, n_dep ]
    nRows:              2
    page:               "/help/Amplifier_mod_cluster"

    property bool matches:  p_sel === twin.p_sel
                         && p_dep === twin.p_dep

    onMatchesChanged:       chr.gangsCheck(matches, gangBit)

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "mod select"
            }

        ButtonValueParam {
            col:                1
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             0
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             3
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             4
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                2

            n:                  n_dep
            p:                  p_dep
            popup:              root
            }
        }
    }
