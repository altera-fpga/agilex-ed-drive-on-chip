# This is the Run ModelSim file list for 'busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz'

if {![info exist use_own_safe_path] || ![string equal -nocase $use_own_safe_path true]} {
    vcom -93 -quiet $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_safe_path_msim.vhd
}
vcom -93 -quiet $base_dir/DF_fixp16_alu_av/busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz.vhd
