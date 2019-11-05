import QtQuick 2.13
import QtQuick.Window 2.13
import HtmlResourceReader 1.0
import "Util.js" as Util

Rectangle {
    id:                 page

    property string     curDir:         "/"     // current URL directory
    property string     defaultUrl:     ""      // URL of error page
    property real       designWidth:    768     // unscaled width
    property string     htmlUrl:        ""      // current URL
    property string     link:                   // link URL hovered over
                            text.text, text.linkAt(mousex, mousey - text.y)
    property real       mousex:         0       // last mouse
    property real       mousey:         0       //  position
    property bool       moved:          false   // true if moved since press
    property int        navChg:         0       // incremented on navigation
    property var        pagesBack:      []      // list of text.y, url pairs
    property var        pagesFwd:       []      // list of text.y, url pairs
    property string     styleUrl:       ""      // URL of style sheet
    property alias      pageHeight:             // unscaled background height
                            background.height

    // For looking up navigation data:
    property string     backTitle:      backUrl && hlp.titles[baseOf(backUrl)]
    property string     backUrl:        navChg, pagesBack.length 
                                            ? pagesBack[pagesBack.length - 1]
                                            : ""
    property string     downBase:       hlp.downs[htmlBase] || ""
    property string     downTitle:      hlp.titles[downBase] || ""
    property string     downUrl:        "/help/" + downBase
    property string     fwdTitle:       fwdUrl && hlp.titles[baseOf(fwdUrl)]
    property string     fwdUrl:         navChg, pagesFwd.length 
                                            ? pagesFwd[pagesFwd.length - 1]
                                            : ""
    property string     htmlBase:       baseOf(htmlUrl)
    property string     nextBase:       hlp.nexts[htmlBase] || ""
    property string     nextTitle:      hlp.titles[nextBase] || ""
    property string     nextUrl:        "/help/" + nextBase
    property string     prevBase:       hlp.prevs[htmlBase] || ""
    property string     prevTitle:      hlp.titles[prevBase] || ""
    property string     prevUrl:        "/help/" + prevBase
    property string     title:          hlp.titles[htmlBase] || ""
    property string     upBase:         hlp.ups[htmlBase] || ""
    property string     upTitle:        hlp.titles[upBase] || ""
    property string     upUrl:          "/help/" + upBase

    signal              newTab(string url)      // emitted on link long press

    function absUrl(url) {                      // make absolute URL
        if (url[0] === "/")
            return url
        else
            return curDir + url
        }

    function baseOf(url) {                      // return URL name without path
        return url && url.slice(url.lastIndexOf("/") + 1)
        }

    function goBack() {                         // back to last page
        if (pagesBack.length) {
            pagesFwd.push(text.y)
            pagesFwd.push(htmlUrl)
            htmlUrl = pagesBack.pop()
            behavior.enabled = false
            text.y = pagesBack.pop()
            behavior.enabled = true
            ++navChg
            }
        }

    function goFwd() {                          // fwd to next page
        if (pagesFwd.length) {
            pagesBack.push(text.y)
            pagesBack.push(htmlUrl)
            htmlUrl = pagesFwd.pop()
            behavior.enabled = false
            text.y = pagesFwd.pop()
            behavior.enabled = true
            ++navChg
            }
        }

    function goTo(u) {                          // go to specific page
        if (u != htmlUrl) {
            pagesBack.push(text.y)
            pagesBack.push(htmlUrl)
            pagesFwd = []
            htmlUrl = u
            behavior.enabled = false
            text.y = 0
            behavior.enabled = true
            ++navChg
            }
        }

    function processHelpHtml(text) {
        return text.replace(/<!-- URL -->/, htmlUrl)
        }

    function scroll(d) {
        moved = true
        if (d < 0) {
            if (text.y + text.height > background.height)
                text.y = Math.max(background.height - text.height, text.y + d)
            }
        else if (d > 0) {
            if (text.y < 0)
                text.y = Math.min(0, text.y + d)
            }
        }

    onHtmlUrlChanged: {
        hlp.popup(null)
        curDir = htmlUrl.slice(0, htmlUrl.lastIndexOf("/") + 1)
        text.baseUrl = "qrc:" + curDir
        }

    Rectangle {
        id:                 background

        clip:               true
        transformOrigin:    Item.TopLeft
        x:                  4
        y:                  4
        scale:              (parent.width - 8) / designWidth
        width:              designWidth
        height:             (parent.height - 8) / scale

        onHeightChanged:    text.y = Math.min(0, Math.max(text.y, 
                                        height - text.height))

        Text {
            id:                 text

            width:              parent.width
            text:               reader.text.replace(/<!-- URL -->/, htmlUrl)
            textFormat:         Text.RichText
            wrapMode:           Text.Wrap

            Behavior on y {
                id:                 behavior
                NumberAnimation {
                    duration:           100
                    }
                }
            }

        MouseArea {
            id:                 mouse

            anchors.fill:       parent
            drag.target:        text
            drag.axis:          Drag.YAxis
            drag.minimumY:      Math.min(0, height - text.height)
            drag.maximumY:      0
            hoverEnabled:       true
            cursorShape:        link ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                if (!moved && link) {
                    if (link[0] === "_")
                        hlp.popup(absUrl(link), 
                                mapToItem(hlp, mouse.x, mouse.y))
                    else
                        goTo(absUrl(link))
                    }
                else
                    hlp.popup(null)
                }
            onPressed: {
                moved = false
                hlp.popup(null)
                }
            onPressAndHold: {
                if (moved)
                    hlp.popup(null)
                else if (link) {
                    if (link[0] === "_")
                        hlp.popup(absUrl(link), 
                                mapToItem(hlp, mouse.x, mouse.y))
                    else
                        newTab(absUrl(link))
                    }
                else if (text.height > background.height) {
                    hlp.popup(null)
                    moved = true
                    if (mouse.y < background.height * 0.5)
                        text.y = 0
                    else
                        text.y = background.height - text.height
                    }
                }
            onPositionChanged:  mousex = mouse.x, mousey = mouse.y
            onWheel:            scroll(wheel.angleDelta.y)
            }

        HtmlResourceReader {
            id:                 reader
            htmlUrl:            ":" + page.htmlUrl
            styleUrl:           ":" + page.styleUrl
            defaultUrl:         ":" + page.defaultUrl
            }
        }
    }
