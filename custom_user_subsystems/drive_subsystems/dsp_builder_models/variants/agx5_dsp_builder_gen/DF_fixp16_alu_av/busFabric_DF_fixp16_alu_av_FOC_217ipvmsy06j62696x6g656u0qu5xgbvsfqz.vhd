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

-- VHDL created from busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz
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
entity busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz is
    port (
        busIn_writedata : in std_logic_vector(31 downto 0);  -- ufix32
        busIn_address : in std_logic_vector(5 downto 0);  -- ufix6
        busIn_write : in std_logic_vector(0 downto 0);  -- ufix1
        busIn_read : in std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdata : out std_logic_vector(31 downto 0);  -- ufix32
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : in std_logic_vector(31 downto 0);  -- sfix32_en10
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : in std_logic_vector(31 downto 0);  -- sfix32_en10
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl : out std_logic_vector(7 downto 0);  -- ufix8
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic;
        h_areset : in std_logic
    );
end busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz;

architecture normal of busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_bitsel_x_b : STD_LOGIC_VECTOR (7 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_bitsel_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_bitsel_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_0_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_0_const_0_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_1_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_1_const_1_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_2_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_2_const_2_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_3_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_3_const_3_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_16_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_16_const_16_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_17_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_17_const_17_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_19_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_19_const_19_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_32_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_32_const_32_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_33_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_33_const_33_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_34_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_34_const_34_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_35_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_35_const_35_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_36_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_36_const_36_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_48_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_48_const_48_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_49_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_49_const_49_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_54_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_54_const_54_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_55_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_55_const_55_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_56_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_56_const_56_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_57_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_57_const_57_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_58_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_58_const_58_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_60_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_60_const_60_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_62_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_62_const_62_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal mm_reg_0_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_1_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_2_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_3_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_16_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_17_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_19_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_32_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_33_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_34_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_35_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_36_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_48_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_49_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_54_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_55_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_56_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_57_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_58_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_60_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_62_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_msb_const_0_x_q : STD_LOGIC_VECTOR (23 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_msb_const_0_x_q : STD_LOGIC_VECTOR (30 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal addr_0_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_1_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_1_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_2_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_2_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_3_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_16_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_16_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_17_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_17_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_19_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_19_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_32_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_32_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_33_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_33_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_34_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_34_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_35_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_35_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_36_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_36_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_48_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_49_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_54_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_55_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_56_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_57_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_58_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_60_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_62_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_62_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev0_id0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id0_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev0_id1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id1_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev0_id2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id2_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev0_id3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id3_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev0_id4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id4_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev0_id5_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id5_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev0_id6_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id6_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev1_id0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev1_id0_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev1_id1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev1_id1_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev2_id0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev2_id0_v : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_msb_const_0_x(CONSTANT,161)
    DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_msb_const_0_x_q <= "000000000000000000000000";

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_bitjoin_x(BITJOIN,39)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl;

    -- mm_reg_60_data_x(REG,158)@0
    mm_reg_60_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_60_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl = "1") THEN
                    mm_reg_60_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_60_const_60_x(CONSTANT,116)
    addr_60_const_60_x_q <= "111100";

    -- addr_60_cmp_x(LOGICAL,115)@0
    addr_60_cmp_x_q <= "1" WHEN addr_60_const_60_x_q = busIn_address ELSE "0";

    -- addr_60_readHit_and_x(LOGICAL,198)@0
    addr_60_readHit_and_x_q <= addr_60_cmp_x_q and busIn_read;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x(CONSTANT,164)
    DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x_q <= "0000000000000000";

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_bitjoin_x(BITJOIN,71)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl;

    -- mm_reg_58_data_x(REG,156)@0
    mm_reg_58_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_58_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl = "1") THEN
                    mm_reg_58_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_58_const_58_x(CONSTANT,114)
    addr_58_const_58_x_q <= "111010";

    -- addr_58_cmp_x(LOGICAL,113)@0
    addr_58_cmp_x_q <= "1" WHEN addr_58_const_58_x_q = busIn_address ELSE "0";

    -- addr_58_readHit_and_x(LOGICAL,197)@0
    addr_58_readHit_and_x_q <= addr_58_cmp_x_q and busIn_read;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_bitjoin_x(BITJOIN,69)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl;

    -- mm_reg_57_data_x(REG,154)@0
    mm_reg_57_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_57_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl = "1") THEN
                    mm_reg_57_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_57_const_57_x(CONSTANT,112)
    addr_57_const_57_x_q <= "111001";

    -- addr_57_cmp_x(LOGICAL,111)@0
    addr_57_cmp_x_q <= "1" WHEN addr_57_const_57_x_q = busIn_address ELSE "0";

    -- addr_57_readHit_and_x(LOGICAL,196)@0
    addr_57_readHit_and_x_q <= addr_57_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id6(SELECTOR,207)@0
    bus_selector_opt_lev0_id6_combproc: PROCESS (addr_57_readHit_and_x_q, mm_reg_57_data_x_q, addr_58_readHit_and_x_q, mm_reg_58_data_x_q, addr_60_readHit_and_x_q, mm_reg_60_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id6_q <= (others => '0');
        bus_selector_opt_lev0_id6_v <= "0";
        IF (addr_60_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id6_q <= STD_LOGIC_VECTOR(mm_reg_60_data_x_q);
            bus_selector_opt_lev0_id6_v <= "1";
        END IF;
        IF (addr_58_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id6_q <= STD_LOGIC_VECTOR(mm_reg_58_data_x_q);
            bus_selector_opt_lev0_id6_v <= "1";
        END IF;
        IF (addr_57_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id6_q <= STD_LOGIC_VECTOR(mm_reg_57_data_x_q);
            bus_selector_opt_lev0_id6_v <= "1";
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_bitjoin_x(BITJOIN,67)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl;

    -- mm_reg_56_data_x(REG,152)@0
    mm_reg_56_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_56_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl = "1") THEN
                    mm_reg_56_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_56_const_56_x(CONSTANT,110)
    addr_56_const_56_x_q <= "111000";

    -- addr_56_cmp_x(LOGICAL,109)@0
    addr_56_cmp_x_q <= "1" WHEN addr_56_const_56_x_q = busIn_address ELSE "0";

    -- addr_56_readHit_and_x(LOGICAL,195)@0
    addr_56_readHit_and_x_q <= addr_56_cmp_x_q and busIn_read;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_bitjoin_x(BITJOIN,49)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl;

    -- mm_reg_55_data_x(REG,150)@0
    mm_reg_55_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_55_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl = "1") THEN
                    mm_reg_55_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_55_const_55_x(CONSTANT,108)
    addr_55_const_55_x_q <= "110111";

    -- addr_55_cmp_x(LOGICAL,107)@0
    addr_55_cmp_x_q <= "1" WHEN addr_55_const_55_x_q = busIn_address ELSE "0";

    -- addr_55_readHit_and_x(LOGICAL,194)@0
    addr_55_readHit_and_x_q <= addr_55_cmp_x_q and busIn_read;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_bitjoin_x(BITJOIN,51)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl;

    -- mm_reg_54_data_x(REG,148)@0
    mm_reg_54_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_54_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl = "1") THEN
                    mm_reg_54_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_54_const_54_x(CONSTANT,106)
    addr_54_const_54_x_q <= "110110";

    -- addr_54_cmp_x(LOGICAL,105)@0
    addr_54_cmp_x_q <= "1" WHEN addr_54_const_54_x_q = busIn_address ELSE "0";

    -- addr_54_readHit_and_x(LOGICAL,193)@0
    addr_54_readHit_and_x_q <= addr_54_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id5(SELECTOR,206)@0
    bus_selector_opt_lev0_id5_combproc: PROCESS (addr_54_readHit_and_x_q, mm_reg_54_data_x_q, addr_55_readHit_and_x_q, mm_reg_55_data_x_q, addr_56_readHit_and_x_q, mm_reg_56_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id5_q <= (others => '0');
        bus_selector_opt_lev0_id5_v <= "0";
        IF (addr_56_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id5_q <= STD_LOGIC_VECTOR(mm_reg_56_data_x_q);
            bus_selector_opt_lev0_id5_v <= "1";
        END IF;
        IF (addr_55_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id5_q <= STD_LOGIC_VECTOR(mm_reg_55_data_x_q);
            bus_selector_opt_lev0_id5_v <= "1";
        END IF;
        IF (addr_54_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id5_q <= STD_LOGIC_VECTOR(mm_reg_54_data_x_q);
            bus_selector_opt_lev0_id5_v <= "1";
        END IF;
    END PROCESS;

    -- mm_reg_49_data_x(REG,146)@0
    mm_reg_49_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_49_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl = "1") THEN
                    mm_reg_49_data_x_q <= in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_49_const_49_x(CONSTANT,104)
    addr_49_const_49_x_q <= "110001";

    -- addr_49_cmp_x(LOGICAL,103)@0
    addr_49_cmp_x_q <= "1" WHEN addr_49_const_49_x_q = busIn_address ELSE "0";

    -- addr_49_readHit_and_x(LOGICAL,192)@0
    addr_49_readHit_and_x_q <= addr_49_cmp_x_q and busIn_read;

    -- mm_reg_48_data_x(REG,144)@0
    mm_reg_48_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_48_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl = "1") THEN
                    mm_reg_48_data_x_q <= in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_48_const_48_x(CONSTANT,102)
    addr_48_const_48_x_q <= "110000";

    -- addr_48_cmp_x(LOGICAL,101)@0
    addr_48_cmp_x_q <= "1" WHEN addr_48_const_48_x_q = busIn_address ELSE "0";

    -- addr_48_readHit_and_x(LOGICAL,191)@0
    addr_48_readHit_and_x_q <= addr_48_cmp_x_q and busIn_read;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_msb_const_0_x(CONSTANT,162)
    DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_msb_const_0_x_q <= "0000000000000000000000000000000";

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_bitjoin_x(BITJOIN,43)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl;

    -- mm_reg_3_data_x(REG,126)@0
    mm_reg_3_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_3_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl = "1") THEN
                    mm_reg_3_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_3_const_3_x(CONSTANT,84)
    addr_3_const_3_x_q <= "000011";

    -- addr_3_cmp_x(LOGICAL,83)@0
    addr_3_cmp_x_q <= "1" WHEN addr_3_const_3_x_q = busIn_address ELSE "0";

    -- addr_3_readHit_and_x(LOGICAL,174)@0
    addr_3_readHit_and_x_q <= addr_3_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id4(SELECTOR,205)@0
    bus_selector_opt_lev0_id4_combproc: PROCESS (addr_3_readHit_and_x_q, mm_reg_3_data_x_q, addr_48_readHit_and_x_q, mm_reg_48_data_x_q, addr_49_readHit_and_x_q, mm_reg_49_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id4_q <= (others => '0');
        bus_selector_opt_lev0_id4_v <= "0";
        IF (addr_49_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id4_q <= STD_LOGIC_VECTOR(mm_reg_49_data_x_q);
            bus_selector_opt_lev0_id4_v <= "1";
        END IF;
        IF (addr_48_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id4_q <= STD_LOGIC_VECTOR(mm_reg_48_data_x_q);
            bus_selector_opt_lev0_id4_v <= "1";
        END IF;
        IF (addr_3_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id4_q <= STD_LOGIC_VECTOR(mm_reg_3_data_x_q);
            bus_selector_opt_lev0_id4_v <= "1";
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_bitjoin_x(BITJOIN,41)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_bitjoin_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_msb_const_0_x_q & in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl;

    -- mm_reg_0_data_x(REG,120)@0
    mm_reg_0_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_0_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl = "1") THEN
                    mm_reg_0_data_x_q <= DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_0_const_0_x(CONSTANT,78)
    addr_0_const_0_x_q <= "000000";

    -- addr_0_cmp_x(LOGICAL,77)@0
    addr_0_cmp_x_q <= "1" WHEN addr_0_const_0_x_q = busIn_address ELSE "0";

    -- addr_0_readHit_and_x(LOGICAL,169)@0
    addr_0_readHit_and_x_q <= addr_0_cmp_x_q and busIn_read;

    -- addr_62_const_62_x(CONSTANT,118)
    addr_62_const_62_x_q <= "111110";

    -- addr_62_cmp_x(LOGICAL,117)@0
    addr_62_cmp_x_q <= "1" WHEN addr_62_const_62_x_q = busIn_address ELSE "0";

    -- addr_62_writeHit_and_x(LOGICAL,200)@0
    addr_62_writeHit_and_x_q <= addr_62_cmp_x_q and busIn_write;

    -- mm_reg_62_data_x(REG,160)@0
    mm_reg_62_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_62_data_x_q <= "00000000000000000100100100111110";
            ELSE
                IF (addr_62_writeHit_and_x_q = "1") THEN
                    mm_reg_62_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_62_readHit_and_x(LOGICAL,199)@0
    addr_62_readHit_and_x_q <= addr_62_cmp_x_q and busIn_read;

    -- addr_36_const_36_x(CONSTANT,100)
    addr_36_const_36_x_q <= "100100";

    -- addr_36_cmp_x(LOGICAL,99)@0
    addr_36_cmp_x_q <= "1" WHEN addr_36_const_36_x_q = busIn_address ELSE "0";

    -- addr_36_writeHit_and_x(LOGICAL,190)@0
    addr_36_writeHit_and_x_q <= addr_36_cmp_x_q and busIn_write;

    -- mm_reg_36_data_x(REG,142)@0
    mm_reg_36_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_36_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_36_writeHit_and_x_q = "1") THEN
                    mm_reg_36_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_36_readHit_and_x(LOGICAL,189)@0
    addr_36_readHit_and_x_q <= addr_36_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id3(SELECTOR,204)@0
    bus_selector_opt_lev0_id3_combproc: PROCESS (addr_36_readHit_and_x_q, mm_reg_36_data_x_q, addr_62_readHit_and_x_q, mm_reg_62_data_x_q, addr_0_readHit_and_x_q, mm_reg_0_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id3_q <= (others => '0');
        bus_selector_opt_lev0_id3_v <= "0";
        IF (addr_0_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id3_q <= STD_LOGIC_VECTOR(mm_reg_0_data_x_q);
            bus_selector_opt_lev0_id3_v <= "1";
        END IF;
        IF (addr_62_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id3_q <= STD_LOGIC_VECTOR(mm_reg_62_data_x_q);
            bus_selector_opt_lev0_id3_v <= "1";
        END IF;
        IF (addr_36_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id3_q <= STD_LOGIC_VECTOR(mm_reg_36_data_x_q);
            bus_selector_opt_lev0_id3_v <= "1";
        END IF;
    END PROCESS;

    -- bus_selector_opt_lev1_id1(SELECTOR,209)@0
    bus_selector_opt_lev1_id1_combproc: PROCESS (bus_selector_opt_lev0_id3_v, bus_selector_opt_lev0_id3_q, bus_selector_opt_lev0_id4_v, bus_selector_opt_lev0_id4_q, bus_selector_opt_lev0_id5_v, bus_selector_opt_lev0_id5_q)
    BEGIN
        bus_selector_opt_lev1_id1_q <= (others => '0');
        bus_selector_opt_lev1_id1_v <= "0";
        IF (bus_selector_opt_lev0_id5_v = "1") THEN
            bus_selector_opt_lev1_id1_q <= STD_LOGIC_VECTOR(bus_selector_opt_lev0_id5_q);
            bus_selector_opt_lev1_id1_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id4_v = "1") THEN
            bus_selector_opt_lev1_id1_q <= STD_LOGIC_VECTOR(bus_selector_opt_lev0_id4_q);
            bus_selector_opt_lev1_id1_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id3_v = "1") THEN
            bus_selector_opt_lev1_id1_q <= STD_LOGIC_VECTOR(bus_selector_opt_lev0_id3_q);
            bus_selector_opt_lev1_id1_v <= "1";
        END IF;
    END PROCESS;

    -- addr_35_const_35_x(CONSTANT,98)
    addr_35_const_35_x_q <= "100011";

    -- addr_35_cmp_x(LOGICAL,97)@0
    addr_35_cmp_x_q <= "1" WHEN addr_35_const_35_x_q = busIn_address ELSE "0";

    -- addr_35_writeHit_and_x(LOGICAL,188)@0
    addr_35_writeHit_and_x_q <= addr_35_cmp_x_q and busIn_write;

    -- mm_reg_35_data_x(REG,140)@0
    mm_reg_35_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_35_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_35_writeHit_and_x_q = "1") THEN
                    mm_reg_35_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_35_readHit_and_x(LOGICAL,187)@0
    addr_35_readHit_and_x_q <= addr_35_cmp_x_q and busIn_read;

    -- addr_34_const_34_x(CONSTANT,96)
    addr_34_const_34_x_q <= "100010";

    -- addr_34_cmp_x(LOGICAL,95)@0
    addr_34_cmp_x_q <= "1" WHEN addr_34_const_34_x_q = busIn_address ELSE "0";

    -- addr_34_writeHit_and_x(LOGICAL,186)@0
    addr_34_writeHit_and_x_q <= addr_34_cmp_x_q and busIn_write;

    -- mm_reg_34_data_x(REG,138)@0
    mm_reg_34_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_34_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_34_writeHit_and_x_q = "1") THEN
                    mm_reg_34_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_34_readHit_and_x(LOGICAL,185)@0
    addr_34_readHit_and_x_q <= addr_34_cmp_x_q and busIn_read;

    -- addr_33_const_33_x(CONSTANT,94)
    addr_33_const_33_x_q <= "100001";

    -- addr_33_cmp_x(LOGICAL,93)@0
    addr_33_cmp_x_q <= "1" WHEN addr_33_const_33_x_q = busIn_address ELSE "0";

    -- addr_33_writeHit_and_x(LOGICAL,184)@0
    addr_33_writeHit_and_x_q <= addr_33_cmp_x_q and busIn_write;

    -- mm_reg_33_data_x(REG,136)@0
    mm_reg_33_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_33_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_33_writeHit_and_x_q = "1") THEN
                    mm_reg_33_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_33_readHit_and_x(LOGICAL,183)@0
    addr_33_readHit_and_x_q <= addr_33_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id2(SELECTOR,203)@0
    bus_selector_opt_lev0_id2_combproc: PROCESS (addr_33_readHit_and_x_q, mm_reg_33_data_x_q, addr_34_readHit_and_x_q, mm_reg_34_data_x_q, addr_35_readHit_and_x_q, mm_reg_35_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id2_q <= (others => '0');
        bus_selector_opt_lev0_id2_v <= "0";
        IF (addr_35_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id2_q <= STD_LOGIC_VECTOR(mm_reg_35_data_x_q);
            bus_selector_opt_lev0_id2_v <= "1";
        END IF;
        IF (addr_34_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id2_q <= STD_LOGIC_VECTOR(mm_reg_34_data_x_q);
            bus_selector_opt_lev0_id2_v <= "1";
        END IF;
        IF (addr_33_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id2_q <= STD_LOGIC_VECTOR(mm_reg_33_data_x_q);
            bus_selector_opt_lev0_id2_v <= "1";
        END IF;
    END PROCESS;

    -- addr_32_const_32_x(CONSTANT,92)
    addr_32_const_32_x_q <= "100000";

    -- addr_32_cmp_x(LOGICAL,91)@0
    addr_32_cmp_x_q <= "1" WHEN addr_32_const_32_x_q = busIn_address ELSE "0";

    -- addr_32_writeHit_and_x(LOGICAL,182)@0
    addr_32_writeHit_and_x_q <= addr_32_cmp_x_q and busIn_write;

    -- mm_reg_32_data_x(REG,134)@0
    mm_reg_32_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_32_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_32_writeHit_and_x_q = "1") THEN
                    mm_reg_32_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_32_readHit_and_x(LOGICAL,181)@0
    addr_32_readHit_and_x_q <= addr_32_cmp_x_q and busIn_read;

    -- addr_19_const_19_x(CONSTANT,90)
    addr_19_const_19_x_q <= "010011";

    -- addr_19_cmp_x(LOGICAL,89)@0
    addr_19_cmp_x_q <= "1" WHEN addr_19_const_19_x_q = busIn_address ELSE "0";

    -- addr_19_writeHit_and_x(LOGICAL,180)@0
    addr_19_writeHit_and_x_q <= addr_19_cmp_x_q and busIn_write;

    -- mm_reg_19_data_x(REG,132)@0
    mm_reg_19_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_19_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_19_writeHit_and_x_q = "1") THEN
                    mm_reg_19_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_19_readHit_and_x(LOGICAL,179)@0
    addr_19_readHit_and_x_q <= addr_19_cmp_x_q and busIn_read;

    -- addr_17_const_17_x(CONSTANT,88)
    addr_17_const_17_x_q <= "010001";

    -- addr_17_cmp_x(LOGICAL,87)@0
    addr_17_cmp_x_q <= "1" WHEN addr_17_const_17_x_q = busIn_address ELSE "0";

    -- addr_17_writeHit_and_x(LOGICAL,178)@0
    addr_17_writeHit_and_x_q <= addr_17_cmp_x_q and busIn_write;

    -- mm_reg_17_data_x(REG,130)@0
    mm_reg_17_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_17_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_17_writeHit_and_x_q = "1") THEN
                    mm_reg_17_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_17_readHit_and_x(LOGICAL,177)@0
    addr_17_readHit_and_x_q <= addr_17_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id1(SELECTOR,202)@0
    bus_selector_opt_lev0_id1_combproc: PROCESS (addr_17_readHit_and_x_q, mm_reg_17_data_x_q, addr_19_readHit_and_x_q, mm_reg_19_data_x_q, addr_32_readHit_and_x_q, mm_reg_32_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id1_q <= (others => '0');
        bus_selector_opt_lev0_id1_v <= "0";
        IF (addr_32_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id1_q <= STD_LOGIC_VECTOR(mm_reg_32_data_x_q);
            bus_selector_opt_lev0_id1_v <= "1";
        END IF;
        IF (addr_19_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id1_q <= STD_LOGIC_VECTOR(mm_reg_19_data_x_q);
            bus_selector_opt_lev0_id1_v <= "1";
        END IF;
        IF (addr_17_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id1_q <= STD_LOGIC_VECTOR(mm_reg_17_data_x_q);
            bus_selector_opt_lev0_id1_v <= "1";
        END IF;
    END PROCESS;

    -- addr_16_const_16_x(CONSTANT,86)
    addr_16_const_16_x_q <= "010000";

    -- addr_16_cmp_x(LOGICAL,85)@0
    addr_16_cmp_x_q <= "1" WHEN addr_16_const_16_x_q = busIn_address ELSE "0";

    -- addr_16_writeHit_and_x(LOGICAL,176)@0
    addr_16_writeHit_and_x_q <= addr_16_cmp_x_q and busIn_write;

    -- mm_reg_16_data_x(REG,128)@0
    mm_reg_16_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_16_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_16_writeHit_and_x_q = "1") THEN
                    mm_reg_16_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_16_readHit_and_x(LOGICAL,175)@0
    addr_16_readHit_and_x_q <= addr_16_cmp_x_q and busIn_read;

    -- addr_2_const_2_x(CONSTANT,82)
    addr_2_const_2_x_q <= "000010";

    -- addr_2_cmp_x(LOGICAL,81)@0
    addr_2_cmp_x_q <= "1" WHEN addr_2_const_2_x_q = busIn_address ELSE "0";

    -- addr_2_writeHit_and_x(LOGICAL,173)@0
    addr_2_writeHit_and_x_q <= addr_2_cmp_x_q and busIn_write;

    -- mm_reg_2_data_x(REG,124)@0
    mm_reg_2_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_2_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_2_writeHit_and_x_q = "1") THEN
                    mm_reg_2_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_2_readHit_and_x(LOGICAL,172)@0
    addr_2_readHit_and_x_q <= addr_2_cmp_x_q and busIn_read;

    -- addr_1_const_1_x(CONSTANT,80)
    addr_1_const_1_x_q <= "000001";

    -- addr_1_cmp_x(LOGICAL,79)@0
    addr_1_cmp_x_q <= "1" WHEN addr_1_const_1_x_q = busIn_address ELSE "0";

    -- addr_1_writeHit_and_x(LOGICAL,171)@0
    addr_1_writeHit_and_x_q <= addr_1_cmp_x_q and busIn_write;

    -- mm_reg_1_data_x(REG,122)@0
    mm_reg_1_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_1_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_1_writeHit_and_x_q = "1") THEN
                    mm_reg_1_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_1_readHit_and_x(LOGICAL,170)@0
    addr_1_readHit_and_x_q <= addr_1_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id0(SELECTOR,201)@0
    bus_selector_opt_lev0_id0_combproc: PROCESS (addr_1_readHit_and_x_q, mm_reg_1_data_x_q, addr_2_readHit_and_x_q, mm_reg_2_data_x_q, addr_16_readHit_and_x_q, mm_reg_16_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id0_q <= (others => '0');
        bus_selector_opt_lev0_id0_v <= "0";
        IF (addr_16_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id0_q <= STD_LOGIC_VECTOR(mm_reg_16_data_x_q);
            bus_selector_opt_lev0_id0_v <= "1";
        END IF;
        IF (addr_2_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id0_q <= STD_LOGIC_VECTOR(mm_reg_2_data_x_q);
            bus_selector_opt_lev0_id0_v <= "1";
        END IF;
        IF (addr_1_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id0_q <= STD_LOGIC_VECTOR(mm_reg_1_data_x_q);
            bus_selector_opt_lev0_id0_v <= "1";
        END IF;
    END PROCESS;

    -- bus_selector_opt_lev1_id0(SELECTOR,208)@0
    bus_selector_opt_lev1_id0_combproc: PROCESS (bus_selector_opt_lev0_id0_v, bus_selector_opt_lev0_id0_q, bus_selector_opt_lev0_id1_v, bus_selector_opt_lev0_id1_q, bus_selector_opt_lev0_id2_v, bus_selector_opt_lev0_id2_q)
    BEGIN
        bus_selector_opt_lev1_id0_q <= (others => '0');
        bus_selector_opt_lev1_id0_v <= "0";
        IF (bus_selector_opt_lev0_id2_v = "1") THEN
            bus_selector_opt_lev1_id0_q <= STD_LOGIC_VECTOR(bus_selector_opt_lev0_id2_q);
            bus_selector_opt_lev1_id0_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id1_v = "1") THEN
            bus_selector_opt_lev1_id0_q <= STD_LOGIC_VECTOR(bus_selector_opt_lev0_id1_q);
            bus_selector_opt_lev1_id0_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id0_v = "1") THEN
            bus_selector_opt_lev1_id0_q <= STD_LOGIC_VECTOR(bus_selector_opt_lev0_id0_q);
            bus_selector_opt_lev1_id0_v <= "1";
        END IF;
    END PROCESS;

    -- bus_selector_opt_lev2_id0(SELECTOR,210)@0 + 1
    bus_selector_opt_lev2_id0_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                bus_selector_opt_lev2_id0_q <= (others => '0');
                bus_selector_opt_lev2_id0_v <= (others => '0');
            ELSE
                bus_selector_opt_lev2_id0_q <= STD_LOGIC_VECTOR("0000000000000000000000000000000" & GND_q);
                bus_selector_opt_lev2_id0_v <= "0";
                IF (bus_selector_opt_lev0_id6_v = "1") THEN
                    bus_selector_opt_lev2_id0_q <= bus_selector_opt_lev0_id6_q;
                    bus_selector_opt_lev2_id0_v <= "1";
                END IF;
                IF (bus_selector_opt_lev1_id1_v = "1") THEN
                    bus_selector_opt_lev2_id0_q <= bus_selector_opt_lev1_id1_q;
                    bus_selector_opt_lev2_id0_v <= "1";
                END IF;
                IF (bus_selector_opt_lev1_id0_v = "1") THEN
                    bus_selector_opt_lev2_id0_q <= bus_selector_opt_lev1_id0_q;
                    bus_selector_opt_lev2_id0_v <= "1";
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- busOut(BUSOUT,3)@1
    busOut_readdatavalid <= bus_selector_opt_lev2_id0_v;
    busOut_readdata <= bus_selector_opt_lev2_id0_q;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_bitsel_x(BITSELECT,37)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_bitsel_x_b <= mm_reg_2_data_x_q(7 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl(GPOUT,26)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_bitsel_x(BITSELECT,45)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_bitsel_x_b <= mm_reg_1_data_x_q(0 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl(GPOUT,27)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_bitsel_x(BITSELECT,47)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_bitsel_x_b <= mm_reg_19_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl(GPOUT,28)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_bitsel_x(BITSELECT,53)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_bitsel_x_b <= mm_reg_32_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl(GPOUT,29)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_bitsel_x(BITSELECT,55)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_bitsel_x_b <= mm_reg_33_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl(GPOUT,30)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_bitsel_x(BITSELECT,57)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_bitsel_x_b <= mm_reg_17_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl(GPOUT,31)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_bitsel_x(BITSELECT,59)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_bitsel_x_b <= mm_reg_16_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl(GPOUT,32)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_bitsel_x(BITSELECT,61)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_bitsel_x_b <= mm_reg_62_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl(GPOUT,33)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_bitsel_x(BITSELECT,63)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_bitsel_x_b <= mm_reg_34_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl(GPOUT,34)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_bitsel_x(BITSELECT,73)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_bitsel_x_b <= mm_reg_35_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl(GPOUT,35)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_bitsel_x_b;

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_bitsel_x(BITSELECT,75)@0
    DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_bitsel_x_b <= mm_reg_36_data_x_q(0 downto 0);

    -- out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl(GPOUT,36)@0
    out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl <= DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_bitsel_x_b;

END normal;
