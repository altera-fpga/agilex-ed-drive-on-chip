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
-- VHDL created on Wed Aug  7 11:04:00 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity motor_kit_sim_20MHz_MotorModel_atb is
end;

architecture normal of motor_kit_sim_20MHz_MotorModel_atb is

component motor_kit_sim_20MHz_MotorModel is
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
end component;

component motor_kit_sim_20MHz_MotorModel_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        busOut_waitrequest_stm : out std_logic_vector(0 downto 0);
        u_h_stm : out std_logic_vector(0 downto 0);
        v_h_stm : out std_logic_vector(0 downto 0);
        w_h_stm : out std_logic_vector(0 downto 0);
        u_l_stm : out std_logic_vector(0 downto 0);
        v_l_stm : out std_logic_vector(0 downto 0);
        w_l_stm : out std_logic_vector(0 downto 0);
        powerdown_p_stm : out std_logic_vector(0 downto 0);
        powerdown_n_stm : out std_logic_vector(0 downto 0);
        ia_sd_stm : out std_logic_vector(0 downto 0);
        ib_sd_stm : out std_logic_vector(0 downto 0);
        ic_sd_stm : out std_logic_vector(0 downto 0);
        Va_sd_stm : out std_logic_vector(0 downto 0);
        Vb_sd_stm : out std_logic_vector(0 downto 0);
        Vc_sd_stm : out std_logic_vector(0 downto 0);
        QEP_A_stm : out std_logic_vector(0 downto 0);
        QEP_B_stm : out std_logic_vector(0 downto 0);
        Theta_one_turn_k_stm : out std_logic_vector(15 downto 0);
        V_DC_link_sd_stm : out std_logic_vector(0 downto 0);
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
signal u_h_stm : STD_LOGIC_VECTOR (0 downto 0);
signal v_h_stm : STD_LOGIC_VECTOR (0 downto 0);
signal w_h_stm : STD_LOGIC_VECTOR (0 downto 0);
signal u_l_stm : STD_LOGIC_VECTOR (0 downto 0);
signal v_l_stm : STD_LOGIC_VECTOR (0 downto 0);
signal w_l_stm : STD_LOGIC_VECTOR (0 downto 0);
signal powerdown_p_stm : STD_LOGIC_VECTOR (0 downto 0);
signal powerdown_n_stm : STD_LOGIC_VECTOR (0 downto 0);
signal ia_sd_stm : STD_LOGIC_VECTOR (0 downto 0);
signal ib_sd_stm : STD_LOGIC_VECTOR (0 downto 0);
signal ic_sd_stm : STD_LOGIC_VECTOR (0 downto 0);
signal Va_sd_stm : STD_LOGIC_VECTOR (0 downto 0);
signal Vb_sd_stm : STD_LOGIC_VECTOR (0 downto 0);
signal Vc_sd_stm : STD_LOGIC_VECTOR (0 downto 0);
signal QEP_A_stm : STD_LOGIC_VECTOR (0 downto 0);
signal QEP_B_stm : STD_LOGIC_VECTOR (0 downto 0);
signal Theta_one_turn_k_stm : STD_LOGIC_VECTOR (15 downto 0);
signal V_DC_link_sd_stm : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_writedata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busIn_address_dut : STD_LOGIC_VECTOR (5 downto 0);
signal busIn_write_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_read_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdatavalid_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busOut_waitrequest_dut : STD_LOGIC_VECTOR (0 downto 0);
signal u_h_dut : STD_LOGIC_VECTOR (0 downto 0);
signal v_h_dut : STD_LOGIC_VECTOR (0 downto 0);
signal w_h_dut : STD_LOGIC_VECTOR (0 downto 0);
signal u_l_dut : STD_LOGIC_VECTOR (0 downto 0);
signal v_l_dut : STD_LOGIC_VECTOR (0 downto 0);
signal w_l_dut : STD_LOGIC_VECTOR (0 downto 0);
signal powerdown_p_dut : STD_LOGIC_VECTOR (0 downto 0);
signal powerdown_n_dut : STD_LOGIC_VECTOR (0 downto 0);
signal ia_sd_dut : STD_LOGIC_VECTOR (0 downto 0);
signal ib_sd_dut : STD_LOGIC_VECTOR (0 downto 0);
signal ic_sd_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Va_sd_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Vb_sd_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Vc_sd_dut : STD_LOGIC_VECTOR (0 downto 0);
signal QEP_A_dut : STD_LOGIC_VECTOR (0 downto 0);
signal QEP_B_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Theta_one_turn_k_dut : STD_LOGIC_VECTOR (15 downto 0);
signal V_DC_link_sd_dut : STD_LOGIC_VECTOR (0 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;
        signal h_areset : std_logic;

begin

-- Bus data out
checkbusOut : process (clk, h_areset)
variable mismatch_busOut_readdatavalid : BOOLEAN := FALSE;
variable mismatch_busOut_readdata : BOOLEAN := FALSE;
variable mismatch_busOut_waitrequest : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((h_areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_busOut_readdatavalid := FALSE;
        mismatch_busOut_readdata := FALSE;
        mismatch_busOut_waitrequest := FALSE;
        IF ( (busOut_readdatavalid_dut /= busOut_readdatavalid_stm)) THEN
            mismatch_busOut_readdatavalid := TRUE;
            report "mismatch in busOut_readdatavalid signal" severity Warning;
        END IF;
        IF ((busOut_readdatavalid_dut = "1")) THEN
            IF ( (busOut_readdata_dut /= busOut_readdata_stm)) THEN
                mismatch_busOut_readdata := TRUE;
                report "mismatch in busOut_readdata signal" severity Warning;
            END IF;
            IF ( (busOut_waitrequest_dut /= busOut_waitrequest_stm)) THEN
                mismatch_busOut_waitrequest := TRUE;
                report "mismatch in busOut_waitrequest signal" severity Warning;
            END IF;
        END IF;
        IF (mismatch_busOut_readdatavalid = TRUE or mismatch_busOut_readdata = TRUE or mismatch_busOut_waitrequest = TRUE) THEN
            ok := FALSE;
        END IF;
        IF (ok = FALSE) THEN
            report "Mismatch detected" severity Warning;
        END IF;
    END IF;
END PROCESS;


-- General Purpose data in real output
checku_h : process (clk, areset, u_h_dut, u_h_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkv_h : process (clk, areset, v_h_dut, v_h_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkw_h : process (clk, areset, w_h_dut, w_h_stm)
begin
END PROCESS;


-- General Purpose data in real output
checku_l : process (clk, areset, u_l_dut, u_l_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkv_l : process (clk, areset, v_l_dut, v_l_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkw_l : process (clk, areset, w_l_dut, w_l_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkpowerdown_p : process (clk, areset, powerdown_p_dut, powerdown_p_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkpowerdown_n : process (clk, areset, powerdown_n_dut, powerdown_n_stm)
begin
END PROCESS;


-- General Purpose data out check
checkia_sd : process (clk, areset)
variable mismatch_ia_sd : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_ia_sd := FALSE;
        IF ( (ia_sd_dut /= ia_sd_stm)) THEN
            mismatch_ia_sd := TRUE;
            report "Mismatch on device output pin ia_sd" severity Warning;
        END IF;
        IF (mismatch_ia_sd = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkib_sd : process (clk, areset)
variable mismatch_ib_sd : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_ib_sd := FALSE;
        IF ( (ib_sd_dut /= ib_sd_stm)) THEN
            mismatch_ib_sd := TRUE;
            report "Mismatch on device output pin ib_sd" severity Warning;
        END IF;
        IF (mismatch_ib_sd = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkic_sd : process (clk, areset)
variable mismatch_ic_sd : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_ic_sd := FALSE;
        IF ( (ic_sd_dut /= ic_sd_stm)) THEN
            mismatch_ic_sd := TRUE;
            report "Mismatch on device output pin ic_sd" severity Warning;
        END IF;
        IF (mismatch_ic_sd = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkVa_sd : process (clk, areset)
variable mismatch_Va_sd : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Va_sd := FALSE;
        IF ( (Va_sd_dut /= Va_sd_stm)) THEN
            mismatch_Va_sd := TRUE;
            report "Mismatch on device output pin Va_sd" severity Warning;
        END IF;
        IF (mismatch_Va_sd = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkVb_sd : process (clk, areset)
variable mismatch_Vb_sd : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Vb_sd := FALSE;
        IF ( (Vb_sd_dut /= Vb_sd_stm)) THEN
            mismatch_Vb_sd := TRUE;
            report "Mismatch on device output pin Vb_sd" severity Warning;
        END IF;
        IF (mismatch_Vb_sd = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkVc_sd : process (clk, areset)
variable mismatch_Vc_sd : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Vc_sd := FALSE;
        IF ( (Vc_sd_dut /= Vc_sd_stm)) THEN
            mismatch_Vc_sd := TRUE;
            report "Mismatch on device output pin Vc_sd" severity Warning;
        END IF;
        IF (mismatch_Vc_sd = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkQEP_A : process (clk, areset)
variable mismatch_QEP_A : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_QEP_A := FALSE;
        IF ( (QEP_A_dut /= QEP_A_stm)) THEN
            mismatch_QEP_A := TRUE;
            report "Mismatch on device output pin QEP_A" severity Warning;
        END IF;
        IF (mismatch_QEP_A = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkQEP_B : process (clk, areset)
variable mismatch_QEP_B : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_QEP_B := FALSE;
        IF ( (QEP_B_dut /= QEP_B_stm)) THEN
            mismatch_QEP_B := TRUE;
            report "Mismatch on device output pin QEP_B" severity Warning;
        END IF;
        IF (mismatch_QEP_B = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkTheta_one_turn_k : process (clk, areset)
variable mismatch_Theta_one_turn_k : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Theta_one_turn_k := FALSE;
        IF ( (Theta_one_turn_k_dut /= Theta_one_turn_k_stm)) THEN
            mismatch_Theta_one_turn_k := TRUE;
            report "Mismatch on device output pin Theta_one_turn_k" severity Warning;
        END IF;
        IF (mismatch_Theta_one_turn_k = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkV_DC_link_sd : process (clk, areset)
variable mismatch_V_DC_link_sd : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_V_DC_link_sd := FALSE;
        IF ( (V_DC_link_sd_dut /= V_DC_link_sd_stm)) THEN
            mismatch_V_DC_link_sd := TRUE;
            report "Mismatch on device output pin V_DC_link_sd" severity Warning;
        END IF;
        IF (mismatch_V_DC_link_sd = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


dut : motor_kit_sim_20MHz_MotorModel port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_dut,
    busOut_readdata_dut,
    busOut_waitrequest_dut,
    u_h_stm,
    v_h_stm,
    w_h_stm,
    u_l_stm,
    v_l_stm,
    w_l_stm,
    powerdown_p_stm,
    powerdown_n_stm,
    ia_sd_dut,
    ib_sd_dut,
    ic_sd_dut,
    Va_sd_dut,
    Vb_sd_dut,
    Vc_sd_dut,
    QEP_A_dut,
    QEP_B_dut,
    Theta_one_turn_k_dut,
    V_DC_link_sd_dut,
        clk,
        areset,
        h_areset
);

sim : motor_kit_sim_20MHz_MotorModel_stm port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_stm,
    busOut_readdata_stm,
    busOut_waitrequest_stm,
    u_h_stm,
    v_h_stm,
    w_h_stm,
    u_l_stm,
    v_l_stm,
    w_l_stm,
    powerdown_p_stm,
    powerdown_n_stm,
    ia_sd_stm,
    ib_sd_stm,
    ic_sd_stm,
    Va_sd_stm,
    Vb_sd_stm,
    Vc_sd_stm,
    QEP_A_stm,
    QEP_B_stm,
    Theta_one_turn_k_stm,
    V_DC_link_sd_stm,
        clk,
        areset,
        h_areset
);

end normal;
