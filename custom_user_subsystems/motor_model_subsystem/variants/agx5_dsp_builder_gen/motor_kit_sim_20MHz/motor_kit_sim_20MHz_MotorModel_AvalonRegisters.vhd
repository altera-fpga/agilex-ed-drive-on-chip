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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_AvalonRegisters
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
entity motor_kit_sim_20MHz_MotorModel_AvalonRegisters is
    port (
        in_1_MM_valid_out_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_2_ia_A_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en9
        in_3_ib_A_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en9
        in_4_ic_A_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en9
        in_5_dTheta_dt_rad_s_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_6_ThetaMech_one_turn_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_7_ready_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        out_1_MM_valid_in_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_6_SampleTime_s_cfg_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en39
        out_5_Vc_V_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_13_LoadT_Nm_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en14
        out_15_DC_link_V_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_2_Vabc_range_V_cfg_tpl : out std_logic_vector(15 downto 0);  -- sfix16
        out_14_DC_link_range_V_cfg_tpl : out std_logic_vector(15 downto 0);  -- sfix16
        out_16_Iabc_range_cfg_tpl : out std_logic_vector(15 downto 0);  -- sfix16
        out_7_Rphase_ohm_cfg_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_8_inv_Lphase_1_H_cfg_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en6
        out_9_PolePairs_int_cfg_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en14
        out_10_Ke_Vs_rad_cfg_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_11_Kt_Nm_A_cfg_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_12_inv_J_1_kgm2_cfg_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_3_Va_V_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_4_Vb_V_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en14
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en14
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en39
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en6
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en9
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en9
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en9
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end motor_kit_sim_20MHz_MotorModel_AvalonRegisters;

architecture normal of motor_kit_sim_20MHz_MotorModel_AvalonRegisters is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Not1_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GPOut(GPOUT,10)@0
    out_1_MM_valid_in_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl;

    -- GPOut1(GPOUT,11)@0
    out_6_SampleTime_s_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl;

    -- GPOut10(GPOUT,12)@0
    out_5_Vc_V_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl;

    -- GPOut11(GPOUT,13)@0
    out_13_LoadT_Nm_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl;

    -- GPOut12(GPOUT,14)@0
    out_15_DC_link_V_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl;

    -- GPOut13(GPOUT,15)@0
    out_2_Vabc_range_V_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl;

    -- GPOut14(GPOUT,16)@0
    out_14_DC_link_range_V_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl;

    -- GPOut15(GPOUT,17)@0
    out_16_Iabc_range_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl;

    -- GPOut2(GPOUT,18)@0
    out_7_Rphase_ohm_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl;

    -- GPOut3(GPOUT,19)@0
    out_8_inv_Lphase_1_H_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl;

    -- GPOut4(GPOUT,20)@0
    out_9_PolePairs_int_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl;

    -- GPOut5(GPOUT,21)@0
    out_10_Ke_Vs_rad_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl;

    -- GPOut6(GPOUT,22)@0
    out_11_Kt_Nm_A_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl;

    -- GPOut7(GPOUT,23)@0
    out_12_inv_J_1_kgm2_cfg_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl;

    -- GPOut8(GPOUT,24)@0
    out_3_Va_V_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl;

    -- GPOut9(GPOUT,25)@0
    out_4_Vb_V_tpl <= in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- Not1(LOGICAL,26)@0
    Not1_q <= not (in_7_ready_tpl);

    -- out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl(GPOUT,59)@0
    out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl <= Not1_q;

    -- out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl(GPOUT,60)@0
    out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl <= in_1_MM_valid_out_tpl;

    -- out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl(GPOUT,61)@0
    out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl <= in_6_ThetaMech_one_turn_tpl;

    -- out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl(GPOUT,62)@0
    out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl <= in_5_dTheta_dt_rad_s_tpl;

    -- out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl(GPOUT,63)@0
    out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl <= in_2_ia_A_tpl;

    -- out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl(GPOUT,64)@0
    out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl <= in_3_ib_A_tpl;

    -- out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl(GPOUT,65)@0
    out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl <= in_4_ic_A_tpl;

    -- out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl(GPOUT,66)@0
    out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl <= VCC_q;

    -- out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl(GPOUT,67)@0
    out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl <= in_1_MM_valid_out_tpl;

    -- out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl(GPOUT,68)@0
    out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl <= in_1_MM_valid_out_tpl;

    -- out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl(GPOUT,69)@0
    out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl <= in_1_MM_valid_out_tpl;

    -- out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl(GPOUT,70)@0
    out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl <= in_1_MM_valid_out_tpl;

    -- out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl(GPOUT,71)@0
    out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl <= in_1_MM_valid_out_tpl;

    -- out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl(GPOUT,72)@0
    out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl <= in_1_MM_valid_out_tpl;

END normal;
