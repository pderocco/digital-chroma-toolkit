import QtQuick 2.13
import QtQuick.Layouts 1.13

Rectangle {

    Layout.column:          col
    Layout.columnSpan:      colSpan
    Layout.row:             row
    Layout.rowSpan:         rowSpan
    Layout.fillHeight:      true
    Layout.fillWidth:       true

    property int col:       0
    property int colSpan:   popup.ganged && (popup.num & 1) ? 3 : 1
    property int row:       0
    property int rowSpan:   1

    property var param              // parameter index, or string label
    property var popup              // ChromaPopup object
    property bool dimmed:   false   // true to dim the background
    property int used               // bitmap showing which ctrl gen used
    property var clusType:  []      // what parameters are dragged
    property alias text:    text.text

    radius:                 radBtn
    z:                      1       // to overlay slider, if ganged
    color:                  dimmed ? colGray 
                          : pressedSrc & used ? "red" 
                          : "white"

    Text {
        id:                     text
        color:                  dropPopup == popup ? colHilite : "black"
        font.pixelSize:         pixData
        lineHeight:             0.75
        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        wrapMode:               Text.WordWrap
        elide:                  Text.ElideRight
        anchors.fill:           parent
        text:                   popup.ganged && (popup.num & 1) ? "="
                                        : typeof param == "string" ? param 
                                        : paramStrs(param)[chr["p" + param]]
        }

    DropArea {
        anchors.fill:           parent
        keys:                   clusType        
        onEntered: {
            if (dragPopup && dragPopup != popup && keys.length)
                dropPopup = popup
            }
        onExited: {
            dropPopup = null
            }
        }

    MouseArea {
        id:                     mouse

        anchors.fill:           parent
        cursorShape:            Qt.PointingHandCursor
        drag.target:            dragMessage
        drag.threshold:         4
        drag.smoothed:          false

        property bool dragActive: drag.active

        onDragActiveChanged: {

            // If released on a compatible cluster button...
            if (!dragActive && dragPopup && dropPopup) {
                var nd = dropPopup.params
                var ns = dragPopup.params

                // See if dragging ganged A cluster to another A cluster.
                var a = dragPopup.ganged && !(dragPopup.num & 1) 
                                && !(dropPopup.num & 1)

                // If this is a copy...
                if (!dragReset) {

                    // Copy all parameters from drag to drop popup or pair.
                    for (var i = 0; i < nd.length; ++i)
                        if (i < ns.length) {
                            setSendParam(nd[i], dragParams[i])
                            if (a)
                                setSendParam(nd[i] + 128, dragParams[i])
                            }

                    // If dropped on twin, and not ganged, set ganged bit.
                    if (dragPopup.twin === dropPopup) {
                        if (!dragPopup.ganged)
                            gangsSet(gangs | dragPopup.gangBit)
                        }

                    // If ganged A dropped onto another A, gang it too.
                    if (a)
                        gangsSet(gangs | dropPopup.gangBit)

                    // Otherwise, if dropped onto a ganged cluster, ungang it.
                    else if (dropPopup.ganged)
                        gangsSet(gangs & ~dropPopup.gangBit)
                    }

                // If this is a swap...
                else {

                    // Swap all parameters.
                    for (var i = 0; i < nd.length; ++i)
                        if (i < ns.length) {
                            var v = chr["p" + nd[i]]
                            setSendParam(nd[i], dragParams[i])
                            setSendParam(ns[i], v)
                            if (a) {
                                v = chr["p" + (nd[i] + 128)]
                                setSendParam(nd[i] + 128, dragParams[i])
                                setSendParam(ns[i] + 128, v)
                                }
                            }

                    // If ganged A swapped with unganged A, swap gangs.
                    if (a && !dropPopup.ganged)
                        gangsSet(gangs & ~dragPopup.gangBit 
                                | dropPopup.gangBit)
                    }

                // Consume drag.
                dragPopup = dropPopup = null
                }

            // Hide or show drag message dot.
            dragMessage.Drag.active = dragActive && dragPopup
            dragMessage.visible = dragActive && dragPopup
            }

        onPressed: {

            // If draggable...
            if (clusType.length) {

                // Associate drag message dot with this cluster, show it.
                dragMessage.Drag.keys = clusType
                dragPopup = popup
                dragParams = popup.params.map(n => chr["p" + n])
                var p = mapToItem(dragMessage.parent, mouse.x, mouse.y)
                dragMessage.x = p.x - dragMessage.Drag.hotSpot.x
                dragMessage.y = p.y - dragMessage.Drag.hotSpot.y

                // Record that values have not been reset yet.
                dragReset = false
                }

            // Otherwise, nothing to drag.
            else
                dragPopup = null
            }

        onClicked: {

            // If clicked, show modal popup.
            if (text.text != "=")
                makeModal(popup)

            // If clicked on equals sign, ungang.
            else
                gangsSet(gangs & ~popup.gangBit)
            }

        onPressAndHold: {

            // Set default values. Also set twin if ganged.
            if (popup.ganged) {
                setSendDefaults(popup.params)
                setSendDefaults(chr.popups[popup.num ^ 1].params)
                }
            else
                setSendDefaults(popup.params)

            // Record that values were reset.
            dragReset = true
            }
        }
    }
