import QtQuick 2.13
import QtQuick.Window 2.13
import HtmlResourceReader 1.0
import "Util.js" as Util

Rectangle {
    id:                 root
    color:              "#FFFFC0"
    border.width:       1
    border.color:       "black"
    width:              hlp.width / 2 + 2 * uSpc
    height:             background.height * background.scale + 2 * uSpc
    visible:            false
    z:                  1

    property string     absLink:                // absolute link URL hovered over
                            !link || link[0] === "/" ? link : curDir + link
    property string     curDir:                 // directory containing htmlUrl
                            htmlUrl.slice(0, htmlUrl.lastIndexOf("/") + 1)
    property string     defaultUrl:     ""      // URL of error popup
    property real       designWidth:    384     // unscaled width
    property var        history:        []      // popup chain history
    property string     htmlUrl:        ""      // current URL
    property string     link:                   // link URL hovered over
                            text.linkAt(mouse.mouseX, mouse.mouseY)
    property point      loc                     // desired location
    property string     styleUrl:       ""      // URL of style sheet

    onVisibleChanged:   if (!visible) history = []

    Rectangle {
        id:                 background
        color:              "#FFFFC0"

        transformOrigin:    Item.TopLeft
        x:                  uSpc
        y:                  uSpc
        scale:              hlp.width / 2 / designWidth
        width:              designWidth
        height:             text.height

        Text {
            id:                 text

            width:              designWidth
            text:               reader.text.replace(/<!-- URL -->/, htmlUrl)
            textFormat:         Text.RichText
            wrapMode:           Text.Wrap
            baseUrl:            "qrc:" + curDir
            }

        MouseArea {
            id:                 mouse

            anchors.fill:       parent
            hoverEnabled:       true
            cursorShape:        link ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                if (!link) {
                    if (history.length)
                        hlp.popup(history.pop())
                    else
                        hlp.popup(null)
                    }
                else if (link[0] === "_") {
                    history.push(htmlUrl)
                    hlp.popup(absLink)
                    }
                else
                    hlp.goTo(absLink)
                }
            onPressAndHold: {
                if (!link) {
                    if (history.length)
                        hlp.popup(history.pop())
                    else
                        hlp.popup(null)
                    }
                else if (link[0] === "_") {
                    history.push(htmlUrl)
                    hlp.popup(absLink)
                    }
                else
                    hlp.newTab(absLink)
                }
            }

        HtmlResourceReader {
            id:                 reader
            htmlUrl:            ":" + root.htmlUrl
            styleUrl:           ":" + root.styleUrl
            defaultUrl:         ":" + root.defaultUrl
            }
        }
    }
