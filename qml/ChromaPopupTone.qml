import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    title:              "CONTROL tone"

    params:             [ n_bass_gain, n_bass_freq, n_middle_gain, 
                          n_middle_freq, n_middle_res, n_treble_gain, 
                          n_treble_freq, n_distortion, n_reverb_room, 
                          n_reverb_send ]
    nRows:              9
    nParams:            4
    page:               "/help/Control_tone_cluster"

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "treble gain"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                0

            n:                  n_treble_gain
            p:                  p_treble_gain
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                1

            text:               "frequency"
            }

        BarSliderParam {
            col:                1
            colSpan:            2
            row:                1

            n:                  n_treble_freq
            p:                  p_treble_freq
            }

        // --------------------------------------------------------------------
        LayoutDummyH { col: 1; row: 2 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                3

            text:               "middle gain"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                3

            n:                  n_middle_gain
            p:                  p_middle_gain
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                4

            text:               "frequency"
            }

        BarSliderParam {
            col:                1
            colSpan:            2
            row:                4

            n:                  n_middle_freq
            p:                  p_middle_freq
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                3
            row:                4

            text:               "resonance"
            }

        BarSliderParam {
            col:                4
            colSpan:            2
            row:                4

            n:                  n_middle_res
            p:                  p_middle_res
            }

        // --------------------------------------------------------------------
        LayoutDummyH { col: 4; row: 5 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                6

            text:               "bass gain"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                6

            n:                  n_bass_gain
            p:                  p_bass_gain
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                7

            text:               "frequency"
            }

        BarSliderParam {
            col:                1
            colSpan:            2
            row:                7

            n:                  n_bass_freq
            p:                  p_bass_freq
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 8 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                9

            text:               "distortion"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                9

            n:                  n_distortion
            p:                  p_distortion
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 10 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                11

            text:               "reverb room"
            }

        ButtonValueParam {
            col:                1
            row:                11

            n:                  n_reverb_room
            p:                  p_reverb_room
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                11

            n:                  n_reverb_room
            p:                  p_reverb_room
            newval:             1
            }

        ButtonValueParam {
            col:                3
            row:                11

            n:                  n_reverb_room
            p:                  p_reverb_room
            newval:             2
            }

        ButtonValueParam {
            col:                4
            row:                11

            n:                  n_reverb_room
            p:                  p_reverb_room
            newval:             3
            }

        ButtonValueParam {
            col:                5
            row:                11

            n:                  n_reverb_room
            p:                  p_reverb_room
            newval:             4
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 12 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                13

            text:               "reverb send"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                13

            n:                  n_reverb_send
            p:                  p_reverb_send
            }
        }
    }
