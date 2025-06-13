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

-- VHDL created from standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x
-- VHDL created on Fri Jun  6 03:50:15 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb is
end;

architecture normal of standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_atb is

component standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x is
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
end component;

component standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        busOut_waitrequest_stm : out std_logic_vector(0 downto 0);
        qv_s_stm : out std_logic_vector(0 downto 0);
        Valpha_s_stm : out std_logic_vector(31 downto 0);
        Vbeta_s_stm : out std_logic_vector(31 downto 0);
        Iq_s_stm : out std_logic_vector(15 downto 0);
        Id_s_stm : out std_logic_vector(15 downto 0);
        Ready_s_stm : out std_logic_vector(0 downto 0);
        Vuvwin_0_stm : out std_logic_vector(15 downto 0);
        Vuvwin_1_stm : out std_logic_vector(15 downto 0);
        Vuvwin_2_stm : out std_logic_vector(15 downto 0);
        AxisOut_s_stm : out std_logic_vector(7 downto 0);
        dv_stm : out std_logic_vector(0 downto 0);
        axisin_stm : out std_logic_vector(7 downto 0);
        Iu_stm : out std_logic_vector(15 downto 0);
        Iw_stm : out std_logic_vector(15 downto 0);
        Torque_stm : out std_logic_vector(15 downto 0);
        phi_el_stm : out std_logic_vector(15 downto 0);
        Kp_cfg_stm : out std_logic_vector(15 downto 0);
        Ki_cfg_stm : out std_logic_vector(15 downto 0);
        I_Sat_Limit_cfg_stm : out std_logic_vector(15 downto 0);
        MaxV_stm : out std_logic_vector(15 downto 0);
        reset_stm : out std_logic_vector(0 downto 0);
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
signal qv_s_stm : STD_LOGIC_VECTOR (0 downto 0);
signal Valpha_s_stm : STD_LOGIC_VECTOR (31 downto 0);
signal Vbeta_s_stm : STD_LOGIC_VECTOR (31 downto 0);
signal Iq_s_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Id_s_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Ready_s_stm : STD_LOGIC_VECTOR (0 downto 0);
signal Vuvwin_0_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Vuvwin_1_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Vuvwin_2_stm : STD_LOGIC_VECTOR (15 downto 0);
signal AxisOut_s_stm : STD_LOGIC_VECTOR (7 downto 0);
signal dv_stm : STD_LOGIC_VECTOR (0 downto 0);
signal axisin_stm : STD_LOGIC_VECTOR (7 downto 0);
signal Iu_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Iw_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Torque_stm : STD_LOGIC_VECTOR (15 downto 0);
signal phi_el_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Kp_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Ki_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal I_Sat_Limit_cfg_stm : STD_LOGIC_VECTOR (15 downto 0);
signal MaxV_stm : STD_LOGIC_VECTOR (15 downto 0);
signal reset_stm : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_writedata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busIn_address_dut : STD_LOGIC_VECTOR (5 downto 0);
signal busIn_write_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_read_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdatavalid_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busOut_waitrequest_dut : STD_LOGIC_VECTOR (0 downto 0);
signal qv_s_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Valpha_s_dut : STD_LOGIC_VECTOR (31 downto 0);
signal Vbeta_s_dut : STD_LOGIC_VECTOR (31 downto 0);
signal Iq_s_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Id_s_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Ready_s_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Vuvwin_0_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Vuvwin_1_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Vuvwin_2_dut : STD_LOGIC_VECTOR (15 downto 0);
signal AxisOut_s_dut : STD_LOGIC_VECTOR (7 downto 0);
signal dv_dut : STD_LOGIC_VECTOR (0 downto 0);
signal axisin_dut : STD_LOGIC_VECTOR (7 downto 0);
signal Iu_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Iw_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Torque_dut : STD_LOGIC_VECTOR (15 downto 0);
signal phi_el_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Kp_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Ki_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal I_Sat_Limit_cfg_dut : STD_LOGIC_VECTOR (15 downto 0);
signal MaxV_dut : STD_LOGIC_VECTOR (15 downto 0);
signal reset_dut : STD_LOGIC_VECTOR (0 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;
        signal h_areset : std_logic;

begin

-- Bus data out
-- General Purpose data in real output
checkqv_s : process (clk, areset, qv_s_dut, qv_s_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkValpha_s : process (clk, areset, Valpha_s_dut, Valpha_s_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkVbeta_s : process (clk, areset, Vbeta_s_dut, Vbeta_s_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkIq_s : process (clk, areset, Iq_s_dut, Iq_s_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkId_s : process (clk, areset, Id_s_dut, Id_s_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkReady_s : process (clk, areset, Ready_s_dut, Ready_s_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkVuvwin_0 : process (clk, areset, Vuvwin_0_dut, Vuvwin_0_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkVuvwin_1 : process (clk, areset, Vuvwin_1_dut, Vuvwin_1_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkVuvwin_2 : process (clk, areset, Vuvwin_2_dut, Vuvwin_2_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkAxisOut_s : process (clk, areset, AxisOut_s_dut, AxisOut_s_stm)
begin
END PROCESS;


-- General Purpose data out check
checkdv : process (clk, areset)
variable mismatch_dv : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_dv := FALSE;
        IF ( (dv_dut /= dv_stm)) THEN
            mismatch_dv := TRUE;
            report "Mismatch on device output pin dv" severity Warning;
        END IF;
        IF (mismatch_dv = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkaxisin : process (clk, areset)
variable mismatch_axisin : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_axisin := FALSE;
        IF ( (axisin_dut /= axisin_stm)) THEN
            mismatch_axisin := TRUE;
            report "Mismatch on device output pin axisin" severity Warning;
        END IF;
        IF (mismatch_axisin = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkIu : process (clk, areset)
variable mismatch_Iu : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Iu := FALSE;
        IF ( (Iu_dut /= Iu_stm)) THEN
            mismatch_Iu := TRUE;
            report "Mismatch on device output pin Iu" severity Warning;
        END IF;
        IF (mismatch_Iu = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkIw : process (clk, areset)
variable mismatch_Iw : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Iw := FALSE;
        IF ( (Iw_dut /= Iw_stm)) THEN
            mismatch_Iw := TRUE;
            report "Mismatch on device output pin Iw" severity Warning;
        END IF;
        IF (mismatch_Iw = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkTorque : process (clk, areset)
variable mismatch_Torque : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Torque := FALSE;
        IF ( (Torque_dut /= Torque_stm)) THEN
            mismatch_Torque := TRUE;
            report "Mismatch on device output pin Torque" severity Warning;
        END IF;
        IF (mismatch_Torque = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkphi_el : process (clk, areset)
variable mismatch_phi_el : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_phi_el := FALSE;
        IF ( (phi_el_dut /= phi_el_stm)) THEN
            mismatch_phi_el := TRUE;
            report "Mismatch on device output pin phi_el" severity Warning;
        END IF;
        IF (mismatch_phi_el = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkKp_cfg : process (clk, areset)
variable mismatch_Kp_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Kp_cfg := FALSE;
        IF ( (Kp_cfg_dut /= Kp_cfg_stm)) THEN
            mismatch_Kp_cfg := TRUE;
            report "Mismatch on device output pin Kp_cfg" severity Warning;
        END IF;
        IF (mismatch_Kp_cfg = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkKi_cfg : process (clk, areset)
variable mismatch_Ki_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_Ki_cfg := FALSE;
        IF ( (Ki_cfg_dut /= Ki_cfg_stm)) THEN
            mismatch_Ki_cfg := TRUE;
            report "Mismatch on device output pin Ki_cfg" severity Warning;
        END IF;
        IF (mismatch_Ki_cfg = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkI_Sat_Limit_cfg : process (clk, areset)
variable mismatch_I_Sat_Limit_cfg : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_I_Sat_Limit_cfg := FALSE;
        IF ( (I_Sat_Limit_cfg_dut /= I_Sat_Limit_cfg_stm)) THEN
            mismatch_I_Sat_Limit_cfg := TRUE;
            report "Mismatch on device output pin I_Sat_Limit_cfg" severity Warning;
        END IF;
        IF (mismatch_I_Sat_Limit_cfg = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkMaxV : process (clk, areset)
variable mismatch_MaxV : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_MaxV := FALSE;
        IF ( (MaxV_dut /= MaxV_stm)) THEN
            mismatch_MaxV := TRUE;
            report "Mismatch on device output pin MaxV" severity Warning;
        END IF;
        IF (mismatch_MaxV = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkreset : process (clk, areset)
variable mismatch_reset : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_reset := FALSE;
        IF ( (reset_dut /= reset_stm)) THEN
            mismatch_reset := TRUE;
            report "Mismatch on device output pin reset" severity Warning;
        END IF;
        IF (mismatch_reset = TRUE) THEN
            ok := FALSE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


dut : standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_dut,
    busOut_readdata_dut,
    busOut_waitrequest_dut,
    qv_s_stm,
    Valpha_s_stm,
    Vbeta_s_stm,
    Iq_s_stm,
    Id_s_stm,
    Ready_s_stm,
    Vuvwin_0_stm,
    Vuvwin_1_stm,
    Vuvwin_2_stm,
    AxisOut_s_stm,
    dv_dut,
    axisin_dut,
    Iu_dut,
    Iw_dut,
    Torque_dut,
    phi_el_dut,
    Kp_cfg_dut,
    Ki_cfg_dut,
    I_Sat_Limit_cfg_dut,
    MaxV_dut,
    reset_dut,
        clk,
        areset,
        h_areset
);

sim : standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_stm port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_stm,
    busOut_readdata_stm,
    busOut_waitrequest_stm,
    qv_s_stm,
    Valpha_s_stm,
    Vbeta_s_stm,
    Iq_s_stm,
    Id_s_stm,
    Ready_s_stm,
    Vuvwin_0_stm,
    Vuvwin_1_stm,
    Vuvwin_2_stm,
    AxisOut_s_stm,
    dv_stm,
    axisin_stm,
    Iu_stm,
    Iw_stm,
    Torque_stm,
    phi_el_stm,
    Kp_cfg_stm,
    Ki_cfg_stm,
    I_Sat_Limit_cfg_stm,
    MaxV_stm,
    reset_stm,
        clk,
        areset,
        h_areset
);

end normal;
