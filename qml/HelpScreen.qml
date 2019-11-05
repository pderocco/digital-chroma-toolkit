import QtQuick 2.13
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.13
import Utf8ResourceReader 1.0
import "Util.js" as Util

Item {
    id:                     root

    property Item currView: tabs.currentIndex < tabs.count 
                                    ? tabs.getTab(tabs.currentIndex).item 
                                    : null
    onCurrViewChanged:      popup(null)

    // From JSON files describing navigation and titles
    property var downs
    property var nexts
    property var prevs
    property var titles
    property var ups

    Shortcut {
        sequences:      [",", "<"]
        enabled:        contentSelect === "hlp"
        onActivated:    currView.goBack()
        }

    Shortcut {
        sequences:      [".",">"]
        enabled:        contentSelect === "hlp"
        onActivated:    currView.goFwd()
        }

    Shortcut {
        sequence:       "Left"
        enabled:        contentSelect === "hlp" && currView.prevTitle
        onActivated:    currView.goTo(currView.prevUrl)
        }

    Shortcut {
        sequence:       "Right"
        enabled:        contentSelect === "hlp" && currView.nextTitle
        onActivated:    currView.goTo(currView.nextUrl)
        }

    Shortcut {
        sequence:       "Up"
        enabled:        contentSelect === "hlp" && currView.upTitle
        onActivated:    currView.goTo(currView.upUrl)
        }

    Shortcut {
        sequence:       "Down"
        enabled:        contentSelect === "hlp" && currView.downTitle
        onActivated:    currView.goTo(currView.downUrl)
        }

    Shortcut {
        sequence:       "PgUp"
        enabled:        contentSelect === "hlp"
        onActivated:    currView.scroll(currView.pageHeight)
        }

    Shortcut {
        sequence:       "PgDown"
        enabled:        contentSelect === "hlp"
        onActivated:    currView.scroll(-currView.pageHeight)
        }

    Shortcut {
        sequence:       "Home"
        enabled:        contentSelect === "hlp"
        onActivated:    currView.scroll(9999)
        }

    Shortcut {
        sequence:       "End"
        enabled:        contentSelect === "hlp"
        onActivated:    currView.scroll(-9999)
        }

    Shortcut {
        sequence:       "Esc"
        enabled:        contentSelect === "hlp"
        onActivated:    hlp.popup(null)
        }

    function createNewTab(url) {
        popup(null)
        var tab = tabs.addTab("", htmlPage)
        tab.active = true
        tabs.currentIndex = tabs.count - 1
        tab.item.defaultUrl = "/help/error"
        tab.item.styleUrl = "/help/styles.css"
        tab.item.htmlUrl = url
        tab.title = Qt.binding(() => tab.item.title)
        contentSelect = "hlp"
        }

    function goTo(url) {
        popup(null)
        if (currView) {
            currView.goTo(url)
            contentSelect = "hlp"
            }
        }

    function popup(url) {
        if (url) {
            helpPopup.htmlUrl = url
            helpPopup.visible = true
            }
        else
            helpPopup.visible = false
        }

    HtmlPopup {
        id:                     helpPopup
        anchors.centerIn:       parent
        defaultUrl:             "/help/error"
        styleUrl:               "/help/styles.css"
        }

    Utf8ResourceReader {
        Component.onCompleted:  url = "help/down.json"
        onTextChanged:          downs = JSON.parse(text)
        }

    Utf8ResourceReader {
        Component.onCompleted:  url = "help/next.json"
        onTextChanged:          nexts = JSON.parse(text)
        }

    Utf8ResourceReader {
        Component.onCompleted:  url = "help/prev.json"
        onTextChanged:          prevs = JSON.parse(text)
        }

    Utf8ResourceReader {
        Component.onCompleted:  url = "help/titles.json"
        onTextChanged:          titles = JSON.parse(text)
        }

    Utf8ResourceReader {
        Component.onCompleted:  url = "help/up.json"
        onTextChanged:          ups = JSON.parse(text)
        }

    TabView {
        id:                     tabs
        x:                      uSpc
        width:                  parent.width - 2 * uSpc
        y:                      uSpc
        height:                 parent.height - 3 * uSpc - uHgt

        property Item tabrow:   null

        Component {
            id:                     htmlPage
            HtmlPage {
                onNewTab:               createNewTab(url)
                }
            }

        MouseArea {
            id:                 mouse
            enabled:            false ///
            x:                  parent.x
            y:                  parent.y + parent.height - uHgt
            width:              parent.width
            height:             uHgt
            }

        Component.onCompleted: {
            tabrow = Util.findChild(tabs, "tabrow")
            mouse.parent = tabrow
            createNewTab("/help/index")
            }

        style:                  TabViewStyle {
            frameOverlap:           -uSpc
            tabOverlap:             -uSpc
            tabsMovable:            false

            leftCorner:             Item {
                implicitWidth:          title.implicitWidth
                implicitHeight:         2 * uHgt + uSpc

                Text {
                    id:                     title
                    anchors.fill:           parent
                    color:                  "white"
                    text:                   "Help"
                    textFormat:             Text.PlainText
                    font.pixelSize:         titleHgt * 0.625
                    font.italic:            true
                    leftPadding:            uSpc
                    rightPadding:           2 * uSpc
                    verticalAlignment:      Text.AlignTop
                    }
                }

            rightCorner:            Item {
                implicitHeight:         2 * uHgt + uSpc

                ButtonAction {
                    id:                     backButton
                    anchors.rightMargin:    uSpc
                    anchors.right:          fwdButton.left
                    width:                  root.width * 0.3
                    height:                 uHgt
                    baseColor:              colHelp
                    enabled:                currView && currView.backUrl
                    text:                   currView.backTitle
                    textFormat:             Text.RichText
                    pixelSize:              height * 0.7

                    onClicked:              currView.goBack()
                    onPressAndHold:         createNewTab(currView.backUrl)

                    Text {
                        anchors.fill:           parent
                        horizontalAlignment:    Text.AlignLeft
                        verticalAlignment:      Text.AlignVCenter
                        font.pixelSize:         height * 0.7
                        font.weight:            Font.Bold
                        text:                   " <"
                        }

                    Text {
                        anchors.fill:           parent
                        horizontalAlignment:    Text.AlignRight
                        verticalAlignment:      Text.AlignVCenter
                        font.pixelSize:         height * 0.7
                        font.weight:            Font.Bold
                        text:                   "< "
                        }
                    }

                ButtonAction {
                    id:                     fwdButton
                    anchors.rightMargin:    uSpc
                    anchors.right:          helpButton.left
                    width:                  root.width * 0.3
                    height:                 uHgt
                    baseColor:              colHelp
                    enabled:                currView && currView.fwdUrl
                    text:                   currView.fwdTitle
                    textFormat:             Text.RichText
                    pixelSize:              height * 0.7

                    onClicked:              currView.goFwd()
                    onPressAndHold:         createNewTab(currView.fwdUrl)

                    Text {
                        anchors.fill:           parent
                        horizontalAlignment:    Text.AlignLeft
                        verticalAlignment:      Text.AlignVCenter
                        font.pixelSize:         height * 0.7
                        font.weight:            Font.Bold
                        text:                   " >"
                        }
                    Text {
                        anchors.fill:           parent
                        horizontalAlignment:    Text.AlignRight
                        verticalAlignment:      Text.AlignVCenter
                        font.pixelSize:         height * 0.7
                        font.weight:            Font.Bold
                        text:                   "> "
                        }
                    }

                ButtonHelp {
                    id:                     helpButton
                    anchors.right:          parent.right
                    width:                  uHgt
                    height:                 uHgt

                    page:                   "/help/Help_screen"
                    }
                }

            tab:                    Item {
                implicitWidth:          tab.width
                implicitHeight:         2 * uHgt + uSpc

                //MouseArea {
                //    anchors.fill:           parent
                //    onPressed:              null
                //    }

                Rectangle {
                    id:                     tab
                    color:                  styleData.selected ? colHelp 
                                                    : Qt.darker(colHelp, dim)
                    width:                  tabText.width + 2 * uSpc
                    height:                 uHgt
                    anchors.bottom:         parent.bottom
                    radius:                 radBtn

                    Text {
                        id:                     tabText
                        anchors.centerIn:       parent
                        text:                   styleData.title
                        textFormat:             Text.RichText
                        font.pixelSize:         uHgt * 0.7
                        MouseArea {
                            anchors.fill:           parent
                            cursorShape:            Qt.PointingHandCursor
                            onPressAndHold: {
                                tabs.removeTab(styleData.index)
                                if (!tabs.count)
                                    createNewTab("/help/index")
                                }
                            onClicked: {
                                tabs.currentIndex = styleData.index
                                }
                            }
                        }
                    }
                }
            }
        }

    RowLayout {
        x:                      uSpc
        width:                  parent.width - 2 * uSpc
        y:                      parent.height - uHgt - uSpc
        height:                 uHgt
        spacing:                uSpc

        ButtonAction {
            baseColor:              colHelp
            enabled:                currView && currView.prevTitle
            text:                   currView.prevTitle
            textFormat:             Text.RichText
            pixelSize:              height * 0.7

            onClicked:              currView.goTo(currView.prevUrl)
            onPressAndHold:         createNewTab(currView.prevUrl)

            Text {
                anchors.fill:           parent
                horizontalAlignment:    Text.AlignLeft
                verticalAlignment:      Text.AlignVCenter
                font.pixelSize:         height * 0.7
                text:                   " \u25C4"
                }

            Text {
                anchors.fill:           parent
                horizontalAlignment:    Text.AlignRight
                verticalAlignment:      Text.AlignVCenter
                font.pixelSize:         height * 0.7
                text:                   "\u25C4 "
                }
            }

        ButtonAction {
            baseColor:              colHelp
            enabled:                currView && currView.upTitle
            text:                   currView.upTitle
            textFormat:             Text.RichText
            pixelSize:              height * 0.7

            onClicked:              currView.goTo(currView.upUrl)
            onPressAndHold:         createNewTab(currView.upUrl)

            Text {
                anchors.fill:           parent
                horizontalAlignment:    Text.AlignLeft
                verticalAlignment:      Text.AlignVCenter
                font.pixelSize:         height * 0.7
                text:                   " \u25B2"
                }

            Text {
                anchors.fill:           parent
                horizontalAlignment:    Text.AlignRight
                verticalAlignment:      Text.AlignVCenter
                font.pixelSize:         height * 0.7
                text:                   "\u25B2 "
                }
            }

        ButtonAction {
            baseColor:              colHelp
            enabled:                currView && currView.nextTitle
            text:                   currView.nextTitle
            textFormat:             Text.RichText
            pixelSize:              height * 0.7

            onClicked:              currView.goTo(currView.nextUrl)
            onPressAndHold:         createNewTab(currView.nextUrl)

            Text {
                anchors.fill:           parent
                horizontalAlignment:    Text.AlignLeft
                verticalAlignment:      Text.AlignVCenter
                font.pixelSize:         height * 0.7
                text:                   " \u25BA"
                }

            Text {
                anchors.fill:           parent
                horizontalAlignment:    Text.AlignRight
                verticalAlignment:      Text.AlignVCenter
                font.pixelSize:         height * 0.7
                text:                   "\u25BA "
                }
            }
        }
    }
