import QtQuick 2.13
import QtQuick.Layouts 1.13

ButtonAction {

    property string         content

    textColor:              contentSelect === content ? "white" : "black"
    pixelSize:              win.width * 0.025
    italic:                 true

    onClicked:              contentSelect = content
    }
