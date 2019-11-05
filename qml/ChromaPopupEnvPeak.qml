import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_sel       // number of Mod Select parameter
    property int        p_sel       // binding to Mod Select parameter
    property int        n_dep       // number of Mod Depth parameter
    property int        p_dep       // binding to Mod Depth parameter

    params:             [ n_sel, n_dep ]
    nRows:              8
    page:               "/help/Envelope_peak_cluster"

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
            }

        ButtonValueParam {
            col:                2
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             7
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             12
            }

        ButtonValueParam {
            col:                4
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             16
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             8
            }

        ButtonValueParam {
            col:                3
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             13
            }

        ButtonValueParam {
            col:                4
            row:                1

            n:                  n_sel
            p:                  p_sel
            newval:             17
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             2
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             9
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             14
            }

        ButtonValueParam {
            col:                4
            row:                2

            n:                  n_sel
            p:                  p_sel
            newval:             18
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             3
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             10
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             15
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_sel
            p:                  p_sel
            newval:             19
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             4
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_sel
            p:                  p_sel
            newval:             11
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             5
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             6
            }

        // --------------------------------------------------------------------

        Item {
            Layout.column:      3
            Layout.columnSpan:  2
            Layout.row:         4
            Layout.rowSpan:     3
            Layout.fillWidth:   true
            Layout.fillHeight:  true

            ChromaGraphEnvPeak {
                anchors.centerIn:   parent
                width:              Math.min(parent.height, parent.width)
                height:             width
                d:                  p_dep
                s:                  p_sel
                }
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 7 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                8

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                8

            n:                  n_dep
            p:                  p_dep
            }
        }
    }
