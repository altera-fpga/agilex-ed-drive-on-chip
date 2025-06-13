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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3
-- VHDL created on Fri Jun  6 03:42:56 2025


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

USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;
entity motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3 is
    port (
        in_1_Fraction_ND_ufix16_En16_tpl : in std_logic_vector(15 downto 0);  -- ufix16_en16
        out_1_PulseDensity_Bool_x_tpl : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3;

architecture normal of motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Add_a : STD_LOGIC_VECTOR (18 downto 0);
    signal Add_b : STD_LOGIC_VECTOR (18 downto 0);
    signal Add_o : STD_LOGIC_VECTOR (18 downto 0);
    signal Add_q : STD_LOGIC_VECTOR (18 downto 0);
    signal CmpGE_a : STD_LOGIC_VECTOR (19 downto 0);
    signal CmpGE_b : STD_LOGIC_VECTOR (19 downto 0);
    signal CmpGE_o : STD_LOGIC_VECTOR (19 downto 0);
    signal CmpGE_n : STD_LOGIC_VECTOR (0 downto 0);
    signal Const1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Sub_a : STD_LOGIC_VECTOR (16 downto 0);
    signal Sub_b : STD_LOGIC_VECTOR (16 downto 0);
    signal Sub_i : STD_LOGIC_VECTOR (16 downto 0);
    signal Sub_a1 : STD_LOGIC_VECTOR (16 downto 0);
    signal Sub_b1 : STD_LOGIC_VECTOR (16 downto 0);
    signal Sub_o : STD_LOGIC_VECTOR (16 downto 0);
    signal Sub_q : STD_LOGIC_VECTOR (16 downto 0);
    signal Convert4_sel_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_Convert4_sel_x_b_1_q : STD_LOGIC_VECTOR (17 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- Const1(CONSTANT,5)
    Const1_q <= "1111111111111111";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- Sub(SUB,13)@0
    Sub_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & in_1_Fraction_ND_ufix16_En16_tpl));
    Sub_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & Const1_q));
    Sub_i <= Sub_a;
    Sub_a1 <= Sub_i;
    Sub_b1 <= (others => '0') WHEN CmpGE_n = "0" ELSE Sub_b;
    Sub_o <= STD_LOGIC_VECTOR(SIGNED(Sub_a1) - SIGNED(Sub_b1));
    Sub_q <= STD_LOGIC_VECTOR(Sub_o(16 downto 0));

    -- Add(ADD,2)@0
    Add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 17 => Sub_q(16)) & Sub_q));
    Add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((18 downto 18 => redist0_Convert4_sel_x_b_1_q(17)) & redist0_Convert4_sel_x_b_1_q));
    Add_o <= STD_LOGIC_VECTOR(SIGNED(Add_a) + SIGNED(Add_b));
    Add_q <= STD_LOGIC_VECTOR(Add_o(18 downto 0));

    -- Convert4_sel_x(BITSELECT,15)@0
    Convert4_sel_x_b <= Add_q(17 downto 0);

    -- redist0_Convert4_sel_x_b_1(DELAY,18)
    redist0_Convert4_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist0_Convert4_sel_x_b_1_q <= (others => '0');
            ELSE
                redist0_Convert4_sel_x_b_1_q <= Convert4_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- CmpGE(COMPARE,3)@0
    CmpGE_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((19 downto 18 => redist0_Convert4_sel_x_b_1_q(17)) & redist0_Convert4_sel_x_b_1_q));
    CmpGE_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000" & Const1_q));
    CmpGE_o <= STD_LOGIC_VECTOR(SIGNED(CmpGE_a) - SIGNED(CmpGE_b));
    CmpGE_n(0) <= not (CmpGE_o(19));

    -- GPOut(GPOUT,10)@0
    out_1_PulseDensity_Bool_x_tpl <= CmpGE_n;

END normal;
