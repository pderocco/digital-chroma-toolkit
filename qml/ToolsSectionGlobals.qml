import QtQuick 2.12
import QtQuick.Layouts 1.12

Rectangle {

    color:              colSection

    property alias      helpButtonHeight: help.height

    GridLayout {
        x:                  uSpc
        width:              parent.width - 2 * uSpc
        y:                  uSpc
        height:             parent.height - 2 * uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            text:               "GLOBAL PARAMETERS"
            }

        ButtonHelp {
            id:             help
            col:            9
            page:           "/help/Global_parameters"
            }

        LabelCluster {
            col:            0
            colSpan:        2
            row:            1

            text:           "reverb room"
            }

        ButtonValueParam {
            col:            2
            row:            1

            n:              n_reverb_room
            p:              p_reverb_room
            newval:         1
            }

        ButtonValueParam {
            col:            3
            row:            1

            n:              n_reverb_room
            p:              p_reverb_room
            newval:         2
            }

        ButtonValueParam {
            col:            4
            row:            1

            n:              n_reverb_room
            p:              p_reverb_room
            newval:         3
            }

        ButtonValueParam {
            col:            5
            row:            1

            n:              n_reverb_room
            p:              p_reverb_room
            newval:         4
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 2 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            3

            text:           "reverb send"
            }

        BarSliderParam {
            col:            2
            colSpan:        8
            row:            3

            n:              n_reverb_send
            p:              p_reverb_send
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 4 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            5

            text:           "analog master"
            }

        BarSliderParam {
            col:            2
            colSpan:        8
            row:            5

            n:              n_analog_master
            p:              p_analog_master
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 6 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            7

            text:           "rollover time"
            }

        BarSliderParam {
            col:            2
            colSpan:        8
            row:            7

            n:              n_rollover_time
            p:              p_rollover_time
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 8 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            9

            text:           "release threshold"
            }

        BarSliderParam {
            col:            2
            colSpan:        8
            row:            9

            n:              n_release_threshold
            p:              p_release_threshold
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 10 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            11

            text:           "midi main in"
            }

        ButtonValueParam {
            col:            2
            row:            11

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       !p_midi_main_in
            newval:         0
            text:           "none"
            }

        ButtonValueParam {
            col:            3
            row:            11

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       p_midi_main_in && mainPort == 0
            newval:         mainChan + 1
            text:           "serial"
            }

        ButtonValueParam {
            col:            4
            row:            11

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainPort == 1
            newval:         mainChan + 17
            text:           "host A"
            }

        ButtonValueParam {
            col:            5
            row:            11

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainPort == 2
            newval:         mainChan + 33
            text:           "host B"
            }

        // ----------------------------------------------------------------

        ButtonValueParam {
            col:            2
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       p_midi_main_in && mainChan == 0
            newval:         mainPort * 16 + 1
            text:           "1"
            }

        ButtonValueParam {
            col:            3
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 1
            newval:         mainPort * 16 + 2
            text:           "2"
            }

        ButtonValueParam {
            col:            4
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 2
            newval:         mainPort * 16 + 3
            text:           "3"
            }

        ButtonValueParam {
            col:            5
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 3
            newval:         mainPort * 16 + 4
            text:           "4"
            }

        ButtonValueParam {
            col:            6
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 4
            newval:         mainPort * 16 + 5
            text:           "5"
            }

        ButtonValueParam {
            col:            7
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 5
            newval:         mainPort * 16 + 6
            text:           "6"
            }

        ButtonValueParam {
            col:            8
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 6
            newval:         mainPort * 16 + 7
            text:           "7"
            }

        ButtonValueParam {
            col:            9
            row:            12

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 7
            newval:         mainPort * 16 + 8
            text:           "8"
            }

        // ----------------------------------------------------------------

        ButtonValueParam {
            col:            2
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 8
            newval:         mainPort * 16 + 9
            text:           "9"
            }

        ButtonValueParam {
            col:            3
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 9
            newval:         mainPort * 16 + 10
            text:           "10"
            }

        ButtonValueParam {
            col:            4
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 10
            newval:         mainPort * 16 + 11
            text:           "11"
            }

        ButtonValueParam {
            col:            5
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 11
            newval:         mainPort * 16 + 12
            text:           "12"
            }

        ButtonValueParam {
            col:            6
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 12
            newval:         mainPort * 16 + 13
            text:           "13"
            }

        ButtonValueParam {
            col:            7
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 13
            newval:         mainPort * 16 + 14
            text:           "14"
            }

        ButtonValueParam {
            col:            8
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 14
            newval:         mainPort * 16 + 15
            text:           "15"
            }

        ButtonValueParam {
            col:            9
            row:            13

            n:              n_midi_main_in
            p:              p_midi_main_in
            selected:       mainChan == 15
            newval:         mainPort * 16 + 16
            text:           "16"
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 14 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            15

            text:           "midi link in"
            }

        ButtonValueParam {
            col:            2
            row:            15

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       !p_midi_link_in
            newval:         0
            text:           "none"
            }

        ButtonValueParam {
            col:            3
            row:            15

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       p_midi_link_in && linkPort == 0
            newval:         linkChan + 1
            text:           "serial"
            }

        ButtonValueParam {
            col:            4
            row:            15

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkPort == 1
            newval:         linkChan + 17
            text:           "host A"
            }

        ButtonValueParam {
            col:            5
            row:            15

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkPort == 2
            newval:         linkChan + 33
            text:           "host B"
            }

        // ----------------------------------------------------------------

        ButtonValueParam {
            col:            2
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       p_midi_link_in && linkChan == 0
            newval:         linkPort * 16 + 1
            text:           "1"
            }

        ButtonValueParam {
            col:            3
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 1
            newval:         linkPort * 16 + 2
            text:           "2"
            }

        ButtonValueParam {
            col:            4
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 2
            newval:         linkPort * 16 + 3
            text:           "3"
            }

        ButtonValueParam {
            col:            5
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 3
            newval:         linkPort * 16 + 4
            text:           "4"
            }

        ButtonValueParam {
            col:            6
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 4
            newval:         linkPort * 16 + 5
            text:           "5"
            }

        ButtonValueParam {
            col:            7
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 5
            newval:         linkPort * 16 + 6
            text:           "6"
            }

        ButtonValueParam {
            col:            8
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 6
            newval:         linkPort * 16 + 7
            text:           "7"
            }

        ButtonValueParam {
            col:            9
            row:            16

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 7
            newval:         linkPort * 16 + 8
            text:           "8"
            }

        // ----------------------------------------------------------------

        ButtonValueParam {
            col:            2
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 8
            newval:         linkPort * 16 + 9
            text:           "9"
            }

        ButtonValueParam {
            col:            3
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 9
            newval:         linkPort * 16 + 10
            text:           "10"
            }

        ButtonValueParam {
            col:            4
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 10
            newval:         linkPort * 16 + 11
            text:           "11"
            }

        ButtonValueParam {
            col:            5
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 11
            newval:         linkPort * 16 + 12
            text:           "12"
            }

        ButtonValueParam {
            col:            6
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 12
            newval:         linkPort * 16 + 13
            text:           "13"
            }

        ButtonValueParam {
            col:            7
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 13
            newval:         linkPort * 16 + 14
            text:           "14"
            }

        ButtonValueParam {
            col:            8
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 14
            newval:         linkPort * 16 + 15
            text:           "15"
            }

        ButtonValueParam {
            col:            9
            row:            17

            n:              n_midi_link_in
            p:              p_midi_link_in
            selected:       linkChan == 15
            newval:         linkPort * 16 + 16
            text:           "16"
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 18 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            19

            text:           "midi record out"
            }

        ButtonValueParam {
            col:            2
            row:            19

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       !p_midi_rec_out
            newval:         0
            text:           "none"
            }

        ButtonValueParam {
            col:            3
            row:            19

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       p_midi_rec_out && recPort == 0
            newval:         recChan + 1
            text:           "device A"
            }

        ButtonValueParam {
            col:            4
            row:            19

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recPort == 1
            newval:         recChan + 17
            text:           "device B"
            }

        ButtonValueParam {
            col:            5
            row:            19

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recPort == 2
            newval:         recChan + 33
            text:           "device C"
            }

        ButtonValueParam {
            col:            6
            row:            19

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recPort == 3
            newval:         recChan + 49
            text:           "device D"
            }

        ButtonValueParam {
            col:            8
            row:            19

            n:              n_midi_rec_prog
            p:              p_midi_rec_prog
            selected:       p == 1
            newval:         1 - p_midi_rec_prog
            text:           "record\nprogram"
            }

        ButtonValueParam {
            col:            9
            row:            19

            n:              n_midi_rec_state
            p:              p_midi_rec_state
            selected:       p == 1
            newval:         1 - p_midi_rec_state
            text:           "record\nstate"
            }

        // ----------------------------------------------------------------

        ButtonValueParam {
            col:            2
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       p_midi_rec_out && recChan == 0 || recChan == 15
            newval:         recPort * 16 + 1
            text:           "1"
            }

        ButtonValueParam {
            col:            3
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 1 || p_midi_rec_out && recChan == 0
            newval:         recPort * 16 + 2
            text:           "2"
            }

        ButtonValueParam {
            col:            4
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 2 || recChan == 1
            newval:         recPort * 16 + 3
            text:           "3"
            }

        ButtonValueParam {
            col:            5
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 3 || recChan == 2
            newval:         recPort * 16 + 4
            text:           "4"
            }

        ButtonValueParam {
            col:            6
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 4 || recChan == 3
            newval:         recPort * 16 + 5
            text:           "5"
            }

        ButtonValueParam {
            col:            7
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 5 || recChan == 4
            newval:         recPort * 16 + 6
            text:           "6"
            }

        ButtonValueParam {
            col:            8
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 6 || recChan == 5
            newval:         recPort * 16 + 7
            text:           "7"
            }

        ButtonValueParam {
            col:            9
            row:            20

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 7 || recChan == 6
            newval:         recPort * 16 + 8
            text:           "8"
            }

        // ----------------------------------------------------------------

        ButtonValueParam {
            col:            2
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 8 || recChan == 7
            newval:         recPort * 16 + 9
            text:           "9"
            }

        ButtonValueParam {
            col:            3
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 9 || recChan == 8
            newval:         recPort * 16 + 10
            text:           "10"
            }

        ButtonValueParam {
            col:            4
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 10 || recChan == 9
            newval:         recPort * 16 + 11
            text:           "11"
            }

        ButtonValueParam {
            col:            5
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 11 || recChan == 10
            newval:         recPort * 16 + 12
            text:           "12"
            }

        ButtonValueParam {
            col:            6
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 12 || recChan == 11
            newval:         recPort * 16 + 13
            text:           "13"
            }

        ButtonValueParam {
            col:            7
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 13 || recChan == 12
            newval:         recPort * 16 + 14
            text:           "14"
            }

        ButtonValueParam {
            col:            8
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 14 || recChan == 13
            newval:         recPort * 16 + 15
            text:           "15"
            }

        ButtonValueParam {
            col:            9
            row:            21

            n:              n_midi_rec_out
            p:              p_midi_rec_out
            selected:       recChan == 15 || recChan == 14
            newval:         recPort * 16 + 16
            text:           "16"
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 22 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            23

            text:           "tapper mode"
            }

        ButtonValueParam {
            col:            2
            row:            23

            n:              n_tapper_mode
            p:              p_tapper_mode
            newval:         0
            }

        ButtonValueParam {
            col:            3
            row:            23

            n:              n_tapper_mode
            p:              p_tapper_mode
            newval:         1
            }

        ButtonValueParam {
            col:            4
            row:            23

            n:              n_tapper_mode
            p:              p_tapper_mode
            newval:         2
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 24 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            25

            text:           "slider mode"
            }

        ButtonValueParam {
            col:            2
            row:            25

            n:              n_slider_mode
            p:              p_slider_mode
            newval:         0
            }

        ButtonValueParam {
            col:            3
            row:            25

            n:              n_slider_mode
            p:              p_slider_mode
            newval:         1
            }

        ButtonValueParam {
            col:            4
            row:            25

            n:              n_slider_mode
            p:              p_slider_mode
            newval:         2
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 26 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            27

            text:           "invert"
            }

        ButtonValueParam {
            col:            2
            row:            27

            n:              n_lever1_polarity
            p:              p_lever1_polarity
            selected:       p == 1
            newval:         1 - p_lever1_polarity
            text:           "lever 1"
            }

        ButtonValueParam {
            col:            3
            row:            27

            n:              n_lever2_polarity
            p:              p_lever2_polarity
            selected:       p == 1
            newval:         1 - p_lever2_polarity
            text:           "lever 2"
            }

        ButtonValueParam {
            col:            4
            row:            27

            n:              n_pedal1_polarity
            p:              p_pedal1_polarity
            selected:       p == 1
            newval:         1 - p_pedal1_polarity
            text:           "pedal 1"
            }

        ButtonValueParam {
            col:            5
            row:            27

            n:              n_pedal2_polarity
            p:              p_pedal2_polarity
            selected:       p == 1
            newval:         1 - p_pedal2_polarity
            text:           "pedal 2"
            }

        ButtonValueParam {
            col:            6
            row:            27

            n:              n_ribbon_polarity
            p:              p_ribbon_polarity
            newval:         1 - p_ribbon_polarity
            selected:       p == 1
            text:           "ribbon"
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 28 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            29

            text:           "high resolution"
            }

        ButtonValueParam {
            col:            2
            row:            29

            n:              n_lever_resolution
            p:              p_lever_resolution
            selected:       p == 1
            newval:         1 - p_lever_resolution
            text:           "levers"
            }

        ButtonValueParam {
            col:            3
            row:            29

            n:              n_pedal_resolution
            p:              p_pedal_resolution
            selected:       p == 1
            newval:         1 - p_pedal_resolution
            text:           "pedals"
            }

        ButtonValueParam {
            col:            4
            row:            29

            n:              n_ribbon_resolution
            p:              p_ribbon_resolution
            selected:       p == 1
            newval:         1 - p_ribbon_resolution
            text:           "ribbon"
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 30 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            31

            text:           "bipolar"
            }

        ButtonValueParam {
            col:            2
            row:            31

            n:              n_bipolar_pedal1
            p:              p_bipolar_pedal1
            selected:       p == 1
            newval:         1 - p_bipolar_pedal1
            text:           "pedal 1"
            }

        ButtonValueParam {
            col:            3
            row:            31

            n:              n_bipolar_pedal2
            p:              p_bipolar_pedal2
            selected:       p == 1
            newval:         1 - p_bipolar_pedal2
            text:           "pedal 2"
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 32 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            33

            text:           "display position"
            }

        BarSliderParam {
            col:            2
            colSpan:        8
            row:            33

            n:              n_display_position
            p:              p_display_position
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 34 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            35

            text:           "display brightness"
            }

        ButtonValueParam {
            col:            2
            row:            35

            n:              n_display_brightness
            p:              p_display_brightness
            newval:         0
            }

        ButtonValueParam {
            col:            3
            row:            35

            n:              n_display_brightness
            p:              p_display_brightness
            newval:         1
            }

        ButtonValueParam {
            col:            4
            row:            35

            n:              n_display_brightness
            p:              p_display_brightness
            newval:         2
            }

        // ----------------------------------------------------------------
        LayoutDummyH { row: 36 }
        // ----------------------------------------------------------------

        LabelCluster {
            col:            0
            colSpan:        2
            row:            37

            text:           "edit timeout"
            }

        BarSliderParam {
            col:            2
            colSpan:        8
            row:            37

            n:              n_edit_timeout
            p:              p_edit_timeout
            }
        }
    }
