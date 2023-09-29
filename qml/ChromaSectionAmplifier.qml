import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection
    
    property int used:  mod1SelectA.used | mod2SelectA.used 
                                | postmodSelectA.used | panA.used 
                                | mod1SelectB.used | mod2SelectB.used 
                                | postmodSelectB.used

    readonly property var popups: [
        popupAmpAMod1,
        popupAmpBMod1,
        popupAmpAMod2,
        popupAmpBMod2,
        popupAmpAPostmod,
        popupAmpBPostmod,
        popupAmpAPan,
        popupAmpBPan
        ]

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 titleA

            text:               "AMPLIFIER A"
            }

        ChromaButtonCluster {
            id:                 mod1SelectA

            col:                0
            row:                1

            dimmed:             !p_ampA_mod1_dep
            used:               popup.p_dep && usedByVolModSelect[popup.p_sel]
            param:              n_ampA_mod1_sel
            popup:              popupAmpAMod1
            clusType:           ["am"]
            }

        ChromaPopupAmplMod {
            id:                 popupAmpAMod1
            twin:               popupAmpBMod1
            title:              "AMPLIFIER A mod 1"
            titleGanged:        "AMPLIFIER mod 1"

            n_sel:              n_ampA_mod1_sel
            p_sel:              p_ampA_mod1_sel
            n_dep:              n_ampA_mod1_dep
            p_dep:              p_ampA_mod1_dep
            }

        BarSliderParam {
            id:                 mod1DepthA

            col:                1
            colSpan:            2
            row:                1

            dimmed:             !p_ampA_mod1_dep
            n:                  n_ampA_mod1_dep
            p:                  p_ampA_mod1_dep
            popup:              popupAmpAMod1
            }

        ChromaButtonCluster {
            id:                 mod2SelectA

            col:                0
            row:                2

            dimmed:             !p_ampA_mod2_dep
            used:               popup.p_dep && usedByVolModSelect[popup.p_sel]
            param:              n_ampA_mod2_sel
            popup:              popupAmpAMod2
            clusType:           ["am"]
            }

        ChromaPopupAmplMod {
            id:                 popupAmpAMod2
            twin:               popupAmpBMod2
            title:              "AMPLIFIER A mod 2"
            titleGanged:        "AMPLIFIER mod 2"

            n_sel:              n_ampA_mod2_sel
            p_sel:              p_ampA_mod2_sel
            n_dep:              n_ampA_mod2_dep
            p_dep:              p_ampA_mod2_dep
            }

        BarSliderParam {
            id:                 mod2DepthA

            col:                1
            colSpan:            2
            row:                2

            dimmed:             !p_ampA_mod2_dep
            n:                  n_ampA_mod2_dep
            p:                  p_ampA_mod2_dep
            popup:              popupAmpAMod2
            }

        ChromaButtonCluster {
            id:                 postmodSelectA

            col:                0
            row:                3

            dimmed:             !p_ampA_postmod_dep
            used:               popup.p_dep
                                        && usedByVolPostmodSelect[popup.p_sel]
            param:              n_ampA_postmod_sel
            popup:              popupAmpAPostmod
            clusType:           ["a3"]
            }

        ChromaPopupAmplPostmod {
            id:                 popupAmpAPostmod
            twin:               popupAmpBPostmod
            title:              "AMPLIFIER A post mod"
            titleGanged:        "AMPLIFIER post mod"

            n_sel:              n_ampA_postmod_sel
            p_sel:              p_ampA_postmod_sel
            n_dep:              n_ampA_postmod_dep
            p_dep:              p_ampA_postmod_dep
            }

        BarSliderParam {
            id:                 postmodDepthA

            col:                1
            colSpan:            2
            row:                3

            dimmed:             !p_ampA_postmod_dep
            n:                  n_ampA_postmod_dep
            p:                  p_ampA_postmod_dep
            popup:              popupAmpAPostmod
            }

        ChromaButtonCluster {
            id:                 panA

            col:                0
            row:                4

            dimmed:             !popup.p_pan && !popup.p_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              "<i>pan</i>"
            popup:              popupAmpAPan
            clusType:           ["ap"]
            }

        ChromaPopupPan {
            id:                 popupAmpAPan
            twin:               popupAmpBPan
            title:              "AMPLIFIER A pan"
            titleGanged:        "AMPLIFIER pan"

            n_pan:              n_ampA_pan
            p_pan:              p_ampA_pan
            n_sel:              n_ampA_pan_mod_sel
            p_sel:              p_ampA_pan_mod_sel
            n_dep:              n_ampA_pan_mod_dep
            p_dep:              p_ampA_pan_mod_dep
            }

        BarSliderParam {
            id:             panValA

            col:                1
            colSpan:            2
            row:                4

            dimmed:             !p_ampA_pan
            n:                  n_ampA_pan
            p:                  p_ampA_pan
            popup:              popupAmpAPan
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB
            col:                4

            text:               "AMPLIFIER B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Amplifier_section"
            }

        ChromaButtonCluster {
            id:                 mod1SelectB

            col:                4
            row:                1

            dimmed:             !p_ampB_mod1_dep
            used:               popup.p_dep && usedByVolModSelect[popup.p_sel]
            param:              n_ampB_mod1_sel
            popup:              popupAmpBMod1
            clusType:           ["am"]
            }

        ChromaPopupAmplMod {
            id:                 popupAmpBMod1
            twin:               popupAmpAMod1
            title:              "AMPLIFIER B mod 1"
            titleGanged:        "AMPLIFIER mod 1"

            n_sel:              n_ampB_mod1_sel
            p_sel:              p_ampB_mod1_sel
            n_dep:              n_ampB_mod1_dep
            p_dep:              p_ampB_mod1_dep
            }

        BarSliderParam {
            id:                 mod1DepthB

            col:                5
            colSpan:            2
            row:                1

            dimmed:             !p_ampB_mod1_dep
            n:                  n_ampB_mod1_dep
            p:                  p_ampB_mod1_dep
            popup:              popupAmpBMod1
            visible:            mod1SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod2SelectB

            col:                4
            row:                2

            dimmed:             !p_ampB_mod2_dep
            used:               popup.p_dep && usedByVolModSelect[popup.p_sel]
            param:              n_ampB_mod2_sel
            popup:              popupAmpBMod2
            clusType:           ["am"]
            }

        ChromaPopupAmplMod {
            id:                 popupAmpBMod2
            twin:               popupAmpAMod2
            title:              "AMPLIFIER B mod 2"
            titleGanged:        "AMPLIFIER mod 2"

            n_sel:              n_ampB_mod2_sel
            p_sel:              p_ampB_mod2_sel
            n_dep:              n_ampB_mod2_dep
            p_dep:              p_ampB_mod2_dep
            }

        BarSliderParam {
            id:                 mod2DepthB

            col:                5
            colSpan:            2
            row:                2

            dimmed:             !p_ampB_mod2_dep
            n:                  n_ampB_mod2_dep
            p:                  p_ampB_mod2_dep
            popup:              popupAmpBMod2
            visible:            mod2SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 postmodSelectB

            col:                4
            row:                3

            dimmed:             !p_ampB_postmod_dep
            used:               popup.p_dep
                                        && usedByVolPostmodSelect[popup.p_sel]
            param:              n_ampB_postmod_sel
            popup:              popupAmpBPostmod
            clusType:           ["a3"]
            }

        ChromaPopupAmplPostmod {
            id:                 popupAmpBPostmod
            twin:               popupAmpAPostmod
            title:              "AMPLIFIER B post mod"
            titleGanged:        "AMPLIFIER post mod"

            n_sel:              n_ampB_postmod_sel
            p_sel:              p_ampB_postmod_sel
            n_dep:              n_ampB_postmod_dep
            p_dep:              p_ampB_postmod_dep
            }

        BarSliderParam {
            id:                 postmodDepthB

            col:                5
            colSpan:            2
            row:                3

            dimmed:             !p_ampB_postmod_dep
            n:                  n_ampB_postmod_dep
            p:                  p_ampB_postmod_dep
            popup:              popupAmpBPostmod
            visible:            postmodSelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 panB

            col:                4
            row:                4

            dimmed:             !popup.p_pan && !popup.p_dep
            used:               popup.p_dep && ((0xF07DE >> p_patch) & 1) 
                                        && usedByModSelect[popup.p_sel]
            param:              "<i>pan</i>"
            popup:              popupAmpBPan
            clusType:           ["ap"]
            }

        ChromaPopupPan {
            id:                 popupAmpBPan
            twin:               popupAmpAPan
            title:              "AMPLIFIER B pan"
            titleGanged:        "AMPLIFIER pan"

            n_pan:              n_ampB_pan
            p_pan:              p_ampB_pan
            n_sel:              n_ampB_pan_mod_sel
            p_sel:              p_ampB_pan_mod_sel
            n_dep:              n_ampB_pan_mod_dep
            p_dep:              p_ampB_pan_mod_dep
            }

        BarSliderParam {
            id:                 panValB

            col:                5
            colSpan:            2
            row:                4

            dimmed:             !p_ampB_pan
            n:                  n_ampB_pan
            p:                  p_ampB_pan
            popup:              popupAmpBPan
            visible:            panB.text !== "="
            }
        }
    }
