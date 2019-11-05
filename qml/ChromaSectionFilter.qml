import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection
    
    property int used:  mod1SelectA.used | mod2SelectA.used | mod3SelectA.used 
                                | mod4SelectA.used | mod5SelectA.used 
                                | resonanceA.used | mod1SelectB.used 
                                | mod2SelectB.used | mod3SelectB.used 
                                | mod4SelectB.used | mod5SelectB.used 
                                | resonanceB.used

    readonly property var popups: [
        popupFltATune,
        popupFltBTune,
        popupFltAMod1,
        popupFltBMod1,
        popupFltAMod2,
        popupFltBMod2,
        popupFltAMod3,
        popupFltBMod3,
        popupFltAMod4,
        popupFltBMod4,
        popupFltAMod5,
        popupFltBMod5,
        popupFltAResonance,
        popupFltBResonance
        ]

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 titleA

            text:               "FILTER A"
            }

        ChromaButtonCluster {
            id:                 modeA

            col:                0
            row:                1

            param:              n_fltA_mode
            popup:              popupFltATune
            clusType:           ["ft"]
            }

        ChromaPopupFilterTune {
            id:                 popupFltATune
            twin:               popupFltBTune
            title:              "FILTER A tune"
            titleGanged:        "FILTER tune"

            n_mode:             n_fltA_mode
            p_mode:             p_fltA_mode
            n_tune:             n_fltA_tune
            p_tune:             p_fltA_tune
            }

        BarSliderParam {
            id:                 tuneA

            col:                1
            colSpan:            2
            row:                1

            n:                  n_fltA_tune
            p:                  p_fltA_tune
            popup:              popupFltATune
            }

        ChromaButtonCluster {
            id:                 mod1SelectA

            col:                0
            row:                2

            dimmed:             !p_fltA_mod1_dep
            used:               popup.p_dep && (usedByModSelect[popup.p_sel] 
                                        | usedByModSteps[popup.p_steps])
            param:              n_fltA_mod1_sel
            popup:              popupFltAMod1
            clusType:           ["mp"]
            }

        ChromaPopupModSteps {
            id:                 popupFltAMod1
            twin:               popupFltBMod1
            title:              "FILTER A mod 1"
            titleGanged:        "FILTER mod 1"
            page:               "/help/Filter_mod1_cluster"

            n_sel:              n_fltA_mod1_sel
            p_sel:              p_fltA_mod1_sel
            n_dep:              n_fltA_mod1_dep
            p_dep:              p_fltA_mod1_dep
            n_steps:            n_fltA_mod1_steps
            p_steps:            p_fltA_mod1_steps
            }

        BarSliderParam {
           id:                  mod1DepthA

            col:                1
            colSpan:            2
            row:                2

            dimmed:             !p_fltA_mod1_dep
            n:                  n_fltA_mod1_dep
            p:                  p_fltA_mod1_dep
            popup:              popupFltAMod1
            }

        ChromaButtonCluster {
            id:                 mod2SelectA

            col:                0
            row:                3

            dimmed:             !p_fltA_mod2_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltA_mod2_sel
            popup:              popupFltAMod2
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltAMod2
            twin:               popupFltBMod2
            title:              "FILTER A mod 2"
            titleGanged:        "FILTER mod 2"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltA_mod2_sel
            p_sel:              p_fltA_mod2_sel
            n_dep:              n_fltA_mod2_dep
            p_dep:              p_fltA_mod2_dep
            }

        BarSliderParam {
            id:                 mod2DepthA

            col:                1
            colSpan:            2
            row:                3

            dimmed:             !p_fltA_mod2_dep
            n:                  n_fltA_mod2_dep
            p:                  p_fltA_mod2_dep
            popup:              popupFltAMod2
            }

        ChromaButtonCluster {
            id:                 mod3SelectA

            col:                0
            row:                4

            dimmed:             !p_fltA_mod3_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltA_mod3_sel
            popup:              popupFltAMod3
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltAMod3
            twin:               popupFltBMod3
            title:              "FILTER A mod 3"
            titleGanged:        "FILTER mod 3"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltA_mod3_sel
            p_sel:              p_fltA_mod3_sel
            n_dep:              n_fltA_mod3_dep
            p_dep:              p_fltA_mod3_dep
            }

        BarSliderParam {
            id:                 mod3DepthA

            col:                1
            colSpan:            2
            row:                4

            dimmed:             !p_fltA_mod3_dep
            n:                  n_fltA_mod3_dep
            p:                  p_fltA_mod3_dep
            popup:              popupFltAMod3
            }

        ChromaButtonCluster {
            id:                 mod4SelectA

            col:                0
            row:                5

            dimmed:             !p_fltA_mod4_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltA_mod4_sel
            popup:              popupFltAMod4
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltAMod4
            twin:               popupFltBMod4
            title:              "FILTER A mod 4"
            titleGanged:        "FILTER mod 4"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltA_mod4_sel
            p_sel:              p_fltA_mod4_sel
            n_dep:              n_fltA_mod4_dep
            p_dep:              p_fltA_mod4_dep
            }

        BarSliderParam {
            id:                 mod4DepthA

            col:                1
            colSpan:            2
            row:                5

            dimmed:             !p_fltA_mod4_dep
            n:                  n_fltA_mod4_dep
            p:                  p_fltA_mod4_dep
            popup:              popupFltAMod4
            }

        ChromaButtonCluster {
            id:                 mod5SelectA

            col:                0
            row:                6

            dimmed:             !p_fltA_mod5_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltA_mod5_sel
            popup:              popupFltAMod5
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltAMod5
            twin:               popupFltBMod5
            title:              "FILTER A mod 5"
            titleGanged:        "FILTER mod 5"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltA_mod5_sel
            p_sel:              p_fltA_mod5_sel
            n_dep:              n_fltA_mod5_dep
            p_dep:              p_fltA_mod5_dep
            }

        BarSliderParam {
            id:                 mod5DepthA

            col:                1
            colSpan:            2
            row:                6

            dimmed:             !p_fltA_mod5_dep
            n:                  n_fltA_mod5_dep
            p:                  p_fltA_mod5_dep
            popup:              popupFltAMod5
            }

        ChromaButtonCluster {
            id:                 resonanceA

            col:                0
            row:                7

            dimmed:             !popup.p_res && !popup.p_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              "<i>resonance</i>"
            popup:              popupFltAResonance
            clusType:           ["fr"]
            }

        ChromaPopupResonance {
            id:                 popupFltAResonance
            twin:               popupFltBResonance
            title:              "FILTER A resonance"
            titleGanged:        "FILTER resonance"

            n_res:              n_fltA_res
            p_res:              p_fltA_res
            n_sel:              n_fltA_res_mod_sel
            p_sel:              p_fltA_res_mod_sel
            n_dep:              n_fltA_res_mod_dep
            p_dep:              p_fltA_res_mod_dep
            }

        BarSliderParam {
            id:                 resonanceValA

            col:                1
            colSpan:            2
            row:                7

            dimmed:             !p_fltA_res
            n:                  n_fltA_res
            p:                  p_fltA_res
            popup:              popupFltAResonance
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB
            col:                4

            text:               "FILTER B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Filter_section"
            }

        ChromaButtonCluster {
            id:                 modeB

            col:                4
            row:                1

            param:              n_fltB_mode
            popup:              popupFltBTune
            clusType:           ["ft"]
            }

        ChromaPopupFilterTune {
            id:                 popupFltBTune
            twin:               popupFltATune
            title:              "FILTER B tune"
            titleGanged:        "FILTER tune"

            n_mode:             n_fltB_mode
            p_mode:             p_fltB_mode
            n_tune:             n_fltB_tune
            p_tune:             p_fltB_tune
            }

        BarSliderParam {
            id:                 tuneB

            col:                5
            colSpan:            2
            row:                1

            n:                  n_fltB_tune
            p:                  p_fltB_tune
            popup:              popupFltBTune
            visible:            modeB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod1SelectB

            col:                4
            row:                2

            dimmed:             !p_fltB_mod1_dep
            used:               popup.p_dep && (usedByModSelect[popup.p_sel] 
                                        | usedByModSteps[popup.p_steps])
            param:              n_fltB_mod1_sel
            popup:              popupFltBMod1
            clusType:           ["mp"]
            }

        ChromaPopupModSteps {
            id:                 popupFltBMod1
            twin:               popupFltAMod1
            title:              "FILTER B mod 1"
            titleGanged:        "FILTER mod 1"
            page:               "/help/Filter_mod1_cluster"

            n_sel:              n_fltB_mod1_sel
            p_sel:              p_fltB_mod1_sel
            n_dep:              n_fltB_mod1_dep
            p_dep:              p_fltB_mod1_dep
            n_steps:            n_fltB_mod1_steps
            p_steps:            p_fltB_mod1_steps
            }

        BarSliderParam {
            id:                 mod1DepthB

            col:                5
            colSpan:            2
            row:                2

            dimmed:             !p_fltB_mod1_dep
            n:                  n_fltB_mod1_dep
            p:                  p_fltB_mod1_dep
            popup:              popupFltBMod1
            visible:            mod1SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod2SelectB

            col:                4
            row:                3

            dimmed:             !p_fltB_mod2_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltB_mod2_sel
            popup:              popupFltBMod2
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltBMod2
            twin:               popupFltAMod2
            title:              "FILTER B mod 2"
            titleGanged:        "FILTER mod 2"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltB_mod2_sel
            p_sel:              p_fltB_mod2_sel
            n_dep:              n_fltB_mod2_dep
            p_dep:              p_fltB_mod2_dep
            }

        BarSliderParam {
            id:                 mod2DepthB

            col:                5
            colSpan:            2
            row:                3

            dimmed:             !p_fltB_mod2_dep
            n:                  n_fltB_mod2_dep
            p:                  p_fltB_mod2_dep
            popup:              popupFltBMod2
            visible:            mod2SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod3SelectB

            col:                4
            row:                4

            dimmed:             !p_fltB_mod3_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltB_mod3_sel
            popup:              popupFltBMod3
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltBMod3
            twin:               popupFltAMod3
            title:              "FILTER B mod 3"
            titleGanged:        "FILTER mod 3"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltB_mod3_sel
            p_sel:              p_fltB_mod3_sel
            n_dep:              n_fltB_mod3_dep
            p_dep:              p_fltB_mod3_dep
            }

        BarSliderParam {
            id:                 mod3DepthB

            col:                5
            colSpan:            2
            row:                4

            dimmed:             !p_fltB_mod3_dep
            n:                  n_fltB_mod3_dep
            p:                  p_fltB_mod3_dep
            popup:              popupFltBMod3
            visible:            mod3SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod4SelectB

            col:                4
            row:                5

            dimmed:             !p_fltB_mod4_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltB_mod4_sel
            popup:              popupFltBMod4
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltBMod4
            twin:               popupFltAMod4
            title:              "FILTER B mod 4"
            titleGanged:        "FILTER mod 4"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltB_mod4_sel
            p_sel:              p_fltB_mod4_sel
            n_dep:              n_fltB_mod4_dep
            p_dep:              p_fltB_mod4_dep
            }

        BarSliderParam {
            id:                 mod4DepthB

            col:                5
            colSpan:            2
            row:                5

            dimmed:             !p_fltB_mod4_dep
            n:                  n_fltB_mod4_dep
            p:                  p_fltB_mod4_dep
            popup:              popupFltBMod4
            visible:            mod4SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod5SelectB

            col:                4
            row:                6

            dimmed:             !p_fltB_mod5_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_fltB_mod5_sel
            popup:              popupFltBMod5
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupFltBMod5
            twin:               popupFltAMod5
            title:              "FILTER B mod 5"
            titleGanged:        "FILTER mod 5"
            page:               "/help/Filter_mod_cluster"

            n_sel:              n_fltB_mod5_sel
            p_sel:              p_fltB_mod5_sel
            n_dep:              n_fltB_mod5_dep
            p_dep:              p_fltB_mod5_dep
            }

        BarSliderParam {
            id:                 mod5DepthB

            col:                5
            colSpan:            2
            row:                6

            dimmed:             !p_fltB_mod5_dep
            n:                  n_fltB_mod5_dep
            p:                  p_fltB_mod5_dep
            popup:              popupFltBMod5
            visible:            mod5SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 resonanceB

            col:                4
            row:                7

            dimmed:             !popup.p_res && !popup.p_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              "<i>resonance</i>"
            popup:              popupFltBResonance
            clusType:           ["fr"]
            }

        ChromaPopupResonance {
            id:                 popupFltBResonance
            twin:               popupFltAResonance
            title:              "FILTER B resonance"
            titleGanged:        "FILTER resonance"

            n_res:              n_fltB_res
            p_res:              p_fltB_res
            n_sel:              n_fltB_res_mod_sel
            p_sel:              p_fltB_res_mod_sel
            n_dep:              n_fltB_res_mod_dep
            p_dep:              p_fltB_res_mod_dep
            }

        BarSliderParam {
            id:                 resonanceValB

            col:                5
            colSpan:            2
            row:                7

            dimmed:             !p_fltB_res
            n:                  n_fltB_res
            p:                  p_fltB_res
            popup:              popupFltBResonance
            visible:            resonanceB.text !== "="
            }
        }
    }
