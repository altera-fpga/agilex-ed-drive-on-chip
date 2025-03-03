# This is the Run ModelSim file list for 'DF_fixp16_alu_av_FOC'

if {![info exist use_own_safe_path] || ![string equal -nocase $use_own_safe_path true]} {
    vcom -93 -quiet $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_safe_path_msim.vhd
}
vcom -93 -quiet $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC.vhd
source $base_dir/DF_fixp16_alu_av/busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz.dspb.do
source $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_fb_latches.dspb.do
source $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs.dspb.do
source $base_dir/DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16.dspb.do
