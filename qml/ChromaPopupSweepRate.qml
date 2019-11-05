import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_mode      // number of Mode parameter
    property int        p_mode      // binding to Mode parameter
    property int        n_rate      // number of Rate parameter
    property int        p_rate      // binding to Rate parameter
    property int        n_sel       // number of Rate Mod Select parameter
    property int        p_sel       // binding to Rate Mod Select parameter
    property int        n_dep       // number of Rate Mod Depth parameter
    property int        p_dep       // binding to Rate Mod Depth parameter

    params:             [ n_mode, n_rate, n_sel, n_dep ]
    nRows:              11
    page:               "/help/Sweep_rate_cluster"

    property bool matches:  p_mode === twin.p_mode
                         && p_rate === twin.p_rate
                         && p_sel === twin.p_sel
                         && p_dep === twin.p_dep

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
            }

        ButtonValueParam {
            col:                2
            row:                0

            n:                  n_mode
            p:                  p_mode
            newval:             1
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_mode
            p:                  p_mode
            newval:             2
            }

        ButtonValueParam {
            col:                4
            row:                0

            n:                  n_mode
            p:                  p_mode
            newval:             3
            }

        ButtonValueParam {
            col:                5
            row:                0

            n:                  n_mode
            p:                  p_mode
            newval:             4
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "rate"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                2

            n:                  n_rate
            p:                  p_rate
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_rate
            p:                  p_rate
            newval:             120
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_rate
            p:                  p_rate
            newval:             122
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_rate
            p:                  p_rate
            newval:             124
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_rate
            p:                  p_rate
            newval:             126
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                4

            n:                  n_rate
            p:                  p_rate
            newval:             121
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_rate
            p:                  p_rate
            newval:             123
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_rate
            p:                  p_rate
            newval:             125
            }

        ButtonValueParam {
            col:                4
            row:                4

            n:                  n_rate
            p:                  p_rate
            newval:             127
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 5 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                6

            text:               "mod select"
            }

        ButtonValueParam {
            col:                1
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             6
            }

        ButtonValueParam {
            col:                3
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             12
            }

        ButtonValueParam {
            col:                4
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             16
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             7
            }

        ButtonValueParam {
            col:                3
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             13
            }

        ButtonValueParam {
            col:                4
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             17
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             2
            }

        ButtonValueParam {
            col:                2
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             8
            }

        ButtonValueParam {
            col:                3
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             14
            }

        ButtonValueParam {
            col:                4
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             18
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             3
            }

        ButtonValueParam {
            col:                2
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             9
            }

        ButtonValueParam {
            col:                3
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             15
            }

        ButtonValueParam {
            col:                4
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             19
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                10

            n:                  n_sel
            p:                  p_sel
            newval:             4
            }

        ButtonValueParam {
            col:                2
            row:                10

            n:                  n_sel
            p:                  p_sel
            newval:             10
            }

        ButtonValueParam {
            col:                4
            row:                10

            n:                  n_sel
            p:                  p_sel
            newval:             20
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                11

            n:                  n_sel
            p:                  p_sel
            newval:             5
            }

        ButtonValueParam {
            col:                2
            row:                11

            n:                  n_sel
            p:                  p_sel
            newval:             11
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 12 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                13

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                13

            n:                  n_dep
            p:                  p_dep
            }
        }
    }
