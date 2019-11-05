import QtQuick 2.13
import QtQuick.Layouts 1.13
import "Util.js" as Util

Rectangle {
    color:              colSection
    
    readonly property var popups: [
        popupSequence,
        popupControllers,
        popupLink,
        popupEdit
        ]

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 commonTitle

            text:               "COMMON"
            }

        ChromaButtonCluster {
            id:                 commonSequenceCluster

            col:                0
            colSpan:            2
            row:                1

            param:              "<i>sequence:</i> " + popupSequence.text
            popup:              popupSequence
            dimmed:             !p_sequence_number
            }

        ChromaPopupSequence {
            id:                 popupSequence
            gangBit:            0
            }

        ChromaButtonCluster {
            id:                 commonControllersCluster

            col:                2
            row:                1

            param:              "<i>controllers</i>"
            popup:              popupControllers
            dimmed:             !p_kybd_alg && !p_fsw_mode && !p_ribbon_alg
            }

        ChromaPopupControllers {
            id:                 popupControllers
            gangBit:            0
            }

        ButtonValueParam {

            col:                0
            row:                2

            n:                  n_main_transpose
            p:                  p_main_transpose
            newval:             -1
            text:               "main \u20121 oct"
            }

        ButtonValueParam {

            col:                1
            row:                2

            n:                  n_main_transpose
            p:                  p_main_transpose
            newval:             0
            text:               "main normal"
            }

        ButtonValueParam {

            col:                2
            row:                2

            n:                  n_main_transpose
            p:                  p_main_transpose
            newval:             1
            text:               "main +1 oct"
            }

        LayoutDummyV { col: 3 }

        ButtonHelp {
            col:                6
            page:               "/help/Common_section"
            }

        ChromaButtonCluster {
            id:                 commonLinkCluster

            col:                4
            colSpan:            2
            row:                1

            param:              p_link_mode 
                                        ? "link " + str_link_mode[p_link_mode] 
                                        + ": " + Util.escapeHtml(popupLink.text) 
                                        : "no link"
            popup:              popupLink
            dimmed:             !p_link_mode
            }

        ChromaPopupLink {
            id:                 popupLink
            gangBit:            0
            }

        ChromaButtonCluster {
            id:                 commonEditCluster

            col:                6
            row:                1

            readonly property int gX:       2
            readonly property int gY:       1

            param:              "<i>edit</i>"
            popup:              popupEdit
            dimmed:             p_edit_mode == defs[0][n_edit_mode]
                                    && p_edit_number == defs[0][n_edit_number]
            }

        ChromaPopupEdit {
            id:                 popupEdit
            gangBit:            0
            }

        ButtonValueParam {

            col:                4
            row:                2

            n:                  n_link_transpose
            p:                  p_link_transpose
            newval:             -1
            text:               "link \u20121 oct"
            }

        ButtonValueParam {

            col:                5
            row:                2

            n:                  n_link_transpose
            p:                  p_link_transpose
            newval:             0
            text:               "link normal"
            }

        ButtonValueParam {

            col:                6
            row:                2

            n:                  n_link_transpose
            p:                  p_link_transpose
            newval:             1
            text:               "link +1 oct"
            }
        }
    }
