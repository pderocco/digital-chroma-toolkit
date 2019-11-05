import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_time      // number of Release Time parameter
    property int        p_time      // binding to Release Time parameter
    property int        n_sel       // number of Release Mod Select parameter
    property int        p_sel       // binding to Release Mod Select parameter

    params:             [ n_time, n_sel ]
    nRows:              5
    page:               "/help/Envelope_release_cluster"

    property bool matches:  p_time === twin.p_time
                         && p_sel === twin.p_sel

    onMatchesChanged:       chr.gangsCheck(matches, gangBit)

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "time"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                0

            n:                  n_time
            p:                  p_time
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "mod select"
            }

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             4
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             8
            }

        ButtonValueParam {
            col:                4
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             12
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             5
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             9
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             13
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             2
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             6
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             10
            }

        ButtonValueParam {
            col:                4
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             14
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             3
            }

        ButtonValueParam {
            col:                2
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             7
            }

        ButtonValueParam {
            col:                3
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             11
            }

        ButtonValueParam {
            col:                4
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             15
            }
        }
    }
