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
add wave -noupdate -format Logic /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/clk
add wave -noupdate -format Logic /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/areset
add wave -noupdate -format Logic /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/h_areset
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/MM_valid_out_stm
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/ia_A_stm 16 9 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/ib_A_stm 16 9 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/ic_A_stm 16 9 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/dTheta_dt_rad_s_stm 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/ThetaMech_one_turn_stm 16 16 unsigned
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/ready_stm
add wave -noupdate -divider {Output Ports}
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/MM_valid_in
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/MM_valid_in_stm
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Vabc_range_V_cfg 16 0 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Vabc_range_V_cfg_stm 16 0 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Va_V 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Va_V_stm 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Vb_V 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Vb_V_stm 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Vc_V 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Vc_V_stm 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/SampleTime_s_cfg 16 39 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/SampleTime_s_cfg_stm 16 39 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Rphase_ohm_cfg 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Rphase_ohm_cfg_stm 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/inv_Lphase_1_H_cfg 16 6 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/inv_Lphase_1_H_cfg_stm 16 6 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/PolePairs_int_cfg 16 14 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/PolePairs_int_cfg_stm 16 14 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Ke_Vs_rad_cfg 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Ke_Vs_rad_cfg_stm 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Kt_Nm_A_cfg 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Kt_Nm_A_cfg_stm 16 16 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/inv_J_1_kgm2_cfg 16 0 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/inv_J_1_kgm2_cfg_stm 16 0 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/LoadT_Nm 16 14 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/LoadT_Nm_stm 16 14 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/DC_link_range_V_cfg 16 0 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/DC_link_range_V_cfg_stm 16 0 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/DC_link_V 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/DC_link_V_stm 16 6 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/Iabc_range_cfg 16 0 signed
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/Iabc_range_cfg_stm 16 0 signed
add wave -noupdate -divider {Bus Ports}
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/busIn_writedata_stm 32 0 unsigned
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/busIn_address_stm 6 0 unsigned
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/busIn_write_stm
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/sim/busIn_read_stm
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/busOut_readdatavalid
add_fixpt_wave /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/busOut_readdata 32 0 unsigned
add wave -noupdate -format Logical /standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb/dut/busOut_waitrequest
TreeUpdate [SetDefaultTree]
