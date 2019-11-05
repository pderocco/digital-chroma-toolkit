import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    title:              "CONTROL detune"

    params:             [ n_detune, n_detune_scale, n_tune_shift ]
    nRows:              3
    page:               "/help/Control_detune_cluster"

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "detune"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                0

            n:                  n_detune
            p:                  p_detune
            strs:               p_detune_scale < 2 ? str_pm50c : str_detune_hz
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "scale"
            }

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_detune_scale
            p:                  p_detune_scale
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_detune_scale
            p:                  p_detune_scale
            newval:             1
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_detune_scale
            p:                  p_detune_scale
            newval:             2
            }

        LayoutDummyH { col: 4; row: 2 }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 3 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                4

            text:               "tune shift"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                4

            n:                  n_tune_shift
            p:                  p_tune_shift
            }
        }
    }
