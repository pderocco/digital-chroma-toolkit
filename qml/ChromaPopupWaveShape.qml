import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    property int        n_shape     // number of Shape parameter
    property int        p_shape     // binding to Shape parameter
    property int        n_width     // number of Width parameter
    property int        p_width     // binding to Width parameter

    params:             [ n_shape, n_width ]
    nRows:              6
    page:               "/help/Waveshaper_shape_cluster"

    property bool matches:  p_shape === twin.p_shape
                         && p_width === twin.p_width

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
            newval:             2
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             3
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             4
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                0

            n:                  n_shape
            p:                  p_shape
            newval:             5
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_shape
            p:                  p_shape
            newval:             1
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_shape
            p:                  p_shape
            newval:             6
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                1

            n:                  n_shape
            p:                  p_shape
            newval:             7
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             15
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             8
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             9
            popup:              root
            }

        ButtonValueParam {
            col:                5
            row:                2

            n:                  n_shape
            p:                  p_shape
            newval:             10
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_shape
            p:                  p_shape
            newval:             16
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_shape
            p:                  p_shape
            newval:             11
            popup:              root
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_shape
            p:                  p_shape
            newval:             12
            popup:              root
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                4

            n:                  n_shape
            p:                  p_shape
            newval:             17
            popup:              root
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_shape
            p:                  p_shape
            newval:             13
            popup:              root
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_shape
            p:                  p_shape
            newval:             14
            popup:              root
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 5 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                6

            text:               "width"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                6

            n:                  n_width
            p:                  p_width
            popup:              root
            strs:               p_shape < 2 ? str_100pct 
                                        : p_shape < 15 ? str_16cyc 
                                        : null
            }
        }
    }
