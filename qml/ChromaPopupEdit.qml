import QtQuick 2.13
import QtQuick.Layouts 1.13

ChromaPopup {
    id:                 root

    title:              "COMMON edit"

    params:             [ n_edit_mode, n_edit_number ]
    nRows:              2
    page:               "/help/Common_edit_cluster"

    ChromaPopupLayout {

        LabelCluster {
            col:                0
            row:                0

            text:               "parameter"
            }

        Rectangle {
            Layout.column:      1
            Layout.columnSpan:  5
            Layout.row:         0
            Layout.fillWidth:   true
            Layout.fillHeight:  true
            radius:             radBtn

            signal clicked()
            Component.onCompleted: mouse.clicked.connect(clicked)

            Text {
                text:                   str_edit_number[p_edit_number]
                                            .replace("*", "").replace("  ", " ")
                textFormat:             Text.PlainText
                font.pixelSize:         pixData
                horizontalAlignment:    Text.AlignHCenter
                verticalAlignment:      Text.AlignVCenter
                anchors.fill:           parent
                }

            MouseArea {
                id:                     mouse
                anchors.fill:           parent
                cursorShape:            Qt.PointingHandCursor

                onClicked: {
                    setSendParam(n_edit_number, lastEditNumber)
                    if (lastEditMode)
                        setSendParam(n_edit_mode, lastEditMode)
                    }
                onPressAndHold: {
                    setSendParam(n_edit_number, paramDefs(n_edit_number))
                    setSendParam(n_edit_mode, paramDefs(n_edit_mode))
                    }
                }
            }

        // --------------------------------------------------------------------
        LayoutDummyH { row: 1 }
        // --------------------------------------------------------------------

        LabelCluster {
            col:                0
            row:                2

            text:               "mode"
            }

        ButtonValueParam {
            col:                1
            row:                2

            n:                  n_edit_mode
            p:                  p_edit_mode
            newval:             1
            }

        ButtonValueParam {
            col:                2
            row:                2

            n:                  n_edit_mode
            p:                  p_edit_mode
            newval:             2
            }

        ButtonValueParam {
            col:                3
            row:                2

            n:                  n_edit_mode
            p:                  p_edit_mode
            newval:             3
            }

        LayoutDummyH { col: 4; row: 2 }
        }
    }
                