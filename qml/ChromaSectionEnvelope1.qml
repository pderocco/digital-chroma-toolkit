import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection
    
    property int used:  peakA.used | attackA.used | decayA.used 
                                | releaseA.used | peakB.used | attackB.used 
                                | decayB.used | releaseB.used

    readonly property var popups: [
        popupEnv1APeak,
        popupEnv1BPeak,
        popupEnv1AAttack,
        popupEnv1BAttack,
        popupEnv1ADecay,
        popupEnv1BDecay,
        popupEnv1ARelease,
        popupEnv1BRelease
        ]

    property alias pressedA:    titleA.pressed
    property alias pressedB:    titleB.pressed
    property int usedA:         chr.used & 0x04
    property int usedB:         chr.used & 0x40

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 titleA
            cursor:             Qt.PointingHandCursor
            text:               "ENVELOPE 1A"
            }

        ChromaButtonCluster {
            id:                 peakA

            col:                0
            row:                1

            dimmed:             !usedA || !popup.p_dep
            used:               popup.p_dep && usedByEnvPeak[popup.p_sel]
            param:              n_env1A_peak_mod_sel
            popup:              popupEnv1APeak
            clusType:           ["et"]
            }

        ChromaPopupEnvPeak {
            id:                 popupEnv1APeak
            twin:               popupEnv1BPeak
            title:              "ENVELOPE 1A peak"
            titleGanged:        "ENVELOPE 1 peak"

            n_sel:              n_env1A_peak_mod_sel
            p_sel:              p_env1A_peak_mod_sel
            n_dep:              n_env1A_peak_mod_dep
            p_dep:              p_env1A_peak_mod_dep
            }

        BarSliderParam {
            id:                 peakADepth

            col:                1
            colSpan:            2
            row:                1

            dimmed:             !usedA || !p_env1A_peak_mod_dep
            n:                  n_env1A_peak_mod_dep
            p:                  p_env1A_peak_mod_dep
            popup:              popupEnv1APeak
            }

        ChromaButtonCluster {
            id:                 attackA

            col:                0
            row:                2

            dimmed:             !usedA || !popup.p_conserv && !popup.p_time 
                                        && !popup.p_dep
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>attack</i>"
            popup:              popupEnv1AAttack
            clusType:           ["ea"]
            }

        ChromaPopupEnvAttack {
            id:                 popupEnv1AAttack
            twin:               popupEnv1BAttack
            title:              "ENVELOPE 1A attack"
            titleGanged:        "ENVELOPE 1 attack"

            n_time:             n_env1A_att_time
            p_time:             p_env1A_att_time
            n_conserv:          n_env1A_att_conserv
            p_conserv:          p_env1A_att_conserv
            n_sel:              n_env1A_att_mod_sel
            p_sel:              p_env1A_att_mod_sel
            n_dep:              n_env1A_att_mod_dep
            p_dep:              p_env1A_att_mod_dep
            }

        BarSliderParam {
            id:                 attackATime

            col:                1
            colSpan:            2
            row:                2

            dimmed:             !usedA || !p_env1A_att_time
            n:                  n_env1A_att_time
            p:                  p_env1A_att_time
            popup:              popupEnv1AAttack
            }

        ChromaButtonCluster {
            id:                 decayA

            col:                0
            row:                3

            dimmed:             !usedA 
                                    || popup.p_time == paramDefs(popup.n_time) 
                                    && !popup.p_dep && !popup.p_self
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>decay</i>"
            popup:              popupEnv1ADecay
            clusType:           ["ed"]
            }

        ChromaPopupEnvDecay {
            id:                 popupEnv1ADecay
            twin:               popupEnv1BDecay
            title:              "ENVELOPE 1A decay"
            titleGanged:        "ENVELOPE 1 decay"

            n_time:             n_env1A_dec_time
            p_time:             p_env1A_dec_time
            n_self:             n_env1A_dec_self_mod
            p_self:             p_env1A_dec_self_mod
            n_sel:              n_env1A_dec_mod_sel
            p_sel:              p_env1A_dec_mod_sel
            n_dep:              n_env1A_dec_mod_dep
            p_dep:              p_env1A_dec_mod_dep
            }

        BarSliderParam {
            id:                 decayATime

            col:                1
            colSpan:            2
            row:                3

            dimmed:             !usedA || p_env1A_dec_time 
                                        == chr.paramDefs(n_env1A_dec_time)
            n:                  n_env1A_dec_time
            p:                  p_env1A_dec_time
            popup:              popupEnv1ADecay
            }

        ChromaButtonCluster {
            id:                 releaseA

            col:                0
            row:                4

            dimmed:             !usedA || !popup.p_time && !popup.p_sel
            used:               usedByEnvReleaseMod[popup.p_sel]
            param:              "<i>release</i>"
            popup:              popupEnv1ARelease
            clusType:           ["er"]
            }

        ChromaPopupEnvRelease {
            id:                 popupEnv1ARelease
            twin:               popupEnv1BRelease
            title:              "ENVELOPE 1A release"
            titleGanged:        "ENVELOPE 1 release"

            n_time:             n_env1A_rel_time
            p_time:             p_env1A_rel_time
            n_sel:              n_env1A_rel_mod
            p_sel:              p_env1A_rel_mod
            }

        BarSliderParam {
            id:                 releaseATime

            col:                1
            colSpan:            2
            row:                4

            dimmed:             !usedA || !p_env1A_rel_time
            n:                  n_env1A_rel_time
            p:                  p_env1A_rel_time
            popup:              popupEnv1ARelease
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB
            col:                4
            cursor:             Qt.PointingHandCursor
            text:               "ENVELOPE 1B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Envelope_sections"
            }

        ChromaButtonCluster {
            id:                 peakB

            col:                4
            row:                1

            dimmed:             !usedB || !popup.p_dep
            used:               popup.p_dep && usedByEnvPeak[popup.p_sel]
            param:              n_env1B_peak_mod_sel
            popup:              popupEnv1BPeak
            clusType:           ["et"]
            }

        ChromaPopupEnvPeak {
            id:                 popupEnv1BPeak
            twin:               popupEnv1APeak
            title:              "ENVELOPE 1B peak"
            titleGanged:        "ENVELOPE 1 peak"

            n_sel:              n_env1B_peak_mod_sel
            p_sel:              p_env1B_peak_mod_sel
            n_dep:              n_env1B_peak_mod_dep
            p_dep:              p_env1B_peak_mod_dep
            }

        BarSliderParam {
            id:                 peakBDepth

            col:                5
            colSpan:            2
            row:                1

            dimmed:             !usedB || !p_env1B_peak_mod_dep
            n:                  n_env1B_peak_mod_dep
            p:                  p_env1B_peak_mod_dep
            popup:              popupEnv1BPeak
            visible:            peakB.text !== "="
            }

        ChromaButtonCluster {
            id:                 attackB

            col:                4
            row:                2

            dimmed:             !usedB || !popup.p_conserv && !popup.p_time 
                                        && !popup.p_dep
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>attack</i>"
            popup:              popupEnv1BAttack
            clusType:           ["ea"]
            }

        ChromaPopupEnvAttack {
            id:                 popupEnv1BAttack
            twin:               popupEnv1AAttack
            title:              "ENVELOPE 1B attack"
            titleGanged:        "ENVELOPE 1 attack"

            n_time:             n_env1B_att_time
            p_time:             p_env1B_att_time
            n_conserv:          n_env1B_att_conserv
            p_conserv:          p_env1B_att_conserv
            n_sel:              n_env1B_att_mod_sel
            p_sel:              p_env1B_att_mod_sel
            n_dep:              n_env1B_att_mod_dep
            p_dep:              p_env1B_att_mod_dep
            }

        BarSliderParam {
            id:                 attackBTime

            col:                5
            colSpan:            2
            row:                2

            dimmed:             !usedB || !p_env1B_att_time
            n:                  n_env1B_att_time
            p:                  p_env1B_att_time
            popup:              popupEnv1BAttack
            visible:            attackB.text !== "="
            }

        ChromaButtonCluster {
            id:                 decayB

            col:                4
            row:                3

            dimmed:             !usedB 
                                    || popup.p_time == paramDefs(popup.n_time) 
                                    && !popup.p_dep && !popup.p_self
            used:               popup.p_dep && usedByEnvRateMod[popup.p_sel]
            param:              "<i>decay</i>"
            popup:              popupEnv1BDecay
            clusType:           ["ed"]
            }

        ChromaPopupEnvDecay {
            id:                 popupEnv1BDecay
            twin:               popupEnv1ADecay
            title:              "ENVELOPE 1B decay"
            titleGanged:        "ENVELOPE 1 decay"

            n_time:             n_env1B_dec_time
            p_time:             p_env1B_dec_time
            n_self:             n_env1B_dec_self_mod
            p_self:             p_env1B_dec_self_mod
            n_sel:              n_env1B_dec_mod_sel
            p_sel:              p_env1B_dec_mod_sel
            n_dep:              n_env1B_dec_mod_dep
            p_dep:              p_env1B_dec_mod_dep
            }

        BarSliderParam {
            id:                 decayBTime

            col:                5
            colSpan:            2
            row:                3

            dimmed:             !usedB || p_env1B_dec_time 
                                        == chr.paramDefs(n_env1B_dec_time)
            n:                  n_env1B_dec_time
            p:                  p_env1B_dec_time
            popup:              popupEnv1BDecay
            visible:            decayB.text !== "="
            }

        ChromaButtonCluster {
            id:                 releaseB

            col:                4
            row:                4

            dimmed:             !usedB || !popup.p_time && !popup.p_sel
            used:               usedByEnvReleaseMod[popup.p_sel]
            param:              "<i>release</i>"
            popup:              popupEnv1BRelease
            clusType:           ["er"]
            }

        ChromaPopupEnvRelease {
            id:                 popupEnv1BRelease
            twin:               popupEnv1ARelease
            title:              "ENVELOPE 1B release"
            titleGanged:        "ENVELOPE 1 release"

            n_time:             n_env1B_rel_time
            p_time:             p_env1B_rel_time
            n_sel:              n_env1B_rel_mod
            p_sel:              p_env1B_rel_mod
            }

        BarSliderParam {
            id:                 releaseBTime

            col:                5
            colSpan:            2
            row:                4

            dimmed:             !usedB || !p_env1B_rel_time
            n:                  n_env1B_rel_time
            p:                  p_env1B_rel_time
            popup:              popupEnv1BRelease
            visible:            releaseB.text !== "="
            }
        }
    }
