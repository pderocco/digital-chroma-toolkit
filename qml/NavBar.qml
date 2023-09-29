import QtQuick 2.13
import QtQuick.Layouts 1.13

Item {

    Rectangle {
        anchors.fill:       parent
        color:              "black"
        }

    GridLayout {

        anchors.fill:       parent
        anchors.margins:    uSpc
        rowSpacing:         uSpc

        // Clock, help button
        Rectangle {
            id:                 clock

            Layout.fillWidth:   true
            Layout.fillHeight:  true
            Layout.row:         0

            radius:             radBtn
            antialiasing:       true
            color:              "#6000A0"

            MouseArea {
                anchors.fill:       parent
                onClicked:          target.txClockGet()
                }

            Item {
                anchors.horizontalCenter:
                                    parent.horizontalCenter
                anchors.verticalCenter:
                                    parent.verticalCenter
                height:             time.height
                width:              time.width + ampm.width

                Text {
                    id:                 time
                    color:              "#80C0FF"
                    font.pixelSize:     clock.height * 0.6
                    textFormat:         Text.PlainText
                    }
                Text {
                    id:                 seconds
                    anchors.left:       time.right
                    anchors.baseline:   ampm.top
                    color:              "#80C0FF"
                    font.pixelSize:     clock.height * 0.25
                    textFormat:         Text.PlainText
                    }
                Text {
                    id:                 ampm
                    anchors.left:       time.right
                    anchors.baseline:   time.baseline
                    color:              "#80C0FF"
                    font.pixelSize:     clock.height * 0.25
                    textFormat:         Text.PlainText
                    }
                }

            Timer {
                running:            true
                interval:           1
                onTriggered: {
                    var t = new Date()
                    var s = (t.getHours() + 11) % 12 + 1
                    if (s < 10)
                        s = " " + s
                    else
                        s = "" + s
                    s += ":"
                    if (t.getMinutes() < 10)
                        s += "0"
                    s += t.getMinutes()
                    time.text = s
                    if (t.getSeconds() < 10)
                        s = ":0"
                    else
                        s = ":"
                    s += t.getSeconds()
                    seconds.text = s
                    if (t.getHours() < 12)
                        ampm.text = "am"
                    else
                        ampm.text = "pm"
                    interval = 1000 - t.getMilliseconds()
                    start()
                    }
                }

            Rectangle {
                color:              "black"
                x:                  parent.width - uHgt - uSpc
                width:              uHgt + 2 * uSpc
                y:                  -uSpc
                height:             uHgt + 2 * uSpc
                radius:             radBtn + uSpc

                ButtonHelp {
                    x:                  uSpc
                    width:              uHgt
                    y:                  uSpc
                    height:             uHgt
                    page:               "/help/Navigation_bar"
                    }
                }
            }

        // Program info button
        ButtonProgInfo {
            row:                1

            id:                 mainButton
            color:              "#4040C0"
            }

        // Connection button
        ButtonConnect {
            id:                 connectButton
            row:                2

            color:              "#4070A0"
            }

        Item {
            id:                 logo

            Layout.row:         3
            Layout.rowSpan:     2
            Layout.fillWidth:   true
            Layout.fillHeight:  true

            Image {
                anchors.fill:       parent
                source:             "../images/logo.png"
                fillMode:           Image.PreserveAspectFit
                mipmap:             true
                }

            MouseArea {
                anchors.fill:       parent
                cursorShape:        Qt.PointingHandCursor
                onClicked:          win.showMessage(`
<p><b><i>DIGITAL</i> CHROMA</b> &trade; Hereford Software Inc.</p>
<table>
  <tr><td width="70%">Toolkit:</td><td>${logo.dateOfToolkit()}</td></tr>
  <tr><td>Chroma firmware:</td><td>${logo.dateOf("main")}</td></tr>
  <tr><td>Panel firmware:</td><td>${logo.dateOf("panel")}</td></tr>
  <tr><td>Linux build:</td><td>${logo.dateOf("linux")}</td></tr>
</table>
<p>Send bug reports to <i>bugs@DigitalChroma.com</i>.</p>
`)
                }

            function dateOf(s) {
                var d = target.identification.match(s + "=(..)(..)(..)")
                return d ? "20" + d[1] + "/" + d[2] + "/" + d[3] : "&mdash;"
                }

            function dateOfToolkit() {
                return qtutil.buildYear + '/' 
                        + (100 + qtutil.buildMonth).toString().substring(1) + '/' 
                        + (100 + qtutil.buildDay).toString().substring(1)
                }
            }

        LayoutDummyV { row: 3 }

        // Programs button
        ButtonScreen {
            id:             programsButton
            row:            5

            text:           "PROGRAMS"
            color:          "#40A070"
            content:        "prg"
            }

        // Parameters button
        ButtonScreen {
            id:             soundButton
            row:            6

            text:           "EDITOR"
            color:          "#60C060"
            content:        "chr"
            }

        // Tools button
        ButtonScreen {
            id:             toolsButton
            row:            7

            text:           "TOOLS"
            color:          "#A0C020"
            content:        "tls"
            }

        // Help button
        ButtonScreen {
            id:             helpButton
            row:            8

            text:           "HELP"
            color:          colHelp
            content:        "hlp"

            onPressAndHold: hlp.goTo("help/index")
            }

        Item {
            Layout.row:         9
            Layout.fillWidth:   true
            Layout.fillHeight:  true

            Image {
                anchors.fill:       parent
                source:             "../images/wrenches.png"
                fillMode:           Image.PreserveAspectFit
                mipmap:             true
                }

            MouseArea {
                anchors.fill:       parent
                cursorShape:        qtutil.args.indexOf("/debug") > 0 
                                        ? Qt.PointingHandCursor : null
                enabled:            qtutil.args.indexOf("/debug") > 0
                onClicked:          debugPopup.visible = true
                }
            }

        // Redo button
        ButtonUndoRedo {
            id:             redoButton
            row:            10

            color:          "#E08020"
            textColor:      "black"
            label:          "Redo: "
            descr:          redoDescr

            MouseArea {
                anchors.fill:   parent
                cursorShape:    Qt.PointingHandCursor
                onClicked:      target.txUndoRedoRequest(2)
                }
            }

        // Undo button
        ButtonUndoRedo {
            id:             undoButton
            row:            11

            color:          "#FF3030"
            textColor:      "black"
            label:          "Undo: "
            descr:          undoDescr

            MouseArea {
                anchors.fill:   parent
                cursorShape:    Qt.PointingHandCursor
                onClicked:      target.txUndoRedoRequest(1)
                }
            }
        }
    }
