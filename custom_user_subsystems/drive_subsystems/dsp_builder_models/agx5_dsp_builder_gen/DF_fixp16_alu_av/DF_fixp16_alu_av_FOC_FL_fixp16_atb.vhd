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
use work.dspba_sim_library_package.all;
entity DF_fixp16_alu_av_FOC_FL_fixp16_atb is
end;

architecture normal of DF_fixp16_alu_av_FOC_FL_fixp16_atb is

component DF_fixp16_alu_av_FOC_FL_fixp16 is
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
end component;

component DF_fixp16_alu_av_FOC_FL_fixp16_stm is
    port (
        in_1_dv_tpl_stm : out std_logic_vector(0 downto 0);
        in_2_dc_tpl_stm : out std_logic_vector(7 downto 0);
        in_3_valid_in_tpl_stm : out std_logic_vector(0 downto 0);
        in_4_axis_in_tpl_stm : out std_logic_vector(7 downto 0);
        in_5_Iu_tpl_stm : out std_logic_vector(15 downto 0);
        in_6_Iw_tpl_stm : out std_logic_vector(15 downto 0);
        in_7_Torque_tpl_stm : out std_logic_vector(15 downto 0);
        in_8_IntegralQ_in_tpl_stm : out std_logic_vector(15 downto 0);
        in_9_IntegralD_in_tpl_stm : out std_logic_vector(15 downto 0);
        in_10_phi_el_tpl_stm : out std_logic_vector(15 downto 0);
        in_11_Kp_tpl_stm : out std_logic_vector(15 downto 0);
        in_12_Ki_tpl_stm : out std_logic_vector(15 downto 0);
        in_13_I_Sat_Limit_tpl_stm : out std_logic_vector(15 downto 0);
        in_14_Max_tpl_stm : out std_logic_vector(15 downto 0);
        out_1_qv_tpl_stm : out std_logic_vector(0 downto 0);
        out_2_qc_tpl_stm : out std_logic_vector(7 downto 0);
        out_3_valid_out_tpl_stm : out std_logic_vector(0 downto 0);
        out_4_axis_out_tpl_stm : out std_logic_vector(7 downto 0);
        out_5_Valpha_tpl_stm : out std_logic_vector(31 downto 0);
        out_6_Vbeta_tpl_stm : out std_logic_vector(31 downto 0);
        out_7_IntegralD_out_tpl_stm : out std_logic_vector(15 downto 0);
        out_8_IntegralQ_out_tpl_stm : out std_logic_vector(15 downto 0);
        out_9_Iq_tpl_stm : out std_logic_vector(15 downto 0);
        out_10_Id_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_0_uvw_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_1_uvw_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_2_uvw_tpl_stm : out std_logic_vector(15 downto 0);
        out_12_ready_tpl_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end component;

signal in_1_dv_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_2_dc_tpl_stm : STD_LOGIC_VECTOR (7 downto 0);
signal in_3_valid_in_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_4_axis_in_tpl_stm : STD_LOGIC_VECTOR (7 downto 0);
signal in_5_Iu_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_6_Iw_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_7_Torque_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_8_IntegralQ_in_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_9_IntegralD_in_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_10_phi_el_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_11_Kp_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_12_Ki_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_13_I_Sat_Limit_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_14_Max_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_1_qv_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_qc_tpl_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_valid_out_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_4_axis_out_tpl_stm : STD_LOGIC_VECTOR (7 downto 0);
signal out_5_Valpha_tpl_stm : STD_LOGIC_VECTOR (31 downto 0);
signal out_6_Vbeta_tpl_stm : STD_LOGIC_VECTOR (31 downto 0);
signal out_7_IntegralD_out_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_8_IntegralQ_out_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_9_Iq_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_10_Id_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_0_uvw_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_1_uvw_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_2_uvw_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_12_ready_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_1_dv_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_2_dc_tpl_dut : STD_LOGIC_VECTOR (7 downto 0);
signal in_3_valid_in_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_4_axis_in_tpl_dut : STD_LOGIC_VECTOR (7 downto 0);
signal in_5_Iu_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_6_Iw_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_7_Torque_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_8_IntegralQ_in_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_9_IntegralD_in_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_10_phi_el_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_11_Kp_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_12_Ki_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_13_I_Sat_Limit_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_14_Max_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_1_qv_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_2_qc_tpl_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_3_valid_out_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_4_axis_out_tpl_dut : STD_LOGIC_VECTOR (7 downto 0);
signal out_5_Valpha_tpl_dut : STD_LOGIC_VECTOR (31 downto 0);
signal out_6_Vbeta_tpl_dut : STD_LOGIC_VECTOR (31 downto 0);
signal out_7_IntegralD_out_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_8_IntegralQ_out_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_9_Iq_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_10_Id_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_0_uvw_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_1_uvw_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_11_2_uvw_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_12_ready_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;

begin

-- Channelized data in real output
checkChannelIn2 : process (clk, areset, in_3_valid_in_tpl_dut, in_3_valid_in_tpl_stm, in_4_axis_in_tpl_dut, in_4_axis_in_tpl_stm, in_5_Iu_tpl_dut, in_5_Iu_tpl_stm, in_6_Iw_tpl_dut, in_6_Iw_tpl_stm, in_7_Torque_tpl_dut, in_7_Torque_tpl_stm, in_8_IntegralQ_in_tpl_dut, in_8_IntegralQ_in_tpl_stm, in_9_IntegralD_in_tpl_dut, in_9_IntegralD_in_tpl_stm, in_10_phi_el_tpl_dut, in_10_phi_el_tpl_stm, in_11_Kp_tpl_dut, in_11_Kp_tpl_stm, in_12_Ki_tpl_dut, in_12_Ki_tpl_stm, in_13_I_Sat_Limit_tpl_dut, in_13_I_Sat_Limit_tpl_stm, in_14_Max_tpl_dut, in_14_Max_tpl_stm)
begin
END PROCESS;


-- Channelized data out check
checkChannelOut1_vunroll_x : process (clk, areset, out_3_valid_out_tpl_dut, out_3_valid_out_tpl_stm, out_4_axis_out_tpl_dut, out_4_axis_out_tpl_stm, out_5_Valpha_tpl_dut, out_5_Valpha_tpl_stm, out_6_Vbeta_tpl_dut, out_6_Vbeta_tpl_stm, out_7_IntegralD_out_tpl_dut, out_7_IntegralD_out_tpl_stm, out_8_IntegralQ_out_tpl_dut, out_8_IntegralQ_out_tpl_stm, out_9_Iq_tpl_dut, out_9_Iq_tpl_stm, out_10_Id_tpl_dut, out_10_Id_tpl_stm, out_11_0_uvw_tpl_dut, out_11_0_uvw_tpl_stm, out_11_1_uvw_tpl_dut, out_11_1_uvw_tpl_stm, out_11_2_uvw_tpl_dut, out_11_2_uvw_tpl_stm, out_12_ready_tpl_dut, out_12_ready_tpl_stm)
variable mismatch_out_1_qv_tpl : BOOLEAN := FALSE;
variable mismatch_out_2_qc_tpl : BOOLEAN := FALSE;
variable mismatch_out_3_valid_out_tpl : BOOLEAN := FALSE;
variable mismatch_out_4_axis_out_tpl : BOOLEAN := FALSE;
variable mismatch_out_5_Valpha_tpl : BOOLEAN := FALSE;
variable mismatch_out_6_Vbeta_tpl : BOOLEAN := FALSE;
variable mismatch_out_7_IntegralD_out_tpl : BOOLEAN := FALSE;
variable mismatch_out_8_IntegralQ_out_tpl : BOOLEAN := FALSE;
variable mismatch_out_9_Iq_tpl : BOOLEAN := FALSE;
variable mismatch_out_10_Id_tpl : BOOLEAN := FALSE;
variable mismatch_out_11_0_uvw_tpl : BOOLEAN := FALSE;
variable mismatch_out_11_1_uvw_tpl : BOOLEAN := FALSE;
variable mismatch_out_11_2_uvw_tpl : BOOLEAN := FALSE;
variable mismatch_out_12_ready_tpl : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_out_1_qv_tpl := FALSE;
        mismatch_out_2_qc_tpl := FALSE;
        mismatch_out_3_valid_out_tpl := FALSE;
        mismatch_out_4_axis_out_tpl := FALSE;
        mismatch_out_5_Valpha_tpl := FALSE;
        mismatch_out_6_Vbeta_tpl := FALSE;
        mismatch_out_7_IntegralD_out_tpl := FALSE;
        mismatch_out_8_IntegralQ_out_tpl := FALSE;
        mismatch_out_9_Iq_tpl := FALSE;
        mismatch_out_10_Id_tpl := FALSE;
        mismatch_out_11_0_uvw_tpl := FALSE;
        mismatch_out_11_1_uvw_tpl := FALSE;
        mismatch_out_11_2_uvw_tpl := FALSE;
        mismatch_out_12_ready_tpl := FALSE;
        IF ( (out_1_qv_tpl_dut /= out_1_qv_tpl_stm)) THEN
            mismatch_out_1_qv_tpl := TRUE;
            report "mismatch in out_1_qv_tpl signal" severity Failure;
        END IF;
        IF ((out_1_qv_tpl_dut = "1")) THEN
            IF ( (out_2_qc_tpl_dut /= out_2_qc_tpl_stm)) THEN
                mismatch_out_2_qc_tpl := TRUE;
                report "mismatch in out_2_qc_tpl signal" severity Warning;
            END IF;
            IF ( (out_3_valid_out_tpl_dut /= out_3_valid_out_tpl_stm)) THEN
                mismatch_out_3_valid_out_tpl := TRUE;
                report "mismatch in out_3_valid_out_tpl signal" severity Warning;
            END IF;
            IF ( (out_4_axis_out_tpl_dut /= out_4_axis_out_tpl_stm)) THEN
                mismatch_out_4_axis_out_tpl := TRUE;
                report "mismatch in out_4_axis_out_tpl signal" severity Warning;
            END IF;
            IF ( (out_5_Valpha_tpl_dut /= out_5_Valpha_tpl_stm)) THEN
                mismatch_out_5_Valpha_tpl := TRUE;
                report "mismatch in out_5_Valpha_tpl signal" severity Warning;
            END IF;
            IF ( (out_6_Vbeta_tpl_dut /= out_6_Vbeta_tpl_stm)) THEN
                mismatch_out_6_Vbeta_tpl := TRUE;
                report "mismatch in out_6_Vbeta_tpl signal" severity Warning;
            END IF;
            IF ( (out_7_IntegralD_out_tpl_dut /= out_7_IntegralD_out_tpl_stm)) THEN
                mismatch_out_7_IntegralD_out_tpl := TRUE;
                report "mismatch in out_7_IntegralD_out_tpl signal" severity Warning;
            END IF;
            IF ( (out_8_IntegralQ_out_tpl_dut /= out_8_IntegralQ_out_tpl_stm)) THEN
                mismatch_out_8_IntegralQ_out_tpl := TRUE;
                report "mismatch in out_8_IntegralQ_out_tpl signal" severity Warning;
            END IF;
            IF ( (out_9_Iq_tpl_dut /= out_9_Iq_tpl_stm)) THEN
                mismatch_out_9_Iq_tpl := TRUE;
                report "mismatch in out_9_Iq_tpl signal" severity Warning;
            END IF;
            IF ( (out_10_Id_tpl_dut /= out_10_Id_tpl_stm)) THEN
                mismatch_out_10_Id_tpl := TRUE;
                report "mismatch in out_10_Id_tpl signal" severity Warning;
            END IF;
            IF ( (out_11_0_uvw_tpl_dut /= out_11_0_uvw_tpl_stm)) THEN
                mismatch_out_11_0_uvw_tpl := TRUE;
                report "mismatch in out_11_0_uvw_tpl signal" severity Warning;
            END IF;
            IF ( (out_11_1_uvw_tpl_dut /= out_11_1_uvw_tpl_stm)) THEN
                mismatch_out_11_1_uvw_tpl := TRUE;
                report "mismatch in out_11_1_uvw_tpl signal" severity Warning;
            END IF;
            IF ( (out_11_2_uvw_tpl_dut /= out_11_2_uvw_tpl_stm)) THEN
                mismatch_out_11_2_uvw_tpl := TRUE;
                report "mismatch in out_11_2_uvw_tpl signal" severity Warning;
            END IF;
            IF ( (out_12_ready_tpl_dut /= out_12_ready_tpl_stm)) THEN
                mismatch_out_12_ready_tpl := TRUE;
                report "mismatch in out_12_ready_tpl signal" severity Warning;
            END IF;
        END IF;
        IF (mismatch_out_1_qv_tpl = TRUE or mismatch_out_2_qc_tpl = TRUE or mismatch_out_3_valid_out_tpl = TRUE or mismatch_out_4_axis_out_tpl = TRUE or mismatch_out_5_Valpha_tpl = TRUE or mismatch_out_6_Vbeta_tpl = TRUE or mismatch_out_7_IntegralD_out_tpl = TRUE or mismatch_out_8_IntegralQ_out_tpl = TRUE or mismatch_out_9_Iq_tpl = TRUE or mismatch_out_10_Id_tpl = TRUE or mismatch_out_11_0_uvw_tpl = TRUE or mismatch_out_11_1_uvw_tpl = TRUE or mismatch_out_11_2_uvw_tpl = TRUE or mismatch_out_12_ready_tpl = TRUE) THEN
            ok := FALSE;
        END IF;
        IF (ok = FALSE) THEN
            report "Mismatch detected" severity Failure;
        END IF;
    END IF;
END PROCESS;


dut : DF_fixp16_alu_av_FOC_FL_fixp16 port map (
    in_1_dv_tpl_stm,
    in_2_dc_tpl_stm,
    in_3_valid_in_tpl_stm,
    in_4_axis_in_tpl_stm,
    in_5_Iu_tpl_stm,
    in_6_Iw_tpl_stm,
    in_7_Torque_tpl_stm,
    in_8_IntegralQ_in_tpl_stm,
    in_9_IntegralD_in_tpl_stm,
    in_10_phi_el_tpl_stm,
    in_11_Kp_tpl_stm,
    in_12_Ki_tpl_stm,
    in_13_I_Sat_Limit_tpl_stm,
    in_14_Max_tpl_stm,
    out_1_qv_tpl_dut,
    out_2_qc_tpl_dut,
    out_3_valid_out_tpl_dut,
    out_4_axis_out_tpl_dut,
    out_5_Valpha_tpl_dut,
    out_6_Vbeta_tpl_dut,
    out_7_IntegralD_out_tpl_dut,
    out_8_IntegralQ_out_tpl_dut,
    out_9_Iq_tpl_dut,
    out_10_Id_tpl_dut,
    out_11_0_uvw_tpl_dut,
    out_11_1_uvw_tpl_dut,
    out_11_2_uvw_tpl_dut,
    out_12_ready_tpl_dut,
        clk,
        areset
);

sim : DF_fixp16_alu_av_FOC_FL_fixp16_stm port map (
    in_1_dv_tpl_stm,
    in_2_dc_tpl_stm,
    in_3_valid_in_tpl_stm,
    in_4_axis_in_tpl_stm,
    in_5_Iu_tpl_stm,
    in_6_Iw_tpl_stm,
    in_7_Torque_tpl_stm,
    in_8_IntegralQ_in_tpl_stm,
    in_9_IntegralD_in_tpl_stm,
    in_10_phi_el_tpl_stm,
    in_11_Kp_tpl_stm,
    in_12_Ki_tpl_stm,
    in_13_I_Sat_Limit_tpl_stm,
    in_14_Max_tpl_stm,
    out_1_qv_tpl_stm,
    out_2_qc_tpl_stm,
    out_3_valid_out_tpl_stm,
    out_4_axis_out_tpl_stm,
    out_5_Valpha_tpl_stm,
    out_6_Vbeta_tpl_stm,
    out_7_IntegralD_out_tpl_stm,
    out_8_IntegralQ_out_tpl_stm,
    out_9_Iq_tpl_stm,
    out_10_Id_tpl_stm,
    out_11_0_uvw_tpl_stm,
    out_11_1_uvw_tpl_stm,
    out_11_2_uvw_tpl_stm,
    out_12_ready_tpl_stm,
        clk,
        areset
);

end normal;
