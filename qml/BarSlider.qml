import QtQuick 2.13
import QtQuick.Layouts 1.13
import "Util.js" as Util

Rectangle {
    id:                     root

    signal valueSet(int v)  // emitted when slider sets new value

    property int            value
    property int            defValue
    property int            maxValue
    property int            minValue
    property int            sigValue:   999
    property var            strs
    property alias          enabled:    mouseArea.enabled

    // Caller may override these
    property int            col:        0   // passed to Layout
    property int            colSpan:    1   // passed to Layout
    property int            row:        0   // passed to Layout
    property int            rowSpan:    1   // passed to Layout
    property bool           hilited:    false
    property bool           dimmed:     false
    property alias          fontSize:   text.font.pixelSize

    Layout.column:          col
    Layout.columnSpan:      colSpan
    Layout.row:             row
    Layout.rowSpan:         rowSpan
    Layout.fillHeight:      true
    Layout.fillWidth:       true
    color:                  dimmed ? Qt.darker("white", dim) : "white"
    
    // pixel dimensions
    property int            margin:     1 + (uSpc >> 2) // margin around bargraph
    property int            backlash:   40              // width of backlash zone
    property int            touchSlop:  2               // distance before drag recognized

    // parameter range
    property int            range:      maxValue - minValue

    property double         dragValue               // unconstrained value with fraction

    // position to value gains
    property double         loGain:                 // gain within backlash zone
            range / (width - 2 * margin) / 4
    property double         hiGain:                 // gain outside backlash zone
            range / (width - 2 * margin)

    // positions relative to left of MouseArea
    property double         touch                   // touch position
    property double         touchBacklash           // touch position with backlash

    // state
    property bool           held:       false       // true while mouse or touch is held
    property bool           dragging:   false       // true once dragging has started
    property bool           reset:      false       // true if reset to default

    function pressed(mouse) {
        if (!held && (mouse.buttons & Qt.LeftButton)) {
            held = true
            dragging = reset = false
            touch = touchBacklash = mouse.x
            dragValue = value
            timer.start()
            }
        }

    function released(mouse) {
        if (held && !(mouse.buttons & Qt.LeftButton)) {
            held = false

            // Make sure timer isn't running.
            timer.stop()

            // If not dragging or reset, and there is a "significant" value, 
            //  set and send it.
            if (!dragging && !reset) {
                if (sigValue != 999)
                    valueSet(value = sigValue)
                }
            }
        }

    function moved(x) {

        // Ignore if no horizontal motion.
        if (x == touch)
            return

        // Compute distance from center of backlash.
        var d = x - touchBacklash

        // If not dragging yet...
        if (!dragging) {

            // If outside touch slop range, move center of backlash.
            if (d > touchSlop)
                touchBacklash = x + touchSlop
            else if (d < -touchSlop)
                touchBacklash = x - touchSlop

            // Otherwise, ignore spurious motion.
            else
                return

            // Start dragging, stop timing long press.
            dragging = true
            timer.stop()

            // Recompute distance from center of backlash.
            d = x - touchBacklash
            }

        // If above backlash zone...
        if (d > backlash) {

            // Change drag value with low gain up to edge of backlash zone...
            dragValue += loGain * (touchBacklash + backlash - touch)

                    // and with high gain outside of backlash zone.
                    + hiGain * (d - backlash)

            // Move center of backlash zone.
            touchBacklash = x - backlash
            }

        // If below backlash zone...
        else if (d < -backlash) {

            // Change drag value with low gain down to edge of backlash zone...
            dragValue += loGain * (touchBacklash - backlash - touch)

                    // and with high gain outside of backlash zone.
                    + hiGain * (d + backlash)

            // Move center of backlash zone.
            touchBacklash = x + backlash
            }

        // If within backlash zone...
        else

            // Change drag value with low gain.
            dragValue += loGain * (x - touch)

        // Record new touch location.
        touch = x

        // Compute new range-limited value. If change, set and send.
        d = Math.round(dragValue < minValue ? minValue 
                : dragValue > maxValue ? maxValue 
                : dragValue)
        if (value != d)
            valueSet(value = d)
        }

    Timer {
        id:                 timer
        interval:           500
        running:            false
        repeat:             false
        onTriggered: {

            // Set default value.
            valueSet(value = defValue)

            // Record that value was reset.
            reset = true
            }
        }

    MouseArea {
        id:                 mouseArea
        anchors.fill:       parent
        cursorShape:        Qt.PointingHandCursor

        onPressed:          parent.pressed(mouse)
        onReleased:         parent.released(mouse)
        onPositionChanged:  parent.moved(mouse.x)
        }

    Rectangle {
        id:                 bar
        x:                  Math.floor(parent.margin 
                                + (((value < 0 ? value : minValue < 0 ? 0 : minValue) 
                                - minValue) * (parent.width - 2 * parent.margin)
                                + parent.range * 0.5) / parent.range)
        width:              Math.floor(parent.margin 
                                + (((value < 0 ? 0 : value) - minValue)
                                * (parent.width - 2 * parent.margin)
                                + parent.range * 0.5) / parent.range - x)
        y:                  parent.margin
        height:             parent.height - 2 * parent.margin
        color:              dimmed ? Qt.darker(colBar, 1.2) : colBar
        }

    Text {
        id:                 text
        anchors.fill:       parent
        textFormat:         Text.PlainText
        font.pixelSize:     pixData
        horizontalAlignment:Text.AlignHCenter
        verticalAlignment:  Text.AlignVCenter
        color:              hilited ? colHilite : "black"
        text:               strs && strs[value] || value
        }
    }
