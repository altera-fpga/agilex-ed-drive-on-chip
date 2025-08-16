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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6
-- VHDL created on Mon Aug 11 01:49:11 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_sim_library_package.all;
entity motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6_atb is
end;

architecture normal of motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6_atb is

component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6 is
    port (
        in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end component;

component motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6_stm is
    port (
        in_1_Fraction_ND_ufix16_En16_tpl_stm : out std_logic_vector(15 downto 0);
        out_1_PulseDensity_Bool_x_tpl_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end component;

signal in_1_Fraction_ND_ufix16_En16_tpl_stm : STD_LOGIC_VECTOR (15 downto 0);
signal out_1_PulseDensity_Bool_x_tpl_stm : STD_LOGIC_VECTOR (0 downto 0);
signal in_1_Fraction_ND_ufix16_En16_tpl_dut : STD_LOGIC_VECTOR (15 downto 0);
signal out_1_PulseDensity_Bool_x_tpl_dut : STD_LOGIC_VECTOR (0 downto 0);
        signal clk : std_logic;
        signal areset : std_logic;

begin

-- General Purpose data in real output
checkGPIn : process (clk, areset, in_1_Fraction_ND_ufix16_En16_tpl_dut, in_1_Fraction_ND_ufix16_En16_tpl_stm)
begin
END PROCESS;


-- General Purpose data out check
checkGPOut : process (clk, areset)
variable mismatch_out_1_PulseDensity_Bool_x_tpl : BOOLEAN := FALSE;
variable ok : BOOLEAN := TRUE;
begin
    IF ((areset = '1')) THEN
        -- do nothing during reset
    ELSIF (clk'EVENT AND clk = '0') THEN -- falling clock edge to avoid transitions
        ok := TRUE;
        mismatch_out_1_PulseDensity_Bool_x_tpl := FALSE;
        IF ( (out_1_PulseDensity_Bool_x_tpl_dut /= out_1_PulseDensity_Bool_x_tpl_stm)) THEN
            mismatch_out_1_PulseDensity_Bool_x_tpl := TRUE;
            report "Mismatch on device output pin out_1_PulseDensity_Bool_x_tpl" severity Warning;
        END IF;
        IF (mismatch_out_1_PulseDensity_Bool_x_tpl = TRUE) THEN
            ok := FALSE;
            report_mismatch_warning_detected := TRUE;
        END IF;
        assert (ok)
        report "mismatch in general purpose signal. Check the status of any associated valid signals." severity Warning;
    END IF;
END PROCESS;


dut : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6 port map (
    in_1_Fraction_ND_ufix16_En16_tpl_stm,
    out_1_PulseDensity_Bool_x_tpl_dut,
        clk,
        areset
);

sim : motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6_stm port map (
    in_1_Fraction_ND_ufix16_En16_tpl_stm,
    out_1_PulseDensity_Bool_x_tpl_stm,
        clk,
        areset
);

end normal;
