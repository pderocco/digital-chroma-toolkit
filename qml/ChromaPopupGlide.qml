import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_shape     // number of Shape parameter
    property int        p_shape     // binding to Shape parameter
    property int        n_time      // number of Time parameter
    property int        p_time      // binding to Time parameter
    property int        p_sel       // number of Mod Select parameter
    property int        n_sel       // binding to Mod Select parameter
    property int        p_dep       // number of Mod Depth parameter
    property int        n_dep       // binding to Mod Depth parameter

    params:             [ n_shape, n_time, n_sel, n_dep ]
    nRows:              9
    page:               "/help/Glide_cluster"

    property bool matches:  p_shape === twin.p_shape
                         && p_time === twin.p_time
                         && p_sel === twin.p_sel
                         && p_dep === twin.p_dep

    onMatchesChanged:       chr.gangsCheck(matches, gangBit)

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "shape"
            }

        ButtonValueParam {
            col:                1
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             0
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             3
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "time"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                2

            n:                  n_time
            p:                  p_time
            popup:              root
            strs:               p_shape < 2 ? str_gld_time : str_gld_tps
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 3 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                4

            text:               "mod select"
            }

        ButtonValueParam {
            col:                1
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             0
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             6
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             12
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             7
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             13
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             8
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             14
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             3
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             9
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             15
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             4
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             10
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             5
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             11
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 10 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                11

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                11

            n:                  n_dep
            p:                  p_dep
            popup:              root
            }
        }
    }
