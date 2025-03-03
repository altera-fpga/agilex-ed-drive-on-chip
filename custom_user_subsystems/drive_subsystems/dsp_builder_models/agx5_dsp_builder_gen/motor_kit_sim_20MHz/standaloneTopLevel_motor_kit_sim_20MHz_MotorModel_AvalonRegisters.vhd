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

-- VHDL created from standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters
-- VHDL created on Wed Aug  7 11:03:58 2024


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
entity standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters is
    port (
        busIn_writedata : in std_logic_vector(31 downto 0);  -- ufix32
        busIn_address : in std_logic_vector(5 downto 0);  -- ufix6
        busIn_write : in std_logic_vector(0 downto 0);  -- ufix1
        busIn_read : in std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdata : out std_logic_vector(31 downto 0);  -- ufix32
        busOut_waitrequest : out std_logic_vector(0 downto 0);  -- ufix1
        MM_valid_out : in std_logic_vector(0 downto 0);  -- ufix1
        ia_A : in std_logic_vector(15 downto 0);  -- sfix16_en9
        ib_A : in std_logic_vector(15 downto 0);  -- sfix16_en9
        ic_A : in std_logic_vector(15 downto 0);  -- sfix16_en9
        dTheta_dt_rad_s : in std_logic_vector(15 downto 0);  -- sfix16_en6
        ThetaMech_one_turn : in std_logic_vector(15 downto 0);  -- ufix16_en16
        ready : in std_logic_vector(0 downto 0);  -- ufix1
        MM_valid_in : out std_logic_vector(0 downto 0);  -- ufix1
        Vabc_range_V_cfg : out std_logic_vector(15 downto 0);  -- sfix16
        Va_V : out std_logic_vector(15 downto 0);  -- sfix16_en6
        Vb_V : out std_logic_vector(15 downto 0);  -- sfix16_en6
        Vc_V : out std_logic_vector(15 downto 0);  -- sfix16_en6
        SampleTime_s_cfg : out std_logic_vector(15 downto 0);  -- ufix16_en39
        Rphase_ohm_cfg : out std_logic_vector(15 downto 0);  -- ufix16_en16
        inv_Lphase_1_H_cfg : out std_logic_vector(15 downto 0);  -- ufix16_en6
        PolePairs_int_cfg : out std_logic_vector(15 downto 0);  -- ufix16_en14
        Ke_Vs_rad_cfg : out std_logic_vector(15 downto 0);  -- ufix16_en16
        Kt_Nm_A_cfg : out std_logic_vector(15 downto 0);  -- ufix16_en16
        inv_J_1_kgm2_cfg : out std_logic_vector(15 downto 0);  -- ufix16
        LoadT_Nm : out std_logic_vector(15 downto 0);  -- sfix16_en14
        DC_link_range_V_cfg : out std_logic_vector(15 downto 0);  -- sfix16
        DC_link_V : out std_logic_vector(15 downto 0);  -- sfix16_en6
        Iabc_range_cfg : out std_logic_vector(15 downto 0);  -- sfix16
        clk : in std_logic;
        areset : in std_logic;
        h_areset : in std_logic
    );
end standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters;

architecture normal of standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component motor_kit_sim_20MHz_MotorModel_AvalonRegisters is
        port (
            in_1_MM_valid_out_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_2_ia_A_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_3_ib_A_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_4_ic_A_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_5_dTheta_dt_rad_s_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_6_ThetaMech_one_turn_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_7_ready_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_MM_valid_in_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_2_Vabc_range_V_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_3_Va_V_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_4_Vb_V_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_5_Vc_V_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_6_SampleTime_s_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_7_Rphase_ohm_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_8_inv_Lphase_1_H_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_9_PolePairs_int_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_10_Ke_Vs_rad_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_11_Kt_Nm_A_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_12_inv_J_1_kgm2_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_13_LoadT_Nm_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_14_DC_link_range_V_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_15_DC_link_V_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_16_Iabc_range_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz is
        port (
            busIn_writedata : in std_logic_vector(31 downto 0);  -- Fixed Point
            busIn_address : in std_logic_vector(5 downto 0);  -- Fixed Point
            busIn_write : in std_logic_vector(0 downto 0);  -- Fixed Point
            busIn_read : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            busOut_readdata : out std_logic_vector(31 downto 0);  -- Fixed Point
            busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic;
            h_areset : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_1_MM_valid_in_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_2_Vabc_range_V_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_3_Va_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_4_Vb_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_5_Vc_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_6_SampleTime_s_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_7_Rphase_ohm_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_8_inv_Lphase_1_H_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_9_PolePairs_int_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_10_Ke_Vs_rad_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_11_Kt_Nm_A_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_12_inv_J_1_kgm2_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_13_LoadT_Nm_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_14_DC_link_range_V_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_15_DC_link_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_16_Iabc_range_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_busOut_readdata : STD_LOGIC_VECTOR (31 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_busOut_readdatavalid : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDelayed_q : STD_LOGIC_VECTOR (0 downto 0);
    signal standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDataValid_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- motor_kit_sim_20MHz_MotorModel_AvalonRegisters(BLACKBOX,4)
    themotor_kit_sim_20MHz_MotorModel_AvalonRegisters : motor_kit_sim_20MHz_MotorModel_AvalonRegisters
    PORT MAP (
        in_1_MM_valid_out_tpl => MM_valid_out,
        in_2_ia_A_tpl => ia_A,
        in_3_ib_A_tpl => ib_A,
        in_4_ic_A_tpl => ic_A,
        in_5_dTheta_dt_rad_s_tpl => dTheta_dt_rad_s,
        in_6_ThetaMech_one_turn_tpl => ThetaMech_one_turn,
        in_7_ready_tpl => ready,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl,
        out_1_MM_valid_in_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_1_MM_valid_in_tpl,
        out_2_Vabc_range_V_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_2_Vabc_range_V_cfg_tpl,
        out_3_Va_V_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_3_Va_V_tpl,
        out_4_Vb_V_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_4_Vb_V_tpl,
        out_5_Vc_V_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_5_Vc_V_tpl,
        out_6_SampleTime_s_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_6_SampleTime_s_cfg_tpl,
        out_7_Rphase_ohm_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_7_Rphase_ohm_cfg_tpl,
        out_8_inv_Lphase_1_H_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_8_inv_Lphase_1_H_cfg_tpl,
        out_9_PolePairs_int_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_9_PolePairs_int_cfg_tpl,
        out_10_Ke_Vs_rad_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_10_Ke_Vs_rad_cfg_tpl,
        out_11_Kt_Nm_A_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_11_Kt_Nm_A_cfg_tpl,
        out_12_inv_J_1_kgm2_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_12_inv_J_1_kgm2_cfg_tpl,
        out_13_LoadT_Nm_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_13_LoadT_Nm_tpl,
        out_14_DC_link_range_V_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_14_DC_link_range_V_cfg_tpl,
        out_15_DC_link_V_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_15_DC_link_V_tpl,
        out_16_Iabc_range_cfg_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_16_Iabc_range_cfg_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        clk => clk,
        areset => areset
    );

    -- busFabric_motor_kit_sim_20MHz_MotorModel_x(BLACKBOX,5)
    thebusFabric_motor_kit_sim_20MHz_MotorModel_x : busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz
    PORT MAP (
        busIn_writedata => busIn_writedata,
        busIn_address => busIn_address,
        busIn_write => busIn_write,
        busIn_read => busIn_read,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        busOut_readdata => busFabric_motor_kit_sim_20MHz_MotorModel_x_busOut_readdata,
        busOut_readdatavalid => busFabric_motor_kit_sim_20MHz_MotorModel_x_busOut_readdatavalid,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl => busFabric_motor_kit_sim_20MHz_MotorModel_x_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl,
        clk => clk,
        areset => areset,
        h_areset => h_areset
    );

    -- standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDelayed(DELAY,45)
    standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDelayed_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDelayed_q <= (others => '0');
            ELSE
                standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDelayed_q <= STD_LOGIC_VECTOR(busIn_read);
            END IF;
        END IF;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDataValid(LOGICAL,46)
    standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDataValid_q <= busFabric_motor_kit_sim_20MHz_MotorModel_x_busOut_readdatavalid or standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDelayed_q;

    -- busOut(BUSOUT,3)
    busOut_readdatavalid <= standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_readDataValid_q;
    busOut_readdata <= busFabric_motor_kit_sim_20MHz_MotorModel_x_busOut_readdata;
    busOut_waitrequest <= GND_q;

    -- MM_valid_in(GPOUT,13)
    MM_valid_in <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_1_MM_valid_in_tpl;

    -- Vabc_range_V_cfg(GPOUT,14)
    Vabc_range_V_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_2_Vabc_range_V_cfg_tpl;

    -- Va_V(GPOUT,15)
    Va_V <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_3_Va_V_tpl;

    -- Vb_V(GPOUT,16)
    Vb_V <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_4_Vb_V_tpl;

    -- Vc_V(GPOUT,17)
    Vc_V <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_5_Vc_V_tpl;

    -- SampleTime_s_cfg(GPOUT,18)
    SampleTime_s_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_6_SampleTime_s_cfg_tpl;

    -- Rphase_ohm_cfg(GPOUT,19)
    Rphase_ohm_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_7_Rphase_ohm_cfg_tpl;

    -- inv_Lphase_1_H_cfg(GPOUT,20)
    inv_Lphase_1_H_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_8_inv_Lphase_1_H_cfg_tpl;

    -- PolePairs_int_cfg(GPOUT,21)
    PolePairs_int_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_9_PolePairs_int_cfg_tpl;

    -- Ke_Vs_rad_cfg(GPOUT,22)
    Ke_Vs_rad_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_10_Ke_Vs_rad_cfg_tpl;

    -- Kt_Nm_A_cfg(GPOUT,23)
    Kt_Nm_A_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_11_Kt_Nm_A_cfg_tpl;

    -- inv_J_1_kgm2_cfg(GPOUT,24)
    inv_J_1_kgm2_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_12_inv_J_1_kgm2_cfg_tpl;

    -- LoadT_Nm(GPOUT,25)
    LoadT_Nm <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_13_LoadT_Nm_tpl;

    -- DC_link_range_V_cfg(GPOUT,26)
    DC_link_range_V_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_14_DC_link_range_V_cfg_tpl;

    -- DC_link_V(GPOUT,27)
    DC_link_V <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_15_DC_link_V_tpl;

    -- Iabc_range_cfg(GPOUT,28)
    Iabc_range_cfg <= motor_kit_sim_20MHz_MotorModel_AvalonRegisters_out_16_Iabc_range_cfg_tpl;

END normal;
