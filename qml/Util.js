/* appendStar -----------------------------------------------------------------
This appends an asterisk to a pathname, preceding it with a slash or backslash 
if necessary.                                                                */

function appendStar(p) {
    var s = qtutil.productType === "windows" ? "\\" : "/"

    if (!p || p[p.length - 1] != s)
        p += s
    return p + "*"
    }

/* compareTimestamp -----------------------------------------------------------
This returns true if two timestamps are equal.                               */

function compareTimestamp(t1, t2) {
    return t1 && t2 ? t1.getTime() === t2.getTime() && t1.us100 === t2.us100 
                    : !t1 && !t2
    }

/* decodeProgramSysex ---------------------------------------------------------
If the Sysex in Uint8Array b contains a valid program (if m is false) or a 
valid metadata Sysex (if m is true), this returns a program object, otherwise 
it returns null. The caller must have validated the Sysex header and EOX, and 
checked for an otherwise empty Sysex. A program object always has the following 
properties:

    _time -- a Date object with an added us100 property with the extra digit
    _arch -- a reference to the architecture object
    _link -- the number of the program linked to (-1 for no link, 0 for self, 
        1-50 for current bank, 101-950 for specific bank)
    _seq -- the number of program sequenced to (0 for previous, 1-50 for 
        current bank, 101-950 for specific bank)

Any text metadata that consists of a "name=value" or "name=" line is turned 
into a new property of the program, unless the name starts with an underscore. 
If there are multiple lines of text with the same name, their values are 
concatenated with intervening newlines.

If m is false, the parameters are distributed into the various p# properties of 
the architecture object. If m is true, only the five link and sequence 
parameters must be present.                                                  */

function decodeProgramSysex(app, b, m) {
    var arch        // architecture object
    var i           // index into b
    var len         // length of b
    var n0, n1, n2  // page sizes
    var nam         // metadata name
    var prg = {}    // resulting program object
    var v           // parameter value
    var val         // metadata value

    // Must be long enough to hold timestamp, architecture, version, 
    //  and four parameter bytes.
    len = b.length
    if (len < 20)
        return null
    --len // ignore EOX at end

    // Architecture must be valid.
    if (b[13] >= app.archs.length)
        return null

    // Architecture version must be valid.
    arch = app.archs[b[13]]
    if (b[14] > arch.length)
        return null

    // Point to architecture object.
    prg._arch = arch = arch[b[14]]

    // Validate timestamp.
    prg._time = decodeTimestamp(b, 5)
    if (!prg._time)
        return null

    // If a metadata sysex, get link and sequence parameters from 15..19, 
    //  extra metadata starts at 20.
    if (m) {
        if (!b[17])
            prg._link = -1
        else if (!b[16])
            prg._link = 0
        else
            prg._link = Math.min(50, b[16]) + 100 * Math.min(9, b[15])
        if (!b[19])
            prg._seq = 0
        else
            prg._seq = Math.min(50, b[19]) + 100 * Math.min(9, b[18])
        i = 20
        }

    // If a program sysex, skip over parameters, return null if too short, 
    //  get link and sequence parameters.
    else {
        n0 = arch.pagelen[0]
        n1 = arch.pagelen[1]
        n2 = arch.pagelen[2]
        i = 15 + n0 + n1 + n2
        if (i > len)
            return null
        if (!b[17])
            prg._link = -1
        else if (!b[16])
            prg._link = 0
        else
            prg._link = Math.min(50, b[16]) + 100 * Math.min(9, b[15])
        if (!b[27])
            prg._seq = 0
        else
            prg._seq = Math.min(50, b[27]) + 100 * Math.min(9, b[26])
        }

    // Process metadata one character at a time, return null if invalid.
    nam = ""
    val = null
    while (i < len) {

        // If newline, process accumulated line.
        if (b[i] === 10) {

            // If equals sign was found, and name doesn't start with "_"...
            if (val !== null && nam || nam[0] !== "_") {

                // If already found, append to property, else set property.
                if (prg.hasOwnProperty(nam)) {
                    prg[nam] += "\n"
                    prg[nam] += val
                    }
                else
                    prg[nam] = val
                }

            // Start accumulating new line.
            nam = ""
            val = null
            }

        // If not ASCII, return null
        else if (!within(32, 126, b[i]))
            return null

        // If equals sign already found, append to value.
        else if (val !== null)
            val += String.fromCharCode(b[i])

        // If this is equals sign, start accumulating value.
        else if (b[i] === 61)
            val = ""

        // Otherwise, append to name.
        else
            nam += String.fromCharCode(b[i])

        // Next character.
        ++i
        }

    // If a Program sysex...
    if (!m) {

        // Decode parameters into architecture object, 
        //  after correcting bipolar parameters and clamping to valid ranges, 
        for (i = 0; i < n0; ++i) {
            v = b[15 + i]
            if (arch.paramMins(i) < 0)
                v -= 64
            arch["p" + i] = limit(arch.paramMins(i), arch.paramMaxs(i), v)
            }
        for (i = 0; i < n1; ++i) {
            v = b[15 + n0 + i]
            if (arch.paramMins(128 + i) < 0) {
                v -= 64
                }
            arch["p" + (128 + i)] 
                    = limit(arch.paramMins(128 + i), arch.paramMaxs(128 + i), v)
            }
        for (i = 0; i < n2; ++i) {
            v = b[15 + n0 + n1 + i]
            if (arch.paramMins(256 + i) < 0)
                v -= 64
            arch["p" + (256 + i)] 
                    = limit(arch.paramMins(256 + i), arch.paramMaxs(256 + i), v)
            }
        }
    return prg
    }

/* decodeTime -----------------------------------------------------------------
If the 6 bytes at index i in Uint8Array b represent a valid time, this returns 
a Date object; otherwise, it returns null.                                   */

function decodeTime(b, i) {

    if (b.length < i + 6)
        return null
    var d = new Date(Date.UTC(2000 + b[i], b[i + 1] - 1, b[i + 2], b[i + 3], 
            b[i + 4], b[i + 5]))
    if (d.getUTCFullYear() % 100 !== b[i] 
            || d.getUTCMonth() + 1 !== b[i + 1] 
            || d.getUTCDate() !== b[i + 2] 
            || d.getUTCHours() !== b[i + 3] 
            || d.getUTCMinutes() !== b[i + 4] 
            || d.getUTCSeconds() !== b[i + 5])
        return null
    return d
    }

/* decodeTimestamp ------------------------------------------------------------
If the 8 bytes at index i in Uint8Array b represent a valid timestamp, this 
returns a Date object with an added us100 attribute containing the last digit; 
otherwise, it returns null.                                                  */

function decodeTimestamp(b, i) {

    if (b.length < i + 8 || b[i + 7] > 99)
        return null
    var d = decodeTime(b, i)
    if (d) {
        d.us100 = b[i + 7] % 10
        d.setTime(d.getTime() + b[i + 6] * 10 + (b[i + 7] - d.us100) / 10)
        }
    return d
    }

/* encodeProgramSysex----------------------------------------------------------
This converts a program into an Uint8Array representing a Program or Metadata 
Sysex, depending on m. The p parameter is the program, and must have the 
following properties:

    _time -- a Date representing the timestamp, with a us100 property for the 
    extra digit. If this is null, this returns an empty Uint8Array.

    _arch -- the architecture object (e.g., chr)

If it doesn't have these, or they are null, this returns an empty Uint8Array. 
Otherwise, it builds up the text metadata from any other iterable properties of 
p that have string values, constructs the Uint8Array, and fills in the 
timestamp, architecture, and version at the beginning, and the metadata at the 
end. If m is false, it fetches all the parameters from the "p#" parameters of 
the architecture object, offsets the bipolar ones, and writes them into the 
array. If m is true, the five bytes used to report link and sequence parameters 
are filled with zero, since the Chroma ignores them.                         */

function encodeProgramSysex(p, m) {
    var arch        // architecture object
    var b           // resulting array
    var i           // index into b
    var meta = ""   // metadata as string
    var n0, n1, n2  // page sizes
    var nam         // property name
    var time        // timestamp
    var v           // parameter value

    // For each iterable property...
    time = arch = null
    for (nam in p)

        // If "_time" or "_arch", record those in variables.
        if (nam === "_time")
            time = p._time
        else if (nam === "_arch")
            arch = p._arch

        // If no leading "_", split value at newlines and append to meta.
        else if (nam[0] !== "_")
            p[nam].split("\n").forEach(
                function(l) {
                    meta += nam
                    meta += "="
                    meta += l
                    meta += "\n"
                    }
                )

    // If time and arch not found, return empty value.
    if (!time || !arch)
        return new Uint8Array(0)

    // Create Uint8Array of correct size.
    n0 = arch.pagelen[0]
    n1 = arch.pagelen[1]
    n2 = arch.pagelen[2]
    b = new Uint8Array(16 + (m ? 5 : n0 + n1 + n2) + meta.length)

    // Create Sysex header and program header.
    b[0] = 0xF0
    b[3] = 0x14
    b[4] = 0x44
    encodeTimestamp(p._time, b, 5)
    b[13] = p._arch.archNum
    b[14] = p._arch.archVer

    // Translate parameters, if m is false.
    if (!m) {
        for (i = 0; i < n0; ++i) {
            v = arch["p" + i]
            if (arch.paramMins(i) < 0)
                v += 64
            b[15 + i] = v
            }
        for (i = 0; i < n1; ++i) {
            v = arch["p" + (128 + i)]
            if (arch.paramMins(128 + i) < 0)
                v += 64
            b[15 + n0 + i] = v
            }
        for (i = 0; i < n2; ++i) {
            v = arch["p" + (256 + i)]
            if (arch.paramMins(256 + i) < 0)
                v += 64
            b[15 + n0 + n1 + i] = v
            }

        // Metadata starts after parameters.
        i = 15 + n0 + n1 + n2
        }

    // Otherwise, metadata starts after dummy link and sequence parameters.
    else
        i = 20

    // Append metadata.
    for (var j = 0; j < meta.length; ++j)
        b[i++] = meta.charCodeAt(j)

    // Append EOX.
    b[i] = 0xF7

    // Return result.
    return b
    }

/* encodeTime -----------------------------------------------------------------
This converts a date to a 6-byte time and writes into Uint8Array b at index 
i.                                                                           */

function encodeTime(d, b, i) {

    b[i] = d.getUTCFullYear() % 100
    b[i + 1] = d.getUTCMonth() + 1
    b[i + 2] = d.getUTCDate()
    b[i + 3] = d.getUTCHours()
    b[i + 4] = d.getUTCMinutes()
    b[i + 5] = d.getUTCSeconds()
    }

/* encodeTimestamp ------------------------------------------------------------
This converts a date to an 8-byte timestamp and writes into Uint8Array b at 
index i. The date may have an added us100 property with a 0...9 value to supply 
the final digit; otherwise, that digit is zero.                              */

function encodeTimestamp(d, b, i) {

    encodeTime(d, b, i)
    var ms = d.getUTCMilliseconds()
    var ms1 = ms % 10
    b[i + 6] = (ms - ms1) / 10
    b[i + 7] = ms1 * 10 + (d.us100 || 0)
    }

/* equals ---------------------------------------------------------------------
This compares any two containers of numbers, returning true if they are the 
same length and have the same values.                                        */

function equals(a, b) {

    if (a.length !== b.length)
        return false
    for (var i = 0; i < a.length; ++i)
        if (a[i] !== b[i])
            return false
    return true
    }

/* escapeHtml -----------------------------------------------------------------
This replaces &, <, >, and " with ampersand escapes.                         */

function escapeHtml(str) {

    return String(str).replace(/&/g, '&amp;')
                      .replace(/</g, '&lt;')
                      .replace(/>/g, '&gt;')
                      .replace(/"/g, '&quot;');
    }

/* findChild ------------------------------------------------------------------
This returns the child of item whose objectName is name, or null if not 
found.                                                                       */

function findChild(item, name) {
    if (item.objectName == name)
        return item
    for (var i = 0; i < item.children.length; ++i) {
        var child = findChild(item.children[i], name)
        if (child)
            return child
        }
    return null
    }

/* formatTimestamp ------------------------------------------------------------
This converts a date, with an added us100 property, to a human-readable date 
and time in local time.                                                      */

function formatTimestamp(t) {

    return t.getFullYear().toString() + "/" 
            + (t.getMonth() + 101).toString().substring(1) + "/" 
            + (t.getDate() + 100).toString().substring(1) + " " 
            + (t.getHours() + 100).toString().substring(1) + ":" 
            + (t.getMinutes() + 100).toString().substring(1) + ":" 
            + (t.getSeconds() + 100).toString().substring(1) + "." 
            + (10 * t.getMilliseconds() + (t.us100 || 0) + 10000)
                    .toString().substring(1)
    }

/* hasStar --------------------------------------------------------------------
This returns true if a pathname ends in an asterisk.                         */

function hasStar(p) {

    return p && p[p.length - 1] === "*"
    }

/* limit ----------------------------------------------------------------------
This clamps the range of v to mn...mx.                                       */

function limit(mn, mx, v) {

    return Math.min(mx, Math.max(mn, v))
    }

/* setScratch -----------------------------------------------------------------
This sets all parameters to their default values.                            */

function setScratch(app) {
    var n, p

    n = arch.pagelen[0]
    for (p = 0; p < n; ++p)
        arch["p" + p] = arch.paramDefs(p)
    n = arch.pagelen[1] + 128
    for (p = 128; p < n; ++p)
        arch["p" + p] = arch.paramDefs(p)
    n = arch.pagelen[2] + 256
    for (p = 256; p < n; ++p)
        arch["p" + p] = arch.paramDefs(p)
    }

/* unScratch ------------------------------------------------------------------
If currProg is null, this creates an object with empty strings as name and 
descr properties, the current time as its _time property, arch (always chr) as 
its _arch property, and default values for _link and _seq.                   */

function unScratch(app, arch) {

    if (!app.currProg)
        app.currProg = {
            "name": "", 
            "descr": "", 
            "_time": new Date(), 
            "_arch": arch, 
            "_link": -1, 
            "_seq": 0
            }
    }

/* urlToFile ------------------------------------------------------------------
This strips a leading "file:///" from a URL. On Windows, it converts slashes to 
backslashes.                                                                 */

function urlToFile(u) {

    u = u.toString()
    if (u.substring(0, 8) === "file:///")
        u = u.substring(8)
    if (qtutil.productType === "windows")
        u = u.replace(/\//g, "\\")
    return u
    }

/* within ---------------------------------------------------------------------
This returns true if v is a number within mn...mx.                           */

function within(mn, mx, v) {

    return typeof(v) === "number" && !isNaN(v) && mn <= v && v <= mx
    }
