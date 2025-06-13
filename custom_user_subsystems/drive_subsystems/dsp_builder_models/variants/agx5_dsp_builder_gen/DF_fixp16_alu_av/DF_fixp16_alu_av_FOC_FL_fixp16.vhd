-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Altera(R) FPGAs Version 25.1 (Release Build #6a12354d2f)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2025 Altera Corporation.  All rights reserved.
-- Your use of Altera Corporation's  design tools,  logic functions and other
-- software and  tools, and  its AMPP partner logic functions, and any output
-- files any  of the  foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or  information  are expressly
-- subject to the terms and  conditions  of the  Altera FPGA Software License
-- Agreement, Altera MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that  your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Altera
-- and  sold by Altera  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from DF_fixp16_alu_av_FOC_FL_fixp16
-- VHDL created on Fri Jun  6 03:50:15 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;

library tennm;
use tennm.tennm_components.tennm_mac;
use tennm.tennm_components.tennm_fp_mac;
use tennm.tennm_components.tennm_dsp_prime;

USE work.DF_fixp16_alu_av_FOC_safe_path.all;
entity DF_fixp16_alu_av_FOC_FL_fixp16 is
    port (
        in_1_dv_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_2_dc_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_3_valid_in_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_4_axis_in_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_5_Iu_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_6_Iw_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_7_Torque_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_8_IntegralQ_in_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_9_IntegralD_in_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_10_phi_el_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_11_Kp_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_12_Ki_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_13_I_Sat_Limit_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_14_Max_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        out_1_qv_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_qc_tpl : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_valid_out_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_4_axis_out_tpl : out std_logic_vector(7 downto 0);  -- ufix8
        out_5_Valpha_tpl : out std_logic_vector(31 downto 0);  -- sfix32_en10
        out_6_Vbeta_tpl : out std_logic_vector(31 downto 0);  -- sfix32_en10
        out_7_IntegralD_out_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_8_IntegralQ_out_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_9_Iq_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_10_Id_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_11_uvw_0_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_11_uvw_1_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_11_uvw_2_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_12_ready_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end DF_fixp16_alu_av_FOC_FL_fixp16;

architecture normal of DF_fixp16_alu_av_FOC_FL_fixp16 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal Const1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub1_a : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub1_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub1_o : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Convert1_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Convert4_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_a : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_o : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_a : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_o : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_a : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_o : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_a : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_o : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_a : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_o : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_a : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_o : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_a : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_o : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_a : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_o : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_a : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_o : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_a : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_o : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_a : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_b : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_o : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_a : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_b : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_o : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_q : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_a : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_b : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_o : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_q : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_a : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_b : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_o : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_a : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_b : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_o : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal Sub2_0_x_a : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub2_0_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub2_0_x_o : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub2_0_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub2_1_x_a : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub2_1_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub2_1_x_o : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub2_1_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Convert2_0_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal Convert2_1_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Convert_sel_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_in : STD_LOGIC_VECTOR (47 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_in : STD_LOGIC_VECTOR (47 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_qint : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_qint : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_qint : STD_LOGIC_VECTOR (32 downto 0);
    signal h_uid279_Trig_in : STD_LOGIC_VECTOR (10 downto 0);
    signal h_uid279_Trig_b : STD_LOGIC_VECTOR (0 downto 0);
    signal q_uid280_Trig_in : STD_LOGIC_VECTOR (9 downto 0);
    signal q_uid280_Trig_b : STD_LOGIC_VECTOR (0 downto 0);
    signal o_uid281_Trig_in : STD_LOGIC_VECTOR (8 downto 0);
    signal o_uid281_Trig_b : STD_LOGIC_VECTOR (0 downto 0);
    signal y0_uid282_Trig_in : STD_LOGIC_VECTOR (7 downto 0);
    signal y0_uid282_Trig_b : STD_LOGIC_VECTOR (7 downto 0);
    signal y1Full_uid286_Trig_a : STD_LOGIC_VECTOR (9 downto 0);
    signal y1Full_uid286_Trig_b : STD_LOGIC_VECTOR (9 downto 0);
    signal y1Full_uid286_Trig_o : STD_LOGIC_VECTOR (9 downto 0);
    signal y1Full_uid286_Trig_q : STD_LOGIC_VECTOR (9 downto 0);
    signal oneOverFourPosition_uid287_Trig_in : STD_LOGIC_VECTOR (8 downto 0);
    signal oneOverFourPosition_uid287_Trig_b : STD_LOGIC_VECTOR (0 downto 0);
    signal oneOverFourWhenOct_uid288_Trig_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oneOverFourWhenOct_uid288_Trig_q : STD_LOGIC_VECTOR (0 downto 0);
    signal y1_uid289_Trig_in : STD_LOGIC_VECTOR (7 downto 0);
    signal y1_uid289_Trig_b : STD_LOGIC_VECTOR (7 downto 0);
    signal y_uid290_Trig_s : STD_LOGIC_VECTOR (0 downto 0);
    signal y_uid290_Trig_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstPiO4Sin_uid298_Trig_q : STD_LOGIC_VECTOR (12 downto 0);
    signal sinPiA_uid301_Trig_s : STD_LOGIC_VECTOR (0 downto 0);
    signal sinPiA_uid301_Trig_q : STD_LOGIC_VECTOR (12 downto 0);
    signal cosPiA_uid302_Trig_s : STD_LOGIC_VECTOR (0 downto 0);
    signal cosPiA_uid302_Trig_q : STD_LOGIC_VECTOR (13 downto 0);
    signal mSinPiXR_uid305_Trig_a : STD_LOGIC_VECTOR (14 downto 0);
    signal mSinPiXR_uid305_Trig_b : STD_LOGIC_VECTOR (14 downto 0);
    signal mSinPiXR_uid305_Trig_o : STD_LOGIC_VECTOR (14 downto 0);
    signal mSinPiXR_uid305_Trig_q : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid308_Trig_a : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid308_Trig_b : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid308_Trig_o : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid308_Trig_q : STD_LOGIC_VECTOR (14 downto 0);
    signal sinPiXRF_topExtension_uid309_Trig_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sinPiXRF_topRange_uid310_Trig_b : STD_LOGIC_VECTOR (9 downto 0);
    signal sinPiXRF_mergedSignalTM_uid311_Trig_q : STD_LOGIC_VECTOR (11 downto 0);
    signal mSinPiXRF_uid313_Trig_b : STD_LOGIC_VECTOR (11 downto 0);
    signal cosPiXRF_topRange_uid315_Trig_b : STD_LOGIC_VECTOR (10 downto 0);
    signal cosPiXRF_mergedSignalTM_uid316_Trig_q : STD_LOGIC_VECTOR (11 downto 0);
    signal mCosPiXRF_uid318_Trig_b : STD_LOGIC_VECTOR (11 downto 0);
    signal allBitsSelRR_uid319_Trig_q : STD_LOGIC_VECTOR (2 downto 0);
    signal muxSelSin_uid320_Trig_q : STD_LOGIC_VECTOR (1 downto 0);
    signal outSin_uid322_Trig_s : STD_LOGIC_VECTOR (1 downto 0);
    signal outSin_uid322_Trig_q : STD_LOGIC_VECTOR (11 downto 0);
    signal h_uid326_Trig2_in : STD_LOGIC_VECTOR (10 downto 0);
    signal h_uid326_Trig2_b : STD_LOGIC_VECTOR (0 downto 0);
    signal q_uid327_Trig2_in : STD_LOGIC_VECTOR (9 downto 0);
    signal q_uid327_Trig2_b : STD_LOGIC_VECTOR (0 downto 0);
    signal o_uid328_Trig2_in : STD_LOGIC_VECTOR (8 downto 0);
    signal o_uid328_Trig2_b : STD_LOGIC_VECTOR (0 downto 0);
    signal y0_uid329_Trig2_in : STD_LOGIC_VECTOR (7 downto 0);
    signal y0_uid329_Trig2_b : STD_LOGIC_VECTOR (7 downto 0);
    signal y1Full_uid333_Trig2_a : STD_LOGIC_VECTOR (9 downto 0);
    signal y1Full_uid333_Trig2_b : STD_LOGIC_VECTOR (9 downto 0);
    signal y1Full_uid333_Trig2_o : STD_LOGIC_VECTOR (9 downto 0);
    signal y1Full_uid333_Trig2_q : STD_LOGIC_VECTOR (9 downto 0);
    signal oneOverFourPosition_uid334_Trig2_in : STD_LOGIC_VECTOR (8 downto 0);
    signal oneOverFourPosition_uid334_Trig2_b : STD_LOGIC_VECTOR (0 downto 0);
    signal oneOverFourWhenOct_uid335_Trig2_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oneOverFourWhenOct_uid335_Trig2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal y1_uid336_Trig2_in : STD_LOGIC_VECTOR (7 downto 0);
    signal y1_uid336_Trig2_b : STD_LOGIC_VECTOR (7 downto 0);
    signal y_uid337_Trig2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal y_uid337_Trig2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal sinPiA_uid348_Trig2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal sinPiA_uid348_Trig2_q : STD_LOGIC_VECTOR (12 downto 0);
    signal cosPiA_uid349_Trig2_s : STD_LOGIC_VECTOR (0 downto 0);
    signal cosPiA_uid349_Trig2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal mSinPiXR_uid352_Trig2_a : STD_LOGIC_VECTOR (14 downto 0);
    signal mSinPiXR_uid352_Trig2_b : STD_LOGIC_VECTOR (14 downto 0);
    signal mSinPiXR_uid352_Trig2_o : STD_LOGIC_VECTOR (14 downto 0);
    signal mSinPiXR_uid352_Trig2_q : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid355_Trig2_a : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid355_Trig2_b : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid355_Trig2_o : STD_LOGIC_VECTOR (14 downto 0);
    signal mCosPiXR_uid355_Trig2_q : STD_LOGIC_VECTOR (14 downto 0);
    signal sinPiXRF_topRange_uid357_Trig2_b : STD_LOGIC_VECTOR (9 downto 0);
    signal sinPiXRF_mergedSignalTM_uid358_Trig2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal mSinPiXRF_uid360_Trig2_b : STD_LOGIC_VECTOR (11 downto 0);
    signal cosPiXRF_topRange_uid362_Trig2_b : STD_LOGIC_VECTOR (10 downto 0);
    signal cosPiXRF_mergedSignalTM_uid363_Trig2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal mCosPiXRF_uid365_Trig2_b : STD_LOGIC_VECTOR (11 downto 0);
    signal allBitsSelRR_uid366_Trig2_q : STD_LOGIC_VECTOR (2 downto 0);
    signal muxSelSin_uid367_Trig2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal outSin_uid369_Trig2_s : STD_LOGIC_VECTOR (1 downto 0);
    signal outSin_uid369_Trig2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b : STD_LOGIC_VECTOR (30 downto 0);
    signal addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_rnd_x_sel_b : STD_LOGIC_VECTOR (21 downto 0);
    signal Mult_PostCast_primWireOut_rnd_sel_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q : STD_LOGIC_VECTOR (15 downto 0);
    signal aPostPad_uid285_Trig_q_const_q : STD_LOGIC_VECTOR (8 downto 0);
    signal cstPiO4Cosr_uid300_Trig_b_const_q : STD_LOGIC_VECTOR (13 downto 0);
    signal aPostPad_uid304_Trig_q_const_q : STD_LOGIC_VECTOR (13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_500_b : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_501_b : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_502_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_503_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_504_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sR_bottomExtension_uid514_Mult_q : STD_LOGIC_VECTOR (10 downto 0);
    signal sR_topExtension_uid515_Mult_q : STD_LOGIC_VECTOR (4 downto 0);
    signal sR_mergedSignalTMB_uid516_Mult_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sR_topExtension_uid557_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal sR_mergedSignalTMB_uid558_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal padBCst_uid593_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal bPostPad_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (19 downto 0);
    signal sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a : STD_LOGIC_VECTOR (20 downto 0);
    signal sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o : STD_LOGIC_VECTOR (20 downto 0);
    signal sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (20 downto 0);
    signal lowRangeA_uid598_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_in : STD_LOGIC_VECTOR (2 downto 0);
    signal lowRangeA_uid598_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal highABits_uid599_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (12 downto 0);
    signal addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a : STD_LOGIC_VECTOR (16 downto 0);
    signal addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (16 downto 0);
    signal addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o : STD_LOGIC_VECTOR (16 downto 0);
    signal addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (16 downto 0);
    signal add_uid601_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (19 downto 0);
    signal padBCst_uid603_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal bPostPad_uid604_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (25 downto 0);
    signal a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a : STD_LOGIC_VECTOR (26 downto 0);
    signal a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (26 downto 0);
    signal a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o : STD_LOGIC_VECTOR (26 downto 0);
    signal a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sR_topExtension_uid610_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal sR_mergedSignalTM_uid612_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_i : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a1 : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b1 : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_o : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_i : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a1 : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b1 : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_o : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_a : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_b : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_i : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_a1 : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_b1 : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_o : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bPostPad_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (34 downto 0);
    signal sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (34 downto 0);
    signal sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (34 downto 0);
    signal sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lowRangeB_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid720_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (29 downto 0);
    signal addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal add_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lowRangeB_uid725_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (2 downto 0);
    signal lowRangeB_uid725_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal highBBits_uid726_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (28 downto 0);
    signal addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal add_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (35 downto 0);
    signal aPostPad_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (35 downto 0);
    signal sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (36 downto 0);
    signal sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (36 downto 0);
    signal sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (36 downto 0);
    signal sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (36 downto 0);
    signal bPostPad_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (38 downto 0);
    signal a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (39 downto 0);
    signal a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (39 downto 0);
    signal a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (39 downto 0);
    signal a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (39 downto 0);
    signal lowRangeB_uid739_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (4 downto 0);
    signal lowRangeB_uid739_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (4 downto 0);
    signal highBBits_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (29 downto 0);
    signal a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (40 downto 0);
    signal aPostPad_uid745_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (40 downto 0);
    signal a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (41 downto 0);
    signal lowRangeB_uid748_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (8 downto 0);
    signal lowRangeB_uid748_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (8 downto 0);
    signal highBBits_uid749_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (30 downto 0);
    signal a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_uid751_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (50 downto 0);
    signal lowRangeB_uid753_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (9 downto 0);
    signal lowRangeB_uid753_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal highBBits_uid754_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_uid756_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (46 downto 0);
    signal lowRangeB_uid758_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (17 downto 0);
    signal lowRangeB_uid758_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal highBBits_uid759_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_uid761_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (65 downto 0);
    signal sR_uid764_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (63 downto 0);
    signal sR_uid764_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q : STD_LOGIC_VECTOR (14 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_806_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_a : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_b : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_o : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_809_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_a : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_b : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_o : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_812_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_a : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_b : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_o : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_815_b : STD_LOGIC_VECTOR (20 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_a : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_b : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_o : STD_LOGIC_VECTOR (22 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_qint : STD_LOGIC_VECTOR (48 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_qint : STD_LOGIC_VECTOR (48 downto 0);
    signal sinPiAT_uid292_Trig_lutmem_reset0 : std_logic;
    signal sinPiAT_uid292_Trig_lutmem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal sinPiAT_uid292_Trig_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal sinPiAT_uid292_Trig_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal sinPiAT_uid292_Trig_lutmem_ir : STD_LOGIC_VECTOR (12 downto 0);
    signal sinPiAT_uid292_Trig_lutmem_r : STD_LOGIC_VECTOR (12 downto 0);
    signal cosPiAT_uid295_Trig_lutmem_reset0 : std_logic;
    signal cosPiAT_uid295_Trig_lutmem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal cosPiAT_uid295_Trig_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal cosPiAT_uid295_Trig_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal cosPiAT_uid295_Trig_lutmem_ir : STD_LOGIC_VECTOR (13 downto 0);
    signal cosPiAT_uid295_Trig_lutmem_r : STD_LOGIC_VECTOR (13 downto 0);
    signal sinPiAT_uid339_Trig2_lutmem_reset0 : std_logic;
    signal sinPiAT_uid339_Trig2_lutmem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal sinPiAT_uid339_Trig2_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal sinPiAT_uid339_Trig2_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal sinPiAT_uid339_Trig2_lutmem_ir : STD_LOGIC_VECTOR (12 downto 0);
    signal sinPiAT_uid339_Trig2_lutmem_r : STD_LOGIC_VECTOR (12 downto 0);
    signal cosPiAT_uid342_Trig2_lutmem_reset0 : std_logic;
    signal cosPiAT_uid342_Trig2_lutmem_ia : STD_LOGIC_VECTOR (13 downto 0);
    signal cosPiAT_uid342_Trig2_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal cosPiAT_uid342_Trig2_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal cosPiAT_uid342_Trig2_lutmem_ir : STD_LOGIC_VECTOR (13 downto 0);
    signal cosPiAT_uid342_Trig2_lutmem_r : STD_LOGIC_VECTOR (13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_not_msb_X_859_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op2_861_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_not_msb_X_866_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op2_868_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_not_msb_X_873_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op_top_X_874_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op2_875_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_msb_X_878_in : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_msb_X_878_b : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_top_X_879_in : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_top_X_879_b : STD_LOGIC_VECTOR (2 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_not_msb_X_880_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op_top_X_881_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op2_882_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_lhsMSBs_select_b : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_a : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_b : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_o : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_split_join_q : STD_LOGIC_VECTOR (49 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_lhsMSBs_select_b : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_a : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_b : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_o : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_split_join_q : STD_LOGIC_VECTOR (49 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_a0 : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_c0 : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_a0 : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_c0 : STD_LOGIC_VECTOR (13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_s0 : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_qq0 : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_q : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_a0 : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_c0 : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_a0 : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_c0 : STD_LOGIC_VECTOR (13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_s0 : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_qq0 : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_q : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_qint : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_a : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_b : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_o : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_q : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_qint : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_a : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_b : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_o : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_q : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_a : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_b : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_o : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_q : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_qint : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_a : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_b : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_o : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_q : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_a : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_b : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_o : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_q : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_qint : STD_LOGIC_VECTOR (63 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_a : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_b : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_o : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_q : STD_LOGIC_VECTOR (32 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_qint : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_c : STD_LOGIC_VECTOR (13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_c : STD_LOGIC_VECTOR (13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_in : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_in : STD_LOGIC_VECTOR (34 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_d : STD_LOGIC_VECTOR (17 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_in : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_d : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_in : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_d : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_xinvSel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mergedMUXes0_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_xinvSel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mergedMUXes1_opt_lev0_id0_q : STD_LOGIC_VECTOR (1 downto 0);
    signal mergedMUXes1_opt_lev0_id0_v : STD_LOGIC_VECTOR (0 downto 0);
    signal mergedMUXes1_opt_lev0_id1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal mergedMUXes1_opt_lev0_id1_v : STD_LOGIC_VECTOR (0 downto 0);
    signal mergedMUXes1_opt_lev1_id0_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist3_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist5_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q_1_q : STD_LOGIC_VECTOR (18 downto 0);
    signal redist6_muxSelSin_uid367_Trig2_q_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist7_oneOverFourWhenOct_uid335_Trig2_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_muxSelSin_uid320_Trig_q_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist9_oneOverFourWhenOct_uid288_Trig_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist20_ChannelIn2_in_1_dv_tpl_22_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_ChannelIn2_in_3_valid_in_tpl_22_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_ChannelIn2_in_5_Iu_tpl_2_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist24_ChannelIn2_in_5_Iu_tpl_2_delay_0 : STD_LOGIC_VECTOR (15 downto 0);
    signal redist25_ChannelIn2_in_6_Iw_tpl_2_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist25_ChannelIn2_in_6_Iw_tpl_2_delay_0 : STD_LOGIC_VECTOR (15 downto 0);
    signal redist34_ChannelIn2_in_14_Max_tpl_21_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_reset0 : std_logic;
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i : signal is true;
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_offset_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_reset0 : std_logic;
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i : signal is true;
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_mem_reset0 : std_logic;
    signal redist14_Convert2_1_sel_x_b_7_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist14_Convert2_1_sel_x_b_7_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist14_Convert2_1_sel_x_b_7_wraddr_i : signal is true;
    signal redist14_Convert2_1_sel_x_b_7_offset_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist14_Convert2_1_sel_x_b_7_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_mem_reset0 : std_logic;
    signal redist15_Convert2_0_sel_x_b_7_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist15_Convert2_0_sel_x_b_7_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist15_Convert2_0_sel_x_b_7_wraddr_i : signal is true;
    signal redist15_Convert2_0_sel_x_b_7_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_Convert2_0_sel_x_b_7_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_reset0 : std_logic;
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_i : signal is true;
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_offset_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_reset0 : std_logic;
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_i : signal is true;
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist18_Convert4_sel_x_b_9_mem_reset0 : std_logic;
    signal redist18_Convert4_sel_x_b_9_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist18_Convert4_sel_x_b_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist18_Convert4_sel_x_b_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist18_Convert4_sel_x_b_9_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist18_Convert4_sel_x_b_9_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist18_Convert4_sel_x_b_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist18_Convert4_sel_x_b_9_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist18_Convert4_sel_x_b_9_wraddr_i : signal is true;
    signal redist18_Convert4_sel_x_b_9_offset_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist18_Convert4_sel_x_b_9_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_Convert4_sel_x_b_9_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_Convert4_sel_x_b_9_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist18_Convert4_sel_x_b_9_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist19_Convert1_sel_x_b_9_mem_reset0 : std_logic;
    signal redist19_Convert1_sel_x_b_9_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist19_Convert1_sel_x_b_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist19_Convert1_sel_x_b_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist19_Convert1_sel_x_b_9_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist19_Convert1_sel_x_b_9_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist19_Convert1_sel_x_b_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist19_Convert1_sel_x_b_9_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist19_Convert1_sel_x_b_9_wraddr_i : signal is true;
    signal redist19_Convert1_sel_x_b_9_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist19_Convert1_sel_x_b_9_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist19_Convert1_sel_x_b_9_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist19_Convert1_sel_x_b_9_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_mem_reset0 : std_logic;
    signal redist21_ChannelIn2_in_2_dc_tpl_22_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_i : UNSIGNED (4 downto 0) := "11111";
    attribute preserve_syn_only of redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_i : signal is true;
    signal redist21_ChannelIn2_in_2_dc_tpl_22_offset_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_a : STD_LOGIC_VECTOR (5 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_o : STD_LOGIC_VECTOR (5 downto 0);
    signal redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_reset0 : std_logic;
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_i : UNSIGNED (4 downto 0) := "11111";
    attribute preserve_syn_only of redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_i : signal is true;
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_a : STD_LOGIC_VECTOR (5 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_o : STD_LOGIC_VECTOR (5 downto 0);
    signal redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_mem_reset0 : std_logic;
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_i : signal is true;
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_offset_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_reset0 : std_logic;
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_i : signal is true;
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_offset_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_reset0 : std_logic;
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_i : signal is true;
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_mem_reset0 : std_logic;
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_i : signal is true;
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_mem_reset0 : std_logic;
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_i : signal is true;
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_reset0 : std_logic;
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_i : signal is true;
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_mem_reset0 : std_logic;
    signal redist32_ChannelIn2_in_14_Max_tpl_15_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_i : signal is true;
    signal redist32_ChannelIn2_in_14_Max_tpl_15_offset_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_mem_reset0 : std_logic;
    signal redist33_ChannelIn2_in_14_Max_tpl_20_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_i : UNSIGNED (1 downto 0) := "11";
    attribute preserve_syn_only of redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_i : signal is true;
    signal redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_a : STD_LOGIC_VECTOR (2 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_o : STD_LOGIC_VECTOR (2 downto 0);
    signal redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x(CONSTANT,153)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q <= "10";

    -- redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt(ADD,1067)
    redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_q);
    redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_b <= STD_LOGIC_VECTOR("0" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q);
    redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_a) + UNSIGNED(redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_q <= redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_o(2 downto 0);

    -- redist32_ChannelIn2_in_14_Max_tpl_15_offset(CONSTANT,1062)
    redist32_ChannelIn2_in_14_Max_tpl_15_offset_q <= "0100";

    -- redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt(ADD,1063)
    redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_q);
    redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist32_ChannelIn2_in_14_Max_tpl_15_offset_q);
    redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_a) + UNSIGNED(redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_q <= redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_o(4 downto 0);

    -- redist32_ChannelIn2_in_14_Max_tpl_15_wraddr(COUNTER,1061)
    -- low=0, high=15, step=1, init=0
    redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_i <= redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_i, 4));

    -- redist32_ChannelIn2_in_14_Max_tpl_15_mem(DUALMEM,1060)
    redist32_ChannelIn2_in_14_Max_tpl_15_mem_ia <= STD_LOGIC_VECTOR(in_14_Max_tpl);
    redist32_ChannelIn2_in_14_Max_tpl_15_mem_aa <= redist32_ChannelIn2_in_14_Max_tpl_15_wraddr_q;
    redist32_ChannelIn2_in_14_Max_tpl_15_mem_ab <= redist32_ChannelIn2_in_14_Max_tpl_15_rdcnt_q(3 downto 0);
    redist32_ChannelIn2_in_14_Max_tpl_15_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 16,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist32_ChannelIn2_in_14_Max_tpl_15_mem_aa,
        data_a => redist32_ChannelIn2_in_14_Max_tpl_15_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist32_ChannelIn2_in_14_Max_tpl_15_mem_ab,
        q_b => redist32_ChannelIn2_in_14_Max_tpl_15_mem_iq
    );
    redist32_ChannelIn2_in_14_Max_tpl_15_mem_q <= STD_LOGIC_VECTOR(redist32_ChannelIn2_in_14_Max_tpl_15_mem_iq(15 downto 0));

    -- redist33_ChannelIn2_in_14_Max_tpl_20_wraddr(COUNTER,1065)
    -- low=0, high=3, step=1, init=0
    redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_i <= redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_i, 2));

    -- redist33_ChannelIn2_in_14_Max_tpl_20_mem(DUALMEM,1064)
    redist33_ChannelIn2_in_14_Max_tpl_20_mem_ia <= STD_LOGIC_VECTOR(redist32_ChannelIn2_in_14_Max_tpl_15_mem_q);
    redist33_ChannelIn2_in_14_Max_tpl_20_mem_aa <= redist33_ChannelIn2_in_14_Max_tpl_20_wraddr_q;
    redist33_ChannelIn2_in_14_Max_tpl_20_mem_ab <= redist33_ChannelIn2_in_14_Max_tpl_20_rdcnt_q(1 downto 0);
    redist33_ChannelIn2_in_14_Max_tpl_20_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 16,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist33_ChannelIn2_in_14_Max_tpl_20_mem_aa,
        data_a => redist33_ChannelIn2_in_14_Max_tpl_20_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist33_ChannelIn2_in_14_Max_tpl_20_mem_ab,
        q_b => redist33_ChannelIn2_in_14_Max_tpl_20_mem_iq
    );
    redist33_ChannelIn2_in_14_Max_tpl_20_mem_q <= STD_LOGIC_VECTOR(redist33_ChannelIn2_in_14_Max_tpl_20_mem_iq(15 downto 0));

    -- redist34_ChannelIn2_in_14_Max_tpl_21(DELAY,995)
    redist34_ChannelIn2_in_14_Max_tpl_21_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist34_ChannelIn2_in_14_Max_tpl_21_q <= redist33_ChannelIn2_in_14_Max_tpl_20_mem_q;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias(CONSTANT,918)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q <= "01";

    -- padBCst_uid593_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(CONSTANT,592)
    padBCst_uid593_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= "0000";

    -- bPostPad_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,735)@19
    bPostPad_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & padBCst_uid593_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- sinPiXRF_topExtension_uid309_Trig(CONSTANT,308)
    sinPiXRF_topExtension_uid309_Trig_q <= "00";

    -- bPostPad_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,709)@19
    bPostPad_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b & sinPiXRF_topExtension_uid309_Trig_q;

    -- redist18_Convert4_sel_x_b_9_offset(CONSTANT,1022)
    redist18_Convert4_sel_x_b_9_offset_q <= "010";

    -- redist18_Convert4_sel_x_b_9_rdcnt(ADD,1023)
    redist18_Convert4_sel_x_b_9_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist18_Convert4_sel_x_b_9_wraddr_q);
    redist18_Convert4_sel_x_b_9_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist18_Convert4_sel_x_b_9_offset_q);
    redist18_Convert4_sel_x_b_9_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist18_Convert4_sel_x_b_9_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist18_Convert4_sel_x_b_9_rdcnt_a) + UNSIGNED(redist18_Convert4_sel_x_b_9_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist18_Convert4_sel_x_b_9_rdcnt_q <= redist18_Convert4_sel_x_b_9_rdcnt_o(3 downto 0);

    -- cstPiO4Cosr_uid300_Trig_b_const(CONSTANT,473)
    cstPiO4Cosr_uid300_Trig_b_const_q <= "01011010100001";

    -- aPostPad_uid285_Trig_q_const(CONSTANT,471)
    aPostPad_uid285_Trig_q_const_q <= "100000000";

    -- y1Full_uid333_Trig2(SUB,332)@0
    y1Full_uid333_Trig2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid285_Trig_q_const_q));
    y1Full_uid333_Trig2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00" & y0_uid329_Trig2_b));
    y1Full_uid333_Trig2_o <= STD_LOGIC_VECTOR(SIGNED(y1Full_uid333_Trig2_a) - SIGNED(y1Full_uid333_Trig2_b));
    y1Full_uid333_Trig2_q <= STD_LOGIC_VECTOR(y1Full_uid333_Trig2_o(9 downto 0));

    -- y1_uid336_Trig2(BITSELECT,335)@0
    y1_uid336_Trig2_in <= y1Full_uid333_Trig2_q(7 downto 0);
    y1_uid336_Trig2_b <= STD_LOGIC_VECTOR(y1_uid336_Trig2_in(7 downto 0));

    -- sR_topExtension_uid515_Mult(CONSTANT,514)
    sR_topExtension_uid515_Mult_q <= "00000";

    -- sR_bottomExtension_uid514_Mult(CONSTANT,513)
    sR_bottomExtension_uid514_Mult_q <= "00000000000";

    -- sR_mergedSignalTMB_uid516_Mult(BITJOIN,515)@0
    sR_mergedSignalTMB_uid516_Mult_q <= sR_topExtension_uid515_Mult_q & in_10_phi_el_tpl & sR_bottomExtension_uid514_Mult_q;

    -- Mult_PostCast_primWireOut_rnd_sel(BITSELECT,464)@0
    Mult_PostCast_primWireOut_rnd_sel_b <= sR_mergedSignalTMB_uid516_Mult_q(31 downto 16);

    -- Const1(CONSTANT,65)
    Const1_q <= "0000001000000000";

    -- Sub1(SUB,74)@0
    Sub1_a <= STD_LOGIC_VECTOR(Const1_q);
    Sub1_b <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b);
    Sub1_o <= STD_LOGIC_VECTOR(SIGNED(Sub1_a) - SIGNED(Sub1_b));
    Sub1_q <= STD_LOGIC_VECTOR(Sub1_o(15 downto 0));

    -- y0_uid329_Trig2(BITSELECT,328)@0
    y0_uid329_Trig2_in <= Sub1_q(7 downto 0);
    y0_uid329_Trig2_b <= STD_LOGIC_VECTOR(y0_uid329_Trig2_in(7 downto 0));

    -- o_uid328_Trig2(BITSELECT,327)@0
    o_uid328_Trig2_in <= STD_LOGIC_VECTOR(Sub1_q(8 downto 0));
    o_uid328_Trig2_b <= o_uid328_Trig2_in(8 downto 8);

    -- y_uid337_Trig2(MUX,336)@0
    y_uid337_Trig2_s <= o_uid328_Trig2_b;
    y_uid337_Trig2_combproc: PROCESS (y_uid337_Trig2_s, y0_uid329_Trig2_b, y1_uid336_Trig2_b)
    BEGIN
        CASE (y_uid337_Trig2_s) IS
            WHEN "0" => y_uid337_Trig2_q <= y0_uid329_Trig2_b;
            WHEN "1" => y_uid337_Trig2_q <= y1_uid336_Trig2_b;
            WHEN OTHERS => y_uid337_Trig2_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- cosPiAT_uid342_Trig2_lutmem(DUALMEM,845)@0 + 2
    cosPiAT_uid342_Trig2_lutmem_aa <= y_uid337_Trig2_q;
    cosPiAT_uid342_Trig2_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 14,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "NONE",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_cosPiAT_uid342_Trig2_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => cosPiAT_uid342_Trig2_lutmem_aa,
        q_a => cosPiAT_uid342_Trig2_lutmem_ir
    );
    cosPiAT_uid342_Trig2_lutmem_r <= STD_LOGIC_VECTOR(cosPiAT_uid342_Trig2_lutmem_ir(13 downto 0));

    -- oneOverFourPosition_uid334_Trig2(BITSELECT,333)@0
    oneOverFourPosition_uid334_Trig2_in <= STD_LOGIC_VECTOR(y1Full_uid333_Trig2_q(8 downto 0));
    oneOverFourPosition_uid334_Trig2_b <= oneOverFourPosition_uid334_Trig2_in(8 downto 8);

    -- oneOverFourWhenOct_uid335_Trig2(LOGICAL,334)@0 + 1
    oneOverFourWhenOct_uid335_Trig2_qi <= o_uid328_Trig2_b and oneOverFourPosition_uid334_Trig2_b;
    oneOverFourWhenOct_uid335_Trig2_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneOverFourWhenOct_uid335_Trig2_qi, xout => oneOverFourWhenOct_uid335_Trig2_q, clk => clk, aclr => areset, ena => '1' );

    -- redist7_oneOverFourWhenOct_uid335_Trig2_q_2(DELAY,968)
    redist7_oneOverFourWhenOct_uid335_Trig2_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist7_oneOverFourWhenOct_uid335_Trig2_q_2_q <= oneOverFourWhenOct_uid335_Trig2_q;
            END IF;
        END IF;
    END PROCESS;

    -- cosPiA_uid349_Trig2(MUX,348)@2
    cosPiA_uid349_Trig2_s <= redist7_oneOverFourWhenOct_uid335_Trig2_q_2_q;
    cosPiA_uid349_Trig2_combproc: PROCESS (cosPiA_uid349_Trig2_s, cosPiAT_uid342_Trig2_lutmem_r, cstPiO4Cosr_uid300_Trig_b_const_q)
    BEGIN
        CASE (cosPiA_uid349_Trig2_s) IS
            WHEN "0" => cosPiA_uid349_Trig2_q <= cosPiAT_uid342_Trig2_lutmem_r;
            WHEN "1" => cosPiA_uid349_Trig2_q <= cstPiO4Cosr_uid300_Trig_b_const_q;
            WHEN OTHERS => cosPiA_uid349_Trig2_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- aPostPad_uid304_Trig_q_const(CONSTANT,474)
    aPostPad_uid304_Trig_q_const_q <= "00000000000000";

    -- mCosPiXR_uid355_Trig2(SUB,354)@2
    mCosPiXR_uid355_Trig2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid304_Trig_q_const_q));
    mCosPiXR_uid355_Trig2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & cosPiA_uid349_Trig2_q));
    mCosPiXR_uid355_Trig2_o <= STD_LOGIC_VECTOR(SIGNED(mCosPiXR_uid355_Trig2_a) - SIGNED(mCosPiXR_uid355_Trig2_b));
    mCosPiXR_uid355_Trig2_q <= STD_LOGIC_VECTOR(mCosPiXR_uid355_Trig2_o(14 downto 0));

    -- mCosPiXRF_uid365_Trig2(BITSELECT,364)@2
    mCosPiXRF_uid365_Trig2_b <= mCosPiXR_uid355_Trig2_q(14 downto 3);

    -- cosPiXRF_topRange_uid362_Trig2(BITSELECT,361)@2
    cosPiXRF_topRange_uid362_Trig2_b <= STD_LOGIC_VECTOR(cosPiA_uid349_Trig2_q(13 downto 3));

    -- cosPiXRF_mergedSignalTM_uid363_Trig2(BITJOIN,362)@2
    cosPiXRF_mergedSignalTM_uid363_Trig2_q <= GND_q & cosPiXRF_topRange_uid362_Trig2_b;

    -- cstPiO4Sin_uid298_Trig(CONSTANT,297)
    cstPiO4Sin_uid298_Trig_q <= "1011010100001";

    -- sinPiAT_uid339_Trig2_lutmem(DUALMEM,844)@0 + 2
    sinPiAT_uid339_Trig2_lutmem_aa <= y_uid337_Trig2_q;
    sinPiAT_uid339_Trig2_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 13,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "NONE",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_sinPiAT_uid339_Trig2_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => sinPiAT_uid339_Trig2_lutmem_aa,
        q_a => sinPiAT_uid339_Trig2_lutmem_ir
    );
    sinPiAT_uid339_Trig2_lutmem_r <= STD_LOGIC_VECTOR(sinPiAT_uid339_Trig2_lutmem_ir(12 downto 0));

    -- sinPiA_uid348_Trig2(MUX,347)@2
    sinPiA_uid348_Trig2_s <= redist7_oneOverFourWhenOct_uid335_Trig2_q_2_q;
    sinPiA_uid348_Trig2_combproc: PROCESS (sinPiA_uid348_Trig2_s, sinPiAT_uid339_Trig2_lutmem_r, cstPiO4Sin_uid298_Trig_q)
    BEGIN
        CASE (sinPiA_uid348_Trig2_s) IS
            WHEN "0" => sinPiA_uid348_Trig2_q <= sinPiAT_uid339_Trig2_lutmem_r;
            WHEN "1" => sinPiA_uid348_Trig2_q <= cstPiO4Sin_uid298_Trig_q;
            WHEN OTHERS => sinPiA_uid348_Trig2_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- mSinPiXR_uid352_Trig2(SUB,351)@2
    mSinPiXR_uid352_Trig2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid304_Trig_q_const_q));
    mSinPiXR_uid352_Trig2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00" & sinPiA_uid348_Trig2_q));
    mSinPiXR_uid352_Trig2_o <= STD_LOGIC_VECTOR(SIGNED(mSinPiXR_uid352_Trig2_a) - SIGNED(mSinPiXR_uid352_Trig2_b));
    mSinPiXR_uid352_Trig2_q <= STD_LOGIC_VECTOR(mSinPiXR_uid352_Trig2_o(14 downto 0));

    -- mSinPiXRF_uid360_Trig2(BITSELECT,359)@2
    mSinPiXRF_uid360_Trig2_b <= mSinPiXR_uid352_Trig2_q(14 downto 3);

    -- sinPiXRF_topRange_uid357_Trig2(BITSELECT,356)@2
    sinPiXRF_topRange_uid357_Trig2_b <= STD_LOGIC_VECTOR(sinPiA_uid348_Trig2_q(12 downto 3));

    -- sinPiXRF_mergedSignalTM_uid358_Trig2(BITJOIN,357)@2
    sinPiXRF_mergedSignalTM_uid358_Trig2_q <= sinPiXRF_topExtension_uid309_Trig_q & sinPiXRF_topRange_uid357_Trig2_b;

    -- h_uid326_Trig2(BITSELECT,325)@0
    h_uid326_Trig2_in <= STD_LOGIC_VECTOR(Sub1_q(10 downto 0));
    h_uid326_Trig2_b <= h_uid326_Trig2_in(10 downto 10);

    -- q_uid327_Trig2(BITSELECT,326)@0
    q_uid327_Trig2_in <= STD_LOGIC_VECTOR(Sub1_q(9 downto 0));
    q_uid327_Trig2_b <= q_uid327_Trig2_in(9 downto 9);

    -- allBitsSelRR_uid366_Trig2(BITJOIN,365)@0
    allBitsSelRR_uid366_Trig2_q <= h_uid326_Trig2_b & q_uid327_Trig2_b & o_uid328_Trig2_b;

    -- muxSelSin_uid367_Trig2(LOOKUP,366)@0 + 1
    muxSelSin_uid367_Trig2_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (allBitsSelRR_uid366_Trig2_q) IS
                    WHEN "000" => muxSelSin_uid367_Trig2_q <= "00";
                    WHEN "001" => muxSelSin_uid367_Trig2_q <= "10";
                    WHEN "010" => muxSelSin_uid367_Trig2_q <= "10";
                    WHEN "011" => muxSelSin_uid367_Trig2_q <= "00";
                    WHEN "100" => muxSelSin_uid367_Trig2_q <= "01";
                    WHEN "101" => muxSelSin_uid367_Trig2_q <= "11";
                    WHEN "110" => muxSelSin_uid367_Trig2_q <= "11";
                    WHEN "111" => muxSelSin_uid367_Trig2_q <= "01";
                    WHEN OTHERS => -- unreachable
                                   muxSelSin_uid367_Trig2_q <= (others => '-');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_muxSelSin_uid367_Trig2_q_2(DELAY,967)
    redist6_muxSelSin_uid367_Trig2_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist6_muxSelSin_uid367_Trig2_q_2_q <= muxSelSin_uid367_Trig2_q;
            END IF;
        END IF;
    END PROCESS;

    -- outSin_uid369_Trig2(MUX,368)@2
    outSin_uid369_Trig2_s <= redist6_muxSelSin_uid367_Trig2_q_2_q;
    outSin_uid369_Trig2_combproc: PROCESS (outSin_uid369_Trig2_s, sinPiXRF_mergedSignalTM_uid358_Trig2_q, mSinPiXRF_uid360_Trig2_b, cosPiXRF_mergedSignalTM_uid363_Trig2_q, mCosPiXRF_uid365_Trig2_b)
    BEGIN
        CASE (outSin_uid369_Trig2_s) IS
            WHEN "00" => outSin_uid369_Trig2_q <= sinPiXRF_mergedSignalTM_uid358_Trig2_q;
            WHEN "01" => outSin_uid369_Trig2_q <= mSinPiXRF_uid360_Trig2_b;
            WHEN "10" => outSin_uid369_Trig2_q <= cosPiXRF_mergedSignalTM_uid363_Trig2_q;
            WHEN "11" => outSin_uid369_Trig2_q <= mCosPiXRF_uid365_Trig2_b;
            WHEN OTHERS => outSin_uid369_Trig2_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Convert4_sel_x(BITSELECT,81)@2
    Convert4_sel_x_b <= std_logic_vector(resize(signed(outSin_uid369_Trig2_q(11 downto 0)), 16));

    -- redist18_Convert4_sel_x_b_9_wraddr(COUNTER,1021)
    -- low=0, high=7, step=1, init=0
    redist18_Convert4_sel_x_b_9_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist18_Convert4_sel_x_b_9_wraddr_i <= redist18_Convert4_sel_x_b_9_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist18_Convert4_sel_x_b_9_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist18_Convert4_sel_x_b_9_wraddr_i, 3));

    -- redist18_Convert4_sel_x_b_9_mem(DUALMEM,1020)
    redist18_Convert4_sel_x_b_9_mem_ia <= STD_LOGIC_VECTOR(Convert4_sel_x_b);
    redist18_Convert4_sel_x_b_9_mem_aa <= redist18_Convert4_sel_x_b_9_wraddr_q;
    redist18_Convert4_sel_x_b_9_mem_ab <= redist18_Convert4_sel_x_b_9_rdcnt_q(2 downto 0);
    redist18_Convert4_sel_x_b_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 16,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist18_Convert4_sel_x_b_9_mem_aa,
        data_a => redist18_Convert4_sel_x_b_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist18_Convert4_sel_x_b_9_mem_ab,
        q_b => redist18_Convert4_sel_x_b_9_mem_iq
    );
    redist18_Convert4_sel_x_b_9_mem_q <= STD_LOGIC_VECTOR(redist18_Convert4_sel_x_b_9_mem_iq(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const(CONSTANT,465)
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q <= "1000011001100110";

    -- redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_offset(CONSTANT,1042)
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_offset_q <= "1001";

    -- redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt(ADD,1043)
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_q);
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_offset_q);
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_a) + UNSIGNED(redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_q <= redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_o(4 downto 0);

    -- redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr(COUNTER,1041)
    -- low=0, high=15, step=1, init=0
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_i <= redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_i, 4));

    -- redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem(DUALMEM,1040)
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_ia <= STD_LOGIC_VECTOR(in_8_IntegralQ_in_tpl);
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_aa <= redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_wraddr_q;
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_ab <= redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_rdcnt_q(3 downto 0);
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 16,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_aa,
        data_a => redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_ab,
        q_b => redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_iq
    );
    redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_q <= STD_LOGIC_VECTOR(redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_iq(15 downto 0));

    -- redist26_ChannelIn2_in_7_Torque_tpl_6_offset(CONSTANT,1038)
    redist26_ChannelIn2_in_7_Torque_tpl_6_offset_q <= "101";

    -- redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt(ADD,1055)
    redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_q);
    redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist26_ChannelIn2_in_7_Torque_tpl_6_offset_q);
    redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_a) + UNSIGNED(redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_q <= redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_o(3 downto 0);

    -- redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr(COUNTER,1053)
    -- low=0, high=7, step=1, init=0
    redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_i <= redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_i, 3));

    -- redist30_ChannelIn2_in_12_Ki_tpl_6_mem(DUALMEM,1052)
    redist30_ChannelIn2_in_12_Ki_tpl_6_mem_ia <= STD_LOGIC_VECTOR(in_12_Ki_tpl);
    redist30_ChannelIn2_in_12_Ki_tpl_6_mem_aa <= redist30_ChannelIn2_in_12_Ki_tpl_6_wraddr_q;
    redist30_ChannelIn2_in_12_Ki_tpl_6_mem_ab <= redist30_ChannelIn2_in_12_Ki_tpl_6_rdcnt_q(2 downto 0);
    redist30_ChannelIn2_in_12_Ki_tpl_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 16,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist30_ChannelIn2_in_12_Ki_tpl_6_mem_aa,
        data_a => redist30_ChannelIn2_in_12_Ki_tpl_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist30_ChannelIn2_in_12_Ki_tpl_6_mem_ab,
        q_b => redist30_ChannelIn2_in_12_Ki_tpl_6_mem_iq
    );
    redist30_ChannelIn2_in_12_Ki_tpl_6_mem_q <= STD_LOGIC_VECTOR(redist30_ChannelIn2_in_12_Ki_tpl_6_mem_iq(15 downto 0));

    -- redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt(ADD,1059)
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_q);
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist26_ChannelIn2_in_7_Torque_tpl_6_offset_q);
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_a) + UNSIGNED(redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_q <= redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_o(3 downto 0);

    -- redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr(COUNTER,1057)
    -- low=0, high=7, step=1, init=0
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_i <= redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_i, 3));

    -- redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem(DUALMEM,1056)
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_ia <= STD_LOGIC_VECTOR(in_13_I_Sat_Limit_tpl);
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_aa <= redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_wraddr_q;
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_ab <= redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_rdcnt_q(2 downto 0);
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 16,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_aa,
        data_a => redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_ab,
        q_b => redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_iq
    );
    redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q <= STD_LOGIC_VECTOR(redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_iq(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x(SUB,100)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_b <= STD_LOGIC_VECTOR(redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_o(15 downto 0));

    -- redist24_ChannelIn2_in_5_Iu_tpl_2(DELAY,985)
    redist24_ChannelIn2_in_5_Iu_tpl_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist24_ChannelIn2_in_5_Iu_tpl_2_delay_0 <= STD_LOGIC_VECTOR(in_5_Iu_tpl);
                redist24_ChannelIn2_in_5_Iu_tpl_2_q <= STD_LOGIC_VECTOR(redist24_ChannelIn2_in_5_Iu_tpl_2_delay_0);
            END IF;
        END IF;
    END PROCESS;

    -- y1Full_uid286_Trig(SUB,285)@0
    y1Full_uid286_Trig_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid285_Trig_q_const_q));
    y1Full_uid286_Trig_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00" & y0_uid282_Trig_b));
    y1Full_uid286_Trig_o <= STD_LOGIC_VECTOR(SIGNED(y1Full_uid286_Trig_a) - SIGNED(y1Full_uid286_Trig_b));
    y1Full_uid286_Trig_q <= STD_LOGIC_VECTOR(y1Full_uid286_Trig_o(9 downto 0));

    -- y1_uid289_Trig(BITSELECT,288)@0
    y1_uid289_Trig_in <= y1Full_uid286_Trig_q(7 downto 0);
    y1_uid289_Trig_b <= STD_LOGIC_VECTOR(y1_uid289_Trig_in(7 downto 0));

    -- y0_uid282_Trig(BITSELECT,281)@0
    y0_uid282_Trig_in <= Mult_PostCast_primWireOut_rnd_sel_b(7 downto 0);
    y0_uid282_Trig_b <= STD_LOGIC_VECTOR(y0_uid282_Trig_in(7 downto 0));

    -- o_uid281_Trig(BITSELECT,280)@0
    o_uid281_Trig_in <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b(8 downto 0));
    o_uid281_Trig_b <= o_uid281_Trig_in(8 downto 8);

    -- y_uid290_Trig(MUX,289)@0
    y_uid290_Trig_s <= o_uid281_Trig_b;
    y_uid290_Trig_combproc: PROCESS (y_uid290_Trig_s, y0_uid282_Trig_b, y1_uid289_Trig_b)
    BEGIN
        CASE (y_uid290_Trig_s) IS
            WHEN "0" => y_uid290_Trig_q <= y0_uid282_Trig_b;
            WHEN "1" => y_uid290_Trig_q <= y1_uid289_Trig_b;
            WHEN OTHERS => y_uid290_Trig_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- cosPiAT_uid295_Trig_lutmem(DUALMEM,843)@0 + 2
    cosPiAT_uid295_Trig_lutmem_aa <= y_uid290_Trig_q;
    cosPiAT_uid295_Trig_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 14,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "NONE",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_cosPiAT_uid295_Trig_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => cosPiAT_uid295_Trig_lutmem_aa,
        q_a => cosPiAT_uid295_Trig_lutmem_ir
    );
    cosPiAT_uid295_Trig_lutmem_r <= STD_LOGIC_VECTOR(cosPiAT_uid295_Trig_lutmem_ir(13 downto 0));

    -- oneOverFourPosition_uid287_Trig(BITSELECT,286)@0
    oneOverFourPosition_uid287_Trig_in <= STD_LOGIC_VECTOR(y1Full_uid286_Trig_q(8 downto 0));
    oneOverFourPosition_uid287_Trig_b <= oneOverFourPosition_uid287_Trig_in(8 downto 8);

    -- oneOverFourWhenOct_uid288_Trig(LOGICAL,287)@0 + 1
    oneOverFourWhenOct_uid288_Trig_qi <= o_uid281_Trig_b and oneOverFourPosition_uid287_Trig_b;
    oneOverFourWhenOct_uid288_Trig_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneOverFourWhenOct_uid288_Trig_qi, xout => oneOverFourWhenOct_uid288_Trig_q, clk => clk, aclr => areset, ena => '1' );

    -- redist9_oneOverFourWhenOct_uid288_Trig_q_2(DELAY,970)
    redist9_oneOverFourWhenOct_uid288_Trig_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist9_oneOverFourWhenOct_uid288_Trig_q_2_q <= oneOverFourWhenOct_uid288_Trig_q;
            END IF;
        END IF;
    END PROCESS;

    -- cosPiA_uid302_Trig(MUX,301)@2
    cosPiA_uid302_Trig_s <= redist9_oneOverFourWhenOct_uid288_Trig_q_2_q;
    cosPiA_uid302_Trig_combproc: PROCESS (cosPiA_uid302_Trig_s, cosPiAT_uid295_Trig_lutmem_r, cstPiO4Cosr_uid300_Trig_b_const_q)
    BEGIN
        CASE (cosPiA_uid302_Trig_s) IS
            WHEN "0" => cosPiA_uid302_Trig_q <= cosPiAT_uid295_Trig_lutmem_r;
            WHEN "1" => cosPiA_uid302_Trig_q <= cstPiO4Cosr_uid300_Trig_b_const_q;
            WHEN OTHERS => cosPiA_uid302_Trig_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- mCosPiXR_uid308_Trig(SUB,307)@2
    mCosPiXR_uid308_Trig_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid304_Trig_q_const_q));
    mCosPiXR_uid308_Trig_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & cosPiA_uid302_Trig_q));
    mCosPiXR_uid308_Trig_o <= STD_LOGIC_VECTOR(SIGNED(mCosPiXR_uid308_Trig_a) - SIGNED(mCosPiXR_uid308_Trig_b));
    mCosPiXR_uid308_Trig_q <= STD_LOGIC_VECTOR(mCosPiXR_uid308_Trig_o(14 downto 0));

    -- mCosPiXRF_uid318_Trig(BITSELECT,317)@2
    mCosPiXRF_uid318_Trig_b <= mCosPiXR_uid308_Trig_q(14 downto 3);

    -- cosPiXRF_topRange_uid315_Trig(BITSELECT,314)@2
    cosPiXRF_topRange_uid315_Trig_b <= STD_LOGIC_VECTOR(cosPiA_uid302_Trig_q(13 downto 3));

    -- cosPiXRF_mergedSignalTM_uid316_Trig(BITJOIN,315)@2
    cosPiXRF_mergedSignalTM_uid316_Trig_q <= GND_q & cosPiXRF_topRange_uid315_Trig_b;

    -- sinPiAT_uid292_Trig_lutmem(DUALMEM,842)@0 + 2
    sinPiAT_uid292_Trig_lutmem_aa <= y_uid290_Trig_q;
    sinPiAT_uid292_Trig_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 13,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "NONE",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_sinPiAT_uid292_Trig_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => sinPiAT_uid292_Trig_lutmem_aa,
        q_a => sinPiAT_uid292_Trig_lutmem_ir
    );
    sinPiAT_uid292_Trig_lutmem_r <= STD_LOGIC_VECTOR(sinPiAT_uid292_Trig_lutmem_ir(12 downto 0));

    -- sinPiA_uid301_Trig(MUX,300)@2
    sinPiA_uid301_Trig_s <= redist9_oneOverFourWhenOct_uid288_Trig_q_2_q;
    sinPiA_uid301_Trig_combproc: PROCESS (sinPiA_uid301_Trig_s, sinPiAT_uid292_Trig_lutmem_r, cstPiO4Sin_uid298_Trig_q)
    BEGIN
        CASE (sinPiA_uid301_Trig_s) IS
            WHEN "0" => sinPiA_uid301_Trig_q <= sinPiAT_uid292_Trig_lutmem_r;
            WHEN "1" => sinPiA_uid301_Trig_q <= cstPiO4Sin_uid298_Trig_q;
            WHEN OTHERS => sinPiA_uid301_Trig_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- mSinPiXR_uid305_Trig(SUB,304)@2
    mSinPiXR_uid305_Trig_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid304_Trig_q_const_q));
    mSinPiXR_uid305_Trig_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00" & sinPiA_uid301_Trig_q));
    mSinPiXR_uid305_Trig_o <= STD_LOGIC_VECTOR(SIGNED(mSinPiXR_uid305_Trig_a) - SIGNED(mSinPiXR_uid305_Trig_b));
    mSinPiXR_uid305_Trig_q <= STD_LOGIC_VECTOR(mSinPiXR_uid305_Trig_o(14 downto 0));

    -- mSinPiXRF_uid313_Trig(BITSELECT,312)@2
    mSinPiXRF_uid313_Trig_b <= mSinPiXR_uid305_Trig_q(14 downto 3);

    -- sinPiXRF_topRange_uid310_Trig(BITSELECT,309)@2
    sinPiXRF_topRange_uid310_Trig_b <= STD_LOGIC_VECTOR(sinPiA_uid301_Trig_q(12 downto 3));

    -- sinPiXRF_mergedSignalTM_uid311_Trig(BITJOIN,310)@2
    sinPiXRF_mergedSignalTM_uid311_Trig_q <= sinPiXRF_topExtension_uid309_Trig_q & sinPiXRF_topRange_uid310_Trig_b;

    -- h_uid279_Trig(BITSELECT,278)@0
    h_uid279_Trig_in <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b(10 downto 0));
    h_uid279_Trig_b <= h_uid279_Trig_in(10 downto 10);

    -- q_uid280_Trig(BITSELECT,279)@0
    q_uid280_Trig_in <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b(9 downto 0));
    q_uid280_Trig_b <= q_uid280_Trig_in(9 downto 9);

    -- allBitsSelRR_uid319_Trig(BITJOIN,318)@0
    allBitsSelRR_uid319_Trig_q <= h_uid279_Trig_b & q_uid280_Trig_b & o_uid281_Trig_b;

    -- muxSelSin_uid320_Trig(LOOKUP,319)@0 + 1
    muxSelSin_uid320_Trig_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (allBitsSelRR_uid319_Trig_q) IS
                    WHEN "000" => muxSelSin_uid320_Trig_q <= "00";
                    WHEN "001" => muxSelSin_uid320_Trig_q <= "10";
                    WHEN "010" => muxSelSin_uid320_Trig_q <= "10";
                    WHEN "011" => muxSelSin_uid320_Trig_q <= "00";
                    WHEN "100" => muxSelSin_uid320_Trig_q <= "01";
                    WHEN "101" => muxSelSin_uid320_Trig_q <= "11";
                    WHEN "110" => muxSelSin_uid320_Trig_q <= "11";
                    WHEN "111" => muxSelSin_uid320_Trig_q <= "01";
                    WHEN OTHERS => -- unreachable
                                   muxSelSin_uid320_Trig_q <= (others => '-');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist8_muxSelSin_uid320_Trig_q_2(DELAY,969)
    redist8_muxSelSin_uid320_Trig_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist8_muxSelSin_uid320_Trig_q_2_q <= muxSelSin_uid320_Trig_q;
            END IF;
        END IF;
    END PROCESS;

    -- outSin_uid322_Trig(MUX,321)@2
    outSin_uid322_Trig_s <= redist8_muxSelSin_uid320_Trig_q_2_q;
    outSin_uid322_Trig_combproc: PROCESS (outSin_uid322_Trig_s, sinPiXRF_mergedSignalTM_uid311_Trig_q, mSinPiXRF_uid313_Trig_b, cosPiXRF_mergedSignalTM_uid316_Trig_q, mCosPiXRF_uid318_Trig_b)
    BEGIN
        CASE (outSin_uid322_Trig_s) IS
            WHEN "00" => outSin_uid322_Trig_q <= sinPiXRF_mergedSignalTM_uid311_Trig_q;
            WHEN "01" => outSin_uid322_Trig_q <= mSinPiXRF_uid313_Trig_b;
            WHEN "10" => outSin_uid322_Trig_q <= cosPiXRF_mergedSignalTM_uid316_Trig_q;
            WHEN "11" => outSin_uid322_Trig_q <= mCosPiXRF_uid318_Trig_b;
            WHEN OTHERS => outSin_uid322_Trig_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Convert1_sel_x(BITSELECT,79)@2
    Convert1_sel_x_b <= std_logic_vector(resize(signed(outSin_uid322_Trig_q(11 downto 0)), 16));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma(CHAINMULTADD,899)@2 + 4
    -- in b@5
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Convert1_sel_x_b),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist24_ChannelIn2_in_5_Iu_tpl_2_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_rnd_x_sel(BITSELECT,439)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_sel_x(BITSELECT,191)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_rnd_x_sel_b(15 downto 0);

    -- xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITSELECT,607)@2
    xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(26 downto 26);

    -- sR_topExtension_uid610_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,609)@2
    sR_topExtension_uid610_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid608_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b;

    -- xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x(BITSELECT,554)@2
    xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b <= redist25_ChannelIn2_in_6_Iw_tpl_2_q(15 downto 15);

    -- sR_topExtension_uid557_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x(BITJOIN,556)@2
    sR_topExtension_uid557_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q <= xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid555_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b;

    -- redist25_ChannelIn2_in_6_Iw_tpl_2(DELAY,986)
    redist25_ChannelIn2_in_6_Iw_tpl_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist25_ChannelIn2_in_6_Iw_tpl_2_delay_0 <= STD_LOGIC_VECTOR(in_6_Iw_tpl);
                redist25_ChannelIn2_in_6_Iw_tpl_2_q <= STD_LOGIC_VECTOR(redist25_ChannelIn2_in_6_Iw_tpl_2_delay_0);
            END IF;
        END IF;
    END PROCESS;

    -- sR_mergedSignalTMB_uid558_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x(BITJOIN,557)@2
    sR_mergedSignalTMB_uid558_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q <= sR_topExtension_uid557_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q & redist25_ChannelIn2_in_6_Iw_tpl_2_q & sR_bottomExtension_uid514_Mult_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,442)@2
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_rnd_x_sel_b <= sR_mergedSignalTMB_uid558_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_sel_x(BITSELECT,194)@2
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_rnd_x_sel_b(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x(ADD,84)@2
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_a <= STD_LOGIC_VECTOR(redist24_ChannelIn2_in_5_Iu_tpl_2_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_o(15 downto 0));

    -- highABits_uid599_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITSELECT,598)@2
    highABits_uid599_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(15 downto 3);

    -- addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(ADD,599)@2
    addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 13 => highABits_uid599_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b(12)) & highABits_uid599_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q));
    addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a) + SIGNED(addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= STD_LOGIC_VECTOR(addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o(16 downto 0));

    -- lowRangeA_uid598_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITSELECT,597)@2
    lowRangeA_uid598_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(2 downto 0);
    lowRangeA_uid598_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeA_uid598_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_in(2 downto 0));

    -- add_uid601_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,600)@2
    add_uid601_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= addhigh_uid600_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q & lowRangeA_uid598_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b;

    -- padBCst_uid603_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(CONSTANT,602)
    padBCst_uid603_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= "000000";

    -- bPostPad_uid604_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,603)@2
    bPostPad_uid604_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= add_uid601_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q & padBCst_uid603_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- bPostPad_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,593)@2
    bPostPad_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q & padBCst_uid593_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(SUB,594)@2
    sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q));
    sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 20 => bPostPad_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(19)) & bPostPad_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q));
    sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a) - SIGNED(sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= STD_LOGIC_VECTOR(sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o(20 downto 0));

    -- a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(SUB,604)@2
    a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 21 => sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(20)) & sub_uid595_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q));
    a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => bPostPad_uid604_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(25)) & bPostPad_uid604_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q));
    a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a) - SIGNED(a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= STD_LOGIC_VECTOR(a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o(26 downto 0));

    -- sR_mergedSignalTM_uid612_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,611)@2
    sR_mergedSignalTM_uid612_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= sR_topExtension_uid610_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q & a_subconst_591_uid605_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,443)@2
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_rnd_x_sel_b <= sR_mergedSignalTM_uid612_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x(BITSELECT,195)@2
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_rnd_x_sel_b(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma(CHAINMULTADD,900)@2 + 4
    -- in b@5
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Convert4_sel_x_b),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_rnd_x_sel(BITSELECT,440)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_sel_x(BITSELECT,192)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_rnd_x_sel_b(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x(SUB,89)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_o(15 downto 0));

    -- redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt(ADD,1039)
    redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_q);
    redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist26_ChannelIn2_in_7_Torque_tpl_6_offset_q);
    redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_a) + UNSIGNED(redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_q <= redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_o(3 downto 0);

    -- redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr(COUNTER,1037)
    -- low=0, high=7, step=1, init=0
    redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_i <= redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_i, 3));

    -- redist26_ChannelIn2_in_7_Torque_tpl_6_mem(DUALMEM,1036)
    redist26_ChannelIn2_in_7_Torque_tpl_6_mem_ia <= STD_LOGIC_VECTOR(in_7_Torque_tpl);
    redist26_ChannelIn2_in_7_Torque_tpl_6_mem_aa <= redist26_ChannelIn2_in_7_Torque_tpl_6_wraddr_q;
    redist26_ChannelIn2_in_7_Torque_tpl_6_mem_ab <= redist26_ChannelIn2_in_7_Torque_tpl_6_rdcnt_q(2 downto 0);
    redist26_ChannelIn2_in_7_Torque_tpl_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 16,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist26_ChannelIn2_in_7_Torque_tpl_6_mem_aa,
        data_a => redist26_ChannelIn2_in_7_Torque_tpl_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist26_ChannelIn2_in_7_Torque_tpl_6_mem_ab,
        q_b => redist26_ChannelIn2_in_7_Torque_tpl_6_mem_iq
    );
    redist26_ChannelIn2_in_7_Torque_tpl_6_mem_q <= STD_LOGIC_VECTOR(redist26_ChannelIn2_in_7_Torque_tpl_6_mem_iq(15 downto 0));

    -- Sub2_1_x(SUB,179)@6
    Sub2_1_x_a <= STD_LOGIC_VECTOR(redist26_ChannelIn2_in_7_Torque_tpl_6_mem_q);
    Sub2_1_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q);
    Sub2_1_x_o <= STD_LOGIC_VECTOR(SIGNED(Sub2_1_x_a) - SIGNED(Sub2_1_x_b));
    Sub2_1_x_q <= STD_LOGIC_VECTOR(Sub2_1_x_o(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x(COMPARE,201)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q(15)) & redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => Sub2_1_x_q(15)) & Sub2_1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_o(17));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x(MUX,200)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_s, redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q, Sub2_1_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q <= redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q <= Sub2_1_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x(COMPARE,203)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_o(17);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x(MUX,202)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma(CHAINMULTADD,908)@6 + 4
    -- in b@9
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist30_ChannelIn2_in_12_Ki_tpl_6_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,450)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x(BITSELECT,214)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x(ADD,110)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_q(15)) & redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_o(21 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x(COMPARE,222)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x(MUX,221)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805(CONSTANT,804)
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q <= "100001100110011";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_809(BITSELECT,808)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_809_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q(21 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810(COMPARE,809)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_809_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_809_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 15 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q(14)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_o(22);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x(MUX,223)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_810_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,225)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q(15 downto 0);

    -- redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt(ADD,1051)
    redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_q);
    redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist26_ChannelIn2_in_7_Torque_tpl_6_offset_q);
    redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_a) + UNSIGNED(redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_q <= redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_o(3 downto 0);

    -- redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr(COUNTER,1049)
    -- low=0, high=7, step=1, init=0
    redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_i <= redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_i, 3));

    -- redist29_ChannelIn2_in_11_Kp_tpl_6_mem(DUALMEM,1048)
    redist29_ChannelIn2_in_11_Kp_tpl_6_mem_ia <= STD_LOGIC_VECTOR(in_11_Kp_tpl);
    redist29_ChannelIn2_in_11_Kp_tpl_6_mem_aa <= redist29_ChannelIn2_in_11_Kp_tpl_6_wraddr_q;
    redist29_ChannelIn2_in_11_Kp_tpl_6_mem_ab <= redist29_ChannelIn2_in_11_Kp_tpl_6_rdcnt_q(2 downto 0);
    redist29_ChannelIn2_in_11_Kp_tpl_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 16,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist29_ChannelIn2_in_11_Kp_tpl_6_mem_aa,
        data_a => redist29_ChannelIn2_in_11_Kp_tpl_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist29_ChannelIn2_in_11_Kp_tpl_6_mem_ab,
        q_b => redist29_ChannelIn2_in_11_Kp_tpl_6_mem_iq
    );
    redist29_ChannelIn2_in_11_Kp_tpl_6_mem_q <= STD_LOGIC_VECTOR(redist29_ChannelIn2_in_11_Kp_tpl_6_mem_iq(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma(CHAINMULTADD,907)@6 + 4
    -- in b@9
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist29_ChannelIn2_in_11_Kp_tpl_6_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,451)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x(BITSELECT,215)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x(ADD,109)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_o(21 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x(CONSTANT,108)
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q <= "0111100110011010";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x(COMPARE,217)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x(MUX,216)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_806(BITSELECT,805)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_806_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q(21 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807(COMPARE,806)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_806_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_806_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 15 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q(14)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_o(22);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x(MUX,218)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_807_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,220)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q(15 downto 0);

    -- redist13_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1(DELAY,974)
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist13_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma(CHAINMULTADD,904)@11 + 4
    -- in b@14
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist13_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist18_Convert4_sel_x_b_9_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_rnd_x_sel(BITSELECT,446)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x(BITSELECT,198)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- redist19_Convert1_sel_x_b_9_rdcnt(ADD,1027)
    redist19_Convert1_sel_x_b_9_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist19_Convert1_sel_x_b_9_wraddr_q);
    redist19_Convert1_sel_x_b_9_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist18_Convert4_sel_x_b_9_offset_q);
    redist19_Convert1_sel_x_b_9_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist19_Convert1_sel_x_b_9_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist19_Convert1_sel_x_b_9_rdcnt_a) + UNSIGNED(redist19_Convert1_sel_x_b_9_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist19_Convert1_sel_x_b_9_rdcnt_q <= redist19_Convert1_sel_x_b_9_rdcnt_o(3 downto 0);

    -- redist19_Convert1_sel_x_b_9_wraddr(COUNTER,1025)
    -- low=0, high=7, step=1, init=0
    redist19_Convert1_sel_x_b_9_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist19_Convert1_sel_x_b_9_wraddr_i <= redist19_Convert1_sel_x_b_9_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist19_Convert1_sel_x_b_9_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist19_Convert1_sel_x_b_9_wraddr_i, 3));

    -- redist19_Convert1_sel_x_b_9_mem(DUALMEM,1024)
    redist19_Convert1_sel_x_b_9_mem_ia <= STD_LOGIC_VECTOR(Convert1_sel_x_b);
    redist19_Convert1_sel_x_b_9_mem_aa <= redist19_Convert1_sel_x_b_9_wraddr_q;
    redist19_Convert1_sel_x_b_9_mem_ab <= redist19_Convert1_sel_x_b_9_rdcnt_q(2 downto 0);
    redist19_Convert1_sel_x_b_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 16,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist19_Convert1_sel_x_b_9_mem_aa,
        data_a => redist19_Convert1_sel_x_b_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist19_Convert1_sel_x_b_9_mem_ab,
        q_b => redist19_Convert1_sel_x_b_9_mem_iq
    );
    redist19_Convert1_sel_x_b_9_mem_q <= STD_LOGIC_VECTOR(redist19_Convert1_sel_x_b_9_mem_iq(15 downto 0));

    -- redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt(ADD,1047)
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_q);
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist27_ChannelIn2_in_8_IntegralQ_in_tpl_10_offset_q);
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_a) + UNSIGNED(redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_q <= redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_o(4 downto 0);

    -- redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr(COUNTER,1045)
    -- low=0, high=15, step=1, init=0
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_i <= redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_i, 4));

    -- redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem(DUALMEM,1044)
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_ia <= STD_LOGIC_VECTOR(in_9_IntegralD_in_tpl);
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_aa <= redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_wraddr_q;
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_ab <= redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_rdcnt_q(3 downto 0);
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 16,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_aa,
        data_a => redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_ab,
        q_b => redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_iq
    );
    redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_q <= STD_LOGIC_VECTOR(redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_iq(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma(CHAINMULTADD,898)@2 + 4
    -- in b@5
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Convert1_sel_x_b),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,438)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_sel_x(BITSELECT,190)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma(CHAINMULTADD,897)@2 + 4
    -- in b@5
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist24_ChannelIn2_in_5_Iu_tpl_2_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Convert4_sel_x_b),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,441)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_sel_x(BITSELECT,193)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x(ADD,83)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_o(15 downto 0));

    -- Sub2_0_x(SUB,178)@6
    Sub2_0_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q);
    Sub2_0_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q);
    Sub2_0_x_o <= STD_LOGIC_VECTOR(SIGNED(Sub2_0_x_a) - SIGNED(Sub2_0_x_b));
    Sub2_0_x_q <= STD_LOGIC_VECTOR(Sub2_0_x_o(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x(COMPARE,207)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q(15)) & redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => Sub2_0_x_q(15)) & Sub2_0_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_o(17));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x(MUX,206)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_s, redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q, Sub2_0_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q <= redist31_ChannelIn2_in_13_I_Sat_Limit_tpl_6_mem_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q <= Sub2_0_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x(COMPARE,209)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_o(17);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x(MUX,208)@6
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma(CHAINMULTADD,906)@6 + 4
    -- in b@9
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist30_ChannelIn2_in_12_Ki_tpl_6_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,448)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x(BITSELECT,212)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x(ADD,105)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_q(15)) & redist28_ChannelIn2_in_9_IntegralD_in_tpl_10_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_o(21 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x(COMPARE,232)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x(MUX,231)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_815(BITSELECT,814)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_815_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q(21 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816(COMPARE,815)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_815_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_bit_select_top_X_trz_815_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 15 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q(14)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_o(22);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x(MUX,233)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_new_compare_trz_816_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,235)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma(CHAINMULTADD,905)@6 + 4
    -- in b@9
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist29_ChannelIn2_in_11_Kp_tpl_6_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,449)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x(BITSELECT,213)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x(ADD,104)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_o(21 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x(COMPARE,227)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x(MUX,226)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_812(BITSELECT,811)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_812_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q(21 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813(COMPARE,812)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_812_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_bit_select_top_X_trz_812_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 15 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q(14)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_new_const_trz_805_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_o(22);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x(MUX,228)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_new_compare_trz_813_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q_const_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,230)@10
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q(15 downto 0);

    -- redist11_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1(DELAY,972)
    redist11_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist11_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma(CHAINMULTADD,903)@11 + 4
    -- in b@14
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist11_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist19_Convert1_sel_x_b_9_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_rnd_x_sel(BITSELECT,445)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x(BITSELECT,197)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x(ADD,94)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_o(21 downto 0));

    -- Convert2_1_sel_x(BITSELECT,189)@15
    Convert2_1_sel_x_b <= std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_q(21 downto 0)), 32));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged(BITSELECT,947)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_b <= Convert2_1_sel_x_b(17 downto 0);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_c <= Convert2_1_sel_x_b(31 downto 18);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4(BITJOIN,820)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q <= GND_q & redist32_ChannelIn2_in_14_Max_tpl_15_mem_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma(CHAINMULTADD,912)@15 + 4
    -- in b@18
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q),17));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_c),14));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 17,
        ax_clken => "0",
        ax_width => 14,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 31,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 31, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_qq0(30 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1(BITSHIFT,839)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_q & "000000000000000000";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_qint(48 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_lhsMSBs_select(BITSELECT,890)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_lhsMSBs_select_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_q(48 downto 18);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums(ADD,891)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 31 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_lhsMSBs_select_b(30)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_lhsMSBs_select_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_o(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2(BITJOIN,831)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2_q <= GND_q & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_b;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma(CHAINMULTADD,911)@15 + 4
    -- in b@18
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2_q),19));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q),17));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 19,
        ax_clken => "0",
        ax_width => 17,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 36,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_qq0(35 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged(BITSELECT,950)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_q(35 downto 18));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_q(17 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_split_join(BITJOIN,892)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_split_join_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_MSBs_sums_q & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x(BITSELECT,271)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_in <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_split_join_q(47 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_in(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc(BITSHIFT,924)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_qint(32 downto 14);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add(ADD,925)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 19 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_q(18)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_o(19 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift(BITSHIFT,926)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_qint(19 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x(BITSELECT,269)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b <= std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_q(18 downto 0)), 32));

    -- sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,710)@19
    sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => bPostPad_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(33)) & bPostPad_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(34 downto 0));

    -- a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,736)@19
    a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 35 => sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34)) & sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 39 => bPostPad_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(38)) & bPostPad_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(39 downto 0));

    -- highBBits_uid749_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,748)@19
    highBBits_uid749_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(39 downto 9);

    -- highBBits_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,739)@19
    highBBits_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34 downto 5);

    -- highBBits_uid720_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,719)@19
    highBBits_uid720_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31 downto 2);

    -- addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,720)@19
    addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 30 => highBBits_uid720_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(29)) & highBBits_uid720_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(32 downto 0));

    -- lowRangeB_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,718)@19
    lowRangeB_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(1 downto 0);
    lowRangeB_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeB_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(1 downto 0));

    -- add_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,721)@19
    add_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= addsumAHighB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,740)@19
    a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => add_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34)) & add_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 30 => highBBits_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(29)) & highBBits_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(35 downto 0));

    -- lowRangeB_uid739_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,738)@19
    lowRangeB_uid739_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(4 downto 0);
    lowRangeB_uid739_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeB_uid739_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(4 downto 0));

    -- a_subconst_157_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,741)@19
    a_subconst_157_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_157_sumAHighB_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid739_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,749)@19
    a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 41 => a_subconst_157_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(40)) & a_subconst_157_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 31 => highBBits_uid749_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(30)) & highBBits_uid749_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(41 downto 0));

    -- lowRangeB_uid748_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,747)@19
    lowRangeB_uid748_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= a_subconst_45_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(8 downto 0);
    lowRangeB_uid748_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeB_uid748_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(8 downto 0));

    -- a_subconst_80429_uid751_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,750)@19
    a_subconst_80429_uid751_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_80429_sumAHighB_uid750_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid748_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- highBBits_uid759_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,758)@19
    highBBits_uid759_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= a_subconst_80429_uid751_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(50 downto 18);

    -- aPostPad_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,731)@19
    aPostPad_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b & padBCst_uid593_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,732)@19
    sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 36 => aPostPad_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(35)) & aPostPad_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(36 downto 0));

    -- aPostPad_uid745_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,744)@19
    aPostPad_uid745_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= sub_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & padBCst_uid593_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,745)@19
    a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 41 => aPostPad_uid745_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(40)) & aPostPad_uid745_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 35 => sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34)) & sub_uid711_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(41 downto 0));

    -- highBBits_uid754_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,753)@19
    highBBits_uid754_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(41 downto 10);

    -- highBBits_uid726_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,725)@19
    highBBits_uid726_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31 downto 3);

    -- addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,726)@19
    addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 29 => highBBits_uid726_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(28)) & highBBits_uid726_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(32 downto 0));

    -- lowRangeB_uid725_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,724)@19
    lowRangeB_uid725_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(2 downto 0);
    lowRangeB_uid725_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeB_uid725_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(2 downto 0));

    -- add_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,727)@19
    add_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= addsumAHighB_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid725_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,754)@19
    a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 36 => add_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(35)) & add_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 32 => highBBits_uid754_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(31)) & highBBits_uid754_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(36 downto 0));

    -- lowRangeB_uid753_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,752)@19
    lowRangeB_uid753_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= a_subconst_243_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(9 downto 0);
    lowRangeB_uid753_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeB_uid753_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(9 downto 0));

    -- a_subconst_9459_uid756_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,755)@19
    a_subconst_9459_uid756_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_9459_sumAHighB_uid755_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid753_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,759)@19
    a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((47 downto 47 => a_subconst_9459_uid756_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(46)) & a_subconst_9459_uid756_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((47 downto 33 => highBBits_uid759_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(32)) & highBBits_uid759_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= STD_LOGIC_VECTOR(a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(47 downto 0));

    -- lowRangeB_uid758_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,757)@19
    lowRangeB_uid758_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= a_subconst_80429_uid751_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(17 downto 0);
    lowRangeB_uid758_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeB_uid758_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(17 downto 0));

    -- a_subconst_2479700525_uid761_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,760)@19
    a_subconst_2479700525_uid761_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_2479700525_sumAHighB_uid760_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid758_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- sR_uid764_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,763)@19
    sR_uid764_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= STD_LOGIC_VECTOR(a_subconst_2479700525_uid761_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(63 downto 0));
    sR_uid764_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= sR_uid764_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(63 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc(BITSHIFT,941)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_qint <= sR_uid764_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_qint(63 downto 31);

    -- redist4_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1(DELAY,965)
    redist4_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist4_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add(ADD,942)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => redist4_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q(32)) & redist4_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_o(33 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift(BITSHIFT,943)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_qint(33 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x(BITSELECT,253)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_q(31 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x(SUB,127)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 1 => GND_q(0)) & GND_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_o(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_PostCast_primWireOut_sel_x(BITSELECT,243)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_q(31 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1(BITSHIFT,274)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_PostCast_primWireOut_sel_x_b & "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_qint(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma(CHAINMULTADD,902)@11 + 4
    -- in b@14
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist13_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist19_Convert1_sel_x_b_9_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,444)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x(BITSELECT,196)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma(CHAINMULTADD,901)@11 + 4
    -- in b@14
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist11_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b_1_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist18_Convert4_sel_x_b_9_mem_q),16));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        ax_clken => "0",
        ax_width => 16,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 32,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 32, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_qq0(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,447)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_rnd_x_sel_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_q(31 downto 10);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x(BITSELECT,199)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_rnd_x_sel_b(20 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x(SUB,99)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_o(21 downto 0));

    -- Convert2_0_sel_x(BITSELECT,188)@15
    Convert2_0_sel_x_b <= std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_q(21 downto 0)), 32));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged(BITSELECT,946)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_b <= Convert2_0_sel_x_b(17 downto 0);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_c <= Convert2_0_sel_x_b(31 downto 18);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma(CHAINMULTADD,910)@15 + 4
    -- in b@18
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q),17));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_c),14));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 17,
        ax_clken => "0",
        ax_width => 14,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 31,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 31, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_qq0(30 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1(BITSHIFT,826)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_q & "000000000000000000";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_qint(48 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_lhsMSBs_select(BITSELECT,885)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_lhsMSBs_select_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_q(48 downto 18);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums(ADD,886)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 31 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_lhsMSBs_select_b(30)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_lhsMSBs_select_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_o(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2(BITJOIN,818)@15
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2_q <= GND_q & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_b;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma(CHAINMULTADD,909)@15 + 4
    -- in b@18
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2_q),19));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q),17));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "none",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 19,
        ax_clken => "0",
        ax_width => 17,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 36,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0,
        ena(1) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena1,
        ena(2) => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena2,
        clr(0) => '0',
        clr(1) => '0',
        ay => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_a0,
        ax => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_c0,
        resulta => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_s0
    );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_s0, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_qq0(35 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged(BITSELECT,949)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_q(35 downto 18));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_q(17 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_split_join(BITJOIN,887)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_split_join_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_MSBs_sums_q & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x(BITSELECT,270)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_in <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_split_join_q(47 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_in(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc(BITSHIFT,919)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_qint(32 downto 14);

    -- redist5_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q_1(DELAY,966)
    redist5_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist5_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add(ADD,920)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 19 => redist5_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q_1_q(18)) & redist5_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q_1_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_o(19 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift(BITSHIFT,921)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_qint(19 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x(BITSELECT,268)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b <= std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_q(18 downto 0)), 32));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x(ADD,165)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_o(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged(SUB,635)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 1 => GND_q(0)) & GND_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_i <= "0" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_i WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b = "1" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b1 <= (others => '0') WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b = "1" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a1) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b1));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_o(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_xinvSel(LOGICAL,956)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_xinvSel_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x(SUB,175)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_o(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign(LOGICAL,638)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q(32 downto 32));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign(LOGICAL,642)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q(32 downto 32));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x(LOGICAL,142)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x(LOGICAL,164)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign(LOGICAL,640)@19 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_qi <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31 downto 31)));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_qi, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_q, clk => clk, aclr => areset, ena => '1' );

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x(LOGICAL,143)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x_q;

    -- mergedMUXes1_opt_lev0_id1(SELECTOR,959)@20
    mergedMUXes1_opt_lev0_id1_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q, VCC_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_xinvSel_q, GND_q)
    BEGIN
        mergedMUXes1_opt_lev0_id1_q <= (others => '0');
        mergedMUXes1_opt_lev0_id1_v <= "0";
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_xinvSel_q = "1") THEN
            mergedMUXes1_opt_lev0_id1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & GND_q));
            mergedMUXes1_opt_lev0_id1_v <= "1";
        END IF;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q = "1") THEN
            mergedMUXes1_opt_lev0_id1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & VCC_q));
            mergedMUXes1_opt_lev0_id1_v <= "1";
        END IF;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x_q = "1") THEN
            mergedMUXes1_opt_lev0_id1_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q);
            mergedMUXes1_opt_lev0_id1_v <= "1";
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x(LOGICAL,163)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x(LOGICAL,144)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not_x(LOGICAL,162)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x(LOGICAL,145)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not_x_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x(LOGICAL,146)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q;

    -- mergedMUXes1_opt_lev0_id0(SELECTOR,958)@20
    mergedMUXes1_opt_lev0_id0_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x_q, VCC_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x_q, GND_q)
    BEGIN
        mergedMUXes1_opt_lev0_id0_q <= (others => '0');
        mergedMUXes1_opt_lev0_id0_v <= "0";
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x_q = "1") THEN
            mergedMUXes1_opt_lev0_id0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & GND_q));
            mergedMUXes1_opt_lev0_id0_v <= "1";
        END IF;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x_q = "1") THEN
            mergedMUXes1_opt_lev0_id0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & VCC_q));
            mergedMUXes1_opt_lev0_id0_v <= "1";
        END IF;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x_q = "1") THEN
            mergedMUXes1_opt_lev0_id0_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q);
            mergedMUXes1_opt_lev0_id0_v <= "1";
        END IF;
    END PROCESS;

    -- mergedMUXes1_opt_lev1_id0(SELECTOR,960)@20
    mergedMUXes1_opt_lev1_id0_combproc: PROCESS (mergedMUXes1_opt_lev0_id0_v, mergedMUXes1_opt_lev0_id0_q, mergedMUXes1_opt_lev0_id1_v, mergedMUXes1_opt_lev0_id1_q)
    BEGIN
        mergedMUXes1_opt_lev1_id0_q <= (others => '0');
        IF (mergedMUXes1_opt_lev0_id1_v = "1") THEN
            mergedMUXes1_opt_lev1_id0_q <= STD_LOGIC_VECTOR(mergedMUXes1_opt_lev0_id1_q);
        END IF;
        IF (mergedMUXes1_opt_lev0_id0_v = "1") THEN
            mergedMUXes1_opt_lev1_id0_q <= STD_LOGIC_VECTOR(mergedMUXes1_opt_lev0_id0_q);
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Convert_sel_x(BITSELECT,246)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Convert_sel_x_b <= std_logic_vector(resize(unsigned(mergedMUXes1_opt_lev1_id0_q(1 downto 0)), 3));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged(BITSELECT,948)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Convert_sel_x_b(1 downto 0);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_in(0 downto 0);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_in(1 downto 1);

    -- highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(BITSELECT,374)@20
    highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31 downto 1);

    -- addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(ADD,375)@20
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 31 => highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b(30)) & highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b));
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_a) + SIGNED(addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b));
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q <= STD_LOGIC_VECTOR(addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_o(32 downto 0));

    -- lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(BITSELECT,373)@20
    lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(0 downto 0);
    lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b <= STD_LOGIC_VECTOR(lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_in(0 downto 0));

    -- add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(BITJOIN,376)@20
    add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q <= addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q & lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x(BITSELECT,252)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x_b <= add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(31 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x(CONSTANT,56)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q <= "01111111111111111111111111111111";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_top_X_879(BITSELECT,878)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_top_X_879_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(33)) & add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_top_X_879_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_top_X_879_in(33 downto 31);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op_top_X_881(LOGICAL,880)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op_top_X_881_q <= "1" WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_top_X_879_b /= "000" ELSE "0";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_msb_X_878(BITSELECT,877)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_msb_X_878_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(33)) & add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_msb_X_878_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_msb_X_878_in(34 downto 34);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_not_msb_X_880(LOGICAL,879)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_not_msb_X_880_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_bit_select_msb_X_878_b));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op2_882(LOGICAL,881)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op2_882_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_not_msb_X_880_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op_top_X_881_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x(CONSTANT,58)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q <= "10000000000000000000000000000000";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_501(BITSELECT,500)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_501_b <= add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(32 downto 31);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_503(LOGICAL,502)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_503_q <= "1" WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_501_b = "11" ELSE "0";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_500(BITSELECT,499)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_500_b <= add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(33 downto 33);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_502(LOGICAL,501)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_502_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_500_b));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_504(LOGICAL,503)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_504_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_502_q or DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_503_q);

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x(LOGICAL,183)@20
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_504_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x(SELECTOR,59)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op2_882_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x_b)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x_b;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_498_logic_op2_882_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q;
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x(BITSELECT,254)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b <= std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q(31 downto 0)), 33));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x(ADD,166)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_o(33 downto 0));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged(SUB,636)@20 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 1 => GND_q(0)) & GND_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_i <= "0" & STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_a1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_i WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c = "0" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_a;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_b1 <= (others => '0') WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c = "0" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_a1) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_b1));
            END IF;
        END IF;
    END PROCESS;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_o(33 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x(ADD,124)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000000000000" & redist34_ChannelIn2_in_14_Max_tpl_21_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_o(34 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add(ADD,937)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_o(35 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift(BITSHIFT,938)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_qint(35 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged(BITSELECT,953)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_in(15 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_c <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_in(35 downto 35);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_d <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_in(34 downto 16);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x(CONSTANT,29)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q <= "1111111111111111";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op_top_X_874(LOGICAL,873)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op_top_X_874_q <= "1" WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_d /= "0000000000000000000" ELSE "0";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_not_msb_X_873(LOGICAL,872)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_not_msb_X_873_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_c));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op2_875(LOGICAL,874)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op2_875_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_not_msb_X_873_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op_top_X_874_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x(CONSTANT,31)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q <= "0000000000000000";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign(LOGICAL,492)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q(34 downto 34));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x(LOGICAL,182)@21
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x(SELECTOR,44)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op2_875_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_b)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_bit_select_merged_b;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_new_compare_to_491_logic_op2_875_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q;
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q;
        END IF;
    END PROCESS;

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x(COMPARE,261)@21
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a <= STD_LOGIC_VECTOR("00" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b <= STD_LOGIC_VECTOR("00" & redist34_ChannelIn2_in_14_Max_tpl_21_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a) - UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b));
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_n(0) <= not (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o(17));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x(MUX,260)@21 + 1
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_n;
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s) IS
                    WHEN "0" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q;
                    WHEN "1" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= redist34_ChannelIn2_in_14_Max_tpl_21_q;
                    WHEN OTHERS => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x(SUB,176)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_o(33 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_xinvSel(LOGICAL,954)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_xinvSel_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1(BITSHIFT,275)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b & "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_qint(32 downto 0);

    -- mergedMUXes0(SELECTOR,955)@20
    mergedMUXes0_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_xinvSel_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_q)
    BEGIN
        mergedMUXes0_q <= (others => '0');
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_xinvSel_q = "1") THEN
            mergedMUXes0_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_q;
        END IF;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b = "1") THEN
            mergedMUXes0_q <= STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q);
        END IF;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c = "1") THEN
            mergedMUXes0_q <= STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q);
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x(ADD,123)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => mergedMUXes0_q(33)) & mergedMUXes0_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000000000000" & redist33_ChannelIn2_in_14_Max_tpl_20_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_o(34 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add(ADD,933)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_o(35 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift(BITSHIFT,934)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_qint(35 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged(BITSELECT,952)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_in(15 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_in(35 downto 35);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_d <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_in(34 downto 16);

    -- redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b_1(DELAY,961)
    redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867(LOGICAL,866)@20 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867_qi <= "1" WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_d /= "0000000000000000000" ELSE "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867_qi, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867_q, clk => clk, aclr => areset, ena => '1' );

    -- redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c_1(DELAY,962)
    redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_not_msb_X_866(LOGICAL,865)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_not_msb_X_866_q <= STD_LOGIC_VECTOR(not (redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_c_1_q));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op2_868(LOGICAL,867)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op2_868_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_not_msb_X_866_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op_top_X_867_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign(LOGICAL,488)@20 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_qi <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q(34 downto 34)));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_qi, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_q, clk => clk, aclr => areset, ena => '1' );

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x(LOGICAL,181)@21
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x(SELECTOR,38)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op2_868_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q, redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b_1_q)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q <= redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_bit_select_merged_b_1_q;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_new_compare_to_487_logic_op2_868_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q;
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q;
        END IF;
    END PROCESS;

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x(COMPARE,259)@21
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR("00" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR("00" & redist34_ChannelIn2_in_14_Max_tpl_21_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a) - UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b));
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_n(0) <= not (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o(17));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x(MUX,258)@21 + 1
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_n;
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s) IS
                    WHEN "0" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q;
                    WHEN "1" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= redist34_ChannelIn2_in_14_Max_tpl_21_q;
                    WHEN OTHERS => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1(BITSHIFT,276)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b & "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_qint(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x(MUX,132)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged(SUB,634)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 1 => GND_q(0)) & GND_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_i <= "0" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_i WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c = "0" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b1 <= (others => '0') WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c = "0" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a1) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b1));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_o(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x(ADD,122)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000000000000000" & redist33_ChannelIn2_in_14_Max_tpl_20_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_o(33 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add(ADD,929)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_o(34 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift(BITSHIFT,930)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_qint(34 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged(BITSELECT,951)@20
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_in(15 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_in(34 downto 34);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_d <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_in(33 downto 16);

    -- redist2_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b_1(DELAY,963)
    redist2_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist2_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860(LOGICAL,859)@20 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860_qi <= "1" WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_d /= "000000000000000000" ELSE "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860_qi, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860_q, clk => clk, aclr => areset, ena => '1' );

    -- redist3_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c_1(DELAY,964)
    redist3_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist3_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_not_msb_X_859(LOGICAL,858)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_not_msb_X_859_q <= STD_LOGIC_VECTOR(not (redist3_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_c_1_q));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op2_861(LOGICAL,860)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op2_861_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_not_msb_X_859_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op_top_X_860_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign(LOGICAL,484)@20 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_qi <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q(33 downto 33)));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_qi, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_q, clk => clk, aclr => areset, ena => '1' );

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x(LOGICAL,180)@21
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x(SELECTOR,32)@21
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op2_861_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q, redist2_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b_1_q)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q <= redist2_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_bit_select_merged_b_1_q;
        IF (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_new_compare_to_483_logic_op2_861_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q;
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q;
        END IF;
    END PROCESS;

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x(COMPARE,257)@21
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a <= STD_LOGIC_VECTOR("00" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b <= STD_LOGIC_VECTOR("00" & redist34_ChannelIn2_in_14_Max_tpl_21_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a) - UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b));
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_n(0) <= not (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o(17));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x(MUX,256)@21 + 1
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_n;
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s) IS
                    WHEN "0" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q;
                    WHEN "1" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= redist34_ChannelIn2_in_14_Max_tpl_21_q;
                    WHEN OTHERS => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_offset(CONSTANT,1014)
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_offset_q <= "0011";

    -- redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt(ADD,1019)
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_q);
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_offset_q);
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_a) + UNSIGNED(redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_q <= redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_o(4 downto 0);

    -- redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr(COUNTER,1017)
    -- low=0, high=15, step=1, init=0
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_i <= redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_i, 4));

    -- redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem(DUALMEM,1016)
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q);
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_aa <= redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_wraddr_q;
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_ab <= redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_rdcnt_q(3 downto 0);
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 16,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_aa,
        data_a => redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_ab,
        q_b => redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_iq
    );
    redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_q <= STD_LOGIC_VECTOR(redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_iq(15 downto 0));

    -- redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt(ADD,1015)
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_q);
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_offset_q);
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_a) + UNSIGNED(redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_q <= redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_o(4 downto 0);

    -- redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr(COUNTER,1013)
    -- low=0, high=15, step=1, init=0
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_i <= redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_i, 4));

    -- redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem(DUALMEM,1012)
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q);
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_aa <= redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_wraddr_q;
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_ab <= redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_rdcnt_q(3 downto 0);
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 16,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_aa,
        data_a => redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_ab,
        q_b => redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_iq
    );
    redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_q <= STD_LOGIC_VECTOR(redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_iq(15 downto 0));

    -- redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_offset(CONSTANT,998)
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_offset_q <= "0111";

    -- redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt(ADD,1003)
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q);
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_offset_q);
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_a) + UNSIGNED(redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_q <= redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_o(4 downto 0);

    -- redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr(COUNTER,1001)
    -- low=0, high=15, step=1, init=0
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i <= redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i, 4));

    -- redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem(DUALMEM,1000)
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b);
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_aa <= redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q;
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ab <= redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_q(3 downto 0);
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 16,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_aa,
        data_a => redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ab,
        q_b => redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_iq
    );
    redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_q <= STD_LOGIC_VECTOR(redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_iq(15 downto 0));

    -- redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt(ADD,999)
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q);
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_offset_q);
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_a) + UNSIGNED(redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_q <= redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_o(4 downto 0);

    -- redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr(COUNTER,997)
    -- low=0, high=15, step=1, init=0
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i <= redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_i, 4));

    -- redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem(DUALMEM,996)
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b);
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_aa <= redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_wraddr_q;
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ab <= redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_rdcnt_q(3 downto 0);
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 4,
        numwords_a => 16,
        width_b => 16,
        widthad_b => 4,
        numwords_b => 16,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_aa,
        data_a => redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_ab,
        q_b => redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_iq
    );
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_q <= STD_LOGIC_VECTOR(redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_iq(15 downto 0));

    -- redist14_Convert2_1_sel_x_b_7_offset(CONSTANT,1006)
    redist14_Convert2_1_sel_x_b_7_offset_q <= "100";

    -- redist14_Convert2_1_sel_x_b_7_rdcnt(ADD,1007)
    redist14_Convert2_1_sel_x_b_7_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist14_Convert2_1_sel_x_b_7_wraddr_q);
    redist14_Convert2_1_sel_x_b_7_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist14_Convert2_1_sel_x_b_7_offset_q);
    redist14_Convert2_1_sel_x_b_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist14_Convert2_1_sel_x_b_7_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist14_Convert2_1_sel_x_b_7_rdcnt_a) + UNSIGNED(redist14_Convert2_1_sel_x_b_7_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist14_Convert2_1_sel_x_b_7_rdcnt_q <= redist14_Convert2_1_sel_x_b_7_rdcnt_o(3 downto 0);

    -- redist14_Convert2_1_sel_x_b_7_wraddr(COUNTER,1005)
    -- low=0, high=7, step=1, init=0
    redist14_Convert2_1_sel_x_b_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist14_Convert2_1_sel_x_b_7_wraddr_i <= redist14_Convert2_1_sel_x_b_7_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist14_Convert2_1_sel_x_b_7_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist14_Convert2_1_sel_x_b_7_wraddr_i, 3));

    -- redist14_Convert2_1_sel_x_b_7_mem(DUALMEM,1004)
    redist14_Convert2_1_sel_x_b_7_mem_ia <= STD_LOGIC_VECTOR(Convert2_1_sel_x_b);
    redist14_Convert2_1_sel_x_b_7_mem_aa <= redist14_Convert2_1_sel_x_b_7_wraddr_q;
    redist14_Convert2_1_sel_x_b_7_mem_ab <= redist14_Convert2_1_sel_x_b_7_rdcnt_q(2 downto 0);
    redist14_Convert2_1_sel_x_b_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist14_Convert2_1_sel_x_b_7_mem_aa,
        data_a => redist14_Convert2_1_sel_x_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist14_Convert2_1_sel_x_b_7_mem_ab,
        q_b => redist14_Convert2_1_sel_x_b_7_mem_iq
    );
    redist14_Convert2_1_sel_x_b_7_mem_q <= STD_LOGIC_VECTOR(redist14_Convert2_1_sel_x_b_7_mem_iq(31 downto 0));

    -- redist15_Convert2_0_sel_x_b_7_rdcnt(ADD,1011)
    redist15_Convert2_0_sel_x_b_7_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist15_Convert2_0_sel_x_b_7_wraddr_q);
    redist15_Convert2_0_sel_x_b_7_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist14_Convert2_1_sel_x_b_7_offset_q);
    redist15_Convert2_0_sel_x_b_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist15_Convert2_0_sel_x_b_7_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist15_Convert2_0_sel_x_b_7_rdcnt_a) + UNSIGNED(redist15_Convert2_0_sel_x_b_7_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist15_Convert2_0_sel_x_b_7_rdcnt_q <= redist15_Convert2_0_sel_x_b_7_rdcnt_o(3 downto 0);

    -- redist15_Convert2_0_sel_x_b_7_wraddr(COUNTER,1009)
    -- low=0, high=7, step=1, init=0
    redist15_Convert2_0_sel_x_b_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist15_Convert2_0_sel_x_b_7_wraddr_i <= redist15_Convert2_0_sel_x_b_7_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist15_Convert2_0_sel_x_b_7_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist15_Convert2_0_sel_x_b_7_wraddr_i, 3));

    -- redist15_Convert2_0_sel_x_b_7_mem(DUALMEM,1008)
    redist15_Convert2_0_sel_x_b_7_mem_ia <= STD_LOGIC_VECTOR(Convert2_0_sel_x_b);
    redist15_Convert2_0_sel_x_b_7_mem_aa <= redist15_Convert2_0_sel_x_b_7_wraddr_q;
    redist15_Convert2_0_sel_x_b_7_mem_ab <= redist15_Convert2_0_sel_x_b_7_rdcnt_q(2 downto 0);
    redist15_Convert2_0_sel_x_b_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 32,
        widthad_b => 3,
        numwords_b => 8,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist15_Convert2_0_sel_x_b_7_mem_aa,
        data_a => redist15_Convert2_0_sel_x_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist15_Convert2_0_sel_x_b_7_mem_ab,
        q_b => redist15_Convert2_0_sel_x_b_7_mem_iq
    );
    redist15_Convert2_0_sel_x_b_7_mem_q <= STD_LOGIC_VECTOR(redist15_Convert2_0_sel_x_b_7_mem_iq(31 downto 0));

    -- redist21_ChannelIn2_in_2_dc_tpl_22_offset(CONSTANT,1030)
    redist21_ChannelIn2_in_2_dc_tpl_22_offset_q <= "01101";

    -- redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt(ADD,1035)
    redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_q);
    redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist21_ChannelIn2_in_2_dc_tpl_22_offset_q);
    redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_a) + UNSIGNED(redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_q <= redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_o(5 downto 0);

    -- redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr(COUNTER,1033)
    -- low=0, high=31, step=1, init=0
    redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_i <= redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_i, 5));

    -- redist23_ChannelIn2_in_4_axis_in_tpl_22_mem(DUALMEM,1032)
    redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_ia <= STD_LOGIC_VECTOR(in_4_axis_in_tpl);
    redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_aa <= redist23_ChannelIn2_in_4_axis_in_tpl_22_wraddr_q;
    redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_ab <= redist23_ChannelIn2_in_4_axis_in_tpl_22_rdcnt_q(4 downto 0);
    redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 32,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_aa,
        data_a => redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_ab,
        q_b => redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_iq
    );
    redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_q <= STD_LOGIC_VECTOR(redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_iq(7 downto 0));

    -- redist22_ChannelIn2_in_3_valid_in_tpl_22(DELAY,983)
    redist22_ChannelIn2_in_3_valid_in_tpl_22 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "NONE", phase => 0, modulus => 1024 )
    PORT MAP ( xin => in_3_valid_in_tpl, xout => redist22_ChannelIn2_in_3_valid_in_tpl_22_q, clk => clk, aclr => areset, ena => '1' );

    -- redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt(ADD,1031)
    redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_q);
    redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist21_ChannelIn2_in_2_dc_tpl_22_offset_q);
    redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_a) + UNSIGNED(redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_q <= redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_o(5 downto 0);

    -- redist21_ChannelIn2_in_2_dc_tpl_22_wraddr(COUNTER,1029)
    -- low=0, high=31, step=1, init=0
    redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_i <= redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_q <= STD_LOGIC_VECTOR(RESIZE(redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_i, 5));

    -- redist21_ChannelIn2_in_2_dc_tpl_22_mem(DUALMEM,1028)
    redist21_ChannelIn2_in_2_dc_tpl_22_mem_ia <= STD_LOGIC_VECTOR(in_2_dc_tpl);
    redist21_ChannelIn2_in_2_dc_tpl_22_mem_aa <= redist21_ChannelIn2_in_2_dc_tpl_22_wraddr_q;
    redist21_ChannelIn2_in_2_dc_tpl_22_mem_ab <= redist21_ChannelIn2_in_2_dc_tpl_22_rdcnt_q(4 downto 0);
    redist21_ChannelIn2_in_2_dc_tpl_22_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 8,
        widthad_b => 5,
        numwords_b => 32,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_sclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => redist21_ChannelIn2_in_2_dc_tpl_22_mem_aa,
        data_a => redist21_ChannelIn2_in_2_dc_tpl_22_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist21_ChannelIn2_in_2_dc_tpl_22_mem_ab,
        q_b => redist21_ChannelIn2_in_2_dc_tpl_22_mem_iq
    );
    redist21_ChannelIn2_in_2_dc_tpl_22_mem_q <= STD_LOGIC_VECTOR(redist21_ChannelIn2_in_2_dc_tpl_22_mem_iq(7 downto 0));

    -- redist20_ChannelIn2_in_1_dv_tpl_22(DELAY,981)
    redist20_ChannelIn2_in_1_dv_tpl_22 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => in_1_dv_tpl, xout => redist20_ChannelIn2_in_1_dv_tpl_22_q, clk => clk, aclr => areset, ena => '1' );

    -- ChannelOut1_vunroll_x(PORTOUT,78)@22 + 1
    out_1_qv_tpl <= redist20_ChannelIn2_in_1_dv_tpl_22_q;
    out_2_qc_tpl <= redist21_ChannelIn2_in_2_dc_tpl_22_mem_q;
    out_3_valid_out_tpl <= redist22_ChannelIn2_in_3_valid_in_tpl_22_q;
    out_4_axis_out_tpl <= redist23_ChannelIn2_in_4_axis_in_tpl_22_mem_q;
    out_5_Valpha_tpl <= redist15_Convert2_0_sel_x_b_7_mem_q;
    out_6_Vbeta_tpl <= redist14_Convert2_1_sel_x_b_7_mem_q;
    out_7_IntegralD_out_tpl <= redist10_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_q;
    out_8_IntegralQ_out_tpl <= redist12_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_12_mem_q;
    out_9_Iq_tpl <= redist16_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_16_mem_q;
    out_10_Id_tpl <= redist17_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_16_mem_q;
    out_11_uvw_0_tpl <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q;
    out_11_uvw_1_tpl <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q;
    out_11_uvw_2_tpl <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q;
    out_12_ready_tpl <= VCC_q;

END normal;
