import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_time          // number of Attack Time parameter
    property int        p_time          // binding to Attack Time parameter
    property int        n_conserv       // number of Conservation parameter
    property int        p_conserv       // binding to Conservation parameter
    property int        n_sel           // number of Attack Mod Select parameter
    property int        p_sel           // binding to Attack Mod Select parameter
    property int        n_dep           // number of Attack Mod Depth parameter
    property int        p_dep           // binding to Attack Mod Depth parameter

    params:             [ n_time, n_conserv, n_sel, n_dep ]
    nRows:              8
    page:               "/help/Envelope_attack_cluster"

    property bool matches:  p_time === twin.p_time
                         && p_conserv === twin.p_conserv
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
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "conservation"
            }

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_conserv
            p:                  p_conserv
            newval:             -1
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_conserv
            p:                  p_conserv
            newval:             0
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_conserv
            p:                  p_conserv
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_conserv
            p:                  p_conserv
            newval:             2
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_conserv
            p:                  p_conserv
            newval:             3
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_conserv
            p:                  p_conserv
            newval:             4
            }

        ButtonValueParam {
            col:                5
            row:                3

            n:                  n_conserv
            p:                  p_conserv
            newval:             5
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 4 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                5

            text:               "mod select"
            }

        ButtonValueParam {
            col:                1
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             4
            }

        ButtonValueParam {
            col:                3
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             8
            }

        ButtonValueParam {
            col:                4
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             12
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             5
            }

        ButtonValueParam {
            col:                3
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             9
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             2
            }

        ButtonValueParam {
            col:                2
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             6
            }

        ButtonValueParam {
            col:                3
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             10
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             3
            }

        ButtonValueParam {
            col:                2
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             7
            }

        ButtonValueParam {
            col:                3
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             11
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
            }
        }
    }
