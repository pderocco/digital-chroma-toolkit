import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_sel       // number of Mod Select parameter
    property int        p_sel       // binding to Mod Select parameter
    property int        n_dep       // number of Mod Depth parameter
    property int        p_dep       // binding to Mod Depth parameter
    property int        n_steps     // number of Mod Steps parameter
    property int        p_steps     // binding to Mod Steps parameter

    params:             [ n_sel, n_dep, n_steps ]
    nRows:              10

    property bool matches:  p_sel === twin.p_sel
                         && p_dep === twin.p_dep
                         && p_steps === twin.p_steps

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
            newval:             4
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             8
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             14
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             20
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             5
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             9
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             15
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             21
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             6
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             10
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             16
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             22
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             3
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             7
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             11
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             17
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             23
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             12
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             18
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             24
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                3
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             13
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             19
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             25
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 6 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                7

            text:               "mod depth"
            }

        BarSliderParam {
            id:                 barSlider
            col:                1
            colSpan:            5
            row:                7

            n:                  n_dep
            p:                  p_dep
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 8 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                9

            text:               "mod steps"
            }

        ButtonValueParam {
            col:                1
            row:                9

            n:                  n_steps
            p:                  p_steps
            newval:             0
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                9

            n:                  n_steps
            p:                  p_steps
            newval:             3
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                9

            n:                  n_steps
            p:                  p_steps
            newval:             6
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                9

            n:                  n_steps
            p:                  p_steps
            newval:             9
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                10

            n:                  n_steps
            p:                  p_steps
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                10

            n:                  n_steps
            p:                  p_steps
            newval:             4
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                10

            n:                  n_steps
            p:                  p_steps
            newval:             7
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                10

            n:                  n_steps
            p:                  p_steps
            newval:             10
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                11

            n:                  n_steps
            p:                  p_steps
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                11

            n:                  n_steps
            p:                  p_steps
            newval:             5
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                11

            n:                  n_steps
            p:                  p_steps
            newval:             8
            popup:              root
            }
        }
    }
