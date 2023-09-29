// ChromaConverter.cpp

#include <QDateTime>
#include "ChromaConverter.h"
#include <algorithm>
#include <cmath>
using namespace std;

using int8_p    = int8_t const[];
using uint16_p  = uint16_t const[];

/* param_descrs ---------------------------------------------------------------
This table lists the packed parameters in an old Chroma program in order of 
layout, along with their proper locations within an o_program.               */

param_descr const param_descrs[] = {
    D(2, link_mode),
    D(6, link_num),

    D(2, main_trans),
    D(2, link_trans),
    D(4, patch),

    D(5, detune),
    X(3),   // skip output select

    D(4, a.swp_rate_mod),
    D(4, a.vol_mod1_dep),

    D(6, a.swp_rate),
    D(2, a.swp_mode),

    D(4, a.vol_mod2_dep),
    X(1),
    D(3, fsw_mode),

    D(4, a.swp_shape),
    D(4, a.swp_ampl_mod),

    D(5, a.env1_att),
    D(3, a.env1_att_mod),

    D(5, a.env1_dec),
    D(3, a.env1_dec_mod),

    D(5, a.env1_rel),
    D(3, a.env1_ampl_touch),

    D(5, a.env2_del),
    D(3, a.cut_res),

    D(5, a.env2_att),
    D(3, a.env2_att_mod),

    D(5, a.env2_dec),
    D(3, a.env2_dec_mod),

    D(5, a.env2_rel),
    D(3, a.env2_ampl_touch),

    X(1),
    D(1, a.gld_shape),
    D(6, a.pch_tune),

    D(1, a.cut_lphp),
    D(-7, a.pch_mod1_dep),

    X(1),
    D(-7, a.pch_mod2_dep),

    X(1),
    D(-7, a.pch_mod3_dep),

    D(4, a.pch_mod1_sel),
    D(4, a.pch_mod2_sel),

    D(4, a.pch_mod3_sel),
    D(4, a.wav_mod_sel),

    D(6, a.wav_width),
    D(2, a.wav_shape),

    X(1),
    D(-7, a.wav_mod_dep),

    X(2),
    D(6, a.cut_tune),

    X(1),
    D(-7, a.cut_mod1_dep),

    X(1),
    D(-7, a.cut_mod2_dep),

    X(1),
    D(-7, a.cut_mod3_dep),

    D(4, a.cut_mod1_sel),
    D(4, a.cut_mod2_sel),

    D(4, a.cut_mod3_sel),
    D(2, a.vol_mod1_sel),
    D(2, a.vol_mod2_sel),

    D(5, a.gld_rate),
    D(3, a.vol_mod3_sel),

    D(8, seq_num),

    D(2, edit_mode),
    D(6, edit_num),

    D(4, kbd_alg),
    D(-4, link_balance),

    D(-8, kbd_split),

    D(4, b.swp_rate_mod),
    D(4, b.vol_mod1_dep),

    D(6, b.swp_rate),
    D(2, b.swp_mode),

    D(4, b.vol_mod2_dep),
    X(4),

    D(4, b.swp_shape),
    D(4, b.swp_ampl_mod),

    D(5, b.env1_att),
    D(3, b.env1_att_mod),

    D(5, b.env1_dec),
    D(3, b.env1_dec_mod),

    D(5, b.env1_rel),
    D(3, b.env1_ampl_touch),

    D(5, b.env2_del),
    D(3, b.cut_res),

    D(5, b.env2_att),
    D(3, b.env2_att_mod),

    D(5, b.env2_dec),
    D(3, b.env2_dec_mod),

    D(5, b.env2_rel),
    D(3, b.env2_ampl_touch),

    X(1),
    D(1, b.gld_shape),
    D(6, b.pch_tune),

    D(1, b.cut_lphp),
    D(-7, b.pch_mod1_dep),

    X(1),
    D(-7, b.pch_mod2_dep),

    X(1),
    D(-7, b.pch_mod3_dep),

    D(4, b.pch_mod1_sel),
    D(4, b.pch_mod2_sel),

    D(4, b.pch_mod3_sel),
    D(4, b.wav_mod_sel),

    D(6, b.wav_width),
    D(2, b.wav_shape),

    X(1),
    D(-7, b.wav_mod_dep),

    X(2),
    D(6, b.cut_tune),

    X(1),
    D(-7, b.cut_mod1_dep),

    X(1),
    D(-7, b.cut_mod2_dep),

    X(1),
    D(-7, b.cut_mod3_dep),

    D(4, b.cut_mod1_sel),
    D(4, b.cut_mod2_sel),

    D(4, b.cut_mod3_sel),
    D(2, b.vol_mod1_sel),
    D(2, b.vol_mod2_sel),

    D(5, b.gld_rate),
    D(3, b.vol_mod3_sel),
    };

/* void ChromaConverter::convert(QByteArray sysex, QByteArray names); ---------
This is called with the contents of a sysex file, and an optional names file. 
If the sysex is a valid Syntech sysex, it calls convertProgram for each 
program. If there are any names, the name in line p is attached to program p. 
If anything goes wrong, it emits an error signal, and won't emit any further 
programs.                                                                    */

void ChromaConverter::convert(QByteArray sysex, QByteArray names) {
    int         bit;        // bit number
    int         bsr;        // bit shift register
    int         byt;        // byte number
    char const* d;          // pointer to sysex data
    int         dh;         // high data nibble
    int         di;         // index into sysex data
    int         dl;         // low data nibble
    int         dn;         // length of sysex data
    QString     n;          // name string
    int         pn;         // current program number
    char const* t;          // pointer to names data
    int         ti;         // index into names data
    int         tn;         // length of names data
    int         tot;        // total number of programs to convert

    // Point to unpacked old program as bytes.
    char*       opbytes = reinterpret_cast<char*>(&op);

    // No last timestamp yet.
    lastts = 0;

    // Read sysex and names as chars.
    d = sysex.data();
    dn = sysex.size() - 1; // don't count EOX
    t = names.data();
    tn = names.size();

    // Validate length, Sysex header, EOX.
    if (dn <= 7 || d[0] != '\xF0' || d[1] != '\x08' || d[2] != '\x00' 
            || d[3] != '\x4B' || d[4] != '\x59' || d[5] != '\x7F' 
            || d[6] != '\x33' || d[dn] != '\xF7') {
        emit error("not a Syntech Sysex");
        return;
        }
    tot = (dn - 7) / 119;
    if (!tot || tot > 50 || tot * 119 != dn - 7) {
        emit error("not a valid Syntech Sysex");
        return;
        }

    // For each 119-byte program chunk...
    pn = ti = 0;
    di = 7;
    while (di < dn) {

        // Make sure each program number increases, but not past 50.
        if (d[di] <= pn || d[di] > 50) {
            emit error("invalid program number in Syntech Sysex");
            return;
            }

        // Parse names and increment pn until it equals new program number.
        do {
            n.clear();
            while (ti < tn) {
                char c = t[ti++];
                if (c == '\n')
                    break;
                else if (' ' <= c && c <= '~')
                    n += c;
                }
            } while (++pn < d[di]);
        ++di;

        // Combine nibbles into bytes, split packed parameters into buffer.
        bit = byt = bsr = 0;
        for (param_descr const& desc: param_descrs) {
            if (bit <= 0) { // should never be <0
                dh = d[di++];
                dl = d[di++];
                if (dh > 15 || dl > 15) {
                    emit error("invalid Syntech data");
                    return;
                    }
                bsr = 16 * dh + dl;
                bit = 8;
                }
            if (desc.bits < 0) {
                int8_t v = bsr;
                bsr <<= -desc.bits;
                bit += desc.bits;
                if (desc.offs != 0xFF)
                    opbytes[desc.offs] = v >> (8 + desc.bits);
                }
            else {
                uint8_t v = bsr;
                bsr <<= desc.bits;
                bit -= desc.bits;
                if (desc.offs != 0xFF)
                    opbytes[desc.offs] = int8_t(v >> (8 - desc.bits));
                }
            }

        // Convert individual program.
        convertProgram(pn, n.trimmed());
        }
    }

/* void ChromaConverter::convertAudio(o_channel const& oc, --------------------
    n_channel& nc); This converts the old Chroma channel audio processing 
parameters oc into new Digital Chroma channel parameters nc. The latter has 
already been cleared.                                                        */

void ChromaConverter::convertAudio(o_channel const& oc, n_channel& nc) {

    static int8_t const conv_sel[] = {
         0, //  0 glide A
         1, //  1 sweep A
         2, //  2 envelope 1A
         3, //  3 envelope 2A
         4, //  4 glide B
         5, //  5 sweep B
         6, //  6 envelope 1B
         7, //  7 envelope 2B
        10, //  8 lever 1
        11, //  9 lever 2
        14, // 10 pedal 1
        15, // 11 pedal 2
        22, // 12 velocity
        23, // 13 threshold velocity
        24, // 14 pressure
        25, // 15 threshold pressure
        };

    // OSCILLATOR -------------------------------------------------------------

    // Translate tune.
    nc.osc_tune = oc.pch_tune + 52;

    // Translate mods.
    nc.osc_mod1_sel = conv_sel[oc.pch_mod1_sel];
    nc.osc_mod1_dep = convertDepth(oc.pch_mod1_dep, oc.pch_mod1_sel, 16, true);
    nc.osc_mod2_sel = conv_sel[oc.pch_mod2_sel];
    nc.osc_mod2_dep = convertDepth(oc.pch_mod2_dep, oc.pch_mod2_sel, 4, true);
    nc.osc_mod3_sel = conv_sel[oc.pch_mod3_sel];
    nc.osc_mod3_dep = convertDepth(oc.pch_mod3_dep, oc.pch_mod3_sel, 1, true);

    // Supply default selects.
    if (nc.osc_mod1_dep == 64)
        nc.osc_mod1_sel = 8;
    if (nc.osc_mod2_dep == 64)
        nc.osc_mod2_sel = 1;
    if (nc.osc_mod3_dep == 64)
        nc.osc_mod3_sel = 3;
    nc.osc_mod4_sel = 5;
    nc.osc_mod4_dep = 64;
    nc.osc_mod5_sel = 7;
    nc.osc_mod5_dep = 64;

    // WAVESHAPER -------------------------------------------------------------

    // Translate shape and width.
    nc.wav_shape = int8_p{
             0, //  0 saws
             1, //  1 pulse
            15, //  2 pink noise
            16, //  3 white noise
            }[oc.wav_shape];
    if (oc.wav_width == 63)
        nc.wav_width = 127;
    else
        nc.wav_width = 2 * oc.wav_width;

    // Translate mod.
    nc.wav_mod1_sel = conv_sel[oc.wav_mod_sel];
    nc.wav_mod1_dep = convertDepth(oc.wav_mod_dep, oc.wav_mod_sel, 1, false);

    // Supply default selects.
    if (nc.wav_mod1_dep == 64)
        nc.wav_mod1_sel = 1;
    nc.wav_mod2_sel = 3;
    nc.wav_mod2_dep = 64;

    // FILTER -----------------------------------------------------------------

    // Translate mode and tune.
    nc.flt_mode = 4 * oc.cut_lphp;
    nc.flt_tune = min(127, 31 + 2 * oc.cut_tune);

    // Translate resonance.
    nc.flt_res = int8_p{ 0, 12, 24, 36, 48, 80, 124, 126 }[oc.cut_res];

    // Translate mods.
    nc.flt_mod1_sel = conv_sel[oc.cut_mod1_sel];
    nc.flt_mod1_dep = convertDepth(oc.cut_mod1_dep, oc.cut_mod1_sel, 1, true);
    nc.flt_mod2_sel = conv_sel[oc.cut_mod2_sel];
    nc.flt_mod2_dep = convertDepth(oc.cut_mod2_dep, oc.cut_mod2_sel, 1, true);
    nc.flt_mod3_sel = conv_sel[oc.cut_mod3_sel];
    nc.flt_mod3_dep = convertDepth(oc.cut_mod3_dep, oc.cut_mod3_sel, 1, true);

    // Supply default selects.
    if (!nc.flt_mod1_dep)
        nc.flt_mod1_sel = 0;
    if (!nc.flt_mod2_dep)
        nc.flt_mod2_sel = 1;
    if (!nc.flt_mod3_dep)
        nc.flt_mod3_sel = 3;
    nc.flt_mod4_sel = 5;
    nc.flt_mod4_dep = 64;
    nc.flt_mod5_sel = 7;
    nc.flt_mod5_dep = 64;
    nc.flt_res_mod_sel = 6;
    nc.flt_res_mod_dep = 64;

    // AMPLIFIER --------------------------------------------------------------

    static int8_t const conv_vol_mod_dep[] = {
             0, 18, 20, 23, 25, 28, 32, 36, 
            40, 45, 51, 57, 64, 71, 80, 90 };

    static int8_t const conv_vol_mod3_sel[] = {
             4, // none        -> pedal 1 default
            11, // pressure    -> pressure
             9, // keyboard    -> keyboard
            12, // sweep A     -> sweep
             4, // pedal 1     -> pedal 1
             4, // inv pedal 1 -> -pedal 1
             5, // pedal 2     -> pedal 2
             5, // inv pedal 2 -> -pedal 2
            };

    static int8_t const conv_vol_mod3_dep[] = {
            64,    // none        -> off
            64+32, // pressure    -> 50%
            64-32, // keyboard    -> -25%
            64+22, // sweep A     -> 37.5%
            64+63, // pedal 1     -> 100%
            64-64, // inv pedal 1 -> -100%
            64+63, // pedal 2     -> 100%
            64-64, // inv pedal 2 -> -100%
            };

    // Translate mods.
    nc.amp_mod1_sel = oc.vol_mod1_sel;
    nc.amp_mod1_dep = conv_vol_mod_dep[oc.vol_mod1_dep];
    nc.amp_mod2_sel = oc.vol_mod2_sel;
    nc.amp_mod2_dep = conv_vol_mod_dep[oc.vol_mod2_dep];

    // Translate postmod.
    nc.amp_postmod_sel = conv_vol_mod3_sel[oc.vol_mod3_sel];
    nc.amp_postmod_dep = conv_vol_mod3_dep[oc.vol_mod3_sel];
    if (oc.vol_mod3_sel == 3) {
        if (swpGainA < 0) {
            nc.amp_postmod_dep -= 7;
            nc.amp_mod1_dep = nc.amp_mod1_dep * 9 / 10;
            nc.amp_mod2_dep = nc.amp_mod2_dep * 9 / 10;
            }
        else if (swpGainA > 0) {
            nc.amp_postmod_dep += 7;
            nc.amp_mod1_dep = nc.amp_mod1_dep * 10 / 9;
            nc.amp_mod2_dep = nc.amp_mod2_dep * 10 / 9;
            }
        }

    // Supply default selects.
    if (!nc.amp_mod1_dep)
        nc.amp_mod1_sel = 0;
    if (!nc.amp_mod2_dep)
        nc.amp_mod2_sel = 2;
    if (!nc.amp_postmod_dep)
        nc.amp_postmod_sel = 4;
    nc.amp_pan_mod_sel = 5;
    nc.amp_pan_mod_dep = 64;
    }

/* int ChromaConverter::convertControls(o_channel const& oc, n_channel& nc, ---
    bool b); -- This converts the old Chroma channel control signal generator 
parameters oc into new Digital Chroma channel parameters nc. The latter has 
already been cleared. If these are the B channel, b is true. Since certain 
things change the sweep amplitude relative to the old Chroma, and must be 
compensated for by adjusting the depths of various sweep mods, this returns the 
log2 of the necessary adjustment.                                            */

int ChromaConverter::convertControls(o_channel const& oc, n_channel& nc, 
        bool b) {
    int     g;      // log2 of sweep depth adjustment

    // GLIDE ------------------------------------------------------------------

    // Translate glide shape, with different tables for two types.
    if (oc.gld_shape) {
        nc.gld_shape = 3;
        nc.gld_time = int8_p{
                 0,   1,  17,  24,  31,  35,  39,  43,
                46,  59,  53,  57,  61,  63,  67,  71, 
                74,  77,  79,  81,  83,  86,  88,  91, 
                94,  98, 102, 106, 111, 117, 123, 127 }[oc.gld_rate];
        }
    else
        nc.gld_time = int8_p{
                 0,  16,  20,  24,  27,  31,  34,  38, 
                41,  45,  48,  51,  55,  58,  62,  65, 
                69,  72,  76,  79,  82,  86,  89,  93, 
                96, 100, 103, 107, 110, 113, 117, 120 }[oc.gld_rate];

    // Default glide mod select is pedal 2.
    nc.gld_mod_sel = 7;
    nc.gld_mod_dep = 64;

    // SWEEP RATE -------------------------------------------------------------

    // Translate mode and rate.
    nc.swp_mode = oc.swp_mode;
    nc.swp_rate = 5 + oc.swp_rate * 96 / 63; // 5..101

    // Translate rate mod into select and depth.
    nc.swp_rate_mod_sel = int8_p{
            20, // none        -> random (default)
            15, // pressure    -> pressure
            13, // note        -> pitch
            13, // -note       -> pitch
            14, // velocity    -> velocity
            14, // -velocity   -> velocity
            16, // envelope 2  -> envelope 2A
            16, // -envelope 2 -> envelope 2A
             6, // pedal 1     -> pedal 1
             6, // -pedal 1    -> pedal 1
             7, // pedal 2     -> pedal 2
             7, // -pedal 2    -> pedal 2
             2, // lever 1     -> lever 1
             2, // -lever 1    -> lever 1
             3, // lever 2     -> lever 2
             3, // -lever 2    -> lever 2
            }[oc.swp_rate_mod];
    nc.swp_rate_mod_dep = int8_p{
            64,    // none        -> off
            64+20, // pressure    -> +17%
            64+10, // pitch       -> +8.5%
            64-10, // -pitch      -> -8.5%
            64+20, // velocity    -> +17%
            64-20, // -velocity   -> -17%
            64+10, // envelope 2  -> +8.5%
            64-10, // -envelope 2 -> -8.5%
            64+20, // pedal 1     -> +17%
            64-20, // -pedal 1    -> -17%
            64+20, // pedal 2     -> +17%
            64-20, // -pedal 2    -> -17%
            64+5,  // lever 1     -> +4%
            64-5,  // -lever 1    -> -4%
            64+5,  // lever 2     -> +4%
            64-5,  // -lever 2    -> -4%
            }[oc.swp_rate_mod];

    // In poly mode with no rate mod, apply random mod on slow side only.
    if (!nc.swp_mode && !oc.swp_rate_mod) {
        nc.swp_rate = max(0, nc.swp_rate - 2);
        nc.swp_rate_mod_dep = 64+4;
        }

    // If B channel, change envelope 2A mod to 2B.
    if (b && nc.swp_rate_mod_sel == 16)
        nc.swp_rate_mod_sel = 17;
        
    // If velocity mod, adjust base rate so midscale velocity is zero mod.
    if (oc.swp_rate_mod == 4)
        nc.swp_rate = max(0, nc.swp_rate - 18);
    else if (oc.swp_rate_mod == 5)
        nc.swp_rate = min(119, nc.swp_rate + 18);

    // Translate sweep shape.
    nc.swp_shape = int8_p{
             0, // sine          -> sine
             1, // cosine        -> cosine
             2, // raised sine   -> raised sine
             3, // half sine     -> half sine
             4, // triangle      -> triangle
             5, // cotriangle    -> cotriangle
             6, // sawtooth      -> sawtooth
             8, // lagged square -> rising square
             8, // square        -> rising square
            10, // 3 down        -> 3 down
            11, // 4 down/up     -> 4 down/up
            12, // 4 down        -> 4 down
            13, // 6 down/up     -> 6 down/up
            14, // 6 down        -> 6 down
            15, // 8 down/up     -> 8 down/up
             7, // random        -> random
            }[oc.swp_shape];

    // All shapes except lagged square and random are now twice as big, 
    //  so cut sweep mod depths down by 1 factor of 2.
    g = oc.swp_shape == 8 || oc.swp_shape == 15 ? 0 : -1;

    // Translate sweep amplitude mod into select and depth.
    nc.swp_ampl_mod_sel = int8_p{
             2, // none           -> lever 1
            15, // pressure       -> pressure
            13, // keyboard       -> pitch
            13, // -keyboard      -> pitch
            14, // velocity       -> velocity
            14, // -velocity      -> velocity
            16, // envelope 1     -> envelope 1A
            17, // envelope 2     -> envelope 2A
             6, // pedal 1        -> pedal 1
             7, // pedal 2        -> pedal 1
             2, // lever 1        -> lever 1
             3, // lever 2        -> lever 2
            20, // 0.85 sec delay -> 850ms delay
            21, // 1.3 sec delay  -> 1.3s delay
            22, // 2.6 sec delay  -> 2.6s delay
            24, // 5.1 sec delay  -> 5.1s delay
            }[oc.swp_ampl_mod];
    nc.swp_ampl_mod_dep = int8_p{
            64,    // none           -> off
            64+63, // pressure       -> +100%
            64+24, // keyboard       -> +37.5%
            64-24, // -keyboard      -> -37.5%
            64+63, // velocity       -> +100%
            64-64, // -velocity      -> -100%
            64+63, // envelope 1     -> +100%
            64+63, // envelope 2     -> +100%
            64+63, // pedal 1        -> +100%
            64+63, // pedal 2        -> +100%
            64+63, // lever 1        -> +100%
            64+63, // lever 2        -> +100%
            64+63, // 0.85 sec delay -> +100%
            64+63, // 1.3 sec delay  -> +100%
            64+63, // 2.6 sec delay  -> +100%
            64+63, // 5.1 sec delay  -> +100%
            }[oc.swp_ampl_mod];

    // If B channel, change envelope A mod to B.
    if (b && (nc.swp_ampl_mod_sel == 16 || nc.swp_ampl_mod_sel == 17))
        nc.swp_rate_mod_sel += 2;

    // If delay envelope, attenuate sweep mod depth.
    if (oc.swp_ampl_mod >= 20)
        --g;

    // ENVELOPE TRIGGER -------------------------------------------------------

    // Translate trigger, limiting to 2.3s delay, or using sweep A.
    if (oc.env2_del < 31)
        nc.env2_trigger = min(115, 4 * oc.env2_del);
    else
        nc.env2_trigger = 122;

    // ENVELOPE AMPLITUDE -----------------------------------------------------

    static int8_t const conv_env_ampl_touch_sel[] = {
             4, //  fixed       -> linear
             1, //  low         -> 1/8 warp
             2, //  medium low  -> 1/4 warp
             3, //  medium      -> 3/8 warp
             4, //  medium high -> linear
             5, //  high        -> 3/4 warp
             9, //  thresh      -> 1/2 thresh
             9, //  inv thresh  -> 1/2 thresh
            };

    static int8_t const conv_env_ampl_touch_dep[] = {
            64,    // fixed       -> off
            64+63, // low         -> +100%
            64+63, // medium low  -> +100%
            64+63, // medium      -> +100%
            64+63, // medium high -> +100%
            64+63, // high        -> +100%
            64+63, // thresh      -> +100%
            64-64, // inv thresh  -> -100%
            };

    // Translate touch into select and depth.
    nc.env1_peak_mod_sel = conv_env_ampl_touch_sel[oc.env1_ampl_touch];
    nc.env1_peak_mod_dep = conv_env_ampl_touch_dep[oc.env1_ampl_touch];
    nc.env2_peak_mod_sel = conv_env_ampl_touch_sel[oc.env2_ampl_touch];
    nc.env2_peak_mod_dep = conv_env_ampl_touch_dep[oc.env2_ampl_touch];

    // ENVELOPE ATTACK --------------------------------------------------------

    static int8_t const conv_env_attack_mod_sel[] = {
             9, // none         -> pitch (default)
            11, // pressure     -> pressure
             9, // keyboard     -> keyboard
             9, // inv keyboard -> keyboard
            10, // velocity     -> velocity
            10, // inv velocity -> velocity
             4, // pedal 1      -> pedal 1
             5, // pedal 2      -> pedal 2
            };

    static int8_t const conv_env_attack_mod_dep[] = {
            64,    // none         -> off
            64-26, // pressure     -> -40.5%
            64-7,  // keyboard     -> -10%
            64+7,  // inv keyboard -> +10%
            64-13, // velocity     -> -20.5%
            64+13, // inv velocity -> +20.5%
            64-26, // pedal 1      -> -40.5%
            64-26, // pedal 2      -> -40.5%
            };

    // Translate attack.
    nc.env1_att_time = oc.env1_att < 3 ? 10 * oc.env1_att 
                                       : (oc.env1_att - 3) * 91 / 28 + 23;
    nc.env2_att_time = oc.env2_att < 3 ? 10 * oc.env2_att 
                                       : (oc.env2_att - 3) * 91 / 28 + 23;

    // Translate attack mod into select and depth.
    nc.env1_att_mod_sel = conv_env_attack_mod_sel[oc.env1_att_mod];
    nc.env2_att_mod_sel = conv_env_attack_mod_sel[oc.env2_att_mod];
    nc.env1_att_mod_dep = conv_env_attack_mod_dep[oc.env1_att_mod];
    nc.env2_att_mod_dep = conv_env_attack_mod_dep[oc.env2_att_mod];
    if (oc.env1_att_mod == 4)
        nc.env1_att_time = min(127, nc.env1_att_time + 13);
    else if (oc.env1_att_mod == 5)
        nc.env1_att_time = max(0, nc.env1_att_time - 13);
    if (oc.env2_att_mod == 4)
        nc.env2_att_time = min(127, nc.env2_att_time + 13);
    else if (oc.env2_att_mod == 5)
        nc.env2_att_time = max(0, nc.env2_att_time - 13);

    // ENVELOPE DECAY ---------------------------------------------------------

    static int8_t const conv_env_decay_mod_sel[] = {
             9, // none         -> pitch (default)
            11, // pressure     -> pressure
             9, // keyboard     -> pitch
             9, // inv keyboard -> pitch
            10, // velocity     -> velocity
            10, // inv velocity -> velocity
             4, // pedal 1      -> pedal 1
             5, // pedal 2      -> pedal 2
            };

    static int8_t const conv_env_decay_mod_dep[] = {
            64,    // none         -> off
            64+26, // pressure     -> +40.5%
            64+7,  // keyboard     -> +10%
            64-7,  // inv keyboard -> -10%
            64+13, // velocity     -> +20.5%
            64-13, // inv velocity -> -20.5%
            64+26, // pedal 1      -> +40.5%
            64+26, // pedal 2      -> +40.5%
            };

    // Translate decay.
    nc.env1_dec_time = oc.env1_dec < 3 ? 10 * oc.env1_dec 
                                       : (oc.env1_dec - 3) * 91 / 28 + 23;
    nc.env2_dec_time = oc.env2_dec < 3 ? 10 * oc.env2_dec 
                                       : (oc.env2_dec - 3) * 91 / 28 + 23;

    // Translate decay mod into select and depth.
    nc.env1_dec_mod_sel = conv_env_decay_mod_sel[oc.env1_dec_mod];
    nc.env2_dec_mod_sel = conv_env_decay_mod_sel[oc.env2_dec_mod];
    nc.env1_dec_mod_dep = conv_env_decay_mod_dep[oc.env1_dec_mod];
    nc.env2_dec_mod_dep = conv_env_decay_mod_dep[oc.env2_dec_mod];
    if (oc.env1_dec_mod == 4)
        nc.env1_dec_time = max(0, nc.env1_dec_time - 13);
    else if (oc.env1_dec_mod == 5)
        nc.env1_dec_time = min(127, nc.env1_dec_time + 13);
    if (oc.env2_dec_mod == 4)
        nc.env2_dec_time = max(0, nc.env2_dec_time - 13);
    else if (oc.env2_dec_mod == 5)
        nc.env2_dec_time = min(127, nc.env2_dec_time + 13);

    // ENVELOPE RELEASE -------------------------------------------------------

    // Translate release, pretending threshold setting doesn't exist.
    nc.env1_rel_time = oc.env1_rel < 3 ? 10 * oc.env1_rel 
                                       : (oc.env1_rel - 3) * 91 / 28 + 23;
    nc.env2_rel_time = oc.env2_rel < 3 ? 10 * oc.env2_rel 
                                       : (oc.env2_rel - 3) * 91 / 28 + 23;

    // Return sweep depth adjustment.
    return g;
    }

/* int8_t ChromaConverter::convertDepth(int8_t md, int8_t ms, int8_t ds, ------
    bool p); -- This generates a Digital Chroma pitch modulation depth 
parameter from old Chroma depth parameter md, divided by scale factor ds (16 
for oscillator mod 1 or 4 for mod 2). If mod select ms refers to sweep A or 
sweep B, the depth is halved or doubled based on swpGainA or swpGainB. If it 
refers to lever 1 or lever 2, it is negated if requested by the conversion 
parameter. Finally, if p is true, it generates a nonlinear pitch mod for the 
oscillator or filter, instead of a linear one.                               */

int8_t ChromaConverter::convertDepth(int8_t md, int8_t ms, int8_t ds, bool p) {
    float   d;
        
    static float const pitch_depth[128] = {
            -64,    -62,    -60,    -58,    -56,    -54,    -52,    -50, 
            -48,    -46,    -44,    -42,    -40,    -38,    -36,    -35, 
            -34,    -33,    -32,    -31,    -30,    -29,    -28,    -27,    
            -26,    -25,    -24,    -23,    -22,    -21,    -20,    -19,    
            -18,    -17,    -16,    -15,    -14,    -13,    -12,    -11,    
            -10,     -9,     -8,     -7,     -6,     -5,     -4,     -3.5f,  
             -3,     -2.5f,  -2,     -1.7f,  -1.4f,  -1.2f,  -1,     -0.8f, 
             -0.6f,  -0.5f,  -0.4f,  -0.3f,  -0.2f,  -0.15f, -0.1f,  -0.05f,
              0,      0.05f,  0.1f,   0.15f,  0.2f,   0.3f,   0.4f,   0.5f,
              0.6f,   0.8f,   1,      1.2f,   1.4f,   1.7f,   2,      2.5f,
              3,      3.5f,   4,      5,      6,      7,      8,      9, 
             10,     11,     12,     13,     14,     15,     16,     17, 
             18,     19,     20,     21,     22,     23,     24,     25, 
             26,     27,     28,     29,     30,     31,     32,     33, 
             34,     36,     38,     40,     42,     44,     46,     48, 
             50,     52,     54,     56,     58,     60,     62,     64 };

    // Scale depth by ds.
    d = md;
    d /= ds;

    // If using sweep shape, adjust depth.
    if (ms == 1) {
        if (swpGainA < 0)
            d *= 0.5f;
        else if (swpGainA > 0)
            d *= 2;
        }
    else if (ms == 2) {
        if (swpGainB < 0)
            d *= 0.5f;
        else if (swpGainB > 0)
            d *= 2;
        }

    // If using inverted lever, negate.
    else if (ms == 8) {
        if (m_invert1)
            d = -d;
        }
    else if (ms == 9) {
        if (m_invert2)
            d = -d;
        }

    // If this is a pitch mod, find closest one in table.
    if (p) {
        float const* r = lower_bound(pitch_depth, pitch_depth + 128, d);
        if (r == pitch_depth)
            return 0;
        else if (r == pitch_depth + 128)
            return 127;
        else if (d - r[-1] == r[0] - d) // round ties away from zero
            return md < 0 ? r - pitch_depth - 1 : r - pitch_depth;
        else if (d - r[-1] < r[0] - d)
            return r - pitch_depth - 1;
        else
            return r - pitch_depth;
        }

    // Otherwise, round and limit range, rounding ties away from zero.
    else
        return min(127, max(0, 64 + int(roundf(d))));
    }

/* void ChromaConverter::convertProgram(int pn, QString n); -------------------
This converts the unpacked old Chroma program in op to a Digital Chroma 
program, appends the necessary metadata, and emits it in a program signal. The 
program number is pn, and the name is n.                                     */

void ChromaConverter::convertProgram(int pn, QString n) {
    int             d;          // days since epoch
    uint32_t        g;          // gangs metadata
    uint16_t const* mo;         // month offsets
    QByteArray      nprog;      // new program
    int             s;          // time since start of day

    // Allocate space for new program, name, and possible gangs metadata.
    nprog.reserve(sizeof(n_program) + n.size() + 21);

    // Point to new program as struct.
    n_program& np = *reinterpret_cast<n_program*>(nprog.data());

    // Clear all new parameters.
    nprog.resize(sizeof(n_program));
    memset(&np, 0, sizeof(n_program));

    // Get timestamp, supply random 100us digit, but ensure increasing values.
    lastts = max(QDateTime::currentDateTime().toMSecsSinceEpoch() * 10 
            + rand() % 10 - (365 * 30 + 7) * 86400'0000ll, lastts + 1);

    // Decompose into eight timestamp bytes.
    d = lastts / 86400'0000;
    s = int(lastts) - d * 86400'0000;
    np.ts_100us = s % 100;
    s /= 100;
    np.ts_10ms = s % 100;
    s /= 100;
    np.ts_second = s % 60;
    s /= 60;
    np.ts_minute = s % 60;
    s /= 60;
    np.ts_hour = s;

    // Extract year.
    np.ts_year = d * 4 / 1461;
    d -= (1461 * np.ts_year + 3) / 4;

    // Select month offset table based on leap year.
    if (np.ts_year & 3)
        mo = uint16_p{0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334};
    else
        mo = uint16_p{0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335};

    // Separate month, day.
    np.ts_month = min(11, d / 29);
    if (d >= mo[np.ts_month])
        ++np.ts_month;
    np.ts_day = d - mo[np.ts_month - 1] + 1;

    // Translate common parameters.
    np.link_detune = np.link_spread = 64;
    np.link_number = max(1, min(50, int(op.link_num)));
    np.link_mode = op.link_mode;
    np.link_balance = 64 + op.link_balance * 2;
    np.kybd_split = (60 + op.kbd_split) & 0x7F;
    np.main_transpose = int8_p{ 64, 65, 63, 64 }[op.main_trans];
    np.link_transpose = int8_p{ 64, 65, 63, 64 }[op.link_trans];
    np.edit_mode = op.edit_mode ? op.edit_mode : 3;
    np.edit_number = 64 + max(0, min(50, int(op.edit_num)));
    np.sequence_number = max(1, min(50, int(op.seq_num)));
    np.fsw_mode = op.fsw_mode;
    np.kybd_alg = int8_p{
             0, //  0 poly
             1, //  1 pitch ordered
             2, //  2 chord buffer
             1, //  3 poly all => poly
             3, //  4 mono all => mono single
             3, //  5 mono single
             4, //  6 mono multiple
             5, //  7 mono first
             6, //  8 mono bottom
             7, //  9 mono top
             8, // 10 arpeg up
             9, // 11 arpeg down
            10, // 12 arpeg up/down
            11, // 13 arpeg down/up
            12, // 14 arpeg sequence
            13, // 15 arpeg random
            }[op.kbd_alg];

    // Translate control parameters.
    np.treble_gain = np.treble_freq = np.middle_gain = np.middle_freq 
            = np.bass_gain = np.bass_freq = np.distortion = 64;
    np.patch = int8_p{
             1, //  0 single channel
             1, //  1 independent
             2, //  2 independent, sync
             3, //  3 independent, ring mod
             5, //  4 independent, filter FM
             6, //  5 parallel
             7, //  6 parallel, sync
             8, //  7 parallel, ring mod
            10, //  8 parallel, filter FM
            11, //  9 series
            12, // 10 series, sync
            13, // 11 series, ring mod
            15, // 12 series, filter FM
            16, // 13 vari-mix
            17, // 14 vari-mix, sync
            18, // 15 vari-mix, ring mod
            }[op.patch];
    np.voice_count = m_voiceCount;
    np.detune = op.detune * 100 / 32;
    if (op.detune >= 16)
        np.detune += 64 - 100;
    else
        np.detune += 64;
    np.tune_shift = 64 + m_tuneShift;
    np.tune_spread = m_tuneSpread;
    np.pan_spread = m_panSpread;
    np.lever_modes = m_selective1 + 3 * m_selective2;

    // Translate channel parameters.
    swpGainA = convertControls(op.a, np.a, false);
    swpGainB = convertControls(op.b, np.b, true);
    convertAudio(op.a, np.a);
    convertAudio(op.b, np.b);

    // Bump B pitch if detune was over a quartertone.
    if (op.detune >= 16 && np.b.osc_tune < 127)
        ++np.b.osc_tune;

    // Emulate patch 0 by turning B volume off.
    if (!op.patch)
        np.b.amp_mod1_dep = np.b.amp_mod2_dep = 0;

    // Compute gangs metadatum.
    g = 0;
    if (np.a.gld_time == np.b.gld_time && np.a.gld_shape == np.b.gld_shape 
            && np.a.gld_mod_sel == np.b.gld_mod_sel 
            && np.a.gld_mod_dep == np.b.gld_mod_dep)
        g |= 1 << 0;
    if (np.a.swp_mode == np.b.swp_mode && np.a.swp_rate == np.b.swp_rate 
            && np.a.swp_rate_mod_sel == np.b.swp_rate_mod_sel
            && np.a.swp_rate_mod_dep == np.b.swp_rate_mod_dep)
        g |= 1 << 1;
    if (np.a.swp_shape == np.b.swp_shape 
            && np.a.swp_ampl_mod_sel == np.b.swp_ampl_mod_sel
            && np.a.swp_ampl_mod_dep == np.b.swp_ampl_mod_dep)
        g |= 1 << 2;
    if (np.a.env1_peak_mod_sel == np.b.env1_peak_mod_sel 
            && np.a.env1_peak_mod_dep == np.b.env1_peak_mod_dep)
        g |= 1 << 3;
    if (np.a.env1_att_time == np.b.env1_att_time 
            && np.a.env1_att_conserv == np.b.env1_att_conserv 
            && np.a.env1_att_mod_sel == np.b.env1_att_mod_sel 
            && np.a.env1_att_mod_dep == np.b.env1_att_mod_dep)
        g |= 1 << 4;
    if (np.a.env1_dec_time == np.b.env1_dec_time 
            && np.a.env1_dec_self_mod == np.b.env1_dec_self_mod 
            && np.a.env1_dec_mod_sel == np.b.env1_dec_mod_sel 
            && np.a.env1_dec_mod_dep == np.b.env1_dec_mod_dep)
        g |= 1 << 5;
    if (np.a.env1_rel_time == np.b.env1_rel_time 
            && np.a.env1_rel_mod == np.b.env1_rel_mod)
        g |= 1 << 6;
    if (np.a.env2_trigger == np.b.env2_trigger)
        g |= 1 << 7;
    if (np.a.env2_peak_mod_sel == np.b.env2_peak_mod_sel 
            && np.a.env2_peak_mod_dep == np.b.env2_peak_mod_dep)
        g |= 1 << 8;
    if (np.a.env2_att_time == np.b.env2_att_time 
            && np.a.env2_att_conserv == np.b.env2_att_conserv 
            && np.a.env2_att_mod_sel == np.b.env2_att_mod_sel 
            && np.a.env2_att_mod_dep == np.b.env2_att_mod_dep)
        g |= 1 << 9;
    if (np.a.env2_dec_time == np.b.env2_dec_time 
            && np.a.env2_dec_self_mod == np.b.env2_dec_self_mod 
            && np.a.env2_dec_mod_sel == np.b.env2_dec_mod_sel 
            && np.a.env2_dec_mod_dep == np.b.env2_dec_mod_dep)
        g |= 1 << 10;
    if (np.a.env2_rel_time == np.b.env2_rel_time 
            && np.a.env2_rel_mod == np.b.env2_rel_mod)
        g |= 1 << 11;
    if (np.a.osc_tune == np.b.osc_tune)
        g |= 1 << 12;
    if (np.a.osc_mod1_sel == np.b.osc_mod1_sel 
            && np.a.osc_mod1_dep == np.b.osc_mod1_dep 
            && np.a.osc_mod1_steps == np.b.osc_mod1_steps)
        g |= 1 << 13;
    if (np.a.osc_mod2_sel == np.b.osc_mod2_sel 
            && np.a.osc_mod2_dep == np.b.osc_mod2_dep)
        g |= 1 << 14;
    if (np.a.osc_mod3_sel == np.b.osc_mod3_sel 
            && np.a.osc_mod3_dep == np.b.osc_mod3_dep)
        g |= 1 << 15;
    if (np.a.osc_mod4_sel == np.b.osc_mod4_sel 
            && np.a.osc_mod4_dep == np.b.osc_mod4_dep)
        g |= 1 << 16;
    if (np.a.osc_mod5_sel == np.b.osc_mod5_sel 
            && np.a.osc_mod5_dep == np.b.osc_mod5_dep)
        g |= 1 << 17;
    if (np.a.wav_shape == np.b.wav_shape 
            && np.a.wav_width == np.b.wav_width)
        g |= 1 << 18;
    if (np.a.wav_mod1_sel == np.b.wav_mod1_sel 
            && np.a.wav_mod1_dep == np.b.wav_mod1_dep)
        g |= 1 << 19;
    if (np.a.wav_mod2_sel == np.b.wav_mod2_sel 
            && np.a.wav_mod2_dep == np.b.wav_mod2_dep)
        g |= 1 << 20;
    if (np.a.flt_mode == np.b.flt_mode 
            && np.a.flt_tune == np.b.flt_tune)
        g |= 1 << 21;
    if (np.a.flt_mod1_sel == np.b.flt_mod1_sel 
            && np.a.flt_mod1_dep == np.b.flt_mod1_dep 
            && np.a.flt_mod1_steps == np.b.flt_mod1_steps)
        g |= 1 << 22;
    if (np.a.flt_mod2_sel == np.b.flt_mod2_sel 
            && np.a.flt_mod2_dep == np.b.flt_mod2_dep)
        g |= 1 << 23;
    if (np.a.flt_mod3_sel == np.b.flt_mod3_sel 
            && np.a.flt_mod3_dep == np.b.flt_mod3_dep)
        g |= 1 << 24;
    if (np.a.flt_mod4_sel == np.b.flt_mod4_sel 
            && np.a.flt_mod4_dep == np.b.flt_mod4_dep)
        g |= 1 << 25;
    if (np.a.flt_mod5_sel == np.b.flt_mod5_sel 
            && np.a.flt_mod5_dep == np.b.flt_mod5_dep)
        g |= 1 << 26;
    if (np.a.flt_res == np.b.flt_res 
            && np.a.flt_res_mod_sel == np.b.flt_res_mod_sel 
            && np.a.flt_res_mod_dep == np.b.flt_res_mod_dep)
        g |= 1 << 27;
    if (np.a.amp_mod1_sel == np.b.amp_mod1_sel 
            && np.a.amp_mod1_dep == np.b.amp_mod1_dep)
        g |= 1 << 28;
    if (np.a.amp_mod2_sel == np.b.amp_mod2_sel 
            && np.a.amp_mod2_dep == np.b.amp_mod2_dep)
        g |= 1 << 29;
    if (np.a.amp_postmod_sel == np.b.amp_postmod_sel 
            && np.a.amp_postmod_dep == np.b.amp_postmod_dep)
        g |= 1 << 30;
    if (np.a.amp_pan == np.b.amp_pan 
            && np.a.amp_pan_mod_sel == np.b.amp_pan_mod_sel 
            && np.a.amp_pan_mod_dep == np.b.amp_pan_mod_dep)
        g |= 1u << 31;

    // Create resulting program.
    if (~g) {
        nprog.append("gangs=");
        nprog.append("0123456789abcdef"[g >> 28]);
        nprog.append("0123456789abcdef"[g >> 24 & 0xF]);
        nprog.append("0123456789abcdef"[g >> 20 & 0xF]);
        nprog.append("0123456789abcdef"[g >> 16 & 0xF]);
        nprog.append("0123456789abcdef"[g >> 12 & 0xF]);
        nprog.append("0123456789abcdef"[g >> 8 & 0xF]);
        nprog.append("0123456789abcdef"[g >> 4 & 0xF]);
        nprog.append("0123456789abcdef"[g & 0xF]);
        nprog.append('\n');
        }
    if (n.size()) {
        nprog.append("name=");
        nprog.append(n);
        nprog.append('\n');
        }

    // Emit as program signal.
    emit program(pn, nprog);
    }

/* void ChromaConverter::set???(??? ???); -------------------------------------
These set the various parameters, generating change signals if they actually 
change.                                                                      */

void ChromaConverter::setInvert1(bool invert1) {

    if (m_invert1 != invert1)
        emit invert1Changed(m_invert1 = invert1);
    }

void ChromaConverter::setInvert2(bool invert2) {

    if (m_invert2 != invert2)
        emit invert2Changed(m_invert2 = invert2);
    }

void ChromaConverter::setPanSpread(int panSpread) {

    if (m_panSpread != panSpread && 0 <= panSpread && panSpread <= 127)
        emit panSpreadChanged(m_panSpread = panSpread);
    }

void ChromaConverter::setSelective1(bool selective1) {

    if (m_selective1 != selective1)
        emit selective1Changed(m_selective1 = selective1);
    }

void ChromaConverter::setSelective2(bool selective2) {

    if (m_selective2 != selective2)
        emit selective2Changed(m_selective2 = selective2);
    }

void ChromaConverter::setTuneShift(int tuneShift) {

    if (m_tuneShift != tuneShift && -64 <= tuneShift && tuneShift <= 63)
        emit tuneShiftChanged(m_tuneShift = tuneShift);
    }

void ChromaConverter::setTuneSpread(int tuneSpread) {

    if (m_tuneSpread != tuneSpread && -64 <= tuneSpread && tuneSpread <= 63)
        emit tuneSpreadChanged(m_tuneSpread = tuneSpread);
    }

void ChromaConverter::setVoiceCount(int voiceCount) {

    if (m_voiceCount != voiceCount && 1 <= voiceCount && voiceCount <= 4)
        emit voiceCountChanged(m_voiceCount = voiceCount);
    }
