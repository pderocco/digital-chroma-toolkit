import QtQuick 2.13
import QtQuick.Layouts 1.13
import "Util.js" as Util

Item {
    id: root

    // ARCHIECTURE PROPERTIES -------------------------------------------------

    readonly property int   archNum:    0
    readonly property int   archVer:    0

    // PARAMETER COUNTS -------------------------------------------------------

    readonly property var   pagelen:    [36, 79, 79]

    // PARAMETER VALUES PROPERTIES --------------------------------------------
    //  Page p number n is encoded as "p" followed by 128*p+n.

    property int p0:   defs[0][0];  property alias p_link_bank:              root.p0
    property int p1:   defs[0][1];  property alias p_link_number:            root.p1
    property int p2:   defs[0][2];  property alias p_link_mode:              root.p2
    property int p3:   defs[0][3];  property alias p_link_balance:           root.p3
    property int p4:   defs[0][4];  property alias p_link_spread:            root.p4
    property int p5:   defs[0][5];  property alias p_link_detune:            root.p5
    property int p6:   defs[0][6];  property alias p_keyboard_split:         root.p6
    property int p7:   defs[0][7];  property alias p_main_transpose:         root.p7
    property int p8:   defs[0][8];  property alias p_link_transpose:         root.p8
    property int p9:   defs[0][9];  property alias p_edit_mode:              root.p9
    property int p10:  defs[0][10]; property alias p_edit_number:            root.p10
    property int p11:  defs[0][11]; property alias p_sequence_bank:          root.p11
    property int p12:  defs[0][12]; property alias p_sequence_number:        root.p12
    property int p13:  defs[0][13]; property alias p_fsw_mode:               root.p13
    property int p14:  defs[0][14]; property alias p_ribbon_alg:             root.p14
    property int p15:  defs[0][15]; property alias p_kybd_alg:               root.p15

    // Control parameters
    property int p16:  defs[0][16]; property alias p_bass_gain:              root.p16;  readonly property int n_bass_gain:              16
    property int p17:  defs[0][17]; property alias p_bass_freq:              root.p17;  readonly property int n_bass_freq:              17
    property int p18:  defs[0][18]; property alias p_middle_gain:            root.p18;  readonly property int n_middle_gain:            18
    property int p19:  defs[0][19]; property alias p_middle_freq:            root.p19;  readonly property int n_middle_freq:            19
    property int p20:  defs[0][20]; property alias p_middle_res:             root.p20;  readonly property int n_middle_res:             20
    property int p21:  defs[0][21]; property alias p_treble_gain:            root.p21;  readonly property int n_treble_gain:            21
    property int p22:  defs[0][22]; property alias p_treble_freq:            root.p22;  readonly property int n_treble_freq:            22
    property int p23:  defs[0][23]; property alias p_distortion:             root.p23;  readonly property int n_distortion:             23
    property int p24:  defs[0][24]; property alias p_patch:                  root.p24;  readonly property int n_patch:                  24
    property int p25:  defs[0][25]; property alias p_voice_count:            root.p25;  readonly property int n_voice_count:            25
    property int p26:  defs[0][26]; property alias p_detune:                 root.p26;  readonly property int n_detune:                 26
    property int p27:  defs[0][27]; property alias p_detune_scale:           root.p27;  readonly property int n_detune_scale:           27
    property int p28:  defs[0][28]; property alias p_tune_shift:             root.p28;  readonly property int n_tune_shift:             28
    property int p29:  defs[0][29]; property alias p_tune_spread:            root.p29;  readonly property int n_tune_spread:            29
    property int p30:  defs[0][30]; property alias p_pan_spread:             root.p30;  readonly property int n_pan_spread:             30
    property int p31:  defs[0][31]; property alias p_lever_modes:            root.p31;  readonly property int n_lever_modes:            31
    property int p32:  defs[0][32]; property alias p_pedal_modes:            root.p32;  readonly property int n_pedal_modes:            32
    property int p33:  defs[0][33]; property alias p_ribbon_mode:            root.p33;  readonly property int n_ribbon_mode:            33
    property int p34:  defs[0][34]; property alias p_reverb_room:            root.p34;  readonly property int n_reverb_room:            34
    property int p35:  defs[0][35]; property alias p_reverb_send:            root.p35;  readonly property int n_reverb_send:            35

    // A channel parameters
    property int p128: defs[1][0];  property alias p_gldA_time:              root.p128; readonly property int n_gldA_time:              128
    property int p129: defs[1][1];  property alias p_gldA_shape:             root.p129; readonly property int n_gldA_shape:             129
    property int p130: defs[1][2];  property alias p_gldA_mod_sel:           root.p130; readonly property int n_gldA_mod_sel:           130
    property int p131: defs[1][3];  property alias p_gldA_mod_dep:           root.p131; readonly property int n_gldA_mod_dep:           131
    property int p132: defs[1][4];  property alias p_swpA_mode:              root.p132; readonly property int n_swpA_mode:              132
    property int p133: defs[1][5];  property alias p_swpA_rate:              root.p133; readonly property int n_swpA_rate:              133
    property int p134: defs[1][6];  property alias p_swpA_rate_mod_sel:      root.p134; readonly property int n_swpA_rate_mod_sel:      134
    property int p135: defs[1][7];  property alias p_swpA_rate_mod_dep:      root.p135; readonly property int n_swpA_rate_mod_dep:      135
    property int p136: defs[1][8];  property alias p_swpA_wave_shape:        root.p136; readonly property int n_swpA_wave_shape:        136
    property int p137: defs[1][9];  property alias p_swpA_ampl_mod_sel:      root.p137; readonly property int n_swpA_ampl_mod_sel:      137
    property int p138: defs[1][10]; property alias p_swpA_ampl_mod_dep:      root.p138; readonly property int n_swpA_ampl_mod_dep:      138
    property int p139: defs[1][11]; property alias p_env1A_peak_mod_sel:     root.p139; readonly property int n_env1A_peak_mod_sel:     139
    property int p140: defs[1][12]; property alias p_env1A_peak_mod_dep:     root.p140; readonly property int n_env1A_peak_mod_dep:     140
    property int p141: defs[1][13]; property alias p_env1A_att_time:         root.p141; readonly property int n_env1A_att_time:         141
    property int p142: defs[1][14]; property alias p_env1A_att_conserv:      root.p142; readonly property int n_env1A_att_conserv:      142
    property int p143: defs[1][15]; property alias p_env1A_att_mod_sel:      root.p143; readonly property int n_env1A_att_mod_sel:      143
    property int p144: defs[1][16]; property alias p_env1A_att_mod_dep:      root.p144; readonly property int n_env1A_att_mod_dep:      144
    property int p145: defs[1][17]; property alias p_env1A_dec_time:         root.p145; readonly property int n_env1A_dec_time:         145
    property int p146: defs[1][18]; property alias p_env1A_dec_self_mod:     root.p146; readonly property int n_env1A_dec_self_mod:     146
    property int p147: defs[1][19]; property alias p_env1A_dec_mod_sel:      root.p147; readonly property int n_env1A_dec_mod_sel:      147
    property int p148: defs[1][20]; property alias p_env1A_dec_mod_dep:      root.p148; readonly property int n_env1A_dec_mod_dep:      148
    property int p149: defs[1][21]; property alias p_env1A_rel_time:         root.p149; readonly property int n_env1A_rel_time:         149
    property int p150: defs[1][22]; property alias p_env1A_rel_mod:          root.p150; readonly property int n_env1A_rel_mod:          150
    property int p151: defs[1][23]; property alias p_env2A_trigger:          root.p151; readonly property int n_env2A_trigger:          151
    property int p152: defs[1][24]; property alias p_env2A_peak_mod_sel:     root.p152; readonly property int n_env2A_peak_mod_sel:     152
    property int p153: defs[1][25]; property alias p_env2A_peak_mod_dep:     root.p153; readonly property int n_env2A_peak_mod_dep:     153
    property int p154: defs[1][26]; property alias p_env2A_att_time:         root.p154; readonly property int n_env2A_att_time:         154
    property int p155: defs[1][27]; property alias p_env2A_att_conserv:      root.p155; readonly property int n_env2A_att_conserv:      155
    property int p156: defs[1][28]; property alias p_env2A_att_mod_sel:      root.p156; readonly property int n_env2A_att_mod_sel:      156
    property int p157: defs[1][29]; property alias p_env2A_att_mod_dep:      root.p157; readonly property int n_env2A_att_mod_dep:      157
    property int p158: defs[1][30]; property alias p_env2A_dec_time:         root.p158; readonly property int n_env2A_dec_time:         158
    property int p159: defs[1][31]; property alias p_env2A_dec_self_mod:     root.p159; readonly property int n_env2A_dec_self_mod:     159
    property int p160: defs[1][32]; property alias p_env2A_dec_mod_sel:      root.p160; readonly property int n_env2A_dec_mod_sel:      160
    property int p161: defs[1][33]; property alias p_env2A_dec_mod_dep:      root.p161; readonly property int n_env2A_dec_mod_dep:      161
    property int p162: defs[1][34]; property alias p_env2A_rel_time:         root.p162; readonly property int n_env2A_rel_time:         162
    property int p163: defs[1][35]; property alias p_env2A_rel_mod:          root.p163; readonly property int n_env2A_rel_mod:          163
    property int p164: defs[1][36]; property alias p_oscA_tune:              root.p164; readonly property int n_oscA_tune:              164
    property int p165: defs[1][37]; property alias p_oscA_mod1_sel:          root.p165; readonly property int n_oscA_mod1_sel:          165
    property int p166: defs[1][38]; property alias p_oscA_mod1_dep:          root.p166; readonly property int n_oscA_mod1_dep:          166
    property int p167: defs[1][39]; property alias p_oscA_mod1_steps:        root.p167; readonly property int n_oscA_mod1_steps:        167
    property int p168: defs[1][40]; property alias p_oscA_mod2_sel:          root.p168; readonly property int n_oscA_mod2_sel:          168
    property int p169: defs[1][41]; property alias p_oscA_mod2_dep:          root.p169; readonly property int n_oscA_mod2_dep:          169
    property int p170: defs[1][42]; property alias p_oscA_mod3_sel:          root.p170; readonly property int n_oscA_mod3_sel:          170
    property int p171: defs[1][43]; property alias p_oscA_mod3_dep:          root.p171; readonly property int n_oscA_mod3_dep:          171
    property int p172: defs[1][44]; property alias p_oscA_mod4_sel:          root.p172; readonly property int n_oscA_mod4_sel:          172
    property int p173: defs[1][45]; property alias p_oscA_mod4_dep:          root.p173; readonly property int n_oscA_mod4_dep:          173
    property int p174: defs[1][46]; property alias p_oscA_mod5_sel:          root.p174; readonly property int n_oscA_mod5_sel:          174
    property int p175: defs[1][47]; property alias p_oscA_mod5_dep:          root.p175; readonly property int n_oscA_mod5_dep:          175
    property int p176: defs[1][48]; property alias p_wavA_shape:             root.p176; readonly property int n_wavA_shape:             176
    property int p177: defs[1][49]; property alias p_wavA_width:             root.p177; readonly property int n_wavA_width:             177
    property int p178: defs[1][50]; property alias p_wavA_mod1_sel:          root.p178; readonly property int n_wavA_mod1_sel:          178
    property int p179: defs[1][51]; property alias p_wavA_mod1_dep:          root.p179; readonly property int n_wavA_mod1_dep:          179
    property int p180: defs[1][52]; property alias p_wavA_mod2_sel:          root.p180; readonly property int n_wavA_mod2_sel:          180
    property int p181: defs[1][53]; property alias p_wavA_mod2_dep:          root.p181; readonly property int n_wavA_mod2_dep:          181
    property int p182: defs[1][54]; property alias p_fltA_mode:              root.p182; readonly property int n_fltA_mode:              182
    property int p183: defs[1][55]; property alias p_fltA_res:               root.p183; readonly property int n_fltA_res:               183
    property int p184: defs[1][56]; property alias p_fltA_res_mod_sel:       root.p184; readonly property int n_fltA_res_mod_sel:       184
    property int p185: defs[1][57]; property alias p_fltA_res_mod_dep:       root.p185; readonly property int n_fltA_res_mod_dep:       185
    property int p186: defs[1][58]; property alias p_fltA_tune:              root.p186; readonly property int n_fltA_tune:              186
    property int p187: defs[1][59]; property alias p_fltA_mod1_sel:          root.p187; readonly property int n_fltA_mod1_sel:          187
    property int p188: defs[1][60]; property alias p_fltA_mod1_dep:          root.p188; readonly property int n_fltA_mod1_dep:          188
    property int p189: defs[1][61]; property alias p_fltA_mod1_steps:        root.p189; readonly property int n_fltA_mod1_steps:        189
    property int p190: defs[1][62]; property alias p_fltA_mod2_sel:          root.p190; readonly property int n_fltA_mod2_sel:          190
    property int p191: defs[1][63]; property alias p_fltA_mod2_dep:          root.p191; readonly property int n_fltA_mod2_dep:          191
    property int p192: defs[1][64]; property alias p_fltA_mod3_sel:          root.p192; readonly property int n_fltA_mod3_sel:          192
    property int p193: defs[1][65]; property alias p_fltA_mod3_dep:          root.p193; readonly property int n_fltA_mod3_dep:          193
    property int p194: defs[1][66]; property alias p_fltA_mod4_sel:          root.p194; readonly property int n_fltA_mod4_sel:          194
    property int p195: defs[1][67]; property alias p_fltA_mod4_dep:          root.p195; readonly property int n_fltA_mod4_dep:          195
    property int p196: defs[1][68]; property alias p_fltA_mod5_sel:          root.p196; readonly property int n_fltA_mod5_sel:          196
    property int p197: defs[1][69]; property alias p_fltA_mod5_dep:          root.p197; readonly property int n_fltA_mod5_dep:          197
    property int p198: defs[1][70]; property alias p_ampA_mod1_sel:          root.p198; readonly property int n_ampA_mod1_sel:          198
    property int p199: defs[1][71]; property alias p_ampA_mod1_dep:          root.p199; readonly property int n_ampA_mod1_dep:          199
    property int p200: defs[1][72]; property alias p_ampA_mod2_sel:          root.p200; readonly property int n_ampA_mod2_sel:          200
    property int p201: defs[1][73]; property alias p_ampA_mod2_dep:          root.p201; readonly property int n_ampA_mod2_dep:          201
    property int p202: defs[1][74]; property alias p_ampA_postmod_sel:       root.p202; readonly property int n_ampA_postmod_sel:       202
    property int p203: defs[1][75]; property alias p_ampA_postmod_dep:       root.p203; readonly property int n_ampA_postmod_dep:       203
    property int p204: defs[1][76]; property alias p_ampA_pan:               root.p204; readonly property int n_ampA_pan:               204
    property int p205: defs[1][77]; property alias p_ampA_pan_mod_sel:       root.p205; readonly property int n_ampA_pan_mod_sel:       205
    property int p206: defs[1][78]; property alias p_ampA_pan_mod_dep:       root.p206; readonly property int n_ampA_pan_mod_dep:       206

   // B channel parameters
    property int p256: defs[1][0];  property alias p_gldB_time:              root.p256; readonly property int n_gldB_time:              256
    property int p257: defs[1][1];  property alias p_gldB_shape:             root.p257; readonly property int n_gldB_shape:             257
    property int p258: defs[1][2];  property alias p_gldB_mod_sel:           root.p258; readonly property int n_gldB_mod_sel:           258
    property int p259: defs[1][3];  property alias p_gldB_mod_dep:           root.p259; readonly property int n_gldB_mod_dep:           259
    property int p260: defs[1][4];  property alias p_swpB_mode:              root.p260; readonly property int n_swpB_mode:              260
    property int p261: defs[1][5];  property alias p_swpB_rate:              root.p261; readonly property int n_swpB_rate:              261
    property int p262: defs[1][6];  property alias p_swpB_rate_mod_sel:      root.p262; readonly property int n_swpB_rate_mod_sel:      262
    property int p263: defs[1][7];  property alias p_swpB_rate_mod_dep:      root.p263; readonly property int n_swpB_rate_mod_dep:      263
    property int p264: defs[1][8];  property alias p_swpB_wave_shape:        root.p264; readonly property int n_swpB_wave_shape:        264
    property int p265: defs[1][9];  property alias p_swpB_ampl_mod_sel:      root.p265; readonly property int n_swpB_ampl_mod_sel:      265
    property int p266: defs[1][10]; property alias p_swpB_ampl_mod_dep:      root.p266; readonly property int n_swpB_ampl_mod_dep:      266
    property int p267: defs[1][11]; property alias p_env1B_peak_mod_sel:     root.p267; readonly property int n_env1B_peak_mod_sel:     267
    property int p268: defs[1][12]; property alias p_env1B_peak_mod_dep:     root.p268; readonly property int n_env1B_peak_mod_dep:     268
    property int p269: defs[1][13]; property alias p_env1B_att_time:         root.p269; readonly property int n_env1B_att_time:         269
    property int p270: defs[1][14]; property alias p_env1B_att_conserv:      root.p270; readonly property int n_env1B_att_conserv:      270
    property int p271: defs[1][15]; property alias p_env1B_att_mod_sel:      root.p271; readonly property int n_env1B_att_mod_sel:      271
    property int p272: defs[1][16]; property alias p_env1B_att_mod_dep:      root.p272; readonly property int n_env1B_att_mod_dep:      272
    property int p273: defs[1][17]; property alias p_env1B_dec_time:         root.p273; readonly property int n_env1B_dec_time:         273
    property int p274: defs[1][18]; property alias p_env1B_dec_self_mod:     root.p274; readonly property int n_env1B_dec_self_mod:     274
    property int p275: defs[1][19]; property alias p_env1B_dec_mod_sel:      root.p275; readonly property int n_env1B_dec_mod_sel:      275
    property int p276: defs[1][20]; property alias p_env1B_dec_mod_dep:      root.p276; readonly property int n_env1B_dec_mod_dep:      276
    property int p277: defs[1][21]; property alias p_env1B_rel_time:         root.p277; readonly property int n_env1B_rel_time:         277
    property int p278: defs[1][22]; property alias p_env1B_rel_mod:          root.p278; readonly property int n_env1B_rel_mod:          278
    property int p279: defs[1][23]; property alias p_env2B_trigger:          root.p279; readonly property int n_env2B_trigger:          279
    property int p280: defs[1][24]; property alias p_env2B_peak_mod_sel:     root.p280; readonly property int n_env2B_peak_mod_sel:     280
    property int p281: defs[1][25]; property alias p_env2B_peak_mod_dep:     root.p281; readonly property int n_env2B_peak_mod_dep:     281
    property int p282: defs[1][26]; property alias p_env2B_att_time:         root.p282; readonly property int n_env2B_att_time:         282
    property int p283: defs[1][27]; property alias p_env2B_att_conserv:      root.p283; readonly property int n_env2B_att_conserv:      283
    property int p284: defs[1][28]; property alias p_env2B_att_mod_sel:      root.p284; readonly property int n_env2B_att_mod_sel:      284
    property int p285: defs[1][29]; property alias p_env2B_att_mod_dep:      root.p285; readonly property int n_env2B_att_mod_dep:      285
    property int p286: defs[1][30]; property alias p_env2B_dec_time:         root.p286; readonly property int n_env2B_dec_time:         286
    property int p287: defs[1][31]; property alias p_env2B_dec_self_mod:     root.p287; readonly property int n_env2B_dec_self_mod:     287
    property int p288: defs[1][32]; property alias p_env2B_dec_mod_sel:      root.p288; readonly property int n_env2B_dec_mod_sel:      288
    property int p289: defs[1][33]; property alias p_env2B_dec_mod_dep:      root.p289; readonly property int n_env2B_dec_mod_dep:      289
    property int p290: defs[1][34]; property alias p_env2B_rel_time:         root.p290; readonly property int n_env2B_rel_time:         290
    property int p291: defs[1][35]; property alias p_env2B_rel_mod:          root.p291; readonly property int n_env2B_rel_mod:          291
    property int p292: defs[1][36]; property alias p_oscB_tune:              root.p292; readonly property int n_oscB_tune:              292
    property int p293: defs[1][37]; property alias p_oscB_mod1_sel:          root.p293; readonly property int n_oscB_mod1_sel:          293
    property int p294: defs[1][38]; property alias p_oscB_mod1_dep:          root.p294; readonly property int n_oscB_mod1_dep:          294
    property int p295: defs[1][39]; property alias p_oscB_mod1_steps:        root.p295; readonly property int n_oscB_mod1_steps:        295
    property int p296: defs[1][40]; property alias p_oscB_mod2_sel:          root.p296; readonly property int n_oscB_mod2_sel:          296
    property int p297: defs[1][41]; property alias p_oscB_mod2_dep:          root.p297; readonly property int n_oscB_mod2_dep:          297
    property int p298: defs[1][42]; property alias p_oscB_mod3_sel:          root.p298; readonly property int n_oscB_mod3_sel:          298
    property int p299: defs[1][43]; property alias p_oscB_mod3_dep:          root.p299; readonly property int n_oscB_mod3_dep:          299
    property int p300: defs[1][44]; property alias p_oscB_mod4_sel:          root.p300; readonly property int n_oscB_mod4_sel:          300
    property int p301: defs[1][45]; property alias p_oscB_mod4_dep:          root.p301; readonly property int n_oscB_mod4_dep:          301
    property int p302: defs[1][46]; property alias p_oscB_mod5_sel:          root.p302; readonly property int n_oscB_mod5_sel:          302
    property int p303: defs[1][47]; property alias p_oscB_mod5_dep:          root.p303; readonly property int n_oscB_mod5_dep:          303
    property int p304: defs[1][48]; property alias p_wavB_shape:             root.p304; readonly property int n_wavB_shape:             304
    property int p305: defs[1][49]; property alias p_wavB_width:             root.p305; readonly property int n_wavB_width:             305
    property int p306: defs[1][50]; property alias p_wavB_mod1_sel:          root.p306; readonly property int n_wavB_mod1_sel:          306
    property int p307: defs[1][51]; property alias p_wavB_mod1_dep:          root.p307; readonly property int n_wavB_mod1_dep:          307
    property int p308: defs[1][52]; property alias p_wavB_mod2_sel:          root.p308; readonly property int n_wavB_mod2_sel:          308
    property int p309: defs[1][53]; property alias p_wavB_mod2_dep:          root.p309; readonly property int n_wavB_mod2_dep:          309
    property int p310: defs[1][54]; property alias p_fltB_mode:              root.p310; readonly property int n_fltB_mode:              310
    property int p311: defs[1][55]; property alias p_fltB_res:               root.p311; readonly property int n_fltB_res:               311
    property int p312: defs[1][56]; property alias p_fltB_res_mod_sel:       root.p312; readonly property int n_fltB_res_mod_sel:       312
    property int p313: defs[1][57]; property alias p_fltB_res_mod_dep:       root.p313; readonly property int n_fltB_res_mod_dep:       313
    property int p314: defs[1][58]; property alias p_fltB_tune:              root.p314; readonly property int n_fltB_tune:              314
    property int p315: defs[1][59]; property alias p_fltB_mod1_sel:          root.p315; readonly property int n_fltB_mod1_sel:          315
    property int p316: defs[1][60]; property alias p_fltB_mod1_dep:          root.p316; readonly property int n_fltB_mod1_dep:          316
    property int p317: defs[1][61]; property alias p_fltB_mod1_steps:        root.p317; readonly property int n_fltB_mod1_steps:        317
    property int p318: defs[1][62]; property alias p_fltB_mod2_sel:          root.p318; readonly property int n_fltB_mod2_sel:          318
    property int p319: defs[1][63]; property alias p_fltB_mod2_dep:          root.p319; readonly property int n_fltB_mod2_dep:          319
    property int p320: defs[1][64]; property alias p_fltB_mod3_sel:          root.p320; readonly property int n_fltB_mod3_sel:          320
    property int p321: defs[1][65]; property alias p_fltB_mod3_dep:          root.p321; readonly property int n_fltB_mod3_dep:          321
    property int p322: defs[1][66]; property alias p_fltB_mod4_sel:          root.p322; readonly property int n_fltB_mod4_sel:          322
    property int p323: defs[1][67]; property alias p_fltB_mod4_dep:          root.p323; readonly property int n_fltB_mod4_dep:          323
    property int p324: defs[1][68]; property alias p_fltB_mod5_sel:          root.p324; readonly property int n_fltB_mod5_sel:          324
    property int p325: defs[1][69]; property alias p_fltB_mod5_dep:          root.p325; readonly property int n_fltB_mod5_dep:          325
    property int p326: defs[1][70]; property alias p_ampB_mod1_sel:          root.p326; readonly property int n_ampB_mod1_sel:          326
    property int p327: defs[1][71]; property alias p_ampB_mod1_dep:          root.p327; readonly property int n_ampB_mod1_dep:          327
    property int p328: defs[1][72]; property alias p_ampB_mod2_sel:          root.p328; readonly property int n_ampB_mod2_sel:          328
    property int p329: defs[1][73]; property alias p_ampB_mod2_dep:          root.p329; readonly property int n_ampB_mod2_dep:          329
    property int p330: defs[1][74]; property alias p_ampB_postmod_sel:       root.p330; readonly property int n_ampB_postmod_sel:       330
    property int p331: defs[1][75]; property alias p_ampB_postmod_dep:       root.p331; readonly property int n_ampB_postmod_dep:       331
    property int p332: defs[1][76]; property alias p_ampB_pan:               root.p332; readonly property int n_ampB_pan:               332
    property int p333: defs[1][77]; property alias p_ampB_pan_mod_sel:       root.p333; readonly property int n_ampB_pan_mod_sel:       333
    property int p334: defs[1][78]; property alias p_ampB_pan_mod_dep:       root.p334; readonly property int n_ampB_pan_mod_dep:       334

    // Combined link and sequence parameters (valid even if link mode is None)
    property int p_link_num:        (p_link_number && p_link_bank) * 100 + p_link_number
    property int p_sequence_num:    (p_sequence_number && p_sequence_bank) * 100 + p_sequence_number

    onP_link_numChanged:            currProg._link = p_link_mode ? p_link_number : -1
    onP_link_modeChanged:           currProg._link = p_link_mode ? p_link_number : -1
    onP_sequence_numChanged:        currProg._seq = p_sequence_num

    // PARAMETER DESCRIPTORS --------------------------------------------------
    //  Indexed first by page != 0, then by parameter.

    // Default values
    readonly property var   defs: [
        //  0     1     2     3     4     5     6     7     8     9
        [   0,    0,    0,    0,    0,    0,   60,    0,    0,    3, // 0
            1,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 10
            0,    0,    0,    0,    1,    1,    1,    1,    1,    1, // 20
           64,    4,    0,    0,    0,    0                          // 30
            ],
        [   0,    0,    6,    0,    0,    0,   20,    0,    0,    0, // 0
            0,    4,    0,    0,    0,    8,    0,  127,    0,    8, // 10
            0,    0,    0,    0,    4,    0,    0,    0,    8,    0, // 20
          127,    0,    8,    0,    0,    0,    0,   11,    0,    0, // 30
            1,    0,    3,    0,    5,    0,    7,    0,    0,    0, // 40
            1,    0,    3,    0,    0,    0,    7,    0,   63,    0, // 50
            0,    0,    1,    0,    3,    0,    5,    0,    7,    0, // 60
            0,   90,    2,    0,    4,    0,    0,    5,    0        // 70
            ]
        ]

    // Edit numbers (0 means none, except for link balance)
    readonly property var   edns: [
        //  0     1     2     3     4     5     6     7     8     9
        [   0,    0,    0,    0,   -1,   -2,    0,    0,    0,    0, // 0
            0,    0,    0,    2,    5,    3,    0,    0,    0,    0, // 10
            0,    0,    0,  -37,    1,   -3,    4,   -4,  -26,  -27, // 20
            0,   -8,   -9,   -5,  -33,  -34                          // 30
            ],
        [   6,    7,   -6,   -7,    8,    9,   10,  -10,   11,   12, // 0 
          -12,   13,  -13,   14,  -14,   15,  -15,   16,  -16,   17, // 10 
          -17,   18,  -18,   19,   20,  -20,   21,  -21,   22,  -22, // 20 
           23,  -23,   24,  -24,   25,  -25,   26,   27,   28,  -28, // 30 
           29,   30,   31,   32,  -29,  -30,  -31,  -32,   33,   34, // 40 
           35,   36,  -35,  -36,   37,   38,  -38,  -39,   39,   44, // 50 
           45,  -41,   40,   41,   42,   43,  -42,  -43,  -44,  -45, // 60 
           46,   47,   48,   49,   50,  -50,  -46,  -47,  -48                    // 70
            ]
        ]

    // Maximum values
    readonly property var   maxs: [
        //  0     1     2     3     4     5     6     7     8     9
        [   9,   50,    7,   15,   63,   50,  127,    1,    1,    3, // 0
           50,    9,   50,   11,   10,   15,   15,    5,   20,    5, // 10
            5,   20,    5,   63,   19,    4,   50,    2,   50,   52, // 20
          127,    8,    8,    2,   15,  127                          // 30
            ], 
        [ 127,    3,   15,   63,    4,  127,   20,   63,   15,   25, // 0
           63,   19,   63,  127,    5,   12,   63,  127,   63,   11, // 10
           63,  127,   15,  127,   19,   63,  127,    5,   12,   63, // 20
          127,   63,   11,   63,  127,   15,   60,   25,   63,   11, // 30
           25,   63,   25,   63,   25,   63,   25,   63,   17,  127, // 40
           25,   63,   25,   63,    5,  127,   25,   63,   63,   25, // 50
           63,   11,   25,   63,   25,   63,   25,   63,   25,   63, // 60
            4,  127,    4,  127,   21,   63,   63,   25,   63                    // 70
            ]
        ]

    // Minimum values
    readonly property var   mins: [
        //  0     1     2     3     4     5     6     7     8     9
        [   0,    0,    0,  -15,  -64,  -50,    0,   -1,   -1,    1, // 0
          -50,    0,    0,    0,    0,    0,  -15,   -5,  -20,   -5, // 10
            0,  -20,   -5,  -64,    1,    1,  -50,    0,  -50,    0, // 20
            0,    0,    0,    0,    0,    0                          // 30
            ],
        [   0,    0,    0,  -64,    0,    0,    0,  -64,    0,    0, // 0
          -64,    0,  -64,    0,   -1,    0,  -64,    0,  -64,    0, // 10
          -64,    0,    0,    0,    0,  -64,    0,   -1,    0,  -64, // 20
            0,  -64,    0,  -64,    0,    0,  -24,    0,  -64,    0, // 30
            0,  -64,    0,  -64,    0,  -64,    0,  -64,    0,    0, // 40
            0,  -64,    0,  -64,    0,    0,    0,  -64,  -64,    0, // 50
          -64,    0,    0,  -64,    0,  -64,    0,  -64,    0,  -64, // 60
            0,    0,    0,    0,    0,  -64,  -64,    0,  -64                    // 70
            ]
        ]

    // Significant values (999 means none)
    readonly property var   sigs: [
        //  0     1     2     3     4     5     6     7     8     9
        [ 999,  999,  999,  999,  999,  999,  999,  999,  999,  999, // 0
          999,  999,  999,  999,  999,  999,  999,  999,  999,  999, // 10
          999,  999,  999,  999,  999,  999,  999,  999,  999,  999, // 20
          999,  999,  999,  999,  999,  999                          // 30
            ],
        [ 999,  999,  999,  999,  999,  999,  999,   63,  999,  999, // 0
           63,  999,   63,  999,  999,  999,  999,  999,  999,  999, // 10
          999,  999,  999,  999,  999,   63,  999,  999,  999,  999, // 20
          999,  999,  999,  999,  999,  999,  999,  999,  999,  999, // 30
          999,  999,  999,  999,  999,  999,  999,  999,  999,   64, // 40
          999,  999,  999,  999,  999,  999,  999,  999,    0,  999, // 50
          999,  999,  999,  999,  999,  999,  999,  999,  999,  999, // 60
          999,    0,  999,   90,  999,   63,  999,  999,  999                    // 70
            ]
        ]

    // Value strings
    readonly property var   strs: [
        [   null,                   // 0
            null,                   // 1
            str_link_mode,          // 2
            str_pm20db,             // 3
            str_pm90deg,            // 4
            str_pm50c,              // 5
            str_key,                // 6
            null,                   // 7
            null,                   // 8
            str_edit_mode,          // 9
            str_edit_number,        // 10
            null,                   // 11
            null,                   // 12
            null,                   // 13
            str_ribbon_alg,         // 14
            str_kybd_alg,           // 15
            str_pm20db,             // 16
            str_bass_freq,          // 17
            str_pm20db,             // 18
            str_middle_freq,        // 19
            str_middle_res,         // 20
            str_pm20db,             // 21
            str_treble_freq,        // 22
            str_pm100pct,           // 23
            str_patch,              // 24
            null,                   // 25
            null,                   // 26
            str_detune_scale,       // 27
            str_tune_shift,         // 28
            str_tune_spread,        // 29
            str_180deg,             // 30
            null,                   // 31
            null,                   // 32
            str_sel_mode,           // 33
            str_rev_room,           // 34
            str_rev_send            // 35
            ], 
        [   str_gld_time,           // 0
            str_gld_shape,          // 1
            str_swp_rate_mod_sel,   // 2
            str_pm100pct,           // 3
            str_swp_mode,           // 4
            str_swp_rate,           // 5
            str_swp_rate_mod_sel,   // 6
            str_pm100pct,           // 7
            str_swp_shape,          // 8
            str_swp_ampl_mod_sel,   // 9
            str_pm100pct,           // 10
            str_env_peak_mod_sel,   // 11
            str_pm100pct,           // 12
            str_env_att_dec_time,   // 13
            str_env_att_conserv,    // 14
            str_env_rate_mod_sel,   // 15
            str_pm100pct,           // 16
            str_env_att_dec_time,   // 17
            str_pm100pct,           // 18
            str_env_rate_mod_sel,   // 19
            str_pm100pct,           // 20
            str_env_rel_time,       // 21
            str_env_rel_mod,        // 22
            str_env2_trigger,       // 23
            str_env_peak_mod_sel,   // 24
            str_pm100pct,           // 25
            str_env_att_dec_time,   // 26
            str_env_att_conserv,    // 27
            str_env_rate_mod_sel,   // 28
            str_pm100pct,           // 29
            str_env_att_dec_time,   // 30
            str_pm100pct,           // 31
            str_env_rate_mod_sel,   // 32
            str_pm100pct,           // 33
            str_env_rel_time,       // 34
            str_env_rel_mod,        // 35
            str_osc_tune,           // 36
            str_std_mod_sel,        // 37
            str_pitch_mod_dep,      // 38
            str_pitch_mod_steps,    // 39
            str_std_mod_sel,        // 40
            str_pitch_mod_dep,      // 41
            str_std_mod_sel,        // 42
            str_pitch_mod_dep,      // 43
            str_std_mod_sel,        // 44
            str_pitch_mod_dep,      // 45
            str_std_mod_sel,        // 46
            str_pitch_mod_dep,      // 47
            str_wav_shape,          // 48
            null,                   // 49
            str_std_mod_sel,        // 50
            null,                   // 51
            str_std_mod_sel,        // 52
            null,                   // 53
            str_flt_mode,           // 54
            str_flt_res,            // 55
            str_std_mod_sel,        // 56
            str_pm100pct,           // 57
            str_flt_tune,           // 58
            str_std_mod_sel,        // 59
            str_pitch_mod_dep,      // 60
            str_pitch_mod_steps,    // 61
            str_std_mod_sel,        // 62
            str_pitch_mod_dep,      // 63
            str_std_mod_sel,        // 64
            str_pitch_mod_dep,      // 65
            str_std_mod_sel,        // 66
            str_pitch_mod_dep,      // 67
            str_std_mod_sel,        // 68
            str_pitch_mod_dep,      // 69
            str_amp_mod_sel,        // 70
            str_amp_mod_dep,        // 71
            str_amp_mod_sel,        // 72
            str_amp_mod_dep,        // 73
            str_amp_postmod_sel,    // 74
            str_pm100pct,           // 75
            str_pm90deg,            // 76
            str_std_mod_sel,        // 77
            str_pm180deg            // 78
            ]
        ]

    // PARAMETER VALUE STRINGS ------------------------------------------------

    readonly property var   str_100pct: [
        "off",      "1%",       "1.5%",     "2%",       // 0
        "3%",       "4%",       "5%",       "5.5%",     // 4
        "6%",       "7%",       "8%",       "8.5%",     // 8
        "9%",       "10%",      "11%",      "12%",      // 12
        "12.5%",    "13%",      "14%",      "15%",      // 16
        "16%",      "16.5%",    "17%",      "18%",      // 20
        "19%",      "19.5%",    "19%",      "21%",      // 24
        "22%",      "23%",      "23.5%",    "24%",      // 28
        "25%",      "26%",      "26.5%",    "27%",      // 32
        "28%",      "29%",      "30%",      "30.5%",    // 36
        "31%",      "32%",      "33%",      "33.5%",    // 40
        "34%",      "35%",      "36%",      "37%",      // 44
        "37.5%",    "38%",      "39%",      "40%",      // 48
        "41%",      "41.5%",    "42%",      "43%",      // 52
        "44%",      "44.5%",    "45%",      "46%",      // 56
        "47%",      "48%",      "48.5%",    "49%",      // 60
        "50%",      "51%",      "51.5%",    "52%",      // 64
        "53%",      "54%",      "55%",      "55.5%",    // 68
        "56%",      "57%",      "58%",      "58.5%",    // 72
        "59%",      "60%",      "61%",      "62%",      // 76
        "62.5%",    "63%",      "64%",      "65%",      // 80
        "66%",      "66.5%",    "67%",      "68%",      // 84
        "69%",      "69.5%",    "70%",      "71%",      // 88
        "72%",      "73%",      "73.5%",    "74%",      // 92
        "75%",      "76%",      "76.5%",    "77%",      // 96
        "78%",      "79%",      "80%",      "80.5%",    // 100
        "81%",      "82%",      "83%",      "83.5%",    // 104
        "84%",      "85%",      "86%",      "87%",      // 108
        "87.5%",    "88%",      "89%",      "90%",      // 112
        "91%",      "91.5%",    "92%",      "93%",      // 116
        "94%",      "94.5%",    "95%",      "96%",      // 120
        "97%",      "98%",      "99%",      "100%"      // 124
        ]

    readonly property var   str_16cyc: [
        "0cyc",     "0.1cyc",   "0.2cyc",   "0.4cyc",   // 0
        "0.5cyc",   "0.6cyc",   "0.8cyc",   "0.9cyc",   // 4
        "1cyc",     "1.1cyc",   "1.2cyc",   "1.4cyc",   // 8
        "1.5cyc",   "1.6cyc",   "1.8cyc",   "1.9cyc",   // 12
        "2cyc",     "2.1cyc",   "2.2cyc",   "2.4cyc",   // 16
        "2.5cyc",   "2.6cyc",   "2.8cyc",   "2.9cyc",   // 20
        "3cyc",     "3.1cyc",   "3.2cyc",   "3.4cyc",   // 24
        "3.5cyc",   "3.6cyc",   "3.8cyc",   "3.9cyc",   // 28
        "4cyc",     "4.1cyc",   "4.2cyc",   "4.4cyc",   // 32
        "4.5cyc",   "4.6cyc",   "4.8cyc",   "4.9cyc",   // 36
        "5cyc",     "5.1cyc",   "5.2cyc",   "5.4cyc",   // 40
        "5.5cyc",   "5.6cyc",   "5.8cyc",   "5.9cyc",   // 44
        "6cyc",     "6.1cyc",   "6.2cyc",   "6.4cyc",   // 48
        "6.5cyc",   "6.6cyc",   "6.8cyc",   "6.9cyc",   // 52
        "7cyc",     "7.1cyc",   "7.2cyc",   "7.4cyc",   // 56
        "7.5cyc",   "7.6cyc",   "7.8cyc",   "7.9cyc",   // 60
        "8cyc",     "8.1cyc",   "8.2cyc",   "8.4cyc",   // 64
        "8.5cyc",   "8.6cyc",   "8.8cyc",   "8.9cyc",   // 68
        "9cyc",     "9.1cyc",   "9.2cyc",   "9.4cyc",   // 72
        "9.5cyc",   "9.6cyc",   "9.8cyc",   "9.9cyc",   // 76
        "10cyc",    "10.1cyc",  "10.2cyc",  "10.3cyc",  // 80
        "10.5cyc",  "10.6cyc",  "10.8cyc",  "10.9cyc",  // 84
        "11cyc",    "11.1cyc",  "11.2cyc",  "11.3cyc",  // 88
        "11.5cyc",  "11.6cyc",  "11.8cyc",  "11.9cyc",  // 92
        "12cyc",    "12.1cyc",  "12.2cyc",  "12.3cyc",  // 96
        "12.5cyc",  "12.6cyc",  "12.8cyc",  "12.9cyc",  // 100
        "13cyc",    "13.1cyc",  "13.2cyc",  "13.3cyc",  // 104
        "13.5cyc",  "13.6cyc",  "13.8cyc",  "13.9cyc",  // 108
        "14cyc",    "14.1cyc",  "14.2cyc",  "14.3cyc",  // 112
        "14.5cyc",  "14.6cyc",  "14.8cyc",  "14.9cyc",  // 116
        "15cyc",    "15.1cyc",  "15.2cyc",  "15.3cyc",  // 120
        "15.5cyc",  "15.6cyc",  "15.8cyc",  "15.9cyc"   // 124
        ]

    readonly property var   str_180deg: [
        "0\xB0",    // 0
        "2\xB0",    // 1
        "3\xB0",    // 2
        "4\xB0",    // 3
        "6\xB0",    // 4
        "7\xB0",    // 5
        "8\xB0",    // 6
        "10\xB0",   // 7
        "11\xB0",   // 8
        "12\xB0",   // 9
        "14\xB0",   // 10
        "16\xB0",   // 11
        "17\xB0",   // 12
        "18\xB0",   // 13
        "20\xB0",   // 14
        "21\xB0",   // 15
        "22\xB0",   // 16
        "24\xB0",   // 17
        "26\xB0",   // 18
        "27\xB0",   // 19
        "28\xB0",   // 20
        "30\xB0",   // 21
        "31\xB0",   // 22
        "32\xB0",   // 23
        "34\xB0",   // 24
        "35\xB0",   // 25
        "36\xB0",   // 26
        "38\xB0",   // 27
        "40\xB0",   // 28
        "41\xB0",   // 29
        "42\xB0",   // 30
        "44\xB0",   // 31
        "45\xB0",   // 32
        "46\xB0",   // 33
        "48\xB0",   // 34
        "49\xB0",   // 35
        "50\xB0",   // 36
        "52\xB0",   // 37
        "54\xB0",   // 38
        "55\xB0",   // 39
        "56\xB0",   // 40
        "58\xB0",   // 41
        "59\xB0",   // 42
        "60\xB0",   // 43
        "62\xB0",   // 44
        "63\xB0",   // 45
        "64\xB0",   // 46
        "66\xB0",   // 47
        "68\xB0",   // 48
        "69\xB0",   // 49
        "70\xB0",   // 50
        "72\xB0",   // 51
        "73\xB0",   // 52
        "74\xB0",   // 53
        "76\xB0",   // 54
        "78\xB0",   // 55
        "79\xB0",   // 56
        "80\xB0",   // 57
        "83\xB0",   // 58
        "83\xB0",   // 59
        "84\xB0",   // 60
        "86\xB0",   // 61
        "87\xB0",   // 62
        "88\xB0",   // 63
        "90\xB0",   // 64
        "92\xB0",   // 65
        "93\xB0",   // 66
        "94\xB0",   // 67
        "96\xB0",   // 68
        "97\xB0",   // 69
        "98\xB0",   // 70
        "100\xB0",  // 71
        "101\xB0",  // 72
        "102\xB0",  // 73
        "104\xB0",  // 74
        "106\xB0",  // 75
        "107\xB0",  // 76
        "108\xB0",  // 77
        "110\xB0",  // 78
        "111\xB0",  // 79
        "112\xB0",  // 80
        "114\xB0",  // 81
        "116\xB0",  // 82
        "117\xB0",  // 83
        "118\xB0",  // 84
        "120\xB0",  // 85
        "121\xB0",  // 86
        "122\xB0",  // 87
        "124\xB0",  // 88
        "125\xB0",  // 89
        "126\xB0",  // 90
        "128\xB0",  // 91
        "130\xB0",  // 92
        "131\xB0",  // 93
        "132\xB0",  // 94
        "134\xB0",  // 95
        "135\xB0",  // 96
        "136\xB0",  // 97
        "138\xB0",  // 98
        "139\xB0",  // 99
        "140\xB0",  // 100
        "142\xB0",  // 101
        "144\xB0",  // 102
        "145\xB0",  // 103
        "146\xB0",  // 104
        "148\xB0",  // 105
        "149\xB0",  // 106
        "150\xB0",  // 107
        "152\xB0",  // 108
        "153\xB0",  // 109
        "154\xB0",  // 110
        "156\xB0",  // 111
        "158\xB0",  // 112
        "159\xB0",  // 113
        "160\xB0",  // 114
        "162\xB0",  // 115
        "163\xB0",  // 116
        "164\xB0",  // 117
        "166\xB0",  // 118
        "168\xB0",  // 119
        "169\xB0",  // 120
        "170\xB0",  // 121
        "172\xB0",  // 122
        "173\xB0",  // 123
        "174\xB0",  // 124
        "176\xB0",  // 125
        "178\xB0",  // 126
        "180\xB0"   // 127
        ]

    readonly property var   str_amp_mod_dep: [
        "off",          "\u201278db",   "\u201266db",   "\u201260db",   // 0
        "\u201254db",   "\u201250db",   "\u201247db",   "\u201244db",   // 4
        "\u201242db",   "\u201240db",   "\u201238db",   "\u201236db",   // 8
        "\u201235db",   "\u201234db",   "\u201232db",   "\u201231db",   // 12
        "\u201230db",   "\u201229db",   "\u201228db",   "\u201227db",   // 16
        "\u201226db",   "\u201225db",   "\u201224.5db", "\u201224db",   // 20
        "\u201223db",   "\u201222db",   "\u201221.5db", "\u201221db",   // 24
        "\u201220db",   "\u201219.5db", "\u201219db",   "\u201218.5db", // 28
        "\u201218db",   "\u201217.5db", "\u201217db",   "\u201216.5db", // 32
        "\u201216db",   "\u201215.5db", "\u201215db",   "\u201214.5db", // 36
        "\u201214db",   "\u201213.5db", "\u201213db",   "\u201212.8db", // 40
        "\u201212.4db", "\u201212db",   "\u201211.7db", "\u201211.3db", // 44
        "\u201211db",   "\u201210.6db", "\u201210.2db", "\u201210db",   // 48
        "\u20129.5db",  "\u20129.2db",  "\u20129db",    "\u20128.6db",  // 52
        "\u20128.2db",  "\u20128db",    "\u20127.6db",  "\u20127.3db",  // 56
        "\u20127db",    "\u20126.8db",  "\u20126.5db",  "\u20126.2db",  // 60
        "\u20126db",    "\u20125.7db",  "\u20125.4db",  "\u20125.2db",  // 64
        "\u20125db",    "\u20124.6db",  "\u20124.4db",  "\u20124.2db",  // 68
        "\u20124db",    "\u20123.6db",  "\u20123.4db",  "\u20123.2db",  // 72
        "\u20123db",    "\u20122.7db",  "\u20122.5db",  "\u20122.3db",  // 76
        "\u20122db",    "\u20121.8db",  "\u20121.6db",  "\u20121.4db",  // 80
        "\u20121.2db",  "\u20121db",    "\u20120.8db",  "\u20120.6db",  // 84
        "\u20120.4db",  "\u20120.2db",  "0db",          "+0.2db",       // 88
        "+0.4db",       "+0.6db",       "+0.8db",       "+1db",         // 92
        "+1.1db",       "+1.3db",       "+1.5db",       "+1.7db",       // 96
        "+1.8db",       "+2db",         "+2.2db",       "+2.3db",       // 100
        "+2.5db",       "+2.7db",       "+2.8db",       "+3db",         // 104
        "+3.2db",       "+3.3db",       "+3.5db",       "+3.6db",       // 108
        "+3.8db",       "+4db",         "+4.1db",       "+4.3db",       // 112
        "+4.4db",       "+4.6db",       "+4.7db",       "+4.9db",       // 116
        "+5db",         "+5.1db",       "+5.3db",       "+5.4db",       // 120
        "+5.6db",       "+5.7db",       "+5.8db",       "+6db"          // 124
        ]

    readonly property var   str_amp_mod_sel: [
        "envelope 1A",  // 0
        "envelope 2A",  // 1
        "envelope 1B",  // 2
        "envelope 2B",  // 3
        "fixed"         // 4
        ]

    readonly property var   str_amp_postmod_sel: [
        "+lever 1",             //  0
        "+lever 2",             //  1
        "\u2012lever 1",        //  2
        "\u2012lever 2",        //  3
        "pedal 1",              //  4
        "pedal 2",              //  5
        "\u2012pedal 1",        //  6
        "\u2012pedal 2",        //  7
        "ribbon",               //  8
        "pitch",                //  9
        "velocity",             // 10
        "pressure",             // 11
        "sweep A",              // 12
        "sweep B"               // 13
        ]

    readonly property var   str_bass_freq: {
         "-5": "16Hz",
         "-4": "20Hz",
         "-3": "24Hz",
         "-2": "30Hz",
         "-1": "36Hz",
            0: "45Hz",
            1: "55Hz",
            2: "67Hz",
            3: "83Hz",
            4: "102Hz",
            5: "125Hz"
        }

    readonly property var   str_detune_hz: {
        "-50": "\u20127.5Hz",
        "-49": "\u20127.3Hz",
        "-48": "\u20127.2Hz",
        "-47": "\u20127Hz",
        "-46": "\u20126.9Hz",
        "-45": "\u20126.7Hz", 
        "-44": "\u20126.6Hz",
        "-43": "\u20126.4Hz",
        "-42": "\u20126.3Hz",
        "-41": "\u20126.1Hz", 
        "-40": "\u20126Hz",
        "-39": "\u20125.8Hz",
        "-38": "\u20125.7Hz",
        "-37": "\u20125.5Hz",
        "-36": "\u20125.4Hz",
        "-35": "\u20125.2Hz", 
        "-34": "\u20125.1Hz",
        "-33": "\u20125Hz",
        "-32": "\u20124.8Hz",
        "-31": "\u20124.6Hz", 
        "-30": "\u20124.5Hz",
        "-29": "\u20124.4Hz",
        "-28": "\u20124.2Hz",
        "-27": "\u20124Hz",
        "-26": "\u20123.9Hz",
        "-25": "\u20123.8Hz", 
        "-24": "\u20123.6Hz",
        "-23": "\u20123.5Hz",
        "-22": "\u20123.3Hz",
        "-21": "\u20123.2Hz", 
        "-20": "\u20123Hz",
        "-19": "\u20122.9Hz",
        "-18": "\u20122.7Hz",
        "-17": "\u20122.6Hz",
        "-16": "\u20122.4Hz",
        "-15": "\u20122.3Hz", 
        "-14": "\u20122.1Hz",
        "-13": "\u20122Hz",
        "-12": "\u20121.8Hz",
        "-11": "\u20121.7Hz", 
        "-10": "\u20121.5Hz",
         "-9": "\u20121.4Hz",
         "-8": "\u20121.2Hz",
         "-7": "\u20121Hz",
         "-6": "\u20120.9Hz",
         "-5": "\u20120.8Hz", 
         "-4": "\u20120.6Hz",
         "-3": "\u20120.5Hz",
         "-2": "\u20120.3Hz",
         "-1": "\u20120.2Hz", 
            0: "0Hz",
            1: "+0.2Hz",
            2: "+0.3Hz",
            3: "+0.5Hz",
            4: "+0.6Hz",
            5: "+0.8Hz",
            6: "+0.9Hz",
            7: "+1Hz",
            8: "+1.2Hz",
            9: "+1.4Hz", 
           10: "+1.5Hz",
           11: "+1.7Hz",
           12: "+1.8Hz",
           13: "+2Hz",
           14: "+2.1Hz",
           15: "+2.3Hz",
           16: "+2.4Hz",
           17: "+2.6Hz",
           18: "+2.7Hz",
           19: "+2.9Hz", 
           20: "+3Hz",
           21: "+3.2Hz",
           22: "+3.4Hz",
           23: "+3.5Hz",
           24: "+3.7Hz",
           25: "+3.8Hz",
           26: "+4Hz",
           27: "+4.1Hz",
           28: "+4.3Hz",
           29: "+4.4Hz", 
           30: "+4.6Hz",
           31: "+4.7Hz",
           32: "+4.9Hz",
           33: "+5Hz",
           34: "+5.2Hz",
           35: "+5.4Hz",
           36: "+5.5Hz",
           37: "+5.7Hz",
           38: "+5.8Hz",
           39: "+6Hz", 
           40: "+6.1Hz",
           41: "+6.3Hz",
           42: "+6.4Hz",
           43: "+6.6Hz",
           44: "+6.7Hz",
           45: "+6.9Hz",
           46: "+7Hz",
           47: "+7.2Hz",
           48: "+7.4Hz",
           49: "+7.5Hz", 
           50: "+7.7Hz"
        }

    readonly property var   str_detune_scale: [
        "full", // 0
        "half", // 1
        "fixed" // 2
        ]

    readonly property var str_edit_mode: [
        "none", // 0
        "A",    // 1
        "B",    // 2
        "A&B"   // 3
        ]

    readonly property var str_edit_number: {
        "-50": "X50: amplifier mod 3 depth",
        "-49": "X49: amplifier pan spread",
        "-48": "X48: amplifier pan mod depth",
        "-47": "X47: amplifier pan mod select",
        "-46": "X46: amplifier pan",
        "-45": "X45: filter mod 5 depth",
        "-44": "X44: filter mod 5 select",
        "-43": "X43: filter mod 4 depth",
        "-42": "X42: filter mod 4 select",
        "-41": "X41: filter mod 1 steps",
        "-40": "X40: (no parameter)",
        "-39": "X39: filter resonance mod depth",
        "-38": "X38: filter resonance mod select",
        "-37": "X37: distortion",
        "-36": "X36: waveshaper mod 2 depth",
        "-35": "X35: waveshaper mod 2 select",
        "-34": "X34: (no parameter)",
        "-33": "X33: (no parameter)",
        "-32": "X32: oscillator mod 5 depth",
        "-31": "X31: oscillator mod 5 select",
        "-30": "X30: oscillator mod 4 depth",
        "-29": "X29: oscillator mod 4 select",
        "-28": "X28: oscillator mod 1 steps",
        "-27": "X27: tune spread",
        "-26": "X26: tune shift",
        "-25": "X25: envelope 2 release mod",
        "-24": "X24: envelope 2 decay mod depth",
        "-23": "X23: envelope 2 decay self mod",
        "-22": "X22: envelope 2 attack mod depth",
        "-21": "X21: envelope 2 conservation",
        "-20": "X20: envelope 2 peak mod depth",
        "-19": "X19: (no parameter)",
        "-18": "X18: envelope 1 release mod",
        "-17": "X17: envelope 1 decay mod depth",
        "-16": "X16: envelope 1 decay self mod",
        "-15": "X15: envelope 1 attack mod depth",
        "-14": "X14: envelope 1 conservation",
        "-13": "X13: envelope 1 peak mod depth",
        "-12": "X12: sweep amplitude mod depth",
        "-11": "X11: (no parameter)",
        "-10": "X10: sweep rate mod depth",
         "-9": "X9: (no parameter)",
         "-8": "X8: (no parameter)",
         "-7": "X7: (no parameter)",
         "-6": "X6: (no parameter)",
         "-5": "X5: ribbon algorithm",
         "-4": "X4: detune scale",
         "-3": "X3: voice count",
         "-2": "X2: link detune",
         "-1": "X1: link spread",
            0: "link balance",
            1: "P1: patch",
            2: "P2: footswitch mode",
            3: "P3: keyboard algorithm",
            4: "P4: detune",
            5: "P5: selectivity",
            6: "P6: glide rate",
            7: "P7: glide shape",
            8: "P8: sweep mode",
            9: "P9: sweep rate",
           10: "P10: sweep rate mod",
           11: "P11: sweep shape",
           12: "P12: sweep amplitude mode",
           13: "P13: envelope 1 peak mod select",
           14: "P14: envelope 1 attack",
           15: "P15: envelope 1 attack mod select",
           16: "P16: envelope 1 decay",
           17: "P17: envelope 1 decay mod select",
           18: "P18: envelope 1 release",
           19: "P19: envelope 2 trigger",
           20: "P20: envelope 2 peak mod select",
           21: "P21: envelope 2 attack",
           22: "P22: envelope 2 attack mod select",
           23: "P23: envelope 2 decay",
           24: "P24: envelope 2 decay mod select",
           25: "P25: envelope 2 release",
           26: "P26: oscillator tune",
           27: "P27: oscillator mod 1 select",
           28: "P28: oscillator mod 1 depth",
           29: "P29: oscillator mod 2 select",
           30: "P30: oscillator mod 2 depth",
           31: "P31: oscillator mod 3 select",
           32: "P32: oscillator mod 3 depth",
           33: "P33: waveshaper shape",
           34: "P34: waveshaper width",
           35: "P35: waveshaper width mod 1 select",
           36: "P36: waveshaper width mod 1 depth",
           37: "P37: filter mode",
           38: "P38: filter resonance",
           39: "P39: filter tune",
           40: "P40: filter mod 1 select",
           41: "P41: filter mod 1 depth",
           42: "P42: filter mod 2 select",
           43: "P43: filter mod 2 depth",
           44: "P44: filter mod 3 select",
           45: "P45: filter mod 3 depth",
           46: "P46: amplifier mod 1 select",
           47: "P47: amplifier mod 1 depth",
           48: "P48: amplifier mod 2 select",
           49: "P49: amplifier mod 2 depth",
           50: "P50: amplifier mod 3 select",
        }

    readonly property var   str_env_peak_mod_sel: [
        "0 warp",           // 0
        "1/8 warp",         // 1
        "1/4 warp",         // 2
        "3/8 warp",         // 3
        "linear",           // 4
        "3/4 warp",         // 5
        "1 warp",           // 6
        "5/6 threshold",    // 7
        "2/3 threshold",    // 8
        "1/2 threshold",    // 9
        "1/3 threshold",    // 10
        "1/6 threshold",    // 11
        "+lever 1",         // 12
        "+lever 2",         // 13
        "\u2012lever 1",    // 14
        "\u2012lever 2",    // 15
        "pedal 1",          // 16
        "pedal 2",          // 17
        "\u2012pedal 1",    // 18
        "\u2012pedal 2"     // 19
        ]

    readonly property var   str_env_att_dec_time: [
        "instant", "2ms", "4ms", "6ms", "8ms", "10ms", "12ms", "14ms",          // 0
        "16ms", "18ms", "20ms", "22ms", "24ms", "26ms", "28ms", "30ms",         // 8
        "32ms", "34ms", "36ms", "38ms", "40ms", "43ms", "45ms", "48ms",         // 16
        "51ms", "54ms", "58ms", "61ms", "65ms", "69ms", "73ms", "77ms",         // 24
        "81ms", "86ms", "92ms", "97ms", "103ms", "110ms", "116ms", "123ms",     // 32
        "131ms", "138ms", "146ms", "155ms", "165ms", "175ms", "185ms", "200ms", // 40
        "210ms", "220ms", "230ms", "250ms", "260ms", "280ms", "290ms", "310ms", // 48
        "330ms", "350ms", "375ms", "400ms", "420ms", "445ms", "470ms", "500ms", // 56
        "530ms", "560ms", "590ms", "630ms", "670ms", "710ms", "750ms", "800ms", // 64
        "850ms", "900ms", "950ms", "1s", "1.05s", "1.1s", "1.2s", "1.3s",       // 72
        "1.35s", "1.4s", "1.5s", "1.6s", "1.7s", "1.8s", "1.9s", "2s",          // 80
        "2.15s", "2.3s", "2.4s", "2.55s", "2.7s", "2.85s", "3.05s", "3.25s",    // 88
        "3.45s", "3.65s", "3.85s", "4.1s", "4.3s", "4.6s", "4.9s", "5.2s",      // 96
        "5.5s", "5.8s", "6.2s", "6.5s", "6.9s", "7.4s", "7.8s", "8.3s",         // 104
        "8.7s", "9.3s", "10s", "10.5s", "11s", "11.5s", "12.5s", "13s",         // 112
        "14s", "15s", "15.5s", "16.5s", "17.5s", "18.5s", "20s", "infinite"     // 120
        ]

    readonly property var   str_env_att_conserv: {
         "-1": "truncate",
          "0": "none",
          "1": "10%",
          "2": "20%",
          "3": "30%",
          "4": "40%",
          "5": "50%"
        }

    readonly property var   str_env_rate_mod_sel: [
        "+lever 1",         // 0
        "+lever 2",         // 1
        "\u2012lever 1",    // 2
        "\u2012lever 2",    // 3
        "pedal 1",          // 4
        "pedal 2",          // 5
        "\u2012pedal 1",    // 6
        "\u2012pedal 2",    // 7
        "ribbon",           // 8
        "pitch",            // 9
        "velocity",         // 10
        "pressure",         // 11
        "self"              // 12 (attack only)
        ]

    readonly property var   str_env_rel_mod: [
        "none",             // 0
        "pitch x2",         // 1
        "pitch x3",         // 2
        "pitch x4",         // 3
        "pedal 1",          // 4
        "pedal 2",          // 5
        "\u2012pedal 1",    // 6
        "\u2012pedal 2",    // 7
        "slow x2",          // 8
        "slow x4",          // 9
        "slow x8",          // 10
        "slow x16",         // 11
        "slow x32",         // 12
        "slow x64",         // 13
        "slow x128",        // 14
        "slow x256"         // 15
        ]

    readonly property var   str_env_rel_time: [
        "instant", "2ms", "4ms", "6ms", "8ms", "10ms", "12ms", "14ms",          // 0
        "16ms", "18ms", "20ms", "22ms", "24ms", "26ms", "28ms", "30ms",         // 8
        "32ms", "34ms", "36ms", "38ms", "40ms", "43ms", "45ms", "48ms",         // 16
        "51ms", "54ms", "58ms", "61ms", "65ms", "69ms", "73ms", "77ms",         // 24
        "81ms", "86ms", "92ms", "97ms", "103ms", "110ms", "116ms", "123ms",     // 32
        "131ms", "138ms", "146ms", "155ms", "165ms", "175ms", "185ms", "200ms", // 40
        "210ms", "220ms", "230ms", "250ms", "260ms", "280ms", "290ms", "310ms", // 48
        "330ms", "350ms", "375ms", "400ms", "420ms", "445ms", "470ms", "500ms", // 56
        "530ms", "560ms", "590ms", "630ms", "670ms", "710ms", "750ms", "800ms", // 64
        "850ms", "900ms", "950ms", "1s", "1.05s", "1.1s", "1.2s", "1.3s",       // 72
        "1.35s", "1.4s", "1.5s", "1.6s", "1.7s", "1.8s", "1.9s", "2s",          // 80
        "2.15s", "2.3s", "2.4s", "2.55s", "2.7s", "2.85s", "3.05s", "3.25s",    // 88
        "3.45s", "3.65s", "3.85s", "4.1s", "4.3s", "4.6s", "4.9s", "5.2s",      // 96
        "5.5s", "5.8s", "6.2s", "6.5s", "6.9s", "7.4s", "7.8s", "8.3s",         // 104
        "8.7s", "9.3s", "10s", "10.5s", "11s", "11.5s", "12.5s", "13s",         // 112
        "14s", "15s", "15.5s", "16.5s", "17.5s", "18.5s", "20s", "21s"          // 120
        ]

    readonly property var   str_env2_trigger: [
        "off",   "20ms",  "40ms",  "60ms",  "80ms",  "100ms", "120ms", "140ms", 
        "160ms", "180ms", "200ms", "220ms", "240ms", "260ms", "280ms", "300ms", 
        "320ms", "340ms", "360ms", "380ms", "400ms", "420ms", "440ms", "460ms", 
        "480ms", "500ms", "520ms", "540ms", "560ms", "580ms", "600ms", "620ms", 
        "640ms", "660ms", "680ms", "700ms", "720ms", "740ms", "760ms", "780ms", 
        "800ms", "820ms", "840ms", "860ms", "880ms", "900ms", "920ms", "940ms", 
        "960ms", "980ms", "1s",    "1.02s", "1.04s", "1.06s", "1.08s", "1.1s", 
        "1.12s", "1.14s", "1.16s", "1.18s", "1.2s",  "1.22s", "1.24s", "1.26s", 
        "1.28s", "1.3s",  "1.32s", "1.34s", "1.36s", "1.38s", "1.4s",  "1.42s", 
        "1.44s", "1.46s", "1.48s", "1.5s",  "1.52s", "1.54s", "1.56s", "1.58s", 
        "1.6s",  "1.62s", "1.64s", "1.66s", "1.68s", "1.7s",  "1.72s", "1.74s", 
        "1.76s", "1.78s", "1.8s",  "1.82s", "1.84s", "1.86s", "1.88s", "1.9s", 
        "1.92s", "1.94s", "1.96s", "1.98s", "2s",    "2.02s", "2.04s", "2.06s", 
        "2.08s", "2.1s",  "2.12s", "2.14s", "2.16s", "2.18s", "2.2s",  "2.22s", 
        "2.24s", "2.26s", "2.28s", "2.3s", 
        "release", "release sustain", "mono multiple", "mono single",
        "envelope 1A", "envelope 1B", "sweep A", "sweep B",
        "\u2012sweep A", "\u2012sweep B", "\u00B1sweep A", "\u00B1sweep B"
        ]

    readonly property var   str_flt_mode: [
        "2p lowpass",   // 0
        "4p lowpass",   // 1
        "2p bandpass",  // 2
        "4p bandpass",  // 3
        "2p highpass",  // 4
        "4p highpass"   // 5
        ]

    readonly property var   str_flt_res: [
        "0.5",  "0.52", "0.55", "0.58", "0.6",  "0.64", "0.67", "0.7",  // 0
        "0.74", "0.77", "0.8",  "0.85", "0.9",  "0.95", "1",    "1.04", // 8
        "1.08", "1.13", "1.2",  "1.25", "1.3",  "1.4",  "1.45", "1.5",  // 16
        "1.6",  "1.7",  "1.75", "1.8",  "1.9",  "2",    "2.1",  "2.2",  // 24
        "2.3",  "2.45", "2.6",  "2.7",  "2.85", "3",    "3.15", "3.3",  // 32
        "3.45", "3.6",  "3.8",  "4",    "4.2",  "4.4",  "4.6",  "4.8",  // 40
        "5",    "5.3",  "5.6",  "5.9",  "6.2",  "6.5",  "6.8",  "7.1",  // 48
        "7.5",  "7.9",  "8.2",  "8.6",  "9",    "9.5",  "10",   "10.5", // 56
        "11",   "11.5", "12",   "13",   "13.5", "14",   "15",   "15.5", // 64
        "16",   "17",   "18",   "19",   "20",   "21",   "22",   "23",   // 72
        "24",   "25",   "26",   "28",   "29",   "30",   "32",   "33",   // 80
        "35",   "37",   "39",   "41",   "43",   "45",   "47",   "49",   // 88
        "52",   "54",   "57",   "60",   "63",   "66",   "69",   "73",   // 96
        "76",   "80",   "84",   "88",   "92",   "96",   "100",  "105",  // 104
        "110",  "115",  "125",  "130",  "135",  "140",  "150",  "160",  // 112
        "165",  "170",  "180",  "190",  "200",                          // 120
        "low self-osc", "med self-osc", "high self-osc"                 // 125
        ]

    readonly property var   str_flt_tune: {
        "-64": "F0",
        "-63": "F#0",
        "-62": "G0",
        "-61": "G#0",
        "-60": "A0",
        "-59": "A#0",
        "-58": "B0",
        "-57": "C1",
        "-56": "C#1",
        "-55": "D1",
        "-54": "D#1",
        "-53": "E1",
        "-52": "F1",
        "-51": "F#1",
        "-50": "G1",
        "-49": "G#1",
        "-48": "A1",
        "-47": "A#1",
        "-46": "B1",
        "-45": "C2",
        "-44": "C#2",
        "-43": "D2",
        "-42": "D#2",
        "-41": "E2",
        "-40": "F2",
        "-39": "F#2",
        "-38": "G2",
        "-37": "G#2",
        "-36": "A2",
        "-35": "A#2",
        "-34": "B2",
        "-33": "C3",
        "-32": "C#3",
        "-31": "D3",
        "-30": "D#3",
        "-29": "E3",
        "-28": "F3",
        "-27": "F#3",
        "-26": "G3",
        "-25": "G#3",
        "-24": "A3",
        "-23": "A#3",
        "-22": "B3",
        "-21": "C4",
        "-20": "C#4",
        "-19": "D4",
        "-18": "D#4",
        "-17": "E4",
        "-16": "F4",
        "-15": "F#4",
        "-14": "G4",
        "-13": "G#4",
        "-12": "A4",
        "-11": "A#4",
        "-10": "B4",
         "-9": "C5",
         "-8": "C#5",
         "-7": "D5",
         "-6": "D#5",
         "-5": "E5",
         "-4": "F5",
         "-3": "F#5",
         "-2": "G5",
         "-1": "G#5",
            0: "A5",
            1: "A#5",
            2: "B5",
            3: "C6",
            4: "C#6",
            5: "D6",
            6: "D#6",
            7: "E6",
            8: "F6",
            9: "F#6",
           10: "G6",
           11: "G#6",
           12: "A6",
           13: "A#6",
           14: "B6",
           15: "C7",
           16: "C#7",
           17: "D7",
           18: "D#7",
           19: "E7",
           20: "F7",
           21: "F#7",
           22: "G7",
           23: "G#7",
           24: "A7",
           25: "A#7",
           26: "B7",
           27: "C8",
           28: "C#8",
           29: "D8",
           30: "D#8",
           31: "E8",
           32: "F8",
           33: "F#8",
           34: "G8",
           35: "G#8",
           36: "A8",
           37: "A#8",
           38: "B8",
           39: "C9",
           40: "C#9",
           41: "D9",
           42: "D#9",
           43: "E9",
           44: "F9",
           45: "F#9",
           46: "G9",
           47: "G#9",
           48: "A9",
           49: "A#9",
           50: "B9",
           51: "C10",
           52: "C#10",
           53: "D10",
           54: "D#10",
           55: "E10",
           56: "F10",
           57: "F#10",
           58: "G10",
           59: "G#10",
           60: "A10",
           61: "A#10",
           62: "B10",
           63: "C11"
        }

    readonly property var   str_gld_shape: [
        "constant time",    // 0
        "exponential",      // 1
        "constant slope",   // 2
        "glissando"         // 3
        ]

    readonly property var   str_gld_time: [
        "instant", "10ms", "10.5ms", "11ms", "12ms", "12.5ms", "13ms", "14ms",  // 0
        "15ms", "16ms", "17ms", "18ms", "19ms", "20ms", "21ms", "22.5ms",       // 8
        "24ms", "25.5ms", "27ms", "28.5ms", "30ms", "32ms", "34ms", "36ms",     // 16
        "38ms", "40ms", "43ms", "45ms", "48ms", "51ms", "54ms", "57ms",         // 24
        "61ms", "64ms", "68ms", "72ms", "77ms", "81ms", "86ms", "91ms",         // 32
        "96ms", "100ms", "110ms", "115ms", "120ms", "130ms", "140ms", "145ms",  // 40
        "150ms", "160ms", "170ms", "180ms", "190ms", "200ms", "220ms", "230ms", // 48
        "245ms", "260ms", "275ms", "290ms", "310ms", "325ms", "345ms", "365ms", // 56
        "390ms", "410ms", "435ms", "460ms", "490ms", "520ms", "550ms", "585ms", // 64
        "620ms", "655ms", "690ms", "735ms", "780ms", "830ms", "880ms", "930ms", // 72
        "990ms", "1.05s", "1.1s", "1.2s", "1.25s", "1.3s", "1.4s", "1.5s",      // 80
        "1.6s", "1.65s", "1.75s", "1.9s", "2s", "2.1s", "2.2s", "2.4s",         // 88
        "2.5s", "2.6s", "2.8s", "3s", "3.1s", "3.3s", "3.5s", "3.8s",           // 96
        "4s", "4.2s", "4.5s", "4.7s", "5s", "5.3s", "5.6s", "6s",               // 104
        "6.3s", "6.7s", "7s", "7.5s", "8s", "8.5s", "9s", "9.5s",               // 112
        "10s", "10.5s", "11s", "12s", "12.5s", "13.5s", "14s", "15s"            // 120
        ]

    readonly property var   str_gld_tps: [
        "instant", "40ms", "41ms", "42ms", "43ms", "44ms", "45ms", "46ms",      // 0
        "48ms", "49ms", "50ms", "51ms", "53ms", "54ms", "56ms", "57ms",         // 8
        "59ms", "60ms", "62ms", "63ms", "65ms", "67ms", "68ms", "70ms",         // 16
        "72ms", "74ms", "76ms", "77ms", "79ms", "81ms", "83ms", "85ms",         // 24
        "88ms", "90ms", "92ms", "94ms", "97ms", "99ms", "102ms", "105ms",       // 32
        "107ms", "110ms", "113ms", "116ms", "119ms", "122ms", "125ms", "129ms", // 40
        "132ms", "135ms", "139ms", "142ms", "146ms", "150ms", "154ms", "157ms", // 48
        "161ms", "165ms", "169ms", "174ms", "178ms", "183ms", "187ms", "192ms", // 56
        "197ms", "200ms", "210ms", "215ms", "220ms", "225ms", "230ms", "235ms", // 64
        "240ms", "250ms", "255ms", "260ms", "270ms", "275ms", "280ms", "290ms", // 72
        "300ms", "305ms", "310ms", "320ms", "330ms", "335ms", "340ms", "350ms", // 80
        "360ms", "370ms", "380ms", "390ms", "400ms", "410ms", "420ms", "435ms", // 88
        "445ms", "455ms", "465ms", "480ms", "490ms", "505ms", "520ms", "530ms", // 96
        "545ms", "560ms", "575ms", "590ms", "605ms", "620ms", "635ms", "650ms", // 104
        "665ms", "685ms", "700ms", "720ms", "735ms", "755ms", "775ms", "790ms", // 112
        "815ms", "840ms", "860ms", "880ms", "900ms", "930ms", "950ms", "980ms"  // 120
        ]

    readonly property var   str_middle_freq: {
         "-5": "170Hz",
         "-4": "210Hz",
         "-3": "260Hz",
         "-2": "320Hz",
         "-1": "390Hz",
            0: "480Hz",
            1: "590Hz",
            2: "730Hz",
            3: "900Hz",
            4: "1100Hz",
            5: "1350Hz"
        }

    readonly property var   str_middle_res: [
        "0.5",  // 0
        "0.7",  // 1
        "0.9",  // 2
        "1.2",  // 3
        "1.5",  // 4
        "2"     // 5
        ]

    readonly property var   str_osc_tune: {
        "-24": "C3",
        "-23": "C#3",
        "-22": "D3",
        "-21": "D#3",
        "-20": "E3",
        "-19": "F3",
        "-18": "F#3",
        "-17": "G3",
        "-16": "G#3",
        "-15": "A3",
        "-14": "A#3",
        "-13": "B3",
        "-12": "C4",
        "-11": "C#4",
        "-10": "D4",
         "-9": "D#4",
         "-8": "E4",
         "-7": "F4",
         "-6": "F#4",
         "-5": "G4",
         "-4": "G#4",
         "-3": "A4",
         "-2": "A#4",
         "-1": "B4",
            0: "C5",
            1: "C#5",
            2: "D5",
            3: "D#5",
            4: "E5",
            5: "F5",
            6: "F#5",
            7: "G5",
            8: "G#5",
            9: "A5",
           10: "A#5",
           11: "B5",
           12: "C6",
           13: "C#6",
           14: "D6",
           15: "D#6",
           16: "E6",
           17: "F6",
           18: "F#6",
           19: "G6",
           20: "G#6",
           21: "A6",
           22: "A#6",
           23: "B6",
           24: "C7",
           25: "C#7",
           26: "D7",
           27: "D#7",
           28: "E7",
           29: "F7",
           30: "F#7",
           31: "G7",
           32: "G#7",
           33: "A7",
           34: "A#7",
           35: "B7",
           36: "C8",
           37: "C#8",
           38: "D8",
           39: "D#8",
           40: "E8",
           41: "F8",
           42: "F#8",
           43: "G8",
           44: "G#8",
           45: "A8",
           46: "A#8",
           47: "B8",
           48: "C9",
           49: "C#9",
           50: "D9",
           51: "D#9",
           52: "E9",
           53: "F9",
           54: "F#9",
           55: "G9",
           56: "G#9",
           57: "A9",
           58: "A#9",
           59: "B9",
           60: "C10",
           61: "C#10",
           62: "D10",
           63: "D#10"
        }

    readonly property var   str_patch: [
        "",                             // 0
        "independent",                  // 1
        "independent + sync",           // 2
        "independent + ring mod",       // 3
        "independent + multiply",       // 4
        "independent + filter fm",      // 5
        "parallel filters",             // 6
        "parallel filters + sync",      // 7
        "parallel filters + ring mod",  // 8
        "parallel filters + multiply",  // 9
        "parallel filters + filter fm", // 10
        "series filters",               // 11
        "series filters + sync",        // 12
        "series filters + ring mod",    // 13
        "series filters + multiply",    // 14
        "series filters + filter fm",   // 15
        "vari-mix filters",             // 16
        "vari-mix filters + sync",      // 17
        "vari-mix filters + ring mod",  // 18
        "vari-mix filters + multiply"   // 19
        ]

    readonly property var   str_pitch_mod_dep: {
        "-64": "\u201264",
        "-63": "\u201262",
        "-62": "\u201260",
        "-61": "\u201258",
        "-60": "\u201256",
        "-59": "\u201254",
        "-58": "\u201252",
        "-57": "\u201250",
        "-56": "\u201248",
        "-55": "\u201246",
        "-54": "\u201244",
        "-53": "\u201242",
        "-52": "\u201240",
        "-51": "\u201238",
        "-50": "\u201236",
        "-49": "\u201235",
        "-48": "\u201234",
        "-47": "\u201233",
        "-46": "\u201232",
        "-45": "\u201231",
        "-44": "\u201230",
        "-43": "\u201229",
        "-42": "\u201228",
        "-41": "\u201227",
        "-40": "\u201226",
        "-39": "\u201225",
        "-38": "\u201224",
        "-37": "\u201223",
        "-36": "\u201222",
        "-35": "\u201221",
        "-34": "\u201220",
        "-33": "\u201219",
        "-32": "\u201218",
        "-31": "\u201217",
        "-30": "\u201216",
        "-29": "\u201215",
        "-28": "\u201214",
        "-27": "\u201213",
        "-26": "\u201212",
        "-25": "\u201211",
        "-24": "\u201210",
        "-23": "\u20129",
        "-22": "\u20128",
        "-21": "\u20127",
        "-20": "\u20126",
        "-19": "\u20125",
        "-18": "\u20124",
        "-17": "\u20123.5",
        "-16": "\u20123",
        "-15": "\u20122.5",
        "-14": "\u20122",
        "-13": "\u20121.7",
        "-12": "\u20121.4",
        "-11": "\u20121.2",
        "-10": "\u20121",
         "-9": "\u20120.8",
         "-8": "\u20120.6",
         "-7": "\u20120.5",
         "-6": "\u20120.4",
         "-5": "\u20120.3",
         "-4": "\u20120.2",
         "-3": "\u20120.15",
         "-2": "\u20120.1",
         "-1": "\u20120.05",
            0: "off",
            1: "+0.05",
            2: "+0.1",
            3: "+0.15",
            4: "+0.2",
            5: "+0.3",
            6: "+0.4",
            7: "+0.5",
            8: "+0.6",
            9: "+0.8",
           10: "+1",
           11: "+1.2",
           12: "+1.4",
           13: "+1.7",
           14: "+2",
           15: "+2.5",
           16: "+3",
           17: "+3.5",
           18: "+4",
           19: "+5",
           20: "+6",
           21: "+7",
           22: "+8",
           23: "+9",
           24: "+10",
           25: "+11",
           26: "+12",
           27: "+13",
           28: "+14",
           29: "+15",
           30: "+16",
           31: "+17",
           32: "+18",
           33: "+19",
           34: "+20",
           35: "+21",
           36: "+22",
           37: "+23",
           38: "+24",
           39: "+25",
           40: "+26",
           41: "+27",
           42: "+28",
           43: "+29",
           44: "+30",
           45: "+31",
           46: "+32",
           47: "+33",
           48: "+34",
           49: "+36",
           50: "+38",
           51: "+40",
           52: "+42",
           53: "+44",
           54: "+46",
           55: "+48",
           56: "+50",
           57: "+52",
           58: "+54",
           59: "+56",
           60: "+58",
           61: "+60",
           62: "+62",
           63: "+64"
        }

    readonly property var   str_pitch_mod_steps: [
        "none",             // 0
        "soft semis",       // 1
        "semitones",        // 2
        "whole tones",      // 3
        "minor thirds",     // 4
        "major thirds",     // 5
        "fourths",          // 6
        "tritones",         // 7
        "fifths",           // 8
        "sweep A",          // 9
        "sweep B",          // 10
        "trigger"           // 11
        ]

    readonly property var   str_pm100pct: {
        "-64": "\u2012100%",
        "-63": "\u201299%",
        "-62": "\u201297%",
        "-61": "\u201296%",
        "-60": "\u201294%",
        "-59": "\u201293%",
        "-58": "\u201291%",
        "-57": "\u201290%",
        "-56": "\u201288%",
        "-55": "\u201286%",
        "-54": "\u201285%",
        "-53": "\u201283%",
        "-52": "\u201282%",
        "-51": "\u201280%",
        "-50": "\u201279%",
        "-49": "\u201277%",
        "-48": "\u201275%",
        "-47": "\u201274%",
        "-46": "\u201272%",
        "-45": "\u201271%",
        "-44": "\u201269%",
        "-43": "\u201268%",
        "-42": "\u201266%",
        "-41": "\u201265%",
        "-40": "\u201263%",
        "-39": "\u201261%",
        "-38": "\u201260%",
        "-37": "\u201258%",
        "-36": "\u201257%",
        "-35": "\u201255%",
        "-34": "\u201254%",
        "-33": "\u201252%",
        "-32": "\u201250%",
        "-31": "\u201249%",
        "-30": "\u201247%",
        "-29": "\u201246%",
        "-28": "\u201244%",
        "-27": "\u201243%",
        "-26": "\u201241%",
        "-25": "\u201240%",
        "-24": "\u201238%",
        "-23": "\u201236%",
        "-22": "\u201235%",
        "-21": "\u201233%",
        "-20": "\u201232%",
        "-19": "\u201230%",
        "-18": "\u201229%",
        "-17": "\u201227%",
        "-16": "\u201225%",
        "-15": "\u201224%",
        "-14": "\u201222%",
        "-13": "\u201221%",
        "-12": "\u201219%",
        "-11": "\u201218%",
        "-10": "\u201216%",
         "-9": "\u201215%",
         "-8": "\u201213%",
         "-7": "\u201211%",
         "-6": "\u201210%",
         "-5": "\u20128%",
         "-4": "\u20127%",
         "-3": "\u20125%",
         "-2": "\u20124%",
         "-1": "\u20122%",
            0: "off",
            1: "+1%",
            2: "+3%",
            3: "+4%",
            4: "+6%",
            5: "+7%",
            6: "+9%",
            7: "+10%",
            8: "+12%",
            9: "+14%",
           10: "+15%",
           11: "+17%",
           12: "+18%",
           13: "+20%",
           14: "+21%",
           15: "+23%",
           16: "+25%",
           17: "+26%",
           18: "+28%",
           19: "+29%",
           20: "+31%",
           21: "+32%",
           22: "+34%",
           23: "+35%",
           24: "+37%",
           25: "+39%",
           26: "+40%",
           27: "+42%",
           28: "+43%",
           29: "+45%",
           30: "+46%",
           31: "+48%",
           32: "+50%",
           33: "+51%",
           34: "+53%",
           35: "+54%",
           36: "+56%",
           37: "+57%",
           38: "+59%",
           39: "+60%",
           40: "+62%",
           41: "+64%",
           42: "+65%",
           43: "+67%",
           44: "+68%",
           45: "+70%",
           46: "+71%",
           47: "+73%",
           48: "+75%",
           49: "+76%",
           50: "+78%",
           51: "+79%",
           52: "+81%",
           53: "+82%",
           54: "+84%",
           55: "+85%",
           56: "+87%",
           57: "+89%",
           58: "+90%",
           59: "+92%",
           60: "+93%",
           61: "+95%",
           62: "+96%",
           63: "+100%"
        }

    readonly property var   str_pm16cyc: {
        "-64": "\u201216cyc",
        "-63": "\u201215.8cyc",
        "-62": "\u201215.5cyc",
        "-61": "\u201215.2cyc",
        "-60": "\u201215cyc",
        "-59": "\u201214.8cyc",
        "-58": "\u201214.5cyc",
        "-57": "\u201214.2cyc",
        "-56": "\u201214cyc",
        "-55": "\u201213.8cyc",
        "-54": "\u201213.5cyc",
        "-53": "\u201213.2cyc",
        "-52": "\u201213cyc",
        "-51": "\u201212.8cyc",
        "-50": "\u201212.5cyc",
        "-49": "\u201212.2cyc",
        "-48": "\u201212cyc",
        "-47": "\u201211.8cyc",
        "-46": "\u201211.5cyc",
        "-45": "\u201211.2cyc",
        "-44": "\u201211cyc",
        "-43": "\u201210.8cyc",
        "-42": "\u201210.5cyc",
        "-41": "\u201210.2cyc",
        "-40": "\u201210cyc",
        "-39": "\u20129.8cyc",
        "-38": "\u20129.5cyc",
        "-37": "\u20129.2cyc",
        "-36": "\u20129cyc",
        "-35": "\u20128.8cyc",
        "-34": "\u20128.5cyc",
        "-33": "\u20128.2cyc",
        "-32": "\u20128cyc",
        "-31": "\u20127.8cyc",
        "-30": "\u20127.5cyc",
        "-29": "\u20127.2cyc",
        "-28": "\u20127cyc",
        "-27": "\u20126.8cyc",
        "-26": "\u20126.5cyc",
        "-25": "\u20126.2cyc",
        "-24": "\u20126cyc",
        "-23": "\u20125.8cyc",
        "-22": "\u20125.5cyc",
        "-21": "\u20125.2cyc",
        "-20": "\u20125cyc",
        "-19": "\u20124.8cyc",
        "-18": "\u20124.5cyc",
        "-17": "\u20124.2cyc",
        "-16": "\u20124cyc",
        "-15": "\u20123.8cyc",
        "-14": "\u20123.5cyc",
        "-13": "\u20123.2cyc",
        "-12": "\u20123cyc",
        "-11": "\u20122.8cyc",
        "-10": "\u20122.5cyc",
         "-9": "\u20122.2cyc",
         "-8": "\u20122cyc",
         "-7": "\u20121.8cyc",
         "-6": "\u20121.5cyc",
         "-5": "\u20121.2cyc",
         "-4": "\u20121cyc",
         "-3": "\u20120.8cyc",
         "-2": "\u20120.5cyc",
         "-1": "\u20120.2cyc",
            0: "off",
            1: "+0.2cyc",
            2: "+0.5cyc",
            3: "+0.8cyc",
            4: "+1cyc",
            5: "+1.2cyc",
            6: "+1.5cyc",
            7: "+1.8cyc",
            8: "+2cyc",
            9: "+2.2cyc",
           10: "+2.5cyc",
           11: "+2.8cyc",
           12: "+3cyc",
           13: "+3.2cyc",
           14: "+3.5cyc",
           15: "+3.8cyc",
           16: "+4cyc",
           17: "+4.2cyc",
           18: "+4.5cyc",
           19: "+4.8cyc",
           20: "+5cyc",
           21: "+5.2cyc",
           22: "+5.5cyc",
           23: "+5.8cyc",
           24: "+6cyc",
           25: "+6.2cyc",
           26: "+6.5cyc",
           27: "+6.8cyc",
           28: "+7cyc",
           29: "+7.2cyc",
           30: "+7.5cyc",
           31: "+7.8cyc",
           32: "+8cyc",
           33: "+8.2cyc",
           34: "+8.5cyc",
           35: "+8.8cyc",
           36: "+9cyc",
           37: "+9.2cyc",
           38: "+9.5cyc",
           39: "+9.8cyc",
           40: "+10cyc",
           41: "+10.2cyc",
           42: "+10.5cyc",
           43: "+10.8cyc",
           44: "+11cyc",
           45: "+11.2cyc",
           46: "+11.5cyc",
           47: "+11.8cyc",
           48: "+12cyc",
           49: "+12.2cyc",
           50: "+12.5cyc",
           51: "+12.8cyc",
           52: "+13cyc",
           53: "+13.2cyc",
           54: "+13.5cyc",
           55: "+13.8cyc",
           56: "+14cyc",
           57: "+14.2cyc",
           58: "+14.5cyc",
           59: "+14.8cyc",
           60: "+15cyc",
           61: "+15.2cyc",
           62: "+15.5cyc",
           63: "+15.8cyc"
        }

    readonly property var   str_pm180deg: {
        "-64": "\u2012180\xB0",
        "-63": "\u2012177\xB0",
        "-62": "\u2012174\xB0",
        "-61": "\u2012172\xB0",
        "-60": "\u2012169\xB0",
        "-59": "\u2012166\xB0",
        "-58": "\u2012163\xB0",
        "-57": "\u2012160\xB0",
        "-56": "\u2012158\xB0",
        "-55": "\u2012155\xB0",
        "-54": "\u2012152\xB0",
        "-53": "\u2012149\xB0",
        "-52": "\u2012146\xB0",
        "-51": "\u2012143\xB0",
        "-50": "\u2012141\xB0",
        "-49": "\u2012138\xB0",
        "-48": "\u2012135\xB0",
        "-47": "\u2012132\xB0",
        "-46": "\u2012129\xB0",
        "-45": "\u2012127\xB0",
        "-44": "\u2012124\xB0",
        "-43": "\u2012121\xB0",
        "-42": "\u2012118\xB0",
        "-41": "\u2012115\xB0",
        "-40": "\u2012113\xB0",
        "-39": "\u2012110\xB0",
        "-38": "\u2012107\xB0",
        "-37": "\u2012104\xB0",
        "-36": "\u2012101\xB0",
        "-35": "\u201298\xB0",
        "-34": "\u201296\xB0",
        "-33": "\u201293\xB0",
        "-32": "\u201290\xB0",
        "-31": "\u201287\xB0",
        "-30": "\u201284\xB0",
        "-29": "\u201282\xB0",
        "-28": "\u201279\xB0",
        "-27": "\u201276\xB0",
        "-26": "\u201273\xB0",
        "-25": "\u201270\xB0",
        "-24": "\u201268\xB0",
        "-23": "\u201265\xB0",
        "-22": "\u201262\xB0",
        "-21": "\u201259\xB0",
        "-20": "\u201256\xB0",
        "-19": "\u201253\xB0",
        "-18": "\u201251\xB0",
        "-17": "\u201248\xB0",
        "-16": "\u201245\xB0",
        "-15": "\u201242\xB0",
        "-14": "\u201239\xB0",
        "-13": "\u201237\xB0",
        "-12": "\u201234\xB0",
        "-11": "\u201231\xB0",
        "-10": "\u201228\xB0",
         "-9": "\u201225\xB0",
         "-8": "\u201223\xB0",
         "-7": "\u201220\xB0",
         "-6": "\u201217\xB0",
         "-5": "\u201214\xB0",
         "-4": "\u201211\xB0",
         "-3": "\u20128\xB0",
         "-2": "\u20126\xB0",
         "-1": "\u20123\xB0",
            0: "off",
            1: "+3\xB0",
            2: "+6\xB0",
            3: "+8\xB0",
            4: "+11\xB0",
            5: "+14\xB0",
            6: "+17\xB0",
            7: "+20\xB0",
            8: "+23\xB0",
            9: "+25\xB0",
           10: "+28\xB0",
           11: "+31\xB0",
           12: "+34\xB0",
           13: "+37\xB0",
           14: "+39\xB0",
           15: "+42\xB0",
           16: "+45\xB0",
           17: "+48\xB0",
           18: "+51\xB0",
           19: "+53\xB0",
           20: "+56\xB0",
           21: "+59\xB0",
           22: "+62\xB0",
           23: "+65\xB0",
           24: "+68\xB0",
           25: "+70\xB0",
           26: "+73\xB0",
           27: "+76\xB0",
           28: "+79\xB0",
           29: "+82\xB0",
           30: "+84\xB0",
           31: "+87\xB0",
           32: "+90\xB0",
           33: "+93\xB0",
           34: "+96\xB0",
           35: "+98\xB0",
           36: "+101\xB0",
           37: "+104\xB0",
           38: "+107\xB0",
           39: "+110\xB0",
           40: "+113\xB0",
           41: "+115\xB0",
           42: "+118\xB0",
           43: "+121\xB0",
           44: "+124\xB0",
           45: "+127\xB0",
           46: "+129\xB0",
           47: "+132\xB0",
           48: "+135\xB0",
           49: "+138\xB0",
           50: "+141\xB0",
           51: "+143\xB0",
           52: "+146\xB0",
           53: "+149\xB0",
           54: "+152\xB0",
           55: "+155\xB0",
           56: "+158\xB0",
           57: "+160\xB0",
           58: "+163\xB0",
           59: "+166\xB0",
           60: "+169\xB0",
           61: "+172\xB0",
           62: "+174\xB0",
           63: "+180\xB0"
        }

    readonly property var   str_pm20db: {
        "-20": "\u201220db",
        "-19": "\u201219db",
        "-18": "\u201218db",
        "-17": "\u201217db",
        "-16": "\u201216db",
        "-15": "\u201215db",
        "-14": "\u201214db",
        "-13": "\u201213db",
        "-12": "\u201212db",
        "-11": "\u201211db",
        "-10": "\u201210db",
         "-9": "\u20129db",
         "-8": "\u20128db",
         "-7": "\u20127db",
         "-6": "\u20126db",
         "-5": "\u20125db",
         "-4": "\u20124db",
         "-3": "\u20123db",
         "-2": "\u20122db",
         "-1": "\u20121db",
            0: "0db",
            1: "+1db",
            2: "+2db",
            3: "+3db",
            4: "+4db",
            5: "+5db",
            6: "+6db",
            7: "+7db",
            8: "+8db",
            9: "+9db",
           10: "+10db",
           11: "+11db",
           12: "+12db",
           13: "+13db",
           14: "+14db",
           15: "+15db",
           16: "+16db",
           17: "+17db",
           18: "+18db",
           19: "+19db",
           20: "+20db"
        }

    readonly property var   str_pm90deg: {
        "-64": "\u201290\xB0",
        "-63": "\u201289\xB0",
        "-62": "\u201287\xB0",
        "-61": "\u201286\xB0",
        "-60": "\u201284\xB0",
        "-59": "\u201283\xB0",
        "-58": "\u201282\xB0",
        "-57": "\u201280\xB0",
        "-56": "\u201279\xB0",
        "-55": "\u201277\xB0",
        "-54": "\u201276\xB0",
        "-53": "\u201275\xB0",
        "-52": "\u201273\xB0",
        "-51": "\u201272\xB0",
        "-50": "\u201270\xB0",
        "-49": "\u201269\xB0",
        "-48": "\u201267\xB0",
        "-47": "\u201266\xB0",
        "-46": "\u201265\xB0",
        "-45": "\u201263\xB0",
        "-44": "\u201262\xB0",
        "-43": "\u201260\xB0",
        "-42": "\u201259\xB0",
        "-41": "\u201258\xB0",
        "-40": "\u201256\xB0",
        "-39": "\u201255\xB0",
        "-38": "\u201253\xB0",
        "-37": "\u201252\xB0",
        "-36": "\u201251\xB0",
        "-35": "\u201249\xB0",
        "-34": "\u201248\xB0",
        "-33": "\u201246\xB0",
        "-32": "\u201245\xB0",
        "-31": "\u201244\xB0",
        "-30": "\u201242\xB0",
        "-29": "\u201241\xB0",
        "-28": "\u201239\xB0",
        "-27": "\u201238\xB0",
        "-26": "\u201237\xB0",
        "-25": "\u201235\xB0",
        "-24": "\u201234\xB0",
        "-23": "\u201232\xB0",
        "-22": "\u201231\xB0",
        "-21": "\u201230\xB0",
        "-20": "\u201228\xB0",
        "-19": "\u201227\xB0",
        "-18": "\u201225\xB0",
        "-17": "\u201224\xB0",
        "-16": "\u201222\xB0",
        "-15": "\u201221\xB0",
        "-14": "\u201220\xB0",
        "-13": "\u201218\xB0",
        "-12": "\u201217\xB0",
        "-11": "\u201215\xB0",
        "-10": "\u201214\xB0",
         "-9": "\u201213\xB0",
         "-8": "\u201211\xB0",
         "-7": "\u201210\xB0",
         "-6": "\u20128\xB0",
         "-5": "\u20127\xB0",
         "-4": "\u20126\xB0",
         "-3": "\u20124\xB0",
         "-2": "\u20123\xB0",
         "-1": "\u20121\xB0",
            0: "0\xB0",
            1: "+1\xB0",
            2: "+3\xB0",
            3: "+4\xB0",
            4: "+6\xB0",
            5: "+7\xB0",
            6: "+8\xB0",
            7: "+10\xB0",
            8: "+11\xB0",
            9: "+13\xB0",
           10: "+14\xB0",
           11: "+15\xB0",
           12: "+17\xB0",
           13: "+18\xB0",
           14: "+20\xB0",
           15: "+21\xB0",
           16: "+23\xB0",
           17: "+24\xB0",
           18: "+25\xB0",
           19: "+27\xB0",
           20: "+28\xB0",
           21: "+30\xB0",
           22: "+31\xB0",
           23: "+32\xB0",
           24: "+34\xB0",
           25: "+35\xB0",
           26: "+37\xB0",
           27: "+38\xB0",
           28: "+39\xB0",
           29: "+41\xB0",
           30: "+42\xB0",
           31: "+44\xB0",
           32: "+45\xB0",
           33: "+46\xB0",
           34: "+48\xB0",
           35: "+49\xB0",
           36: "+51\xB0",
           37: "+52\xB0",
           38: "+53\xB0",
           39: "+55\xB0",
           40: "+56\xB0",
           41: "+58\xB0",
           42: "+59\xB0",
           43: "+60\xB0",
           44: "+62\xB0",
           45: "+63\xB0",
           46: "+65\xB0",
           47: "+66\xB0",
           48: "+68\xB0",
           49: "+69\xB0",
           50: "+70\xB0",
           51: "+72\xB0",
           52: "+73\xB0",
           53: "+75\xB0",
           54: "+76\xB0",
           55: "+77\xB0",
           56: "+79\xB0",
           57: "+80\xB0",
           58: "+82\xB0",
           59: "+83\xB0",
           60: "+84\xB0",
           61: "+86\xB0",
           62: "+88\xB0",
           63: "+90\xB0"
        }

    readonly property var   str_sel_mode: [
        "normal",               // 0
        "selective",            // 1
        "sampled"               // 2
        ]

    readonly property var   str_std_mod_sel: [
        "glide A",              // 0
        "sweep A",              // 1
        "envelope 1A",          // 2
        "envelope 2A",          // 3
        "glide B",              // 4
        "sweep B",              // 5
        "envelope 1B",          // 6
        "envelope 2B",          // 7
        "+lever 1",             // 8
        "+lever 2",             // 9
        "lever 1",              // 10
        "lever 2",              // 11
        "\u2012lever 1",        // 12
        "\u2012lever 2",        // 13
        "pedal 1",              // 14
        "pedal 2",              // 15
        "\u00B1pedal 1",        // 16
        "\u00B1pedal 2",        // 17
        "\u2012pedal 1",        // 18
        "\u2012pedal 2",        // 19
        "ribbon",               // 20
        "noise",                // 21
        "velocity",             // 22
        "velocity threshold",   // 23
        "pressure",             // 24
        "pressure threshold"    // 25
        ]

    readonly property var   str_swp_ampl_mod_sel: [
        "+lever 1",         // 0
        "+lever 2",         // 1
        "lever 1",          // 2
        "lever 2",          // 3
        "\u2012lever 1",    // 4
        "\u2012lever 2",    // 5
        "pedal 1",          // 6
        "pedal 2",          // 7
        "\u00B1pedal 1",    // 8
        "\u00B1pedal 2",    // 9
        "\u2012pedal 1",    // 10
        "\u2012pedal 2",    // 11
        "ribbon",           // 12
        "pitch",            // 13
        "velocity",         // 14
        "pressure",         // 15
        "envelope 1A",      // 16
        "envelope 2A",      // 17
        "envelope 1B",      // 18
        "envelope 2B",      // 19
        "850ms delay",      // 20
        "1.3s delay",       // 21
        "2.6s delay",       // 22
        "3.8s delay",       // 23
        "5.1s delay",       // 24
        "6.4s delay"        // 25
        ]

    readonly property var   str_swp_mode: [
        "poly",             // 0
        "poly synced",      // 1
        "mono",             // 2
        "mono multiple",    // 3
        "mono single"       // 4
        ]

    readonly property var   str_swp_rate: [
        "10s", "9.5s", "9s", "8.6s", "8.3s", "7.9s", "7.5s", "7.2s",            // 0
        "6.8s", "6.5s", "6.2s", "5.9s", "5.6s", "5.4s", "5.1s", "4.9s",         // 8
        "4.7s", "4.4s", "4.2s", "4s", "3.8s", "3.7s", "3.5s", "3.3s",           // 16
        "3.2s", "3s", "2.9s", "2.7s", "2.6s", "2.5s", "2.4s", "2.3s",           // 24
        "2.2s", "2.1s", "2s", "1.9s", "1.8s", "1.7s", "1.6s", "1.5s",           // 32
        "1.45s", "1.4s", "1.35s", "1.3s", "1.2s", "1.15s", "1.1s", "1.05s",     // 40
        "1s", "1.05Hz", "1.1Hz", "1.15Hz", "1.2Hz", "1.3Hz", "1.35Hz", "1.4Hz", // 48
        "1.45Hz", "1.5Hz", "1.6Hz", "1.7Hz", "1.8Hz", "1.9Hz", "2Hz", "2.1Hz",  // 56
        "2.2Hz", "2.3Hz", "2.4Hz", "2.5Hz", "2.6Hz", "2.7Hz", "2.9Hz", "3Hz",   // 64
        "3.2Hz", "3.3Hz", "3.5Hz", "3.6Hz", "3.8Hz", "4Hz", "4.2Hz", "4.4Hz",   // 72
        "4.6Hz", "4.9Hz", "5.1Hz", "5.4Hz", "5.6Hz", "5.9Hz", "6.2Hz", "6.5Hz", // 80
        "6.8Hz", "7.1Hz", "7.4Hz", "7.8Hz", "8.2Hz", "8.6Hz", "9Hz", "9.5Hz",   // 88
        "10Hz", "10.5Hz", "11Hz", "11.5Hz", "12Hz", "12.5Hz", "13Hz", "14Hz",   // 96
        "14.5Hz", "15Hz", "16Hz", "17Hz", "18Hz", "18.5Hz", "19.5Hz", "20.5Hz", // 104
        "21.5Hz", "22.5Hz", "24Hz", "25Hz", "26Hz", "27Hz", "28.5Hz", "30Hz",   // 112
        "half note", "half triplet", "quarter note", "quarter triplet",         // 120
        "eighth note", "eighth triplet", "sixteenth note", "sixteenth triplet"  // 124
        ]

    readonly property var   str_swp_rate_mod_sel: [
        "+lever 1",         // 0
        "+lever 2",         // 1
        "lever 1",          // 2
        "lever 2",          // 3
        "\u2012lever 1",    // 4
        "\u2012lever 2",    // 5
        "pedal 1",          // 6
        "pedal 2",          // 7
        "\u00B1pedal 1",    // 8
        "\u00B1pedal 2",    // 9
        "\u2012pedal 1",    // 10
        "\u2012pedal 2",    // 11
        "ribbon",           // 12
        "pitch",            // 13
        "velocity",         // 14
        "pressure",         // 15
        "envelope 1A",      // 16
        "envelope 2A",      // 17
        "envelope 1B",      // 18
        "envelope 2B",      // 19
        "random"            // 20
        ]

    readonly property var   str_swp_shape: [
        "sine",             // 0
        "cosine",           // 1
        "offset sine",      // 2
        "half sine",        // 3
        "triangle",         // 4
        "cotriangle",       // 5
        "sawtooth",         // 6
        "random",           // 7
        "rising square",    // 8
        "falling square",   // 9
        "3 down",           // 10
        "4 down/up",        // 11
        "4 down",           // 12
        "6 down/up",        // 13
        "6 down",           // 14
        "8 down/up"         // 15
        ]

    readonly property var   str_treble_freq: {
         "-5": "1KHz",
         "-4": "1.2KHz",
         "-3": "1.5KHz",
         "-2": "1.8KHz",
         "-1": "2.3KHz",
            0: "2.8KHz",
            1: "3.4KHz",
            2: "4.2KHz",
            3: "5.2KHz",
            4: "6.4KHz",
            5: "7.9KHz"
        }

    readonly property var   str_tune_shift: {
        "-50": "random 50\xA2", 
        "-49": "random 49\xA2", 
        "-48": "random 48\xA2", 
        "-47": "random 47\xA2", 
        "-46": "random 46\xA2", 
        "-45": "random 45\xA2", 
        "-44": "random 44\xA2", 
        "-43": "random 43\xA2", 
        "-42": "random 42\xA2", 
        "-41": "random 41\xA2", 
        "-40": "random 40\xA2", 
        "-39": "random 39\xA2", 
        "-38": "random 38\xA2", 
        "-37": "random 37\xA2", 
        "-36": "random 36\xA2", 
        "-35": "random 35\xA2", 
        "-34": "random 34\xA2", 
        "-33": "random 33\xA2", 
        "-32": "random 32\xA2", 
        "-31": "random 31\xA2", 
        "-30": "random 30\xA2", 
        "-29": "random 29\xA2", 
        "-28": "random 28\xA2", 
        "-27": "random 27\xA2", 
        "-26": "random 26\xA2", 
        "-25": "random 25\xA2", 
        "-24": "random 24\xA2", 
        "-23": "random 23\xA2", 
        "-22": "random 22\xA2", 
        "-21": "random 21\xA2", 
        "-20": "random 20\xA2", 
        "-19": "random 19\xA2", 
        "-18": "random 18\xA2", 
        "-17": "random 17\xA2", 
        "-16": "random 16\xA2", 
        "-15": "random 15\xA2", 
        "-14": "random 14\xA2", 
        "-13": "random 13\xA2", 
        "-12": "random 12\xA2", 
        "-11": "random 11\xA2", 
        "-10": "random 10\xA2", 
         "-9": "random 9\xA2", 
         "-8": "random 8\xA2", 
         "-7": "random 7\xA2", 
         "-6": "random 6\xA2", 
         "-5": "random 5\xA2", 
         "-4": "random 4\xA2", 
         "-3": "random 3\xA2", 
         "-2": "random 2\xA2", 
         "-1": "random 1\xA2", 
            0: "off", 
            1: "stretch 1\xA2", 
            2: "stretch 2\xA2", 
            3: "stretch 3\xA2", 
            4: "stretch 4\xA2", 
            5: "stretch 5\xA2", 
            6: "stretch 6\xA2", 
            7: "stretch 7\xA2", 
            8: "stretch 8\xA2", 
            9: "stretch 9\xA2", 
           10: "stretch 10\xA2", 
           11: "stretch 11\xA2", 
           12: "stretch 12\xA2", 
           13: "stretch 13\xA2", 
           14: "stretch 14\xA2", 
           15: "stretch 15\xA2", 
           16: "stretch 16\xA2", 
           17: "stretch 17\xA2", 
           18: "stretch 18\xA2", 
           19: "stretch 19\xA2", 
           20: "stretch 20\xA2", 
           21: "stretch 21\xA2", 
           22: "stretch 22\xA2", 
           23: "stretch 23\xA2", 
           24: "stretch 24\xA2", 
           25: "stretch 25\xA2", 
           26: "stretch 26\xA2", 
           27: "stretch 27\xA2", 
           28: "stretch 28\xA2", 
           29: "stretch 29\xA2", 
           30: "stretch 30\xA2", 
           31: "stretch 31\xA2", 
           32: "stretch 32\xA2", 
           33: "stretch 33\xA2", 
           34: "stretch 34\xA2", 
           35: "stretch 35\xA2", 
           36: "stretch 36\xA2", 
           37: "stretch 37\xA2", 
           38: "stretch 38\xA2", 
           39: "stretch 39\xA2", 
           40: "stretch 40\xA2", 
           41: "stretch 41\xA2", 
           42: "stretch 42\xA2", 
           43: "stretch 43\xA2", 
           44: "stretch 44\xA2", 
           45: "stretch 45\xA2", 
           46: "stretch 46\xA2", 
           47: "stretch 47\xA2", 
           48: "stretch 48\xA2", 
           49: "stretch 49\xA2", 
           50: "stretch 50\xA2"
        }

    readonly property var   str_tune_spread: [
        "off",      // 0
        "1\xA2",    // 1
        "2\xA2",    // 2
        "3\xA2",    // 3
        "4\xA2",    // 4
        "5\xA2",    // 5
        "6\xA2",    // 6
        "7\xA2",    // 7
        "8\xA2",    // 8
        "9\xA2",    // 9
        "10\xA2",   // 10
        "11\xA2",   // 11
        "12\xA2",   // 12
        "13\xA2",   // 13
        "14\xA2",   // 14
        "15\xA2",   // 15
        "16\xA2",   // 16
        "17\xA2",   // 17
        "18\xA2",   // 18
        "19\xA2",   // 19
        "20\xA2",   // 20
        "21\xA2",   // 21
        "22\xA2",   // 22
        "23\xA2",   // 23
        "24\xA2",   // 24
        "25\xa2",   // 25
        "26\xa2",   // 26
        "27\xa2",   // 27
        "28\xa2",   // 28
        "29\xa2",   // 29
        "30\xA2",   // 30
        "31\xA2",   // 31
        "32\xA2",   // 32
        "33\xA2",   // 33
        "34\xA2",   // 34
        "35\xA2",   // 35
        "36\xA2",   // 36
        "37\xA2",   // 37
        "38\xA2",   // 38
        "39\xA2",   // 39
        "40\xA2",   // 40
        "41\xA2",   // 41
        "42\xA2",   // 42
        "43\xA2",   // 43
        "44\xA2",   // 44
        "45\xA2",   // 45
        "46\xA2",   // 46
        "47\xA2",   // 47
        "48\xA2",   // 48
        "49\xA2",   // 49
        "50\xA2",   // 50
        "pedal 1",  // 51
        "pedal 2"   // 52
        ]

    readonly property var   str_wav_shape: [
        "saws",             // 0
        "pulse",            // 1
        "FM 1:1",           // 2
        "FM 1:2",           // 3
        "FM 1:3",           // 4
        "FM 1:4",           // 5
        "FM 2:1",           // 6
        "FM 2:3",           // 7
        "FM 3:1",           // 8
        "FM 3:2",           // 9
        "FM 3:4",           // 10
        "FM 4:1",           // 11
        "FM 4:3",           // 12
        "oscillator FM",    // 13
        "filter FM",        // 14
        "pink noise",       // 15
        "white noise",      // 16
        "impulse"           // 17
        ]

    // DESCRIPTOR ACCESS FUNCTIONS --------------------------------------------

    function edn(p) { return edns[p >= 128 ? 1 : 0][p & 0x7F] }
    function paramMins(p) { return mins[p >= 128 ? 1 : 0][p & 0x7F] }
    function paramDefs(p) { return defs[p >= 128 ? 1 : 0][p & 0x7F] }
    function paramMaxs(p) { return maxs[p >= 128 ? 1 : 0][p & 0x7F] }
    function paramSigs(p) { return sigs[p >= 128 ? 1 : 0][p & 0x7F] }
    function paramStrs(p) { return strs[p >= 128 ? 1 : 0][p & 0x7F] }

    // CHROMA-SPECIFIC METADATA -----------------------------------------------

    property int    gangs: {
        if (!currProg)
            return -1
        var g = parseInt(currProg.gangs, 16)
        if (isNaN(g))
            return -1
        return g | 0
        }

    property int    gangsOk:    0

    onGangsChanged: {
        if (debug & 16) {
            var g = (gangs ^ 0x80000000) + 0x80000000
            console.log("gangs", ("0000000" + g.toString(16)).substr(-8))
            }
        }
    onGangsOkChanged: {
        if (debug & 16) {
            var g = (gangsOk ^ 0x80000000) + 0x80000000
            console.log("gangsOk", ("0000000" + g.toString(16)).substr(-8))
            }
        }

    // LAYOUT PROPERTIES ------------------------------------------------------

    // main screen width and height units
    readonly property real  uWid:           (width - 19 * uSpc) / 12
    readonly property real  uHgt:           (height - 33 * uSpc) / 24

    // cluster popup width
    readonly property int   clusWidth:      width * 0.48 + 0.5

    // horizontal coordinates of sections
    readonly property int   scrnX0:         uSpc
    readonly property int   scrnWidth0:     6 * uWid + 8 * uSpc + 0.5
    readonly property int   scrnX1:         scrnX0 + scrnWidth0 + uSpc
    readonly property int   scrnWidth1:     width - uSpc - scrnX1

    // SECTIONS ---------------------------------------------------------------

    Text {
        color:          "white"
        x:              scrnX0
        width:          scrnWidth0
        y:              uSpc
        height:         sectionCommon.t - 2 * uSpc
        text:           "Editor"
        textFormat:     Text.PlainText
        font.pixelSize: parent.height / 20
        font.italic:    true
        }

    RowLayout {
        x:              scrnX0
        width:          scrnWidth0
        y:              sectionCommon.y - uSpc - height
        height:         pixData * 1.5
        spacing:        uSpc

        ButtonController {
            id:             srcLever1
            text:           "LEVER 1"
            }

        ButtonController {
            id:             srcLever2
            text:           "LEVER 2"
            }

        ButtonController {
            id:             srcPedal1
            text:           "PEDAL 1"
            }

        ButtonController {
            id:             srcPedal2
            text:           "PEDAL 2"
            }

        ButtonController {
            id:             srcRibbon
            text:           "RIBBON"
            }

        ButtonController {
            id:             srcPitch
            text:           "PITCH"
            }

        ButtonController {
            id:             srcVelocity
            text:           "VELOCITY"
            }

        ButtonController {
            id:             srcPressure
            text:           "PRESSURE"
            }
        }

    ButtonHelp {
        x:              scrnX1 - 2 * uSpc - uHgt
        width:          uHgt
        y:              2 * uSpc
        height:         uHgt
        page:           "/help/Editor_screen"
        }

    ChromaSectionCommon {
        id:             sectionCommon
        x:              scrnX0
        width:          scrnWidth0
        y:              sectionControl.y - uSpc - height
        height:         3 * uHgt + 4 * uSpc
        }

    ChromaSectionControl {
        id:             sectionControl
        x:              scrnX0
        width:          scrnWidth0
        y:              sectionGlide.y - uSpc - height
        height:         2 * uHgt + 3 * uSpc
        }

    ChromaSectionGlide {
        id:             sectionGlide
        x:              scrnX0
        width:          scrnWidth0
        y:              sectionSweep.y - uSpc - height
        height:         2 * uHgt + 3 * uSpc
        }

    ChromaSectionSweep {
        id:             sectionSweep
        x:              scrnX0
        width:          scrnWidth0
        y:              sectionEnvelope1.y - uSpc - height
        height:         3 * uHgt + 4 * uSpc
        }

    ChromaSectionEnvelope1 {
        id:             sectionEnvelope1
        x:              scrnX0
        width:          scrnWidth0
        y:              sectionEnvelope2.y - uSpc - height
        height:         5 * uHgt + 6 * uSpc
        }

    ChromaSectionEnvelope2 {
        id:             sectionEnvelope2
        x:              scrnX0
        width:          scrnWidth0
        y:              parent.height - uSpc - height
        height:         6 * uHgt + 7 * uSpc
        }

    ChromaSectionOscillator {
        id:             sectionOscillator
        x:              scrnX1
        width:          scrnWidth1
        y:              uSpc
        height:         sectionWaveshaper.y - 2 * uSpc
        }

    ChromaSectionWaveshaper {
        id:             sectionWaveshaper
        x:              scrnX1
        width:          scrnWidth1
        y:              sectionFilter.y - uSpc - height
        height:         4 * uHgt + 5 * uSpc
        }

    ChromaSectionFilter {
        id:             sectionFilter
        x:              scrnX1
        width:          scrnWidth1
        y:              sectionAmplifier.y - uSpc - height
        height:         8 * uHgt + 9 * uSpc
        }

    ChromaSectionAmplifier {
        id:             sectionAmplifier
        x:              scrnX1
        width:          scrnWidth1
        y:              parent.height - uSpc - height
        height:         5 * uHgt + 6 * uSpc
        }

    // WHERE USED SUPPORT -----------------------------------------------------

    // bits representing sources
    readonly property int   bGlideA:    0x0001
    readonly property int   bSweepA:    0x0002
    readonly property int   bEnv1A:     0x0004
    readonly property int   bEnv2A:     0x0008
    readonly property int   bGlideB:    0x0010
    readonly property int   bSweepB:    0x0020
    readonly property int   bEnv1B:     0x0040
    readonly property int   bEnv2B:     0x0080
    readonly property int   bLever1:    0x0100
    readonly property int   bLever2:    0x0200
    readonly property int   bPedal1:    0x0400
    readonly property int   bPedal2:    0x0800
    readonly property int   bRibbon:    0x1000
    readonly property int   bPitch:     0x2000
    readonly property int   bVel:       0x4000
    readonly property int   bPress:     0x8000

    // mapping parameter values to source bits
    readonly property var   usedByEnvPeak: [
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                bLever1,    bLever2,    bLever1,    bLever2, 
                                bPedal1,    bPedal2,    bPedal1,    bPedal2
                                ]

    readonly property var   usedByEnvRateMod: [
                                bLever1,    bLever2,    bLever1,    bLever2,
                                bPedal1,    bPedal2,    bPedal1,    bPedal2,
                                bRibbon,    bPitch,     bVel,       bPress,
                                0
                                ]

    readonly property var   usedByEnvReleaseMod: [
                                0, 0, 0, 0, 
                                bPedal1,    bPedal2,    bPedal1,    bPedal2, 
                                0, 0, 0, 0, 0, 0, 0, 0
                                ]

    readonly property var   usedByEnv2Trigger: [
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 
                                bEnv1A,     bEnv1B,     bSweepA,    bSweepB, 
                                bSweepA,    bSweepB,    bSweepA,    bSweepB
                                ]

    readonly property var   usedByGlide: [
                                bLever1,    bLever2,    bLever1,    bLever2,
                                bLever1,    bLever2,    bPedal1,    bPedal2,
                                bPedal1,    bPedal2,    bPedal1,    bPedal2,
                                bRibbon,    bPitch,     bVel,       bPress
                                ]

    readonly property var   usedByModSteps: [
                                0, 0, 0, 0, 0, 0, 0, 0, 0, bSweepA, bSweepB, 0
                                ]
    
    readonly property var   usedByModSelect:  [
                                bGlideA,    bSweepA,    bEnv1A,     bEnv2A,
                                bGlideB,    bSweepB,    bEnv1B,     bEnv2B,
                                bLever1,    bLever2,    bLever1,    bLever2,
                                bLever1,    bLever2,    bPedal1,    bPedal2,
                                bPedal1,    bPedal2,    bPedal1,    bPedal2,
                                bRibbon,    0,          bVel,       bVel,
                                bPress,     bPress
                                ]

    readonly property var   usedBySweepAmplMod: [
                                bLever1,    bLever2,    bLever1,    bLever2,
                                bLever1,    bLever2,    bPedal1,    bPedal2,
                                bPedal1,    bPedal2,    bPedal1,    bPedal2,
                                bRibbon,    bPitch,     bVel,       bPress,
                                bEnv1A,     bEnv2A,     bEnv1B,     bEnv2B,
                                0, 0, 0, 0, 0, 0
                                ]

    readonly property var   usedBySweepRateMod: [
                                bLever1,    bLever2,    bLever1,    bLever2,
                                bLever1,    bLever2,    bPedal1,    bPedal2,
                                bPedal1,    bPedal2,    bPedal1,    bPedal2,
                                bRibbon,    bPitch,     bVel,       bPress,
                                bEnv1A,     bEnv2A,     bEnv1B,     bEnv2B,
                                0
                                ]

    readonly property var   usedByTuneSpread: [
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
                                0, 0, 0, bPedal1, bPedal2
                                ]

    readonly property var   usedByVolModSelect: [
                                bEnv1A, bEnv2A, bEnv1B, bEnv2B, 0
                                ]

    readonly property var   usedByVolPostmodSelect: [
                                bLever1,    bLever2,    bLever1,    bLever2,
                                bPedal1,    bPedal2,    bPedal1,    bPedal2,
                                bRibbon,    bPitch,     bVel,       bPress,
                                bSweepA,    bSweepB
                                ]

    property int pressedSrc:    (srcLever1.pressed && bLever1)
                              | (srcLever2.pressed && bLever2) 
                              | (srcPedal1.pressed && bPedal1) 
                              | (srcPedal2.pressed && bPedal2) 
                              | (srcRibbon.pressed && bRibbon) 
                              | (srcPitch.pressed && bPitch)
                              | (srcVelocity.pressed && bVel) 
                              | (srcPressure.pressed && bPress) 
                              | (sectionGlide.pressedA && bGlideA) 
                              | (sectionSweep.pressedA && bSweepA) 
                              | (sectionEnvelope1.pressedA && bEnv1A) 
                              | (sectionEnvelope2.pressedA && bEnv2A) 
                              | (sectionGlide.pressedB && bGlideB) 
                              | (sectionSweep.pressedB && bSweepB) 
                              | (sectionEnvelope1.pressedB && bEnv1B) 
                              | (sectionEnvelope2.pressedB && bEnv2B)

    property int used:          sectionControl.used 
                              | sectionGlide.used 
                              | sectionSweep.used 
                              | sectionEnvelope1.used 
                              | sectionEnvelope2.used 
                              | sectionOscillator.used 
                              | sectionWaveshaper.used 
                              | sectionFilter.used 
                              | sectionAmplifier.used

    // POPUP SUPPORT ----------------------------------------------------------

    // popups -- array of popups, so metadata can refer to them by index
    readonly property var popups: [].concat(
        sectionGlide.popups,
        sectionSweep.popups,
        sectionEnvelope1.popups,
        sectionEnvelope2.popups,
        sectionOscillator.popups,
        sectionWaveshaper.popups,
        sectionFilter.popups,
        sectionAmplifier.popups,
        sectionCommon.popups,
        sectionControl.popups
        )

    // dimmer -- for dimming the content
    Rectangle {
        id:             dimmer
        color:          "#C0000000" // black, 75% opacity
        anchors.fill:   parent
        visible:        false       // not visible until explicitly enabled

        MouseArea {
            anchors.fill:   parent
            onClicked:      dismiss(modalPopup)
            }
        }

    // POPUP FUNCTIONS --------------------------------------------------------

    Shortcut {
        sequence:       "Esc"
        enabled:        contentSelect === "chr"
        onActivated: {
            if (modalPopup)
                dismiss(modalPopup)
            popups.forEach(p => { p.visible = false })
            }
        }

    property var modalPopup:    null    // what popup is in modal state
    property int topz:          0       // Z order counter

    // PARAMETER EDITING KEYS -------------------------------------------------

    Shortcut {
        sequence:       "Left"
        enabled:        contentSelect === "chr"
        onActivated: {
            var v = lastParamNumber < 384 ? lastParamNumber 
                                          : lastParamNumber - 256
            v = root["p" + v]
            if (v > paramMins(lastParamNumber))
                setSendParam(lastParamNumber, v - 1)
            }
        }

    Shortcut {
        sequence:       "Right"
        enabled:        contentSelect === "chr"
        onActivated: {
            var v = lastParamNumber < 384 ? lastParamNumber 
                                          : lastParamNumber - 256
            v = root["p" + v]
            if (v < paramMaxs(lastParamNumber))
                setSendParam(lastParamNumber, v + 1)
            }
        }

    /* dismiss(obj) -----------------------------------------------------------
    This makes obj, the modal popup, and the dimmer invisible.               */

    function dismiss(obj) {
        if (obj)
            obj.visible = false
        dimmer.visible = false
        if (modalPopup) {
            modalPopup.visible = false
            modalPopup = null
            }
        }

    /* makeModal(obj) ---------------------------------------------------------
    This dims the editor, makes obj visible in the center, and records obj in 
    modalPopup.                                                              */

    function makeModal(obj) {
        if (obj) {
            obj.x = Math.round((width - obj.width) / 2)
            obj.y = Math.round((height - obj.height) / 2)
            toTop(dimmer)
            toTop(obj)
            modalPopup = obj
            }
        }

    /* makeNonmodal(obj) ------------------------------------------------------
    This makes obj nonmodal if it is modal, and moves it to the top of the Z 
    order.                                                                   */

    function makeNonmodal(obj) {
        if (modalPopup === obj) {
            dimmer.visible = false
            modalPopup = null
            }
        toTop(obj)
        }

    /* toTop(obj) -------------------------------------------------------------
    This gives obj the highest Z order, and makes it visible.                */

    function toTop(obj) {
        if (obj) {
            if (!obj.visible) {
                obj.z = ++topz
                obj.visible = true
                }
            else if (obj.z !== topz)
                obj.z = ++topz
            }
        }

    // CLUSTER DRAGGING -------------------------------------------------------

    property var    dragParams: null    // parameter values being dragged
    property var    dragPopup:  null    // the popup object begin dragged
    property bool   dragReset:  false   // true if source was reset to default  
    property var    dropPopup:  null    // the popup object whose cluster 
                                        //  button the mouse is within

    /* gangsCheck -------------------------------------------------------------
    If m is true, indicating a pair of twinned clusters matches, it ORs bit b 
    into gangsOk, or clears that bit in gangsOk if m is false. Then, if there 
    are any bits set in gangs that aren't set in gangsOk, it restarts the 
    gangsTimer, which will clear the gangs bit if the discrepancy isn't 
    resolved before the timer expires; otherwise, it stops the timer.        */

    function gangsCheck(m, b) {
        if (m)
            gangsOk |= b
        else
            gangsOk &= ~b
        if (gangs & ~gangsOk)
            gangsTimer.restart()
        else
            gangsTimer.stop()
        }

    /* gangsSet(g) ------------------------------------------------------------
    If g differs from the gangs metadatum, this sends a ProgSetMeta message 
    containing the new value. The response changes currProg, gangs, and 
    everything that derives from them, including the displays.               */

    function gangsSet(g) {
        console.log("gangsSet", ("0000000" + g.toString(16)).substr(-8))
        g = (g ^ 0x80000000) + 0x80000000
        setMeta("gangs", g !== 0xFFFFFFFF 
                ? ("0000000" + g.toString(16)).substr(-8) : null)
        }

    // gangsTimer -- Clears any gangs bit not allowed by gangsOk.
    Timer {
        id:             gangsTimer
        interval:       100
        onTriggered:    {
            if (gangs & ~gangsOk)
                gangsSet(gangs & gangsOk)
            }
        }

    // PARAMETER OUTPUT FUNCTIONS ---------------------------------------------

    property int    lastEditMode:       0   // edit mode, 0 if non-channelized
    property int    lastEditNumber:     1   // edit number, -50 to +50
    property int    lastParamNumber:    24  // parameter number

    onLastEditModeChanged: console.log("Mode", lastEditMode)
    onLastEditNumberChanged: console.log("Num", lastEditNumber)

    /* setSendDefaults(p) -----------------------------------------------------
    This sets and sends the default values for all the parameters listed in 
    array p.                                                                 */

    function setSendDefaults(p) {
        for (var i = 0; i < p.length; ++i)
            setSendParam(p[i], paramDefs(p[i]))
        }
    }
