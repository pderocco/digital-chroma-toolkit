import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection
    
    property int used:  modeA.used | shapeA.used | modeB.used | shapeB.used

    readonly property var popups: [
        popupSweepARate,
        popupSweepBRate,
        popupSweepAAmpl,
        popupSweepBAmpl
        ]

    property alias pressedA:    titleA.pressed
    property alias pressedB:    titleB.pressed
    property int usedA:         chr.used & 0x02
    property int usedB:         chr.used & 0x20

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 titleA
            cursor:             Qt.PointingHandCursor
            text:               "SWEEP A"
            }

        ChromaButtonCluster {
            id:                 modeA

            col:                0
            row:                1

            param:              n_swpA_mode
            popup:              popupSweepARate
            clusType:           ["sr"]
            dimmed:             !usedA || !popup.p_mode && !popup.p_dep
            used:               popup.p_dep && usedBySweepRateMod[popup.p_sel]
            }

        ChromaPopupSweepRate {
            id:                 popupSweepARate
            twin:               popupSweepBRate
            title:              "SWEEP A rate"
            titleGanged:        "SWEEP rate"

            n_mode:             n_swpA_mode
            p_mode:             p_swpA_mode
            n_rate:             n_swpA_rate
            p_rate:             p_swpA_rate
            n_sel:              n_swpA_rate_mod_sel
            p_sel:              p_swpA_rate_mod_sel
            n_dep:              n_swpA_rate_mod_dep
            p_dep:              p_swpA_rate_mod_dep
            }

        BarSliderParam {
            id:                 rateA

            col:                1
            colSpan:            2
            row:                1

            n:                  n_swpA_rate
            p:                  p_swpA_rate
            dimmed:             !usedA || !p_swpA_rate
            popup:              popupSweepARate
            }

        ChromaButtonCluster {
            id:                 shapeA

            col:                0
            row:                2

            param:              n_swpA_ampl_mod_sel
            popup:              popupSweepAAmpl
            clusType:           ["sa"]
            dimmed:             !usedA || !popup.p_shape && !popup.p_dep
            used:               popup.p_dep && usedBySweepAmplMod[popup.p_sel]
            }

        ChromaPopupSweepAmpl {
            id:                 popupSweepAAmpl
            twin:               popupSweepBAmpl
            title:              "SWEEP A amplitude"
            titleGanged:        "SWEEP amplitude"

            n_shape:            n_swpA_wave_shape
            p_shape:            p_swpA_wave_shape
            n_sel:              n_swpA_ampl_mod_sel
            p_sel:              p_swpA_ampl_mod_sel
            n_dep:              n_swpA_ampl_mod_dep
            p_dep:              p_swpA_ampl_mod_dep
            }

        BarSliderParam {
            id:                 amplModA

            col:                1
            colSpan:            2
            row:                2

            dimmed:             !usedA || !p_swpA_ampl_mod_dep
            n:                  n_swpA_ampl_mod_dep
            p:                  p_swpA_ampl_mod_dep
            popup:              popupSweepAAmpl
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB
            col:                4
            cursor:             Qt.PointingHandCursor
            text:               "SWEEP B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Sweep_section"
            }

        ChromaButtonCluster {
            id:                 modeB

            col:                4
            row:                1

            param:              n_swpB_mode
            popup:              popupSweepBRate
            clusType:           ["sr"]
            dimmed:             !usedB || !popup.p_mode && !popup.p_dep
            used:               popup.p_dep && usedBySweepRateMod[popup.p_sel]
            }

        ChromaPopupSweepRate {
            id:                 popupSweepBRate
            twin:               popupSweepARate
            title:              "SWEEP B rate"
            titleGanged:        "SWEEP rate"

            n_mode:             n_swpB_mode
            p_mode:             p_swpB_mode
            n_rate:             n_swpB_rate
            p_rate:             p_swpB_rate
            n_sel:              n_swpB_rate_mod_sel
            p_sel:              p_swpB_rate_mod_sel
            n_dep:              n_swpB_rate_mod_dep
            p_dep:              p_swpB_rate_mod_dep
            }

        BarSliderParam {
            id:                 rateB

            col:                5
            colSpan:            2
            row:                1

            n:                  n_swpB_rate
            p:                  p_swpB_rate
            dimmed:             !usedB || !p_swpB_rate
            popup:              popupSweepBRate
            visible:            modeB.text !== "="
            }

        ChromaButtonCluster {
            id:                 shapeB

            col:                4
            row:                2

            param:              n_swpB_ampl_mod_sel
            popup:              popupSweepBAmpl
            clusType:           ["sa"]
            dimmed:             !usedB || !popup.p_shape && !popup.p_dep
            used:               popup.p_dep && usedBySweepAmplMod[popup.p_sel]
            }

        ChromaPopupSweepAmpl {
            id:                 popupSweepBAmpl
            twin:               popupSweepAAmpl
            title:              "SWEEP B amplitude"
            titleGanged:        "SWEEP amplitude"

            n_shape:            n_swpB_wave_shape
            p_shape:            p_swpB_wave_shape
            n_sel:              n_swpB_ampl_mod_sel
            p_sel:              p_swpB_ampl_mod_sel
            n_dep:              n_swpB_ampl_mod_dep
            p_dep:              p_swpB_ampl_mod_dep
            }

        BarSliderParam {
            id:                 amplModB

            col:                5
            colSpan:            2
            row:                2

            dimmed:             !usedB || !p_swpB_ampl_mod_dep
            n:                  n_swpB_ampl_mod_dep
            p:                  p_swpB_ampl_mod_dep
            popup:              popupSweepBAmpl
            visible:            shapeB.text !== "="
            }
        }
    }
