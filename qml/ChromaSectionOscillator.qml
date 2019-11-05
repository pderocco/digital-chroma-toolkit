import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection

    property int used:  mod1SelectA.used | mod2SelectA.used 
                      | mod3SelectA.used | mod4SelectA.used 
                      | mod5SelectA.used | tuneB.used 
                      | mod1SelectB.used | mod2SelectB.used 
                      | mod3SelectB.used | mod4SelectB.used 
                      | mod5SelectB.used

    readonly property var popups: [
        popupOscATune,
        popupOscBTune,
        popupOscAMod1,
        popupOscBMod1,
        popupOscAMod2,
        popupOscBMod2,
        popupOscAMod3,
        popupOscBMod3,
        popupOscAMod4,
        popupOscBMod4,
        popupOscAMod5,
        popupOscBMod5
        ]

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 titleA

            text:               "OSCILLATOR A"
            }

        ChromaButtonCluster {
            id:                 tuneA

            col:                0
            row:                1

            dimmed:             !p_oscA_tune
            param:              "<i>tune</i>"
            popup:              popupOscATune
            clusType:           ["ot"]
            }

        ChromaPopupOscillatorTune {
            id:                 popupOscATune
            twin:               popupOscBTune
            title:              "OSCILLATOR A tune"
            titleGanged:        "OSCILLATOR tune"

            n_tune:             n_oscA_tune
            p_tune:             p_oscA_tune
            }

        BarSliderParam {
            id:                 tuneAVal

            col:                1
            colSpan:            2
            row:                1

            dimmed:             !p_oscA_tune
            n:                  n_oscA_tune
            p:                  p_oscA_tune
            popup:              popupOscATune
            }

        ChromaButtonCluster {
            id:                 mod1SelectA

            col:                0
            row:                2

            dimmed:             !p_oscA_mod1_dep
            used:               popup.p_dep && (usedByModSelect[popup.p_sel] 
                                        | usedByModSteps[popup.p_steps])
            param:              n_oscA_mod1_sel
            popup:              popupOscAMod1
            clusType:           ["mp"]
            }

        ChromaPopupModSteps {
            id:                 popupOscAMod1
            twin:               popupOscBMod1
            title:              "OSCILLATOR A mod 1"
            titleGanged:        "OSCILLATOR mod 1"
            page:               "/help/Oscillator_mod1_cluster"

            n_sel:              n_oscA_mod1_sel
            p_sel:              p_oscA_mod1_sel
            n_dep:              n_oscA_mod1_dep
            p_dep:              p_oscA_mod1_dep
            n_steps:            n_oscA_mod1_steps
            p_steps:            p_oscA_mod1_steps
            }

        BarSliderParam {
            id:                 mod1DepthA

            col:                1
            colSpan:            2
            row:                2

            dimmed:             !p_oscA_mod1_dep
            n:                  n_oscA_mod1_dep
            p:                  p_oscA_mod1_dep
            popup:              popupOscAMod1
            }

        ChromaButtonCluster {
            id:                 mod2SelectA

            col:                0
            row:                3

            dimmed:             !p_oscA_mod2_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscA_mod2_sel
            popup:              popupOscAMod2
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscAMod2
            twin:               popupOscBMod2
            title:              "OSCILLATOR A mod 2"
            titleGanged:        "OSCILLATOR mod 2"
            page:               "/help/Oscillator_mod_cluster"
    
            n_sel:              n_oscA_mod2_sel
            p_sel:              p_oscA_mod2_sel
            n_dep:              n_oscA_mod2_dep
            p_dep:              p_oscA_mod2_dep
            }

        BarSliderParam {
            id:                 mod2DepthA

            col:                1
            colSpan:            2
            row:                3

            dimmed:             !p_oscA_mod2_dep
            n:                  n_oscA_mod2_dep
            p:                  p_oscA_mod2_dep
            popup:              popupOscAMod2
            }

        ChromaButtonCluster {
            id:                 mod3SelectA

            col:                0
            row:                4

            dimmed:             !p_oscA_mod3_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscA_mod3_sel
            popup:              popupOscAMod3
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscAMod3
            twin:               popupOscBMod3
            title:              "OSCILLATOR A mod 3"
            titleGanged:        "OSCILLATOR mod 3"
            page:               "/help/Oscillator_mod_cluster"

            n_sel:              n_oscA_mod3_sel
            p_sel:              p_oscA_mod3_sel
            n_dep:              n_oscA_mod3_dep
            p_dep:              p_oscA_mod3_dep
            }

        BarSliderParam {
            id:                 mod3DepthA

            col:                1
            colSpan:            2
            row:                4

            dimmed:             !p_oscA_mod3_dep
            n:                  n_oscA_mod3_dep
            p:                  p_oscA_mod3_dep
            popup:              popupOscAMod3
            }

        ChromaButtonCluster {
            id:                 mod4SelectA

            col:                0
            row:                5

            dimmed:             !p_oscA_mod4_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscA_mod4_sel
            popup:              popupOscAMod4
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscAMod4
            twin:               popupOscBMod4
            title:              "OSCILLATOR A mod 4"
            titleGanged:        "OSCILLATOR mod 4"
            page:               "/help/Oscillator_mod_cluster"

            n_sel:              n_oscA_mod4_sel
            p_sel:              p_oscA_mod4_sel
            n_dep:              n_oscA_mod4_dep
            p_dep:              p_oscA_mod4_dep
            }

        BarSliderParam {
            id:                 mod4DepthA

            col:                1
            colSpan:            2
            row:                5

            dimmed:             !p_oscA_mod4_dep
            n:                  n_oscA_mod4_dep
            p:                  p_oscA_mod4_dep
            popup:              popupOscAMod4
            }

        ChromaButtonCluster {
            id:                 mod5SelectA

            col:                0
            row:                6

            dimmed:             !p_oscA_mod5_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscA_mod5_sel
            popup:              popupOscAMod5
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscAMod5
            twin:               popupOscBMod5
            title:              "OSCILLATOR A mod 5"
            titleGanged:        "OSCILLATOR mod 5"
            page:               "/help/Oscillator_mod_cluster"

            n_sel:              n_oscA_mod5_sel
            p_sel:              p_oscA_mod5_sel
            n_dep:              n_oscA_mod5_dep
            p_dep:              p_oscA_mod5_dep
            }

        BarSliderParam {
            id:                 mod5DepthA

            col:                1
            colSpan:            2
            row:                6

            dimmed:             !p_oscA_mod5_dep
            n:                  n_oscA_mod5_dep
            p:                  p_oscA_mod5_dep
            popup:              popupOscAMod5
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB
            col:                4

            text:               "OSCILLATOR B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Oscillator_section"
            }

        ChromaButtonCluster {
            id:                 tuneB

            col:                4
            row:                1

            dimmed:             !p_oscB_tune
            param:              "<i>tune</i>"
            popup:              popupOscBTune
            clusType:           ["ot"]
            }

        ChromaPopupOscillatorTune {
            id:                 popupOscBTune
            twin:               popupOscATune
            title:              "OSCILLATOR B tune"
            titleGanged:        "OSCILLATOR tune"

            n_tune:             n_oscB_tune
            p_tune:             p_oscB_tune
            }

        BarSliderParam {
            id:                 tuneBVal

            col:                5
            colSpan:            2
            row:                1

            dimmed:             !p_oscB_tune
            n:                  n_oscB_tune
            p:                  p_oscB_tune
            popup:              popupOscBTune
            visible:            tuneB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod1SelectB

            col:                4
            row:                2

            dimmed:             !p_oscB_mod1_dep
            used:               popup.p_dep && (usedByModSelect[popup.p_sel] 
                                        | usedByModSteps[popup.p_steps])
            param:              n_oscB_mod1_sel
            popup:              popupOscBMod1
            clusType:           ["mp"]
            }

        ChromaPopupModSteps {
            id:                 popupOscBMod1
            twin:               popupOscAMod1
            title:              "OSCILLATOR B mod 1"
            titleGanged:        "OSCILLATOR mod 1"
            page:               "/help/Oscillator_mod1_cluster"

            n_sel:              n_oscB_mod1_sel
            p_sel:              p_oscB_mod1_sel
            n_dep:              n_oscB_mod1_dep
            p_dep:              p_oscB_mod1_dep
            n_steps:            n_oscB_mod1_steps
            p_steps:            p_oscB_mod1_steps
            }

        BarSliderParam {
            id:                 mod1DepthB

            col:                5
            colSpan:            2
            row:                2

            dimmed:             !p_oscB_mod1_dep
            n:                  n_oscB_mod1_dep
            p:                  p_oscB_mod1_dep
            popup:              popupOscBMod1
            visible:            mod1SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod2SelectB

            col:                4
            row:                3

            dimmed:             !p_oscB_mod2_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscB_mod2_sel
            popup:              popupOscBMod2
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscBMod2
            twin:               popupOscAMod2
            title:              "OSCILLATOR B mod 2"
            titleGanged:        "OSCILLATOR mod 2"
            page:               "/help/Oscillator_mod_cluster"

            n_sel:              n_oscB_mod2_sel
            p_sel:              p_oscB_mod2_sel
            n_dep:              n_oscB_mod2_dep
            p_dep:              p_oscB_mod2_dep
            }

        BarSliderParam {
            id:                 mod2DepthB

            col:                5
            colSpan:            2
            row:                3

            dimmed:             !p_oscB_mod2_dep
            n:                  n_oscB_mod2_dep
            p:                  p_oscB_mod2_dep
            popup:              popupOscBMod2
            visible:            mod2SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod3SelectB

            col:                4
            row:                4

            dimmed:             !p_oscB_mod3_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscB_mod3_sel
            popup:              popupOscBMod3
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscBMod3
            twin:               popupOscAMod3
            title:              "OSCILLATOR B mod 3"
            titleGanged:        "OSCILLATOR mod 3"
            page:               "/help/Oscillator_mod_cluster"

            n_sel:              n_oscB_mod3_sel
            p_sel:              p_oscB_mod3_sel
            n_dep:              n_oscB_mod3_dep
            p_dep:              p_oscB_mod3_dep
            }

        BarSliderParam {
            id:                 mod3DepthB

            col:                5
            colSpan:            2
            row:                4

            dimmed:             !p_oscB_mod3_dep
            n:                  n_oscB_mod3_dep
            p:                  p_oscB_mod3_dep
            popup:              popupOscBMod3
            visible:            mod3SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod4SelectB

            col:                4
            row:                5

            dimmed:             !p_oscB_mod4_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscB_mod4_sel
            popup:              popupOscBMod4
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscBMod4
            twin:               popupOscAMod4
            title:              "OSCILLATOR B mod 4"
            titleGanged:        "OSCILLATOR mod 4"
            page:               "/help/Oscillator_mod_cluster"

            n_sel:              n_oscB_mod4_sel
            p_sel:              p_oscB_mod4_sel
            n_dep:              n_oscB_mod4_dep
            p_dep:              p_oscB_mod4_dep
            }

        BarSliderParam {
            id:                 mod4DepthB

            col:                5
            colSpan:            2
            row:                5

            dimmed:             !p_oscB_mod4_dep
            n:                  n_oscB_mod4_dep
            p:                  p_oscB_mod4_dep
            popup:              popupOscBMod4
            visible:            mod4SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod5SelectB

            col:                4
            row:                6

            dimmed:             !p_oscB_mod5_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_oscB_mod5_sel
            popup:              popupOscBMod5
            clusType:           ["mp"]
            }

        ChromaPopupMod {
            id:                 popupOscBMod5
            twin:               popupOscAMod5
            title:              "OSCILLATOR B mod 5"
            titleGanged:        "OSCILLATOR mod 5"
            page:               "/help/Oscillator_mod_cluster"

            n_sel:              n_oscB_mod5_sel
            p_sel:              p_oscB_mod5_sel
            n_dep:              n_oscB_mod5_dep
            p_dep:              p_oscB_mod5_dep
            }

        BarSliderParam {
            id:                 mod5DepthB

            col:                5
            colSpan:            2
            row:                6

            dimmed:             !p_oscB_mod5_dep
            n:                  n_oscB_mod5_dep
            p:                  p_oscB_mod5_dep
            popup:              popupOscBMod5
            visible:            mod5SelectB.text !== "="
            }
        }
    }
