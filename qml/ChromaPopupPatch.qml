import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    title:              "CONTROL patch"

    nRows:              9
    nParams:            0
    page:               "/help/Control_patch_cluster"

    ChromaPopupLayout {

        Rectangle {

            color:                  "white"

            Layout.column:          0
            Layout.columnSpan:      6
            Layout.row:             0
            Layout.rowSpan:         4
            Layout.fillHeight:      true
            Layout.fillWidth:       true

            Text {
                id:                     text
                x:                      0
                width:                  parent.width
                y:                      0
                height:                 uHgt

                textFormat:             Text.PlainText
                font.pixelSize:         pixData
                horizontalAlignment:    Text.AlignHCenter
                verticalAlignment:      Text.AlignVCenter
                text:                   str_patch[p_patch]
                }
                    
            Image {
                x:                      2
                width:                  parent.width - 4
                y:                      uHgt
                height:                 3 * uHgt + 3 * uSpc

                source:                 "../images/patch" + p_patch + ".png"
                fillMode:               Image.PreserveAspectFit
                mipmap:                 true
                }
            }

        LayoutDummyV { row: 1 }
        LayoutDummyV { row: 3 }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                    1
            row:                    4

            text:                   "none"
            hAlign:                 Text.AlignHCenter
            vAlign:                 Text.AlignBottom
            }

        LabelCluster {
            col:                    2
            row:                    4

            text:                   "sync"
            hAlign:                 Text.AlignHCenter
            vAlign:                 Text.AlignBottom
            }

        LabelCluster {
            col:                    3
            row:                    4

            text:                   "ring mod"
            hAlign:                 Text.AlignHCenter
            vAlign:                 Text.AlignBottom
            }

        LabelCluster {
            col:                    4
            row:                    4

            text:                   "multiply"
            hAlign:                 Text.AlignHCenter
            vAlign:                 Text.AlignBottom
            }

        LabelCluster {
            col:                    5
            row:                    4

            text:                   "filter fm"
            hAlign:                 Text.AlignHCenter
            vAlign:                 Text.AlignBottom
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                    0
            row:                    5

            text:                   "independent"
            }

        ButtonValueParam {
            col:                    1
            row:                    5

            n:                      n_patch
            p:                      p_patch
            newval:                 1
            text:                   "1"
            }

        ButtonValueParam {
            col:                    2
            row:                    5

            n:                      n_patch
            p:                      p_patch
            newval:                 2
            text:                   "2"
            }

        ButtonValueParam {
            col:                    3
            row:                    5

            n:                      n_patch
            p:                      p_patch
            newval:                 3
            text:                   "3"
            }

        ButtonValueParam {
            col:                    4
            row:                    5

            n:                      n_patch
            p:                      p_patch
            newval:                 4
            text:                   "4"
            }

        ButtonValueParam {
            col:                    5
            row:                    5

            n:                      n_patch
            p:                      p_patch
            newval:                 5
            text:                   "5"
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                    0
            row:                    6

            text:                   "parallel filters"
            }

        ButtonValueParam {
            col:                    1
            row:                    6

            n:                      n_patch
            p:                      p_patch
            newval:                 6
            text:                   "6"
            }

        ButtonValueParam {
            col:                    2
            row:                    6

            n:                      n_patch
            p:                      p_patch
            newval:                 7
            text:                   "7"
            }

        ButtonValueParam {
            col:                    3
            row:                    6

            n:                      n_patch
            p:                      p_patch
            newval:                 8
            text:                   "8"
            }

        ButtonValueParam {
            col:                    4
            row:                    6

            n:                      n_patch
            p:                      p_patch
            newval:                 9
            text:                   "9"
            }

        ButtonValueParam {
            col:                    5
            row:                    6

            n:                      n_patch
            p:                      p_patch
            newval:                 10
            text:                   "10"
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                    0
            row:                    7

            text:                   "series filters"
            }

        ButtonValueParam {
            col:                    1
            row:                    7

            n:                      n_patch
            p:                      p_patch
            newval:                 11
            text:                   "11"
            }

        ButtonValueParam {
            col:                    2
            row:                    7

            n:                      n_patch
            p:                      p_patch
            newval:                 12
            text:                   "12"
            }

        ButtonValueParam {
            col:                    3
            row:                    7

            n:                      n_patch
            p:                      p_patch
            newval:                 13
            text:                   "13"
            }

        ButtonValueParam {
            col:                    4
            row:                    7

            n:                      n_patch
            p:                      p_patch
            newval:                 14
            text:                   "14"
            }

        ButtonValueParam {
            col:                    5
            row:                    7

            n:                      n_patch
            p:                      p_patch
            newval:                 15
            text:                   "15"
            }

        // --------------------------------------------------------------------

        LabelCluster {
            col:                    0
            row:                    8

            text:                   "vari-mix filters"
            }

        ButtonValueParam {
            col:                    1
            row:                    8

            n:                      n_patch
            p:                      p_patch
            newval:                 16
            text:                   "16"
            }

        ButtonValueParam {
            col:                    2
            row:                    8

            n:                      n_patch
            p:                      p_patch
            newval:                 17
            text:                   "17"
            }

        ButtonValueParam {
            col:                    3
            row:                    8

            n:                      n_patch
            p:                      p_patch
            newval:                 18
            text:                   "18"
            }

        ButtonValueParam {
            col:                    4
            row:                    8

            n:                      n_patch
            p:                      p_patch
            newval:                 19
            text:                   "19"
            }
        }
    }
