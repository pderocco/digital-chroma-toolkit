import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    title:              "CONTROL voice stack"

    params:             [ n_voice_count, n_tune_spread, n_pan_spread ]
    nRows:              4
    page:               "/help/Control_voice_stack_cluster"

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            Layout.row:         0

            text:               "voice count"
            }

        ButtonValueParam {
            col:                1
            Layout.row:         0

            n:                  n_voice_count
            p:                  p_voice_count
            newval:             1
            text:               "1"
            }

        ButtonValueParam {
            col:                2
            Layout.row:         0

            n:                  n_voice_count
            p:                  p_voice_count
            newval:             2
            text:               "2"
            }

        ButtonValueParam {
            col:                3
            Layout.row:         0

            n:                  n_voice_count
            p:                  p_voice_count
            newval:             3
            text:               "3"
            }

        ButtonValueParam {
            col:                4
            Layout.row:         0

            n:                  n_voice_count
            p:                  p_voice_count
            newval:             4
            text:               "4"
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 2 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            Layout.row:         3

            text:               "tune spread"
            }

        BarSliderParam {
            col:                1
            Layout.columnSpan:  5
            Layout.row:         3

            n:                  n_tune_spread
            p:                  p_tune_spread
            }

        ButtonValueParam {
            col:                1
            Layout.row:         4

            n:                  n_tune_spread
            p:                  p_tune_spread
            newval:             51
            }

        ButtonValueParam {
            col:                2
            Layout.row:         4

            n:                  n_tune_spread
            p:                  p_tune_spread
            newval:             52
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 5 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            Layout.row:         6

            text:               "pan spread"
            }

        BarSliderParam {
            col:                1
            Layout.columnSpan:  5
            Layout.row:         6

            n:                  n_pan_spread
            p:                  p_pan_spread
            }
        }
    }
