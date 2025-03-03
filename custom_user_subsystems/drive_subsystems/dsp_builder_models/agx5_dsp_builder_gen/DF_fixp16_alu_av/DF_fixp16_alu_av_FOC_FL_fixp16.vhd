-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 24.1 (Release Build #1f326d321c)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2024 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from DF_fixp16_alu_av_FOC_FL_fixp16
-- VHDL created on Wed Aug  7 11:08:24 2024


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
        out_11_0_uvw_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_11_1_uvw_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_11_2_uvw_tpl : out std_logic_vector(15 downto 0);  -- ufix16
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
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_a : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_b : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_o : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_a : STD_LOGIC_VECTOR (36 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_b : STD_LOGIC_VECTOR (36 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_o : STD_LOGIC_VECTOR (36 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_a : STD_LOGIC_VECTOR (36 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_b : STD_LOGIC_VECTOR (36 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_o : STD_LOGIC_VECTOR (36 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_a : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_b : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_o : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_a : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_b : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_o : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_n : STD_LOGIC_VECTOR (0 downto 0);
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
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_a : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_o : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q : STD_LOGIC_VECTOR (15 downto 0);
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
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_q : STD_LOGIC_VECTOR (1 downto 0);
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
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q : STD_LOGIC_VECTOR (0 downto 0);
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
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_n : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q : STD_LOGIC_VECTOR (21 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
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
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o : STD_LOGIC_VECTOR (17 downto 0);
    signal dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_c : STD_LOGIC_VECTOR (0 downto 0);
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
    signal aPostPad_uid285_Trig_q_const_q : STD_LOGIC_VECTOR (8 downto 0);
    signal cstPiO4Cosr_uid300_Trig_b_const_q : STD_LOGIC_VECTOR (13 downto 0);
    signal aPostPad_uid304_Trig_q_const_q : STD_LOGIC_VECTOR (13 downto 0);
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
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sR_bottomExtension_uid496_Mult_q : STD_LOGIC_VECTOR (10 downto 0);
    signal sR_topExtension_uid497_Mult_q : STD_LOGIC_VECTOR (4 downto 0);
    signal sR_mergedSignalTMB_uid498_Mult_q : STD_LOGIC_VECTOR (31 downto 0);
    signal xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sR_topExtension_uid539_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal sR_mergedSignalTMB_uid540_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal padBCst_uid575_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (3 downto 0);
    signal bPostPad_uid576_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (19 downto 0);
    signal sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a : STD_LOGIC_VECTOR (20 downto 0);
    signal sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (20 downto 0);
    signal sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o : STD_LOGIC_VECTOR (20 downto 0);
    signal sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (20 downto 0);
    signal lowRangeA_uid580_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_in : STD_LOGIC_VECTOR (2 downto 0);
    signal lowRangeA_uid580_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal highABits_uid581_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (12 downto 0);
    signal addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a : STD_LOGIC_VECTOR (16 downto 0);
    signal addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (16 downto 0);
    signal addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o : STD_LOGIC_VECTOR (16 downto 0);
    signal addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (16 downto 0);
    signal add_uid583_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (19 downto 0);
    signal padBCst_uid585_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal bPostPad_uid586_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (25 downto 0);
    signal a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a : STD_LOGIC_VECTOR (26 downto 0);
    signal a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (26 downto 0);
    signal a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o : STD_LOGIC_VECTOR (26 downto 0);
    signal a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (26 downto 0);
    signal xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sR_topExtension_uid592_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (4 downto 0);
    signal sR_mergedSignalTM_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q : STD_LOGIC_VECTOR (31 downto 0);
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
    signal bPostPad_uid692_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (34 downto 0);
    signal sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (34 downto 0);
    signal sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (34 downto 0);
    signal sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lowRangeB_uid701_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid701_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid702_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (29 downto 0);
    signal addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal add_uid704_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (34 downto 0);
    signal lowRangeB_uid707_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (2 downto 0);
    signal lowRangeB_uid707_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (2 downto 0);
    signal highBBits_uid708_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (28 downto 0);
    signal addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (32 downto 0);
    signal addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (32 downto 0);
    signal add_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (35 downto 0);
    signal aPostPad_uid714_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (35 downto 0);
    signal sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (36 downto 0);
    signal sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (36 downto 0);
    signal sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (36 downto 0);
    signal sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (36 downto 0);
    signal bPostPad_uid718_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (38 downto 0);
    signal a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (39 downto 0);
    signal a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (39 downto 0);
    signal a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (39 downto 0);
    signal a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (39 downto 0);
    signal lowRangeB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (4 downto 0);
    signal lowRangeB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (4 downto 0);
    signal highBBits_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (29 downto 0);
    signal a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (35 downto 0);
    signal a_subconst_157_uid724_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (40 downto 0);
    signal aPostPad_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (40 downto 0);
    signal a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (41 downto 0);
    signal lowRangeB_uid730_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (8 downto 0);
    signal lowRangeB_uid730_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (8 downto 0);
    signal highBBits_uid731_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (30 downto 0);
    signal a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (41 downto 0);
    signal a_subconst_80429_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (50 downto 0);
    signal lowRangeB_uid735_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (9 downto 0);
    signal lowRangeB_uid735_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (9 downto 0);
    signal highBBits_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (36 downto 0);
    signal a_subconst_9459_uid738_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (46 downto 0);
    signal lowRangeB_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (17 downto 0);
    signal lowRangeB_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal highBBits_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (32 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (47 downto 0);
    signal a_subconst_2479700525_uid743_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q : STD_LOGIC_VECTOR (65 downto 0);
    signal sR_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in : STD_LOGIC_VECTOR (63 downto 0);
    signal sR_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_qint : STD_LOGIC_VECTOR (48 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_a : STD_LOGIC_VECTOR (50 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_b : STD_LOGIC_VECTOR (50 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_o : STD_LOGIC_VECTOR (50 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_q : STD_LOGIC_VECTOR (49 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2_q : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_q : STD_LOGIC_VECTOR (48 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_qint : STD_LOGIC_VECTOR (48 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_a : STD_LOGIC_VECTOR (50 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_b : STD_LOGIC_VECTOR (50 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_o : STD_LOGIC_VECTOR (50 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_q : STD_LOGIC_VECTOR (49 downto 0);
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
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_reset : std_logic;
    type DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype is array(NATURAL range <>) of SIGNED(15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_c0 : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_s0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_qq0 : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_reset : std_logic;
    type DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ahtype is array(NATURAL range <>) of SIGNED(18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ah : signal is true;
    type DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_chtype is array(NATURAL range <>) of SIGNED(16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_chtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_a0 : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_c0 : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_chtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ah : signal is true;
    type DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_chtype is array(NATURAL range <>) of SIGNED(13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_chtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_a0 : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_c0 : STD_LOGIC_VECTOR (13 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_s0 : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_qq0 : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_q : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_chtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ch : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_a0 : STD_LOGIC_VECTOR (18 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_c0 : STD_LOGIC_VECTOR (16 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena1 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena2 : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_reset : std_logic;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ah : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_chtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ah : signal is true;
    signal DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ch : DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_chtype(0 to 0);
    attribute preserve_syn_only of DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ch : signal is true;
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
    signal redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q_1_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist2_muxSelSin_uid367_Trig2_q_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist3_oneOverFourWhenOct_uid335_Trig2_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_muxSelSin_uid320_Trig_q_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_oneOverFourWhenOct_uid288_Trig_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist9_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b_1_q : STD_LOGIC_VECTOR (20 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_delay_0 : STD_LOGIC_VECTOR (15 downto 0);
    signal redist17_ChannelIn2_in_1_dv_tpl_26_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_ChannelIn2_in_3_valid_in_tpl_26_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_ChannelIn2_in_5_Iu_tpl_2_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist21_ChannelIn2_in_5_Iu_tpl_2_delay_0 : STD_LOGIC_VECTOR (15 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_reset0 : std_logic;
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i : signal is true;
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_offset_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_reset0 : std_logic;
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i : signal is true;
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_mem_reset0 : std_logic;
    signal redist11_Convert2_1_sel_x_b_8_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist11_Convert2_1_sel_x_b_8_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist11_Convert2_1_sel_x_b_8_wraddr_i : signal is true;
    signal redist11_Convert2_1_sel_x_b_8_offset_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist11_Convert2_1_sel_x_b_8_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_mem_reset0 : std_logic;
    signal redist12_Convert2_0_sel_x_b_7_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist12_Convert2_0_sel_x_b_7_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist12_Convert2_0_sel_x_b_7_wraddr_i : signal is true;
    signal redist12_Convert2_0_sel_x_b_7_offset_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist12_Convert2_0_sel_x_b_7_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_reset0 : std_logic;
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_i : UNSIGNED (4 downto 0) := "11111";
    attribute preserve_syn_only of redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_i : signal is true;
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_offset_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_a : STD_LOGIC_VECTOR (5 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_o : STD_LOGIC_VECTOR (5 downto 0);
    signal redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_reset0 : std_logic;
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_i : UNSIGNED (4 downto 0) := "11111";
    attribute preserve_syn_only of redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_i : signal is true;
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_a : STD_LOGIC_VECTOR (5 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_o : STD_LOGIC_VECTOR (5 downto 0);
    signal redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist15_Convert4_sel_x_b_11_mem_reset0 : std_logic;
    signal redist15_Convert4_sel_x_b_11_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist15_Convert4_sel_x_b_11_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_Convert4_sel_x_b_11_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_Convert4_sel_x_b_11_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist15_Convert4_sel_x_b_11_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist15_Convert4_sel_x_b_11_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist15_Convert4_sel_x_b_11_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist15_Convert4_sel_x_b_11_wraddr_i : signal is true;
    signal redist15_Convert4_sel_x_b_11_offset_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist15_Convert4_sel_x_b_11_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist15_Convert4_sel_x_b_11_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist15_Convert4_sel_x_b_11_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist15_Convert4_sel_x_b_11_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist16_Convert1_sel_x_b_11_mem_reset0 : std_logic;
    signal redist16_Convert1_sel_x_b_11_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist16_Convert1_sel_x_b_11_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_Convert1_sel_x_b_11_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist16_Convert1_sel_x_b_11_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist16_Convert1_sel_x_b_11_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist16_Convert1_sel_x_b_11_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist16_Convert1_sel_x_b_11_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist16_Convert1_sel_x_b_11_wraddr_i : signal is true;
    signal redist16_Convert1_sel_x_b_11_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist16_Convert1_sel_x_b_11_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist16_Convert1_sel_x_b_11_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist16_Convert1_sel_x_b_11_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_mem_reset0 : std_logic;
    signal redist18_ChannelIn2_in_2_dc_tpl_26_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_i : UNSIGNED (4 downto 0) := "11111";
    attribute preserve_syn_only of redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_i : signal is true;
    signal redist18_ChannelIn2_in_2_dc_tpl_26_offset_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_a : STD_LOGIC_VECTOR (5 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_o : STD_LOGIC_VECTOR (5 downto 0);
    signal redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_reset0 : std_logic;
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_i : UNSIGNED (4 downto 0) := "11111";
    attribute preserve_syn_only of redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_i : signal is true;
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_a : STD_LOGIC_VECTOR (5 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_o : STD_LOGIC_VECTOR (5 downto 0);
    signal redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_mem_reset0 : std_logic;
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_i : signal is true;
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_reset0 : std_logic;
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_i : signal is true;
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_offset_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_reset0 : std_logic;
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_i : UNSIGNED (3 downto 0) := "1111";
    attribute preserve_syn_only of redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_i : signal is true;
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_a : STD_LOGIC_VECTOR (4 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_o : STD_LOGIC_VECTOR (4 downto 0);
    signal redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_mem_reset0 : std_logic;
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_i : signal is true;
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_mem_reset0 : std_logic;
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_i : signal is true;
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_reset0 : std_logic;
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_i : signal is true;
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_mem_reset0 : std_logic;
    signal redist28_ChannelIn2_in_14_Max_tpl_18_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_i : UNSIGNED (4 downto 0) := "11111";
    attribute preserve_syn_only of redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_i : signal is true;
    signal redist28_ChannelIn2_in_14_Max_tpl_18_offset_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_a : STD_LOGIC_VECTOR (5 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_o : STD_LOGIC_VECTOR (5 downto 0);
    signal redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_mem_reset0 : std_logic;
    signal redist29_ChannelIn2_in_14_Max_tpl_25_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    -- Initial-value here is arbitrary, but a resolved value is necessary for simulation.
    signal redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_i : UNSIGNED (2 downto 0) := "111";
    attribute preserve_syn_only of redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_i : signal is true;
    signal redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_a : STD_LOGIC_VECTOR (3 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_o : STD_LOGIC_VECTOR (3 downto 0);
    signal redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- redist12_Convert2_0_sel_x_b_7_offset(CONSTANT,906)
    redist12_Convert2_0_sel_x_b_7_offset_q <= "100";

    -- redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt(ADD,963)
    redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_q);
    redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist12_Convert2_0_sel_x_b_7_offset_q);
    redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_a) + UNSIGNED(redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_q <= redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_o(3 downto 0);

    -- redist28_ChannelIn2_in_14_Max_tpl_18_offset(CONSTANT,958)
    redist28_ChannelIn2_in_14_Max_tpl_18_offset_q <= "10001";

    -- redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt(ADD,959)
    redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_q);
    redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist28_ChannelIn2_in_14_Max_tpl_18_offset_q);
    redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_a) + UNSIGNED(redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_q <= redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_o(5 downto 0);

    -- redist28_ChannelIn2_in_14_Max_tpl_18_wraddr(COUNTER,957)
    -- low=0, high=31, step=1, init=0
    redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_i <= redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_i, 5)));

    -- redist28_ChannelIn2_in_14_Max_tpl_18_mem(DUALMEM,956)
    redist28_ChannelIn2_in_14_Max_tpl_18_mem_ia <= STD_LOGIC_VECTOR(in_14_Max_tpl);
    redist28_ChannelIn2_in_14_Max_tpl_18_mem_aa <= redist28_ChannelIn2_in_14_Max_tpl_18_wraddr_q;
    redist28_ChannelIn2_in_14_Max_tpl_18_mem_ab <= redist28_ChannelIn2_in_14_Max_tpl_18_rdcnt_q(4 downto 0);
    redist28_ChannelIn2_in_14_Max_tpl_18_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 16,
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
        address_a => redist28_ChannelIn2_in_14_Max_tpl_18_mem_aa,
        data_a => redist28_ChannelIn2_in_14_Max_tpl_18_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist28_ChannelIn2_in_14_Max_tpl_18_mem_ab,
        q_b => redist28_ChannelIn2_in_14_Max_tpl_18_mem_iq
    );
    redist28_ChannelIn2_in_14_Max_tpl_18_mem_q <= redist28_ChannelIn2_in_14_Max_tpl_18_mem_iq(15 downto 0);

    -- redist29_ChannelIn2_in_14_Max_tpl_25_wraddr(COUNTER,961)
    -- low=0, high=7, step=1, init=0
    redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_i <= redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_i, 3)));

    -- redist29_ChannelIn2_in_14_Max_tpl_25_mem(DUALMEM,960)
    redist29_ChannelIn2_in_14_Max_tpl_25_mem_ia <= STD_LOGIC_VECTOR(redist28_ChannelIn2_in_14_Max_tpl_18_mem_q);
    redist29_ChannelIn2_in_14_Max_tpl_25_mem_aa <= redist29_ChannelIn2_in_14_Max_tpl_25_wraddr_q;
    redist29_ChannelIn2_in_14_Max_tpl_25_mem_ab <= redist29_ChannelIn2_in_14_Max_tpl_25_rdcnt_q(2 downto 0);
    redist29_ChannelIn2_in_14_Max_tpl_25_mem_dmem : altera_syncram
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
        address_a => redist29_ChannelIn2_in_14_Max_tpl_25_mem_aa,
        data_a => redist29_ChannelIn2_in_14_Max_tpl_25_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist29_ChannelIn2_in_14_Max_tpl_25_mem_ab,
        q_b => redist29_ChannelIn2_in_14_Max_tpl_25_mem_iq
    );
    redist29_ChannelIn2_in_14_Max_tpl_25_mem_q <= redist29_ChannelIn2_in_14_Max_tpl_25_mem_iq(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias(CONSTANT,832)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q <= "01";

    -- padBCst_uid575_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(CONSTANT,574)
    padBCst_uid575_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= "0000";

    -- bPostPad_uid718_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,717)@23
    bPostPad_uid718_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & padBCst_uid575_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- sinPiXRF_topExtension_uid309_Trig(CONSTANT,308)
    sinPiXRF_topExtension_uid309_Trig_q <= "00";

    -- bPostPad_uid692_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,691)@23
    bPostPad_uid692_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b & sinPiXRF_topExtension_uid309_Trig_q;

    -- redist15_Convert4_sel_x_b_11_offset(CONSTANT,918)
    redist15_Convert4_sel_x_b_11_offset_q <= "1000";

    -- redist15_Convert4_sel_x_b_11_rdcnt(ADD,919)
    redist15_Convert4_sel_x_b_11_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist15_Convert4_sel_x_b_11_wraddr_q);
    redist15_Convert4_sel_x_b_11_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist15_Convert4_sel_x_b_11_offset_q);
    redist15_Convert4_sel_x_b_11_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist15_Convert4_sel_x_b_11_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist15_Convert4_sel_x_b_11_rdcnt_a) + UNSIGNED(redist15_Convert4_sel_x_b_11_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist15_Convert4_sel_x_b_11_rdcnt_q <= redist15_Convert4_sel_x_b_11_rdcnt_o(4 downto 0);

    -- cstPiO4Cosr_uid300_Trig_b_const(CONSTANT,432)
    cstPiO4Cosr_uid300_Trig_b_const_q <= "01011010100001";

    -- aPostPad_uid285_Trig_q_const(CONSTANT,430)
    aPostPad_uid285_Trig_q_const_q <= "100000000";

    -- y1Full_uid333_Trig2(SUB,332)@0
    y1Full_uid333_Trig2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid285_Trig_q_const_q));
    y1Full_uid333_Trig2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00" & y0_uid329_Trig2_b));
    y1Full_uid333_Trig2_o <= STD_LOGIC_VECTOR(SIGNED(y1Full_uid333_Trig2_a) - SIGNED(y1Full_uid333_Trig2_b));
    y1Full_uid333_Trig2_q <= y1Full_uid333_Trig2_o(9 downto 0);

    -- y1_uid336_Trig2(BITSELECT,335)@0
    y1_uid336_Trig2_in <= y1Full_uid333_Trig2_q(7 downto 0);
    y1_uid336_Trig2_b <= y1_uid336_Trig2_in(7 downto 0);

    -- sR_topExtension_uid497_Mult(CONSTANT,496)
    sR_topExtension_uid497_Mult_q <= "00000";

    -- sR_bottomExtension_uid496_Mult(CONSTANT,495)
    sR_bottomExtension_uid496_Mult_q <= "00000000000";

    -- sR_mergedSignalTMB_uid498_Mult(BITJOIN,497)@0
    sR_mergedSignalTMB_uid498_Mult_q <= sR_topExtension_uid497_Mult_q & in_10_phi_el_tpl & sR_bottomExtension_uid496_Mult_q;

    -- Mult_PostCast_primWireOut_rnd_sel(BITSELECT,476)@0
    Mult_PostCast_primWireOut_rnd_sel_b <= STD_LOGIC_VECTOR(sR_mergedSignalTMB_uid498_Mult_q(31 downto 16));

    -- Const1(CONSTANT,65)
    Const1_q <= "0000001000000000";

    -- Sub1(SUB,74)@0
    Sub1_a <= STD_LOGIC_VECTOR(Const1_q);
    Sub1_b <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b);
    Sub1_o <= STD_LOGIC_VECTOR(SIGNED(Sub1_a) - SIGNED(Sub1_b));
    Sub1_q <= Sub1_o(15 downto 0);

    -- y0_uid329_Trig2(BITSELECT,328)@0
    y0_uid329_Trig2_in <= Sub1_q(7 downto 0);
    y0_uid329_Trig2_b <= y0_uid329_Trig2_in(7 downto 0);

    -- o_uid328_Trig2(BITSELECT,327)@0
    o_uid328_Trig2_in <= STD_LOGIC_VECTOR(Sub1_q(8 downto 0));
    o_uid328_Trig2_b <= STD_LOGIC_VECTOR(o_uid328_Trig2_in(8 downto 8));

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

    -- cosPiAT_uid342_Trig2_lutmem(DUALMEM,815)@0 + 2
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
    cosPiAT_uid342_Trig2_lutmem_r <= cosPiAT_uid342_Trig2_lutmem_ir(13 downto 0);

    -- oneOverFourPosition_uid334_Trig2(BITSELECT,333)@0
    oneOverFourPosition_uid334_Trig2_in <= STD_LOGIC_VECTOR(y1Full_uid333_Trig2_q(8 downto 0));
    oneOverFourPosition_uid334_Trig2_b <= STD_LOGIC_VECTOR(oneOverFourPosition_uid334_Trig2_in(8 downto 8));

    -- oneOverFourWhenOct_uid335_Trig2(LOGICAL,334)@0 + 1
    oneOverFourWhenOct_uid335_Trig2_qi <= o_uid328_Trig2_b and oneOverFourPosition_uid334_Trig2_b;
    oneOverFourWhenOct_uid335_Trig2_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneOverFourWhenOct_uid335_Trig2_qi, xout => oneOverFourWhenOct_uid335_Trig2_q, clk => clk, aclr => areset, ena => '1' );

    -- redist3_oneOverFourWhenOct_uid335_Trig2_q_2(DELAY,865)
    redist3_oneOverFourWhenOct_uid335_Trig2_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist3_oneOverFourWhenOct_uid335_Trig2_q_2_q <= STD_LOGIC_VECTOR(oneOverFourWhenOct_uid335_Trig2_q);
            END IF;
        END IF;
    END PROCESS;

    -- cosPiA_uid349_Trig2(MUX,348)@2
    cosPiA_uid349_Trig2_s <= redist3_oneOverFourWhenOct_uid335_Trig2_q_2_q;
    cosPiA_uid349_Trig2_combproc: PROCESS (cosPiA_uid349_Trig2_s, cosPiAT_uid342_Trig2_lutmem_r, cstPiO4Cosr_uid300_Trig_b_const_q)
    BEGIN
        CASE (cosPiA_uid349_Trig2_s) IS
            WHEN "0" => cosPiA_uid349_Trig2_q <= cosPiAT_uid342_Trig2_lutmem_r;
            WHEN "1" => cosPiA_uid349_Trig2_q <= cstPiO4Cosr_uid300_Trig_b_const_q;
            WHEN OTHERS => cosPiA_uid349_Trig2_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- aPostPad_uid304_Trig_q_const(CONSTANT,433)
    aPostPad_uid304_Trig_q_const_q <= "00000000000000";

    -- mCosPiXR_uid355_Trig2(SUB,354)@2
    mCosPiXR_uid355_Trig2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid304_Trig_q_const_q));
    mCosPiXR_uid355_Trig2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & cosPiA_uid349_Trig2_q));
    mCosPiXR_uid355_Trig2_o <= STD_LOGIC_VECTOR(SIGNED(mCosPiXR_uid355_Trig2_a) - SIGNED(mCosPiXR_uid355_Trig2_b));
    mCosPiXR_uid355_Trig2_q <= mCosPiXR_uid355_Trig2_o(14 downto 0);

    -- mCosPiXRF_uid365_Trig2(BITSELECT,364)@2
    mCosPiXRF_uid365_Trig2_b <= STD_LOGIC_VECTOR(mCosPiXR_uid355_Trig2_q(14 downto 3));

    -- cosPiXRF_topRange_uid362_Trig2(BITSELECT,361)@2
    cosPiXRF_topRange_uid362_Trig2_b <= cosPiA_uid349_Trig2_q(13 downto 3);

    -- cosPiXRF_mergedSignalTM_uid363_Trig2(BITJOIN,362)@2
    cosPiXRF_mergedSignalTM_uid363_Trig2_q <= GND_q & cosPiXRF_topRange_uid362_Trig2_b;

    -- cstPiO4Sin_uid298_Trig(CONSTANT,297)
    cstPiO4Sin_uid298_Trig_q <= "1011010100001";

    -- sinPiAT_uid339_Trig2_lutmem(DUALMEM,814)@0 + 2
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
    sinPiAT_uid339_Trig2_lutmem_r <= sinPiAT_uid339_Trig2_lutmem_ir(12 downto 0);

    -- sinPiA_uid348_Trig2(MUX,347)@2
    sinPiA_uid348_Trig2_s <= redist3_oneOverFourWhenOct_uid335_Trig2_q_2_q;
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
    mSinPiXR_uid352_Trig2_q <= mSinPiXR_uid352_Trig2_o(14 downto 0);

    -- mSinPiXRF_uid360_Trig2(BITSELECT,359)@2
    mSinPiXRF_uid360_Trig2_b <= STD_LOGIC_VECTOR(mSinPiXR_uid352_Trig2_q(14 downto 3));

    -- sinPiXRF_topRange_uid357_Trig2(BITSELECT,356)@2
    sinPiXRF_topRange_uid357_Trig2_b <= sinPiA_uid348_Trig2_q(12 downto 3);

    -- sinPiXRF_mergedSignalTM_uid358_Trig2(BITJOIN,357)@2
    sinPiXRF_mergedSignalTM_uid358_Trig2_q <= sinPiXRF_topExtension_uid309_Trig_q & sinPiXRF_topRange_uid357_Trig2_b;

    -- h_uid326_Trig2(BITSELECT,325)@0
    h_uid326_Trig2_in <= STD_LOGIC_VECTOR(Sub1_q(10 downto 0));
    h_uid326_Trig2_b <= STD_LOGIC_VECTOR(h_uid326_Trig2_in(10 downto 10));

    -- q_uid327_Trig2(BITSELECT,326)@0
    q_uid327_Trig2_in <= STD_LOGIC_VECTOR(Sub1_q(9 downto 0));
    q_uid327_Trig2_b <= STD_LOGIC_VECTOR(q_uid327_Trig2_in(9 downto 9));

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

    -- redist2_muxSelSin_uid367_Trig2_q_2(DELAY,864)
    redist2_muxSelSin_uid367_Trig2_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist2_muxSelSin_uid367_Trig2_q_2_q <= STD_LOGIC_VECTOR(muxSelSin_uid367_Trig2_q);
            END IF;
        END IF;
    END PROCESS;

    -- outSin_uid369_Trig2(MUX,368)@2
    outSin_uid369_Trig2_s <= redist2_muxSelSin_uid367_Trig2_q_2_q;
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
    Convert4_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(outSin_uid369_Trig2_q(11 downto 0)), 16)));

    -- redist15_Convert4_sel_x_b_11_wraddr(COUNTER,917)
    -- low=0, high=15, step=1, init=0
    redist15_Convert4_sel_x_b_11_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist15_Convert4_sel_x_b_11_wraddr_i <= redist15_Convert4_sel_x_b_11_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist15_Convert4_sel_x_b_11_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist15_Convert4_sel_x_b_11_wraddr_i, 4)));

    -- redist15_Convert4_sel_x_b_11_mem(DUALMEM,916)
    redist15_Convert4_sel_x_b_11_mem_ia <= STD_LOGIC_VECTOR(Convert4_sel_x_b);
    redist15_Convert4_sel_x_b_11_mem_aa <= redist15_Convert4_sel_x_b_11_wraddr_q;
    redist15_Convert4_sel_x_b_11_mem_ab <= redist15_Convert4_sel_x_b_11_rdcnt_q(3 downto 0);
    redist15_Convert4_sel_x_b_11_mem_dmem : altera_syncram
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
        address_a => redist15_Convert4_sel_x_b_11_mem_aa,
        data_a => redist15_Convert4_sel_x_b_11_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist15_Convert4_sel_x_b_11_mem_ab,
        q_b => redist15_Convert4_sel_x_b_11_mem_iq
    );
    redist15_Convert4_sel_x_b_11_mem_q <= redist15_Convert4_sel_x_b_11_mem_iq(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x(CONSTANT,108)
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q <= "0111100110011010";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x(SUB,114)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_o(15 downto 0);

    -- redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_offset(CONSTANT,938)
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_offset_q <= "0111";

    -- redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt(ADD,939)
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_q);
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_offset_q);
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_a) + UNSIGNED(redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_q <= redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_o(4 downto 0);

    -- redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr(COUNTER,937)
    -- low=0, high=15, step=1, init=0
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_i <= redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_i, 4)));

    -- redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem(DUALMEM,936)
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_ia <= STD_LOGIC_VECTOR(in_8_IntegralQ_in_tpl);
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_aa <= redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_wraddr_q;
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_ab <= redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_rdcnt_q(3 downto 0);
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_dmem : altera_syncram
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
        address_a => redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_aa,
        data_a => redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_ab,
        q_b => redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_iq
    );
    redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_q <= redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_iq(15 downto 0);

    -- redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt(ADD,951)
    redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_q);
    redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist12_Convert2_0_sel_x_b_7_offset_q);
    redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_a) + UNSIGNED(redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_q <= redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_o(3 downto 0);

    -- redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr(COUNTER,949)
    -- low=0, high=7, step=1, init=0
    redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_i <= redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_i, 3)));

    -- redist26_ChannelIn2_in_12_Ki_tpl_7_mem(DUALMEM,948)
    redist26_ChannelIn2_in_12_Ki_tpl_7_mem_ia <= STD_LOGIC_VECTOR(in_12_Ki_tpl);
    redist26_ChannelIn2_in_12_Ki_tpl_7_mem_aa <= redist26_ChannelIn2_in_12_Ki_tpl_7_wraddr_q;
    redist26_ChannelIn2_in_12_Ki_tpl_7_mem_ab <= redist26_ChannelIn2_in_12_Ki_tpl_7_rdcnt_q(2 downto 0);
    redist26_ChannelIn2_in_12_Ki_tpl_7_mem_dmem : altera_syncram
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
        address_a => redist26_ChannelIn2_in_12_Ki_tpl_7_mem_aa,
        data_a => redist26_ChannelIn2_in_12_Ki_tpl_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist26_ChannelIn2_in_12_Ki_tpl_7_mem_ab,
        q_b => redist26_ChannelIn2_in_12_Ki_tpl_7_mem_iq
    );
    redist26_ChannelIn2_in_12_Ki_tpl_7_mem_q <= redist26_ChannelIn2_in_12_Ki_tpl_7_mem_iq(15 downto 0);

    -- redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt(ADD,955)
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_q);
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist12_Convert2_0_sel_x_b_7_offset_q);
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_a) + UNSIGNED(redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_q <= redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_o(3 downto 0);

    -- redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr(COUNTER,953)
    -- low=0, high=7, step=1, init=0
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_i <= redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_i, 3)));

    -- redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem(DUALMEM,952)
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_ia <= STD_LOGIC_VECTOR(in_13_I_Sat_Limit_tpl);
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_aa <= redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_wraddr_q;
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_ab <= redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_rdcnt_q(2 downto 0);
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_dmem : altera_syncram
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
        address_a => redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_aa,
        data_a => redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_ab,
        q_b => redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_iq
    );
    redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q <= redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_iq(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x(SUB,100)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_b <= STD_LOGIC_VECTOR(redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q);
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_o(15 downto 0);

    -- redist21_ChannelIn2_in_5_Iu_tpl_2(DELAY,883)
    redist21_ChannelIn2_in_5_Iu_tpl_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist21_ChannelIn2_in_5_Iu_tpl_2_delay_0 <= STD_LOGIC_VECTOR(in_5_Iu_tpl);
                redist21_ChannelIn2_in_5_Iu_tpl_2_q <= redist21_ChannelIn2_in_5_Iu_tpl_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- y1Full_uid286_Trig(SUB,285)@0
    y1Full_uid286_Trig_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & aPostPad_uid285_Trig_q_const_q));
    y1Full_uid286_Trig_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00" & y0_uid282_Trig_b));
    y1Full_uid286_Trig_o <= STD_LOGIC_VECTOR(SIGNED(y1Full_uid286_Trig_a) - SIGNED(y1Full_uid286_Trig_b));
    y1Full_uid286_Trig_q <= y1Full_uid286_Trig_o(9 downto 0);

    -- y1_uid289_Trig(BITSELECT,288)@0
    y1_uid289_Trig_in <= y1Full_uid286_Trig_q(7 downto 0);
    y1_uid289_Trig_b <= y1_uid289_Trig_in(7 downto 0);

    -- y0_uid282_Trig(BITSELECT,281)@0
    y0_uid282_Trig_in <= Mult_PostCast_primWireOut_rnd_sel_b(7 downto 0);
    y0_uid282_Trig_b <= y0_uid282_Trig_in(7 downto 0);

    -- o_uid281_Trig(BITSELECT,280)@0
    o_uid281_Trig_in <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b(8 downto 0));
    o_uid281_Trig_b <= STD_LOGIC_VECTOR(o_uid281_Trig_in(8 downto 8));

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

    -- cosPiAT_uid295_Trig_lutmem(DUALMEM,813)@0 + 2
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
    cosPiAT_uid295_Trig_lutmem_r <= cosPiAT_uid295_Trig_lutmem_ir(13 downto 0);

    -- oneOverFourPosition_uid287_Trig(BITSELECT,286)@0
    oneOverFourPosition_uid287_Trig_in <= STD_LOGIC_VECTOR(y1Full_uid286_Trig_q(8 downto 0));
    oneOverFourPosition_uid287_Trig_b <= STD_LOGIC_VECTOR(oneOverFourPosition_uid287_Trig_in(8 downto 8));

    -- oneOverFourWhenOct_uid288_Trig(LOGICAL,287)@0 + 1
    oneOverFourWhenOct_uid288_Trig_qi <= o_uid281_Trig_b and oneOverFourPosition_uid287_Trig_b;
    oneOverFourWhenOct_uid288_Trig_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => oneOverFourWhenOct_uid288_Trig_qi, xout => oneOverFourWhenOct_uid288_Trig_q, clk => clk, aclr => areset, ena => '1' );

    -- redist5_oneOverFourWhenOct_uid288_Trig_q_2(DELAY,867)
    redist5_oneOverFourWhenOct_uid288_Trig_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist5_oneOverFourWhenOct_uid288_Trig_q_2_q <= STD_LOGIC_VECTOR(oneOverFourWhenOct_uid288_Trig_q);
            END IF;
        END IF;
    END PROCESS;

    -- cosPiA_uid302_Trig(MUX,301)@2
    cosPiA_uid302_Trig_s <= redist5_oneOverFourWhenOct_uid288_Trig_q_2_q;
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
    mCosPiXR_uid308_Trig_q <= mCosPiXR_uid308_Trig_o(14 downto 0);

    -- mCosPiXRF_uid318_Trig(BITSELECT,317)@2
    mCosPiXRF_uid318_Trig_b <= STD_LOGIC_VECTOR(mCosPiXR_uid308_Trig_q(14 downto 3));

    -- cosPiXRF_topRange_uid315_Trig(BITSELECT,314)@2
    cosPiXRF_topRange_uid315_Trig_b <= cosPiA_uid302_Trig_q(13 downto 3);

    -- cosPiXRF_mergedSignalTM_uid316_Trig(BITJOIN,315)@2
    cosPiXRF_mergedSignalTM_uid316_Trig_q <= GND_q & cosPiXRF_topRange_uid315_Trig_b;

    -- sinPiAT_uid292_Trig_lutmem(DUALMEM,812)@0 + 2
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
    sinPiAT_uid292_Trig_lutmem_r <= sinPiAT_uid292_Trig_lutmem_ir(12 downto 0);

    -- sinPiA_uid301_Trig(MUX,300)@2
    sinPiA_uid301_Trig_s <= redist5_oneOverFourWhenOct_uid288_Trig_q_2_q;
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
    mSinPiXR_uid305_Trig_q <= mSinPiXR_uid305_Trig_o(14 downto 0);

    -- mSinPiXRF_uid313_Trig(BITSELECT,312)@2
    mSinPiXRF_uid313_Trig_b <= STD_LOGIC_VECTOR(mSinPiXR_uid305_Trig_q(14 downto 3));

    -- sinPiXRF_topRange_uid310_Trig(BITSELECT,309)@2
    sinPiXRF_topRange_uid310_Trig_b <= sinPiA_uid301_Trig_q(12 downto 3);

    -- sinPiXRF_mergedSignalTM_uid311_Trig(BITJOIN,310)@2
    sinPiXRF_mergedSignalTM_uid311_Trig_q <= sinPiXRF_topExtension_uid309_Trig_q & sinPiXRF_topRange_uid310_Trig_b;

    -- h_uid279_Trig(BITSELECT,278)@0
    h_uid279_Trig_in <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b(10 downto 0));
    h_uid279_Trig_b <= STD_LOGIC_VECTOR(h_uid279_Trig_in(10 downto 10));

    -- q_uid280_Trig(BITSELECT,279)@0
    q_uid280_Trig_in <= STD_LOGIC_VECTOR(Mult_PostCast_primWireOut_rnd_sel_b(9 downto 0));
    q_uid280_Trig_b <= STD_LOGIC_VECTOR(q_uid280_Trig_in(9 downto 9));

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

    -- redist4_muxSelSin_uid320_Trig_q_2(DELAY,866)
    redist4_muxSelSin_uid320_Trig_q_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist4_muxSelSin_uid320_Trig_q_2_q <= STD_LOGIC_VECTOR(muxSelSin_uid320_Trig_q);
            END IF;
        END IF;
    END PROCESS;

    -- outSin_uid322_Trig(MUX,321)@2
    outSin_uid322_Trig_s <= redist4_muxSelSin_uid320_Trig_q_2_q;
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
    Convert1_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(outSin_uid322_Trig_q(11 downto 0)), 16)));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma(CHAINMULTADD,818)@2 + 4
    -- out q@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ah(0) <= RESIZE(SIGNED(Convert1_sel_x_b),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ch(0) <= RESIZE(SIGNED(redist21_ChannelIn2_in_5_Iu_tpl_2_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_rnd_x_sel(BITSELECT,451)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_sel_x(BITSELECT,191)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_rnd_x_sel_b(15 downto 0));

    -- xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITSELECT,589)@0
    xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(26 downto 26));

    -- sR_topExtension_uid592_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,591)@0
    sR_topExtension_uid592_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b & xMSB_uid590_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b;

    -- xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x(BITSELECT,536)@0
    xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b <= STD_LOGIC_VECTOR(in_6_Iw_tpl(15 downto 15));

    -- sR_topExtension_uid539_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x(BITJOIN,538)@0
    sR_topExtension_uid539_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q <= xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b & xMSB_uid537_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_b;

    -- sR_mergedSignalTMB_uid540_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x(BITJOIN,539)@0
    sR_mergedSignalTMB_uid540_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q <= sR_topExtension_uid539_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q & in_6_Iw_tpl & sR_bottomExtension_uid496_Mult_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,454)@0
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(sR_mergedSignalTMB_uid540_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_x_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_sel_x(BITSELECT,194)@0
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_rnd_x_sel_b(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x(ADD,84)@0
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_a <= STD_LOGIC_VECTOR(in_5_Iu_tpl);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain_Mult_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_o(15 downto 0);

    -- highABits_uid581_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITSELECT,580)@0
    highABits_uid581_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(15 downto 3));

    -- addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(ADD,581)@0
    addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 13 => highABits_uid581_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b(12)) & highABits_uid581_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q));
    addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a) + SIGNED(addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o(16 downto 0);

    -- lowRangeA_uid580_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITSELECT,579)@0
    lowRangeA_uid580_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(2 downto 0);
    lowRangeA_uid580_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= lowRangeA_uid580_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_in(2 downto 0);

    -- add_uid583_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,582)@0
    add_uid583_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= addhigh_uid582_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q & lowRangeA_uid580_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b;

    -- padBCst_uid585_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(CONSTANT,584)
    padBCst_uid585_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= "000000";

    -- bPostPad_uid586_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,585)@0
    bPostPad_uid586_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= add_uid583_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q & padBCst_uid585_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- bPostPad_uid576_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,575)@0
    bPostPad_uid576_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q & padBCst_uid575_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(SUB,576)@0
    sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add1_x_q));
    sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((20 downto 20 => bPostPad_uid576_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(19)) & bPostPad_uid576_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q));
    sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a) - SIGNED(sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o(20 downto 0);

    -- a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(SUB,586)@0
    a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 21 => sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(20)) & sub_uid577_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q));
    a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 26 => bPostPad_uid586_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(25)) & bPostPad_uid586_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q));
    a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_a) - SIGNED(a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_b));
    a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_o(26 downto 0);

    -- sR_mergedSignalTM_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x(BITJOIN,593)@0
    sR_mergedSignalTM_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q <= sR_topExtension_uid592_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q & a_subconst_591_uid587_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,455)@0
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(sR_mergedSignalTM_uid594_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x(BITSELECT,195)@0
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_rnd_x_sel_b(15 downto 0));

    -- redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2(DELAY,872)
    redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_delay_0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b);
                redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_q <= redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma(CHAINMULTADD,819)@2 + 4
    -- out q@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ah(0) <= RESIZE(SIGNED(redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_q),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ch(0) <= RESIZE(SIGNED(Convert4_sel_x_b),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_rnd_x_sel(BITSELECT,452)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_sel_x(BITSELECT,192)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_rnd_x_sel_b(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x(SUB,89)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult3_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult2_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_o(15 downto 0);

    -- redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt(ADD,935)
    redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_q);
    redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist12_Convert2_0_sel_x_b_7_offset_q);
    redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_a) + UNSIGNED(redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_q <= redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_o(3 downto 0);

    -- redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr(COUNTER,933)
    -- low=0, high=7, step=1, init=0
    redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_i <= redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_i, 3)));

    -- redist22_ChannelIn2_in_7_Torque_tpl_7_mem(DUALMEM,932)
    redist22_ChannelIn2_in_7_Torque_tpl_7_mem_ia <= STD_LOGIC_VECTOR(in_7_Torque_tpl);
    redist22_ChannelIn2_in_7_Torque_tpl_7_mem_aa <= redist22_ChannelIn2_in_7_Torque_tpl_7_wraddr_q;
    redist22_ChannelIn2_in_7_Torque_tpl_7_mem_ab <= redist22_ChannelIn2_in_7_Torque_tpl_7_rdcnt_q(2 downto 0);
    redist22_ChannelIn2_in_7_Torque_tpl_7_mem_dmem : altera_syncram
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
        address_a => redist22_ChannelIn2_in_7_Torque_tpl_7_mem_aa,
        data_a => redist22_ChannelIn2_in_7_Torque_tpl_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist22_ChannelIn2_in_7_Torque_tpl_7_mem_ab,
        q_b => redist22_ChannelIn2_in_7_Torque_tpl_7_mem_iq
    );
    redist22_ChannelIn2_in_7_Torque_tpl_7_mem_q <= redist22_ChannelIn2_in_7_Torque_tpl_7_mem_iq(15 downto 0);

    -- Sub2_1_x(SUB,179)@7
    Sub2_1_x_a <= STD_LOGIC_VECTOR(redist22_ChannelIn2_in_7_Torque_tpl_7_mem_q);
    Sub2_1_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q);
    Sub2_1_x_o <= STD_LOGIC_VECTOR(SIGNED(Sub2_1_x_a) - SIGNED(Sub2_1_x_b));
    Sub2_1_x_q <= Sub2_1_x_o(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x(COMPARE,201)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q(15)) & redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => Sub2_1_x_q(15)) & Sub2_1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_o(17));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x(MUX,200)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_s, redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q, Sub2_1_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q <= redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q <= Sub2_1_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x(COMPARE,203)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_o(17);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x(MUX,202)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma(CHAINMULTADD,827)@7 + 4
    -- out q@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ch(0) <= RESIZE(SIGNED(redist26_ChannelIn2_in_12_Ki_tpl_7_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,462)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x(BITSELECT,214)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x(ADD,110)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_q(15)) & redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_o(21 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x(COMPARE,222)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x(MUX,221)@12 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
                    WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x(COMPARE,224)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_o(23);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x(MUX,223)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,225)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_mux_x_q(15 downto 0));

    -- redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt(ADD,947)
    redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_q);
    redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist12_Convert2_0_sel_x_b_7_offset_q);
    redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_a) + UNSIGNED(redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_q <= redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_o(3 downto 0);

    -- redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr(COUNTER,945)
    -- low=0, high=7, step=1, init=0
    redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_i <= redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_i, 3)));

    -- redist25_ChannelIn2_in_11_Kp_tpl_7_mem(DUALMEM,944)
    redist25_ChannelIn2_in_11_Kp_tpl_7_mem_ia <= STD_LOGIC_VECTOR(in_11_Kp_tpl);
    redist25_ChannelIn2_in_11_Kp_tpl_7_mem_aa <= redist25_ChannelIn2_in_11_Kp_tpl_7_wraddr_q;
    redist25_ChannelIn2_in_11_Kp_tpl_7_mem_ab <= redist25_ChannelIn2_in_11_Kp_tpl_7_rdcnt_q(2 downto 0);
    redist25_ChannelIn2_in_11_Kp_tpl_7_mem_dmem : altera_syncram
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
        address_a => redist25_ChannelIn2_in_11_Kp_tpl_7_mem_aa,
        data_a => redist25_ChannelIn2_in_11_Kp_tpl_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist25_ChannelIn2_in_11_Kp_tpl_7_mem_ab,
        q_b => redist25_ChannelIn2_in_11_Kp_tpl_7_mem_iq
    );
    redist25_ChannelIn2_in_11_Kp_tpl_7_mem_q <= redist25_ChannelIn2_in_11_Kp_tpl_7_mem_iq(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma(CHAINMULTADD,826)@7 + 4
    -- out q@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_MinMax1_mux_x_q),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ch(0) <= RESIZE(SIGNED(redist25_ChannelIn2_in_11_Kp_tpl_7_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,463)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x(BITSELECT,215)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- redist8_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b_1(DELAY,870)
    redist8_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist8_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b_1_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x(ADD,109)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => redist8_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b_1_q(20)) & redist8_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Mult_PostCast_primWireOut_sel_x_b_1_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_o(21 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x(COMPARE,217)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x(MUX,216)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Add1_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x(COMPARE,219)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_o(23);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x(MUX,218)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,220)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_mux_x_q(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma(CHAINMULTADD,823)@13 + 4
    -- out q@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ch(0) <= RESIZE(SIGNED(redist15_Convert4_sel_x_b_11_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_rnd_x_sel(BITSELECT,458)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x(BITSELECT,198)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- redist16_Convert1_sel_x_b_11_rdcnt(ADD,923)
    redist16_Convert1_sel_x_b_11_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist16_Convert1_sel_x_b_11_wraddr_q);
    redist16_Convert1_sel_x_b_11_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist15_Convert4_sel_x_b_11_offset_q);
    redist16_Convert1_sel_x_b_11_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_Convert1_sel_x_b_11_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist16_Convert1_sel_x_b_11_rdcnt_a) + UNSIGNED(redist16_Convert1_sel_x_b_11_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist16_Convert1_sel_x_b_11_rdcnt_q <= redist16_Convert1_sel_x_b_11_rdcnt_o(4 downto 0);

    -- redist16_Convert1_sel_x_b_11_wraddr(COUNTER,921)
    -- low=0, high=15, step=1, init=0
    redist16_Convert1_sel_x_b_11_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist16_Convert1_sel_x_b_11_wraddr_i <= redist16_Convert1_sel_x_b_11_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist16_Convert1_sel_x_b_11_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist16_Convert1_sel_x_b_11_wraddr_i, 4)));

    -- redist16_Convert1_sel_x_b_11_mem(DUALMEM,920)
    redist16_Convert1_sel_x_b_11_mem_ia <= STD_LOGIC_VECTOR(Convert1_sel_x_b);
    redist16_Convert1_sel_x_b_11_mem_aa <= redist16_Convert1_sel_x_b_11_wraddr_q;
    redist16_Convert1_sel_x_b_11_mem_ab <= redist16_Convert1_sel_x_b_11_rdcnt_q(3 downto 0);
    redist16_Convert1_sel_x_b_11_mem_dmem : altera_syncram
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
        address_a => redist16_Convert1_sel_x_b_11_mem_aa,
        data_a => redist16_Convert1_sel_x_b_11_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist16_Convert1_sel_x_b_11_mem_ab,
        q_b => redist16_Convert1_sel_x_b_11_mem_iq
    );
    redist16_Convert1_sel_x_b_11_mem_q <= redist16_Convert1_sel_x_b_11_mem_iq(15 downto 0);

    -- redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt(ADD,943)
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_q);
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist23_ChannelIn2_in_8_IntegralQ_in_tpl_12_offset_q);
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_a) + UNSIGNED(redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_q <= redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_o(4 downto 0);

    -- redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr(COUNTER,941)
    -- low=0, high=15, step=1, init=0
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_i <= redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_i, 4)));

    -- redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem(DUALMEM,940)
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_ia <= STD_LOGIC_VECTOR(in_9_IntegralD_in_tpl);
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_aa <= redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_wraddr_q;
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_ab <= redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_rdcnt_q(3 downto 0);
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_dmem : altera_syncram
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
        address_a => redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_aa,
        data_a => redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_ab,
        q_b => redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_iq
    );
    redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_q <= redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_iq(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma(CHAINMULTADD,817)@2 + 4
    -- out q@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ah(0) <= RESIZE(SIGNED(redist10_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_PostCast_primWireOut_sel_x_b_2_q),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ch(0) <= RESIZE(SIGNED(Convert1_sel_x_b),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,450)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_sel_x(BITSELECT,190)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma(CHAINMULTADD,816)@2 + 4
    -- out q@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ah(0) <= RESIZE(SIGNED(redist21_ChannelIn2_in_5_Iu_tpl_2_q),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ch(0) <= RESIZE(SIGNED(Convert4_sel_x_b),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,453)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_sel_x(BITSELECT,193)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x(ADD,83)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Mult1_PostCast_primWireOut_sel_x_b);
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_o(15 downto 0);

    -- Sub2_0_x(SUB,178)@7
    Sub2_0_x_a <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q);
    Sub2_0_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q);
    Sub2_0_x_o <= STD_LOGIC_VECTOR(SIGNED(Sub2_0_x_a) - SIGNED(Sub2_0_x_b));
    Sub2_0_x_q <= Sub2_0_x_o(15 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x(COMPARE,207)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q(15)) & redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => Sub2_0_x_q(15)) & Sub2_0_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_o(17));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x(MUX,206)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_s, redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q, Sub2_0_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q <= redist27_ChannelIn2_in_13_I_Sat_Limit_tpl_7_mem_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q <= Sub2_0_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x(COMPARE,209)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_o(17);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x(MUX,208)@7
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate1_Sub_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma(CHAINMULTADD,825)@7 + 4
    -- out q@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ch(0) <= RESIZE(SIGNED(redist26_ChannelIn2_in_12_Ki_tpl_7_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,460)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x(BITSELECT,212)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x(ADD,105)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_q(15)) & redist24_ChannelIn2_in_9_IntegralD_in_tpl_12_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_o(21 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x(COMPARE,232)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x(MUX,231)@12 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
                    WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x(COMPARE,234)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_o(23);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x(MUX,233)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,235)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_mux_x_q(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma(CHAINMULTADD,824)@7 + 4
    -- out q@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_Fixed_Saturate2_MinMax1_mux_x_q),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ch(0) <= RESIZE(SIGNED(redist25_ChannelIn2_in_11_Kp_tpl_7_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,461)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x(BITSELECT,213)@12
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- redist9_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b_1(DELAY,871)
    redist9_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist9_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b_1_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x(ADD,104)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => redist9_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b_1_q(20)) & redist9_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Mult_PostCast_primWireOut_sel_x_b_1_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_o(21 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x(COMPARE,227)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_o(23));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x(MUX,226)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_signBit_x_n;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_const1_x_q);
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Add1_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x(COMPARE,229)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 22 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q(21)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((23 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_c(0) <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_o(23);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x(MUX,228)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_signBit_x_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax_mux_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q <= STD_LOGIC_VECTOR((21 downto 16 => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q(15)) & DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_Sub_x_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x(BITSELECT,230)@13
    DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_mux_x_q(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma(CHAINMULTADD,822)@13 + 4
    -- out q@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ch(0) <= RESIZE(SIGNED(redist16_Convert1_sel_x_b_11_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_rnd_x_sel(BITSELECT,457)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x(BITSELECT,197)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x(ADD,94)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult2_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult3_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_o(21 downto 0);

    -- Convert2_1_sel_x(BITSELECT,189)@18
    Convert2_1_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Add_x_q(21 downto 0)), 32)));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged(BITSELECT,860)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_b <= STD_LOGIC_VECTOR(Convert2_1_sel_x_b(17 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_c <= STD_LOGIC_VECTOR(Convert2_1_sel_x_b(31 downto 18));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4(BITJOIN,790)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q <= GND_q & redist28_ChannelIn2_in_14_Max_tpl_18_mem_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma(CHAINMULTADD,831)@18 + 4
    -- out q@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q),17);
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ch(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_c),14);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1(BITSHIFT,809)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im5_cma_q & "000000000000000000";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_qint(48 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2(BITJOIN,801)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2_q <= GND_q & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bs1_bit_select_merged_b;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma(CHAINMULTADD,830)@18 + 4
    -- out q@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_bjA2_q),19);
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ch(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q),17);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0(ADD,811)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_im0_cma_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((50 downto 49 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_q(48)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_align_1_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_o(49 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x(BITSELECT,271)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_in <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_1_x_sums_result_add_0_0_q(47 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_in(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc(BITSHIFT,838)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_1_sel_x_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_qint(32 downto 14);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add(ADD,839)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 19 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_q(18)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_trunc_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_o(19 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift(BITSHIFT,840)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_qint(19 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x(BITSELECT,269)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_rnd_x_shift_q(18 downto 0)), 32)));

    -- sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,692)@23
    sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => bPostPad_uid692_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(33)) & bPostPad_uid692_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(34 downto 0);

    -- a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,718)@23
    a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 35 => sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34)) & sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 39 => bPostPad_uid718_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(38)) & bPostPad_uid718_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(39 downto 0);

    -- highBBits_uid731_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,730)@23
    highBBits_uid731_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(39 downto 9));

    -- highBBits_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,721)@23
    highBBits_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34 downto 5));

    -- highBBits_uid702_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,701)@23
    highBBits_uid702_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31 downto 2));

    -- addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,702)@23
    addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 30 => highBBits_uid702_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(29)) & highBBits_uid702_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(32 downto 0);

    -- lowRangeB_uid701_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,700)@23
    lowRangeB_uid701_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(1 downto 0);
    lowRangeB_uid701_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= lowRangeB_uid701_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(1 downto 0);

    -- add_uid704_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,703)@23
    add_uid704_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= addsumAHighB_uid703_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid701_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,722)@23
    a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => add_uid704_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34)) & add_uid704_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 30 => highBBits_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(29)) & highBBits_uid722_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(35 downto 0);

    -- lowRangeB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,720)@23
    lowRangeB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(4 downto 0);
    lowRangeB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= lowRangeB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(4 downto 0);

    -- a_subconst_157_uid724_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,723)@23
    a_subconst_157_uid724_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_157_sumAHighB_uid723_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid721_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,731)@23
    a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 41 => a_subconst_157_uid724_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(40)) & a_subconst_157_uid724_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 31 => highBBits_uid731_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(30)) & highBBits_uid731_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(41 downto 0);

    -- lowRangeB_uid730_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,729)@23
    lowRangeB_uid730_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= a_subconst_45_uid719_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(8 downto 0);
    lowRangeB_uid730_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= lowRangeB_uid730_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(8 downto 0);

    -- a_subconst_80429_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,732)@23
    a_subconst_80429_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_80429_sumAHighB_uid732_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid730_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- highBBits_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,740)@23
    highBBits_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(a_subconst_80429_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(50 downto 18));

    -- aPostPad_uid714_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,713)@23
    aPostPad_uid714_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b & padBCst_uid575_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,714)@23
    sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 36 => aPostPad_uid714_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(35)) & aPostPad_uid714_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(36 downto 0);

    -- aPostPad_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,726)@23
    aPostPad_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= sub_uid715_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & padBCst_uid575_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_FixedGain1_Mult_x_q;

    -- a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(SUB,727)@23
    a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 41 => aPostPad_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(40)) & aPostPad_uid727_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((41 downto 35 => sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(34)) & sub_uid693_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) - SIGNED(a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(41 downto 0);

    -- highBBits_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,735)@23
    highBBits_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(41 downto 10));

    -- highBBits_uid708_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,707)@23
    highBBits_uid708_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31 downto 3));

    -- addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,708)@23
    addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b));
    addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 29 => highBBits_uid708_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(28)) & highBBits_uid708_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(32 downto 0);

    -- lowRangeB_uid707_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,706)@23
    lowRangeB_uid707_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(2 downto 0);
    lowRangeB_uid707_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= lowRangeB_uid707_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(2 downto 0);

    -- add_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,709)@23
    add_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= addsumAHighB_uid709_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid707_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,736)@23
    a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 36 => add_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(35)) & add_uid710_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 32 => highBBits_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(31)) & highBBits_uid736_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(36 downto 0);

    -- lowRangeB_uid735_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,734)@23
    lowRangeB_uid735_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= a_subconst_243_uid728_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(9 downto 0);
    lowRangeB_uid735_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= lowRangeB_uid735_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(9 downto 0);

    -- a_subconst_9459_uid738_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,737)@23
    a_subconst_9459_uid738_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_9459_sumAHighB_uid737_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid735_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(ADD,741)@23
    a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((47 downto 47 => a_subconst_9459_uid738_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(46)) & a_subconst_9459_uid738_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q));
    a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((47 downto 33 => highBBits_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b(32)) & highBBits_uid741_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_a) + SIGNED(a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b));
    a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_o(47 downto 0);

    -- lowRangeB_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,739)@23
    lowRangeB_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= a_subconst_80429_uid733_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(17 downto 0);
    lowRangeB_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= lowRangeB_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(17 downto 0);

    -- a_subconst_2479700525_uid743_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITJOIN,742)@23
    a_subconst_2479700525_uid743_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q <= a_subconst_2479700525_sumAHighB_uid742_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q & lowRangeB_uid740_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;

    -- sR_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x(BITSELECT,745)@23
    sR_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in <= STD_LOGIC_VECTOR(a_subconst_2479700525_uid743_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_q(63 downto 0));
    sR_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b <= STD_LOGIC_VECTOR(sR_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_in(63 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc(BITSHIFT,855)@23
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_qint <= sR_uid746_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Mult_x_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_qint(63 downto 31);

    -- redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1(DELAY,862)
    redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q);
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add(ADD,856)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q(32)) & redist0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_trunc_q_1_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_o(33 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift(BITSHIFT,857)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_qint(33 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x(BITSELECT,253)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_rnd_x_shift_q(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x(SUB,127)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 1 => GND_q(0)) & GND_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_o(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_PostCast_primWireOut_sel_x(BITSELECT,243)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_x_q(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1(BITSHIFT,274)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate3_PostCast_primWireOut_sel_x_b & "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_qint(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma(CHAINMULTADD,821)@13 + 4
    -- out q@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ch(0) <= RESIZE(SIGNED(redist16_Convert1_sel_x_b_11_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_rnd_x_sel(BITSELECT,456)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x(BITSELECT,196)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma(CHAINMULTADD,820)@13 + 4
    -- out q@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate1_MinMax1_PostCast_primWireOut_sel_x_b),16);
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ch(0) <= RESIZE(SIGNED(redist15_Convert4_sel_x_b_11_mem_q),16);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_rnd_x_sel(BITSELECT,459)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_rnd_x_sel_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_x_cma_q(31 downto 10));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x(BITSELECT,199)@18
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_rnd_x_sel_b(20 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x(SUB,99)@18 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 21 => DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x_b(20)) & DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Mult1_PostCast_primWireOut_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_b));
            END IF;
        END IF;
    END PROCESS;
    DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_o(21 downto 0);

    -- Convert2_0_sel_x(BITSELECT,188)@19
    Convert2_0_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_FP_Inv_Park_Sub1_x_q(21 downto 0)), 32)));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged(BITSELECT,859)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_b <= STD_LOGIC_VECTOR(Convert2_0_sel_x_b(17 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_c <= STD_LOGIC_VECTOR(Convert2_0_sel_x_b(31 downto 18));

    -- redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q_1(DELAY,863)
    redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q_1_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q);
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma(CHAINMULTADD,829)@19 + 4
    -- out q@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ah(0) <= RESIZE(SIGNED(redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q_1_q),17);
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ch(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_c),14);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1(BITSHIFT,796)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im5_cma_q & "000000000000000000";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_qint(48 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2(BITJOIN,788)@19
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2_q <= GND_q & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bs1_bit_select_merged_b;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma(CHAINMULTADD,828)@19 + 4
    -- out q@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_reset <= areset;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0 <= '1';
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena2 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ena0;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ah(0) <= RESIZE(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjA2_q),19);
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ch(0) <= RESIZE(SIGNED(redist1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_bjB4_q_1_q),17);
            END IF;
        END IF;
    END PROCESS;

    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_a0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ah(0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_c0 <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_ch(0));
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

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0(ADD,798)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_im0_cma_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((50 downto 49 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_q(48)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_align_1_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_o(49 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x(BITSELECT,270)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_in <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mult_0_x_sums_result_add_0_0_q(47 downto 0));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_in(32 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc(BITSHIFT,833)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_ReinterpretCast1_0_sel_x_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_qint(32 downto 14);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add(ADD,834)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 19 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q(18)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_trunc_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_o(19 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift(BITSHIFT,835)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_qint(19 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x(BITSELECT,268)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_shift_q(18 downto 0)), 32)));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x(ADD,165)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_o(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged(SUB,617)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 1 => GND_q(0)) & GND_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_i <= "0" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_PreShift_1_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_i WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b = "1" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b1 <= (others => '0') WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b = "1" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_a1) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_b1));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate4_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux_x_merged_o(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x(CONSTANT,153)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q <= "10";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x(SUB,175)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_o(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign(LOGICAL,620)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q(32 downto 32)));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign(LOGICAL,624)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q(32 downto 32)));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x(LOGICAL,142)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x(MUX,157)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And_x_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_s, GND_q, VCC_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_q <= GND_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_q <= VCC_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x(LOGICAL,164)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign(LOGICAL,622)@23 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_qi <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_1_sel_x_b(31 downto 31)));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "NONE", phase => 0, modulus => 1 )
    PORT MAP ( xin => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_qi, xout => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_q, clk => clk, aclr => areset, ena => '1' );

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x(LOGICAL,143)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x(MUX,158)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And1_x_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_q <= STD_LOGIC_VECTOR("0" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux1_x_q);
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x(LOGICAL,163)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE1_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x(LOGICAL,144)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x(MUX,159)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And2_x_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_q, GND_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux2_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_q <= STD_LOGIC_VECTOR("0" & GND_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not_x(LOGICAL,162)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x(LOGICAL,145)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not2_x_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not_x_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x(MUX,160)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And3_x_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_q, VCC_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux3_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_q <= STD_LOGIC_VECTOR("0" & VCC_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x(LOGICAL,146)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Not1_x_q and DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_CmpGE2_x_cmp_nsign_q;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x(MUX,161)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_And4_x_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux4_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Const3_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Convert_sel_x(BITSELECT,246)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Convert_sel_x_b <= std_logic_vector(resize(unsigned(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_SectorSel_Mux5_x_q(1 downto 0)), 3));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged(BITSELECT,861)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Convert_sel_x_b(1 downto 0);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_in(0 downto 0);
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_in(1 downto 1);

    -- highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(BITSELECT,374)@24
    highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31 downto 1));

    -- addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(ADD,375)@24
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b));
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((32 downto 31 => highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b(30)) & highBBits_uid375_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b));
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_o <= STD_LOGIC_VECTOR(SIGNED(addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_a) + SIGNED(addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b));
    addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q <= addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_o(32 downto 0);

    -- lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(BITSELECT,373)@24
    lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_in <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b(0 downto 0);
    lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b <= lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_in(0 downto 0);

    -- add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x(BITJOIN,376)@24
    add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q <= addsumAHighB_uid376_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q & lowRangeB_uid374_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_b;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x(BITSELECT,252)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x_b <= STD_LOGIC_VECTOR(add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(31 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x(CONSTANT,56)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q <= "01111111111111111111111111111111";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x(COMPARE,55)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(33)) & add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_o(35));

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x(LOGICAL,187)@24
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hcmp_x_n);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x(CONSTANT,58)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q <= "10000000000000000000000000000000";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x(COMPARE,57)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q(33)) & add_uid377_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_o(35));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x(LOGICAL,183)@24
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lcmp_x_n);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x(SELECTOR,59)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q, dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x_b)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_sel_x_b);
        IF (dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_hconst_x_q);
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Const_Mult_PostCast_primWireOut_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_lconst_x_q);
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x(BITSELECT,254)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_x_Const_Mult_PostCast_primWireOut_mux_x_q(31 downto 0)), 33)));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x(ADD,166)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add1_x_o(33 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged(SUB,618)@24 + 1
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
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_o(33 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x(ADD,124)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Negate1_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u2_Mux3_x_merged_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000000000000" & redist29_ChannelIn2_in_14_Max_tpl_25_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_o(34 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add(ADD,851)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add3_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_o(35 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift(BITSHIFT,852)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_qint(35 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x(BITSELECT,242)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x(CONSTANT,29)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q <= "1111111111111111";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x(COMPARE,40)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000000000" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_o(36));

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x(LOGICAL,186)@25
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_hcmp_x_n);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x(CONSTANT,31)
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q <= "0000000000000000";

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign(LOGICAL,482)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_rnd_x_shift_q(34 downto 34)));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x(LOGICAL,182)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_lcmp_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x(SELECTOR,44)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q, dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_b)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_sel_x_b;
        IF (dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q;
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q;
        END IF;
    END PROCESS;

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x(COMPARE,261)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a <= STD_LOGIC_VECTOR("00" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b <= STD_LOGIC_VECTOR("00" & redist29_ChannelIn2_in_14_Max_tpl_25_mem_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a) - UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b));
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_n(0) <= not (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o(17));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x(MUX,260)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_n;
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q, redist29_ChannelIn2_in_14_Max_tpl_25_mem_q)
    BEGIN
        CASE (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s) IS
            WHEN "0" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert3_mux_x_q;
            WHEN "1" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= redist29_ChannelIn2_in_14_Max_tpl_25_mem_q;
            WHEN OTHERS => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x(COMPARE,267)@25
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a <= STD_LOGIC_VECTOR("00" & dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q);
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b <= STD_LOGIC_VECTOR("00000000000000000" & GND_q);
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_a) - UNSIGNED(dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_b));
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_c(0) <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_o(17);

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x(MUX,266)@25 + 1
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_signBit_x_c;
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_s) IS
                    WHEN "0" => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q;
                    WHEN "1" => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= STD_LOGIC_VECTOR("000000000000000" & GND_q);
                    WHEN OTHERS => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1(BITSHIFT,275)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert_sel_x_b & "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_qint(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x(SUB,176)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Convert1_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b(31)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_o(33 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x(MUX,136)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub1_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_q <= STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_PreShift_1_q);
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x(MUX,137)@24 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_q <= STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q);
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x(ADD,123)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u1_Mux3_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000000000000" & redist29_ChannelIn2_in_14_Max_tpl_25_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_o(34 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add(ADD,847)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add2_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_o(35 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift(BITSHIFT,848)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_qint(35 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x(BITSELECT,241)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x(COMPARE,34)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000000000" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 35 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q(34)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_o(36));

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x(LOGICAL,185)@25
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_hcmp_x_n);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign(LOGICAL,480)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_rnd_x_shift_q(34 downto 34)));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x(LOGICAL,181)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_lcmp_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x(SELECTOR,38)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q, dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_b)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_sel_x_b;
        IF (dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q;
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q;
        END IF;
    END PROCESS;

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x(COMPARE,259)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR("00" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR("00" & redist29_ChannelIn2_in_14_Max_tpl_25_mem_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a) - UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b));
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_n(0) <= not (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o(17));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x(MUX,258)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_n;
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q, redist29_ChannelIn2_in_14_Max_tpl_25_mem_q)
    BEGIN
        CASE (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s) IS
            WHEN "0" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert2_mux_x_q;
            WHEN "1" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= redist29_ChannelIn2_in_14_Max_tpl_25_mem_q;
            WHEN OTHERS => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x(COMPARE,265)@25
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a <= STD_LOGIC_VECTOR("00" & dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q);
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b <= STD_LOGIC_VECTOR("00000000000000000" & GND_q);
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_a) - UNSIGNED(dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_b));
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_c(0) <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_o(17);

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x(MUX,264)@25 + 1
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_signBit_x_c;
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_s) IS
                    WHEN "0" => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q;
                    WHEN "1" => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= STD_LOGIC_VECTOR("000000000000000" & GND_q);
                    WHEN OTHERS => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1(BITSHIFT,276)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_sel_x_b & "0";
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_qint(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x(MUX,132)@24
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_s <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Add_x_q;
            WHEN "1" => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_PreShift_1_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged(SUB,616)@24 + 1
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 1 => GND_q(0)) & GND_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_rotv_Sub_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_i <= "0" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux_x_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a1 <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_i WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c = "0" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b1 <= (others => '0') WHEN DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_BitExtract_x_bit_select_merged_c = "0" ELSE DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_a1) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_b1));
            END IF;
        END IF;
    END PROCESS;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_o(32 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x(ADD,122)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 33 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_q(32)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Negate_x_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MUX3_u_Mux3_x_merged_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000000000000000" & redist29_ChannelIn2_in_14_Max_tpl_25_mem_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_o(33 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add(ADD,843)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Add1_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 2 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q(1)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Convert1_0_rnd_x_bias_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_a) + SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_o(34 downto 0);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift(BITSHIFT,844)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_qint <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_add_q;
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_qint(34 downto 1);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x(BITSELECT,240)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_b <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q(15 downto 0));

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x(COMPARE,28)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("00000000000000000000" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 34 => DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q(33)) & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_o <= STD_LOGIC_VECTOR(SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_a) - SIGNED(DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_b));
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_n(0) <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_o(35));

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x(LOGICAL,184)@25
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hcmp_x_n);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign(LOGICAL,478)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_q <= STD_LOGIC_VECTOR(not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_rnd_x_shift_q(33 downto 33)));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x(LOGICAL,180)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q <= not (DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lcmp_x_cmp_nsign_q);

    -- DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x(SELECTOR,32)@25
    DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q, dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_b)
    BEGIN
        DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_sel_x_b;
        IF (dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_hconst_x_q;
        END IF;
        IF (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_x_q = "1") THEN
            DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_lconst_x_q;
        END IF;
    END PROCESS;

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x(COMPARE,257)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a <= STD_LOGIC_VECTOR("00" & DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b <= STD_LOGIC_VECTOR("00" & redist29_ChannelIn2_in_14_Max_tpl_25_mem_q);
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a) - UNSIGNED(dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b));
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_n(0) <= not (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o(17));

    -- dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x(MUX,256)@25
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_n;
    dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_combproc: PROCESS (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s, DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q, redist29_ChannelIn2_in_14_Max_tpl_25_mem_q)
    BEGIN
        CASE (dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s) IS
            WHEN "0" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_Convert1_mux_x_q;
            WHEN "1" => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= redist29_ChannelIn2_in_14_Max_tpl_25_mem_q;
            WHEN OTHERS => dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x(COMPARE,263)@25
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a <= STD_LOGIC_VECTOR("00" & dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q);
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b <= STD_LOGIC_VECTOR("00000000000000000" & GND_q);
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o <= STD_LOGIC_VECTOR(UNSIGNED(dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_a) - UNSIGNED(dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_b));
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_c(0) <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_o(17);

    -- dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x(MUX,262)@25 + 1
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_signBit_x_c;
    dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                CASE (dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_s) IS
                    WHEN "0" => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= dupName_0_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q;
                    WHEN "1" => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= STD_LOGIC_VECTOR("000000000000000" & GND_q);
                    WHEN OTHERS => dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_offset(CONSTANT,910)
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_offset_q <= "10000";

    -- redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt(ADD,915)
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_q);
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_offset_q);
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_a) + UNSIGNED(redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_q <= redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_o(5 downto 0);

    -- redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr(COUNTER,913)
    -- low=0, high=31, step=1, init=0
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_i <= redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_i, 5)));

    -- redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem(DUALMEM,912)
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q);
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_aa <= redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_wraddr_q;
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_ab <= redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_rdcnt_q(4 downto 0);
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 16,
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
        address_a => redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_aa,
        data_a => redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_ab,
        q_b => redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_iq
    );
    redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_q <= redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_iq(15 downto 0);

    -- redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt(ADD,911)
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_q);
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_offset_q);
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_a) + UNSIGNED(redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_q <= redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_o(5 downto 0);

    -- redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr(COUNTER,909)
    -- low=0, high=31, step=1, init=0
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_i <= redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_i, 5)));

    -- redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem(DUALMEM,908)
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q);
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_aa <= redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_wraddr_q;
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_ab <= redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_rdcnt_q(4 downto 0);
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 32,
        width_b => 16,
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
        address_a => redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_aa,
        data_a => redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_ab,
        q_b => redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_iq
    );
    redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_q <= redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_iq(15 downto 0);

    -- redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_offset(CONSTANT,894)
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_offset_q <= "0110";

    -- redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt(ADD,899)
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q);
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_offset_q);
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_a) + UNSIGNED(redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_q <= redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_o(4 downto 0);

    -- redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr(COUNTER,897)
    -- low=0, high=15, step=1, init=0
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i <= redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i, 4)));

    -- redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem(DUALMEM,896)
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b);
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_aa <= redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q;
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ab <= redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_q(3 downto 0);
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_dmem : altera_syncram
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
        address_a => redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_aa,
        data_a => redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ab,
        q_b => redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_iq
    );
    redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_q <= redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_iq(15 downto 0);

    -- redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt(ADD,895)
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q);
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_offset_q);
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_a) + UNSIGNED(redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_q <= redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_o(4 downto 0);

    -- redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr(COUNTER,893)
    -- low=0, high=15, step=1, init=0
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i <= redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_i, 4)));

    -- redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem(DUALMEM,892)
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ia <= STD_LOGIC_VECTOR(DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b);
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_aa <= redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_wraddr_q;
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ab <= redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_rdcnt_q(3 downto 0);
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_dmem : altera_syncram
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
        address_a => redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_aa,
        data_a => redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_ab,
        q_b => redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_iq
    );
    redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_q <= redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_iq(15 downto 0);

    -- redist11_Convert2_1_sel_x_b_8_offset(CONSTANT,902)
    redist11_Convert2_1_sel_x_b_8_offset_q <= "011";

    -- redist11_Convert2_1_sel_x_b_8_rdcnt(ADD,903)
    redist11_Convert2_1_sel_x_b_8_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist11_Convert2_1_sel_x_b_8_wraddr_q);
    redist11_Convert2_1_sel_x_b_8_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist11_Convert2_1_sel_x_b_8_offset_q);
    redist11_Convert2_1_sel_x_b_8_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist11_Convert2_1_sel_x_b_8_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist11_Convert2_1_sel_x_b_8_rdcnt_a) + UNSIGNED(redist11_Convert2_1_sel_x_b_8_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist11_Convert2_1_sel_x_b_8_rdcnt_q <= redist11_Convert2_1_sel_x_b_8_rdcnt_o(3 downto 0);

    -- redist11_Convert2_1_sel_x_b_8_wraddr(COUNTER,901)
    -- low=0, high=7, step=1, init=0
    redist11_Convert2_1_sel_x_b_8_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist11_Convert2_1_sel_x_b_8_wraddr_i <= redist11_Convert2_1_sel_x_b_8_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist11_Convert2_1_sel_x_b_8_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist11_Convert2_1_sel_x_b_8_wraddr_i, 3)));

    -- redist11_Convert2_1_sel_x_b_8_mem(DUALMEM,900)
    redist11_Convert2_1_sel_x_b_8_mem_ia <= STD_LOGIC_VECTOR(Convert2_1_sel_x_b);
    redist11_Convert2_1_sel_x_b_8_mem_aa <= redist11_Convert2_1_sel_x_b_8_wraddr_q;
    redist11_Convert2_1_sel_x_b_8_mem_ab <= redist11_Convert2_1_sel_x_b_8_rdcnt_q(2 downto 0);
    redist11_Convert2_1_sel_x_b_8_mem_dmem : altera_syncram
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
        address_a => redist11_Convert2_1_sel_x_b_8_mem_aa,
        data_a => redist11_Convert2_1_sel_x_b_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist11_Convert2_1_sel_x_b_8_mem_ab,
        q_b => redist11_Convert2_1_sel_x_b_8_mem_iq
    );
    redist11_Convert2_1_sel_x_b_8_mem_q <= redist11_Convert2_1_sel_x_b_8_mem_iq(31 downto 0);

    -- redist12_Convert2_0_sel_x_b_7_rdcnt(ADD,907)
    redist12_Convert2_0_sel_x_b_7_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist12_Convert2_0_sel_x_b_7_wraddr_q);
    redist12_Convert2_0_sel_x_b_7_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist12_Convert2_0_sel_x_b_7_offset_q);
    redist12_Convert2_0_sel_x_b_7_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist12_Convert2_0_sel_x_b_7_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist12_Convert2_0_sel_x_b_7_rdcnt_a) + UNSIGNED(redist12_Convert2_0_sel_x_b_7_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist12_Convert2_0_sel_x_b_7_rdcnt_q <= redist12_Convert2_0_sel_x_b_7_rdcnt_o(3 downto 0);

    -- redist12_Convert2_0_sel_x_b_7_wraddr(COUNTER,905)
    -- low=0, high=7, step=1, init=0
    redist12_Convert2_0_sel_x_b_7_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist12_Convert2_0_sel_x_b_7_wraddr_i <= redist12_Convert2_0_sel_x_b_7_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist12_Convert2_0_sel_x_b_7_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist12_Convert2_0_sel_x_b_7_wraddr_i, 3)));

    -- redist12_Convert2_0_sel_x_b_7_mem(DUALMEM,904)
    redist12_Convert2_0_sel_x_b_7_mem_ia <= STD_LOGIC_VECTOR(Convert2_0_sel_x_b);
    redist12_Convert2_0_sel_x_b_7_mem_aa <= redist12_Convert2_0_sel_x_b_7_wraddr_q;
    redist12_Convert2_0_sel_x_b_7_mem_ab <= redist12_Convert2_0_sel_x_b_7_rdcnt_q(2 downto 0);
    redist12_Convert2_0_sel_x_b_7_mem_dmem : altera_syncram
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
        address_a => redist12_Convert2_0_sel_x_b_7_mem_aa,
        data_a => redist12_Convert2_0_sel_x_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist12_Convert2_0_sel_x_b_7_mem_ab,
        q_b => redist12_Convert2_0_sel_x_b_7_mem_iq
    );
    redist12_Convert2_0_sel_x_b_7_mem_q <= redist12_Convert2_0_sel_x_b_7_mem_iq(31 downto 0);

    -- redist18_ChannelIn2_in_2_dc_tpl_26_offset(CONSTANT,926)
    redist18_ChannelIn2_in_2_dc_tpl_26_offset_q <= "01001";

    -- redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt(ADD,931)
    redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_q);
    redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist18_ChannelIn2_in_2_dc_tpl_26_offset_q);
    redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_a) + UNSIGNED(redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_q <= redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_o(5 downto 0);

    -- redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr(COUNTER,929)
    -- low=0, high=31, step=1, init=0
    redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_i <= redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_i, 5)));

    -- redist20_ChannelIn2_in_4_axis_in_tpl_26_mem(DUALMEM,928)
    redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_ia <= STD_LOGIC_VECTOR(in_4_axis_in_tpl);
    redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_aa <= redist20_ChannelIn2_in_4_axis_in_tpl_26_wraddr_q;
    redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_ab <= redist20_ChannelIn2_in_4_axis_in_tpl_26_rdcnt_q(4 downto 0);
    redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_dmem : altera_syncram
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
        address_a => redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_aa,
        data_a => redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_ab,
        q_b => redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_iq
    );
    redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_q <= redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_iq(7 downto 0);

    -- redist19_ChannelIn2_in_3_valid_in_tpl_26(DELAY,881)
    redist19_ChannelIn2_in_3_valid_in_tpl_26 : dspba_delay
    GENERIC MAP ( width => 1, depth => 26, reset_kind => "NONE", phase => 0, modulus => 1024 )
    PORT MAP ( xin => in_3_valid_in_tpl, xout => redist19_ChannelIn2_in_3_valid_in_tpl_26_q, clk => clk, aclr => areset, ena => '1' );

    -- redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt(ADD,927)
    redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_a <= STD_LOGIC_VECTOR("0" & redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_q);
    redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_b <= STD_LOGIC_VECTOR("0" & redist18_ChannelIn2_in_2_dc_tpl_26_offset_q);
    redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_o <= STD_LOGIC_VECTOR(UNSIGNED(redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_a) + UNSIGNED(redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_b));
            END IF;
        END IF;
    END PROCESS;
    redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_q <= redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_o(5 downto 0);

    -- redist18_ChannelIn2_in_2_dc_tpl_26_wraddr(COUNTER,925)
    -- low=0, high=31, step=1, init=0
    redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_i <= redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_i, 5)));

    -- redist18_ChannelIn2_in_2_dc_tpl_26_mem(DUALMEM,924)
    redist18_ChannelIn2_in_2_dc_tpl_26_mem_ia <= STD_LOGIC_VECTOR(in_2_dc_tpl);
    redist18_ChannelIn2_in_2_dc_tpl_26_mem_aa <= redist18_ChannelIn2_in_2_dc_tpl_26_wraddr_q;
    redist18_ChannelIn2_in_2_dc_tpl_26_mem_ab <= redist18_ChannelIn2_in_2_dc_tpl_26_rdcnt_q(4 downto 0);
    redist18_ChannelIn2_in_2_dc_tpl_26_mem_dmem : altera_syncram
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
        address_a => redist18_ChannelIn2_in_2_dc_tpl_26_mem_aa,
        data_a => redist18_ChannelIn2_in_2_dc_tpl_26_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist18_ChannelIn2_in_2_dc_tpl_26_mem_ab,
        q_b => redist18_ChannelIn2_in_2_dc_tpl_26_mem_iq
    );
    redist18_ChannelIn2_in_2_dc_tpl_26_mem_q <= redist18_ChannelIn2_in_2_dc_tpl_26_mem_iq(7 downto 0);

    -- redist17_ChannelIn2_in_1_dv_tpl_26(DELAY,879)
    redist17_ChannelIn2_in_1_dv_tpl_26 : dspba_delay
    GENERIC MAP ( width => 1, depth => 26, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => in_1_dv_tpl, xout => redist17_ChannelIn2_in_1_dv_tpl_26_q, clk => clk, aclr => areset, ena => '1' );

    -- ChannelOut1_vunroll_x(PORTOUT,78)@26 + 1
    out_1_qv_tpl <= redist17_ChannelIn2_in_1_dv_tpl_26_q;
    out_2_qc_tpl <= redist18_ChannelIn2_in_2_dc_tpl_26_mem_q;
    out_3_valid_out_tpl <= redist19_ChannelIn2_in_3_valid_in_tpl_26_q;
    out_4_axis_out_tpl <= redist20_ChannelIn2_in_4_axis_in_tpl_26_mem_q;
    out_5_Valpha_tpl <= redist12_Convert2_0_sel_x_b_7_mem_q;
    out_6_Vbeta_tpl <= redist11_Convert2_1_sel_x_b_8_mem_q;
    out_7_IntegralD_out_tpl <= redist6_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_q;
    out_8_IntegralQ_out_tpl <= redist7_DF_fixp16_alu_av_FOC_FL_fixp16_PI_Ctrl_D_DSPBA1_Fixed_Saturate2_MinMax1_PostCast_primWireOut_sel_x_b_13_mem_q;
    out_9_Iq_tpl <= redist13_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Sub1_x_q_19_mem_q;
    out_10_Id_tpl <= redist14_DF_fixp16_alu_av_FOC_FL_fixp16_FP_CP1_DSPBA_Add_x_q_19_mem_q;
    out_11_0_uvw_tpl <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax_mux_x_q;
    out_11_1_uvw_tpl <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax1_mux_x_q;
    out_11_2_uvw_tpl <= dupName_1_DF_fixp16_alu_av_FOC_FL_fixp16_SVM_Mod_MinMax2_mux_x_q;
    out_12_ready_tpl <= VCC_q;

END normal;
