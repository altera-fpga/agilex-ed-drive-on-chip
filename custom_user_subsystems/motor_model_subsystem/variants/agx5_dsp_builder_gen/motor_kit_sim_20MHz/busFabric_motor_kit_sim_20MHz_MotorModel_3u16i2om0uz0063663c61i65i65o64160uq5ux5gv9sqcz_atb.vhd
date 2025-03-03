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
-- VHDL created on Wed Aug  7 11:03:58 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb is
end;

architecture normal of busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_atb is

component busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz is
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
end component;

component busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_stm : out std_logic_vector(0 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        clk : out std_logic;
        areset : out std_logic;
        h_areset : out std_logic
    );
end component;

signal busIn_writedata_stm : STD_LOGIC_VECTOR (31 downto 0);
signal busIn_address_stm : STD_LOGIC_VECTOR (5 downto 0);
signal busIn_write_stm : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_read_stm : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdatavalid_stm : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdata_stm : STD_LOGIC_VECTOR (31 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal busIn_writedata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busIn_address_dut : STD_LOGIC_VECTOR (5 downto 0);
signal busIn_write_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_read_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdatavalid_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;
        signal h_areset : std_logic;

begin

-- Bus data out
-- General Purpose data in real output
checkin_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : process (clk, areset, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_dut, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : process (clk, areset, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_dut, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : process (clk, areset, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_dut, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : process (clk, areset, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_dut, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : process (clk, areset, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_dut, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : process (clk, areset, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_dut, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : process (clk, areset, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_dut, in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl : process (clk, areset, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_dut, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl : process (clk, areset, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_dut, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl : process (clk, areset, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_dut, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl : process (clk, areset, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_dut, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl : process (clk, areset, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_dut, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl : process (clk, areset, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_dut, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkin_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl : process (clk, areset, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_dut, in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm)
begin
END PROCESS;


dut : busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_dut,
    busOut_readdata_dut,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_dut,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_dut,
        clk,
        areset,
        h_areset
);

sim : busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_stm port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_stm,
    busOut_readdata_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm,
    in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm,
    in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_stm,
    out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_stm,
        clk,
        areset,
        h_areset
);

end normal;
