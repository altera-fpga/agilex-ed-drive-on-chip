-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Altera(R) FPGAs Version 25.1.1 (Release Build #64f96064e9)
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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_MM_16fixed
-- VHDL created on Mon Aug 11 01:49:11 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb is
end;

architecture normal of motor_kit_sim_20MHz_MotorModel_MM_16fixed_atb is

component motor_kit_sim_20MHz_MotorModel_MM_16fixed is
    port (
        in_1_valid_in_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_2_channel_in_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_12_PolePairs_int_tpl : in std_logic_vector(1 downto 0);  -- ufix2
        in_13_Ke_Vs_rad_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_17_DC_link_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_3_Va_V_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_4_Vb_V_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_5_Vc_V_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_6_u_l_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_7_v_l_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_8_w_l_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_9_SampleTime_s_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en39
        in_10_Rphase_ohm_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_11_inv_Lphase_1_H_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en6
        in_14_Kt_Nm_A_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_15_inv_J_1_kgm2_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_16_LoadT_Nm_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en14
        in_18_Powerdown_p_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_19_Powerdown_n_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        out_1_valid_out_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_channel_out_tpl : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_did_dt_A_s_tpl : out std_logic_vector(32 downto 0);  -- sfix33_en15
        out_4_diq_dt_A_s_tpl : out std_logic_vector(32 downto 0);  -- sfix33_en15
        out_8_id_A_tpl : out std_logic_vector(26 downto 0);  -- sfix27_en16
        out_9_iq_A_tpl : out std_logic_vector(26 downto 0);  -- sfix27_en16
        out_10_T_Nm_tpl : out std_logic_vector(19 downto 0);  -- sfix20_en14
        out_5_ia_A_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en9
        out_6_ib_A_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en9
        out_7_ic_A_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en9
        out_11_Vd_V_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_12_Vq_V_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en6
        out_13_dTheta_dt_rad_s_k_tpl : out std_logic_vector(31 downto 0);  -- sfix32_en20
        out_14_Theta_one_turn_k_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_15_QEP_A_tpl : out std_logic_vector(0 downto 0);  -- ufix1_en13
        out_16_QEP_B_tpl : out std_logic_vector(0 downto 0);  -- ufix1_en13
        out_17_DC_link_A_tpl : out std_logic_vector(18 downto 0);  -- sfix19_en10
        out_18_ready_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end component;

component motor_kit_sim_20MHz_MotorModel_MM_16fixed_stm is
    port (
        in_1_valid_in_tpl_stm : out std_logic_vector(0 downto 0);
        in_2_channel_in_tpl_stm : out std_logic_vector(7 downto 0);
        in_12_PolePairs_int_tpl_stm : out std_logic_vector(1 downto 0);
        in_13_Ke_Vs_rad_tpl_stm : out std_logic_vector(15 downto 0);
        in_17_DC_link_tpl_stm : out std_logic_vector(15 downto 0);
        in_3_Va_V_tpl_stm : out std_logic_vector(0 downto 0);
        in_4_Vb_V_tpl_stm : out std_logic_vector(0 downto 0);
        in_5_Vc_V_tpl_stm : out std_logic_vector(0 downto 0);
        in_6_u_l_tpl_stm : out std_logic_vector(0 downto 0);
        in_7_v_l_tpl_stm : out std_logic_vector(0 downto 0);
        in_8_w_l_tpl_stm : out std_logic_vector(0 downto 0);
        in_9_SampleTime_s_tpl_stm : out std_logic_vector(15 downto 0);
        in_10_Rphase_ohm_tpl_stm : out std_logic_vector(15 downto 0);
        in_11_inv_Lphase_1_H_tpl_stm : out std_logic_vector(15 downto 0);
        in_14_Kt_Nm_A_tpl_stm : out std_logic_vector(15 downto 0);
        in_15_inv_J_1_kgm2_tpl_stm : out std_logic_vector(15 downto 0);
        in_16_LoadT_Nm_tpl_stm : out std_logic_vector(15 downto 0);
        in_18_Powerdown_p_tpl_stm : out std_logic_vector(0 downto 0);
        in_19_Powerdown_n_tpl_stm : out std_logic_vector(0 downto 0);
        out_1_valid_out_tpl_stm : out std_logic_vector(0 downto 0);
        out_2_channel_out_tpl_stm : out std_logic_vector(7 downto 0);
        out_3_did_dt_A_s_tpl_stm : out std_logic_vector(32 downto 0);
        out_4_diq_dt_A_s_tpl_stm : out std_logic_vector(32 downto 0);
        out_8_id_A_tpl_stm : out std_logic_vector(26 downto 0);
        out_9_iq_A_tpl_stm : out std_logic_vector(26 downto 0);
        out_10_T_Nm_tpl_stm : out std_logic_vector(19 downto 0);
        out_5_ia_A_tpl_stm : out std_logic_vector(15 downto 0);
        out_6_ib_A_tpl_stm : out std_logic_vector(15 downto 0);
        out_7_ic_A_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_Vd_V_tpl_stm : out std_logic_vector(15 downto 0);
        out_12_Vq_V_tpl_stm : out std_logic_vector(15 downto 0);
        out_13_dTheta_dt_rad_s_k_tpl_stm : out std_logic_vector(31 downto 0);
        out_14_Theta_one_turn_k_tpl_stm : out std_logic_vector(15 downto 0);
        out_15_QEP_A_tpl_stm : out std_logic_vector(0 downto 0);
        out_16_QEP_B_tpl_stm : out std_logic_vector(0 downto 0);
        out_17_DC_link_A_tpl_stm : out std_logic_vector(18 downto 0);
        out_18_ready_tpl_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end component;

signal in_1_valid_in_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_2_channel_in_tpl_stm : STD_LOGIC_VECTOR (7 downto 0);
signal in_12_PolePairs_int_tpl_stm : STD_LOGIC_VECTOR (1 downto 0);
signal in_13_Ke_Vs_rad_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_17_DC_link_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_3_Va_V_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_4_Vb_V_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_5_Vc_V_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_6_u_l_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_7_v_l_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_8_w_l_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_9_SampleTime_s_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_10_Rphase_ohm_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_11_inv_Lphase_1_H_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_14_Kt_Nm_A_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_15_inv_J_1_kgm2_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_16_LoadT_Nm_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_18_Powerdown_p_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_19_Powerdown_n_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_1_valid_out_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_channel_out_tpl_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_did_dt_A_s_tpl_stm : STD_LOGIC_VECTOR (32 downto 0);
signal out_4_diq_dt_A_s_tpl_stm : STD_LOGIC_VECTOR (32 downto 0);
signal out_8_id_A_tpl_stm : STD_LOGIC_VECTOR (26 downto 0);
signal out_9_iq_A_tpl_stm : STD_LOGIC_VECTOR (26 downto 0);
signal out_10_T_Nm_tpl_stm : STD_LOGIC_VECTOR (19 downto 0);
signal out_5_ia_A_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_6_ib_A_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_7_ic_A_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_Vd_V_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_12_Vq_V_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_13_dTheta_dt_rad_s_k_tpl_stm : STD_LOGIC_VECTOR (31 downto 0);
signal out_14_Theta_one_turn_k_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_15_QEP_A_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_16_QEP_B_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_17_DC_link_A_tpl_stm : STD_LOGIC_VECTOR (18 downto 0);
signal out_18_ready_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_1_valid_in_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_2_channel_in_tpl_dut : STD_LOGIC_VECTOR (7 downto 0);
signal in_12_PolePairs_int_tpl_dut : STD_LOGIC_VECTOR (1 downto 0);
signal in_13_Ke_Vs_rad_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_17_DC_link_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_3_Va_V_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_4_Vb_V_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_5_Vc_V_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_6_u_l_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_7_v_l_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_8_w_l_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_9_SampleTime_s_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_10_Rphase_ohm_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_11_inv_Lphase_1_H_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_14_Kt_Nm_A_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_15_inv_J_1_kgm2_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_16_LoadT_Nm_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_18_Powerdown_p_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_19_Powerdown_n_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_1_valid_out_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_channel_out_tpl_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_did_dt_A_s_tpl_dut : STD_LOGIC_VECTOR (32 downto 0);
signal out_4_diq_dt_A_s_tpl_dut : STD_LOGIC_VECTOR (32 downto 0);
signal out_8_id_A_tpl_dut : STD_LOGIC_VECTOR (26 downto 0);
signal out_9_iq_A_tpl_dut : STD_LOGIC_VECTOR (26 downto 0);
signal out_10_T_Nm_tpl_dut : STD_LOGIC_VECTOR (19 downto 0);
signal out_5_ia_A_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_6_ib_A_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_7_ic_A_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_Vd_V_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_12_Vq_V_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_13_dTheta_dt_rad_s_k_tpl_dut : STD_LOGIC_VECTOR (31 downto 0);
signal out_14_Theta_one_turn_k_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_15_QEP_A_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_16_QEP_B_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_17_DC_link_A_tpl_dut : STD_LOGIC_VECTOR (18 downto 0);
signal out_18_ready_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;

begin

-- Channelized data in real output
checkChannelIn : process (clk, areset, in_12_PolePairs_int_tpl_dut, in_12_PolePairs_int_tpl_stm, in_13_Ke_Vs_rad_tpl_dut, in_13_Ke_Vs_rad_tpl_stm, in_17_DC_link_tpl_dut, in_17_DC_link_tpl_stm, in_3_Va_V_tpl_dut, in_3_Va_V_tpl_stm, in_4_Vb_V_tpl_dut, in_4_Vb_V_tpl_stm, in_5_Vc_V_tpl_dut, in_5_Vc_V_tpl_stm, in_6_u_l_tpl_dut, in_6_u_l_tpl_stm, in_7_v_l_tpl_dut, in_7_v_l_tpl_stm, in_8_w_l_tpl_dut, in_8_w_l_tpl_stm, in_9_SampleTime_s_tpl_dut, in_9_SampleTime_s_tpl_stm, in_10_Rphase_ohm_tpl_dut, in_10_Rphase_ohm_tpl_stm, in_11_inv_Lphase_1_H_tpl_dut, in_11_inv_Lphase_1_H_tpl_stm, in_14_Kt_Nm_A_tpl_dut, in_14_Kt_Nm_A_tpl_stm, in_15_inv_J_1_kgm2_tpl_dut, in_15_inv_J_1_kgm2_tpl_stm, in_16_LoadT_Nm_tpl_dut, in_16_LoadT_Nm_tpl_stm, in_18_Powerdown_p_tpl_dut, in_18_Powerdown_p_tpl_stm, in_19_Powerdown_n_tpl_dut, in_19_Powerdown_n_tpl_stm)
begin
END PROCESS;


-- Channelized data out check
checkChannelOut : process (clk, areset, out_3_did_dt_A_s_tpl_dut, out_3_did_dt_A_s_tpl_stm, out_4_diq_dt_A_s_tpl_dut, out_4_diq_dt_A_s_tpl_stm, out_8_id_A_tpl_dut, out_8_id_A_tpl_stm, out_9_iq_A_tpl_dut, out_9_iq_A_tpl_stm, out_10_T_Nm_tpl_dut, out_10_T_Nm_tpl_stm, out_5_ia_A_tpl_dut, out_5_ia_A_tpl_stm, out_6_ib_A_tpl_dut, out_6_ib_A_tpl_stm, out_7_ic_A_tpl_dut, out_7_ic_A_tpl_stm, out_11_Vd_V_tpl_dut, out_11_Vd_V_tpl_stm, out_12_Vq_V_tpl_dut, out_12_Vq_V_tpl_stm, out_13_dTheta_dt_rad_s_k_tpl_dut, out_13_dTheta_dt_rad_s_k_tpl_stm, out_14_Theta_one_turn_k_tpl_dut, out_14_Theta_one_turn_k_tpl_stm, out_15_QEP_A_tpl_dut, out_15_QEP_A_tpl_stm, out_16_QEP_B_tpl_dut, out_16_QEP_B_tpl_stm, out_17_DC_link_A_tpl_dut, out_17_DC_link_A_tpl_stm, out_18_ready_tpl_dut, out_18_ready_tpl_stm)
variable mismatch_out_1_valid_out_tpl : BOOLEAN := FALSE;
variable mismatch_out_2_channel_out_tpl : BOOLEAN := FALSE;
variable mismatch_out_3_did_dt_A_s_tpl : BOOLEAN := FALSE;
variable mismatch_out_4_diq_dt_A_s_tpl : BOOLEAN := FALSE;
variable mismatch_out_8_id_A_tpl : BOOLEAN := FALSE;
variable mismatch_out_9_iq_A_tpl : BOOLEAN := FALSE;
variable mismatch_out_10_T_Nm_tpl : BOOLEAN := FALSE;
variable mismatch_out_5_ia_A_tpl : BOOLEAN := FALSE;
variable mismatch_out_6_ib_A_tpl : BOOLEAN := FALSE;
variable mismatch_out_7_ic_A_tpl : BOOLEAN := FALSE;
variable mismatch_out_11_Vd_V_tpl : BOOLEAN := FALSE;
variable mismatch_out_12_Vq_V_tpl : BOOLEAN := FALSE;
variable mismatch_out_13_dTheta_dt_rad_s_k_tpl : BOOLEAN := FALSE;
variable mismatch_out_14_Theta_one_turn_k_tpl : BOOLEAN := FALSE;
variable mismatch_out_15_QEP_A_tpl : BOOLEAN := FALSE;
variable mismatch_out_16_QEP_B_tpl : BOOLEAN := FALSE;
variable mismatch_out_17_DC_link_A_tpl : BOOLEAN := FALSE;
variable mismatch_out_18_ready_tpl : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_out_1_valid_out_tpl := FALSE;
        mismatch_out_2_channel_out_tpl := FALSE;
        mismatch_out_3_did_dt_A_s_tpl := FALSE;
        mismatch_out_4_diq_dt_A_s_tpl := FALSE;
        mismatch_out_8_id_A_tpl := FALSE;
        mismatch_out_9_iq_A_tpl := FALSE;
        mismatch_out_10_T_Nm_tpl := FALSE;
        mismatch_out_5_ia_A_tpl := FALSE;
        mismatch_out_6_ib_A_tpl := FALSE;
        mismatch_out_7_ic_A_tpl := FALSE;
        mismatch_out_11_Vd_V_tpl := FALSE;
        mismatch_out_12_Vq_V_tpl := FALSE;
        mismatch_out_13_dTheta_dt_rad_s_k_tpl := FALSE;
        mismatch_out_14_Theta_one_turn_k_tpl := FALSE;
        mismatch_out_15_QEP_A_tpl := FALSE;
        mismatch_out_16_QEP_B_tpl := FALSE;
        mismatch_out_17_DC_link_A_tpl := FALSE;
        mismatch_out_18_ready_tpl := FALSE;
        IF ( (out_1_valid_out_tpl_dut /= out_1_valid_out_tpl_stm)) THEN
            mismatch_out_1_valid_out_tpl := TRUE;
            report "mismatch in out_1_valid_out_tpl signal" severity Failure;
        END IF;
        IF ((out_1_valid_out_tpl_dut = "1")) THEN
            IF ( (out_2_channel_out_tpl_dut /= out_2_channel_out_tpl_stm)) THEN
                mismatch_out_2_channel_out_tpl := TRUE;
                report "mismatch in out_2_channel_out_tpl signal" severity Warning;
            END IF;
            IF ( (out_3_did_dt_A_s_tpl_dut /= out_3_did_dt_A_s_tpl_stm)) THEN
                mismatch_out_3_did_dt_A_s_tpl := TRUE;
                report "mismatch in out_3_did_dt_A_s_tpl signal" severity Warning;
            END IF;
            IF ( (out_4_diq_dt_A_s_tpl_dut /= out_4_diq_dt_A_s_tpl_stm)) THEN
                mismatch_out_4_diq_dt_A_s_tpl := TRUE;
                report "mismatch in out_4_diq_dt_A_s_tpl signal" severity Warning;
            END IF;
            IF ( (out_8_id_A_tpl_dut /= out_8_id_A_tpl_stm)) THEN
                mismatch_out_8_id_A_tpl := TRUE;
                report "mismatch in out_8_id_A_tpl signal" severity Warning;
            END IF;
            IF ( (out_9_iq_A_tpl_dut /= out_9_iq_A_tpl_stm)) THEN
                mismatch_out_9_iq_A_tpl := TRUE;
                report "mismatch in out_9_iq_A_tpl signal" severity Warning;
            END IF;
            IF ( (out_10_T_Nm_tpl_dut /= out_10_T_Nm_tpl_stm)) THEN
                mismatch_out_10_T_Nm_tpl := TRUE;
                report "mismatch in out_10_T_Nm_tpl signal" severity Warning;
            END IF;
            IF ( (out_5_ia_A_tpl_dut /= out_5_ia_A_tpl_stm)) THEN
                mismatch_out_5_ia_A_tpl := TRUE;
                report "mismatch in out_5_ia_A_tpl signal" severity Warning;
            END IF;
            IF ( (out_6_ib_A_tpl_dut /= out_6_ib_A_tpl_stm)) THEN
                mismatch_out_6_ib_A_tpl := TRUE;
                report "mismatch in out_6_ib_A_tpl signal" severity Warning;
            END IF;
            IF ( (out_7_ic_A_tpl_dut /= out_7_ic_A_tpl_stm)) THEN
                mismatch_out_7_ic_A_tpl := TRUE;
                report "mismatch in out_7_ic_A_tpl signal" severity Warning;
            END IF;
            IF ( (out_11_Vd_V_tpl_dut /= out_11_Vd_V_tpl_stm)) THEN
                mismatch_out_11_Vd_V_tpl := TRUE;
                report "mismatch in out_11_Vd_V_tpl signal" severity Warning;
            END IF;
            IF ( (out_12_Vq_V_tpl_dut /= out_12_Vq_V_tpl_stm)) THEN
                mismatch_out_12_Vq_V_tpl := TRUE;
                report "mismatch in out_12_Vq_V_tpl signal" severity Warning;
            END IF;
            IF ( (out_13_dTheta_dt_rad_s_k_tpl_dut /= out_13_dTheta_dt_rad_s_k_tpl_stm)) THEN
                mismatch_out_13_dTheta_dt_rad_s_k_tpl := TRUE;
                report "mismatch in out_13_dTheta_dt_rad_s_k_tpl signal" severity Warning;
            END IF;
            IF ( (out_14_Theta_one_turn_k_tpl_dut /= out_14_Theta_one_turn_k_tpl_stm)) THEN
                mismatch_out_14_Theta_one_turn_k_tpl := TRUE;
                report "mismatch in out_14_Theta_one_turn_k_tpl signal" severity Warning;
            END IF;
            IF ( (out_15_QEP_A_tpl_dut /= out_15_QEP_A_tpl_stm)) THEN
                mismatch_out_15_QEP_A_tpl := TRUE;
                report "mismatch in out_15_QEP_A_tpl signal" severity Warning;
            END IF;
            IF ( (out_16_QEP_B_tpl_dut /= out_16_QEP_B_tpl_stm)) THEN
                mismatch_out_16_QEP_B_tpl := TRUE;
                report "mismatch in out_16_QEP_B_tpl signal" severity Warning;
            END IF;
            IF ( (out_17_DC_link_A_tpl_dut /= out_17_DC_link_A_tpl_stm)) THEN
                mismatch_out_17_DC_link_A_tpl := TRUE;
                report "mismatch in out_17_DC_link_A_tpl signal" severity Warning;
            END IF;
            IF ( (out_18_ready_tpl_dut /= out_18_ready_tpl_stm)) THEN
                mismatch_out_18_ready_tpl := TRUE;
                report "mismatch in out_18_ready_tpl signal" severity Warning;
            END IF;
        END IF;
        IF (mismatch_out_1_valid_out_tpl = TRUE or mismatch_out_2_channel_out_tpl = TRUE or mismatch_out_3_did_dt_A_s_tpl = TRUE or mismatch_out_4_diq_dt_A_s_tpl = TRUE or mismatch_out_8_id_A_tpl = TRUE or mismatch_out_9_iq_A_tpl = TRUE or mismatch_out_10_T_Nm_tpl = TRUE or mismatch_out_5_ia_A_tpl = TRUE or mismatch_out_6_ib_A_tpl = TRUE or mismatch_out_7_ic_A_tpl = TRUE or mismatch_out_11_Vd_V_tpl = TRUE or mismatch_out_12_Vq_V_tpl = TRUE or mismatch_out_13_dTheta_dt_rad_s_k_tpl = TRUE or mismatch_out_14_Theta_one_turn_k_tpl = TRUE or mismatch_out_15_QEP_A_tpl = TRUE or mismatch_out_16_QEP_B_tpl = TRUE or mismatch_out_17_DC_link_A_tpl = TRUE or mismatch_out_18_ready_tpl = TRUE) THEN
            ok := FALSE;
            report_mismatch_failure_detected := TRUE;
        END IF;
        IF (ok = FALSE) THEN
            report "Mismatch detected" severity Failure;
        END IF;
    END IF;
END PROCESS;


dut : motor_kit_sim_20MHz_MotorModel_MM_16fixed port map (
    in_1_valid_in_tpl_stm,
    in_2_channel_in_tpl_stm,
    in_12_PolePairs_int_tpl_stm,
    in_13_Ke_Vs_rad_tpl_stm,
    in_17_DC_link_tpl_stm,
    in_3_Va_V_tpl_stm,
    in_4_Vb_V_tpl_stm,
    in_5_Vc_V_tpl_stm,
    in_6_u_l_tpl_stm,
    in_7_v_l_tpl_stm,
    in_8_w_l_tpl_stm,
    in_9_SampleTime_s_tpl_stm,
    in_10_Rphase_ohm_tpl_stm,
    in_11_inv_Lphase_1_H_tpl_stm,
    in_14_Kt_Nm_A_tpl_stm,
    in_15_inv_J_1_kgm2_tpl_stm,
    in_16_LoadT_Nm_tpl_stm,
    in_18_Powerdown_p_tpl_stm,
    in_19_Powerdown_n_tpl_stm,
    out_1_valid_out_tpl_dut,
    out_2_channel_out_tpl_dut,
    out_3_did_dt_A_s_tpl_dut,
    out_4_diq_dt_A_s_tpl_dut,
    out_8_id_A_tpl_dut,
    out_9_iq_A_tpl_dut,
    out_10_T_Nm_tpl_dut,
    out_5_ia_A_tpl_dut,
    out_6_ib_A_tpl_dut,
    out_7_ic_A_tpl_dut,
    out_11_Vd_V_tpl_dut,
    out_12_Vq_V_tpl_dut,
    out_13_dTheta_dt_rad_s_k_tpl_dut,
    out_14_Theta_one_turn_k_tpl_dut,
    out_15_QEP_A_tpl_dut,
    out_16_QEP_B_tpl_dut,
    out_17_DC_link_A_tpl_dut,
    out_18_ready_tpl_dut,
        clk,
        areset
);

sim : motor_kit_sim_20MHz_MotorModel_MM_16fixed_stm port map (
    in_1_valid_in_tpl_stm,
    in_2_channel_in_tpl_stm,
    in_12_PolePairs_int_tpl_stm,
    in_13_Ke_Vs_rad_tpl_stm,
    in_17_DC_link_tpl_stm,
    in_3_Va_V_tpl_stm,
    in_4_Vb_V_tpl_stm,
    in_5_Vc_V_tpl_stm,
    in_6_u_l_tpl_stm,
    in_7_v_l_tpl_stm,
    in_8_w_l_tpl_stm,
    in_9_SampleTime_s_tpl_stm,
    in_10_Rphase_ohm_tpl_stm,
    in_11_inv_Lphase_1_H_tpl_stm,
    in_14_Kt_Nm_A_tpl_stm,
    in_15_inv_J_1_kgm2_tpl_stm,
    in_16_LoadT_Nm_tpl_stm,
    in_18_Powerdown_p_tpl_stm,
    in_19_Powerdown_n_tpl_stm,
    out_1_valid_out_tpl_stm,
    out_2_channel_out_tpl_stm,
    out_3_did_dt_A_s_tpl_stm,
    out_4_diq_dt_A_s_tpl_stm,
    out_8_id_A_tpl_stm,
    out_9_iq_A_tpl_stm,
    out_10_T_Nm_tpl_stm,
    out_5_ia_A_tpl_stm,
    out_6_ib_A_tpl_stm,
    out_7_ic_A_tpl_stm,
    out_11_Vd_V_tpl_stm,
    out_12_Vq_V_tpl_stm,
    out_13_dTheta_dt_rad_s_k_tpl_stm,
    out_14_Theta_one_turn_k_tpl_stm,
    out_15_QEP_A_tpl_stm,
    out_16_QEP_B_tpl_stm,
    out_17_DC_link_A_tpl_stm,
    out_18_ready_tpl_stm,
        clk,
        areset
);

end normal;
