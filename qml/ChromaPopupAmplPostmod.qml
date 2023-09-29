import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_sel       // number of Mod Select parameter
    property int        p_sel       // binding to Mod Select parameter
    property int        n_dep       // number of Mod Depth parameter
    property int        p_dep       // binding to Mod Depth parameter

    params:             [ n_sel, n_dep ]
    nRows:              5
    page:               "/help/Amplifier_post_mod_cluster"

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
            newval:             12
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                0

            n:                  n_sel
            p:                  p_sel
            newval:             13
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

        // --------------------------------------------------------------------

        Item {
            Layout.column:          4
            Layout.columnSpan:      2
            Layout.row:             2
            Layout.rowSpan:         2
            Layout.fillWidth:       true
            Layout.fillHeight:      true

            ChromaGraphAmpPostmod {
                anchors.centerIn:   parent
                height:             parent.height
                d:                  p_dep
                s:                  p_sel
                }
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 4 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                5

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                5

            n:                  n_dep
            p:                  p_dep
            popup:              root
            }
        }
    }
