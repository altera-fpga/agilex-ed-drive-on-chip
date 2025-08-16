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

-- VHDL created from standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x
-- VHDL created on Mon Aug 11 01:51:49 2025


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
entity standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x is
    port (
        busIn_writedata : in std_logic_vector(31 downto 0);  -- ufix32
        busIn_address : in std_logic_vector(5 downto 0);  -- ufix6
        busIn_write : in std_logic_vector(0 downto 0);  -- ufix1
        busIn_read : in std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdata : out std_logic_vector(31 downto 0);  -- ufix32
        busOut_waitrequest : out std_logic_vector(0 downto 0);  -- ufix1
        qv_s : in std_logic_vector(0 downto 0);  -- ufix1
        Valpha_s : in std_logic_vector(31 downto 0);  -- sfix32_en10
        Vbeta_s : in std_logic_vector(31 downto 0);  -- sfix32_en10
        Iq_s : in std_logic_vector(15 downto 0);  -- sfix16_en10
        Id_s : in std_logic_vector(15 downto 0);  -- sfix16_en10
        Ready_s : in std_logic_vector(0 downto 0);  -- ufix1
        Vuvwin_0 : in std_logic_vector(15 downto 0);  -- ufix16
        Vuvwin_1 : in std_logic_vector(15 downto 0);  -- ufix16
        Vuvwin_2 : in std_logic_vector(15 downto 0);  -- ufix16
        AxisOut_s : in std_logic_vector(7 downto 0);  -- ufix8
        dv : out std_logic_vector(0 downto 0);  -- ufix1
        axisin : out std_logic_vector(7 downto 0);  -- ufix8
        Iu : out std_logic_vector(15 downto 0);  -- sfix16_en10
        Iw : out std_logic_vector(15 downto 0);  -- sfix16_en10
        Torque : out std_logic_vector(15 downto 0);  -- sfix16_en10
        phi_el : out std_logic_vector(15 downto 0);  -- ufix16_en16
        Kp_cfg : out std_logic_vector(15 downto 0);  -- sfix16_en10
        Ki_cfg : out std_logic_vector(15 downto 0);  -- sfix16_en10
        I_Sat_Limit_cfg : out std_logic_vector(15 downto 0);  -- sfix16_en10
        MaxV : out std_logic_vector(15 downto 0);  -- ufix16
        reset : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic;
        h_areset : in std_logic
    );
end standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x;

architecture normal of standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component DF_fixp16_alu_av_FOC_Avalon_Regs is
        port (
            in_1_qv_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_2_Valpha_tpl : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_3_Vbeta_tpl : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_4_Iq_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_5_Id_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_6_Ready_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_7_Vuvwin_0_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_7_Vuvwin_1_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_7_Vuvwin_2_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_8_AxisOut_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_1_dv_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_2_axisin_tpl : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_3_Iu_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_4_Iw_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_5_Torque_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_6_phi_el_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_7_Kp_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_8_Ki_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_9_I_Sat_Limit_cfg_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_10_MaxV_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_11_reset_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    component busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz is
        port (
            busIn_writedata : in std_logic_vector(31 downto 0);  -- Fixed Point
            busIn_address : in std_logic_vector(5 downto 0);  -- Fixed Point
            busIn_write : in std_logic_vector(0 downto 0);  -- Fixed Point
            busIn_read : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            busOut_readdata : out std_logic_vector(31 downto 0);  -- Fixed Point
            busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic;
            h_areset : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_1_dv_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_2_axisin_tpl : STD_LOGIC_VECTOR (7 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_3_Iu_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_4_Iw_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_5_Torque_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_6_phi_el_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_7_Kp_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_8_Ki_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_9_I_Sat_Limit_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_10_MaxV_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_11_reset_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : STD_LOGIC_VECTOR (7 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : STD_LOGIC_VECTOR (31 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_busOut_readdata : STD_LOGIC_VECTOR (31 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_busOut_readdatavalid : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl : STD_LOGIC_VECTOR (7 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDelayed_q : STD_LOGIC_VECTOR (0 downto 0);
    signal standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDataValid_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- DF_fixp16_alu_av_FOC_Avalon_Regs_x(BLACKBOX,2)
    theDF_fixp16_alu_av_FOC_Avalon_Regs_x : DF_fixp16_alu_av_FOC_Avalon_Regs
    PORT MAP (
        in_1_qv_tpl => qv_s,
        in_2_Valpha_tpl => Valpha_s,
        in_3_Vbeta_tpl => Vbeta_s,
        in_4_Iq_tpl => Iq_s,
        in_5_Id_tpl => Id_s,
        in_6_Ready_tpl => Ready_s,
        in_7_Vuvwin_0_tpl => Vuvwin_0,
        in_7_Vuvwin_1_tpl => Vuvwin_1,
        in_7_Vuvwin_2_tpl => Vuvwin_2,
        in_8_AxisOut_tpl => AxisOut_s,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl,
        out_1_dv_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_1_dv_tpl,
        out_2_axisin_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_2_axisin_tpl,
        out_3_Iu_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_3_Iu_tpl,
        out_4_Iw_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_4_Iw_tpl,
        out_5_Torque_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_5_Torque_tpl,
        out_6_phi_el_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_6_phi_el_tpl,
        out_7_Kp_cfg_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_7_Kp_cfg_tpl,
        out_8_Ki_cfg_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_8_Ki_cfg_tpl,
        out_9_I_Sat_Limit_cfg_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_9_I_Sat_Limit_cfg_tpl,
        out_10_MaxV_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_10_MaxV_tpl,
        out_11_reset_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_11_reset_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        clk => clk,
        areset => areset
    );

    -- busFabric_DF_fixp16_alu_av_FOC_x(BLACKBOX,5)
    thebusFabric_DF_fixp16_alu_av_FOC_x : busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz
    PORT MAP (
        busIn_writedata => busIn_writedata,
        busIn_address => busIn_address,
        busIn_write => busIn_write,
        busIn_read => busIn_read,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        busOut_readdata => busFabric_DF_fixp16_alu_av_FOC_x_busOut_readdata,
        busOut_readdatavalid => busFabric_DF_fixp16_alu_av_FOC_x_busOut_readdatavalid,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl => busFabric_DF_fixp16_alu_av_FOC_x_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl,
        clk => clk,
        areset => areset,
        h_areset => h_areset
    );

    -- standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDelayed(DELAY,43)
    standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDelayed_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDelayed_q <= (others => '0');
            ELSE
                standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDelayed_q <= busIn_read;
            END IF;
        END IF;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDataValid(LOGICAL,44)
    standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDataValid_q <= STD_LOGIC_VECTOR(busFabric_DF_fixp16_alu_av_FOC_x_busOut_readdatavalid or standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDelayed_q);

    -- busOut(BUSOUT,4)
    busOut_readdatavalid <= standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_readDataValid_q;
    busOut_readdata <= busFabric_DF_fixp16_alu_av_FOC_x_busOut_readdata;
    busOut_waitrequest <= GND_q;

    -- dv(GPOUT,16)
    dv <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_1_dv_tpl;

    -- axisin(GPOUT,17)
    axisin <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_2_axisin_tpl;

    -- Iu(GPOUT,18)
    Iu <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_3_Iu_tpl;

    -- Iw(GPOUT,19)
    Iw <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_4_Iw_tpl;

    -- Torque(GPOUT,20)
    Torque <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_5_Torque_tpl;

    -- phi_el(GPOUT,21)
    phi_el <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_6_phi_el_tpl;

    -- Kp_cfg(GPOUT,22)
    Kp_cfg <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_7_Kp_cfg_tpl;

    -- Ki_cfg(GPOUT,23)
    Ki_cfg <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_8_Ki_cfg_tpl;

    -- I_Sat_Limit_cfg(GPOUT,24)
    I_Sat_Limit_cfg <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_9_I_Sat_Limit_cfg_tpl;

    -- MaxV(GPOUT,25)
    MaxV <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_10_MaxV_tpl;

    -- reset(GPOUT,26)
    reset <= DF_fixp16_alu_av_FOC_Avalon_Regs_x_out_11_reset_tpl;

END normal;
