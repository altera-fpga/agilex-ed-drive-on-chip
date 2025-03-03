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
add wave -noupdate -format Logic /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/clk
add wave -noupdate -format Logic /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/areset
add wave -noupdate -format Logic /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/h_areset
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm 16 16 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm 16 9 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm 16 9 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm 16 9 signed
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm
add wave -noupdate -divider {Output Ports}
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_stm 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl 16 0 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_stm 16 0 signed
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_stm
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl 16 0 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_stm 16 0 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl 16 16 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_stm 16 16 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl 16 16 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_stm 16 16 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl 16 14 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_stm 16 14 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl 16 14 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_stm 16 14 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl 16 16 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_stm 16 16 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl 16 39 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_stm 16 39 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_stm 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl 16 0 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_stm 16 0 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_stm 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_stm 16 6 signed
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl 16 0 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_stm 16 0 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl 16 6 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_stm 16 6 unsigned
add wave -noupdate -divider {Bus Ports}
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/busIn_writedata_stm 32 0 unsigned
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/busIn_address_stm 6 0 unsigned
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/busIn_write_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/sim/busIn_read_stm
add wave -noupdate -format Logical /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/busOut_readdatavalid
add_fixpt_wave /busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb/dut/busOut_readdata 32 0 unsigned
TreeUpdate [SetDefaultTree]
