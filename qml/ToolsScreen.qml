import QtQuick 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    // indicator that any time-consuming tool is busy
    property bool toolBusy: sImport.busy || sBackupRestore.busy 

    // message popup contents
    property string msgBody
    property string msgTitle

    // unit height derived from computed Globals help button height
    readonly property real  uHgt: sGlobals.helpButtonHeight

    // Local properties for splitting MIDI parameters into port and channel
    //  xxx_port = 0 if none, 0...? if not
    //  xxx_chan = 0 if none, 0...15 if not
    property int mainPort:  (p_midi_main_in && p_midi_main_in - 1) >> 4
    property int mainChan:  (p_midi_main_in && p_midi_main_in - 1) & 0xF
    property int linkPort:  (p_midi_link_in && p_midi_link_in - 1) >> 4
    property int linkChan:  (p_midi_link_in && p_midi_link_in - 1) & 0xF
    property int recPort:   (p_midi_rec_out && p_midi_rec_out - 1) >> 4
    property int recChan:   (p_midi_rec_out && p_midi_rec_out - 1) & 0xF

    Text {
        id:                 title
        color:              "white"
        x:                  2 * uSpc
        width:              parent.width - 4 * uSpc
        y:                  uSpc
        height:             titleHgt - 2 * uSpc
        text:               "Tools"
        textFormat:         Text.PlainText
        font.pixelSize:     titleHgt * 0.625
        font.italic:        true
        }

    ButtonHelp {
        x:                  sGlobals.x - uHgt - 2 * uSpc
        width:              uHgt
        y:                  2 * uSpc
        height:             uHgt
        page:               "/help/Tools_screen"
        }    

    ToolsSectionImport {
        id:                 sImport
        x:                  uSpc
        width:              (parent.width - 3 * uSpc) / 2
        y:                  title.height + 2 * uSpc
        }

    ToolsSectionConvert {
        id:                 sConvert
        x:                  uSpc
        width:              (parent.width - 3 * uSpc) / 2
        y:                  sImport.y + sImport.height + uSpc
        }

    ToolsSectionBackupRestore {
        id:                 sBackupRestore
        x:                  uSpc
        width:              (parent.width - 3 * uSpc) / 2
        y:                  sConvert.y + sConvert.height + uSpc
        }

    ToolsSectionGlobals {
        id:                 sGlobals
        x:                  width + 2 * uSpc
        width:              (parent.width - 3 * uSpc) / 2
        y:                  uSpc
        height:             parent.height - 2 * uSpc
        }

    // dimmer -- for dimming the content
    Rectangle {
        id:                 dimmer
        color:              "#C0000000" // black, 75% opacity
        anchors.fill:       parent
        visible:            false       // not visible until explicitly enabled

        // msgBox -- result message box
        Rectangle {
            id:                 msgBox
            color:              colHelp
            visible:            false
            anchors.centerIn:   parent

            Text {
                id:                 msgText
                textFormat:         Text.RichText
                font.pixelSize:     pixData
                lineHeight:         0.75
                text:               "<b>" + msgTitle + "</b>" 
                                            + (msgBody ? "<br>" + msgBody : "")
                }

            MouseArea {
                anchors.fill:       parent
                onClicked:          dimmer.visible = false
                onPressAndHold: {
                    
                    dimmer.visible = false
                    }
                }
            }

        MouseArea {
            anchors.fill:       parent
            onClicked:          dimmer.visible = false
            }
        }

    // GLOBAL PARAMETER PROPERTIES --------------------------------------------

    property int p1921: defs[1];  property alias p_reverb_room:        root.p1921; readonly property int n_reverb_room:        1921
    property int p1922: defs[2];  property alias p_reverb_send:        root.p1922; readonly property int n_reverb_send:        1922
    property int p1923: defs[3];  property alias p_analog_master:      root.p1923; readonly property int n_analog_master:      1923
    property int p1924: defs[4];  property alias p_rollover_time:      root.p1924; readonly property int n_rollover_time:      1924
    property int p1925: defs[5];  property alias p_release_threshold:  root.p1925; readonly property int n_release_threshold:  1925
    property int p1926: defs[6];  property alias p_midi_main_in:       root.p1926; readonly property int n_midi_main_in:       1926
    property int p1927: defs[7];  property alias p_midi_link_in:       root.p1927; readonly property int n_midi_link_in:       1927
    property int p1928: defs[8];  property alias p_midi_rec_out:       root.p1928; readonly property int n_midi_rec_out:       1928
    property int p1929: defs[9];  property alias p_tapper_mode:        root.p1929; readonly property int n_tapper_mode:        1929
    property int p1930: defs[10]; property alias p_slider_mode:        root.p1930; readonly property int n_slider_mode:        1930
    property int p1931: defs[11]; property alias p_lever1_polarity:    root.p1931; readonly property int n_lever1_polarity:    1931
    property int p1932: defs[12]; property alias p_lever2_polarity:    root.p1932; readonly property int n_lever2_polarity:    1932
    property int p1933: defs[13]; property alias p_pedal1_polarity:    root.p1933; readonly property int n_pedal1_polarity:    1933
    property int p1934: defs[14]; property alias p_pedal2_polarity:    root.p1934; readonly property int n_pedal2_polarity:    1934
    property int p1935: defs[15]; property alias p_ribbon_polarity:    root.p1935; readonly property int n_ribbon_polarity:    1935
    property int p1936: defs[16]; property alias p_lever_resolution:   root.p1936; readonly property int n_lever_resolution:   1936
    property int p1937: defs[17]; property alias p_pedal_resolution:   root.p1937; readonly property int n_pedal_resolution:   1937
    property int p1938: defs[18]; property alias p_ribbon_resolution:  root.p1938; readonly property int n_ribbon_resolution:  1938
    property int p1939: defs[19]; property alias p_bipolar_pedal1:     root.p1939; readonly property int n_bipolar_pedal1:     1939
    property int p1940: defs[20]; property alias p_bipolar_pedal2:     root.p1940; readonly property int n_bipolar_pedal2:     1940
    property int p1941: defs[21]; property alias p_display_position:   root.p1941; readonly property int n_display_position:   1941
    property int p1942: defs[22]; property alias p_display_brightness: root.p1942; readonly property int n_display_brightness: 1942
    property int p1943: defs[23]; property alias p_edit_timeout:       root.p1943; readonly property int n_edit_timeout:       1943
    
    // Minimum values
    readonly property var mins: [
        //  0     1     2     3     4     5     6     7     8     9
            0,    1,    0,    0,    1,    1,    0,    0,    0,    0, // 0
            0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 10
            0,  -10,    0,    0                                      // 20
        ]

    // Maximum values
    readonly property var maxs: [
        //  0     1     2     3     4     5     6     7     8     9
            0,    4,  127,  100,   20,    7,   48,   48,   64,    2, // 0
            2,    1,    1,    1,    1,    1,    1,    1,    1,    1, // 10
            1,   10,    2,   10                                      // 20
        ]

    // Default values
    readonly property var defs: [
        //  0     1     2     3     4     5     6     7     8     9
            0,    2,    0,  100,    5,    4,    0,    0,    0,    2, // 0
            2,    0,    0,    0,    0,    0,    1,    1,    1,    0, // 10
            0,    0,    2,    7                                      // 20
        ]

    // Significant values (all invalid)
    readonly property var sigs: [
        //  0     1     2     3     4     5     6     7     8     9
          999,  999,  999,  999,  999,  999,  999,  999,  999,  999, // 0
          999,  999,  999,  999,  999,  999,  999,  999,  999,  999, // 10
          999,  999,  999,  999                                      // 20
        ]

    // Value strings
    readonly property var strs: [
        null,
        str_rev_room,       // reverb_room
        str_rev_send,       // reverb_send
        str_analog_master,  // analog_master
        str_rollover_time,  // rollover_time
        str_release_thresh, // release_threshold
        null,               // midi_main_input
        null,               // midi_link_input
        null,               // midi_rec_output
        str_tapper_mode,    // tapper_mode
        str_slider_mode,    // slider_mode
        str_push_pull,      // lever1_polarity
        str_push_pull,      // lever2_polarity
        str_normal_invert,  // pedal1_polarity
        str_normal_invert,  // pedal2_polarity
        str_normal_invert,  // ribbon_polarity
        str_low_high,       // lever_resolution
        str_low_high,       // pedal_resolution
        str_low_high,       // ribbon_resolution
        str_off_on,         // bipolar_pedal1
        str_off_on,         // bipolar_pedal2
        str_disp_pos,       // display_position
        str_disp_brite,     // display_brightness
        str_edit_timeout    // edit_timeout
        ]

    readonly property var   str_analog_master: [
        "off", "1%", "2%", "3%", "4%", "5%", "6%", "7%", "8%", "9%", 
        "10%", "11%", "12%", "13%", "14%", "15%", "16%", "17%", "18%", "19%", 
        "20%", "21%", "22%", "23%", "24%", "25%", "26%", "27%", "28%", "29%", 
        "30%", "31%", "32%", "33%", "34%", "35%", "36%", "37%", "38%", "39%", 
        "40%", "41%", "42%", "43%", "44%", "45%", "46%", "47%", "48%", "49%", 
        "50%", "51%", "52%", "53%", "54%", "55%", "56%", "57%", "58%", "59%", 
        "60%", "61%", "62%", "63%", "64%", "65%", "66%", "67%", "68%", "69%", 
        "70%", "71%", "72%", "73%", "74%", "75%", "76%", "77%", "78%", "79%", 
        "80%", "81%", "82%", "83%", "84%", "85%", "86%", "87%", "88%", "89%", 
        "90%", "91%", "92%", "93%", "94%", "95%", "96%", "97%", "98%", "99%", 
        "100%"
        ]

    readonly property var   str_disp_brite: {
            0: "low",
            1: "medium",
            2: "high"
        }

    readonly property var   str_disp_pos: {
        "-10": "\u201210",
         "-9": "\u20129",
         "-8": "\u20128",
         "-7": "\u20127", 
         "-6": "\u20126",
         "-5": "\u20125",
         "-4": "\u20124",
         "-3": "\u20123", 
         "-2": "\u20122",
         "-1": "\u20121",
            0: "normal", 
            1: "1",
            2: "2",
            3: "3",
            4: "4",
            5: "5",
            6: "6",
            7: "7",
            8: "8",
            9: "9",
           10: "10"
        }

    readonly property var   str_edit_timeout: [
        "1s",   // 0
        "1.3s", // 1
        "1.6s", // 2
        "2s",   // 3
        "2.5s", // 4
        "3s",   // 5
        "4s",   // 6
        "5s",   // 7
        "6s",   // 8
        "8s",   // 9
        "10s"   // 10
        ]

    readonly property var   str_low_high: {
            0: "low",
            1: "high"
        }

    readonly property var   str_normal_invert: {
            0: "normal",
            1: "invert"
        }

    readonly property var   str_off_on: {
            0: "off",
            1: "on"
        }

    readonly property var   str_push_pull: {
            0: "push",
            1: "pull"
        }

    readonly property var   str_release_thresh: [
        "",     // 0
        "16",   // 1
        "32",   // 2
        "48",   // 3
        "64",   // 4
        "80",   // 5
        "96",   // 6
        "112"   // 7
        ]

    readonly property var   str_rollover_time: [
        "",     // 0
        "5ms",  // 1
        "10ms", // 2
        "15ms", // 3
        "20ms", // 4
        "25ms", // 5
        "30ms", // 6
        "35ms", // 7
        "40ms", // 8
        "45ms", // 9
        "50ms", // 10
        "55ms", // 11
        "60ms", // 12
        "65ms", // 13
        "70ms", // 14
        "75ms", // 15
        "80ms", // 16
        "85ms", // 17
        "90ms", // 18
        "95ms", // 19
        "100ms" // 20
        ]

    readonly property var   str_slider_mode: {
            0: "jump",
            1: "capture",
            2: "smooth"
        }

    readonly property var   str_tapper_mode: {
            0: "off",
            1: "switches",
            2: "on"
        }

    // DESCRIPTOR ACCESS FUNCTIONS --------------------------------------------

    function paramMins(p) { return mins[p & 0x7F] }
    function paramMaxs(p) { return maxs[p & 0x7F] }
    function paramDefs(p) { return defs[p & 0x7F] }
    function paramSigs(p) { return sigs[p & 0x7F] }
    function paramStrs(p) { return strs[p & 0x7F] }
    }
