import QtQuick 2.13

Canvas {

    antialiasing:           true

    property color color

    onColorChanged:         requestPaint()
    onWidthChanged:         requestPaint()
    onHeightChanged:        requestPaint()

    onPaint: {
        var cx = getContext("2d");

        // Define trapezoid with top narrower than bottom by half the height.
        cx.beginPath()
        cx.moveTo(0, height)
        cx.lineTo(height * 0.25, 0)
        cx.lineTo(width - height * 0.25, 0)
        cx.lineTo(width, height)
        cx.closePath()

        // Fill with color.
        cx.fillStyle = color
        cx.fill()
        }
    }
