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

-- VHDL created from DF_fixp16_alu_av_FOC
-- VHDL created on Mon Aug 11 01:51:50 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity DF_fixp16_alu_av_FOC_atb is
end;

architecture normal of DF_fixp16_alu_av_FOC_atb is

component DF_fixp16_alu_av_FOC is
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
end component;

component DF_fixp16_alu_av_FOC_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        busOut_waitrequest_stm : out std_logic_vector(0 downto 0);
        Iu_stm : out std_logic_vector(15 downto 0);
        Iw_stm : out std_logic_vector(15 downto 0);
        vu_pwm_stm : out std_logic_vector(15 downto 0);
        vv_pwm_stm : out std_logic_vector(15 downto 0);
        vw_pwm_stm : out std_logic_vector(15 downto 0);
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
signal Iu_stm : STD_LOGIC_VECTOR (15 downto 0);
signal Iw_stm : STD_LOGIC_VECTOR (15 downto 0);
signal vu_pwm_stm : STD_LOGIC_VECTOR (15 downto 0);
signal vv_pwm_stm : STD_LOGIC_VECTOR (15 downto 0);
signal vw_pwm_stm : STD_LOGIC_VECTOR (15 downto 0);
signal busIn_writedata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busIn_address_dut : STD_LOGIC_VECTOR (5 downto 0);
signal busIn_write_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busIn_read_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdatavalid_dut : STD_LOGIC_VECTOR (0 downto 0);
signal busOut_readdata_dut : STD_LOGIC_VECTOR (31 downto 0);
signal busOut_waitrequest_dut : STD_LOGIC_VECTOR (0 downto 0);
signal Iu_dut : STD_LOGIC_VECTOR (15 downto 0);
signal Iw_dut : STD_LOGIC_VECTOR (15 downto 0);
signal vu_pwm_dut : STD_LOGIC_VECTOR (15 downto 0);
signal vv_pwm_dut : STD_LOGIC_VECTOR (15 downto 0);
signal vw_pwm_dut : STD_LOGIC_VECTOR (15 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;
        signal h_areset : std_logic;

begin

-- Bus data out
-- General Purpose data in real output
checkIu : process (clk, areset, Iu_dut, Iu_stm)
begin
END PROCESS;


-- General Purpose data in real output
checkIw : process (clk, areset, Iw_dut, Iw_stm)
begin
END PROCESS;


-- General Purpose data out check
checkvu_pwm : process (clk, areset)
variable mismatch_vu_pwm : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_vu_pwm := FALSE;
        IF ( (vu_pwm_dut /= vu_pwm_stm)) THEN
            mismatch_vu_pwm := TRUE;
            report "Mismatch on device output pin vu_pwm" severity Warning;
        END IF;
        IF (mismatch_vu_pwm = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkvv_pwm : process (clk, areset)
variable mismatch_vv_pwm : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_vv_pwm := FALSE;
        IF ( (vv_pwm_dut /= vv_pwm_stm)) THEN
            mismatch_vv_pwm := TRUE;
            report "Mismatch on device output pin vv_pwm" severity Warning;
        END IF;
        IF (mismatch_vv_pwm = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


-- General Purpose data out check
checkvw_pwm : process (clk, areset)
variable mismatch_vw_pwm : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_vw_pwm := FALSE;
        IF ( (vw_pwm_dut /= vw_pwm_stm)) THEN
            mismatch_vw_pwm := TRUE;
            report "Mismatch on device output pin vw_pwm" severity Warning;
        END IF;
        IF (mismatch_vw_pwm = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


dut : DF_fixp16_alu_av_FOC port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_dut,
    busOut_readdata_dut,
    busOut_waitrequest_dut,
    Iu_stm,
    Iw_stm,
    vu_pwm_dut,
    vv_pwm_dut,
    vw_pwm_dut,
        clk,
        areset,
        h_areset
);

sim : DF_fixp16_alu_av_FOC_stm port map (
    busIn_writedata_stm,
    busIn_address_stm,
    busIn_write_stm,
    busIn_read_stm,
    busOut_readdatavalid_stm,
    busOut_readdata_stm,
    busOut_waitrequest_stm,
    Iu_stm,
    Iw_stm,
    vu_pwm_stm,
    vv_pwm_stm,
    vw_pwm_stm,
        clk,
        areset,
        h_areset
);

end normal;
