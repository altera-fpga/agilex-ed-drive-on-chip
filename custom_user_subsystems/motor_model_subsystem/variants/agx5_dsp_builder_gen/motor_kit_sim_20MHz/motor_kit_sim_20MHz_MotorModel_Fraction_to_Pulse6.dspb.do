# This is the Run ModelSim file list for 'motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6'

if {![info exist use_own_safe_path] || ![string equal -nocase $use_own_safe_path true]} {
    vcom -93 -quiet $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_safe_path_msim.vhd
}
vcom -93 -quiet $base_dir/motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6.vhd
