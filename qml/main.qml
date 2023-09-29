import QtQuick 2.13
import QtQuick.Window 2.13
import Qt.labs.settings 1.0
import QtUtil 1.0
import "Util.js" as Util

Window {
    id:             app
    title:          "Digital Chroma Toolkit"
    color:          "#202020"
    visible:        true
    visibility:     config.window || Window.Windowed
    width:          config.width || 1280
    height:         config.height || 720
    minimumWidth:   960
    minimumHeight:  540

    property int    debug:  config.debug || 0
    // 1 main onRx
    // 2 TargetEmulator input functions
    // 4 schedule
    // 8 TargetInterface param thinning logic
    // 16 gangs and gangsOk
    // 32 TargetInterface tx functions
    // 64 display sysex contents instead of length
    // 128 changes in state, portName, identification
    // 256 browzer zoom

    // set to choose which content to show
    property string contentSelect:      "hlp"

    QtUtil {
        id:                 qtutil
        }

    // win -- the real background, aspect ratio limited to 16:8 to 16:10    
    Rectangle {
        id:                 win
        color:              "black"
        width:              Math.round(Math.min(parent.width, parent.height * 16 / 8))
        height:             Math.round(Math.min(parent.height, parent.width * 10 / 16))
        anchors.centerIn:   parent

        // nav -- navigation bar filling left 20% of the background
        NavBar {
            id:     nav
            width:  Math.round(parent.width * 0.2)
            anchors {
                left:   parent.left
                top:    parent.top
                bottom: parent.bottom
                }
            }

        // content -- content area
        Item {
            id: content
            anchors {
                left:   nav.right
                right:  parent.right
                top:    parent.top
                bottom: parent.bottom
                }

            // prg -- Programs Screen content
            ProgramsScreen {
                id:             prg
                anchors.fill:   content
                visible:        contentSelect === "prg"
                }

            // chr -- Chroma editor content
            ChromaEditor {
                id:             chr
                anchors.fill:   content
                visible:        contentSelect === "chr"
                }

            // tls -- Tools content
            ToolsScreen {
                id:             tls
                anchors.fill:   content
                visible:        contentSelect === "tls"
                }

            // hlp -- Help screen content
            HelpScreen {
                id:             hlp
                anchors.fill:   content
                visible:        contentSelect === "hlp"
                }
            }

        // Debug checkbox popup
        PopupDebug {
            id:             debugPopup
            }

        // General message popup
        PopupMessage {
            id:             popupMessage
            }

        function showMessage(m) {
            popupMessage.text = m
            popupMessage.visible = true
            }

        // Keyboard shortcuts
        Shortcut {
            sequence:       "L"     // load
            onActivated:    target.txProgLoad(currBank, currNumber)
            }
        Shortcut {
            sequence:       "S"     // store
            onActivated:    target.txProgStore(currBank, currNumber)
            }
        Shortcut {
            sequence:       "X"     // exchange
            onActivated:    target.txProgExchange(currBank, currNumber)
            }
        Shortcut {
            sequence:       "P"     // PROGRAMS
            onActivated:    contentSelect = "prg"
            }
        Shortcut {
            sequence:       "E"     // PARAMETERS
            onActivated:    contentSelect = "chr"
            }
        Shortcut {
            sequence:       "T"     // TOOLS
            onActivated:    contentSelect = "tls"
            }
        Shortcut {
            sequence:       "H"     // HELP
            onActivated:    contentSelect = "hlp"
            }
        Shortcut {
            sequence:       "R"     // redo
            onActivated:    target.txUndoRedoRequest(2)
            }
        Shortcut {
            sequence:       "U"     // undo
            onActivated:    target.txUndoRedoRequest(1)
            }
        }

    // PERSISTENT SETTINGS ----------------------------------------------------

    property int visibility1
    onVisibilityChanged: {
        if (visibility !== Window.Hidden) {
            visibility1 = visibility
            if (visibility === Window.Maximized 
                    || visibility === Window.FullScreen) {
                width1 = width2
                height1 = height2
                }
            }
        }

    property int width1
    property int width2
    onWidthChanged: {
        width2 = width1
        width1 = width
        }

    property int height1
    property int height2
    onHeightChanged: {
        height2 = height1
        height1 = height
        }

    Settings {
        id:             config
        property int    window
        property int    width
        property int    height
        property string port
        property int    debug
        property url    brDir
        property url    chrDir
        property url    syxDir
        property url    wavDir
        property bool   lever1Inv
        property bool   lever1Sel
        property bool   lever2Inv
        property bool   lever2Sel
        property int    tuneShift
        property int    voiceCount
        property int    panSpread
        property int    tuneSpread

        Component.onCompleted: {
            target.setPortName(config.port ? config.port : "Demonstrator")
            }
        }

    Component.onDestruction: {
        config.window = visibility1 
        config.width  = width1
        config.height = height1
        config.port   = target.portName
        config.debug  = debug
        }

    // DRAG MESSAGE -----------------------------------------------------------

    Rectangle {
        id:                     dragMessage

        radius:                 uHgt / 2
        width:                  2 * radius
        height:                 2 * radius
        visible:                false
        color:                  colDrag

        Drag.keys:              []
        Drag.dragType:          Drag.Internal
        Drag.hotSpot.x:         radius
        Drag.hotSpot.y:         radius
        }

    // LAYOUT PARAMETERS ------------------------------------------------------

    // universal spacing property based on background height
    readonly property int   uSpc:       win.height * 0.007

    // standard colors
    readonly property color colSection: "#505050"   // section background
    readonly property color colPopup:   "#303030"   // popup background
    readonly property color colBar:     "#FFA500"   // BarSlider bar
    readonly property color colHilite:  "#FF0080"   // hilited text
    readonly property color colHelp:    "#E0E000"   // help button
    readonly property color colDrag:    "#FF8040"   // dragMessage
    readonly property color colUnmod:   "#A0FF80"   // unmodified program
    readonly property color colMod:     "#FFBCBC"   // modified program
    readonly property color colScr:     "#FFFF80"   // scratch program
    readonly property color colGray:    "#C0C0C0"   // dimmed controls
    readonly property color colLink:    "blue"      // link annunciator
    readonly property color colSeq:     "green"     // sequence annunciator

    // unit height (taken from Chroma editor)
    readonly property real  uHgt:       (win.height - 33 * uSpc) / 24

    // button radius
    readonly property real  radBtn:     uHgt / 4

    // title height
    readonly property int   titleHgt:   win.height * 0.08

    // pixel sizes
    readonly property real  pixData:    win.width * 0.008
    readonly property real  pixTitle:   win.height * 0.028

    // dim -- how much to dim inactive controls by
    readonly property real  dim:        1.4

    // BACKUP/RESTORE MONITORING FUNCTIONS ------------------------------------

    property var    backupMonitor:  null
    property var    restoreMonitor: null

    // PROGRAM STATE ----------------------------------------------------------

    // current program
    property var    currBank:   0       // 0-based program bank
    property var    currNumber: 0       // 0-based program number
    property int    currNum:    currBank * 100 + currNumber + 101
    property var    currProg:   null    // current program object

    // link and sequence parameters from current arch
    property int    currLinkNumber: arch.p_link_number
    property int    currLinkBank:   arch.p_link_bank
    property int    currLinkMode:   arch.p_link_mode
    property int    currSeqNumber:  arch.p_sequence_number
    property int    currSeqBank:    arch.p_sequence_bank

    // 1- to 3-digit link program number, even in No Link mode
    property int    currLinkNum:    currLinkNumber 
                                        && currLinkNumber + 100 * currLinkBank

    // 1- to 3-digit sequence program number
    property int    currSeqNum:     currSeqNumber 
                                        && currSeqNumber + 100 * currSeqBank

    // 3-digit link program number
    property int    linkNum:        currLinkNumber &&
                                        (currLinkBank || currBank + 1) * 100 
                                        + currLinkNumber

    // 3-digit sequence program number
    property int    seqNum:         currSeqNumber &&
                                        (currSeqBank || currBank + 1) * 100 
                                        + currSeqNumber

    // temporary program stash area
    property var    stash:      null    // sysex representing stashed program
    property int    stashBank:  0       // 0-based stash bank
    property int    stashNumber:0       // 0-based stash number

    // stored program metadata (program objects without parameters)
    property var    p101:       null
    property var    p102:       null
    property var    p103:       null
    property var    p104:       null
    property var    p105:       null
    property var    p106:       null
    property var    p107:       null
    property var    p108:       null
    property var    p109:       null
    property var    p110:       null
    property var    p111:       null
    property var    p112:       null
    property var    p113:       null
    property var    p114:       null
    property var    p115:       null
    property var    p116:       null
    property var    p117:       null
    property var    p118:       null
    property var    p119:       null
    property var    p120:       null
    property var    p121:       null
    property var    p122:       null
    property var    p123:       null
    property var    p124:       null
    property var    p125:       null
    property var    p126:       null
    property var    p127:       null
    property var    p128:       null
    property var    p129:       null
    property var    p130:       null
    property var    p131:       null
    property var    p132:       null
    property var    p133:       null
    property var    p134:       null
    property var    p135:       null
    property var    p136:       null
    property var    p137:       null
    property var    p138:       null
    property var    p139:       null
    property var    p140:       null
    property var    p141:       null
    property var    p142:       null
    property var    p143:       null
    property var    p144:       null
    property var    p145:       null
    property var    p146:       null
    property var    p147:       null
    property var    p148:       null
    property var    p149:       null
    property var    p150:       null
    property var    p201:       null
    property var    p202:       null
    property var    p203:       null
    property var    p204:       null
    property var    p205:       null
    property var    p206:       null
    property var    p207:       null
    property var    p208:       null
    property var    p209:       null
    property var    p210:       null
    property var    p211:       null
    property var    p212:       null
    property var    p213:       null
    property var    p214:       null
    property var    p215:       null
    property var    p216:       null
    property var    p217:       null
    property var    p218:       null
    property var    p219:       null
    property var    p220:       null
    property var    p221:       null
    property var    p222:       null
    property var    p223:       null
    property var    p224:       null
    property var    p225:       null
    property var    p226:       null
    property var    p227:       null
    property var    p228:       null
    property var    p229:       null
    property var    p230:       null
    property var    p231:       null
    property var    p232:       null
    property var    p233:       null
    property var    p234:       null
    property var    p235:       null
    property var    p236:       null
    property var    p237:       null
    property var    p238:       null
    property var    p239:       null
    property var    p240:       null
    property var    p241:       null
    property var    p242:       null
    property var    p243:       null
    property var    p244:       null
    property var    p245:       null
    property var    p246:       null
    property var    p247:       null
    property var    p248:       null
    property var    p249:       null
    property var    p250:       null
    property var    p301:       null
    property var    p302:       null
    property var    p303:       null
    property var    p304:       null
    property var    p305:       null
    property var    p306:       null
    property var    p307:       null
    property var    p308:       null
    property var    p309:       null
    property var    p310:       null
    property var    p311:       null
    property var    p312:       null
    property var    p313:       null
    property var    p314:       null
    property var    p315:       null
    property var    p316:       null
    property var    p317:       null
    property var    p318:       null
    property var    p319:       null
    property var    p320:       null
    property var    p321:       null
    property var    p322:       null
    property var    p323:       null
    property var    p324:       null
    property var    p325:       null
    property var    p326:       null
    property var    p327:       null
    property var    p328:       null
    property var    p329:       null
    property var    p330:       null
    property var    p331:       null
    property var    p332:       null
    property var    p333:       null
    property var    p334:       null
    property var    p335:       null
    property var    p336:       null
    property var    p337:       null
    property var    p338:       null
    property var    p339:       null
    property var    p340:       null
    property var    p341:       null
    property var    p342:       null
    property var    p343:       null
    property var    p344:       null
    property var    p345:       null
    property var    p346:       null
    property var    p347:       null
    property var    p348:       null
    property var    p349:       null
    property var    p350:       null
    property var    p401:       null
    property var    p402:       null
    property var    p403:       null
    property var    p404:       null
    property var    p405:       null
    property var    p406:       null
    property var    p407:       null
    property var    p408:       null
    property var    p409:       null
    property var    p410:       null
    property var    p411:       null
    property var    p412:       null
    property var    p413:       null
    property var    p414:       null
    property var    p415:       null
    property var    p416:       null
    property var    p417:       null
    property var    p418:       null
    property var    p419:       null
    property var    p420:       null
    property var    p421:       null
    property var    p422:       null
    property var    p423:       null
    property var    p424:       null
    property var    p425:       null
    property var    p426:       null
    property var    p427:       null
    property var    p428:       null
    property var    p429:       null
    property var    p430:       null
    property var    p431:       null
    property var    p432:       null
    property var    p433:       null
    property var    p434:       null
    property var    p435:       null
    property var    p436:       null
    property var    p437:       null
    property var    p438:       null
    property var    p439:       null
    property var    p440:       null
    property var    p441:       null
    property var    p442:       null
    property var    p443:       null
    property var    p444:       null
    property var    p445:       null
    property var    p446:       null
    property var    p447:       null
    property var    p448:       null
    property var    p449:       null
    property var    p450:       null
    property var    p501:       null
    property var    p502:       null
    property var    p503:       null
    property var    p504:       null
    property var    p505:       null
    property var    p506:       null
    property var    p507:       null
    property var    p508:       null
    property var    p509:       null
    property var    p510:       null
    property var    p511:       null
    property var    p512:       null
    property var    p513:       null
    property var    p514:       null
    property var    p515:       null
    property var    p516:       null
    property var    p517:       null
    property var    p518:       null
    property var    p519:       null
    property var    p520:       null
    property var    p521:       null
    property var    p522:       null
    property var    p523:       null
    property var    p524:       null
    property var    p525:       null
    property var    p526:       null
    property var    p527:       null
    property var    p528:       null
    property var    p529:       null
    property var    p530:       null
    property var    p531:       null
    property var    p532:       null
    property var    p533:       null
    property var    p534:       null
    property var    p535:       null
    property var    p536:       null
    property var    p537:       null
    property var    p538:       null
    property var    p539:       null
    property var    p540:       null
    property var    p541:       null
    property var    p542:       null
    property var    p543:       null
    property var    p544:       null
    property var    p545:       null
    property var    p546:       null
    property var    p547:       null
    property var    p548:       null
    property var    p549:       null
    property var    p550:       null
    property var    p601:       null
    property var    p602:       null
    property var    p603:       null
    property var    p604:       null
    property var    p605:       null
    property var    p606:       null
    property var    p607:       null
    property var    p608:       null
    property var    p609:       null
    property var    p610:       null
    property var    p611:       null
    property var    p612:       null
    property var    p613:       null
    property var    p614:       null
    property var    p615:       null
    property var    p616:       null
    property var    p617:       null
    property var    p618:       null
    property var    p619:       null
    property var    p620:       null
    property var    p621:       null
    property var    p622:       null
    property var    p623:       null
    property var    p624:       null
    property var    p625:       null
    property var    p626:       null
    property var    p627:       null
    property var    p628:       null
    property var    p629:       null
    property var    p630:       null
    property var    p631:       null
    property var    p632:       null
    property var    p633:       null
    property var    p634:       null
    property var    p635:       null
    property var    p636:       null
    property var    p637:       null
    property var    p638:       null
    property var    p639:       null
    property var    p640:       null
    property var    p641:       null
    property var    p642:       null
    property var    p643:       null
    property var    p644:       null
    property var    p645:       null
    property var    p646:       null
    property var    p647:       null
    property var    p648:       null
    property var    p649:       null
    property var    p650:       null
    property var    p701:       null
    property var    p702:       null
    property var    p703:       null
    property var    p704:       null
    property var    p705:       null
    property var    p706:       null
    property var    p707:       null
    property var    p708:       null
    property var    p709:       null
    property var    p710:       null
    property var    p711:       null
    property var    p712:       null
    property var    p713:       null
    property var    p714:       null
    property var    p715:       null
    property var    p716:       null
    property var    p717:       null
    property var    p718:       null
    property var    p719:       null
    property var    p720:       null
    property var    p721:       null
    property var    p722:       null
    property var    p723:       null
    property var    p724:       null
    property var    p725:       null
    property var    p726:       null
    property var    p727:       null
    property var    p728:       null
    property var    p729:       null
    property var    p730:       null
    property var    p731:       null
    property var    p732:       null
    property var    p733:       null
    property var    p734:       null
    property var    p735:       null
    property var    p736:       null
    property var    p737:       null
    property var    p738:       null
    property var    p739:       null
    property var    p740:       null
    property var    p741:       null
    property var    p742:       null
    property var    p743:       null
    property var    p744:       null
    property var    p745:       null
    property var    p746:       null
    property var    p747:       null
    property var    p748:       null
    property var    p749:       null
    property var    p750:       null
    property var    p801:       null
    property var    p802:       null
    property var    p803:       null
    property var    p804:       null
    property var    p805:       null
    property var    p806:       null
    property var    p807:       null
    property var    p808:       null
    property var    p809:       null
    property var    p810:       null
    property var    p811:       null
    property var    p812:       null
    property var    p813:       null
    property var    p814:       null
    property var    p815:       null
    property var    p816:       null
    property var    p817:       null
    property var    p818:       null
    property var    p819:       null
    property var    p820:       null
    property var    p821:       null
    property var    p822:       null
    property var    p823:       null
    property var    p824:       null
    property var    p825:       null
    property var    p826:       null
    property var    p827:       null
    property var    p828:       null
    property var    p829:       null
    property var    p830:       null
    property var    p831:       null
    property var    p832:       null
    property var    p833:       null
    property var    p834:       null
    property var    p835:       null
    property var    p836:       null
    property var    p837:       null
    property var    p838:       null
    property var    p839:       null
    property var    p840:       null
    property var    p841:       null
    property var    p842:       null
    property var    p843:       null
    property var    p844:       null
    property var    p845:       null
    property var    p846:       null
    property var    p847:       null
    property var    p848:       null
    property var    p849:       null
    property var    p850:       null
    property var    p901:       null
    property var    p902:       null
    property var    p903:       null
    property var    p904:       null
    property var    p905:       null
    property var    p906:       null
    property var    p907:       null
    property var    p908:       null
    property var    p909:       null
    property var    p910:       null
    property var    p911:       null
    property var    p912:       null
    property var    p913:       null
    property var    p914:       null
    property var    p915:       null
    property var    p916:       null
    property var    p917:       null
    property var    p918:       null
    property var    p919:       null
    property var    p920:       null
    property var    p921:       null
    property var    p922:       null
    property var    p923:       null
    property var    p924:       null
    property var    p925:       null
    property var    p926:       null
    property var    p927:       null
    property var    p928:       null
    property var    p929:       null
    property var    p930:       null
    property var    p931:       null
    property var    p932:       null
    property var    p933:       null
    property var    p934:       null
    property var    p935:       null
    property var    p936:       null
    property var    p937:       null
    property var    p938:       null
    property var    p939:       null
    property var    p940:       null
    property var    p941:       null
    property var    p942:       null
    property var    p943:       null
    property var    p944:       null
    property var    p945:       null
    property var    p946:       null
    property var    p947:       null
    property var    p948:       null
    property var    p949:       null
    property var    p950:       null

    // list of architectures and versions
    readonly property var archs: [[chr]]

    // current architecture editor
    property var    arch:   chr

    /* setMeta(n, v) ----------------------------------------------------------
    If property n of currProg doesn't equal v (where null means nonexistent), 
    it sends a Prog Set Meta message to change that metadatum.               */

    function setMeta(n, v) {
        var p
        if (v) {
            Util.unScratch(app, chr)
            if (currProg[n] === v)
                return
            p = Object.assign({}, currProg)
            p[n] = v
            }
        else {
            if (!currProg || !currProg[n])
                return
            p = Object.assign({}, currProg)
            delete p[n]
            }
        target.txProgSetMeta(p)
        }

    /* setSendParam(n, v) -----------------------------------------------------
    This sets parameter n to v, and also sends it. This handles globals as well 
    as program parameters. It also handles page 3 parameters by treating them 
    as a pair of page 1 and page 2 parameters.                               */

    function setSendParam(n, v) {

        if (debug & 8)
            console.log("setSendParam", n, v)

        // If global, eliminate duplicates, record in tls array.
        if (n >= 15 * 128) {
            if (tls["p" + n] === v)
                return
            tls["p" + n] = v
            if (tls.mins[n & 0x7F] < 0)
                v += 64
            target.txParamSet(n >> 7, n & 0x7F, v)
            }

        // If program parameter...
        else {

            // Compute offset value if bipolar.
            var vs = v
            if (arch.paramMins(n) < 0)
                vs += 64

            // If page 3, send page 1 unless duplicate, do page 2 next.
            if (n >= 3 * 128) {
                if (arch["p" + (n - 256)] !== v) {
                    arch["p" + (n - 256)] = v
                    target.txParamSet(1, n & 0x7F, vs)
                    }
                n -= 128
                }

            // Send unless duplicate.
            if (arch["p" + n] !== v) {
                arch["p" + n] = v
                target.txParamSet(n >> 7, n & 0x7F, vs)
                }
            }
        }

    /* setSendEditParam(n, v) -------------------------------------------------
    If parameter n has an edit number, it records its edit number and mode. In 
    any case, it records the parameter number and calls setSendParam() to send 
    the parameter. Page 3 refers to an A and B parameter set to the same 
    value.                                                                   */

    function setSendEditParam(n, v) {

        var e = arch.edn(n)
        if (e || n === n_link_balance) {
            arch.lastEditNumber = e
            arch.lastEditMode = n >> 7
            }
        arch.lastParamNumber = n
        setSendParam(n, v)
        }

    /* writeMeta(p, n, v) -----------------------------------------------------
    If property n of program p (a 3-digit program number) doesn't equal v 
    (where null means nonexistent), it sends a Prog Write Meta message to 
    change that metadatum.                                                   */

    function writeMeta(p, n, v) {
        var prog = app["p" + p]
        if (prog && prog[n] !== v) {
            prog = Object.assign({}, prog)
            if (v === null)
                delete prog[n]
            else
                prog[n] = v
            target.txProgWriteMeta(Math.trunc(p / 100) - 1, p % 100 - 1, prog)
            }
        }

    // COMMON PARAMETER NUMBERS -----------------------------------------------

    readonly property int n_link_bank:       0
    readonly property int n_link_number:     1
    readonly property int n_link_mode:       2
    readonly property int n_link_balance:    3
    readonly property int n_link_spread:     4
    readonly property int n_link_detune:     5
    readonly property int n_keyboard_split:  6
    readonly property int n_main_transpose:  7
    readonly property int n_link_transpose:  8
    readonly property int n_edit_mode:       9
    readonly property int n_edit_number:     10
    readonly property int n_sequence_bank:   11
    readonly property int n_sequence_number: 12
    readonly property int n_fsw_mode:        13
    readonly property int n_ribbon_alg:      14
    readonly property int n_kybd_alg:        15

    // COMMON PARAMTER VALUE STRINGS ------------------------------------------

    readonly property var   str_key: {
            0: "C0",
            1: "C#0",
            2: "D0",
            3: "D#0",
            4: "E0",
            5: "F0",
            6: "F#0",
            7: "G0",
            8: "G#0",
            9: "A0",
           10: "A#0",
           11: "B0",
           12: "C1",
           13: "C#1",
           14: "D1",
           15: "D#1",
           16: "E1",
           17: "F1",
           18: "F#1",
           19: "G1",
           20: "G#1",
           21: "A1",
           22: "A#1",
           23: "B1",
           24: "C2",
           25: "C#2",
           26: "D2",
           27: "D#2",
           28: "E2",
           29: "F2",
           30: "F#2",
           31: "G2",
           32: "G#2",
           33: "A2",
           34: "A#2",
           35: "B2",
           36: "C3",
           37: "C#3",
           38: "D3",
           39: "D#3",
           40: "E3",
           41: "F3",
           42: "F#3",
           43: "G3",
           44: "G#3",
           45: "A3",
           46: "A#3",
           47: "B3",
           48: "C4",
           49: "C#4",
           50: "D4",
           51: "D#4",
           52: "E4",
           53: "F4",
           54: "F#4",
           55: "G4",
           56: "G#4",
           57: "A4",
           58: "A#4",
           59: "B4",
           60: "C5",
           61: "C#5",
           62: "D5",
           63: "D#5",
           64: "E5",
           65: "F5",
           66: "F#5",
           67: "G5",
           68: "G#5",
           69: "A5",
           70: "A#5",
           71: "B5",
           72: "C6",
           73: "C#6",
           74: "D6",
           75: "D#6",
           76: "E6",
           77: "F6",
           78: "F#6",
           79: "G6",
           80: "G#6",
           81: "A6",
           82: "A#6",
           83: "B6",
           84: "C7",
           85: "C#7",
           86: "D7",
           87: "D#7",
           88: "E7",
           89: "F7",
           90: "F#7",
           91: "G7",
           92: "G#7",
           93: "A7",
           94: "A#7",
           95: "B7",
           96: "C8",
           97: "C#8",
           98: "D8",
           99: "D#8",
          100: "E8",
          101: "F8",
          102: "F#8",
          103: "G8",
          104: "G#8",
          105: "A8",
          106: "A#8",
          107: "B8",
          108: "C9",
          109: "C#9",
          110: "D9",
          111: "D#9",
          112: "E9",
          113: "F9",
          114: "F#9",
          115: "G9",
          116: "G#9",
          117: "A9",
          118: "A#9",
          119: "B9",
          120: "C10",
          121: "C#10",
          122: "D10",
          123: "D#10",
          124: "E10",
          125: "F10",
          126: "F#10",
          127: "G10",
        }

    readonly property var   str_kybd_alg: {
            0: "poly",
            1: "ordered",
            2: "buffered",
            3: "single",
            4: "multiple",
            5: "first",
            6: "bottom",
            7: "top",
            8: "up",
            9: "down",
           10: "up/down",
           11: "down/up",
           12: "sequence",
           13: "random",
           14: "low",
           15: "high"
        }

    readonly property var   str_link_mode: {
            0: "no link",
            1: "lower",
            2: "upper",
            3: "unison",
            4: "lower unison",
            5: "upper unison",
            6: "external",
            7: "internal"
        }

    readonly property var   str_pm50c: {
        "-50": "\u201250\xA2", 
        "-49": "\u201249\xA2", 
        "-48": "\u201248\xA2", 
        "-47": "\u201247\xA2", 
        "-46": "\u201246\xA2", 
        "-45": "\u201245\xA2", 
        "-44": "\u201244\xA2", 
        "-43": "\u201243\xA2", 
        "-42": "\u201242\xA2", 
        "-41": "\u201241\xA2", 
        "-40": "\u201240\xA2", 
        "-39": "\u201239\xA2", 
        "-38": "\u201238\xA2", 
        "-37": "\u201237\xA2", 
        "-36": "\u201236\xA2", 
        "-35": "\u201235\xA2", 
        "-34": "\u201234\xA2", 
        "-33": "\u201233\xA2", 
        "-32": "\u201232\xA2", 
        "-31": "\u201231\xA2", 
        "-30": "\u201230\xA2", 
        "-29": "\u201229\xA2", 
        "-28": "\u201228\xA2", 
        "-27": "\u201227\xA2", 
        "-26": "\u201226\xA2", 
        "-25": "\u201225\xA2", 
        "-24": "\u201224\xA2", 
        "-23": "\u201223\xA2", 
        "-22": "\u201222\xA2", 
        "-21": "\u201221\xA2", 
        "-20": "\u201220\xA2", 
        "-19": "\u201219\xA2", 
        "-18": "\u201218\xA2", 
        "-17": "\u201217\xA2", 
        "-16": "\u201216\xA2", 
        "-15": "\u201215\xA2", 
        "-14": "\u201214\xA2", 
        "-13": "\u201213\xA2", 
        "-12": "\u201212\xA2", 
        "-11": "\u201211\xA2", 
        "-10": "\u201210\xA2", 
         "-9": "\u20129\xA2", 
         "-8": "\u20128\xA2", 
         "-7": "\u20127\xA2", 
         "-6": "\u20126\xA2", 
         "-5": "\u20125\xA2", 
         "-4": "\u20124\xA2", 
         "-3": "\u20123\xA2", 
         "-2": "\u20122\xA2", 
         "-1": "\u20121\xA2", 
            0: "0\xA2", 
            1: "+1\xA2", 
            2: "+2\xA2", 
            3: "+3\xA2", 
            4: "+4\xA2", 
            5: "+5\xA2", 
            6: "+6\xA2", 
            7: "+7\xA2", 
            8: "+8\xA2", 
            9: "+9\xA2", 
           10: "+10\xA2", 
           11: "+11\xA2", 
           12: "+12\xA2", 
           13: "+13\xA2", 
           14: "+14\xA2", 
           15: "+15\xA2", 
           16: "+16\xA2", 
           17: "+17\xA2", 
           18: "+18\xA2", 
           19: "+19\xA2", 
           20: "+20\xA2", 
           21: "+21\xA2", 
           22: "+22\xA2", 
           23: "+23\xA2", 
           24: "+24\xA2", 
           25: "+25\xA2", 
           26: "+26\xA2", 
           27: "+27\xA2", 
           28: "+28\xA2", 
           29: "+29\xA2", 
           30: "+30\xA2", 
           31: "+31\xA2", 
           32: "+32\xA2", 
           33: "+33\xA2", 
           34: "+34\xA2", 
           35: "+35\xA2", 
           36: "+36\xA2", 
           37: "+37\xA2", 
           38: "+38\xA2", 
           39: "+39\xA2", 
           40: "+40\xA2", 
           41: "+41\xA2", 
           42: "+42\xA2", 
           43: "+43\xA2", 
           44: "+44\xA2", 
           45: "+45\xA2", 
           46: "+46\xA2", 
           47: "+47\xA2", 
           48: "+48\xA2", 
           49: "+49\xA2", 
           50: "+50\xA2"
        }

    readonly property var   str_rev_room: {
            0: "performance",
            1: "small",
            2: "medium",
            3: "large",
            4: "huge"
        }

    readonly property var   str_rev_send: [
        "off",          // 0
        "\u201265db",   // 1
        "\u201253db",   // 2
        "\u201246db",   // 3
        "\u201241db",   // 4
        "\u201237db",   // 5
        "\u201234db",   // 6
        "\u201231db",   // 7
        "\u201229db",   // 8
        "\u201227db",   // 9
        "\u201225db",   // 10
        "\u201223db",   // 11
        "\u201222db",   // 12
        "\u201220db",   // 13
        "\u201219db",   // 14
        "\u201218db",   // 15
        "\u201217db",   // 16
        "\u201216db",   // 17
        "\u201215db",   // 18
        "\u201214db",   // 19
        "\u201213db",   // 20
        "\u201212db",   // 21
        "\u201211.5db", // 22
        "\u201211db",   // 23
        "\u201210db",   // 24
        "\u20129db",    // 25
        "\u20128.5db",  // 26
        "\u20128db",    // 27
        "\u20127db",    // 28
        "\u20126.5db",  // 29
        "\u20126db",    // 30
        "\u20125.5db",  // 31
        "\u20125db",    // 32
        "\u20124.5db",  // 33
        "\u20124db",    // 34
        "\u20123.5db",  // 35
        "\u20123db",    // 36
        "\u20122.5db",  // 37
        "\u20122db",    // 38
        "\u20121.5db",  // 39
        "\u20121db",    // 40
        "\u20120.7db",  // 41
        "\u20120.3db",  // 42
        "0db",          // 43
        "+0.5db",       // 44
        "+1db",         // 45
        "+1.3db",       // 46
        "+1.7db",       // 47
        "+2db",         // 48
        "+2.4db",       // 49
        "+2.7db",       // 50
        "+3db",         // 51
        "+3.4db",       // 52
        "+3.7db",       // 53
        "+4db",         // 54
        "+4.4db",       // 55
        "+4.7db",       // 56
        "+5db",         // 57
        "+5.3db",       // 58
        "+5.6db",       // 59
        "+6db",         // 60
        "+6.2db",       // 61
        "+6.5db",       // 62
        "+6.8db",       // 63
        "+7db",         // 64
        "+7.3db",       // 65
        "+7.6db",       // 66
        "+7.8db",       // 67
        "+8db",         // 68
        "+8.4db",       // 69
        "+8.6db",       // 70
        "+8.8db",       // 71
        "+9db",         // 72
        "+9.3db",       // 73
        "+9.6db",       // 74
        "+9.8db",       // 75
        "+10db",        // 76
        "+10.3db",      // 77
        "+10.5db",      // 78
        "+10.7db",      // 79
        "+10.9db",      // 80
        "+11db",        // 81
        "+11.3db",      // 82
        "+11.6db",      // 83
        "+11.8db",      // 84
        "+12db",        // 85
        "+12.2db",      // 86
        "+12.4db",      // 87
        "+12.6db",      // 88
        "+12.8db",      // 89
        "+13db",        // 90
        "+13.2db",      // 91
        "+13.3db",      // 92
        "+13.5db",      // 93
        "+13.7db",      // 94
        "+14db",        // 95
        "+14.2db",      // 96
        "+14.5db",      // 97
        "+15db",        // 98
        "+15.5db",      // 99
        "+16db",        // 100
        "+16.5db",      // 101
        "+17db",        // 102
        "+17.5db",      // 103
        "+18db",        // 104
        "+18.5db",      // 105
        "+19db",        // 106
        "+19.2db",      // 107
        "+19.7db",      // 108
        "+20db",        // 109
        "+20.5db",      // 110
        "+21db",        // 111
        "+22db",        // 112
        "+22.5db",      // 113
        "+23db",        // 114
        "+23.5db",      // 115
        "+24db",        // 116
        "+24.5db",      // 117
        "+25db",        // 118
        "+25.5db",      // 119
        "+26db",        // 120
        "+26.5db",      // 121
        "+27db",        // 122
        "+28db",        // 123
        "+28.5db",      // 124
        "+29db",        // 125
        "+30db",        // 126
        "+30.5db",      // 127
        ]

    readonly property var   str_ribbon_alg: {
            0: "short release",
            1: "short hold",
            2: "short smooth",
            3: "medium release",
            4: "medium hold",
            5: "medium smooth",
            6: "long release",
            7: "long hold",
            8: "long smooth",
            9: "fixed release",
           10: "fixed hold"
        }

    // UNDO/REDO DESCRIPTIONS -------------------------------------------------

    property string redoDescr:  "(none)"
    property string undoDescr:  "(none)"
    
    // TARGET -----------------------------------------------------------------

    /* clearState -------------------------------------------------------------
    This clears the current program and all stored programs, and resets the 
    current program number to 101.                                           */

    function clearState() {

        currBank = currNumber = 0
        currProg = null
        Util.setScratch()
        for (var b = 0; b < 9; ++b)
            for (var p = 0; p < 50; ++p)
                app["p" + (101 + 100 * b + p)] = null
        }

    /* sxDisp(sx) -------------------------------------------------------------
    This generates a string from sysex packet sx. It is empty if sx is null, 
    shows the length in brackets if debug bit 6 is clear, or contains a hex 
    dump of the packet if bit 6 is set.                                      */

    function sxDisp(sx) {
        var r = ""
        if (sx && sx.length) {
            if (debug & 64) {
                for (var i = 0; i < sx.length; ++i) {
                    if (!(i & 0xF)) {
                        r += "\n"
                        r += "0123456789ABCDEF"[(i >> 8) & 0xF]
                        r += "0123456789ABCDEF"[(i >> 4) & 0xF]
                        r += "0123456789ABCDEF"[i & 0xF]
                        }
                    r += " "
                    r += "0123456789ABCDEF"[sx[i] >> 4]
                    r += "0123456789ABCDEF"[sx[i] & 0xF]
                    }
                if (sx.length & 0xF)
                    r += "\n"
                }
            else
                r = "[" + sx.length + "]"
            }
        return r
        }

    // TARGET INTERFACE -------------------------------------------------------

    TargetInterface {
        id:             target

        property bool allMeta
        readonly property int metaPipe: 10

        onRxClockSet: { // sync, sx
            if (debug & 1)
                console.log("onRxClockSet", sync, sxDisp(sx))
            if (sync)
                win.showMessage("Chroma clock is synced to internet")
            else if (sx.length === 12) {
                var c = Util.decodeTime(sx, 5)
                if (c) {
                    var t = new Date()
                    var e = Math.round((t.getTime() - c.getTime()) / 1000)
                    if (-2 <= e && e <= 2)
                        win.showMessage("Chroma clock is correct")
                    else {
                        Util.encodeTime(t, sx, 5)
                        txClockSet(sx)
                        win.showMessage(
                                "Chroma clock adjusted by " + e + " seconds")
                        }
                    }
                }
            }

        onRxParamSet: { // page, num, val, sx
            if (debug & 1)
                console.log("onRxParamSet", page, num, val, sxDisp(sx))
            if (page < 3) {
                if (num < arch.pagelen[page]) {
                    Util.unScratch(app, chr)
                    if (arch.paramMins(128 * page + num) < 0)
                        val -= 64
                    arch["p" + (128 * page + num)] = val
                    if (sx && sx.length) {
                        sx = Util.decodeTimestamp(sx, 5)
                        if (sx) {
                            currProg._time = sx
                            currProgChanged(currProg)
                            }
                        }
                    }
                }
            else if (page === 15) {
                if (num && num <= 22) {
                    if (tls.mins[num] < 0)
                        val -= 64
                    tls["p" + (1920 + num)] = val
                    }
                }
            }

        onRxProgSet: { // bank, prog, sx
            if (debug & 1)
                console.log("onRxProgSet", bank, prog, sxDisp(sx))
            if (bank < 9 && prog < 50) {
                if (sx && sx.length) {
                    sx = Util.decodeProgramSysex(app, sx, false)
                    if (sx) {
                        currBank = bank
                        currNumber = prog
                        currProg = sx
                        }
                    }
                else {
                    arch = chr
                    Util.setScratch(app)
                    currBank = bank
                    currNumber = prog
                    currProg = null
                    }
                }
            }

        onRxProgSetAttr: { // bank, prog, sx
            if (debug & 1)
                console.log("onRxProgSetAttr", bank, prog, sxDisp(sx))
            currBank = bank
            currNumber = prog
            if (sx && sx.length) {
                sx = Util.decodeTimestamp(sx, 5)
                if (sx) {
                    Util.unScratch(app, chr)
                    currProg._time = sx
                    currProgChanged(currProg)
                    }
                }
            }

        onRxProgSetMeta: { // sx
            if (debug & 1)
                console.log("onRxProgSetMeta", sxDisp(sx))
            if (sx && sx.length) {
                sx = Util.decodeProgramSysex(app, sx, true)
                if (sx)
                    currProg = sx
                }
            }

        onRxProgWrite: { // bank, prog, sx
            if (debug & 1)
                console.log("onRxProgWrite", bank, prog, sxDisp(sx))
            if (bank < 9 && prog < 50) {
                if (backupMonitor)
                    backupMonitor(bank, prog, sx)
                }
            }

        onRxProgWriteMeta: { // bank, prog, sx
            if (debug & 1)
                console.log("onRxProgWriteMeta", bank, prog, sxDisp(sx))
            if (bank < 9 && prog < 50) {

                // Compute 3-digit program number.
                var num = bank * 100 + prog + 101

                // If meta isn't null, decode it and record it.
                if (sx && sx.length) {
                    sx = Util.decodeProgramSysex(app, sx, true)
                    if (sx)
                        app["p" + num] = sx
                    }

                // If meta is null, clear it.
                else
                    app["p" + num] = null

                // If in the middle of a Restore, call restoreMonitor function.
                if (restoreMonitor)
                    restoreMonitor(bank, prog, sx)

                // If fetching all metadata, issue another request 4 ahead.
                if (allMeta) {
                    prog += metaPipe
                    if (prog >= 50) {
                        prog -= 50
                        if (++bank >= 9)
                            allMeta = false
                        }
                    if (bank < 9)
                        target.txProgReadMeta(bank, prog)
                    }
                }
            }

        onRxProgStore: { // bank, prog
            if (debug & 1)
                console.log("onRxProgStore", bank, prog)
            if (bank < 9 && prog < 50) {
                currBank = bank
                currNumber = prog
                app["p" + currNum] = Object.assign({}, currProg)
                }
            }

        onRxProgSwap: { // bank0, prog0, bank1, prog1
            if (debug & 1)
                console.log("onRxProgSwap", bank0, prog0, bank1, prog1)
            if (bank0 < 9 && prog0 < 50 && bank1 < 9 && prog1 < 50) {
                prog0 = "p" + (bank0 * 100 + prog0 + 101)
                prog1 = "p" + (bank1 * 100 + prog1 + 101)
                var p = app[prog0]
                app[prog0] = app[prog1]
                app[prog1] = p
                }
            }

        onRxEditResponse: { // sx
            if (debug & 1)
                console.log("onRxEditResponse", sxDisp(sx))
            target.stopEditRequest()
            var id = ""
            if (sx)
                for (var i = 5; i < sx.length - 1; ++i)
                    id += String.fromCharCode(sx[i])
            target.identification = id
            target.txProgGet()
            for (var n = 1; n < 23; ++n)
                target.txParamGet(15, n)
            target.txUndoRedoRequest(0)
            allMeta = true
            for (var i = 0; i < metaPipe; ++i)
                target.txProgReadMeta(0, i)
            }

        onRxUndoRedoStatus: { // cnt, sx
            if (debug & 1)
                console.log("onRxUndoRedoStatus", cnt, sxDisp(sx))
            var u = "", r = "", i
            if (sx) {
                cnt += 5
                for (i = 5; i < cnt; ++i)
                    u += String.fromCharCode(sx[i])
                cnt = sx ? sx.length - 1 : 0
                for ( ; i < cnt; ++i)
                    r += String.fromCharCode(sx[i])
                }
            undoDescr = u ? u : "(none)"
            redoDescr = r ? r : "(none)"
            }
        }
    }
