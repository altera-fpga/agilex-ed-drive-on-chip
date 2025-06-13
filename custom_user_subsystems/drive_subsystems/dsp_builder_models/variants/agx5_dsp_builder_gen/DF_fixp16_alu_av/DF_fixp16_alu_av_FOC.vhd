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

-- VHDL created from DF_fixp16_alu_av_FOC
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
entity DF_fixp16_alu_av_FOC is
    port (
        busIn_writedata : in std_logic_vector(31 downto 0);  -- ufix32
        busIn_address : in std_logic_vector(5 downto 0);  -- ufix6
        busIn_write : in std_logic_vector(0 downto 0);  -- ufix1
        busIn_read : in std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdatavalid : out std_logic_vector(0 downto 0);  -- ufix1
        busOut_readdata : out std_logic_vector(31 downto 0);  -- ufix32
        busOut_waitrequest : out std_logic_vector(0 downto 0);  -- ufix1
        Iu : in std_logic_vector(15 downto 0);  -- sfix16_en10
        Iw : in std_logic_vector(15 downto 0);  -- sfix16_en10
        vu_pwm : out std_logic_vector(15 downto 0);  -- ufix16
        vv_pwm : out std_logic_vector(15 downto 0);  -- ufix16
        vw_pwm : out std_logic_vector(15 downto 0);  -- ufix16
        clk : in std_logic;
        areset : in std_logic;
        h_areset : in std_logic
    );
end DF_fixp16_alu_av_FOC;

architecture normal of DF_fixp16_alu_av_FOC is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
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


    component DF_fixp16_alu_av_FOC_fb_latches is
        port (
            in_1_id_int_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_2_iq_int_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_3_qv_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_4_valid_out_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_5_axis_out_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_6_axis_in_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_7_reset_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_1_id_int_latch_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_2_iq_int_latch_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


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


    component DF_fixp16_alu_av_FOC_FL_fixp16 is
        port (
            in_1_dv_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_2_dc_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_3_valid_in_tpl : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_4_axis_in_tpl : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_5_Iu_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_6_Iw_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_7_Torque_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_8_IntegralQ_in_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_9_IntegralD_in_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_10_phi_el_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_11_Kp_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_12_Ki_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_13_I_Sat_Limit_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            in_14_Max_tpl : in std_logic_vector(15 downto 0);  -- Fixed Point
            out_1_qv_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_2_qc_tpl : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_3_valid_out_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_4_axis_out_tpl : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_5_Valpha_tpl : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_6_Vbeta_tpl : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_7_IntegralD_out_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_8_IntegralQ_out_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_9_Iq_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_10_Id_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_11_uvw_0_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_11_uvw_1_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_11_uvw_2_tpl : out std_logic_vector(15 downto 0);  -- Fixed Point
            out_12_ready_tpl : out std_logic_vector(0 downto 0);  -- Fixed Point
            clk : in std_logic;
            areset : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Constantdc1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal busFabric_busOut_readdata : STD_LOGIC_VECTOR (31 downto 0);
    signal busFabric_busOut_readdatavalid : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl : STD_LOGIC_VECTOR (7 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal fb_latches_out_1_id_int_latch_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal fb_latches_out_2_iq_int_latch_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_1_dv_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_2_axisin_tpl : STD_LOGIC_VECTOR (7 downto 0);
    signal Avalon_Regs_vunroll_x_out_5_Torque_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_6_phi_el_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_7_Kp_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_8_Ki_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_9_I_Sat_Limit_cfg_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_10_MaxV_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_11_reset_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : STD_LOGIC_VECTOR (7 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : STD_LOGIC_VECTOR (31 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : STD_LOGIC_VECTOR (31 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal FL_fixp16_vunroll_x_out_1_qv_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal FL_fixp16_vunroll_x_out_3_valid_out_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal FL_fixp16_vunroll_x_out_4_axis_out_tpl : STD_LOGIC_VECTOR (7 downto 0);
    signal FL_fixp16_vunroll_x_out_5_Valpha_tpl : STD_LOGIC_VECTOR (31 downto 0);
    signal FL_fixp16_vunroll_x_out_6_Vbeta_tpl : STD_LOGIC_VECTOR (31 downto 0);
    signal FL_fixp16_vunroll_x_out_7_IntegralD_out_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal FL_fixp16_vunroll_x_out_8_IntegralQ_out_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal FL_fixp16_vunroll_x_out_9_Iq_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal FL_fixp16_vunroll_x_out_10_Id_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal FL_fixp16_vunroll_x_out_11_uvw_0_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal FL_fixp16_vunroll_x_out_11_uvw_1_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal FL_fixp16_vunroll_x_out_11_uvw_2_tpl : STD_LOGIC_VECTOR (15 downto 0);
    signal FL_fixp16_vunroll_x_out_12_ready_tpl : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_readDelayed_q : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_readDataValid_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- fb_latches(BLACKBOX,6)
    thefb_latches : DF_fixp16_alu_av_FOC_fb_latches
    PORT MAP (
        in_1_id_int_tpl => FL_fixp16_vunroll_x_out_7_IntegralD_out_tpl,
        in_2_iq_int_tpl => FL_fixp16_vunroll_x_out_8_IntegralQ_out_tpl,
        in_3_qv_tpl => FL_fixp16_vunroll_x_out_1_qv_tpl,
        in_4_valid_out_tpl => FL_fixp16_vunroll_x_out_3_valid_out_tpl,
        in_5_axis_out_tpl => FL_fixp16_vunroll_x_out_4_axis_out_tpl,
        in_6_axis_in_tpl => Avalon_Regs_vunroll_x_out_2_axisin_tpl,
        in_7_reset_tpl => Avalon_Regs_vunroll_x_out_11_reset_tpl,
        out_1_id_int_latch_tpl => fb_latches_out_1_id_int_latch_tpl,
        out_2_iq_int_latch_tpl => fb_latches_out_2_iq_int_latch_tpl,
        clk => clk,
        areset => areset
    );

    -- Constantdc1(CONSTANT,2)
    Constantdc1_q <= "00000000";

    -- FL_fixp16_vunroll_x(BLACKBOX,9)
    theFL_fixp16_vunroll_x : DF_fixp16_alu_av_FOC_FL_fixp16
    PORT MAP (
        in_1_dv_tpl => Avalon_Regs_vunroll_x_out_1_dv_tpl,
        in_2_dc_tpl => Constantdc1_q,
        in_3_valid_in_tpl => Avalon_Regs_vunroll_x_out_1_dv_tpl,
        in_4_axis_in_tpl => Avalon_Regs_vunroll_x_out_2_axisin_tpl,
        in_5_Iu_tpl => Iu,
        in_6_Iw_tpl => Iw,
        in_7_Torque_tpl => Avalon_Regs_vunroll_x_out_5_Torque_tpl,
        in_8_IntegralQ_in_tpl => fb_latches_out_2_iq_int_latch_tpl,
        in_9_IntegralD_in_tpl => fb_latches_out_1_id_int_latch_tpl,
        in_10_phi_el_tpl => Avalon_Regs_vunroll_x_out_6_phi_el_tpl,
        in_11_Kp_tpl => Avalon_Regs_vunroll_x_out_7_Kp_cfg_tpl,
        in_12_Ki_tpl => Avalon_Regs_vunroll_x_out_8_Ki_cfg_tpl,
        in_13_I_Sat_Limit_tpl => Avalon_Regs_vunroll_x_out_9_I_Sat_Limit_cfg_tpl,
        in_14_Max_tpl => Avalon_Regs_vunroll_x_out_10_MaxV_tpl,
        out_1_qv_tpl => FL_fixp16_vunroll_x_out_1_qv_tpl,
        out_3_valid_out_tpl => FL_fixp16_vunroll_x_out_3_valid_out_tpl,
        out_4_axis_out_tpl => FL_fixp16_vunroll_x_out_4_axis_out_tpl,
        out_5_Valpha_tpl => FL_fixp16_vunroll_x_out_5_Valpha_tpl,
        out_6_Vbeta_tpl => FL_fixp16_vunroll_x_out_6_Vbeta_tpl,
        out_7_IntegralD_out_tpl => FL_fixp16_vunroll_x_out_7_IntegralD_out_tpl,
        out_8_IntegralQ_out_tpl => FL_fixp16_vunroll_x_out_8_IntegralQ_out_tpl,
        out_9_Iq_tpl => FL_fixp16_vunroll_x_out_9_Iq_tpl,
        out_10_Id_tpl => FL_fixp16_vunroll_x_out_10_Id_tpl,
        out_11_uvw_0_tpl => FL_fixp16_vunroll_x_out_11_uvw_0_tpl,
        out_11_uvw_1_tpl => FL_fixp16_vunroll_x_out_11_uvw_1_tpl,
        out_11_uvw_2_tpl => FL_fixp16_vunroll_x_out_11_uvw_2_tpl,
        out_12_ready_tpl => FL_fixp16_vunroll_x_out_12_ready_tpl,
        clk => clk,
        areset => areset
    );

    -- Avalon_Regs_vunroll_x(BLACKBOX,8)
    theAvalon_Regs_vunroll_x : DF_fixp16_alu_av_FOC_Avalon_Regs
    PORT MAP (
        in_1_qv_tpl => FL_fixp16_vunroll_x_out_1_qv_tpl,
        in_2_Valpha_tpl => FL_fixp16_vunroll_x_out_5_Valpha_tpl,
        in_3_Vbeta_tpl => FL_fixp16_vunroll_x_out_6_Vbeta_tpl,
        in_4_Iq_tpl => FL_fixp16_vunroll_x_out_9_Iq_tpl,
        in_5_Id_tpl => FL_fixp16_vunroll_x_out_10_Id_tpl,
        in_6_Ready_tpl => FL_fixp16_vunroll_x_out_12_ready_tpl,
        in_7_Vuvwin_0_tpl => FL_fixp16_vunroll_x_out_11_uvw_0_tpl,
        in_7_Vuvwin_1_tpl => FL_fixp16_vunroll_x_out_11_uvw_1_tpl,
        in_7_Vuvwin_2_tpl => FL_fixp16_vunroll_x_out_11_uvw_2_tpl,
        in_8_AxisOut_tpl => FL_fixp16_vunroll_x_out_4_axis_out_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl,
        in_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl,
        out_1_dv_tpl => Avalon_Regs_vunroll_x_out_1_dv_tpl,
        out_2_axisin_tpl => Avalon_Regs_vunroll_x_out_2_axisin_tpl,
        out_5_Torque_tpl => Avalon_Regs_vunroll_x_out_5_Torque_tpl,
        out_6_phi_el_tpl => Avalon_Regs_vunroll_x_out_6_phi_el_tpl,
        out_7_Kp_cfg_tpl => Avalon_Regs_vunroll_x_out_7_Kp_cfg_tpl,
        out_8_Ki_cfg_tpl => Avalon_Regs_vunroll_x_out_8_Ki_cfg_tpl,
        out_9_I_Sat_Limit_cfg_tpl => Avalon_Regs_vunroll_x_out_9_I_Sat_Limit_cfg_tpl,
        out_10_MaxV_tpl => Avalon_Regs_vunroll_x_out_10_MaxV_tpl,
        out_11_reset_tpl => Avalon_Regs_vunroll_x_out_11_reset_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        clk => clk,
        areset => areset
    );

    -- busFabric(BLACKBOX,3)
    thebusFabric : busFabric_DF_fixp16_alu_av_FOC_217ipvmsy06j62696x6g656u0qu5xgbvsfqz
    PORT MAP (
        busIn_writedata => busIn_writedata,
        busIn_address => busIn_address,
        busIn_write => busIn_write,
        busIn_read => busIn_read,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        in_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortData_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Busy_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Ready_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Id_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Iq_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Valpha_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vbeta_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vu_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vv_Output_x_tpl,
        in_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl => Avalon_Regs_vunroll_x_out_AMMregisterPortWriteEn_DF_fixp16_alu_av_FOC_Avalon_Regs_Vw_Output_x_tpl,
        busOut_readdata => busFabric_busOut_readdata,
        busOut_readdatavalid => busFabric_busOut_readdatavalid,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Axis_In_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_DSPBA_Start_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_I_Sat_Limit_cfg_CFG_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iu_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Iw_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Ki_cfg_CFG_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Kp_cfg_CFG_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_MaxPWMvalue_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_Torque_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_phi_el_Input_x_tpl,
        out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl => busFabric_out_AMMregisterWireData_DF_fixp16_alu_av_FOC_Avalon_Regs_reset_Input_x_tpl,
        clk => clk,
        areset => areset,
        h_areset => h_areset
    );

    -- DF_fixp16_alu_av_FOC_readDelayed(DELAY,21)
    DF_fixp16_alu_av_FOC_readDelayed_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (h_areset = '1') THEN
                DF_fixp16_alu_av_FOC_readDelayed_q <= (others => '0');
            ELSE
                DF_fixp16_alu_av_FOC_readDelayed_q <= busIn_read;
            END IF;
        END IF;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- DF_fixp16_alu_av_FOC_readDataValid(LOGICAL,22)
    DF_fixp16_alu_av_FOC_readDataValid_q <= STD_LOGIC_VECTOR(busFabric_busOut_readdatavalid or DF_fixp16_alu_av_FOC_readDelayed_q);

    -- busOut(BUSOUT,5)
    busOut_readdatavalid <= DF_fixp16_alu_av_FOC_readDataValid_q;
    busOut_readdata <= busFabric_busOut_readdata;
    busOut_waitrequest <= GND_q;

    -- vu_pwm(GPOUT,14)
    vu_pwm <= FL_fixp16_vunroll_x_out_11_uvw_0_tpl;

    -- vv_pwm(GPOUT,15)
    vv_pwm <= FL_fixp16_vunroll_x_out_11_uvw_1_tpl;

    -- vw_pwm(GPOUT,16)
    vw_pwm <= FL_fixp16_vunroll_x_out_11_uvw_2_tpl;

END normal;
