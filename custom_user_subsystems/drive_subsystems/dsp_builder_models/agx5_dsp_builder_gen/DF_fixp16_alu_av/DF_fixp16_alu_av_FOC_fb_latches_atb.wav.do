onerror {resume}

# obtain Modelsim version and extract the NN.Nc part after vsim
quietly set vsim_ver [regexp -inline {vsim (\d+\.\d+)(\w?)} [vsim -version]]
quietly set has_fixpt_radix 0
if {[lindex $vsim_ver 1] == 10.2} {
    if {[lindex $vsim_ver 2] >= "d"} {
        quietly set has_fixpt_radix 1
    }
} elseif {[lindex $vsim_ver 1] > 10.2} {
    quietly set has_fixpt_radix 1
}

proc add_fixpt_wave {name width frac_width signed} {
    global has_fixpt_radix
    if {$frac_width > 0 && $has_fixpt_radix} {
        set type "[string index $signed 0]fix${width}_En${frac_width}"
        if {[lsearch [radix names] $type] < 0} {
            if {$signed == "signed"} {
                radix define $type -fixed -signed -fraction $frac_width
            } else {
                radix define $type -fixed -fraction $frac_width
            }
        }
        add wave -noupdate -format Literal -radix $type $name
    } else {
        add wave -noupdate -format Literal -radix $signed $name
    }
}

add wave -noupdate -divider {Input Ports}
add wave -noupdate -format Logic /DF_fixp16_alu_av_FOC_fb_latches_atb/dut/clk
add wave -noupdate -format Logic /DF_fixp16_alu_av_FOC_fb_latches_atb/dut/areset
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/in_6_axis_in_tpl_stm 8 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/in_5_axis_out_tpl_stm 8 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/in_1_id_int_tpl_stm 16 10 signed
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/in_4_valid_out_tpl_stm
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/in_3_qv_tpl_stm
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/in_2_iq_int_tpl_stm 16 10 signed
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/in_7_reset_tpl_stm
add wave -noupdate -divider {Output Ports}
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/dut/out_2_iq_int_latch_tpl 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/out_2_iq_int_latch_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/dut/out_1_id_int_latch_tpl 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_fb_latches_atb/sim/out_1_id_int_latch_tpl_stm 16 10 signed
TreeUpdate [SetDefaultTree]
