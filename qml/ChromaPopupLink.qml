import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                     root

    title:                  "COMMON link"

    property alias text:    value.text

    params:                 [ n_link_mode, n_link_balance, n_link_spread, 
                              n_link_detune, n_keyboard_split ]
    nRows:                  7
    nParams:                6
    page:                   "/help/Common_link_cluster"

    function link_text(n, p) {
        if (!n)
            return "self"
        if (p && p.name)
            return n.toString() + " " + p.name
        else
            return n.toString()
        }

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "link program"
            }

        ButtonValueParam {
            id:                 value

            col:                1
            colSpan:            5
            row:                0

            n:                  n_link_number
            p:                  n_link_number
            newval:             p_link_number
            selected:           p_link_mode

            text:               link_text(currLinkNum, 
                                        linkNum ? app["p" + linkNum] : null)
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "link mode"
            }

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             0
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             5
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             2
            }

        ButtonValueParam {
            col:                4
            row:                2

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             6
            }

        // --------------------------------------------------------------------

        ButtonValueParam {
            col:                1
            row:                3

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             3
            }

        ButtonValueParam {
            col:                2
            row:                3

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             4
            }

        ButtonValueParam {
            col:                3
            row:                3

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             1
            }

        ButtonValueParam {
            col:                4
            row:                3

            n:                  n_link_mode
            p:                  p_link_mode
            newval:             7
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 4 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                5

            text:               "keyboard split"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                5

            n:                  n_keyboard_split
            p:                  p_keyboard_split
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 6 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                7

            text:               "link balance"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                7

            n:                  n_link_balance
            p:                  p_link_balance
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 8 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                9

            text:               "link detune"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                9

            n:                  n_link_detune
            p:                  p_link_detune
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 10 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                11

            text:               "link spread"
            }

        BarSliderParam {
            col:                1
            colSpan:            5
            row:                11

            n:                  n_link_spread
            p:                  p_link_spread
            }
        }
    }
    