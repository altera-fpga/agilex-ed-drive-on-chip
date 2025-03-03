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

-- VHDL created from motor_kit_sim_20MHz_MotorModel
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
entity motor_kit_sim_20MHz_MotorModel is
    port (
        busIn_writedata : in std_logic_vector(31 downto 0);  -- ufix32
        busIn_address : in std_logic_vector(5 downto 0);  -- ufix6
        busIn_write : in std_logic_vector(0 downto 0);  -- ufix1
        busIn_read : in std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdata : out std_logic_vector(31 downto 0);  -- ufix32
        busOut_waitrequest : out std_logic_vector(0 downto 0);  -- ufix1
        u_h : in std_logic_vector(0 downto 0);  -- ufix1
        v_h : in std_logic_vector(0 downto 0);  -- ufix1
        w_h : in std_logic_vector(0 downto 0);  -- ufix1
        u_l : in std_logic_vector(0 downto 0);  -- ufix1
        v_l : in std_logic_vector(0 downto 0);  -- ufix1
        w_l : in std_logic_vector(0 downto 0);  -- ufix1
        powerdown_p : in std_logic_vector(0 downto 0);  -- ufix1
        powerdown_n : in std_logic_vector(0 downto 0);  -- ufix1
        ia_sd : out std_logic_vector(0 downto 0);  -- ufix1
        ib_sd : out std_logic_vector(0 downto 0);  -- ufix1
        ic_sd : out std_logic_vector(0 downto 0);  -- ufix1
        Va_sd : out std_logic_vector(0 downto 0);  -- ufix1
        Vb_sd : out std_logic_vector(0 downto 0);  -- ufix1
        Vc_sd : out std_logic_vector(0 downto 0);  -- ufix1
        QEP_A : out std_logic_vector(0 downto 0);  -- ufix1_en13
        QEP_B : out std_logic_vector(0 downto 0);  -- ufix1_en13
        Theta_one_turn_k : out std_logic_vector(15 downto 0);  -- ufix16_en16
        V_DC_link_sd : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic;
        h_areset : in std_logic
    );
end motor_kit_sim_20MHz_MotorModel;

architecture normal of motor_kit_sim_20MHz_MotorModel is

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


    component motor_kit_sim_20MHz_MotorModel_Current_scale_64_x is
        port (
            in_1_Current_range_int16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_Current_sfix16_En10_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Current_scale_64_1 is
        port (
            in_1_Current_range_int16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_Current_sfix16_En10_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Current_scale_64_2 is
        port (
            in_1_Current_range_int16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_Current_sfix16_En10_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse is
        port (
            in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse1 is
        port (
            in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse2 is
        port (
            in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3 is
        port (
            in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse4 is
        port (
            in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse5 is
        port (
            in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6 is
        port (
            in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_MM_16fixed is
        port (
            in_1_valid_in_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_2_channel_in_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_3_Va_V_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_4_Vb_V_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_5_Vc_V_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_6_u_l_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_7_v_l_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_8_w_l_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_9_SampleTime_s_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_10_Rphase_ohm_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_11_inv_Lphase_1_H_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_12_PolePairs_int_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_13_Ke_Vs_rad_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_14_Kt_Nm_A_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_15_inv_J_1_kgm2_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_16_LoadT_Nm_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_17_DC_link_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_18_Powerdown_p_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_19_Powerdown_n_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_1_valid_out_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_2_channel_out_tpl : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_3_did_dt_A_s_tpl : out std_logic_vector(32 downto 0);  -- Fixed Point
            out_4_diq_dt_A_s_tpl : out std_logic_vector(32 downto 0);  -- Fixed Point
            out_5_ia_A_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_6_ib_A_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_7_ic_A_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_8_id_A_tpl : out std_logic_vector(26 downto 0);  -- Fixed Point
            out_9_iq_A_tpl : out std_logic_vector(26 downto 0);  -- Fixed Point
            out_10_T_Nm_tpl : out std_logic_vector(19 downto 0);  -- Fixed Point
            out_11_Vd_V_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_12_Vq_V_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_13_dTheta_dt_rad_s_k_tpl : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_14_Theta_one_turn_k_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_15_QEP_A_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_16_QEP_B_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_17_DC_link_A_tpl : out std_logic_vector(18 downto 0);  -- Fixed Point
            out_18_ready_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_x is
        port (
            in_1_Voltage_range_int16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_Voltage_sfix16_En9_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_1 is
        port (
            in_1_Voltage_range_int16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_Voltage_sfix16_En9_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_2 is
        port (
            in_1_Voltage_range_int16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_Voltage_sfix16_En9_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V is
        port (
            in_1_Voltage_range_int16_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_Voltage_sfix16_En9_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
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
    signal AvalonRegisters_out_1_MM_valid_in_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_2_Vabc_range_V_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_3_Va_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_4_Vb_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_5_Vc_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_6_SampleTime_s_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_7_Rphase_ohm_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_8_inv_Lphase_1_H_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_9_PolePairs_int_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_10_Ke_Vs_rad_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_11_Kt_Nm_A_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_12_inv_J_1_kgm2_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_13_LoadT_Nm_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_14_DC_link_range_V_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_15_DC_link_V_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_16_Iabc_range_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Constant1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal Current_scale_64_x_out_1_Fraction_ND_ufix16_En16_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Current_scale_64_1_out_1_Fraction_ND_ufix16_En16_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Current_scale_64_2_out_1_Fraction_ND_ufix16_En16_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Fraction_to_Pulse_out_1_PulseDensity_Bool_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Fraction_to_Pulse1_out_1_PulseDensity_Bool_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Fraction_to_Pulse2_out_1_PulseDensity_Bool_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Fraction_to_Pulse3_out_1_PulseDensity_Bool_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Fraction_to_Pulse4_out_1_PulseDensity_Bool_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Fraction_to_Pulse5_out_1_PulseDensity_Bool_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Fraction_to_Pulse6_out_1_PulseDensity_Bool_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal MM_16fixed_out_1_valid_out_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal MM_16fixed_out_5_ia_A_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal MM_16fixed_out_6_ib_A_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal MM_16fixed_out_7_ic_A_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal MM_16fixed_out_13_dTheta_dt_rad_s_k_tpl : STD_LOGIC_VECTOR (31 downto 0);
    signal MM_16fixed_out_14_Theta_one_turn_k_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal MM_16fixed_out_15_QEP_A_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal MM_16fixed_out_16_QEP_B_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal MM_16fixed_out_18_ready_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Voltage_scale_120_x_out_1_Fraction_ND_ufix16_En16_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Voltage_scale_120_1_out_1_Fraction_ND_ufix16_En16_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Voltage_scale_120_2_out_1_Fraction_ND_ufix16_En16_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Voltage_scale_120_link_V_out_1_Fraction_ND_ufix16_En16_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_busOut_readdata : STD_LOGIC_VECTOR (31 downto 0);
    signal busFabric_busOut_readdatavalid : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal speed_sfix16_En6_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_constant_q : STD_LOGIC_VECTOR (13 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_round_select_in : STD_LOGIC_VECTOR (13 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_round_select_b : STD_LOGIC_VECTOR (13 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_keep_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_comp_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_comp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_hi_select_in : STD_LOGIC_VECTOR (14 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_hi_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_lo_select_in : STD_LOGIC_VECTOR (13 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_lo_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_mux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_add_a : STD_LOGIC_VECTOR (19 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_add_b : STD_LOGIC_VECTOR (19 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_add_o : STD_LOGIC_VECTOR (19 downto 0);
    signal speed_sfix16_En6_x_rnd_x_replace_add_q : STD_LOGIC_VECTOR (18 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_readDelayed_q : STD_LOGIC_VECTOR (0 downto 0);
    signal motor_kit_sim_20MHz_MotorModel_readDataValid_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- speed_sfix16_En6_x_rnd_x_replace_hi_select(BITSELECT,53)
    speed_sfix16_En6_x_rnd_x_replace_hi_select_in <= STD_LOGIC_VECTOR(MM_16fixed_out_13_dTheta_dt_rad_s_k_tpl(14 downto 0));
    speed_sfix16_En6_x_rnd_x_replace_hi_select_b <= STD_LOGIC_VECTOR(speed_sfix16_En6_x_rnd_x_replace_hi_select_in(14 downto 14));

    -- speed_sfix16_En6_x_rnd_x_replace_lo_select(BITSELECT,54)
    speed_sfix16_En6_x_rnd_x_replace_lo_select_in <= STD_LOGIC_VECTOR(MM_16fixed_out_13_dTheta_dt_rad_s_k_tpl(13 downto 0));
    speed_sfix16_En6_x_rnd_x_replace_lo_select_b <= STD_LOGIC_VECTOR(speed_sfix16_En6_x_rnd_x_replace_lo_select_in(13 downto 13));

    -- speed_sfix16_En6_x_rnd_x_replace_constant(CONSTANT,49)
    speed_sfix16_En6_x_rnd_x_replace_constant_q <= "10000000000000";

    -- speed_sfix16_En6_x_rnd_x_replace_round_select(BITSELECT,50)
    speed_sfix16_En6_x_rnd_x_replace_round_select_in <= STD_LOGIC_VECTOR(MM_16fixed_out_13_dTheta_dt_rad_s_k_tpl(13 downto 0));
    speed_sfix16_En6_x_rnd_x_replace_round_select_b <= STD_LOGIC_VECTOR(speed_sfix16_En6_x_rnd_x_replace_round_select_in(13 downto 0));

    -- speed_sfix16_En6_x_rnd_x_replace_comp(LOGICAL,52)
    speed_sfix16_En6_x_rnd_x_replace_comp_qi <= "1" WHEN speed_sfix16_En6_x_rnd_x_replace_round_select_b = speed_sfix16_En6_x_rnd_x_replace_constant_q ELSE "0";
    speed_sfix16_En6_x_rnd_x_replace_comp_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => speed_sfix16_En6_x_rnd_x_replace_comp_qi, xout => speed_sfix16_En6_x_rnd_x_replace_comp_q, clk => clk, aclr => areset, ena => '1' );

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- speed_sfix16_En6_x_rnd_x_replace_mux(MUX,55)
    speed_sfix16_En6_x_rnd_x_replace_mux_s <= speed_sfix16_En6_x_rnd_x_replace_comp_q;
    speed_sfix16_En6_x_rnd_x_replace_mux_combproc: PROCESS (speed_sfix16_En6_x_rnd_x_replace_mux_s, speed_sfix16_En6_x_rnd_x_replace_lo_select_b, speed_sfix16_En6_x_rnd_x_replace_hi_select_b)
    BEGIN
        CASE (speed_sfix16_En6_x_rnd_x_replace_mux_s) IS
            WHEN "0" => speed_sfix16_En6_x_rnd_x_replace_mux_q <= speed_sfix16_En6_x_rnd_x_replace_lo_select_b;
            WHEN "1" => speed_sfix16_En6_x_rnd_x_replace_mux_q <= speed_sfix16_En6_x_rnd_x_replace_hi_select_b;
            WHEN OTHERS => speed_sfix16_En6_x_rnd_x_replace_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- speed_sfix16_En6_x_rnd_x_replace_keep_select(BITSELECT,51)
    speed_sfix16_En6_x_rnd_x_replace_keep_select_b <= STD_LOGIC_VECTOR(MM_16fixed_out_13_dTheta_dt_rad_s_k_tpl(31 downto 14));

    -- speed_sfix16_En6_x_rnd_x_replace_add(ADD,56)
    speed_sfix16_En6_x_rnd_x_replace_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => speed_sfix16_En6_x_rnd_x_replace_keep_select_b(17)) & speed_sfix16_En6_x_rnd_x_replace_keep_select_b));
    speed_sfix16_En6_x_rnd_x_replace_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000000000000000" & speed_sfix16_En6_x_rnd_x_replace_mux_q));
    speed_sfix16_En6_x_rnd_x_replace_add_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                speed_sfix16_En6_x_rnd_x_replace_add_o <= (others => '0');
            ELSE
                speed_sfix16_En6_x_rnd_x_replace_add_o <= STD_LOGIC_VECTOR(SIGNED(speed_sfix16_En6_x_rnd_x_replace_add_a) + SIGNED(speed_sfix16_En6_x_rnd_x_replace_add_b));
            END IF;
        END IF;
    END PROCESS;
    speed_sfix16_En6_x_rnd_x_replace_add_q <= speed_sfix16_En6_x_rnd_x_replace_add_o(18 downto 0);

    -- speed_sfix16_En6_sel_x(BITSELECT,44)
    speed_sfix16_En6_sel_x_b <= STD_LOGIC_VECTOR(speed_sfix16_En6_x_rnd_x_replace_add_q(15 downto 0));

    -- Constant1(CONSTANT,4)
    Constant1_q <= "00000000";

    -- MM_16fixed(BLACKBOX,15)
    theMM_16fixed : motor_kit_sim_20MHz_MotorModel_MM_16fixed
    PORT MAP (
        in_1_valid_in_tpl => AvalonRegisters_out_1_MM_valid_in_tpl,
        in_2_channel_in_tpl => Constant1_q,
        in_3_Va_V_tpl => u_h,
        in_4_Vb_V_tpl => v_h,
        in_5_Vc_V_tpl => w_h,
        in_6_u_l_tpl => u_l,
        in_7_v_l_tpl => v_l,
        in_8_w_l_tpl => w_l,
        in_9_SampleTime_s_tpl => AvalonRegisters_out_6_SampleTime_s_cfg_tpl,
        in_10_Rphase_ohm_tpl => AvalonRegisters_out_7_Rphase_ohm_cfg_tpl,
        in_11_inv_Lphase_1_H_tpl => AvalonRegisters_out_8_inv_Lphase_1_H_cfg_tpl,
        in_12_PolePairs_int_tpl => AvalonRegisters_out_9_PolePairs_int_cfg_tpl,
        in_13_Ke_Vs_rad_tpl => AvalonRegisters_out_10_Ke_Vs_rad_cfg_tpl,
        in_14_Kt_Nm_A_tpl => AvalonRegisters_out_11_Kt_Nm_A_cfg_tpl,
        in_15_inv_J_1_kgm2_tpl => AvalonRegisters_out_12_inv_J_1_kgm2_cfg_tpl,
        in_16_LoadT_Nm_tpl => AvalonRegisters_out_13_LoadT_Nm_tpl,
        in_17_DC_link_tpl => AvalonRegisters_out_15_DC_link_V_tpl,
        in_18_Powerdown_p_tpl => powerdown_p,
        in_19_Powerdown_n_tpl => powerdown_n,
        out_1_valid_out_tpl => MM_16fixed_out_1_valid_out_tpl,
        out_5_ia_A_tpl => MM_16fixed_out_5_ia_A_tpl,
        out_6_ib_A_tpl => MM_16fixed_out_6_ib_A_tpl,
        out_7_ic_A_tpl => MM_16fixed_out_7_ic_A_tpl,
        out_13_dTheta_dt_rad_s_k_tpl => MM_16fixed_out_13_dTheta_dt_rad_s_k_tpl,
        out_14_Theta_one_turn_k_tpl => MM_16fixed_out_14_Theta_one_turn_k_tpl,
        out_15_QEP_A_tpl => MM_16fixed_out_15_QEP_A_tpl,
        out_16_QEP_B_tpl => MM_16fixed_out_16_QEP_B_tpl,
        out_18_ready_tpl => MM_16fixed_out_18_ready_tpl,
        clk => clk,
        areset => areset
    );

    -- AvalonRegisters(BLACKBOX,3)
    theAvalonRegisters : motor_kit_sim_20MHz_MotorModel_AvalonRegisters
    PORT MAP (
        in_1_MM_valid_out_tpl => MM_16fixed_out_1_valid_out_tpl,
        in_2_ia_A_tpl => MM_16fixed_out_5_ia_A_tpl,
        in_3_ib_A_tpl => MM_16fixed_out_6_ib_A_tpl,
        in_4_ic_A_tpl => MM_16fixed_out_7_ic_A_tpl,
        in_5_dTheta_dt_rad_s_tpl => speed_sfix16_En6_sel_x_b,
        in_6_ThetaMech_one_turn_tpl => MM_16fixed_out_14_Theta_one_turn_k_tpl,
        in_7_ready_tpl => MM_16fixed_out_18_ready_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl,
        in_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl,
        out_1_MM_valid_in_tpl => AvalonRegisters_out_1_MM_valid_in_tpl,
        out_2_Vabc_range_V_cfg_tpl => AvalonRegisters_out_2_Vabc_range_V_cfg_tpl,
        out_3_Va_V_tpl => AvalonRegisters_out_3_Va_V_tpl,
        out_4_Vb_V_tpl => AvalonRegisters_out_4_Vb_V_tpl,
        out_5_Vc_V_tpl => AvalonRegisters_out_5_Vc_V_tpl,
        out_6_SampleTime_s_cfg_tpl => AvalonRegisters_out_6_SampleTime_s_cfg_tpl,
        out_7_Rphase_ohm_cfg_tpl => AvalonRegisters_out_7_Rphase_ohm_cfg_tpl,
        out_8_inv_Lphase_1_H_cfg_tpl => AvalonRegisters_out_8_inv_Lphase_1_H_cfg_tpl,
        out_9_PolePairs_int_cfg_tpl => AvalonRegisters_out_9_PolePairs_int_cfg_tpl,
        out_10_Ke_Vs_rad_cfg_tpl => AvalonRegisters_out_10_Ke_Vs_rad_cfg_tpl,
        out_11_Kt_Nm_A_cfg_tpl => AvalonRegisters_out_11_Kt_Nm_A_cfg_tpl,
        out_12_inv_J_1_kgm2_cfg_tpl => AvalonRegisters_out_12_inv_J_1_kgm2_cfg_tpl,
        out_13_LoadT_Nm_tpl => AvalonRegisters_out_13_LoadT_Nm_tpl,
        out_14_DC_link_range_V_cfg_tpl => AvalonRegisters_out_14_DC_link_range_V_cfg_tpl,
        out_15_DC_link_V_tpl => AvalonRegisters_out_15_DC_link_V_tpl,
        out_16_Iabc_range_cfg_tpl => AvalonRegisters_out_16_Iabc_range_cfg_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        clk => clk,
        areset => areset
    );

    -- busFabric(BLACKBOX,20)
    thebusFabric : busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz
    PORT MAP (
        busIn_writedata => busIn_writedata,
        busIn_address => busIn_address,
        busIn_write => busIn_write,
        busIn_read => busIn_read,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => AvalonRegisters_out_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl,
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl => AvalonRegisters_out_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl,
        busOut_readdata => busFabric_busOut_readdata,
        busOut_readdatavalid => busFabric_busOut_readdatavalid,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl,
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl => busFabric_out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl,
        clk => clk,
        areset => areset,
        h_areset => h_areset
    );

    -- motor_kit_sim_20MHz_MotorModel_readDelayed(DELAY,57)
    motor_kit_sim_20MHz_MotorModel_readDelayed_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                motor_kit_sim_20MHz_MotorModel_readDelayed_q <= (others => '0');
            ELSE
                motor_kit_sim_20MHz_MotorModel_readDelayed_q <= STD_LOGIC_VECTOR(busIn_read);
            END IF;
        END IF;
    END PROCESS;

    -- motor_kit_sim_20MHz_MotorModel_readDataValid(LOGICAL,58)
    motor_kit_sim_20MHz_MotorModel_readDataValid_q <= busFabric_busOut_readdatavalid or motor_kit_sim_20MHz_MotorModel_readDelayed_q;

    -- busOut(BUSOUT,22)
    busOut_readdatavalid <= motor_kit_sim_20MHz_MotorModel_readDataValid_q;
    busOut_readdata <= busFabric_busOut_readdata;
    busOut_waitrequest <= GND_q;

    -- Current_scale_64_x(BLACKBOX,5)
    theCurrent_scale_64_x : motor_kit_sim_20MHz_MotorModel_Current_scale_64_x
    PORT MAP (
        in_1_Current_range_int16_tpl => AvalonRegisters_out_16_Iabc_range_cfg_tpl,
        in_2_Current_sfix16_En10_tpl => MM_16fixed_out_5_ia_A_tpl,
        out_1_Fraction_ND_ufix16_En16_x_tpl => Current_scale_64_x_out_1_Fraction_ND_ufix16_En16_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Fraction_to_Pulse(BLACKBOX,8)
    theFraction_to_Pulse : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse
    PORT MAP (
        in_1_Fraction_ND_ufix16_En16_tpl => Current_scale_64_x_out_1_Fraction_ND_ufix16_En16_x_tpl,
        out_1_PulseDensity_Bool_x_tpl => Fraction_to_Pulse_out_1_PulseDensity_Bool_x_tpl,
        clk => clk,
        areset => areset
    );

    -- ia_sd(GPOUT,34)
    ia_sd <= Fraction_to_Pulse_out_1_PulseDensity_Bool_x_tpl;

    -- Current_scale_64_1(BLACKBOX,6)
    theCurrent_scale_64_1 : motor_kit_sim_20MHz_MotorModel_Current_scale_64_1
    PORT MAP (
        in_1_Current_range_int16_tpl => AvalonRegisters_out_16_Iabc_range_cfg_tpl,
        in_2_Current_sfix16_En10_tpl => MM_16fixed_out_6_ib_A_tpl,
        out_1_Fraction_ND_ufix16_En16_x_tpl => Current_scale_64_1_out_1_Fraction_ND_ufix16_En16_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Fraction_to_Pulse1(BLACKBOX,9)
    theFraction_to_Pulse1 : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse1
    PORT MAP (
        in_1_Fraction_ND_ufix16_En16_tpl => Current_scale_64_1_out_1_Fraction_ND_ufix16_En16_x_tpl,
        out_1_PulseDensity_Bool_x_tpl => Fraction_to_Pulse1_out_1_PulseDensity_Bool_x_tpl,
        clk => clk,
        areset => areset
    );

    -- ib_sd(GPOUT,35)
    ib_sd <= Fraction_to_Pulse1_out_1_PulseDensity_Bool_x_tpl;

    -- Current_scale_64_2(BLACKBOX,7)
    theCurrent_scale_64_2 : motor_kit_sim_20MHz_MotorModel_Current_scale_64_2
    PORT MAP (
        in_1_Current_range_int16_tpl => AvalonRegisters_out_16_Iabc_range_cfg_tpl,
        in_2_Current_sfix16_En10_tpl => MM_16fixed_out_7_ic_A_tpl,
        out_1_Fraction_ND_ufix16_En16_x_tpl => Current_scale_64_2_out_1_Fraction_ND_ufix16_En16_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Fraction_to_Pulse2(BLACKBOX,10)
    theFraction_to_Pulse2 : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse2
    PORT MAP (
        in_1_Fraction_ND_ufix16_En16_tpl => Current_scale_64_2_out_1_Fraction_ND_ufix16_En16_x_tpl,
        out_1_PulseDensity_Bool_x_tpl => Fraction_to_Pulse2_out_1_PulseDensity_Bool_x_tpl,
        clk => clk,
        areset => areset
    );

    -- ic_sd(GPOUT,36)
    ic_sd <= Fraction_to_Pulse2_out_1_PulseDensity_Bool_x_tpl;

    -- Voltage_scale_120_x(BLACKBOX,16)
    theVoltage_scale_120_x : motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_x
    PORT MAP (
        in_1_Voltage_range_int16_tpl => AvalonRegisters_out_2_Vabc_range_V_cfg_tpl,
        in_2_Voltage_sfix16_En9_tpl => AvalonRegisters_out_3_Va_V_tpl,
        out_1_Fraction_ND_ufix16_En16_x_tpl => Voltage_scale_120_x_out_1_Fraction_ND_ufix16_En16_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Fraction_to_Pulse3(BLACKBOX,11)
    theFraction_to_Pulse3 : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3
    PORT MAP (
        in_1_Fraction_ND_ufix16_En16_tpl => Voltage_scale_120_x_out_1_Fraction_ND_ufix16_En16_x_tpl,
        out_1_PulseDensity_Bool_x_tpl => Fraction_to_Pulse3_out_1_PulseDensity_Bool_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Va_sd(GPOUT,37)
    Va_sd <= Fraction_to_Pulse3_out_1_PulseDensity_Bool_x_tpl;

    -- Voltage_scale_120_1(BLACKBOX,17)
    theVoltage_scale_120_1 : motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_1
    PORT MAP (
        in_1_Voltage_range_int16_tpl => AvalonRegisters_out_2_Vabc_range_V_cfg_tpl,
        in_2_Voltage_sfix16_En9_tpl => AvalonRegisters_out_4_Vb_V_tpl,
        out_1_Fraction_ND_ufix16_En16_x_tpl => Voltage_scale_120_1_out_1_Fraction_ND_ufix16_En16_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Fraction_to_Pulse4(BLACKBOX,12)
    theFraction_to_Pulse4 : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse4
    PORT MAP (
        in_1_Fraction_ND_ufix16_En16_tpl => Voltage_scale_120_1_out_1_Fraction_ND_ufix16_En16_x_tpl,
        out_1_PulseDensity_Bool_x_tpl => Fraction_to_Pulse4_out_1_PulseDensity_Bool_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Vb_sd(GPOUT,38)
    Vb_sd <= Fraction_to_Pulse4_out_1_PulseDensity_Bool_x_tpl;

    -- Voltage_scale_120_2(BLACKBOX,18)
    theVoltage_scale_120_2 : motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_2
    PORT MAP (
        in_1_Voltage_range_int16_tpl => AvalonRegisters_out_2_Vabc_range_V_cfg_tpl,
        in_2_Voltage_sfix16_En9_tpl => AvalonRegisters_out_5_Vc_V_tpl,
        out_1_Fraction_ND_ufix16_En16_x_tpl => Voltage_scale_120_2_out_1_Fraction_ND_ufix16_En16_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Fraction_to_Pulse5(BLACKBOX,13)
    theFraction_to_Pulse5 : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse5
    PORT MAP (
        in_1_Fraction_ND_ufix16_En16_tpl => Voltage_scale_120_2_out_1_Fraction_ND_ufix16_En16_x_tpl,
        out_1_PulseDensity_Bool_x_tpl => Fraction_to_Pulse5_out_1_PulseDensity_Bool_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Vc_sd(GPOUT,39)
    Vc_sd <= Fraction_to_Pulse5_out_1_PulseDensity_Bool_x_tpl;

    -- QEP_A(GPOUT,40)
    QEP_A <= MM_16fixed_out_15_QEP_A_tpl;

    -- QEP_B(GPOUT,41)
    QEP_B <= MM_16fixed_out_16_QEP_B_tpl;

    -- Theta_one_turn_k(GPOUT,42)
    Theta_one_turn_k <= MM_16fixed_out_14_Theta_one_turn_k_tpl;

    -- Voltage_scale_120_link_V(BLACKBOX,19)
    theVoltage_scale_120_link_V : motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V
    PORT MAP (
        in_1_Voltage_range_int16_tpl => AvalonRegisters_out_14_DC_link_range_V_cfg_tpl,
        in_2_Voltage_sfix16_En9_tpl => AvalonRegisters_out_15_DC_link_V_tpl,
        out_1_Fraction_ND_ufix16_En16_x_tpl => Voltage_scale_120_link_V_out_1_Fraction_ND_ufix16_En16_x_tpl,
        clk => clk,
        areset => areset
    );

    -- Fraction_to_Pulse6(BLACKBOX,14)
    theFraction_to_Pulse6 : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6
    PORT MAP (
        in_1_Fraction_ND_ufix16_En16_tpl => Voltage_scale_120_link_V_out_1_Fraction_ND_ufix16_En16_x_tpl,
        out_1_PulseDensity_Bool_x_tpl => Fraction_to_Pulse6_out_1_PulseDensity_Bool_x_tpl,
        clk => clk,
        areset => areset
    );

    -- V_DC_link_sd(GPOUT,43)
    V_DC_link_sd <= Fraction_to_Pulse6_out_1_PulseDensity_Bool_x_tpl;

END normal;
