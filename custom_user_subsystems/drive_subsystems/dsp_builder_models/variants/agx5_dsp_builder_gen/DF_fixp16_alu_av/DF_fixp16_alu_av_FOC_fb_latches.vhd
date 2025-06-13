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

-- VHDL created from DF_fixp16_alu_av_FOC_fb_latches
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
entity DF_fixp16_alu_av_FOC_fb_latches is
    port (
        in_6_axis_in_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_5_axis_out_tpl : in std_logic_vector(7 downto 0);  -- ufix8
        in_1_id_int_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_4_valid_out_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_3_qv_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        in_2_iq_int_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en10
        in_7_reset_tpl : in std_logic_vector(0 downto 0);  -- ufix1
        out_2_iq_int_latch_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        out_1_id_int_latch_tpl : out std_logic_vector(15 downto 0);  -- sfix16_en10
        clk : in std_logic;
        areset : in std_logic
    );
end DF_fixp16_alu_av_FOC_fb_latches;

architecture normal of DF_fixp16_alu_av_FOC_fb_latches is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal And_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal And1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal And2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal And3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal And4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal And5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpEQ_b : STD_LOGIC_VECTOR (7 downto 0);
    signal CmpEQ_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpEQ1_b : STD_LOGIC_VECTOR (7 downto 0);
    signal CmpEQ1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpEQ2_b : STD_LOGIC_VECTOR (7 downto 0);
    signal CmpEQ2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal CmpEQ3_b : STD_LOGIC_VECTOR (7 downto 0);
    signal CmpEQ3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal Const1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal Const2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal Const3_q : STD_LOGIC_VECTOR (1 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches_reset_integ2_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_s : STD_LOGIC_VECTOR (0 downto 0);
    signal DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Mux_0_x_s : STD_LOGIC_VECTOR (7 downto 0);
    signal Mux_0_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Mux_1_x_s : STD_LOGIC_VECTOR (7 downto 0);
    signal Mux_1_x_q : STD_LOGIC_VECTOR (15 downto 0);

begin


    -- DF_fixp16_alu_av_FOC_fb_latches_latches_reset_integ2_x(CONSTANT,25)
    DF_fixp16_alu_av_FOC_fb_latches_latches_reset_integ2_x_q <= "0000000000000000";

    -- And1(LOGICAL,3)@0
    And1_q <= in_3_qv_tpl and in_7_reset_tpl;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x(MUX,28)@0
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_s <= And1_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_s, in_2_iq_int_tpl, DF_fixp16_alu_av_FOC_fb_latches_latches_reset_integ2_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q <= in_2_iq_int_tpl;
            WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches_reset_integ2_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Const3(CONSTANT,15)
    Const3_q <= "11";

    -- CmpEQ3(LOGICAL,11)@0
    CmpEQ3_b <= STD_LOGIC_VECTOR("000000" & Const3_q);
    CmpEQ3_q <= "1" WHEN in_5_axis_out_tpl = CmpEQ3_b ELSE "0";

    -- And_rsrvd_fix(LOGICAL,2)@0
    And_rsrvd_fix_q <= in_3_qv_tpl and in_4_valid_out_tpl;

    -- And5(LOGICAL,7)@0
    And5_q <= And_rsrvd_fix_q and CmpEQ3_q;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x(MUX,43)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_s <= And5_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- Const2(CONSTANT,14)
    Const2_q <= "10";

    -- CmpEQ2(LOGICAL,10)@0
    CmpEQ2_b <= STD_LOGIC_VECTOR("000000" & Const2_q);
    CmpEQ2_q <= "1" WHEN in_5_axis_out_tpl = CmpEQ2_b ELSE "0";

    -- And4(LOGICAL,6)@0
    And4_q <= And_rsrvd_fix_q and CmpEQ2_q;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x(MUX,36)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_s <= And4_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- Const1(CONSTANT,13)
    Const1_q <= "01";

    -- CmpEQ1(LOGICAL,9)@0
    CmpEQ1_b <= STD_LOGIC_VECTOR("000000" & Const1_q);
    CmpEQ1_q <= "1" WHEN in_5_axis_out_tpl = CmpEQ1_b ELSE "0";

    -- And3(LOGICAL,5)@0
    And3_q <= And_rsrvd_fix_q and CmpEQ1_q;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x(MUX,29)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_s <= And3_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- Const_rsrvd_fix(CONSTANT,12)
    Const_rsrvd_fix_q <= "00";

    -- CmpEQ(LOGICAL,8)@0
    CmpEQ_b <= STD_LOGIC_VECTOR("000000" & Const_rsrvd_fix_q);
    CmpEQ_q <= "1" WHEN in_5_axis_out_tpl = CmpEQ_b ELSE "0";

    -- And2(LOGICAL,4)@0
    And2_q <= And_rsrvd_fix_q and CmpEQ_q;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x(MUX,49)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_s <= And2_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- Mux_1_x(MUX,54)@0 + 1
    Mux_1_x_s <= in_6_axis_in_tpl;
    Mux_1_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                Mux_1_x_q <= (others => '0');
            ELSE
                CASE (Mux_1_x_s) IS
                    WHEN "00000000" => Mux_1_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches_RL1_latch_1L1_Mux_x_q;
                    WHEN "00000001" => Mux_1_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL1_latch_1L1_Mux_x_q;
                    WHEN "00000010" => Mux_1_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches2_RL1_latch_1L1_Mux_x_q;
                    WHEN "00000011" => Mux_1_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches3_RL1_latch_1L1_Mux_x_q;
                    WHEN OTHERS => Mux_1_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- GPOut1(GPOUT,23)@1
    out_2_iq_int_latch_tpl <= Mux_1_x_q;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x(MUX,27)@0
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_s <= And1_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_combproc: PROCESS (DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_s, in_1_id_int_tpl, DF_fixp16_alu_av_FOC_fb_latches_latches_reset_integ2_x_q)
    BEGIN
        CASE (DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_s) IS
            WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q <= in_1_id_int_tpl;
            WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches_reset_integ2_x_q;
            WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x(MUX,45)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_s <= And5_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x(MUX,38)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_s <= And4_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x(MUX,31)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_s <= And3_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x(MUX,51)@0 + 1
    DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_s <= And2_q;
    DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_q <= (others => '0');
            ELSE
                CASE (DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_s) IS
                    WHEN "0" => DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_q;
                    WHEN "1" => DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_Mux4_x_q;
                    WHEN OTHERS => DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- Mux_0_x(MUX,53)@0 + 1
    Mux_0_x_s <= in_6_axis_in_tpl;
    Mux_0_x_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                Mux_0_x_q <= (others => '0');
            ELSE
                CASE (Mux_0_x_s) IS
                    WHEN "00000000" => Mux_0_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches_RL_latch_1L1_Mux_x_q;
                    WHEN "00000001" => Mux_0_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches1_RL_latch_1L1_Mux_x_q;
                    WHEN "00000010" => Mux_0_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches2_RL_latch_1L1_Mux_x_q;
                    WHEN "00000011" => Mux_0_x_q <= DF_fixp16_alu_av_FOC_fb_latches_latches3_RL_latch_1L1_Mux_x_q;
                    WHEN OTHERS => Mux_0_x_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- GPOut2(GPOUT,24)@1
    out_1_id_int_latch_tpl <= Mux_0_x_q;

END normal;
