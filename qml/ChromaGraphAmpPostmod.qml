import QtQuick 2.13
import QtQuick.Layouts 1.13
import "Util.js" as Util

Canvas {

    antialiasing:       true

    property int        d       // depth parameter value
    property int        s       // select parameter value

    property int        dummy:  requestPaint(), chr.p7

    width:              height * 2.1 / 1.1
    onWidthChanged:     requestPaint()
    onHeightChanged:    requestPaint()
    onDChanged:         requestPaint()
    onSChanged:         requestPaint()

    onPaint: {
        var cx = getContext("2d");

        // Use white background.
        cx.fillStyle = Qt.rgba(1, 1, 1, 1)

        // X = 0 to 2 with 0.1 margin, Y = 1 to 0 with 0.1 margin.
        cx.setTransform(width / 2.2, 0, 0, height / -1.2, 
                0.1 * width / 2.2, 1.1 * height / 1.2)

        // Use 2 pixel lines.
        cx.lineWidth = 2 * 1.2 / height

        // Decode select parameter to determine type of graph.
        switch (s) {

        // unipolar
        default: // 0 to 7, 10 to 11

            // Fill with white.
            cx.fillRect(-0.1, -0.1, 2.2, 1.2)

            // Draw 1-unit lines in green.
            cx.beginPath()
            cx.moveTo(0, 1)
            cx.lineTo(2, 1)
            cx.lineTo(2, 0)
            cx.strokeStyle = Qt.rgba(0, 1, 0.375, 1)
            cx.stroke()

            // Draw X and Y axis in blue.
            cx.beginPath()
            cx.moveTo(0, 1)
            cx.lineTo(0, 0)
            cx.lineTo(2, 0)
            cx.strokeStyle = Qt.rgba(0, 0.375, 1, 1)
            cx.stroke()

            // Draw graph in black.
            cx.beginPath()
            cx.moveTo(0, d < 0 ? 1 : d < 63 ? 1 - d / 64 : 0)
            cx.lineTo(2, d < 0 ? 1 + d / 64 : 1)
            cx.strokeStyle = Qt.rgba(0, 0, 0, 1)
            cx.stroke()
            break

        // bipolar
        case 8: case 12: case 13:

            // Fill with white.
            cx.fillRect(-0.1, -0.1, 2.2, 1.2)

            // Draw 1-unit lines in green.
            cx.beginPath()
            cx.moveTo(0, 1)
            cx.lineTo(2, 1)
            cx.moveTo(2, 0)
            cx.lineTo(2, 1)
            cx.strokeStyle = Qt.rgba(0, 1, 0.375, 1)
            cx.stroke()

            // Draw X and Y axis in blue.
            cx.beginPath()
            cx.moveTo(0, 0)
            cx.lineTo(2, 0)
            cx.moveTo(1, 0)
            cx.lineTo(1, 1)
            cx.strokeStyle = Qt.rgba(0, 0.375, 1, 1)
            cx.stroke()

            // Draw graph in black.
            cx.beginPath()
            if (d < -32) {
                cx.moveTo(0, 1)
                cx.lineTo(-64 / d, 0)
                cx.lineTo(2, 0)
                }
            else if (d < 0) {
                cx.moveTo(0, 1)
                cx.lineTo(2, 1 + d / 32)
                }
            else if (d < 32) {
                cx.moveTo(0, 1 - d / 32)
                cx.lineTo(2, 1)
                }
            else if (d < 63) {
                cx.moveTo(0, 0)
                cx.lineTo(2 - 64 / d, 0)
                cx.lineTo(2, 1)
                }
            else {
                cx.moveTo(0, 0)
                cx.lineTo(1, 0)
                cx.lineTo(2, 1)
                }
            cx.strokeStyle = Qt.rgba(0, 0, 0, 1)
            cx.stroke()
            break

        // pitch
        case 9:

            // Compute starting and ending note, make out-of-range areas gray.
            var x = (28 + chr.p7 * 12) / 64
            cx.fillRect(x, -0.1, 1, 1.2)
            cx.fillStyle = Qt.rgba(0.9, 0.9, 0.9, 1)
            cx.fillRect(-0.1, -0.1, x + 0.1, 1.2)
            cx.fillRect(x + 1, -0.1, 1.1 - x, 1.2)

            // Draw 1-unit lines in green.
            cx.beginPath()
            cx.moveTo(0, 0.5)
            cx.lineTo(2, 0.5)
            cx.moveTo(92 / 64, 0)
            cx.lineTo(92 / 64, 1)
            cx.strokeStyle = Qt.rgba(0, 1, 0.375, 1)
            cx.stroke()

            // Draw X and Y axis in blue.
            cx.beginPath()
            cx.moveTo(0, 0)
            cx.lineTo(2, 0)
            cx.moveTo(60 / 64, 0)
            cx.lineTo(60 / 64, 1)
            cx.strokeStyle = Qt.rgba(0, 0.375, 1, 1)
            cx.stroke()

            // Draw graph in black.
            cx.beginPath()
            if (d >= 23) {
                cx.moveTo(0, 0)
                if (d == 63) {
                    cx.lineTo(60 / 64, 0)
                    cx.lineTo(2, 68 / 64)
                    }
                else {
                    cx.lineTo(92 / 64 - 32 / d, 0)
                    cx.lineTo(2, 0.5 + d / 64 * 36 / 64)
                    }
                }
            else if (d > 0) {
                cx.moveTo(0, 0.5 - 1.5 * d / 64)
                cx.lineTo(2, 0.5 + d / 64 * 36 / 64)
                }
            else if (d >= -20) {
                cx.moveTo(0, 0.5 - 28 / 64 * d / 64)
                cx.lineTo(2, 0.5 + 100 / 64 * d / 64)
                }
            else {
                cx.moveTo(0, 0.5 - 28 / 64 * d / 64)
                cx.lineTo(28 / 64 - 0.5 * 64 / d, 0)
                cx.lineTo(2, 0)
                }
            cx.strokeStyle = Qt.rgba(0, 0, 0, 1)
            cx.stroke()
            break
            }
        }
    }
