import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    title:              "COMMON controllers"

    params:             [ n_fsw_mode, n_ribbon_alg, n_kybd_alg ]
    nParams:            4   // since n_fsw_mode is presented as two parameters
    nRows:              12
    page:               "/help/Common_controllers_cluster"

    ChromaPopupLayout {

        LabelCluster {
            col:                1
            row:                0

            text:               "poly"
            hAlign:             Text.AlignHCenter
            vAlign:             Text.AlignBottom
            }

        LabelCluster {
            col:                2
            row:                0

            text:               "mono"
            hAlign:             Text.AlignHCenter
            vAlign:             Text.AlignBottom
            }

        LabelCluster {
            col:                3
            row:                0

            text:               "arpeg"
            hAlign:             Text.AlignHCenter
            vAlign:             Text.AlignBottom
            }

        LabelCluster {
            col:                4
            row:                0

            text:               "sequence"
            hAlign:             Text.AlignHCenter
            vAlign:             Text.AlignBottom
            }

        LabelCluster {
            col:                5
            row:                0

            text:               "strum"
            hAlign:             Text.AlignHCenter
            vAlign:             Text.AlignBottom
            }

        // --------------------------------------------------------------------

        LabelCluster     {
            col:                0
            row:                1

            text:               "keyboard\nalgorithm"
            }

        ButtonValueParam {
            col:                1
            row:                1

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                1

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             3
            }

        ButtonValueParam {
            col:                3
            row:                1

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             8
            }

        ButtonValueParam {
            col:                4
            row:                1

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             12
            }

        ButtonValueParam {
            col:                5
            row:                1

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             14
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             4
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             9
            }

        ButtonValueParam {
            col:                4
            row:                2

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             13
            }

        ButtonValueParam {
            col:                5
            row:                2

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             15
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             2
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             5
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             10
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                2
            row:                4

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             6
            }

        ButtonValueParam {
            col:                3
            row:                4

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             11
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                2
            row:                5

            n:                  n_kybd_alg
            p:                  p_kybd_alg
            newval:             7
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 6 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                7

            text:               "right footswitch"
            }

        ButtonValueParam {
            col:                1
            row:                7

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 0xE
            selected:           (p_fsw_mode & 1) == 0
            text:               "enabled"
            }

        ButtonValueParam {
            col:                2
            row:                7

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 0xE | 1
            selected:           (p_fsw_mode & 1) == 1
            text:               "disabled"
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 8 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                9

            text:               "left footswitch"
            }

        ButtonValueParam {
            col:                1
            row:                9

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 1
            selected:           (p_fsw_mode >> 1) == 0
            text:               "latch"
            }

        ButtonValueParam {
            col:                2
            row:                9

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 1 | 4
            selected:           (p_fsw_mode >> 1) == 2
            text:               "gate"
            }

        ButtonValueParam {
            col:                3
            row:                9

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 1 | 8
            selected:           (p_fsw_mode >> 1) == 4
            text:               "glide"
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                10

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 1 | 2
            selected:           (p_fsw_mode >> 1) == 1
            text:               "disabled"
            }

        ButtonValueParam {
            col:                2
            row:                10

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 1 | 6
            selected:           (p_fsw_mode >> 1) == 3
            text:               "\u2012gate"
            }

        ButtonValueParam {
            col:                3
            row:                10

            n:                  n_fsw_mode
            p:                  p_fsw_mode
            newval:             p_fsw_mode & 1 | 10
            selected:           (p_fsw_mode >> 1) == 5
            text:               "\u2012glide"
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 11 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                12

            text:               "ribbon\nalgorithm"
            }

        ButtonValueParam {
            col:                1
            row:                12

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                12

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             3
            }

        ButtonValueParam {
            col:                3
            row:                12

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             6
            }

        ButtonValueParam {
            col:                4
            row:                12

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             9
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                13

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                13

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             4
            }

        ButtonValueParam {
            col:                3
            row:                13

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             7
            }

        ButtonValueParam {
            col:                4
            row:                13

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             10
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                14

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             2
            }

        ButtonValueParam {
            col:                2
            row:                14

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             5
            }

        ButtonValueParam {
            col:                3
            row:                14

            n:                  n_ribbon_alg
            p:                  p_ribbon_alg
            newval:             8
            }
        }
    }
