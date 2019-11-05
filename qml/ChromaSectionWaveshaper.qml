import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {
    color:              colSection

    property int used:  mod1SelectA.used | mod2SelectA.used | mod1SelectB.used 
                                | mod2SelectB.used

    readonly property var popups: [
        popupWavAShape,
        popupWavBShape,
        popupWavAMod1,
        popupWavBMod1,
        popupWavAMod2,
        popupWavBMod2
        ]

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        columnSpacing:      uSpc
        rowSpacing:         uSpc

        SectionTitle {
            id:                 titleA

            text:               "WAVESHAPER A"
            }

        ChromaButtonCluster {
            id:                 shapeA

            col:                0
            row:                1

            param:              n_wavA_shape
            popup:              popupWavAShape
            clusType:           ["ws"]
            }

        ChromaPopupWaveShape {
            id:                 popupWavAShape
            twin:               popupWavBShape
            title:              "WAVESHAPER A shape"
            titleGanged:        "WAVESHAPER shape"

            n_shape:            n_wavA_shape
            p_shape:            p_wavA_shape
            n_width:            n_wavA_width
            p_width:            p_wavA_width
            }

        BarSliderParam {
            id:                 widthA

            col:                1
            colSpan:            2
            row:                1

            n:                  n_wavA_width
            p:                  p_wavA_width
            popup:              popupWavAShape
            strs:               p_wavA_shape < 2 ? str_100pct 
                                        : p_wavA_shape < 15 ? str_16cyc
                                        : null
            }

        ChromaButtonCluster {
            id:                 mod1SelectA

            col:                0
            row:                2

            dimmed:             !p_wavA_mod1_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_wavA_mod1_sel
            popup:              popupWavAMod1
            clusType:           ["mw"]
            }

        ChromaPopupMod {
            id:                 popupWavAMod1
            twin:               popupWavBMod1
            title:              "WAVESHAPER A mod 1"
            titleGanged:        "WAVESHAPER mod 1"
            page:               "/help/Waveshaper_mod_cluster"

            n_sel:              n_wavA_mod1_sel
            p_sel:              p_wavA_mod1_sel
            n_dep:              n_wavA_mod1_dep
            p_dep:              p_wavA_mod1_dep
            strs:               p_wavA_shape < 2 ? str_pm100pct 
                                        : p_wavA_shape < 15 ? str_pm16cyc
                                        : null
            }

        BarSliderParam {
            id:                 mod1DepthA

            col:                1
            colSpan:            2
            row:                2

            dimmed:             !p_wavA_mod1_dep
            n:                  n_wavA_mod1_dep
            p:                  p_wavA_mod1_dep
            popup:              popupWavAMod1
            strs:               p_wavA_shape < 2 ? str_pm100pct 
                                        : p_wavA_shape < 15 ? str_pm16cyc
                                        : null
            }

        ChromaButtonCluster {
            id:                 mod2SelectA

            col:                0
            row:                3

            dimmed:             !p_wavA_mod2_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_wavA_mod2_sel
            popup:              popupWavAMod2
            clusType:           ["mw"]
            }

        ChromaPopupMod {
            id:                 popupWavAMod2
            twin:               popupWavBMod2
            title:              "WAVESHAPER A mod 2"
            titleGanged:        "WAVESHAPER mod 2"
            page:               "/help/Waveshaper_mod_cluster"

            n_sel:              n_wavA_mod2_sel
            p_sel:              p_wavA_mod2_sel
            n_dep:              n_wavA_mod2_dep
            p_dep:              p_wavA_mod2_dep
            strs:               p_wavA_shape < 2 ? str_pm100pct
                                        : p_wavA_shape < 15 ? str_pm16cyc
                                        : null
            }

        BarSliderParam {
            id:                 mod2DepthA

            col:                1
            colSpan:            2
            row:                3

            dimmed:             !p_wavA_mod2_dep
            n:                  n_wavA_mod2_dep
            p:                  p_wavA_mod2_dep
            popup:              popupWavAMod2
            strs:               p_wavA_shape < 2 ? str_pm100pct 
                                        : p_wavA_shape < 15 ? str_pm16cyc
                                        : null
            }

        LayoutDummyV { col: 3 }

        SectionTitle {
            id:                 titleB

            col:                4

            text:               "WAVESHAPER B"
            }

        LayoutDummyH { col: 5 }

        ButtonHelp {
            col:                6
            page:               "/help/Waveshaper_section"
            }

        ChromaButtonCluster {
            id:                 shapeB

            col:                4
            row:                1

            param:              n_wavB_shape
            popup:              popupWavBShape
            clusType:           ["ws"]
            }

        ChromaPopupWaveShape {
            id:                 popupWavBShape
            twin:               popupWavAShape
            title:              "WAVESHAPER B shape"
            titleGanged:        "WAVESHAPER shape"

            n_shape:            n_wavB_shape
            p_shape:            p_wavB_shape
            n_width:            n_wavB_width
            p_width:            p_wavB_width
            }

        BarSliderParam {
            id:                 widthB

            col:                5
            colSpan:            2
            row:                1

            n:                  n_wavB_width
            p:                  p_wavB_width
            popup:              popupWavBShape
            strs:               p_wavB_shape < 2 ? str_100pct 
                                        : p_wavB_shape < 15 ? str_16cyc
                                        : null
            visible:            shapeB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod1SelectB

            col:                4
            row:                2

            dimmed:             !p_wavB_mod1_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_wavB_mod1_sel
            popup:              popupWavBMod1
            clusType:           ["mw"]
            }

        ChromaPopupMod {
            id:                 popupWavBMod1
            twin:               popupWavAMod1
            title:              "WAVESHAPER B mod 1"
            titleGanged:        "WAVESHAPER mod 1"
            page:               "/help/Waveshaper_mod_cluster"

            n_sel:              n_wavB_mod1_sel
            p_sel:              p_wavB_mod1_sel
            n_dep:              n_wavB_mod1_dep
            p_dep:              p_wavB_mod1_dep
            strs:               p_wavB_shape < 2 ? str_pm100pct 
                                        : p_wavB_shape < 15 ? str_pm16cyc
                                        : null
            }

        BarSliderParam {
            id:                 mod1DepthB

            col:                5
            colSpan:            2
            row:                2

            dimmed:             !p_wavB_mod1_dep
            n:                  n_wavB_mod1_dep
            p:                  p_wavB_mod1_dep
            popup:              popupWavBMod1
            strs:               p_wavB_shape < 2 ? str_pm100pct 
                                        : p_wavB_shape < 15 ? str_pm16cyc
                                        : null
            visible:            mod1SelectB.text !== "="
            }

        ChromaButtonCluster {
            id:                 mod2SelectB

            col:                4
            row:                3

            dimmed:             !p_wavB_mod2_dep
            used:               popup.p_dep && usedByModSelect[popup.p_sel]
            param:              n_wavB_mod2_sel
            popup:              popupWavBMod2
            clusType:           ["mw"]
            }

        ChromaPopupMod {
            id:                 popupWavBMod2
            twin:               popupWavAMod2
            title:              "WAVESHAPER B mod 2"
            titleGanged:        "WAVESHAPER mod 2"
            page:               "/help/Waveshaper_mod_cluster"

            n_sel:              n_wavB_mod2_sel
            p_sel:              p_wavB_mod2_sel
            n_dep:              n_wavB_mod2_dep
            p_dep:              p_wavB_mod2_dep
            strs:               p_wavB_shape < 2 ? str_pm100pct 
                                        : p_wavB_shape < 15 ? str_pm16cyc
                                        : null
            }

        BarSliderParam {
            id:                 mod2DepthB

            col:                5
            colSpan:            2
            row:                3

            dimmed:             !p_wavB_mod2_dep
            n:                  n_wavB_mod2_dep
            p:                  p_wavB_mod2_dep
            popup:              popupWavBMod2
            strs:               p_wavB_shape < 2 ? str_pm100pct 
                                        : p_wavB_shape < 15 ? str_pm16cyc
                                        : null
            visible:            mod2SelectB.text !== "="
            }
        }
    }
