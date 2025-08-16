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
add wave -noupdate -format Logic /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/clk
add wave -noupdate -format Logic /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/areset
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_1_dv_tpl_stm
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_2_dc_tpl_stm 8 0 unsigned
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_3_valid_in_tpl_stm
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_4_axis_in_tpl_stm 8 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_5_Iu_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_6_Iw_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_7_Torque_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_8_IntegralQ_in_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_9_IntegralD_in_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_10_phi_el_tpl_stm 16 16 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_11_Kp_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_12_Ki_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_13_I_Sat_Limit_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/in_14_Max_tpl_stm 16 0 unsigned
add wave -noupdate -divider {Output Ports}
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_1_qv_tpl
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_1_qv_tpl_stm
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_2_qc_tpl 8 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_2_qc_tpl_stm 8 0 unsigned
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_3_valid_out_tpl
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_3_valid_out_tpl_stm
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_4_axis_out_tpl 8 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_4_axis_out_tpl_stm 8 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_5_Valpha_tpl 32 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_5_Valpha_tpl_stm 32 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_6_Vbeta_tpl 32 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_6_Vbeta_tpl_stm 32 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_7_IntegralD_out_tpl 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_7_IntegralD_out_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_8_IntegralQ_out_tpl 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_8_IntegralQ_out_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_9_Iq_tpl 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_9_Iq_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_10_Id_tpl 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_10_Id_tpl_stm 16 10 signed
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_11_uvw_0_tpl 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_11_uvw_0_tpl_stm 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_11_uvw_1_tpl 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_11_uvw_1_tpl_stm 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_11_uvw_2_tpl 16 0 unsigned
add_fixpt_wave /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_11_uvw_2_tpl_stm 16 0 unsigned
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/dut/out_12_ready_tpl
add wave -noupdate -format Logical /DF_fixp16_alu_av_FOC_FL_fixp16_atb/sim/out_12_ready_tpl_stm
TreeUpdate [SetDefaultTree]
