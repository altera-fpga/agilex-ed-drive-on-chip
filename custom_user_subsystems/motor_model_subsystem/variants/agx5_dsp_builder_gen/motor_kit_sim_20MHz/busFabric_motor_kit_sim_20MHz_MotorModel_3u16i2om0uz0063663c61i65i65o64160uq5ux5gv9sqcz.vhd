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

-- VHDL created from busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz
-- VHDL created on Wed Aug  7 11:03:59 2024


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

USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;
entity busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz is
    port (
        busIn_writedata : in std_logic_vector(31 downto 0);  -- ufix32
        busIn_address : in std_logic_vector(5 downto 0);  -- ufix6
        busIn_write : in std_logic_vector(0 downto 0);  -- ufix1
        busIn_read : in std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdata : out std_logic_vector(31 downto 0);  -- ufix32
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en9
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en9
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en9
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en14
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en14
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en39
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en6
        clk : in std_logic;
        areset : in std_logic;
        h_areset : in std_logic
    );
end busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz;

architecture normal of busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_0_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_0_const_0_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_1_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_1_const_1_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_3_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_3_const_3_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_16_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_16_const_16_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_17_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_17_const_17_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_18_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_18_const_18_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_19_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_19_const_19_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_20_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_20_const_20_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_21_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_21_const_21_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_22_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_22_const_22_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_31_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_31_const_31_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_32_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_32_const_32_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_33_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_33_const_33_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_34_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_34_const_34_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_35_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_35_const_35_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_37_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_37_const_37_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_38_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_38_const_38_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_47_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_47_const_47_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_48_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_48_const_48_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_49_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_49_const_49_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_50_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_50_const_50_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_54_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_54_const_54_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal addr_55_cmp_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_55_const_55_x_q : STD_LOGIC_VECTOR (5 downto 0);
    signal mm_reg_0_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_1_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_3_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_16_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_17_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_18_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_19_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_20_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_21_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_22_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_31_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_32_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_33_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_34_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_35_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_37_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_38_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_47_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_48_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_49_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_50_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_54_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal mm_reg_55_data_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_bitsel_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_bitjoin_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_bitsel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal addr_0_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_1_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_1_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_3_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_16_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_16_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_17_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_17_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_18_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_18_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_19_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_19_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_20_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_20_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_21_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_21_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_22_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_22_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_31_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_31_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_32_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_32_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_33_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_33_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_34_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_34_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_35_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_35_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_37_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_37_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_38_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_38_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_47_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_47_writeHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_48_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_49_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_50_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_54_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal addr_55_readHit_and_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_msb_const_0_x_q : STD_LOGIC_VECTOR (30 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x_q : STD_LOGIC_VECTOR (15 downto 0);
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
    signal bus_selector_opt_lev0_id7_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev0_id7_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev1_id0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev1_id0_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev1_id1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev1_id1_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev1_id2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev1_id2_v : STD_LOGIC_VECTOR (0 downto 0);
    signal bus_selector_opt_lev2_id0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bus_selector_opt_lev2_id0_v : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x(CONSTANT,215)
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x_q <= "0000000000000000";

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_bitjoin_x(BITJOIN,152)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_bitjoin_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x_q & in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl;

    -- mm_reg_55_data_x(REG,127)@0
    mm_reg_55_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_55_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl = "1") THEN
                    mm_reg_55_data_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_55_const_55_x(CONSTANT,81)
    addr_55_const_55_x_q <= "110111";

    -- addr_55_cmp_x(LOGICAL,80)@0
    addr_55_cmp_x_q <= "1" WHEN addr_55_const_55_x_q = busIn_address ELSE "0";

    -- addr_55_readHit_and_x(LOGICAL,212)@0
    addr_55_readHit_and_x_q <= addr_55_cmp_x_q and busIn_read;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_bitjoin_x(BITJOIN,162)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_bitjoin_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x_q & in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl;

    -- mm_reg_54_data_x(REG,125)@0
    mm_reg_54_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_54_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl = "1") THEN
                    mm_reg_54_data_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_54_const_54_x(CONSTANT,79)
    addr_54_const_54_x_q <= "110110";

    -- addr_54_cmp_x(LOGICAL,78)@0
    addr_54_cmp_x_q <= "1" WHEN addr_54_const_54_x_q = busIn_address ELSE "0";

    -- addr_54_readHit_and_x(LOGICAL,211)@0
    addr_54_readHit_and_x_q <= addr_54_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id7(SELECTOR,227)@0
    bus_selector_opt_lev0_id7_combproc: PROCESS (addr_54_readHit_and_x_q, mm_reg_54_data_x_q, addr_55_readHit_and_x_q, mm_reg_55_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id7_q <= (others => '0');
        bus_selector_opt_lev0_id7_v <= "0";
        IF (addr_55_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id7_q <= mm_reg_55_data_x_q;
            bus_selector_opt_lev0_id7_v <= "1";
        END IF;
        IF (addr_54_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id7_q <= mm_reg_54_data_x_q;
            bus_selector_opt_lev0_id7_v <= "1";
        END IF;
    END PROCESS;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_bitjoin_x(BITJOIN,168)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_bitjoin_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x_q & in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl;

    -- mm_reg_50_data_x(REG,123)@0
    mm_reg_50_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_50_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl = "1") THEN
                    mm_reg_50_data_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_50_const_50_x(CONSTANT,77)
    addr_50_const_50_x_q <= "110010";

    -- addr_50_cmp_x(LOGICAL,76)@0
    addr_50_cmp_x_q <= "1" WHEN addr_50_const_50_x_q = busIn_address ELSE "0";

    -- addr_50_readHit_and_x(LOGICAL,210)@0
    addr_50_readHit_and_x_q <= addr_50_cmp_x_q and busIn_read;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_bitjoin_x(BITJOIN,166)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_bitjoin_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x_q & in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl;

    -- mm_reg_49_data_x(REG,121)@0
    mm_reg_49_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_49_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl = "1") THEN
                    mm_reg_49_data_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_49_const_49_x(CONSTANT,75)
    addr_49_const_49_x_q <= "110001";

    -- addr_49_cmp_x(LOGICAL,74)@0
    addr_49_cmp_x_q <= "1" WHEN addr_49_const_49_x_q = busIn_address ELSE "0";

    -- addr_49_readHit_and_x(LOGICAL,209)@0
    addr_49_readHit_and_x_q <= addr_49_cmp_x_q and busIn_read;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_bitjoin_x(BITJOIN,164)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_bitjoin_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_msb_const_0_x_q & in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl;

    -- mm_reg_48_data_x(REG,119)@0
    mm_reg_48_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_48_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl = "1") THEN
                    mm_reg_48_data_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_48_const_48_x(CONSTANT,73)
    addr_48_const_48_x_q <= "110000";

    -- addr_48_cmp_x(LOGICAL,72)@0
    addr_48_cmp_x_q <= "1" WHEN addr_48_const_48_x_q = busIn_address ELSE "0";

    -- addr_48_readHit_and_x(LOGICAL,208)@0
    addr_48_readHit_and_x_q <= addr_48_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id6(SELECTOR,226)@0
    bus_selector_opt_lev0_id6_combproc: PROCESS (addr_48_readHit_and_x_q, mm_reg_48_data_x_q, addr_49_readHit_and_x_q, mm_reg_49_data_x_q, addr_50_readHit_and_x_q, mm_reg_50_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id6_q <= (others => '0');
        bus_selector_opt_lev0_id6_v <= "0";
        IF (addr_50_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id6_q <= mm_reg_50_data_x_q;
            bus_selector_opt_lev0_id6_v <= "1";
        END IF;
        IF (addr_49_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id6_q <= mm_reg_49_data_x_q;
            bus_selector_opt_lev0_id6_v <= "1";
        END IF;
        IF (addr_48_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id6_q <= mm_reg_48_data_x_q;
            bus_selector_opt_lev0_id6_v <= "1";
        END IF;
    END PROCESS;

    -- bus_selector_opt_lev1_id2(SELECTOR,230)@0
    bus_selector_opt_lev1_id2_combproc: PROCESS (bus_selector_opt_lev0_id6_v, bus_selector_opt_lev0_id6_q, bus_selector_opt_lev0_id7_v, bus_selector_opt_lev0_id7_q)
    BEGIN
        bus_selector_opt_lev1_id2_q <= (others => '0');
        bus_selector_opt_lev1_id2_v <= "0";
        IF (bus_selector_opt_lev0_id7_v = "1") THEN
            bus_selector_opt_lev1_id2_q <= bus_selector_opt_lev0_id7_q;
            bus_selector_opt_lev1_id2_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id6_v = "1") THEN
            bus_selector_opt_lev1_id2_q <= bus_selector_opt_lev0_id6_q;
            bus_selector_opt_lev1_id2_v <= "1";
        END IF;
    END PROCESS;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_msb_const_0_x(CONSTANT,213)
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_msb_const_0_x_q <= "0000000000000000000000000000000";

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_bitjoin_x(BITJOIN,134)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_bitjoin_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_msb_const_0_x_q & in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl;

    -- mm_reg_3_data_x(REG,87)@0
    mm_reg_3_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_3_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl = "1") THEN
                    mm_reg_3_data_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_3_const_3_x(CONSTANT,41)
    addr_3_const_3_x_q <= "000011";

    -- addr_3_cmp_x(LOGICAL,40)@0
    addr_3_cmp_x_q <= "1" WHEN addr_3_const_3_x_q = busIn_address ELSE "0";

    -- addr_3_readHit_and_x(LOGICAL,177)@0
    addr_3_readHit_and_x_q <= addr_3_cmp_x_q and busIn_read;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_bitjoin_x(BITJOIN,132)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_bitjoin_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_msb_const_0_x_q & in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl;

    -- mm_reg_0_data_x(REG,83)@0
    mm_reg_0_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_0_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl = "1") THEN
                    mm_reg_0_data_x_q <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_bitjoin_x_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_0_const_0_x(CONSTANT,37)
    addr_0_const_0_x_q <= "000000";

    -- addr_0_cmp_x(LOGICAL,36)@0
    addr_0_cmp_x_q <= "1" WHEN addr_0_const_0_x_q = busIn_address ELSE "0";

    -- addr_0_readHit_and_x(LOGICAL,174)@0
    addr_0_readHit_and_x_q <= addr_0_cmp_x_q and busIn_read;

    -- addr_47_const_47_x(CONSTANT,71)
    addr_47_const_47_x_q <= "101111";

    -- addr_47_cmp_x(LOGICAL,70)@0
    addr_47_cmp_x_q <= "1" WHEN addr_47_const_47_x_q = busIn_address ELSE "0";

    -- addr_47_writeHit_and_x(LOGICAL,207)@0
    addr_47_writeHit_and_x_q <= addr_47_cmp_x_q and busIn_write;

    -- mm_reg_47_data_x(REG,117)@0
    mm_reg_47_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_47_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_47_writeHit_and_x_q = "1") THEN
                    mm_reg_47_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_47_readHit_and_x(LOGICAL,206)@0
    addr_47_readHit_and_x_q <= addr_47_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id5(SELECTOR,225)@0
    bus_selector_opt_lev0_id5_combproc: PROCESS (addr_47_readHit_and_x_q, mm_reg_47_data_x_q, addr_0_readHit_and_x_q, mm_reg_0_data_x_q, addr_3_readHit_and_x_q, mm_reg_3_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id5_q <= (others => '0');
        bus_selector_opt_lev0_id5_v <= "0";
        IF (addr_3_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id5_q <= mm_reg_3_data_x_q;
            bus_selector_opt_lev0_id5_v <= "1";
        END IF;
        IF (addr_0_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id5_q <= mm_reg_0_data_x_q;
            bus_selector_opt_lev0_id5_v <= "1";
        END IF;
        IF (addr_47_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id5_q <= mm_reg_47_data_x_q;
            bus_selector_opt_lev0_id5_v <= "1";
        END IF;
    END PROCESS;

    -- addr_38_const_38_x(CONSTANT,69)
    addr_38_const_38_x_q <= "100110";

    -- addr_38_cmp_x(LOGICAL,68)@0
    addr_38_cmp_x_q <= "1" WHEN addr_38_const_38_x_q = busIn_address ELSE "0";

    -- addr_38_writeHit_and_x(LOGICAL,205)@0
    addr_38_writeHit_and_x_q <= addr_38_cmp_x_q and busIn_write;

    -- mm_reg_38_data_x(REG,115)@0
    mm_reg_38_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_38_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_38_writeHit_and_x_q = "1") THEN
                    mm_reg_38_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_38_readHit_and_x(LOGICAL,204)@0
    addr_38_readHit_and_x_q <= addr_38_cmp_x_q and busIn_read;

    -- addr_37_const_37_x(CONSTANT,67)
    addr_37_const_37_x_q <= "100101";

    -- addr_37_cmp_x(LOGICAL,66)@0
    addr_37_cmp_x_q <= "1" WHEN addr_37_const_37_x_q = busIn_address ELSE "0";

    -- addr_37_writeHit_and_x(LOGICAL,203)@0
    addr_37_writeHit_and_x_q <= addr_37_cmp_x_q and busIn_write;

    -- mm_reg_37_data_x(REG,113)@0
    mm_reg_37_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_37_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_37_writeHit_and_x_q = "1") THEN
                    mm_reg_37_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_37_readHit_and_x(LOGICAL,202)@0
    addr_37_readHit_and_x_q <= addr_37_cmp_x_q and busIn_read;

    -- addr_35_const_35_x(CONSTANT,65)
    addr_35_const_35_x_q <= "100011";

    -- addr_35_cmp_x(LOGICAL,64)@0
    addr_35_cmp_x_q <= "1" WHEN addr_35_const_35_x_q = busIn_address ELSE "0";

    -- addr_35_writeHit_and_x(LOGICAL,201)@0
    addr_35_writeHit_and_x_q <= addr_35_cmp_x_q and busIn_write;

    -- mm_reg_35_data_x(REG,111)@0
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

    -- addr_35_readHit_and_x(LOGICAL,200)@0
    addr_35_readHit_and_x_q <= addr_35_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id4(SELECTOR,224)@0
    bus_selector_opt_lev0_id4_combproc: PROCESS (addr_35_readHit_and_x_q, mm_reg_35_data_x_q, addr_37_readHit_and_x_q, mm_reg_37_data_x_q, addr_38_readHit_and_x_q, mm_reg_38_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id4_q <= (others => '0');
        bus_selector_opt_lev0_id4_v <= "0";
        IF (addr_38_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id4_q <= mm_reg_38_data_x_q;
            bus_selector_opt_lev0_id4_v <= "1";
        END IF;
        IF (addr_37_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id4_q <= mm_reg_37_data_x_q;
            bus_selector_opt_lev0_id4_v <= "1";
        END IF;
        IF (addr_35_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id4_q <= mm_reg_35_data_x_q;
            bus_selector_opt_lev0_id4_v <= "1";
        END IF;
    END PROCESS;

    -- addr_34_const_34_x(CONSTANT,63)
    addr_34_const_34_x_q <= "100010";

    -- addr_34_cmp_x(LOGICAL,62)@0
    addr_34_cmp_x_q <= "1" WHEN addr_34_const_34_x_q = busIn_address ELSE "0";

    -- addr_34_writeHit_and_x(LOGICAL,199)@0
    addr_34_writeHit_and_x_q <= addr_34_cmp_x_q and busIn_write;

    -- mm_reg_34_data_x(REG,109)@0
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

    -- addr_34_readHit_and_x(LOGICAL,198)@0
    addr_34_readHit_and_x_q <= addr_34_cmp_x_q and busIn_read;

    -- addr_33_const_33_x(CONSTANT,61)
    addr_33_const_33_x_q <= "100001";

    -- addr_33_cmp_x(LOGICAL,60)@0
    addr_33_cmp_x_q <= "1" WHEN addr_33_const_33_x_q = busIn_address ELSE "0";

    -- addr_33_writeHit_and_x(LOGICAL,197)@0
    addr_33_writeHit_and_x_q <= addr_33_cmp_x_q and busIn_write;

    -- mm_reg_33_data_x(REG,107)@0
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

    -- addr_33_readHit_and_x(LOGICAL,196)@0
    addr_33_readHit_and_x_q <= addr_33_cmp_x_q and busIn_read;

    -- addr_32_const_32_x(CONSTANT,59)
    addr_32_const_32_x_q <= "100000";

    -- addr_32_cmp_x(LOGICAL,58)@0
    addr_32_cmp_x_q <= "1" WHEN addr_32_const_32_x_q = busIn_address ELSE "0";

    -- addr_32_writeHit_and_x(LOGICAL,195)@0
    addr_32_writeHit_and_x_q <= addr_32_cmp_x_q and busIn_write;

    -- mm_reg_32_data_x(REG,105)@0
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

    -- addr_32_readHit_and_x(LOGICAL,194)@0
    addr_32_readHit_and_x_q <= addr_32_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id3(SELECTOR,223)@0
    bus_selector_opt_lev0_id3_combproc: PROCESS (addr_32_readHit_and_x_q, mm_reg_32_data_x_q, addr_33_readHit_and_x_q, mm_reg_33_data_x_q, addr_34_readHit_and_x_q, mm_reg_34_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id3_q <= (others => '0');
        bus_selector_opt_lev0_id3_v <= "0";
        IF (addr_34_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id3_q <= mm_reg_34_data_x_q;
            bus_selector_opt_lev0_id3_v <= "1";
        END IF;
        IF (addr_33_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id3_q <= mm_reg_33_data_x_q;
            bus_selector_opt_lev0_id3_v <= "1";
        END IF;
        IF (addr_32_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id3_q <= mm_reg_32_data_x_q;
            bus_selector_opt_lev0_id3_v <= "1";
        END IF;
    END PROCESS;

    -- bus_selector_opt_lev1_id1(SELECTOR,229)@0
    bus_selector_opt_lev1_id1_combproc: PROCESS (bus_selector_opt_lev0_id3_v, bus_selector_opt_lev0_id3_q, bus_selector_opt_lev0_id4_v, bus_selector_opt_lev0_id4_q, bus_selector_opt_lev0_id5_v, bus_selector_opt_lev0_id5_q)
    BEGIN
        bus_selector_opt_lev1_id1_q <= (others => '0');
        bus_selector_opt_lev1_id1_v <= "0";
        IF (bus_selector_opt_lev0_id5_v = "1") THEN
            bus_selector_opt_lev1_id1_q <= bus_selector_opt_lev0_id5_q;
            bus_selector_opt_lev1_id1_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id4_v = "1") THEN
            bus_selector_opt_lev1_id1_q <= bus_selector_opt_lev0_id4_q;
            bus_selector_opt_lev1_id1_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id3_v = "1") THEN
            bus_selector_opt_lev1_id1_q <= bus_selector_opt_lev0_id3_q;
            bus_selector_opt_lev1_id1_v <= "1";
        END IF;
    END PROCESS;

    -- addr_31_const_31_x(CONSTANT,57)
    addr_31_const_31_x_q <= "011111";

    -- addr_31_cmp_x(LOGICAL,56)@0
    addr_31_cmp_x_q <= "1" WHEN addr_31_const_31_x_q = busIn_address ELSE "0";

    -- addr_31_writeHit_and_x(LOGICAL,193)@0
    addr_31_writeHit_and_x_q <= addr_31_cmp_x_q and busIn_write;

    -- mm_reg_31_data_x(REG,103)@0
    mm_reg_31_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_31_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_31_writeHit_and_x_q = "1") THEN
                    mm_reg_31_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_31_readHit_and_x(LOGICAL,192)@0
    addr_31_readHit_and_x_q <= addr_31_cmp_x_q and busIn_read;

    -- addr_22_const_22_x(CONSTANT,55)
    addr_22_const_22_x_q <= "010110";

    -- addr_22_cmp_x(LOGICAL,54)@0
    addr_22_cmp_x_q <= "1" WHEN addr_22_const_22_x_q = busIn_address ELSE "0";

    -- addr_22_writeHit_and_x(LOGICAL,191)@0
    addr_22_writeHit_and_x_q <= addr_22_cmp_x_q and busIn_write;

    -- mm_reg_22_data_x(REG,101)@0
    mm_reg_22_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_22_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_22_writeHit_and_x_q = "1") THEN
                    mm_reg_22_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_22_readHit_and_x(LOGICAL,190)@0
    addr_22_readHit_and_x_q <= addr_22_cmp_x_q and busIn_read;

    -- addr_21_const_21_x(CONSTANT,53)
    addr_21_const_21_x_q <= "010101";

    -- addr_21_cmp_x(LOGICAL,52)@0
    addr_21_cmp_x_q <= "1" WHEN addr_21_const_21_x_q = busIn_address ELSE "0";

    -- addr_21_writeHit_and_x(LOGICAL,189)@0
    addr_21_writeHit_and_x_q <= addr_21_cmp_x_q and busIn_write;

    -- mm_reg_21_data_x(REG,99)@0
    mm_reg_21_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_21_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_21_writeHit_and_x_q = "1") THEN
                    mm_reg_21_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_21_readHit_and_x(LOGICAL,188)@0
    addr_21_readHit_and_x_q <= addr_21_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id2(SELECTOR,222)@0
    bus_selector_opt_lev0_id2_combproc: PROCESS (addr_21_readHit_and_x_q, mm_reg_21_data_x_q, addr_22_readHit_and_x_q, mm_reg_22_data_x_q, addr_31_readHit_and_x_q, mm_reg_31_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id2_q <= (others => '0');
        bus_selector_opt_lev0_id2_v <= "0";
        IF (addr_31_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id2_q <= mm_reg_31_data_x_q;
            bus_selector_opt_lev0_id2_v <= "1";
        END IF;
        IF (addr_22_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id2_q <= mm_reg_22_data_x_q;
            bus_selector_opt_lev0_id2_v <= "1";
        END IF;
        IF (addr_21_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id2_q <= mm_reg_21_data_x_q;
            bus_selector_opt_lev0_id2_v <= "1";
        END IF;
    END PROCESS;

    -- addr_20_const_20_x(CONSTANT,51)
    addr_20_const_20_x_q <= "010100";

    -- addr_20_cmp_x(LOGICAL,50)@0
    addr_20_cmp_x_q <= "1" WHEN addr_20_const_20_x_q = busIn_address ELSE "0";

    -- addr_20_writeHit_and_x(LOGICAL,187)@0
    addr_20_writeHit_and_x_q <= addr_20_cmp_x_q and busIn_write;

    -- mm_reg_20_data_x(REG,97)@0
    mm_reg_20_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_20_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_20_writeHit_and_x_q = "1") THEN
                    mm_reg_20_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_20_readHit_and_x(LOGICAL,186)@0
    addr_20_readHit_and_x_q <= addr_20_cmp_x_q and busIn_read;

    -- addr_19_const_19_x(CONSTANT,49)
    addr_19_const_19_x_q <= "010011";

    -- addr_19_cmp_x(LOGICAL,48)@0
    addr_19_cmp_x_q <= "1" WHEN addr_19_const_19_x_q = busIn_address ELSE "0";

    -- addr_19_writeHit_and_x(LOGICAL,185)@0
    addr_19_writeHit_and_x_q <= addr_19_cmp_x_q and busIn_write;

    -- mm_reg_19_data_x(REG,95)@0
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

    -- addr_19_readHit_and_x(LOGICAL,184)@0
    addr_19_readHit_and_x_q <= addr_19_cmp_x_q and busIn_read;

    -- addr_18_const_18_x(CONSTANT,47)
    addr_18_const_18_x_q <= "010010";

    -- addr_18_cmp_x(LOGICAL,46)@0
    addr_18_cmp_x_q <= "1" WHEN addr_18_const_18_x_q = busIn_address ELSE "0";

    -- addr_18_writeHit_and_x(LOGICAL,183)@0
    addr_18_writeHit_and_x_q <= addr_18_cmp_x_q and busIn_write;

    -- mm_reg_18_data_x(REG,93)@0
    mm_reg_18_data_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                mm_reg_18_data_x_q <= "00000000000000000000000000000000";
            ELSE
                IF (addr_18_writeHit_and_x_q = "1") THEN
                    mm_reg_18_data_x_q <= busIn_writedata;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- addr_18_readHit_and_x(LOGICAL,182)@0
    addr_18_readHit_and_x_q <= addr_18_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id1(SELECTOR,221)@0
    bus_selector_opt_lev0_id1_combproc: PROCESS (addr_18_readHit_and_x_q, mm_reg_18_data_x_q, addr_19_readHit_and_x_q, mm_reg_19_data_x_q, addr_20_readHit_and_x_q, mm_reg_20_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id1_q <= (others => '0');
        bus_selector_opt_lev0_id1_v <= "0";
        IF (addr_20_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id1_q <= mm_reg_20_data_x_q;
            bus_selector_opt_lev0_id1_v <= "1";
        END IF;
        IF (addr_19_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id1_q <= mm_reg_19_data_x_q;
            bus_selector_opt_lev0_id1_v <= "1";
        END IF;
        IF (addr_18_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id1_q <= mm_reg_18_data_x_q;
            bus_selector_opt_lev0_id1_v <= "1";
        END IF;
    END PROCESS;

    -- addr_17_const_17_x(CONSTANT,45)
    addr_17_const_17_x_q <= "010001";

    -- addr_17_cmp_x(LOGICAL,44)@0
    addr_17_cmp_x_q <= "1" WHEN addr_17_const_17_x_q = busIn_address ELSE "0";

    -- addr_17_writeHit_and_x(LOGICAL,181)@0
    addr_17_writeHit_and_x_q <= addr_17_cmp_x_q and busIn_write;

    -- mm_reg_17_data_x(REG,91)@0
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

    -- addr_17_readHit_and_x(LOGICAL,180)@0
    addr_17_readHit_and_x_q <= addr_17_cmp_x_q and busIn_read;

    -- addr_16_const_16_x(CONSTANT,43)
    addr_16_const_16_x_q <= "010000";

    -- addr_16_cmp_x(LOGICAL,42)@0
    addr_16_cmp_x_q <= "1" WHEN addr_16_const_16_x_q = busIn_address ELSE "0";

    -- addr_16_writeHit_and_x(LOGICAL,179)@0
    addr_16_writeHit_and_x_q <= addr_16_cmp_x_q and busIn_write;

    -- mm_reg_16_data_x(REG,89)@0
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

    -- addr_16_readHit_and_x(LOGICAL,178)@0
    addr_16_readHit_and_x_q <= addr_16_cmp_x_q and busIn_read;

    -- addr_1_const_1_x(CONSTANT,39)
    addr_1_const_1_x_q <= "000001";

    -- addr_1_cmp_x(LOGICAL,38)@0
    addr_1_cmp_x_q <= "1" WHEN addr_1_const_1_x_q = busIn_address ELSE "0";

    -- addr_1_writeHit_and_x(LOGICAL,176)@0
    addr_1_writeHit_and_x_q <= addr_1_cmp_x_q and busIn_write;

    -- mm_reg_1_data_x(REG,85)@0
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

    -- addr_1_readHit_and_x(LOGICAL,175)@0
    addr_1_readHit_and_x_q <= addr_1_cmp_x_q and busIn_read;

    -- bus_selector_opt_lev0_id0(SELECTOR,220)@0
    bus_selector_opt_lev0_id0_combproc: PROCESS (addr_1_readHit_and_x_q, mm_reg_1_data_x_q, addr_16_readHit_and_x_q, mm_reg_16_data_x_q, addr_17_readHit_and_x_q, mm_reg_17_data_x_q)
    BEGIN
        bus_selector_opt_lev0_id0_q <= (others => '0');
        bus_selector_opt_lev0_id0_v <= "0";
        IF (addr_17_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id0_q <= mm_reg_17_data_x_q;
            bus_selector_opt_lev0_id0_v <= "1";
        END IF;
        IF (addr_16_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id0_q <= mm_reg_16_data_x_q;
            bus_selector_opt_lev0_id0_v <= "1";
        END IF;
        IF (addr_1_readHit_and_x_q = "1") THEN
            bus_selector_opt_lev0_id0_q <= mm_reg_1_data_x_q;
            bus_selector_opt_lev0_id0_v <= "1";
        END IF;
    END PROCESS;

    -- bus_selector_opt_lev1_id0(SELECTOR,228)@0
    bus_selector_opt_lev1_id0_combproc: PROCESS (bus_selector_opt_lev0_id0_v, bus_selector_opt_lev0_id0_q, bus_selector_opt_lev0_id1_v, bus_selector_opt_lev0_id1_q, bus_selector_opt_lev0_id2_v, bus_selector_opt_lev0_id2_q)
    BEGIN
        bus_selector_opt_lev1_id0_q <= (others => '0');
        bus_selector_opt_lev1_id0_v <= "0";
        IF (bus_selector_opt_lev0_id2_v = "1") THEN
            bus_selector_opt_lev1_id0_q <= bus_selector_opt_lev0_id2_q;
            bus_selector_opt_lev1_id0_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id1_v = "1") THEN
            bus_selector_opt_lev1_id0_q <= bus_selector_opt_lev0_id1_q;
            bus_selector_opt_lev1_id0_v <= "1";
        END IF;
        IF (bus_selector_opt_lev0_id0_v = "1") THEN
            bus_selector_opt_lev1_id0_q <= bus_selector_opt_lev0_id0_q;
            bus_selector_opt_lev1_id0_v <= "1";
        END IF;
    END PROCESS;

    -- bus_selector_opt_lev2_id0(SELECTOR,231)@0 + 1
    bus_selector_opt_lev2_id0_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                bus_selector_opt_lev2_id0_q <= (others => '0');
                bus_selector_opt_lev2_id0_v <= (others => '0');
            ELSE
                bus_selector_opt_lev2_id0_q <= STD_LOGIC_VECTOR("0000000000000000000000000000000" & GND_q);
                bus_selector_opt_lev2_id0_v <= "0";
                IF (bus_selector_opt_lev1_id2_v = "1") THEN
                    bus_selector_opt_lev2_id0_q <= bus_selector_opt_lev1_id2_q;
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

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_bitsel_x(BITSELECT,128)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_bitsel_x_b <= mm_reg_37_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl(GPOUT,20)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_bitsel_x(BITSELECT,130)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_bitsel_x_b <= mm_reg_38_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl(GPOUT,21)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_bitsel_x(BITSELECT,136)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_bitsel_x_b <= mm_reg_1_data_x_q(0 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl(GPOUT,22)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_bitsel_x(BITSELECT,138)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_bitsel_x_b <= mm_reg_47_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl(GPOUT,23)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_bitsel_x(BITSELECT,140)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_bitsel_x_b <= mm_reg_20_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl(GPOUT,24)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_bitsel_x(BITSELECT,142)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_bitsel_x_b <= mm_reg_21_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl(GPOUT,25)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_bitsel_x(BITSELECT,144)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_bitsel_x_b <= mm_reg_35_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl(GPOUT,26)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_bitsel_x(BITSELECT,146)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_bitsel_x_b <= mm_reg_19_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl(GPOUT,27)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_bitsel_x(BITSELECT,148)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_bitsel_x_b <= mm_reg_17_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl(GPOUT,28)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_bitsel_x(BITSELECT,150)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_bitsel_x_b <= mm_reg_16_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl(GPOUT,29)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_bitsel_x(BITSELECT,154)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_bitsel_x_b <= mm_reg_32_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl(GPOUT,30)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_bitsel_x(BITSELECT,156)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_bitsel_x_b <= mm_reg_31_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl(GPOUT,31)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_bitsel_x(BITSELECT,158)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_bitsel_x_b <= mm_reg_33_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl(GPOUT,32)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_bitsel_x(BITSELECT,160)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_bitsel_x_b <= mm_reg_34_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl(GPOUT,33)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_bitsel_x(BITSELECT,170)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_bitsel_x_b <= mm_reg_22_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl(GPOUT,34)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_bitsel_x_b;

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_bitsel_x(BITSELECT,172)@0
    motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_bitsel_x_b <= mm_reg_18_data_x_q(15 downto 0);

    -- out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl(GPOUT,35)@0
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_bitsel_x_b;

END normal;
