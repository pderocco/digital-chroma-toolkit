import QtQuick 2.13
import QtQuick.Layouts 1.13

Item {

    property int col:       0
    property int row:       0
    property string page:   "/help/index"

    Layout.column:          col
    Layout.row:             row
    Layout.fillHeight:      true
    Layout.fillWidth:       true

    ButtonAction {
        color:                  colHelp
        x:                      parent.width - parent.height
        width:                  parent.height
        y:                      0
        height:                 parent.height
        text:                   "?"
        pixelSize:              height * 0.75

        onClicked:              hlp.goTo(page)
        onPressAndHold:         hlp.createNewTab(page)
        }
    }
