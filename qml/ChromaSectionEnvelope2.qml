import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection
    
    property int used:  triggerA.used | peakA.used | attackA.used | decayA.used 
                                | releaseA.used | triggerB.used | peakB.used 
                                | attackB.used | decayB.used | releaseB.used

    readonly property var popups: [
        popupEnv2ATrigger,
        popupEnv2BTrigger,
        popupEnv2APeak,
        popupEnv2BPeak,
        popupEnv2AAttack,
        popupEnv2BAttack,
        popupEnv2ADecay,
        popupEnv2BDecay,
        popupEnv2ARelease,
        popupEnv2BRelease
        ]

    property alias pressedA:    titleA.pressed
    property alias pressedB:    titleB.pressed
    property int usedA:         chr.used & 0x08
    property int usedB:         chr.used & 0x80

    GridLayout {

        anchors.fill:           parent
        anchors.margins:        uSpc
        columnSpacing:          uSpc
        rowSpacing:             uSpc

        SectionTitle {
            id:                 titleA
            cursor:             Qt.PointingHandCursor
            text:               "ENVELOPE 2A"
            }

        ChromaButtonCluster {
            id:                 triggerA

            col:                0
            row:                1

            dimmed:             !usedA || !popup.p_trigger
            used:               usedByEnv2Trigger[popup.p_trigger]
            param:              "<i>trigger</i>"
            popup:              popupEnv2ATrigger
            clusType:           ["ey"]
            }

        ChromaPopupEnvTrigger {
            id:                 popupEnv2ATrigger
            twin:               popupEnv2BTrigger
            title:              "ENVELOPE 2A trigger"
            titleGanged:        "ENVELOPE 2 trigger"

            n_trigger:          n_env2A_trigger
            p_trigger:          p_env2A_trigger
            }

        BarSliderParam {
            id:                 triggerATime

            col:                1
            colSpan:            2
            row:                1

            dimmed:             !usedA || !p_env2A_trigger
            n:                  n_env2A_trigger
            p:                  p_env2A_trigger
            popup:              popupEnv2ATrigger
            }

        ChromaButtonCluster {
            id:                 peakA

            col:                0
            row:                2

            dimmed:             !usedA || !popup.p_dep
            used:               popup.p_dep && usedByEnvPeak[popup.p_sel]
            param:              n_env2A_peak_mod_sel
            popup:              popupEnv2APeak
            clusType:           ["et"]
            }

        ChromaPopupEnvPeak {
            id:                 popupEnv2APeak
            twin:               popupEnv2BPeak
            title:              "ENVELOPE 2A peak"
            titleGanged:        "ENVELOPE 2 peak"

            n_sel:              n_env2A_peak_mod_sel
            p_sel:              p_env2A_peak_mod_sel
            n_dep:              n_env2A_peak_mod_dep
            p_dep:              p_env2A_peak_mod_dep
            }

        BarSliderParam {
            id:                 peakAModDepth

            col:                1
            colSpan:            2
            row:                2

            dimmed:             !usedA || !p_env2A_peak_mod_dep
            n:                  n_env2A_peak_mod_dep
            p:                  p_env2A_peak_mod_dep
            popup:              popupEnv2APeak
            }

        ChromaButtonCluster {
            id:                 attackA

            col:                0
            row:                3

            dimmed:             !usedA || !popup.p_conserv && !popup.p_time 
                                        && !popup.p_dep
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>attack</i>"
            popup:              popupEnv2AAttack
            clusType:           ["ea"]
            }

        ChromaPopupEnvAttack {
            id:                 popupEnv2AAttack
            twin:               popupEnv2BAttack
            title:              "ENVELOPE 2A attack"
            titleGanged:        "ENVELOPE 2 attack"

            n_time:             n_env2A_att_time
            p_time:             p_env2A_att_time
            n_conserv:          n_env2A_att_conserv
            p_conserv:          p_env2A_att_conserv
            n_sel:              n_env2A_att_mod_sel
            p_sel:              p_env2A_att_mod_sel
            n_dep:              n_env2A_att_mod_dep
            p_dep:              p_env2A_att_mod_dep
            }

        BarSliderParam {
            id:                 attackATime

            col:                1
            colSpan:            2
            row:                3

            dimmed:             !usedA || !p_env2A_att_time
            n:                  n_env2A_att_time
            p:                  p_env2A_att_time
            popup:              popupEnv2AAttack
            }

        ChromaButtonCluster {
            id:                 decayA

            col:                0
            row:                4

            dimmed:             !usedA 
                                    || popup.p_time == paramDefs(popup.n_time) 
                                    && !popup.p_dep && !popup.p_self
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>decay</i>"
            popup:              popupEnv2ADecay
            clusType:           ["ed"]
            }

        ChromaPopupEnvDecay {
            id:                 popupEnv2ADecay
            twin:               popupEnv2BDecay
            title:              "ENVELOPE 2A decay"
            titleGanged:        "ENVELOPE 2 decay"

            n_time:             n_env2A_dec_time
            p_time:             p_env2A_dec_time
            n_self:             n_env2A_dec_self_mod
            p_self:             p_env2A_dec_self_mod
            n_sel:              n_env2A_dec_mod_sel
            p_sel:              p_env2A_dec_mod_sel
            n_dep:              n_env2A_dec_mod_dep
            p_dep:              p_env2A_dec_mod_dep
            }

        BarSliderParam {
            id:                 decayATime

            col:                1
            colSpan:            2
            row:                4

            dimmed:             !usedA || p_env2A_dec_time 
                                        == paramDefs(n_env2A_dec_time)
            n:                  n_env2A_dec_time
            p:                  p_env2A_dec_time
            popup:              popupEnv2ADecay
            }

        ChromaButtonCluster {
            id:                 releaseA

            col:                0
            row:                5

            dimmed:             !usedA || !popup.p_time && !popup.p_sel
            used:               usedByEnvReleaseMod[popup.p_sel]
            param:              "<i>release</i>"
            popup:              popupEnv2ARelease
            clusType:           ["er"]
            }

        ChromaPopupEnvRelease {
            id:                 popupEnv2ARelease
            twin:               popupEnv2BRelease
            title:              "ENVELOPE 2A release"
            titleGanged:        "ENVELOPE 2 release"

            n_time:             n_env2A_rel_time
            p_time:             p_env2A_rel_time
            n_sel:              n_env2A_rel_mod
            p_sel:              p_env2A_rel_mod
            }

        BarSliderParam {
            id:                 releaseATime

            col:                1
            colSpan:            2
            row:                5

            dimmed:             !usedA || !p_env2A_rel_time
            n:                  n_env2A_rel_time
            p:                  p_env2A_rel_time
            popup:              popupEnv2ARelease
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB
            col:                4
            cursor:             Qt.PointingHandCursor
            text:               "ENVELOPE 2B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Envelope_sections"
            }

        ChromaButtonCluster {
            id:                 triggerB

            col:                4
            row:                1

            dimmed:             !usedB || !popup.p_trigger
            used:               usedByEnv2Trigger[popup.p_trigger]
            param:              "<i>trigger</i>"
            popup:              popupEnv2BTrigger
            clusType:           ["ey"]
            }

        ChromaPopupEnvTrigger {
            id:                 popupEnv2BTrigger
            twin:               popupEnv2ATrigger
            title:              "ENVELOPE 2B trigger"
            titleGanged:        "ENVELOPE 2 trigger"

            n_trigger:          n_env2B_trigger
            p_trigger:          p_env2B_trigger
            }

        BarSliderParam {
            id:                 triggerBTime

            col:                5
            colSpan:            2
            row:                1

            dimmed:             !usedB || !p_env2B_trigger
            n:                  n_env2B_trigger
            p:                  p_env2B_trigger
            popup:              popupEnv2BTrigger
            visible:            triggerB.text !== "="
            }

        ChromaButtonCluster {
            id:                 peakB

            col:                4
            row:                2

            dimmed:             !usedB || !popup.p_dep
            used:               popup.p_dep && usedByEnvPeak[popup.p_sel]
            param:              n_env2B_peak_mod_sel
            popup:              popupEnv2BPeak
            clusType:           ["et"]
            }

        ChromaPopupEnvPeak {
            id:                 popupEnv2BPeak
            twin:               popupEnv2APeak
            title:              "ENVELOPE 2B peak"
            titleGanged:        "ENVELOPE 2 peak"

            n_sel:              n_env2B_peak_mod_sel
            p_sel:              p_env2B_peak_mod_sel
            n_dep:              n_env2B_peak_mod_dep
            p_dep:              p_env2B_peak_mod_dep
            }

        BarSliderParam {
            id:                 peakBModDepth

            col:                5
            colSpan:            2
            row:                2

            dimmed:             !usedB || !p_env2B_peak_mod_dep
            n:                  n_env2B_peak_mod_dep
            p:                  p_env2B_peak_mod_dep
            popup:              popupEnv2BPeak
            visible:            peakB.text !== "="
            }

        ChromaButtonCluster {
            id:                 attackB

            col:                4
            row:                3

            dimmed:             !usedB || !popup.p_conserv && !popup.p_time 
                                        && !popup.p_dep
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>attack</i>"
            popup:              popupEnv2BAttack
            clusType:           ["ea"]
            }

        ChromaPopupEnvAttack {
            id:                 popupEnv2BAttack
            twin:               popupEnv2AAttack
            title:              "ENVELOPE 2B attack"
            titleGanged:        "ENVELOPE 2 attack"

            n_time:             n_env2B_att_time
            p_time:             p_env2B_att_time
            n_conserv:          n_env2B_att_conserv
            p_conserv:          p_env2B_att_conserv
            n_sel:              n_env2B_att_mod_sel
            p_sel:              p_env2B_att_mod_sel
            n_dep:              n_env2B_att_mod_dep
            p_dep:              p_env2B_att_mod_dep
            }

        BarSliderParam {
            id:                 attackBTime

            col:                5
            colSpan:            2
            row:                3

            dimmed:             !usedB || !p_env2B_att_time
            n:                  n_env2B_att_time
            p:                  p_env2B_att_time
            popup:              popupEnv2BAttack
            visible:            attackB.text !== "="
            }

        ChromaButtonCluster {
            id:                 decayB

            col:                4
            row:                4

            dimmed:             !usedB 
                                    || popup.p_time == paramDefs(popup.n_time) 
                                    && !popup.p_dep && !popup.p_self
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>decay</i>"
            popup:              popupEnv2BDecay
            clusType:           ["ed"]
            }

        ChromaPopupEnvDecay {
            id:                 popupEnv2BDecay
            twin:               popupEnv2ADecay
            title:              "ENVELOPE 2B decay"
            titleGanged:        "ENVELOPE 2 decay"

            n_time:             n_env2B_dec_time
            p_time:             p_env2B_dec_time
            n_self:             n_env2B_dec_self_mod
            p_self:             p_env2B_dec_self_mod
            n_sel:              n_env2B_dec_mod_sel
            p_sel:              p_env2B_dec_mod_sel
            n_dep:              n_env2B_dec_mod_dep
            p_dep:              p_env2B_dec_mod_dep
            }

        BarSliderParam {
            id:                 decayBTime

            col:                5
            colSpan:            2
            row:                4

            dimmed:             !usedB || p_env2B_dec_time 
                                        == paramDefs(n_env2B_dec_time)
            n:                  n_env2B_dec_time
            p:                  p_env2B_dec_time
            popup:              popupEnv2BDecay
            visible:            decayB.text !== "="
            }

        ChromaButtonCluster {
            id:                 releaseB

            col:                4
            row:                5

            dimmed:             !usedB || !popup.p_time && !popup.p_sel
            used:               usedByEnvReleaseMod[popup.p_sel]
            param:              "<i>release</i>"
            popup:              popupEnv2BRelease
            clusType:           ["er"]
            }

        ChromaPopupEnvRelease {
            id:                 popupEnv2BRelease
            twin:               popupEnv2ARelease
            title:              "ENVELOPE 2B release"
            titleGanged:        "ENVELOPE 2 release"

            n_time:             n_env2B_rel_time
            p_time:             p_env2B_rel_time
            n_sel:              n_env2B_rel_mod
            p_sel:              p_env2B_rel_mod
            }

        BarSliderParam {
            id:                 releaseBTime

            col:                5
            colSpan:            2
            row:                5

            dimmed:             !usedB || !p_env2B_rel_time
            n:                  n_env2B_rel_time
            p:                  p_env2B_rel_time
            popup:              popupEnv2BRelease
            visible:            releaseB.text !== "="
            }
        }
    }
