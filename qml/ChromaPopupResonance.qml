import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_res       // number of Resonance parameter
    property int        p_res       // binding to Resonance parameter
    property int        n_sel       // number of Mod Select parameter
    property int        p_sel       // binding to Mod Select parameter
    property int        n_dep       // number of Mod Depth parameter
    property int        p_dep       // binding to Mod Depth parameter

    params:             [ n_res, n_sel, n_dep ]
    nRows:              9
    page:               "/help/Filter_resonance_cluster"

    property bool matches:  p_res === twin.p_res
                         && p_sel === twin.p_sel
                         && p_dep === twin.p_dep

    onMatchesChanged:       chr.gangsCheck(matches, gangBit)

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "resonance"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                0

            n:                  n_res
            p:                  p_res
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_res
            p:                  p_res
            newval:             125
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_res
            p:                  p_res
            newval:             126
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                1

            n:                  n_res
            p:                  p_res
            newval:             127
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 2 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                3

            text:               "mod select"
            }

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             0
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             4
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             8
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             14
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             20
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             5
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             9
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             15
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             21
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             6
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             10
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             16
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             22
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             3
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             7
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             11
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             17
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             23
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                3
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             12
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             18
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             24
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                3
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             13
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             19
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             25
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 9 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                10

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                10

            n:                  n_dep
            p:                  p_dep
            popup:              root
            }
        }
    }
