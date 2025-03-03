# This is the Run ModelSim file list for 'DF_fixp16_alu_av_FOC_FL_fixp16'

if {![info exist use_own_safe_path] || ![string equal -nocase $use_own_safe_path true]} {
    vcom -93 -quiet $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_safe_path_msim.vhd
}
vcom -93 -quiet $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16.vhd
