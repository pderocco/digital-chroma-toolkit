import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    title:              "CONTROL selectivity"

    params:             [ n_lever_modes, n_pedal_modes, n_ribbon_mode ]
    nRows:              5
    page:               "/help/Control_selectivity_cluster"

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "lever 1"
            }

        ButtonValueParam {
            col:                1
            row:                0

            n:                  n_lever_modes
            p:                  p_lever_modes
            newval:             p_lever_modes - p_lever_modes % 3
            selected:           (p_lever_modes % 3) === 0
            text:               "normal"
            }

        ButtonValueParam {
            col:                2
            row:                0

            n:                  n_lever_modes
            p:                  p_lever_modes
            newval:             p_lever_modes - p_lever_modes % 3 + 1
            selected:           (p_lever_modes % 3) === 1
            text:               "selective"
            }

        ButtonValueParam {
            col:                3
            row:                0

            n:                  n_lever_modes
            p:                  p_lever_modes
            newval:             p_lever_modes - p_lever_modes % 3 + 2
            selected:           (p_lever_modes % 3) === 2
            text:               "sampled"
            }

        LayoutDummyH { col: 4 }
        LayoutDummyH { col: 5 }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "lever 2"
            }

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_lever_modes
            p:                  p_lever_modes
            newval:             p_lever_modes % 3
            selected:           p_lever_modes - p_lever_modes % 3 === 0
            text:               "normal"
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_lever_modes
            p:                  p_lever_modes
            newval:             p_lever_modes % 3 + 3
            selected:           p_lever_modes - p_lever_modes % 3 === 3
            text:               "selective"
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_lever_modes
            p:                  p_lever_modes
            newval:             p_lever_modes % 3 + 6
            selected:           p_lever_modes - p_lever_modes % 3 === 6
            text:               "sampled"
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 3 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                4

            text:               "pedal 1"
            }

        ButtonValueParam {
            col:                1
            row:                4

            n:                  n_pedal_modes
            p:                  p_pedal_modes
            newval:             p_pedal_modes - p_pedal_modes % 3
            selected:           (p_pedal_modes % 3) === 0
            text:               "normal"
            }

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_pedal_modes
            p:                  p_pedal_modes
            newval:             p_pedal_modes - p_pedal_modes % 3 + 1
            selected:           (p_pedal_modes % 3) === 1
            text:               "selective"
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_pedal_modes
            p:                  p_pedal_modes
            newval:             p_pedal_modes - p_pedal_modes % 3 + 2
            selected:           (p_pedal_modes % 3) === 2
            text:               "sampled"
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 5 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                6

            text:               "pedal 2"
            }

        ButtonValueParam {
            col:                1
            row:                6

            n:                  n_pedal_modes
            p:                  p_pedal_modes
            newval:             p_pedal_modes % 3
            selected:           p_pedal_modes - p_pedal_modes % 3 === 0
            text:               "normal"
            }

        ButtonValueParam {
            col:                2
            row:                6

            n:                  n_pedal_modes
            p:                  p_pedal_modes
            newval:             p_pedal_modes % 3 + 3
            selected:           p_pedal_modes - p_pedal_modes % 3 === 3
            text:               "selective"
            }

        ButtonValueParam {
            col:                3
            row:                6

            n:                  n_pedal_modes
            p:                  p_pedal_modes
            newval:             p_pedal_modes % 3 + 6
            selected:           p_pedal_modes - p_pedal_modes % 3 === 6
            text:               "sampled"
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 7 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                8

            text:               "ribbon"
            }

        ButtonValueParam {
            col:                1
            row:                8

            n:                  n_ribbon_mode
            p:                  p_ribbon_mode
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                8

            n:                  n_ribbon_mode
            p:                  p_ribbon_mode
            newval:             1
            }

        ButtonValueParam {
            col:                3
            row:                8

            n:                  n_ribbon_mode
            p:                  p_ribbon_mode
            newval:             2
            }
        }
    }
