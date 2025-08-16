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

-- VHDL created from standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters
-- VHDL created on Mon Aug 11 01:49:10 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb is
end;

architecture normal of standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_atb is

component standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters is
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
end component;

component standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        busOut_waitrequest_stm : out std_logic_vector(0 downto 0);
        MM_valid_out_stm : out std_logic_vector(0 downto 0);
        ia_A_stm : out std_logic_vector(15 downto 0);
        ib_A_stm : out std_logic_vector(15 downto 0);
        ic_A_stm : out std_logic_vector(15 downto 0);
        dTheta_dt_rad_s_stm : out std_logic_vector(15 downto 0);
        ThetaMech_one_turn_stm : out std_logic_vector(15 downto 0);
        ready_stm : out std_logic_vector(0 downto 0);
        MM_valid_in_stm : out std_logic_vector(0 downto 0);
        Vabc_range_V_cfg_stm : out std_logic_vector(15 downto 0);
        Va_V_stm : out std_logic_vector(15 downto 0);
        Vb_V_stm : out std_logic_vector(15 downto 0);
        Vc_V_stm : out std_logic_vector(15 downto 0);
        SampleTime_s_cfg_stm : out std_logic_vector(15 downto 0);
        Rphase_ohm_cfg_stm : out std_logic_vector(15 downto 0);
        inv_Lphase_1_H_cfg_stm : out std_logic_vector(15 downto 0);
        PolePairs_int_cfg_stm : out std_logic_vector(15 downto 0);
        Ke_Vs_rad_cfg_stm : out std_logic_vector(15 downto 0);
        Kt_Nm_A_cfg_stm : out std_logic_vector(15 downto 0);
        inv_J_1_kgm2_cfg_stm : out std_logic_vector(15 downto 0);
        LoadT_Nm_stm : out std_logic_vector(15 downto 0);
        DC_link_range_V_cfg_stm : out std_logic_vector(15 downto 0);
        DC_link_V_stm : out std_logic_vector(15 downto 0);
        Iabc_range_cfg_stm : out std_logic_vector(15 downto 0);
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
signal busOut_waitrequest_stm : STD_LOGIC_VECTOR (0 downto 0);
signal MM_valid_out_stm : STD_LOGIC_VECTOR (0 downto 0);
signal ia_A_stm : STD_LOGIC_VECTOR (15 downto 0);
signal ib_A_stm : STD_LOGIC_VECTOR (15 downto 0);
signal ic_A_stm : STD_LOGIC_VECTOR (15 downto 0);
signal dTheta_dt_rad_s_stm : STD_LOGIC_VECTOR (15 downto 0);
signal ThetaMech_one_turn_stm : STD_LOGIC_VECTOR (15 downto 0);
signal ready_stm : STD_LOGIC_VECTOR (0 downto 0);
signal MM_valid_in_stm : STD_LOGIC_VECTOR (0 downto 0);
signal Vabc_range_V_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Va_V_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Vb_V_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Vc_V_stm : STD_LOGIC_VECTOR (15 downto 0);
signal SampleTime_s_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Rphase_ohm_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal inv_Lphase_1_H_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal PolePairs_int_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Ke_Vs_rad_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Kt_Nm_A_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal inv_J_1_kgm2_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal LoadT_Nm_stm : STD_LOGIC_VECTOR (15 downto 0);
signal DC_link_range_V_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal DC_link_V_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Iabc_range_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal busIn_writedata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busIn_address_dut : STD_LOGIC_VECTOR (5 downto 0);
signal busIn_write_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_read_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdatavalid_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busOut_waitrequest_dut : STD_LOGIC_VECTOR (0 downto 0);
signal MM_valid_out_dut : STD_LOGIC_VECTOR (0 downto 0);
signal ia_A_dut : STD_LOGIC_VECTOR (15 downto 0);
signal ib_A_dut : STD_LOGIC_VECTOR (15 downto 0);
signal ic_A_dut : STD_LOGIC_VECTOR (15 downto 0);
signal dTheta_dt_rad_s_dut : STD_LOGIC_VECTOR (15 downto 0);
signal ThetaMech_one_turn_dut : STD_LOGIC_VECTOR (15 downto 0);
signal ready_dut : STD_LOGIC_VECTOR (0 downto 0);
signal MM_valid_in_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Vabc_range_V_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Va_V_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Vb_V_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Vc_V_dut : STD_LOGIC_VECTOR (15 downto 0);
signal SampleTime_s_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Rphase_ohm_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal inv_Lphase_1_H_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal PolePairs_int_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Ke_Vs_rad_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Kt_Nm_A_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal inv_J_1_kgm2_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal LoadT_Nm_dut : STD_LOGIC_VECTOR (15 downto 0);
signal DC_link_range_V_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal DC_link_V_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Iabc_range_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;
        signal h_areset : std_logic;

begin

-- Bus data out
-- General Purpose data in real output
checkMM_valid_out : process (clk, areset, MM_valid_out_dut, MM_valid_out_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkia_A : process (clk, areset, ia_A_dut, ia_A_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkib_A : process (clk, areset, ib_A_dut, ib_A_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkic_A : process (clk, areset, ic_A_dut, ic_A_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkdTheta_dt_rad_s : process (clk, areset, dTheta_dt_rad_s_dut, dTheta_dt_rad_s_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkThetaMech_one_turn : process (clk, areset, ThetaMech_one_turn_dut, ThetaMech_one_turn_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkready : process (clk, areset, ready_dut, ready_stm)
begin
END PROCESS;


-- General Purpose data out check
checkMM_valid_in : process (clk, areset)
variable mismatch_MM_valid_in : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_MM_valid_in := FALSE;
        IF ( (MM_valid_in_dut /= MM_valid_in_stm)) THEN
            mismatch_MM_valid_in := TRUE;
            report "Mismatch on device output pin MM_valid_in" severity Warning;
        END IF;
        IF (mismatch_MM_valid_in = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkVabc_range_V_cfg : process (clk, areset)
variable mismatch_Vabc_range_V_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Vabc_range_V_cfg := FALSE;
        IF ( (Vabc_range_V_cfg_dut /= Vabc_range_V_cfg_stm)) THEN
            mismatch_Vabc_range_V_cfg := TRUE;
            report "Mismatch on device output pin Vabc_range_V_cfg" severity Warning;
        END IF;
        IF (mismatch_Vabc_range_V_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkVa_V : process (clk, areset)
variable mismatch_Va_V : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Va_V := FALSE;
        IF ( (Va_V_dut /= Va_V_stm)) THEN
            mismatch_Va_V := TRUE;
            report "Mismatch on device output pin Va_V" severity Warning;
        END IF;
        IF (mismatch_Va_V = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkVb_V : process (clk, areset)
variable mismatch_Vb_V : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Vb_V := FALSE;
        IF ( (Vb_V_dut /= Vb_V_stm)) THEN
            mismatch_Vb_V := TRUE;
            report "Mismatch on device output pin Vb_V" severity Warning;
        END IF;
        IF (mismatch_Vb_V = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkVc_V : process (clk, areset)
variable mismatch_Vc_V : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Vc_V := FALSE;
        IF ( (Vc_V_dut /= Vc_V_stm)) THEN
            mismatch_Vc_V := TRUE;
            report "Mismatch on device output pin Vc_V" severity Warning;
        END IF;
        IF (mismatch_Vc_V = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkSampleTime_s_cfg : process (clk, areset)
variable mismatch_SampleTime_s_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_SampleTime_s_cfg := FALSE;
        IF ( (SampleTime_s_cfg_dut /= SampleTime_s_cfg_stm)) THEN
            mismatch_SampleTime_s_cfg := TRUE;
            report "Mismatch on device output pin SampleTime_s_cfg" severity Warning;
        END IF;
        IF (mismatch_SampleTime_s_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkRphase_ohm_cfg : process (clk, areset)
variable mismatch_Rphase_ohm_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Rphase_ohm_cfg := FALSE;
        IF ( (Rphase_ohm_cfg_dut /= Rphase_ohm_cfg_stm)) THEN
            mismatch_Rphase_ohm_cfg := TRUE;
            report "Mismatch on device output pin Rphase_ohm_cfg" severity Warning;
        END IF;
        IF (mismatch_Rphase_ohm_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkinv_Lphase_1_H_cfg : process (clk, areset)
variable mismatch_inv_Lphase_1_H_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_inv_Lphase_1_H_cfg := FALSE;
        IF ( (inv_Lphase_1_H_cfg_dut /= inv_Lphase_1_H_cfg_stm)) THEN
            mismatch_inv_Lphase_1_H_cfg := TRUE;
            report "Mismatch on device output pin inv_Lphase_1_H_cfg" severity Warning;
        END IF;
        IF (mismatch_inv_Lphase_1_H_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkPolePairs_int_cfg : process (clk, areset)
variable mismatch_PolePairs_int_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_PolePairs_int_cfg := FALSE;
        IF ( (PolePairs_int_cfg_dut /= PolePairs_int_cfg_stm)) THEN
            mismatch_PolePairs_int_cfg := TRUE;
            report "Mismatch on device output pin PolePairs_int_cfg" severity Warning;
        END IF;
        IF (mismatch_PolePairs_int_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkKe_Vs_rad_cfg : process (clk, areset)
variable mismatch_Ke_Vs_rad_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Ke_Vs_rad_cfg := FALSE;
        IF ( (Ke_Vs_rad_cfg_dut /= Ke_Vs_rad_cfg_stm)) THEN
            mismatch_Ke_Vs_rad_cfg := TRUE;
            report "Mismatch on device output pin Ke_Vs_rad_cfg" severity Warning;
        END IF;
        IF (mismatch_Ke_Vs_rad_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkKt_Nm_A_cfg : process (clk, areset)
variable mismatch_Kt_Nm_A_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Kt_Nm_A_cfg := FALSE;
        IF ( (Kt_Nm_A_cfg_dut /= Kt_Nm_A_cfg_stm)) THEN
            mismatch_Kt_Nm_A_cfg := TRUE;
            report "Mismatch on device output pin Kt_Nm_A_cfg" severity Warning;
        END IF;
        IF (mismatch_Kt_Nm_A_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkinv_J_1_kgm2_cfg : process (clk, areset)
variable mismatch_inv_J_1_kgm2_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_inv_J_1_kgm2_cfg := FALSE;
        IF ( (inv_J_1_kgm2_cfg_dut /= inv_J_1_kgm2_cfg_stm)) THEN
            mismatch_inv_J_1_kgm2_cfg := TRUE;
            report "Mismatch on device output pin inv_J_1_kgm2_cfg" severity Warning;
        END IF;
        IF (mismatch_inv_J_1_kgm2_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkLoadT_Nm : process (clk, areset)
variable mismatch_LoadT_Nm : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_LoadT_Nm := FALSE;
        IF ( (LoadT_Nm_dut /= LoadT_Nm_stm)) THEN
            mismatch_LoadT_Nm := TRUE;
            report "Mismatch on device output pin LoadT_Nm" severity Warning;
        END IF;
        IF (mismatch_LoadT_Nm = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkDC_link_range_V_cfg : process (clk, areset)
variable mismatch_DC_link_range_V_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_DC_link_range_V_cfg := FALSE;
        IF ( (DC_link_range_V_cfg_dut /= DC_link_range_V_cfg_stm)) THEN
            mismatch_DC_link_range_V_cfg := TRUE;
            report "Mismatch on device output pin DC_link_range_V_cfg" severity Warning;
        END IF;
        IF (mismatch_DC_link_range_V_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkDC_link_V : process (clk, areset)
variable mismatch_DC_link_V : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_DC_link_V := FALSE;
        IF ( (DC_link_V_dut /= DC_link_V_stm)) THEN
            mismatch_DC_link_V := TRUE;
            report "Mismatch on device output pin DC_link_V" severity Warning;
        END IF;
        IF (mismatch_DC_link_V = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkIabc_range_cfg : process (clk, areset)
variable mismatch_Iabc_range_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Iabc_range_cfg := FALSE;
        IF ( (Iabc_range_cfg_dut /= Iabc_range_cfg_stm)) THEN
            mismatch_Iabc_range_cfg := TRUE;
            report "Mismatch on device output pin Iabc_range_cfg" severity Warning;
        END IF;
        IF (mismatch_Iabc_range_cfg = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


dut : standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_dut,
    busOut_readdata_dut,
    busOut_waitrequest_dut,
    MM_valid_out_stm,
    ia_A_stm,
    ib_A_stm,
    ic_A_stm,
    dTheta_dt_rad_s_stm,
    ThetaMech_one_turn_stm,
    ready_stm,
    MM_valid_in_dut,
    Vabc_range_V_cfg_dut,
    Va_V_dut,
    Vb_V_dut,
    Vc_V_dut,
    SampleTime_s_cfg_dut,
    Rphase_ohm_cfg_dut,
    inv_Lphase_1_H_cfg_dut,
    PolePairs_int_cfg_dut,
    Ke_Vs_rad_cfg_dut,
    Kt_Nm_A_cfg_dut,
    inv_J_1_kgm2_cfg_dut,
    LoadT_Nm_dut,
    DC_link_range_V_cfg_dut,
    DC_link_V_dut,
    Iabc_range_cfg_dut,
        clk,
        areset,
        h_areset
);

sim : standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_stm port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_stm,
    busOut_readdata_stm,
    busOut_waitrequest_stm,
    MM_valid_out_stm,
    ia_A_stm,
    ib_A_stm,
    ic_A_stm,
    dTheta_dt_rad_s_stm,
    ThetaMech_one_turn_stm,
    ready_stm,
    MM_valid_in_stm,
    Vabc_range_V_cfg_stm,
    Va_V_stm,
    Vb_V_stm,
    Vc_V_stm,
    SampleTime_s_cfg_stm,
    Rphase_ohm_cfg_stm,
    inv_Lphase_1_H_cfg_stm,
    PolePairs_int_cfg_stm,
    Ke_Vs_rad_cfg_stm,
    Kt_Nm_A_cfg_stm,
    inv_J_1_kgm2_cfg_stm,
    LoadT_Nm_stm,
    DC_link_range_V_cfg_stm,
    DC_link_V_stm,
    Iabc_range_cfg_stm,
        clk,
        areset,
        h_areset
);

end normal;
