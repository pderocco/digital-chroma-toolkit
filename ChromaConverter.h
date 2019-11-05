// ChromaConverter.h

#ifndef CHROMACONVERTER_H
#define CHROMACONVERTER_H

#include <cstdint>
#include <QObject>
#include <QQuickItem>
#include <QByteArray>
#include <QString>

/* n_channel, n_program -------------------------------------------------------
These represent a new Digital Chroma program.                                */

struct n_channel {  // 79 bytes
    int8_t      gld_time;
    int8_t      gld_shape;
    int8_t      gld_mod_sel;
    int8_t      gld_mod_dep;
    int8_t      swp_mode;
    int8_t      swp_rate;
    int8_t      swp_rate_mod_sel;
    int8_t      swp_rate_mod_dep;
    int8_t      swp_shape;
    int8_t      swp_ampl_mod_sel;
    int8_t      swp_ampl_mod_dep;
    int8_t      env1_peak_mod_sel;
    int8_t      env1_peak_mod_dep;
    int8_t      env1_att_time;
    int8_t      env1_att_conserv;
    int8_t      env1_att_mod_sel;
    int8_t      env1_att_mod_dep;
    int8_t      env1_dec_time;
    int8_t      env1_dec_self_mod;
    int8_t      env1_dec_mod_sel;
    int8_t      env1_dec_mod_dep;
    int8_t      env1_rel_time;
    int8_t      env1_rel_mod;
    int8_t      env2_trigger;
    int8_t      env2_peak_mod_sel;
    int8_t      env2_peak_mod_dep;
    int8_t      env2_att_time;
    int8_t      env2_att_conserv;
    int8_t      env2_att_mod_sel;
    int8_t      env2_att_mod_dep;
    int8_t      env2_dec_time;
    int8_t      env2_dec_self_mod;
    int8_t      env2_dec_mod_sel;
    int8_t      env2_dec_mod_dep;
    int8_t      env2_rel_time;
    int8_t      env2_rel_mod;
    int8_t      osc_tune;
    int8_t      osc_mod1_sel;
    int8_t      osc_mod1_dep;
    int8_t      osc_mod1_steps;
    int8_t      osc_mod2_sel;
    int8_t      osc_mod2_dep;
    int8_t      osc_mod3_sel;
    int8_t      osc_mod3_dep;
    int8_t      osc_mod4_sel;
    int8_t      osc_mod4_dep;
    int8_t      osc_mod5_sel;
    int8_t      osc_mod5_dep;
    int8_t      wav_shape;
    int8_t      wav_width;
    int8_t      wav_mod1_sel;
    int8_t      wav_mod1_dep;
    int8_t      wav_mod2_sel;
    int8_t      wav_mod2_dep;
    int8_t      flt_mode;
    int8_t      flt_res;
    int8_t      flt_res_mod_sel;
    int8_t      flt_res_mod_dep;
    int8_t      flt_tune;
    int8_t      flt_mod1_sel;
    int8_t      flt_mod1_dep;
    int8_t      flt_mod1_steps;
    int8_t      flt_mod2_sel;
    int8_t      flt_mod2_dep;
    int8_t      flt_mod3_sel;
    int8_t      flt_mod3_dep;
    int8_t      flt_mod4_sel;
    int8_t      flt_mod4_dep;
    int8_t      flt_mod5_sel;
    int8_t      flt_mod5_dep;
    int8_t      amp_mod1_sel;
    int8_t      amp_mod1_dep;
    int8_t      amp_mod2_sel;
    int8_t      amp_mod2_dep;
    int8_t      amp_postmod_sel;
    int8_t      amp_postmod_dep;
    int8_t      amp_pan;
    int8_t      amp_pan_mod_sel;
    int8_t      amp_pan_mod_dep;
    };

struct n_program {  // 10+36+79+79 = 204 bytes
    int8_t      ts_year;
    int8_t      ts_month;
    int8_t      ts_day;
    int8_t      ts_hour;
    int8_t      ts_minute;
    int8_t      ts_second;
    int8_t      ts_10ms;
    int8_t      ts_100us;
    int8_t      arch;
    int8_t      ver;

    int8_t      link_bank;
    int8_t      link_number;
    int8_t      link_mode;
    int8_t      link_balance;
    int8_t      link_spread;
    int8_t      link_detune;
    int8_t      kybd_split;
    int8_t      main_transpose;
    int8_t      link_transpose;
    int8_t      edit_mode;
    int8_t      edit_number;
    int8_t      sequence_bank;
    int8_t      sequence_number;
    int8_t      fsw_mode;
    int8_t      ribbon_alg;
    int8_t      kybd_alg;
    int8_t      bass_gain;
    int8_t      bass_freq;
    int8_t      middle_gain;
    int8_t      middle_freq;
    int8_t      middle_res;
    int8_t      treble_gain;
    int8_t      treble_freq;
    int8_t      distortion;
    int8_t      patch;
    int8_t      voice_count;
    int8_t      detune;
    int8_t      detune_scale;
    int8_t      tune_shift;
    int8_t      tune_spread;
    int8_t      pan_spread;
    int8_t      lever_modes;
    int8_t      pedal_modes;
    int8_t      ribbon_mode;
    int8_t      reverb_room;
    int8_t      reverb_send;

    n_channel   a;
    n_channel   b;
    };

/* o_channel, o_program -------------------------------------------------------
These represent an old Chroma program in unpacked form.                      */

struct o_channel {  // 45 bytes
    int8_t      gld_shape;
    int8_t      gld_rate;
    int8_t      swp_mode;
    int8_t      swp_rate;
    int8_t      swp_rate_mod;
    int8_t      swp_shape;
    int8_t      swp_ampl_mod;
    int8_t      env1_ampl_touch;
    int8_t      env1_att;
    int8_t      env1_att_mod;
    int8_t      env1_dec;
    int8_t      env1_dec_mod;
    int8_t      env1_rel;
    int8_t      env2_del;
    int8_t      env2_ampl_touch;
    int8_t      env2_att;
    int8_t      env2_att_mod;
    int8_t      env2_dec;
    int8_t      env2_dec_mod;
    int8_t      env2_rel;
    int8_t      pch_tune;
    int8_t      pch_mod1_dep;
    int8_t      pch_mod1_sel;
    int8_t      pch_mod2_dep;
    int8_t      pch_mod2_sel;
    int8_t      pch_mod3_dep;
    int8_t      pch_mod3_sel;
    int8_t      wav_shape;
    int8_t      wav_width;
    int8_t      wav_mod_dep;
    int8_t      wav_mod_sel;
    int8_t      cut_lphp;
    int8_t      cut_res;
    int8_t      cut_tune;
    int8_t      cut_mod1_dep;
    int8_t      cut_mod1_sel;
    int8_t      cut_mod2_dep;
    int8_t      cut_mod2_sel;
    int8_t      cut_mod3_dep;
    int8_t      cut_mod3_sel;
    int8_t      vol_mod1_dep;
    int8_t      vol_mod1_sel;
    int8_t      vol_mod2_dep;
    int8_t      vol_mod2_sel;
    int8_t      vol_mod3_sel;
    };

struct o_program { // 13+45+45 = 103 bytes
    int8_t      link_mode;
    int8_t      link_num;
    int8_t      kbd_split;
    int8_t      main_trans;
    int8_t      link_trans;
    int8_t      edit_num;
    int8_t      edit_mode;
    int8_t      seq_num;
    int8_t      link_balance;
    int8_t      patch;
    int8_t      detune;
    int8_t      kbd_alg;
    int8_t      fsw_mode;

    o_channel   a;
    o_channel   b;
    };

/* param_descr ----------------------------------------------------------------
This represents a range of bits in a packed old Chroma program. The bits member 
is the size of the parameter, starting with the msb of byte zero, and negated 
if the parameter is bipolar. The offs member is the offset within the 
o_program, or 0xFF to skip over unused bits. The parameter table is made up of 
D and X macros.                                                              */

struct param_descr {
    int8_t      bits;
    uint8_t     offs;
    };
#define D(b, o) { b, offsetof(o_program, o) }
#define X(b)    { b, 0xFF }

// ChromaConverter ------------------------------------------------------------

class ChromaConverter: public QObject {

    Q_OBJECT
    Q_PROPERTY(bool invert1     NOTIFY invert1Changed     READ invert1     WRITE setInvert1)
    Q_PROPERTY(bool invert2     NOTIFY invert2Changed     READ invert2     WRITE setInvert2)
    Q_PROPERTY(int panSpread    NOTIFY panSpreadChanged   READ panSpread   WRITE setPanSpread)
    Q_PROPERTY(bool selective1  NOTIFY selective1Changed  READ selective1  WRITE setSelective1)
    Q_PROPERTY(bool selective2  NOTIFY selective2Changed  READ selective2  WRITE setSelective2)
    Q_PROPERTY(int tuneShift    NOTIFY tuneShiftChanged   READ tuneShift   WRITE setTuneShift)
    Q_PROPERTY(int tuneSpread   NOTIFY tuneSpreadChanged  READ tuneSpread  WRITE setTuneSpread)
    Q_PROPERTY(int voiceCount   NOTIFY voiceCountChanged  READ voiceCount  WRITE setVoiceCount)

    bool        m_invert1;      // true to invert lever 1 mods
    bool        m_invert2;      // true to invert lever 2 mods
    int         m_panSpread;    // Pan Spread parameter
    bool        m_selective1;   // lever 1 selectivity parameter
    bool        m_selective2;   // lever 2 selectivity parameter
    int         m_tuneShift;    // Tune Shift parameter
    int         m_tuneSpread;   // Tune Spread parameter
    int         m_voiceCount;   // Voice Count parameter

    qint64      lastts;         // last timestamp generated
    o_program   op;             // unpacked old program
    int         swpGainA;       // log2 gain of sweep A mod depths
    int         swpGainB;       // log2 gain of sweep B mod depths

    void        convertAudio(o_channel const& oc, n_channel& nc);
    int         convertControls(o_channel const& oc, n_channel& nc, bool b);
    int8_t      convertDepth(int8_t md, int8_t ms, int8_t ds, bool p);
    void        convertProgram(int pn, QString n);

public:

    explicit    ChromaConverter(QObject* p = nullptr): QObject(p), 
                    m_invert1(false), m_invert2(false), m_panSpread(0), 
                    m_selective1(false), m_selective2(false), 
                    m_tuneShift(0), m_tuneSpread(0), m_voiceCount(1) {}

    bool        invert1() const { return m_invert1; }
    bool        invert2() const { return m_invert2; }
    int         panSpread() const { return m_panSpread; }
    bool        selective1() const { return m_selective1; }
    bool        selective2() const { return m_selective2; }
    int         tuneShift() const { return m_tuneShift; }
    int         tuneSpread() const { return m_tuneSpread; }
    int         voiceCount() const { return m_voiceCount; }

    Q_INVOKABLE
    void        convert(QByteArray sysex, QByteArray names);

public slots:

    void        setInvert1(bool invert1);
    void        setInvert2(bool invert2);
    void        setPanSpread(int panSpread);
    void        setSelective1(bool selective1);
    void        setSelective2(bool selective2);
    void        setTuneShift(int tuneShift);
    void        setTuneSpread(int tuneSpread);
    void        setVoiceCount(int voiceCount);

signals:

    void        error(QString message);
    void        invert1Changed(bool invert1);
    void        invert2Changed(bool invert2);
    void        panSpreadChanged(int panSpread);
    void        program(int number, QByteArray program);
    void        selective1Changed(bool selective1);
    void        selective2Changed(bool selective2);
    void        tuneShiftChanged(int tuneShift);
    void        tuneSpreadChanged(int tuneSpread);
    void        voiceCountChanged(int voiceCount);
    };

#endif // CHROMACONVERTER_H
