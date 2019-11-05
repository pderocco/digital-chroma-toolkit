import QtQuick 2.12
import Midi 1.0
import "Util.js" as Util

Midi {
    id:                     root

    autoOpen:               true
    outSense:               true

    property string identification: "Demonstrator"
    property string interfaceState: identification ? "Connected to"
            : state === "open" || portName === "Demonstrator" ? "Connecting to" 
            : state === "waiting" ? "Waiting for" 
            : "Looking for"

    onIdentificationChanged: {
        if (debug & 128)
            console.log("identification", identification)
        }

    onPortNameChanged: {
        if (debug & 128)
            console.log("portName", portName)
        identification = null
        stopEditRequest()
        }

    onStateChanged: {
        if (debug & 128)
            console.log("state", state)
        identification = null
        if (state === "open" || portName == "Demonstrator")
            startEditRequest()
        }

    // UTILITY FOR SCHEDULING A FUTURE FUNCTION CALL --------------------------

    /* schedule ---------------------------------------------------------------
    This is an array of function closures.                                   */

    property var    schedule:       []      // closure list

    /* schedTimer -------------------------------------------------------------
    This is a timer that is started when something is added to the schedule, 
    fires when the message loop is empty, executes everything in the schedule, 
    and clears it.                                                           */

    Timer {
        id:             schedTimer
        interval:       0
        onTriggered:    scheduleFlush()
        }

    /* scheduleAdd ------------------------------------------------------------
    This adds function closure fn to the end of the schedule, and makes sure 
    schedTimer is running.                                                   */

    function scheduleAdd(fn) {

        schedule.push(fn)
        if (debug & 4)
            console.log("scheduleAdd")
        schedTimer.running = true
        }

    /* scheduleFlush ----------------------------------------------------------
    This executes all the function closures in the schedule and clears it.   */

    function scheduleFlush() {

        if (debug & 4)
            console.log("scheduleFlush")
        var s = schedule
        schedule = []
        s.forEach(fn => fn())
        }

    // HIGH-LEVEL SIGNALS EMITTED ON TARGET RX --------------------------------

    signal rxClockSet(int sync, var sx)
    signal rxParamSet(int page, int num, int val, var sx)
    signal rxProgSet(int bank, int prog, var sx)
    signal rxProgSetAttr(int bank, int prog, var sx)
    signal rxProgSetMeta(var sx)
    signal rxProgWrite(int bank, int prog, var sx)
    signal rxProgWriteMeta(int bank, int prog, var sx)
    signal rxProgStore(int bank, int prog)
    signal rxProgSwap(int bank0, int prog0, int bank1, int prog1)
    signal rxEditResponse(var sx)
    signal rxUndoRedoStatus(int cnt, var sx)

    // HIGH-LEVEL METHODS FOR TARGET TX ---------------------------------------

    function txClockSet(d) {    // d is sysex Uint8Array
        if (debug & 32)
            console.log("txClockSet", sxDisp(d))
        if (identification) {
            if (state === "open") {
                txLong(d.buffer)
                txShort(0xB0 << 16 | 99 << 8 | 48)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | 0)
                }
            else
                scheduleAdd(function() { emu.clockSet(d) })
            }
        }

    function txClockGet() {
        if (debug & 32)
            console.log("txClockGet")
        if (identification) {
            if (state === "open") {
                txShort(0xB0 << 16 | 99 << 8 | 112)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | 0)
                }
            else
                scheduleAdd(function() { emu.clockGet() })
            }
        }

    function txProgLoad(b, p) {
        if (debug & 32)
            console.log("txProgLoad", b, p)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xC0 << 16 | p << 8)
                }
            else
                scheduleAdd(function() { emu.progLoad(b, p) })
        }

    // txParamSet is at end
    function txParamSetSimple(p, n, v) {
        if (debug & 32)
            console.log("txParamSetSimple", p, n, v)
        if (state === "open") {
            txShort(0xB0 << 16 | 99 << 8 | p)
            txShort(0xB0 << 16 | 98 << 8 | n)
            txShort(0xB0 << 16 | 6 << 8 | v)
            }
        else if (identification)
            scheduleAdd(function() { emu.paramSet(p, n, v) })
        }

    function txProgSet(b, p, d) {   // d is sysex Uint8Array
        if (debug & 32)
            console.log("txProgSet", b, p, sxDisp(d))
        flushParams()
        if (identification)
            if (state === "open") {
                if (d)
                    txLong(d.buffer)
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xB0 << 16 | 99 << 8 | 16)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p)
                }
            else
                scheduleAdd(function() { emu.progSet(b, p, d) })
        }

    function txProgSetMeta(d) {     // d is program metadata object
        d = Util.encodeProgramSysex(d, true)
        if (debug & 32)
            console.log("txProgSetMeta", sxDisp(d))
        flushParams()
        if (identification)
            if (state === "open") {
                if (d)
                    txLong(d.buffer)
                txShort(0xB0 << 16 | 99 << 8 | 17)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | 0)
                }
            else
                scheduleAdd(function() { emu.progSetMeta(d) })
        }

    function txProgWrite(b, p, d) { // d is sysex Uint8Array
        if (debug & 32)
            console.log("txProgWrite", b, p, sxDisp(d))
        flushParams()
        if (identification)
            if (state === "open") {
                if (d)
                    txLong(d.buffer)
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xB0 << 16 | 99 << 8 | 19)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p)
                }
            else
                scheduleAdd(function() { emu.progWrite(b, p, d) })
        }

    function txProgWriteMeta(b, p, d) { // d is program metadata object
        d = Util.encodeProgramSysex(d, true)
        if (debug & 32)
            console.log("txProgWriteMeta", b, p, sxDisp(d))
        flushParams()
        if (identification)
            if (state === "open") {
                if (d)
                    txLong(d.buffer)
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xB0 << 16 | 99 << 8 | 20)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p)
                }
            else
                scheduleAdd(function() { emu.progWriteMeta(b, p, d) })
        }

    function txProgStore(b, p) {
        if (debug & 32)
            console.log("txProgStore", b, p)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xB0 << 16 | 99 << 8 | 23)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p)
                }
            else
                scheduleAdd(function() { emu.progStore(b, p) })
        }

    function txProgExchange(b, p) {
        if (debug & 32)
            console.log("txProgExchange", b, p)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xB0 << 16 | 99 << 8 | 24)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p)
                }
            else
                scheduleAdd(function() { emu.progExchange(b, p) })
        }

    function txProgSwap(b0, p0, b1, p1) {
        if (debug & 32)
            console.log("txProgSwap", b0, p0, b1, p1)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 0 << 8 | b0)
                txShort(0xB0 << 16 | 32 << 8 | b1)
                txShort(0xB0 << 16 | 99 << 8 | 27)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p0)
                txShort(0xB0 << 16 | 38 << 8 | p1)
                }
            else
                scheduleAdd(function() { emu.progSwap(b0, p0, b1, p1) })
        }

    function txParamGet(p, n) {
        if (debug & 32)
            console.log("txParamGet", p, n)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 99 << 8 | (64 + p))
                txShort(0xB0 << 16 | 98 << 8 | n)
                txShort(0xB0 << 16 | 6 << 8 | 0)
                }
            else
                scheduleAdd(function() { emu.paramGet(p, n) })
        }

    function txProgGet() {
        if (debug & 32)
            console.log("txProgGet")
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 99 << 8 | 80)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | 0)
                }
            else
                scheduleAdd(function() { emu.progGet() })
        }

    function txProgRead(b, p) {
        if (debug & 32)
            console.log("txProgRead", b, p)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xB0 << 16 | 99 << 8 | 83)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p)
                }
            else
                scheduleAdd(function() { emu.progRead(b, p) })
        }

    function txProgReadMeta(b, p) {
        if (debug & 32)
            console.log("txProgReadMeta", b, p)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 0 << 8 | b)
                txShort(0xB0 << 16 | 99 << 8 | 84)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | p)
                }
            else
                scheduleAdd(function() { emu.progReadMeta(b, p) })
        }

    function txEditRequest(r) {
        if (r !== 0)
            r = 1
        if (debug & 32)
            console.log("txEditRequest", r)
        flushParams()
        if (state === "open") {
            txShort(0xB0 << 16 | 99 << 8 | 113)
            txShort(0xB0 << 16 | 98 << 8 | 0)
            txShort(0xB0 << 16 | 6 << 8 | r)
            }
        else if (portName === "Demonstrator")
            scheduleAdd(function() { emu.editRequest(r) })
        }

    function txUndoRedoRequest(r) {
        if (debug & 32)
            console.log("txUndoRedoRequest", r)
        flushParams()
        if (identification)
            if (state === "open") {
                txShort(0xB0 << 16 | 99 << 8 | 114)
                txShort(0xB0 << 16 | 98 << 8 | 0)
                txShort(0xB0 << 16 | 6 << 8 | r)
                }
            else if (portName === "Demonstrator")
                scheduleAdd(function() { emu.undoRedoRequest(r) })
        }

    // SIGNAL HANDLERS TO TRANSLATE MIDI RX -----------------------------------

    property int    bankLSB:    -1
    property int    bankMSB:    -1
    property int    dataMSB:    -1
    property var    inSysex:    null
    property int    nrpnLSB:    -1
    property int    nrpnMSB:    -1

    onRxShort: {
        if (0xB00000 <= msg || msg < 0xB10000) {
            var c = msg >> 8 & 0xFF
            msg &= 0xFF
            if (c === 0)
                bankMSB = msg
            else if (c === 6) {
                if (0 <= nrpnMSB && nrpnMSB <= 15)
                    processRxParamSet(nrpnMSB, nrpnLSB, msg, inSysex)
                else if (nrpnLSB === 0)
                    if (nrpnMSB === 16)
                        rxProgSet(bankMSB, msg, inSysex)
                    else if (nrpnMSB === 17)
                        rxProgSetMeta(inSysex)
                    else if (nrpnMSB === 19)
                        rxProgWrite(bankMSB, msg, inSysex)
                    else if (nrpnMSB === 20)
                        rxProgWriteMeta(bankMSB, msg, inSysex)
                    else if (nrpnMSB === 23)
                        rxProgStore(bankMSB, msg)
                    else if (nrpnMSB === 27)
                        dataMSB = msg
                    else if (nrpnMSB === 48)
                        rxClockSet(msg, inSysex)
                    else if (nrpnMSB === 49)
                        rxEditResponse(inSysex)
                    else if (nrpnMSB === 50)
                        rxUndoRedoStatus(msg, inSysex)
                    else
                        return
                else
                    return
                inSysex = null
                }
            else if (c === 32)
                bankLSB = msg
            else if (c === 38) {
                if (nrpnMSB === 27 && nrpnLSB === 0 && dataMSB >= 0) {
                    rxProgSwap(bankMSB, dataMSB, bankLSB, msg)
                    dataMSB = -1
                    inSysex = null
                    }
                }
            else if (c === 98)
                nrpnLSB = msg
            else if (c === 99)
                nrpnMSB = msg
            else if (c === 100 || c === 101)
                nrpnLSB = nrpnMSB = -1
            }
        }

    onRxLong: {
        msg = new Uint8Array(msg)
        if (msg.length >= 6 && msg[1] === 0 && msg[2] === 0 && msg[3] === 0x14 
                && msg[4] === 0x44)
            inSysex = msg
        }

    // INTERNAL PARAMETER TX/RX SYSTEM ----------------------------------------
    
    Timer {
        id:             flushTimer
        interval:       500
        onTriggered:    flushParams()
        }

    property var lastSent:  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    property var nextSent:  [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]

    /* flushParams ------------------------------------------------------------
    This stops flushTimer, and sends all pending Param Set operations that are 
    waiting for echoes.                                                      */

    function flushParams() {

        if (debug & 8)
            console.log("flushParams")
        var n
        flushTimer.running = false
        for (n in nextSent[0]) {
            txParamSetSimple(0, n, lastSent[0][n] = nextSent[0][n])
            if (debug & 8)
                console.log(" ", 0, n, "last", lastSent[0][n], "next empty")
            }
        nextSent[0] = []
        for (n in nextSent[1]) {
            txParamSetSimple(1, n, lastSent[1][n] = nextSent[1][n])
            if (debug & 8)
                console.log(" ", 1, n, "last", lastSent[1][n], "next empty")
            }
        nextSent[1] = []
        for (n in nextSent[2]) {
            txParamSetSimple(2, n, lastSent[2][n] = nextSent[2][n])
            if (debug & 8)
                console.log(" ", 2, n, "last", lastSent[2][n], "next empty")
            }
        nextSent[2] = []
        for (n in nextSent[15]) {
            txParamSetSimple(15, n, lastSent[15][n] = nextSent[15][n])
            if (debug & 8)
                console.log(" ", 15, n, "last", lastSent[15][n], "next empty")
            }
        nextSent[15] = []
        }

    /* scheduleFlushParams ----------------------------------------------------
    This restarts the flushTimer if there are any pending parameters to send, 
    or stops it if not.                                                      */

    function scheduleFlushParams() {
        var n

        flushTimer.running = false
        for (n in nextSent[0]) {
            flushTimer.running = true
            return
            }
        for (n in nextSent[1]) {
            flushTimer.running = true
            return
            }
        for (n in nextSent[2]) {
            flushTimer.running = true
            return
            }
        for (n in nextSent[15]) {
            flushTimer.running = true
            return
            }
        }

    /* processRxParamSet ------------------------------------------------------
    This is called when a Param Set is received. It sends any pending value. */

    function processRxParamSet(p, n, v, sx) {

        if (debug & 8)
            console.log("processRxParamSet", p, n, v, !sx ? "null" : sx.length)

        // If unexpected value, emit rxParamSet signal unconditionally.
        if (lastSent[p][n] !== v) {
            if (debug & 8)
                console.log(" ", p, n, "clear last and next")
            delete lastSent[p][n]
            delete nextSent[p][n]
            rxParamSet(p, n, v, sx)
            }

        // If expected value, and there's a pending value, send it.
        else if (nextSent[p][n] !== undefined) {
            txParamSetSimple(p, n, lastSent[p][n] = nextSent[p][n])
            if (debug & 8)
                console.log(" ", p, n, "move next to last")
            delete nextSent[p][n]
            }

        // Otherwise, emit rxParamSet to update timestamp.
        else {
            rxParamSet(p, n, v, sx)
            if (debug & 8)
                console.log(" ", p, n, "clear last")
            delete lastSent[p][n]
            }

        // Restart flushTimer, if necessary.
        scheduleFlushParams()
        }

    /* txParamSet -------------------------------------------------------------
    This requests that parameter n within page p be set to v. If still awaiting 
    an echo from setting this parameter, it records it as a pending value that 
    will be sent when the echo is received.                                  */

    function txParamSet(p, n, v) {

        if (debug & 8)
            console.log("txParamSet", p, n, v)
        if (lastSent[p][n] === undefined) {
            txParamSetSimple(p, n, lastSent[p][n] = v)
            if (debug & 8)
                console.log(" ", p, n, "set last", v)
            }
        else if (lastSent[p][n] !== v) {
            nextSent[p][n] = v
            if (debug & 8)
                console.log(" ", p, n, "set next", v)
            }
        else if (nextSent[p][n] !== undefined) {
            delete nextSent[p][n]
            if (debug & 8)
                console.log(" ", p, n, "clear next")
            }

        // Restart flushTimer, if necessary.
        scheduleFlushParams()
        }

    // EDIT REQUEST / RESPONSE ------------------------------------------------

    Timer {
        id:             editTimer
        onTriggered:    startEditRequest()
        }

    /* startEditRequest -------------------------------------------------------
    If editTimer isn't running, this sends an Edit Request, and starts the 
    timer.                                                                   */

    function startEditRequest() {

        if (!editTimer.running) {
            txEditRequest(1)
            editTimer.running = true
            }
        }

    /* stopEditRequest --------------------------------------------------------
    This stops editTimer.                                                    */

    function stopEditRequest() {

        editTimer.running = false
        }

    // THE DIGITAL CHROMA EMULATOR --------------------------------------------

    TargetEmulator {
        id:             emu
        isOpen:         portName === "Demonstrator"
        }
    }
