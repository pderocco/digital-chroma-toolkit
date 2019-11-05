import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_time      // number of Decay Time parameter
    property int        p_time      // binding to Decay Time parameter
    property int        n_self      // number of Decay Self Mod parameter
    property int        p_self      // binding to Decay Self Mod parameter
    property int        n_sel       // number of Decay Mod Select parameter
    property int        p_sel       // binding to Decay Mod Select parameter
    property int        n_dep       // number of Decay Mod Depth parameter
    property int        p_dep       // binding to Decay Mod Depth parameter

    params:             [ n_time, n_self, n_sel, n_dep ]
    nRows:              7
    page:               "/help/Envelope_decay_cluster"

    property bool matches:  p_time === twin.p_time
                         && p_self === twin.p_self
                         && p_sel === twin.p_sel
                         && p_dep === twin.p_dep

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
        LayoutDummyH { row: 1; col: 5 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "self mod"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                2

            n:                  n_self
            p:                  p_self
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
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             4
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             8
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             5
            }

        ButtonValueParam {
            col:                3
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             9
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             2
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
            newval:             10
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             3
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
            newval:             11
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 8 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                9

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                9

            n:                  n_dep
            p:                  p_dep
            }
        }
    }
