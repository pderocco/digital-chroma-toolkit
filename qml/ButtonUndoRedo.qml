import QtQuick 2.13
import QtQuick.Layouts 1.13

ButtonAction {
    id:                 root

    property string label
    property string descr

    lineHeight:         1
    textFormat:         Text.RichText
    text:               "<i>" + label + "</i><br>" + descr
    pixelSize:          win.width * 0.015
    }
