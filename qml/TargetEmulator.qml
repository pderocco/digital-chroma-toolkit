import QtQuick 2.12
import TargetFileReader 1.0
import "Util.js" as Util

Item {

    // PROPERTIES -------------------------------------------------------------

    // Programs are stored as Uint8Array objects containing full sysex messages

    property var    currProg:   null        // current program Uint8Array
    property int    currBank:   0           // current 0-based program bank
    property int    currNumber: 0           // current 0-based program number
    property var    globs:      newGlobs()  // globals
    property bool   isOpen:     false       // true if emulator is open
    property var    progs:      newProgs()  // 450 stored programs
    property var    redoable:   []          // list of redoable deltas
    property string redoStr:    ""          // last redo string sent back
    property string timerState: ""          // timer state ("", "edit", "ext")
    property var    undoable:   []          // list of undoable deltas
    property string undoStr:    ""          // last undo string sent back

    readonly property var edit_times: [ 1000, 1300, 1600, 2000, 2500, 
                                        3000, 4000, 5000, 6000, 8000, 10000 ]

    // LOCAL FUNCTIONS --------------------------------------------------------

    /* extractMeta(prog) ------------------------------------------------------
    This returns a sysex containing the metadata from program sysex prog, or 
    null if prog is null or invalid.                                         */

    function extractMeta(prog) {
        if (!prog || prog.length < 15)
            return null
        var a = archs[prog[13]][prog[14]]
        if (!a)
            return null
        var n = a.pagelen[0] + a.pagelen[1] + a.pagelen[2]
        if (prog.length < 15 + n)
            return null
        var m = new Uint8Array(prog.length + 5 - n)
        var i
        for (i = 0; i < 15; ++i)
            m[i] = prog[i]
        m[15] = prog[15]
        m[16] = prog[16]
        m[17] = prog[17]
        m[18] = prog[26]
        m[19] = prog[27]
        for (i = 15 + n; i < prog.length; ++i)
            m[i + 5 - n] = prog[i]
        return m
        }

    /* extractTime(prog) ------------------------------------------------------
    This returns a timestamp sysex containing the timestamp from program sysex 
    prog, or null if prog is null or invalid.                                */

    function extractTime(prog) {
        if (!prog || prog.length < 13)
            return null
        var t = new Uint8Array(
                [0xF0, 0, 0, 0x14, 0x44, 0, 0, 0, 0, 0, 0, 0, 0, 0xF7])
        for (var i = 0; i < 8; ++i)
            t[5 + i] = prog[5 + i]
        return t
        }

    /* modifyMeta(prog, meta) -------------------------------------------------
    This creates a new program sysex and a new metadata sysex containing the 
    combination of the parameters from program sysex prog and the metadata from 
    metadata sysex meta, and returns the pair, with a current timestamp in 
    both. If prog is null, this creates a Chroma program with all default 
    parameter values. If meta is null, it strips the metadata.               */

    function modifyMeta(prog, meta) {
        var a           // architecture
        var i           // byte index
        var n0, n1, n2  // size of each parameter page
        var newprog     // new program

        // If no metadata specified, create empty metadata, otherwise copy it.
        meta = meta && meta.length >= 20 ? meta.slice() 
                : new Uint8Array([0xF0, 0, 0, 0x14, 0x44, 0, 0, 0, 0, 0, 0, 0, 
                0, 0, 0, 0, 0, 0, 0, 0, 0xF7])

        // Look up architecture of prog, use Chroma if empty or invalid.
        if (prog && prog.length >= 20)
            var a = archs[prog[13]][prog[14]] || chr
        else
            var a = chr

        // Look up parameter counts.
        var n0 = a.pagelen[0]
        var n1 = a.pagelen[1]
        var n2 = a.pagelen[2]
        var n = n0 + n1 + n2

        // Create new program sysex of proper length, including metadata.
        newprog = new Uint8Array(meta.length - 5 + n)

        // Copy old prog parameters, or supply default Chroma values.
        if (prog && prog.length >= 15 + n)
            for (i = 0; i < 15 + n; ++i)
                newprog[i] = prog[i]
        else {
            prog = null
            newprog[0] = 0xF0
            newprog[3] = 0x14
            newprog[4] = 0x44
            for (i = 0; i < n0; ++i)
                newprog[15 + i] = chr.paramMins(i) < 0 
                        ? chr.paramDefs(i) + 64 : chr.paramDefs(i)
            for (i = 0; i < n1; ++i)
                newprog[15 + n0 + i] = chr.paramMins(128 + i) < 0 
                        ? chr.paramDefs(128 + i) + 64 : chr.paramDefs(128 + i)
            for (i = 0; i < n2; ++i)
                newprog[15 + n0 + n1 + i] = chr.paramMins(256 + i) < 0 
                        ? chr.paramDefs(256 + i) + 64 : chr.paramDefs(256 + i)
            }

        // Append metadata text.
        for (i = 20; i < meta.length; ++i)
            newprog[n - 5 + i] = meta[i]

        // Insert timestamp into program.
        Util.encodeTimestamp(new Date(), newprog, 5)

        // Also insert it into metadata object.
        for (i = 5; i < 13; ++i)
            meta[i] = newprog[i]

        // Copy link and sequence parameters into metadata.
        if (prog) {
            meta[15] = prog[15]
            meta[16] = prog[16]
            meta[17] = prog[17]
            meta[18] = prog[26]
            meta[19] = prog[27]
            }
        else
            meta[15] = meta[16] = meta[17] = meta[18] = meta[19] = 0

        // Return program, metadata.
        return [newprog, meta]
        }

    /* newGlobs() -------------------------------------------------------------
    This generates an array containing default global parameter values.      */

    function newGlobs() {
        var r = new Uint8Array(tls.defs.length)
        for (var i = 1; i < tls.defs.length; ++i)
            r[i] = tls.mins[i] < 0 ? tls.defs[i] + 64 : tls.defs[i]
        return r
        }

    /* newProgs() -------------------------------------------------------------
    This generates a 9*450 array of nulls, representing a complete set of 
    non-existent programs.                                                   */

    function newProgs() {
        var r = [[], [], [], [], [], [], [], [], []]
        for (var i = 0; i < 50; ++i) {
            r[0][i] = null
            r[1][i] = null
            r[2][i] = null
            r[3][i] = null
            r[4][i] = null
            r[5][i] = null
            r[6][i] = null
            r[7][i] = null
            r[8][i] = null
            }
        return r
        }

    /* setTimerState ----------------------------------------------------------
    This sets timerState to s, which can be "edit" to start it or postpone it 
    with the global edit timeout parameter for the interval, "ext" to start it 
    or postpone it with 100ms for the interval, or "" to stop the timer. If 
    entering the "edit" state, this creates a new delta whose undo action is to 
    call doParamSetDiffs with the current program state, but with no redo 
    action. If leaving the "edit" state, this sets the redo action in the last 
    delta to call doParamSetDiffs with the current program state.            */

    function setTimerState(s) {

        if (s === "edit") {
            if (timerState === "edit")
                timer.restart()
            else {
                redoable = []
                var p = currProg && currProg.slice()
                undoable.push({
                    undo: () => doParamSetDiffs(p),
                    redo: null,
                    msg: `Edit ${101 + 100 * currBank + currNumber}`
                    })
                timer.interval = edit_times[tls.p_edit_timeout]
                timer.start()
                }
            }
        else {
            if (timerState === "edit") {
                var p = currProg && currProg.slice()
                undoable[undoable.length - 1].redo = () => doParamSetDiffs(p)
                }
            if (s === "ext") {
                if (timerState === "ext")
                    timer.restart()
                else {
                    timer.interval = 100
                    timer.start()
                    }
                }
            else
                timer.stop()
            }
        timerState = s
        }

    /* touchProg() ------------------------------------------------------------
    If the current program exists, this simply bumps its timestamp to the 
    present. Otherwise, it uses ModifyMeta to create a program containing all 
    default values and no metadata but with a timestamp of the present.      */

    function touchProg() {
        if (currProg)
            Util.encodeTimestamp(new Date(), currProg, 5)
        else
            currProg = modifyMeta(null, null)[0]
        return currProg
        }

    // METHODS ----------------------------------------------------------------

    function clockGet() {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("clockGet")
        var c = new Uint8Array(
                [0xF0, 0, 0, 0x14, 0x44, 0, 0, 0, 0, 0, 0, 0xF7])
        var d = new Date()
        d.setTime(d.getTime())
        Util.encodeTimestamp(d, c, 5)
        rxClockSet(0, c)
        }

    function clockSet(sx) {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("clockSet", sxDisp(sx))
        }

    function doParamSetDiffs(p) {
        if (debug & 2)
            console.log("doParamSetDiffs", p)
        var a = archs[p[13]][p[14]]
        var n
        var n0 = a.pagelen[0]
        var n1 = a.pagelen[1]
        var n2 = a.pagelen[2]
        if (currProg) {
            for (n = 0; n < n0; ++n)
                if (currProg[15 + n] !== p[15 + n])
                    processRxParamSet(0, n, p[15 + n])
            n0 += 15
            for (n = 0; n < n1; ++n)
                if (currProg[n0 + n] !== p[n0 + n])
                    processRxParamSet(1, n, p[n0 + n])
            n0 += n1
            for (n = 0; n < n2; ++n)
                if (currProg[n0 + n] !== p[n0 + n])
                    processRxParamSet(2, n, p[n0 + n])
            }
        else {
            for (n = 0; n < n0; ++n)
                if (chr.paramDefs(n) !== p[15 + n])
                    processRxParamSet(0, n, p[15 + n])
            n0 += 15
            for (n = 0; n < n1; ++n)
                if (chr.paramDefs(128 + n) !== p[n0 + n])
                    processRxParamSet(1, n, p[n0 + n])
            n0 += n1
            for (n = 0; n < n2; ++n)
                if (chr.paramDefs(256 + n) !== p[n0 + n])
                    processRxParamSet(2, n, p[n0 + n])
            }
        currProg = p
        rxProgSetMeta(extractMeta(p))
        }

    function doProgExchange(b, p) {
        if (debug & 2)
            console.log("doProgExchange", b, p)
        var t = currProg
        currProg = progs[b][p]
        progs[b][p] = t
        rxProgStore(b, p)
        rxProgSet(currBank, currNumber, currProg)
        }

    function doProgLoad(b, n) {
        if (debug & 2)
            console.log("doProgLoad", b, n)
        currBank = b
        currNumber = n
        currProg = progs[b][n] && progs[b][n].slice()
        rxProgSet(b, n, currProg)
        }

    function doProgSet(b, n, sx) {
        if (debug & 2)
            console.log("doProgSet", b, n, sxDisp(sx))
        currBank = b
        currNumber = n
        currProg = sx
        rxProgSet(b, n, sx)
        }

    function doProgSetAttr(b, n) {
        if (debug & 2)
            console.log("doProgSetAttr", b, n)
        currBank = b
        currNumber = n
        rxProgSetAttr(b, n, null)
        }

    function doProgStore(b, n) {
        if (debug & 2)
            console.log("doProgStore", b, n)
        progs[b][n] = currProg && currProg.slice()
        currBank = b
        currNumber = n
        rxProgStore(b, n)
        }

    function doProgSwap(b0, n0, b1, n1) {
        if (debug & 2)
            console.log("doProgSwap", b0, n0, b1, n1)
        var t = progs[b0][n0]
        progs[b0][n0] = progs[b1][n1]
        progs[b1][n1] = t
        rxProgSwap(b0, n0, b1, n1)
        }

    function doProgWrite(b, n, sx) {
        if (debug & 2)
            console.log("doProgWrite", b, n, sxDisp(sx))
        progs[b][n] = sx
        rxProgWriteMeta(b, n, extractMeta(sx))
        }

    function doProgWriteMultiple(p) {
        for (var pn in p)
            doProgWrite(Math.floor((pn - 101) / 100), (pn - 101) % 100, p[pn])
        }

    function doProgWriteMeta(b, n, sx) {
        if (debug & 2)
            console.log("doProgWriteMeta", b, n, sxDisp(sx))
        if (progs[b][n] || sx)
            [progs[b][n], sx] = modifyMeta(progs[b][n], sx)
        rxProgWriteMeta(b, n, sx)
        return sx
        }

    function editRequest(r) {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("editRequest", r)
        if (r) {
            undoStr = redoStr = ""
            var a
            for (var b = 0; b < 9; ++b) {
                for (var p = 0; p < 9; ++p) {
                    a = reader.read(
                            ":/emu/" + (b + 1) + "/0" + (p + 1) + ".chr")
                    progs[b][p] = a ? new Uint8Array(a) : null
                    }
                for (var p = 9; p < 50; ++p) {
                    a = reader.read(
                            ":/emu/" + (b + 1) + "/" + (p + 1) + ".chr")
                    progs[b][p] = a ? new Uint8Array(a) : null
                    }
                }
            rxEditResponse(new Uint8Array([240, 0, 0, 20, 68, 68, 101, 109, 
                    111, 110, 115, 116, 114, 97, 116, 111, 114, 247]))
            }
        else
            progs = newProgs()
        currBank = currNumber = 0
        currProg = progs[0][0] && progs[0][0].slice()
        }

    function paramGet(p, n) {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("paramGet", p, n)
        var v
        if (p == 0) {
            if (n >= chr.pagelen[0])
                return
            v = currProg[15 + n]
            }
        else if (p == 1) {
            if (n >= chr.pagelen[1])
                return
            v = currProg[15 + chr.pagelen[0] + n]
            }
        else if (p == 2) {
            if (n >= chr.pagelen[2])
                return
            v = currProg[15 + chr.pagelen[0] + chr.pagelen[1] + n]
            }
        else if (p == 15) {
            if (!n || n >= 23)
                return
            v = globs[n]
            }
        else
            return
        processRxParamSet(p, n, v)
        }

    function paramSet(p, n, v) {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("paramSet", p, n, v)
        setTimerState("edit")
        if (p == 0) {
            if (n >= chr.pagelen[0])
                return
            touchProg()[15 + n] = v
            }
        else if (p == 1) {
            if (n >= chr.pagelen[1])
                return
            touchProg()[15 + chr.pagelen[0] + n] = v
            }
        else if (p == 2) {
            if (n >= chr.pagelen[2])
                return
            touchProg()[15 + chr.pagelen[0] + chr.pagelen[1] + n] = v
            }
        else if (p == 15) {
            if (!n || n >= 23)
                return
            globs[n] = v
            processRxParamSet(p, n, v)
            return
            }
        else
            return
        processRxParamSet(p, n, v, extractTime(currProg))
        undoRedoReport()
        }

    function progExchange(b, n) {
        if (!isOpen)
            return
        var p = currProg && currProg.slice()
        var p0 = progs[b][n] && progs[b][n].slice()
        doProgExchange(b, n)
        setTimerState("")
        redoable = []
        undoable.push({
            undo: () => { doProgStore(b, n), () => doProgSet(b, n, p) }, 
            redo: () => { doProgStore(b, n), () => doProgSet(b, n, p0) }, 
            msg: `Exchange ${101 + 100 * b + n}`
            })
        undoRedoReport()
        }

    function progGet() {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("progGet")
        rxProgSet(currBank, currNumber, currProg)
        }

    function progLoad(b, n) {
        if (!isOpen)
            return
        setTimerState("")
        var b0 = currBank
        var n0 = currNumber
        var p0 = currProg && currProg.slice()
        doProgLoad(b, n)
        var p = currProg && currProg.slice()
        redoable = []
        undoable.push({
            undo: () => doProgSet(b0, n0, p0),
            redo: () => doProgSet(b, n, p),
            msg: `Load ${101 + 100 * b + n}`
            })
        undoRedoReport()
        }

    function progRead(b, p) {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("progRead", b, p)
        rxProgWrite(b, p, progs[b][p])
        }

    function progReadMeta(b, p) {
        if (!isOpen)
            return
        if (debug & 2)
            console.log("progReadMeta", b, p)
        rxProgWriteMeta(b, p, extractMeta(progs[b][p]))
        }

    function progSet(b, n, sx) {
        if (!isOpen)
            return
        setTimerState("")
        var b0 = currBank
        var n0 = currNumber
        var p0 = currProg && currProg.slice()
        doProgSet(b, n, sx)
        redoable = []
        undoable.push({
            undo: () => doProgSet(b0, n0, p0),
            redo: () => doProgSet(b, n, sx),
            msg: `${sx ? "Set" : "Scratch"} ${101 + 100 * b + n}`
            })
        undoRedoReport()
        }

    function progSetMeta(sx) {
        if (!isOpen)
            return
        setTimerState("edit")
        var p = extractMeta(currProg)
        if (debug & 2)
            console.log("progSetMeta", sxDisp(sx));
        [currProg, sx] = modifyMeta(currProg, sx)
        rxProgSetMeta(sx)
        undoRedoReport()
        }

    function progStore(b, n) {
        if (!isOpen)
            return
        var b0 = currBank, n0 = currNumber
        var p0 = progs[b][n] && progs[b][n].slice()
        setTimerState("")
        doProgStore(b, n)
        redoable = []
        undoable.push({
            undo: () => { doProgWrite(b, n, p0); doProgSetAttr(b0, n0) },
            redo: () => doProgStore(b, n),
            msg: `Store ${101 + 100 * b + n}`
            })
        undoRedoReport()
        }

    function progSwap(b0, n0, b1, n1) {
        var m
        if (!isOpen)
            return
        setTimerState("")
        doProgSwap(b0, n0, b1, n1)
        redoable = []
        if (progs[b0][n0])
            if (progs[b1][n1])
                m = `Swap ${101 + 100 * b0 + n0} with ${101 + 100 * b1 + n1}`
            else
                m = `Move ${101 + 100 * b1 + n1} to ${101 + 100 * b0 + n0}`
        else
            if (progs[b1][n1])
                m = `Move ${101 + 100 * b0 + n0} to ${101 + 100 * b1 + n1}`
            else
                return
        undoable.push({
            undo: () => doProgSwap(b0, n0, b1, n1), 
            redo: () => doProgSwap(b0, n0, b1, n1), 
            msg: m
            })
        undoRedoReport()
        }

    function progWrite(b, n, sx) {
        if (!isOpen)
            return

        // Compute 3-digit program number.
        var pn = 101 + 100 * b + n

        // Get previous program, overwrite it.
        var p0 = progs[b][n] && progs[b][n].slice()
        doProgWrite(b, n, sx)

        // If this is consecutive write, append to undo/redo, postpone timer.
        if (timerState === "ext") {
            var u = undoable[undoable.length - 1]
            if (!u.oldprogs.hasOwnProperty(pn))
                u.oldprogs[pn] = p0
            u.newprogs[pn] = sx
            u.msg = "External modification"
            timer.restart()
            }

        // If this is first write, create new undo/redo, start timer.
        else {
            setTimerState("ext")
            redoable = []
            var op = {}; op[pn] = p0
            var np = {}; np[pn] = sx
            undoable.push({
                oldprogs: op,
                newprogs: np,
                undo: () => doProgWriteMultiple(op),
                redo: () => doProgWriteMultiple(np),
                msg: `${sx ? "Write" : "Delete"} ${pn}`
                })
            }
        undoRedoReport()
        }

    function progWriteMeta(b, n, sx) {
        if (!isOpen)
            return
        var m0 = progs[b][n].slice()
        setTimerState("")
        sx = doProgWriteMeta(b, n, sx)
        redoable = []
        undoable.push({
            undo: () => doProgWrite(b, n, m0),
            redo: () => doProgWriteMeta(b, n, sx),
            msg: `Write meta ${101 + 100 * b + n}`
            })
        undoRedoReport()
        }

    function undoRedoReport() {
        var u = undoable.length ? undoable[undoable.length - 1].msg : ""
        var r = redoable.length ? redoable[redoable.length - 1].msg : ""
        if (u !== undoStr || r !== redoStr) {
            undoStr = u
            redoStr = r
            u += r
            var a = new Uint8Array(6 + u.length)
            a[0] = 240
            a[1] = a[2] = 0
            a[3] = 20
            a[4] = 68
            a[a.length - 1] = 247
            for (var i = 0; i < u.length; ++i)
                a[5 + i] = u.charCodeAt(i)
            rxUndoRedoStatus(undoStr.length, a)
            }
        }

    function undoRedoRequest(r) {
        var d, m
        if (!isOpen)
            return
        if (debug & 2)
            console.log("undoRedoRequest", r)
        if (r === 1) {
            setTimerState("")
            if (undoable.length) {
                d = undoable.pop()
                redoable.push(d)
                d.undo()
                }
            }
        else if (r === 2) {
            setTimerState("")
            if (redoable.length) {
                d = redoable.pop()
                undoable.push(d)
                d.redo()
                }
            }
        undoRedoReport()
        }

    TargetFileReader { id: reader }

    Timer {
        id:             timer
        repeat:         false
        running:        false

        onTriggered:    setTimerState("")
        }
    }
