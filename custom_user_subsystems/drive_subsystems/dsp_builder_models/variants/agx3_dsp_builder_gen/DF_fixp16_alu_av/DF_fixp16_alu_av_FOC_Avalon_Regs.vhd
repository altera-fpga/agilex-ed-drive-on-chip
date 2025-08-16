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

-- VHDL created from DF_fixp16_alu_av_FOC_Avalon_Regs
-- VHDL created on Mon Aug 11 01:51:50 2025


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
entity DF_fixp16_alu_av_FOC_Avalon_Regs is
    port (
        in_2_Valpha_tpl : in std_logic_vector(31 downto 0);  -- sfix32_en10
        in_3_Vbeta_tpl : in std_logic_vector(31 downto 0);  -- sfix32_en10
        in_6_Ready_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_1_qv_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_7_Vuvwin_0_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_7_Vuvwin_1_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_7_Vuvwin_2_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_8_AxisOut_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_4_Iq_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_5_Id_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        out_9_I_Sat_Limit_cfg_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_11_reset_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_1_dv_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_2_axisin_tpl : out std_logic_vector(7 downto 0);  -- ufix8
        out_3_Iu_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_4_Iw_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_5_Torque_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_6_phi_el_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_7_Kp_cfg_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_8_Ki_cfg_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_10_MaxV_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : out std_logic_vector(7 downto 0);  -- ufix8
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : out std_logic_vector(31 downto 0);  -- sfix32_en10
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : out std_logic_vector(31 downto 0);  -- sfix32_en10
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end DF_fixp16_alu_av_FOC_Avalon_Regs;

architecture normal of DF_fixp16_alu_av_FOC_Avalon_Regs is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal And_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Not_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Not1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Or_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_DSPBA_Start_unsched_x_outBound_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_And_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GPOut1(GPOUT,14)@0
    out_9_I_Sat_Limit_cfg_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl;

    -- GPOut10(GPOUT,15)@0
    out_11_reset_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist0_DSPBA_Start_unsched_x_outBound_q_1(DELAY,133)
    redist0_DSPBA_Start_unsched_x_outBound_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist0_DSPBA_Start_unsched_x_outBound_q_1_q <= (others => '0');
            ELSE
                redist0_DSPBA_Start_unsched_x_outBound_q_1_q <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl;
            END IF;
        END IF;
    END PROCESS;

    -- Not1(LOGICAL,26)@0
    Not1_q <= not (redist0_DSPBA_Start_unsched_x_outBound_q_1_q);

    -- And_rsrvd_fix(LOGICAL,2)@0
    And_rsrvd_fix_q <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl and Not1_q;

    -- redist1_And_rsrvd_fix_q_1(DELAY,134)
    redist1_And_rsrvd_fix_q_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist1_And_rsrvd_fix_q_1_q <= (others => '0');
            ELSE
                redist1_And_rsrvd_fix_q_1_q <= And_rsrvd_fix_q;
            END IF;
        END IF;
    END PROCESS;

    -- GPOut11(GPOUT,16)@1
    out_1_dv_tpl <= redist1_And_rsrvd_fix_q_1_q;

    -- GPOut2(GPOUT,17)@0
    out_2_axisin_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl;

    -- GPOut3(GPOUT,18)@0
    out_3_Iu_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl;

    -- GPOut4(GPOUT,19)@0
    out_4_Iw_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl;

    -- GPOut5(GPOUT,20)@0
    out_5_Torque_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl;

    -- GPOut6(GPOUT,21)@0
    out_6_phi_el_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl;

    -- GPOut7(GPOUT,22)@0
    out_7_Kp_cfg_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl;

    -- GPOut8(GPOUT,23)@0
    out_8_Ki_cfg_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl;

    -- GPOut9(GPOUT,24)@0
    out_10_MaxV_tpl <= in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl(GPOUT,38)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl <= in_8_AxisOut_tpl;

    -- Not_rsrvd_fix(LOGICAL,25)@0
    Not_rsrvd_fix_q <= not (in_6_Ready_tpl);

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl(GPOUT,39)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl <= Not_rsrvd_fix_q;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl(GPOUT,40)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl(GPOUT,41)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl <= in_5_Id_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl(GPOUT,42)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl <= in_4_Iq_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl(GPOUT,43)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl <= in_2_Valpha_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl(GPOUT,44)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl <= in_3_Vbeta_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl(GPOUT,45)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl <= in_7_Vuvwin_0_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl(GPOUT,46)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl <= in_7_Vuvwin_1_tpl;

    -- out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl(GPOUT,47)@0
    out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl <= in_7_Vuvwin_2_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl(GPOUT,48)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl(GPOUT,49)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl <= VCC_q;

    -- Or_rsrvd_fix(LOGICAL,27)@0
    Or_rsrvd_fix_q <= And_rsrvd_fix_q or in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl(GPOUT,50)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl <= Or_rsrvd_fix_q;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl(GPOUT,51)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl(GPOUT,52)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl(GPOUT,53)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl(GPOUT,54)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl(GPOUT,55)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl(GPOUT,56)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl <= in_1_qv_tpl;

    -- out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl(GPOUT,57)@0
    out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl <= in_1_qv_tpl;

END normal;
