import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection
    
    property int used:  controlVoiceStackCluster.used

    readonly property var popups: [
        popupPatch,
        popupSelectivity,
        popupTone,
        popupDetune,
        popupVoiceStack
        ]

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 controlTitle

            text:               "CONTROL"
            }

        ChromaButtonCluster {
            id:                 controlPatchCluster

            col:                0
            colSpan:            2
            row:                1

            param:              "<i>patch:</i> " + paramStrs(n_patch)[p_patch]
            popup:              popupPatch
            dimmed:             p_patch === 1
            }

        ChromaPopupPatch {
            id:                 popupPatch
            gangBit:            0
            }

        LayoutDummyH { col: 1 }

        ChromaButtonCluster {
            id:                 controlSelectivityCluster

            col:                2
            row:                1

            param:              "<i>selectivity</i>"
            popup:              popupSelectivity
            dimmed:             p_lever_modes | p_pedal_modes | p_ribbon_mode
            }

        ChromaPopupSelectivity {
            id:                 popupSelectivity
            gangBit:            0
            }

        LayoutDummyV { col: 3 }

        ButtonHelp {
            col:                6
            page:               "/help/Control_section"
            }

        ChromaButtonCluster {
            id:                 controlToneCluster

            col:                4
            row:                1

            param:              "<i>tone</i>"
            popup:              popupTone
            dimmed:             !p_bass_gain && !p_bass_freq 
                                    && !p_middle_gain && !p_middle_freq 
                                    && !p_middle_res && !p_treble_gain 
                                    && !p_treble_freq && !p_distortion
                                    && !p_reverb_room && !p_reverb_send
            }

        ChromaPopupTone {
            id:                 popupTone
            gangBit:            0
            }

        ChromaButtonCluster {
            id:                 controlDetuneCluster

            col:                5
            row:                1

            param:              "<i>detune</i>"
            popup:              popupDetune
            dimmed:             p_detune == defs[0][n_detune] 
                                    && p_detune_scale == defs[0][n_detune_scale]
                                    && p_tune_shift == defs[0][n_tune_shift]
            }

        ChromaPopupDetune {
            id:                 popupDetune
            gangBit:            0
            }

        ChromaButtonCluster {
            id:                 controlVoiceStackCluster

            col:                6
            row:                1

            param:              "<i>voice stack</i>"
            popup:              popupVoiceStack
            dimmed:             p_voice_count == defs[0][n_voice_count]
                                    && p_tune_spread == defs[0][n_tune_spread]
                                    && p_pan_spread == defs[0][n_pan_spread]
            used:               p_voice_count - 1 
                                    && usedByTuneSpread[p_tune_spread]
            }

        ChromaPopupVoiceStack {
            id:                 popupVoiceStack
            gangBit:            0
            }
        }
    }
