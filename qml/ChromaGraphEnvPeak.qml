import QtQuick 2.13
import QtQuick.Layouts 1.13
import "Util.js" as Util

Canvas {

    antialiasing:       true

    property int        d       // depth parameter value
    property int        s       // select parameter value

    onWidthChanged:     requestPaint()
    onHeightChanged:    requestPaint()
    onDChanged:         requestPaint()
    onSChanged:         requestPaint()

    onPaint: {
        var cx = getContext("2d");

        // Use 0 to 1 coordinates (up is positive), with 0.05 margin.
        cx.setTransform(0.9 * width, 0, 0, -0.9 * height, 
                0.05 * width, 0.95 * height)

        // Fill with white, use 1.5 pixel lines.
        cx.fillStyle = Qt.rgba(1, 1, 1, 1)
        cx.fillRect(-0.05, -0.05, 1.1, 1.1)
        cx.lineWidth = 1.5 / width

        // Draw 1-unit lines in green.
        cx.beginPath()
        cx.moveTo(0, 0.5)
        cx.lineTo(1, 0.5)
        cx.strokeStyle = Qt.rgba(0, 1, 0.375, 1)
        cx.stroke()
        cx.moveTo(1, 0)
        cx.lineTo(1, 1)
        cx.strokeStyle = Qt.rgba(0, 1, 0.375, 1)
        cx.stroke()

        // Draw X and Y axis in blue.
        cx.beginPath()
        cx.moveTo(0, 1)
        cx.lineTo(0, 0)
        cx.lineTo(1, 0)
        cx.strokeStyle = Qt.rgba(0, 0.375, 1, 1)
        cx.stroke()

        // Draw graph in black.
        cx.beginPath()
        var a = d === 63 ? 0.5 : d / 128 // -0.5 to +0.5
        if (s < 7) {                // regular curves
            cx.moveTo(0, 0.5 - a)
            cx.lineTo(0.5, 0.5 + a * [-1,-0.75,-0.5,-0.25,0,0.5,1][s])
            cx.lineTo(1, 0.5 + a)
            }
        else if (s < 12) {          // threshold curves
            var v = (12 - s) / 6
            if (a < 0) {
                cx.moveTo(0, 0.5)
                cx.lineTo(v, 0.5)
                cx.lineTo(v, 0.5 + a)
                cx.lineTo(1, 0.5 + a)
                }
            else {
                cx.moveTo(0, 0.5 - a)
                cx.lineTo(v, 0.5 - a)
                cx.lineTo(v, 0.5)
                cx.lineTo(1, 0.5)
                }
            }
        else {                      // pedals and levers
            if (a < 0) {
                cx.moveTo(0, 0.5)
                cx.lineTo(1, 0.5 + a)
                }
            else {
                cx.moveTo(0, 0.5 - a)
                cx.lineTo(1, 0.5)
                }
            }
        cx.strokeStyle = Qt.rgba(0, 0, 0, 1)
        cx.stroke()
        }
    }
