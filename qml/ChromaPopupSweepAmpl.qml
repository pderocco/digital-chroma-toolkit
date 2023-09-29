import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_shape     // number of Shape parameter
    property int        p_shape     // binding to Shape parameter
    property int        n_sel       // number of Ampl Mod Select parameter
    property int        p_sel       // binding to Ampl Mod Select parameter
    property int        n_dep       // number of Ampl Mod Depth parameter
    property int        p_dep       // binding to Ampl Mod Depth parameter

    params:             [ n_shape, n_sel, n_dep ]
    nRows:              11
    page:               "/help/Sweep_amplitude_cluster"

    property bool matches:  p_shape === twin.p_shape
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
            }

        ButtonValueParam {
            col:                2
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             4
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             8
            }

        ButtonValueParam {
            col:                4
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             12
            }
                    
        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_shape
            p:                  p_shape
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_shape
            p:                  p_shape
            newval:             5
            }

        ButtonValueParam {
            col:                3
            row:                1

            n:                  n_shape
            p:                  p_shape
            newval:             9
            }

        ButtonValueParam {
            col:                4
            row:                1

            n:                  n_shape
            p:                  p_shape
            newval:             13
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             2
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             6
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             10
            }

        ButtonValueParam {
            col:                4
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             14
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_shape
            p:                  p_shape
            newval:             3
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_shape
            p:                  p_shape
            newval:             7
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_shape
            p:                  p_shape
            newval:             11
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_shape
            p:                  p_shape
            newval:             15
            }

        // --------------------------------------------------------------------

        Item {
            Layout.column:          5
            Layout.row:             0
            Layout.rowSpan:         4
            Layout.fillWidth:       true
            Layout.fillHeight:      true

            Image {
                anchors.fill:           parent
                anchors.margins:        2
                source:                 "../images/shape" + p_shape + ".png"
                fillMode:               Image.PreserveAspectFit
                mipmap:                 true
                }
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
            newval:             6
            }

        ButtonValueParam {
            col:                3
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             12
            }

        ButtonValueParam {
            col:                4
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             16
            }

        ButtonValueParam {
            col:                5
            row:                5

            n:                  n_sel
            p:                  p_sel
            newval:             20
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
            newval:             7
            }

        ButtonValueParam {
            col:                3
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             13
            }

        ButtonValueParam {
            col:                4
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             17
            }

        ButtonValueParam {
            col:                5
            row:                6

            n:                  n_sel
            p:                  p_sel
            newval:             21
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
            newval:             8
            }

        ButtonValueParam {
            col:                3
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             14
            }

        ButtonValueParam {
            col:                4
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             18
            }

        ButtonValueParam {
            col:                5
            row:                7

            n:                  n_sel
            p:                  p_sel
            newval:             22
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
            newval:             9
            }

        ButtonValueParam {
            col:                3
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             15
            }

        ButtonValueParam {
            col:                4
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             19
            }

        ButtonValueParam {
            col:                5
            row:                8

            n:                  n_sel
            p:                  p_sel
            newval:             23
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             4
            }

        ButtonValueParam {
            col:                2
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             10
            }

        ButtonValueParam {
            col:                5
            row:                9

            n:                  n_sel
            p:                  p_sel
            newval:             24
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                10

            n:                  n_sel
            p:                  p_sel
            newval:             5
            }

        ButtonValueParam {
            col:                2
            row:                10

            n:                  n_sel
            p:                  p_sel
            newval:             11
            }

        ButtonValueParam {
            col:                5
            row:                10

            n:                  n_sel
            p:                  p_sel
            newval:             25
            }

        // --------------------------------------------------------------------

        Item {
            Layout.column:          3
            Layout.columnSpan:      2
            Layout.row:             9
            Layout.rowSpan:         2
            Layout.fillWidth:       true
            Layout.fillHeight:      true

            ChromaGraphSwpAmpl {
                anchors.centerIn:   parent
                height:             parent.height
                d:                  p_dep
                s:                  p_sel
                }
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 11 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                12

            text:               "mod depth"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                12

            n:                  n_dep
            p:                  p_dep
            }
        }
    }
