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
add wave -noupdate -format Logic /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/clk
add wave -noupdate -format Logic /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/areset
add wave -noupdate -format Logic /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/h_areset
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl_stm 8 0 unsigned
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl_stm
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl_stm 32 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl_stm 32 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl_stm 16 0 unsigned
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl_stm 16 0 unsigned
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl_stm 16 0 unsigned
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl_stm
add wave -noupdate -divider {Output Ports}
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl 8 0 unsigned
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl_stm 8 0 unsigned
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl_stm
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl 16 0 unsigned
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl_stm 16 0 unsigned
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl_stm 16 10 signed
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl 16 16 unsigned
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl_stm 16 16 unsigned
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl_stm
add wave -noupdate -divider {Bus Ports}
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/busIn_writedata_stm 32 0 unsigned
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/busIn_address_stm 6 0 unsigned
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/busIn_write_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/sim/busIn_read_stm
add wave -noupdate -format Logical /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/busOut_readdatavalid
add_fixpt_wave /busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz_atb/dut/busOut_readdata 32 0 unsigned
TreeUpdate [SetDefaultTree]
