import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection
    
    property int used:  shapeA.used | shapeB.used

    readonly property var popups: [
        popupGlideA,
        popupGlideB
        ]

    property alias pressedA:    titleA.pressed
    property alias pressedB:    titleB.pressed
    property int usedA:         chr.used & 0x01
    property int usedB:         chr.used & 0x10

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 titleA
            cursor:             Qt.PointingHandCursor
            text:               "GLIDE A"
            }

        ChromaButtonCluster {
            id:                 shapeA

            col:                0
            row:                1

            dimmed:             !usedA || !popup.p_time && !popup.p_dep
            used:               popup.p_dep && usedByGlide[popup.p_sel]
            param:              n_gldA_shape
            popup:              popupGlideA
            clusType:           ["gl"]
            }

        ChromaPopupGlide {
            id:                 popupGlideA
            twin:               popupGlideB
            title:              "GLIDE A time"
            titleGanged:        "GLIDE time"

            n_shape:            n_gldA_shape
            p_shape:            p_gldA_shape
            n_time:             n_gldA_time
            p_time:             p_gldA_time
            n_sel:              n_gldA_mod_sel
            p_sel:              p_gldA_mod_sel
            n_dep:              n_gldA_mod_dep
            p_dep:              p_gldA_mod_dep
            }

        BarSliderParam {
            id:                 timeA

            col:                1
            colSpan:            2
            row:                1

            dimmed:             !usedA || !p_gldA_time
            n:                  n_gldA_time
            p:                  p_gldA_time
            popup:              popupGlideA
            strs:               p_gldA_shape < 2 ? str_gld_time : str_gld_tps
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB
            col:                4
            cursor:             Qt.PointingHandCursor
            text:               "GLIDE B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Glide_section"
            }

        ChromaButtonCluster {
            id:                 shapeB

            col:                4
            row:                1

            dimmed:             !usedB || !popup.p_time && !popup.p_dep
            used:               popup.p_dep && usedByGlide[popup.p_sel]
            param:              n_gldB_shape
            popup:              popupGlideB
            clusType:           ["gl"]
            }

        ChromaPopupGlide {
            id:                 popupGlideB
            twin:               popupGlideA
            title:              "GLIDE B time"
            titleGanged:        "GLIDE time"

            n_shape:            n_gldB_shape
            p_shape:            p_gldB_shape
            n_time:             n_gldB_time
            p_time:             p_gldB_time
            n_sel:              n_gldB_mod_sel
            p_sel:              p_gldB_mod_sel
            n_dep:              n_gldB_mod_dep
            p_dep:              p_gldB_mod_dep
            }

        BarSliderParam {
            id:                 timeB

            col:                5
            colSpan:            2
            row:                1

            dimmed:             !usedB || !p_gldB_time
            n:                  n_gldB_time
            p:                  p_gldB_time
            popup:              popupGlideB
            strs:               p_gldB_shape < 2 ? str_gld_time : str_gld_tps
            visible:            shapeB.text !== "="
            }
        }
    }
