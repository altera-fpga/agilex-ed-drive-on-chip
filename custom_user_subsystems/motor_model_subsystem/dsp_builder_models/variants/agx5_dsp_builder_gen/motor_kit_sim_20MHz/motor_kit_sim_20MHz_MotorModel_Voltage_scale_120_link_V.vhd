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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V
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
entity motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V is
    port (
        in_2_Voltage_sfix16_En9_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_1_Voltage_range_int16_tpl : in std_logic_vector(15 downto 0);  -- sfix16
        out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        clk : in std_logic;
        areset : in std_logic
    );
end motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V;

architecture normal of motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const2_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Convert4_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Add1_PreShift_0_q : STD_LOGIC_VECTOR (21 downto 0);
    signal Add1_PreShift_0_qint : STD_LOGIC_VECTOR (21 downto 0);
    signal xMSB_uid13_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal yPSE_uid15_Divide_b : STD_LOGIC_VECTOR (15 downto 0);
    signal yPSE_uid15_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal yPSEA_uid17_Divide_a : STD_LOGIC_VECTOR (16 downto 0);
    signal yPSEA_uid17_Divide_b : STD_LOGIC_VECTOR (16 downto 0);
    signal yPSEA_uid17_Divide_o : STD_LOGIC_VECTOR (16 downto 0);
    signal yPSEA_uid17_Divide_q : STD_LOGIC_VECTOR (16 downto 0);
    signal yPS_uid18_Divide_in : STD_LOGIC_VECTOR (15 downto 0);
    signal yPS_uid18_Divide_b : STD_LOGIC_VECTOR (15 downto 0);
    signal normYNoLeadOne_uid21_Divide_in : STD_LOGIC_VECTOR (14 downto 0);
    signal normYNoLeadOne_uid21_Divide_b : STD_LOGIC_VECTOR (14 downto 0);
    signal normYIsOneC2_uid22_Divide_a : STD_LOGIC_VECTOR (15 downto 0);
    signal normYIsOneC2_uid22_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOneC2_uid25_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOne_uid26_Divide_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOne_uid26_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsZero_uid27_Divide_b : STD_LOGIC_VECTOR (15 downto 0);
    signal yIsZero_uid27_Divide_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsZero_uid27_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fxpInverseRes_uid32_Divide_in : STD_LOGIC_VECTOR (39 downto 0);
    signal fxpInverseRes_uid32_Divide_b : STD_LOGIC_VECTOR (33 downto 0);
    signal oneInvRes_uid33_Divide_q : STD_LOGIC_VECTOR (33 downto 0);
    signal invResPostOneHandling2_uid34_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal invResPostOneHandling2_uid34_Divide_q : STD_LOGIC_VECTOR (33 downto 0);
    signal cWOut_uid35_Divide_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rShiftCount_uid36_Divide_a : STD_LOGIC_VECTOR (5 downto 0);
    signal rShiftCount_uid36_Divide_b : STD_LOGIC_VECTOR (5 downto 0);
    signal rShiftCount_uid36_Divide_o : STD_LOGIC_VECTOR (5 downto 0);
    signal rShiftCount_uid36_Divide_q : STD_LOGIC_VECTOR (5 downto 0);
    signal xPSX_uid37_Divide_b : STD_LOGIC_VECTOR (15 downto 0);
    signal xPSX_uid37_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zMsbY0_uid39_Divide_q : STD_LOGIC_VECTOR (1 downto 0);
    signal xPSXE_uid40_Divide_a : STD_LOGIC_VECTOR (16 downto 0);
    signal xPSXE_uid40_Divide_b : STD_LOGIC_VECTOR (16 downto 0);
    signal xPSXE_uid40_Divide_o : STD_LOGIC_VECTOR (16 downto 0);
    signal xPSXE_uid40_Divide_q : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftInput_uid42_Divide_in : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftInput_uid42_Divide_b : STD_LOGIC_VECTOR (49 downto 0);
    signal prodPostRightShiftPost_uid44_Divide_in : STD_LOGIC_VECTOR (48 downto 0);
    signal prodPostRightShiftPost_uid44_Divide_b : STD_LOGIC_VECTOR (33 downto 0);
    signal prodPostRightShiftPostRnd_uid46_Divide_a : STD_LOGIC_VECTOR (34 downto 0);
    signal prodPostRightShiftPostRnd_uid46_Divide_b : STD_LOGIC_VECTOR (34 downto 0);
    signal prodPostRightShiftPostRnd_uid46_Divide_o : STD_LOGIC_VECTOR (34 downto 0);
    signal prodPostRightShiftPostRnd_uid46_Divide_q : STD_LOGIC_VECTOR (34 downto 0);
    signal prodPostRightShiftPostRndRange_uid47_Divide_in : STD_LOGIC_VECTOR (33 downto 0);
    signal prodPostRightShiftPostRndRange_uid47_Divide_b : STD_LOGIC_VECTOR (32 downto 0);
    signal resFinal_uid52_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal resFinal_uid52_Divide_q : STD_LOGIC_VECTOR (32 downto 0);
    signal zs_uid54_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid56_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid57_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid59_zCount_uid19_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid59_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid60_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid62_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid65_zCount_uid19_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid65_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid66_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid68_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid71_zCount_uid19_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid71_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid72_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid74_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid77_zCount_uid19_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid77_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid79_zCount_uid19_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid80_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid81_zCount_uid19_Divide_q : STD_LOGIC_VECTOR (4 downto 0);
    signal lowRangeB_uid101_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid101_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid102_invPolyEval_b : STD_LOGIC_VECTOR (13 downto 0);
    signal s1sumAHighB_uid103_invPolyEval_a : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid103_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid103_invPolyEval_o : STD_LOGIC_VECTOR (22 downto 0);
    signal s1sumAHighB_uid103_invPolyEval_q : STD_LOGIC_VECTOR (22 downto 0);
    signal s1_uid104_invPolyEval_q : STD_LOGIC_VECTOR (23 downto 0);
    signal lowRangeB_uid107_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid107_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid108_invPolyEval_b : STD_LOGIC_VECTOR (22 downto 0);
    signal s2sumAHighB_uid109_invPolyEval_a : STD_LOGIC_VECTOR (30 downto 0);
    signal s2sumAHighB_uid109_invPolyEval_b : STD_LOGIC_VECTOR (30 downto 0);
    signal s2sumAHighB_uid109_invPolyEval_o : STD_LOGIC_VECTOR (30 downto 0);
    signal s2sumAHighB_uid109_invPolyEval_q : STD_LOGIC_VECTOR (30 downto 0);
    signal s2_uid110_invPolyEval_q : STD_LOGIC_VECTOR (31 downto 0);
    signal lowRangeB_uid113_invPolyEval_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid113_invPolyEval_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid114_invPolyEval_b : STD_LOGIC_VECTOR (30 downto 0);
    signal s3sumAHighB_uid115_invPolyEval_a : STD_LOGIC_VECTOR (39 downto 0);
    signal s3sumAHighB_uid115_invPolyEval_b : STD_LOGIC_VECTOR (39 downto 0);
    signal s3sumAHighB_uid115_invPolyEval_o : STD_LOGIC_VECTOR (39 downto 0);
    signal s3sumAHighB_uid115_invPolyEval_q : STD_LOGIC_VECTOR (39 downto 0);
    signal s3_uid116_invPolyEval_q : STD_LOGIC_VECTOR (41 downto 0);
    signal osig_uid119_pT1_uid100_invPolyEval_b : STD_LOGIC_VECTOR (14 downto 0);
    signal osig_uid122_pT2_uid106_invPolyEval_b : STD_LOGIC_VECTOR (23 downto 0);
    signal nx_mergedSignalTM_uid141_pT3_uid112_invPolyEval_q : STD_LOGIC_VECTOR (7 downto 0);
    signal topRangeX_bottomExtension_uid143_pT3_uid112_invPolyEval_q : STD_LOGIC_VECTOR (9 downto 0);
    signal topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval_q : STD_LOGIC_VECTOR (17 downto 0);
    signal aboveLeftY_mergedSignalTM_uid154_pT3_uid112_invPolyEval_q : STD_LOGIC_VECTOR (17 downto 0);
    signal lowRangeB_uid161_pT3_uid112_invPolyEval_in : STD_LOGIC_VECTOR (17 downto 0);
    signal lowRangeB_uid161_pT3_uid112_invPolyEval_b : STD_LOGIC_VECTOR (17 downto 0);
    signal highBBits_uid162_pT3_uid112_invPolyEval_b : STD_LOGIC_VECTOR (17 downto 0);
    signal lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_a : STD_LOGIC_VECTOR (36 downto 0);
    signal lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_b : STD_LOGIC_VECTOR (36 downto 0);
    signal lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_o : STD_LOGIC_VECTOR (36 downto 0);
    signal lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_q : STD_LOGIC_VECTOR (36 downto 0);
    signal lev1_a0_uid164_pT3_uid112_invPolyEval_q : STD_LOGIC_VECTOR (54 downto 0);
    signal os_uid165_pT3_uid112_invPolyEval_in : STD_LOGIC_VECTOR (52 downto 0);
    signal os_uid165_pT3_uid112_invPolyEval_b : STD_LOGIC_VECTOR (32 downto 0);
    signal cstOvf_uid51_Divide_q_const_q : STD_LOGIC_VECTOR (32 downto 0);
    signal Add1_lhsMSBs_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Add1_MSBs_sums_a : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_MSBs_sums_b : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_MSBs_sums_o : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_MSBs_sums_q : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_split_join_q : STD_LOGIC_VECTOR (22 downto 0);
    signal Mult_bjB6_q : STD_LOGIC_VECTOR (18 downto 0);
    signal Mult_bjA8_q : STD_LOGIC_VECTOR (18 downto 0);
    signal Mult_sums_join_0_q : STD_LOGIC_VECTOR (55 downto 0);
    signal Mult_sums_align_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal Mult_sums_align_1_qint : STD_LOGIC_VECTOR (52 downto 0);
    signal leftShiftStage0Idx1Rng8_uid195_normY_uid20_Divide_in : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx1Rng8_uid195_normY_uid20_Divide_b : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx1_uid196_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0_uid200_normY_uid20_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid200_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx1Rng2_uid202_normY_uid20_Divide_in : STD_LOGIC_VECTOR (13 downto 0);
    signal leftShiftStage1Idx1Rng2_uid202_normY_uid20_Divide_b : STD_LOGIC_VECTOR (13 downto 0);
    signal leftShiftStage1Idx1_uid203_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx2Rng4_uid205_normY_uid20_Divide_in : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx2Rng4_uid205_normY_uid20_Divide_b : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx2_uid206_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx3Pad6_uid207_normY_uid20_Divide_q : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStage1Idx3Rng6_uid208_normY_uid20_Divide_in : STD_LOGIC_VECTOR (9 downto 0);
    signal leftShiftStage1Idx3Rng6_uid208_normY_uid20_Divide_b : STD_LOGIC_VECTOR (9 downto 0);
    signal leftShiftStage1Idx3_uid209_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1_uid211_normY_uid20_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid211_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage2Idx1Rng1_uid213_normY_uid20_Divide_in : STD_LOGIC_VECTOR (14 downto 0);
    signal leftShiftStage2Idx1Rng1_uid213_normY_uid20_Divide_b : STD_LOGIC_VECTOR (14 downto 0);
    signal leftShiftStage2Idx1_uid214_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage2_uid216_normY_uid20_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid216_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXInvY_uid41_Divide_bjB3_q : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid41_Divide_bjB7_q : STD_LOGIC_VECTOR (16 downto 0);
    signal prodXInvY_uid41_Divide_sums_align_1_q : STD_LOGIC_VECTOR (51 downto 0);
    signal prodXInvY_uid41_Divide_sums_align_1_qint : STD_LOGIC_VECTOR (51 downto 0);
    signal xMSB_uid230_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng1_uid232_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx1_uid233_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to2_uid234_in : STD_LOGIC_VECTOR (1 downto 0);
    signal seMsb_to2_uid234_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0Idx2Rng2_uid235_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx2_uid236_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to3_uid237_in : STD_LOGIC_VECTOR (2 downto 0);
    signal seMsb_to3_uid237_b : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage0Idx3Rng3_uid238_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (46 downto 0);
    signal rightShiftStage0Idx3_uid239_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to4_uid242_in : STD_LOGIC_VECTOR (3 downto 0);
    signal seMsb_to4_uid242_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStage1Idx1Rng4_uid243_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage1Idx1_uid244_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to8_uid245_in : STD_LOGIC_VECTOR (7 downto 0);
    signal seMsb_to8_uid245_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage1Idx2Rng8_uid246_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (41 downto 0);
    signal rightShiftStage1Idx2_uid247_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to12_uid248_in : STD_LOGIC_VECTOR (11 downto 0);
    signal seMsb_to12_uid248_b : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage1Idx3Rng12_uid249_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (37 downto 0);
    signal rightShiftStage1Idx3_uid250_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to16_uid253_in : STD_LOGIC_VECTOR (15 downto 0);
    signal seMsb_to16_uid253_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStage2Idx1Rng16_uid254_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (33 downto 0);
    signal rightShiftStage2Idx1_uid255_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to32_uid256_in : STD_LOGIC_VECTOR (31 downto 0);
    signal seMsb_to32_uid256_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage2Idx2Rng32_uid257_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (17 downto 0);
    signal rightShiftStage2Idx2_uid258_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to48_uid259_in : STD_LOGIC_VECTOR (47 downto 0);
    signal seMsb_to48_uid259_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage2Idx3Rng48_uid260_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2Idx3_uid261_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal memoryC0_uid83_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC0_uid83_invTabGen_lutmem_ena_NotRstA : std_logic;
    signal memoryC0_uid83_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (38 downto 0);
    signal memoryC0_uid83_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC0_uid83_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC0_uid83_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (38 downto 0);
    signal memoryC0_uid83_invTabGen_lutmem_r : STD_LOGIC_VECTOR (38 downto 0);
    signal memoryC1_uid86_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC1_uid86_invTabGen_lutmem_ena_NotRstA : std_logic;
    signal memoryC1_uid86_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (29 downto 0);
    signal memoryC1_uid86_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC1_uid86_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC1_uid86_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (29 downto 0);
    signal memoryC1_uid86_invTabGen_lutmem_r : STD_LOGIC_VECTOR (29 downto 0);
    signal memoryC2_uid89_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC2_uid89_invTabGen_lutmem_ena_NotRstA : std_logic;
    signal memoryC2_uid89_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC2_uid89_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC2_uid89_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC2_uid89_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC2_uid89_invTabGen_lutmem_r : STD_LOGIC_VECTOR (21 downto 0);
    signal memoryC3_uid92_invTabGen_lutmem_reset0 : std_logic;
    signal memoryC3_uid92_invTabGen_lutmem_ena_NotRstA : std_logic;
    signal memoryC3_uid92_invTabGen_lutmem_ia : STD_LOGIC_VECTOR (14 downto 0);
    signal memoryC3_uid92_invTabGen_lutmem_aa : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC3_uid92_invTabGen_lutmem_ab : STD_LOGIC_VECTOR (7 downto 0);
    signal memoryC3_uid92_invTabGen_lutmem_ir : STD_LOGIC_VECTOR (14 downto 0);
    signal memoryC3_uid92_invTabGen_lutmem_r : STD_LOGIC_VECTOR (14 downto 0);
    signal Mult_sums_result_add_0_0_lhsMSBs_select_b : STD_LOGIC_VECTOR (34 downto 0);
    signal Mult_sums_result_add_0_0_MSBs_sums_a : STD_LOGIC_VECTOR (38 downto 0);
    signal Mult_sums_result_add_0_0_MSBs_sums_b : STD_LOGIC_VECTOR (38 downto 0);
    signal Mult_sums_result_add_0_0_MSBs_sums_o : STD_LOGIC_VECTOR (38 downto 0);
    signal Mult_sums_result_add_0_0_MSBs_sums_q : STD_LOGIC_VECTOR (38 downto 0);
    signal Mult_sums_result_add_0_0_split_join_q : STD_LOGIC_VECTOR (56 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_lhsMSBs_select_b : STD_LOGIC_VECTOR (33 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_a : STD_LOGIC_VECTOR (34 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_b : STD_LOGIC_VECTOR (34 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_o : STD_LOGIC_VECTOR (34 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_q : STD_LOGIC_VECTOR (34 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_split_join_q : STD_LOGIC_VECTOR (52 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (6 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (14 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (21 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (21 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_q : STD_LOGIC_VECTOR (21 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ena2 : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (6 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (30 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (30 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_q : STD_LOGIC_VECTOR (30 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ena2 : std_logic;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_reset : std_logic;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ena0 : std_logic;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ena1 : std_logic;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ena2 : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_reset : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ena0 : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ena1 : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ena2 : std_logic;
    signal Mult_im0_cma_reset : std_logic;
    signal Mult_im0_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_im0_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal Mult_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal Mult_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal Mult_im0_cma_ena0 : std_logic;
    signal Mult_im0_cma_ena1 : std_logic;
    signal Mult_im0_cma_ena2 : std_logic;
    signal Mult_im10_cma_reset : std_logic;
    signal Mult_im10_cma_a0 : STD_LOGIC_VECTOR (14 downto 0);
    signal Mult_im10_cma_c0 : STD_LOGIC_VECTOR (10 downto 0);
    signal Mult_im10_cma_s0 : STD_LOGIC_VECTOR (25 downto 0);
    signal Mult_im10_cma_qq0 : STD_LOGIC_VECTOR (25 downto 0);
    signal Mult_im10_cma_q : STD_LOGIC_VECTOR (19 downto 0);
    signal Mult_im10_cma_ena0 : std_logic;
    signal Mult_im10_cma_ena1 : std_logic;
    signal Mult_im10_cma_ena2 : std_logic;
    signal prodXInvY_uid41_Divide_im0_cma_reset : std_logic;
    signal prodXInvY_uid41_Divide_im0_cma_a0 : STD_LOGIC_VECTOR (16 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_ena0 : std_logic;
    signal prodXInvY_uid41_Divide_im0_cma_ena1 : std_logic;
    signal prodXInvY_uid41_Divide_im0_cma_ena2 : std_logic;
    signal prodXInvY_uid41_Divide_im4_cma_reset : std_logic;
    signal prodXInvY_uid41_Divide_im4_cma_a0 : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXInvY_uid41_Divide_im4_cma_b0 : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXInvY_uid41_Divide_im4_cma_c0 : STD_LOGIC_VECTOR (16 downto 0);
    signal prodXInvY_uid41_Divide_im4_cma_s0 : STD_LOGIC_VECTOR (33 downto 0);
    signal prodXInvY_uid41_Divide_im4_cma_qq0 : STD_LOGIC_VECTOR (33 downto 0);
    signal prodXInvY_uid41_Divide_im4_cma_q : STD_LOGIC_VECTOR (33 downto 0);
    signal prodXInvY_uid41_Divide_im4_cma_ena0 : std_logic;
    signal prodXInvY_uid41_Divide_im4_cma_ena1 : std_logic;
    signal prodXInvY_uid41_Divide_im4_cma_ena2 : std_logic;
    signal Mult_ma3_cma_reset : std_logic;
    signal Mult_ma3_cma_a0 : STD_LOGIC_VECTOR (14 downto 0);
    signal Mult_ma3_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal Mult_ma3_cma_a1 : STD_LOGIC_VECTOR (14 downto 0);
    signal Mult_ma3_cma_c1 : STD_LOGIC_VECTOR (18 downto 0);
    signal Mult_ma3_cma_s0 : STD_LOGIC_VECTOR (34 downto 0);
    signal Mult_ma3_cma_qq0 : STD_LOGIC_VECTOR (34 downto 0);
    signal Mult_ma3_cma_q : STD_LOGIC_VECTOR (34 downto 0);
    signal Mult_ma3_cma_ena0 : std_logic;
    signal Mult_ma3_cma_ena1 : std_logic;
    signal Mult_ma3_cma_ena2 : std_logic;
    signal Convert4_rnd_bias_q : STD_LOGIC_VECTOR (1 downto 0);
    signal Convert4_rnd_trunc_q : STD_LOGIC_VECTOR (34 downto 0);
    signal Convert4_rnd_trunc_qint : STD_LOGIC_VECTOR (55 downto 0);
    signal Convert4_rnd_add_a : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_add_b : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_add_o : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_add_q : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_shift_q : STD_LOGIC_VECTOR (34 downto 0);
    signal Convert4_rnd_shift_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal Add1_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (9 downto 0);
    signal Add1_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (5 downto 0);
    signal yAddr_uid29_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (7 downto 0);
    signal yAddr_uid29_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (6 downto 0);
    signal prodXInvY_uid41_Divide_bs2_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid41_Divide_bs2_bit_select_merged_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_d : STD_LOGIC_VECTOR (1 downto 0);
    signal Mult_bs1_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_bs1_bit_select_merged_c : STD_LOGIC_VECTOR (14 downto 0);
    signal rVStage_uid61_zCount_uid19_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid61_zCount_uid19_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid67_zCount_uid19_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid67_zCount_uid19_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid73_zCount_uid19_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid73_zCount_uid19_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_d : STD_LOGIC_VECTOR (0 downto 0);
    signal topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_c : STD_LOGIC_VECTOR (13 downto 0);
    signal Mult_bs2_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_bs2_bit_select_merged_c : STD_LOGIC_VECTOR (4 downto 0);
    signal Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (37 downto 0);
    signal Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_4_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_8_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_12_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist3_yAddr_uid29_Divide_bit_select_merged_c_2_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_6_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_1 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_2 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_10_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_1 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_2 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist9_yIsZero_uid27_Divide_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_normYIsOne_uid26_Divide_q_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_xMSB_uid13_Divide_b_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_Convert4_sel_x_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_reset0 : std_logic;
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ena_OrRstB : std_logic;
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ia : STD_LOGIC_VECTOR (5 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_iq : STD_LOGIC_VECTOR (5 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i : signal is true;
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_eq : signal is true;
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmpReg_q : signal is true;
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena_q : signal is true;
    signal redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_mem_reset0 : std_logic;
    signal redist7_Add1_MSBs_sums_q_13_mem_ena_OrRstB : std_logic;
    signal redist7_Add1_MSBs_sums_q_13_mem_ia : STD_LOGIC_VECTOR (16 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_mem_iq : STD_LOGIC_VECTOR (16 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_mem_q : STD_LOGIC_VECTOR (16 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist7_Add1_MSBs_sums_q_13_rdcnt_i : signal is true;
    signal redist7_Add1_MSBs_sums_q_13_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist7_Add1_MSBs_sums_q_13_rdcnt_eq : signal is true;
    signal redist7_Add1_MSBs_sums_q_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist7_Add1_MSBs_sums_q_13_cmpReg_q : signal is true;
    signal redist7_Add1_MSBs_sums_q_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_Add1_MSBs_sums_q_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist7_Add1_MSBs_sums_q_13_sticky_ena_q : signal is true;
    signal redist7_Add1_MSBs_sums_q_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_reset0 : std_logic;
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ena_OrRstB : std_logic;
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_iq : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i : signal is true;
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_eq : signal is true;
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist8_r_uid81_zCount_uid19_Divide_q_18_cmpReg_q : signal is true;
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena_q : signal is true;
    signal redist8_r_uid81_zCount_uid19_Divide_q_18_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_reset0 : std_logic;
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ena_OrRstB : std_logic;
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve_syn_only of redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_i : signal is true;
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmpReg_q : signal is true;
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena_q : signal is true;
    signal redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- Convert4_rnd_bias(CONSTANT,287)
    Convert4_rnd_bias_q <= "01";

    -- Mult_bjB6(BITJOIN,180)@18
    Mult_bjB6_q <= GND_q & Mult_bs2_bit_select_merged_b;

    -- cstOvf_uid51_Divide_q_const(CONSTANT,168)
    cstOvf_uid51_Divide_q_const_q <= "011111111111111111111111111111111";

    -- oneInvRes_uid33_Divide(CONSTANT,32)
    oneInvRes_uid33_Divide_q <= "1000000000000000000000000000000000";

    -- leftShiftStage2Idx1Rng1_uid213_normY_uid20_Divide(BITSELECT,212)@0
    leftShiftStage2Idx1Rng1_uid213_normY_uid20_Divide_in <= leftShiftStage1_uid211_normY_uid20_Divide_q(14 downto 0);
    leftShiftStage2Idx1Rng1_uid213_normY_uid20_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage2Idx1Rng1_uid213_normY_uid20_Divide_in(14 downto 0));

    -- leftShiftStage2Idx1_uid214_normY_uid20_Divide(BITJOIN,213)@0
    leftShiftStage2Idx1_uid214_normY_uid20_Divide_q <= leftShiftStage2Idx1Rng1_uid213_normY_uid20_Divide_b & GND_q;

    -- leftShiftStage1Idx3Rng6_uid208_normY_uid20_Divide(BITSELECT,207)@0
    leftShiftStage1Idx3Rng6_uid208_normY_uid20_Divide_in <= leftShiftStage0_uid200_normY_uid20_Divide_q(9 downto 0);
    leftShiftStage1Idx3Rng6_uid208_normY_uid20_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage1Idx3Rng6_uid208_normY_uid20_Divide_in(9 downto 0));

    -- leftShiftStage1Idx3Pad6_uid207_normY_uid20_Divide(CONSTANT,206)
    leftShiftStage1Idx3Pad6_uid207_normY_uid20_Divide_q <= "000000";

    -- leftShiftStage1Idx3_uid209_normY_uid20_Divide(BITJOIN,208)@0
    leftShiftStage1Idx3_uid209_normY_uid20_Divide_q <= leftShiftStage1Idx3Rng6_uid208_normY_uid20_Divide_b & leftShiftStage1Idx3Pad6_uid207_normY_uid20_Divide_q;

    -- leftShiftStage1Idx2Rng4_uid205_normY_uid20_Divide(BITSELECT,204)@0
    leftShiftStage1Idx2Rng4_uid205_normY_uid20_Divide_in <= leftShiftStage0_uid200_normY_uid20_Divide_q(11 downto 0);
    leftShiftStage1Idx2Rng4_uid205_normY_uid20_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage1Idx2Rng4_uid205_normY_uid20_Divide_in(11 downto 0));

    -- leftShiftStage1Idx2_uid206_normY_uid20_Divide(BITJOIN,205)@0
    leftShiftStage1Idx2_uid206_normY_uid20_Divide_q <= leftShiftStage1Idx2Rng4_uid205_normY_uid20_Divide_b & zs_uid66_zCount_uid19_Divide_q;

    -- leftShiftStage1Idx1Rng2_uid202_normY_uid20_Divide(BITSELECT,201)@0
    leftShiftStage1Idx1Rng2_uid202_normY_uid20_Divide_in <= leftShiftStage0_uid200_normY_uid20_Divide_q(13 downto 0);
    leftShiftStage1Idx1Rng2_uid202_normY_uid20_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage1Idx1Rng2_uid202_normY_uid20_Divide_in(13 downto 0));

    -- zs_uid72_zCount_uid19_Divide(CONSTANT,71)
    zs_uid72_zCount_uid19_Divide_q <= "00";

    -- leftShiftStage1Idx1_uid203_normY_uid20_Divide(BITJOIN,202)@0
    leftShiftStage1Idx1_uid203_normY_uid20_Divide_q <= leftShiftStage1Idx1Rng2_uid202_normY_uid20_Divide_b & zs_uid72_zCount_uid19_Divide_q;

    -- zs_uid54_zCount_uid19_Divide(CONSTANT,53)
    zs_uid54_zCount_uid19_Divide_q <= "0000000000000000";

    -- leftShiftStage0Idx1Rng8_uid195_normY_uid20_Divide(BITSELECT,194)@0
    leftShiftStage0Idx1Rng8_uid195_normY_uid20_Divide_in <= yPS_uid18_Divide_b(7 downto 0);
    leftShiftStage0Idx1Rng8_uid195_normY_uid20_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage0Idx1Rng8_uid195_normY_uid20_Divide_in(7 downto 0));

    -- zs_uid60_zCount_uid19_Divide(CONSTANT,59)
    zs_uid60_zCount_uid19_Divide_q <= "00000000";

    -- leftShiftStage0Idx1_uid196_normY_uid20_Divide(BITJOIN,195)@0
    leftShiftStage0Idx1_uid196_normY_uid20_Divide_q <= leftShiftStage0Idx1Rng8_uid195_normY_uid20_Divide_b & zs_uid60_zCount_uid19_Divide_q;

    -- xMSB_uid13_Divide(BITSELECT,12)@0
    xMSB_uid13_Divide_b <= in_1_Voltage_range_int16_tpl(15 downto 15);

    -- yPSE_uid15_Divide(LOGICAL,14)@0
    yPSE_uid15_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => xMSB_uid13_Divide_b(0)) & xMSB_uid13_Divide_b));
    yPSE_uid15_Divide_q <= STD_LOGIC_VECTOR(in_1_Voltage_range_int16_tpl xor yPSE_uid15_Divide_b);

    -- yPSEA_uid17_Divide(ADD,16)@0
    yPSEA_uid17_Divide_a <= STD_LOGIC_VECTOR("0" & yPSE_uid15_Divide_q);
    yPSEA_uid17_Divide_b <= STD_LOGIC_VECTOR("0000000000000000" & xMSB_uid13_Divide_b);
    yPSEA_uid17_Divide_o <= STD_LOGIC_VECTOR(UNSIGNED(yPSEA_uid17_Divide_a) + UNSIGNED(yPSEA_uid17_Divide_b));
    yPSEA_uid17_Divide_q <= STD_LOGIC_VECTOR(yPSEA_uid17_Divide_o(16 downto 0));

    -- yPS_uid18_Divide(BITSELECT,17)@0
    yPS_uid18_Divide_in <= STD_LOGIC_VECTOR(yPSEA_uid17_Divide_q(15 downto 0));
    yPS_uid18_Divide_b <= yPS_uid18_Divide_in(15 downto 0);

    -- leftShiftStage0_uid200_normY_uid20_Divide(MUX,199)@0
    leftShiftStage0_uid200_normY_uid20_Divide_s <= leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_b;
    leftShiftStage0_uid200_normY_uid20_Divide_combproc: PROCESS (leftShiftStage0_uid200_normY_uid20_Divide_s, yPS_uid18_Divide_b, leftShiftStage0Idx1_uid196_normY_uid20_Divide_q, zs_uid54_zCount_uid19_Divide_q)
    BEGIN
        CASE (leftShiftStage0_uid200_normY_uid20_Divide_s) IS
            WHEN "00" => leftShiftStage0_uid200_normY_uid20_Divide_q <= yPS_uid18_Divide_b;
            WHEN "01" => leftShiftStage0_uid200_normY_uid20_Divide_q <= leftShiftStage0Idx1_uid196_normY_uid20_Divide_q;
            WHEN "10" => leftShiftStage0_uid200_normY_uid20_Divide_q <= zs_uid54_zCount_uid19_Divide_q;
            WHEN "11" => leftShiftStage0_uid200_normY_uid20_Divide_q <= zs_uid54_zCount_uid19_Divide_q;
            WHEN OTHERS => leftShiftStage0_uid200_normY_uid20_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid211_normY_uid20_Divide(MUX,210)@0
    leftShiftStage1_uid211_normY_uid20_Divide_s <= leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_c;
    leftShiftStage1_uid211_normY_uid20_Divide_combproc: PROCESS (leftShiftStage1_uid211_normY_uid20_Divide_s, leftShiftStage0_uid200_normY_uid20_Divide_q, leftShiftStage1Idx1_uid203_normY_uid20_Divide_q, leftShiftStage1Idx2_uid206_normY_uid20_Divide_q, leftShiftStage1Idx3_uid209_normY_uid20_Divide_q)
    BEGIN
        CASE (leftShiftStage1_uid211_normY_uid20_Divide_s) IS
            WHEN "00" => leftShiftStage1_uid211_normY_uid20_Divide_q <= leftShiftStage0_uid200_normY_uid20_Divide_q;
            WHEN "01" => leftShiftStage1_uid211_normY_uid20_Divide_q <= leftShiftStage1Idx1_uid203_normY_uid20_Divide_q;
            WHEN "10" => leftShiftStage1_uid211_normY_uid20_Divide_q <= leftShiftStage1Idx2_uid206_normY_uid20_Divide_q;
            WHEN "11" => leftShiftStage1_uid211_normY_uid20_Divide_q <= leftShiftStage1Idx3_uid209_normY_uid20_Divide_q;
            WHEN OTHERS => leftShiftStage1_uid211_normY_uid20_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- vCount_uid56_zCount_uid19_Divide(LOGICAL,55)@0
    vCount_uid56_zCount_uid19_Divide_q <= "1" WHEN yPS_uid18_Divide_b = zs_uid54_zCount_uid19_Divide_q ELSE "0";

    -- mO_uid57_zCount_uid19_Divide(CONSTANT,56)
    mO_uid57_zCount_uid19_Divide_q <= "1111111111111111";

    -- vStagei_uid59_zCount_uid19_Divide(MUX,58)@0
    vStagei_uid59_zCount_uid19_Divide_s <= vCount_uid56_zCount_uid19_Divide_q;
    vStagei_uid59_zCount_uid19_Divide_combproc: PROCESS (vStagei_uid59_zCount_uid19_Divide_s, yPS_uid18_Divide_b, mO_uid57_zCount_uid19_Divide_q)
    BEGIN
        CASE (vStagei_uid59_zCount_uid19_Divide_s) IS
            WHEN "0" => vStagei_uid59_zCount_uid19_Divide_q <= yPS_uid18_Divide_b;
            WHEN "1" => vStagei_uid59_zCount_uid19_Divide_q <= mO_uid57_zCount_uid19_Divide_q;
            WHEN OTHERS => vStagei_uid59_zCount_uid19_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid61_zCount_uid19_Divide_bit_select_merged(BITSELECT,297)@0
    rVStage_uid61_zCount_uid19_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(vStagei_uid59_zCount_uid19_Divide_q(15 downto 8));
    rVStage_uid61_zCount_uid19_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(vStagei_uid59_zCount_uid19_Divide_q(7 downto 0));

    -- vCount_uid62_zCount_uid19_Divide(LOGICAL,61)@0
    vCount_uid62_zCount_uid19_Divide_q <= "1" WHEN rVStage_uid61_zCount_uid19_Divide_bit_select_merged_b = zs_uid60_zCount_uid19_Divide_q ELSE "0";

    -- vStagei_uid65_zCount_uid19_Divide(MUX,64)@0
    vStagei_uid65_zCount_uid19_Divide_s <= vCount_uid62_zCount_uid19_Divide_q;
    vStagei_uid65_zCount_uid19_Divide_combproc: PROCESS (vStagei_uid65_zCount_uid19_Divide_s, rVStage_uid61_zCount_uid19_Divide_bit_select_merged_b, rVStage_uid61_zCount_uid19_Divide_bit_select_merged_c)
    BEGIN
        CASE (vStagei_uid65_zCount_uid19_Divide_s) IS
            WHEN "0" => vStagei_uid65_zCount_uid19_Divide_q <= rVStage_uid61_zCount_uid19_Divide_bit_select_merged_b;
            WHEN "1" => vStagei_uid65_zCount_uid19_Divide_q <= rVStage_uid61_zCount_uid19_Divide_bit_select_merged_c;
            WHEN OTHERS => vStagei_uid65_zCount_uid19_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid67_zCount_uid19_Divide_bit_select_merged(BITSELECT,298)@0
    rVStage_uid67_zCount_uid19_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(vStagei_uid65_zCount_uid19_Divide_q(7 downto 4));
    rVStage_uid67_zCount_uid19_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(vStagei_uid65_zCount_uid19_Divide_q(3 downto 0));

    -- vCount_uid68_zCount_uid19_Divide(LOGICAL,67)@0
    vCount_uid68_zCount_uid19_Divide_q <= "1" WHEN rVStage_uid67_zCount_uid19_Divide_bit_select_merged_b = zs_uid66_zCount_uid19_Divide_q ELSE "0";

    -- vStagei_uid71_zCount_uid19_Divide(MUX,70)@0
    vStagei_uid71_zCount_uid19_Divide_s <= vCount_uid68_zCount_uid19_Divide_q;
    vStagei_uid71_zCount_uid19_Divide_combproc: PROCESS (vStagei_uid71_zCount_uid19_Divide_s, rVStage_uid67_zCount_uid19_Divide_bit_select_merged_b, rVStage_uid67_zCount_uid19_Divide_bit_select_merged_c)
    BEGIN
        CASE (vStagei_uid71_zCount_uid19_Divide_s) IS
            WHEN "0" => vStagei_uid71_zCount_uid19_Divide_q <= rVStage_uid67_zCount_uid19_Divide_bit_select_merged_b;
            WHEN "1" => vStagei_uid71_zCount_uid19_Divide_q <= rVStage_uid67_zCount_uid19_Divide_bit_select_merged_c;
            WHEN OTHERS => vStagei_uid71_zCount_uid19_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid73_zCount_uid19_Divide_bit_select_merged(BITSELECT,299)@0
    rVStage_uid73_zCount_uid19_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(vStagei_uid71_zCount_uid19_Divide_q(3 downto 2));
    rVStage_uid73_zCount_uid19_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(vStagei_uid71_zCount_uid19_Divide_q(1 downto 0));

    -- vCount_uid74_zCount_uid19_Divide(LOGICAL,73)@0
    vCount_uid74_zCount_uid19_Divide_q <= "1" WHEN rVStage_uid73_zCount_uid19_Divide_bit_select_merged_b = zs_uid72_zCount_uid19_Divide_q ELSE "0";

    -- vStagei_uid77_zCount_uid19_Divide(MUX,76)@0
    vStagei_uid77_zCount_uid19_Divide_s <= vCount_uid74_zCount_uid19_Divide_q;
    vStagei_uid77_zCount_uid19_Divide_combproc: PROCESS (vStagei_uid77_zCount_uid19_Divide_s, rVStage_uid73_zCount_uid19_Divide_bit_select_merged_b, rVStage_uid73_zCount_uid19_Divide_bit_select_merged_c)
    BEGIN
        CASE (vStagei_uid77_zCount_uid19_Divide_s) IS
            WHEN "0" => vStagei_uid77_zCount_uid19_Divide_q <= rVStage_uid73_zCount_uid19_Divide_bit_select_merged_b;
            WHEN "1" => vStagei_uid77_zCount_uid19_Divide_q <= rVStage_uid73_zCount_uid19_Divide_bit_select_merged_c;
            WHEN OTHERS => vStagei_uid77_zCount_uid19_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid79_zCount_uid19_Divide(BITSELECT,78)@0
    rVStage_uid79_zCount_uid19_Divide_b <= STD_LOGIC_VECTOR(vStagei_uid77_zCount_uid19_Divide_q(1 downto 1));

    -- vCount_uid80_zCount_uid19_Divide(LOGICAL,79)@0
    vCount_uid80_zCount_uid19_Divide_q <= "1" WHEN rVStage_uid79_zCount_uid19_Divide_b = GND_q ELSE "0";

    -- r_uid81_zCount_uid19_Divide(BITJOIN,80)@0
    r_uid81_zCount_uid19_Divide_q <= vCount_uid56_zCount_uid19_Divide_q & vCount_uid62_zCount_uid19_Divide_q & vCount_uid68_zCount_uid19_Divide_q & vCount_uid74_zCount_uid19_Divide_q & vCount_uid80_zCount_uid19_Divide_q;

    -- leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged(BITSELECT,300)@0
    leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(r_uid81_zCount_uid19_Divide_q(4 downto 3));
    leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(r_uid81_zCount_uid19_Divide_q(2 downto 1));
    leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_d <= STD_LOGIC_VECTOR(r_uid81_zCount_uid19_Divide_q(0 downto 0));

    -- leftShiftStage2_uid216_normY_uid20_Divide(MUX,215)@0
    leftShiftStage2_uid216_normY_uid20_Divide_s <= leftShiftStageSel0Dto3_uid199_normY_uid20_Divide_bit_select_merged_d;
    leftShiftStage2_uid216_normY_uid20_Divide_combproc: PROCESS (leftShiftStage2_uid216_normY_uid20_Divide_s, leftShiftStage1_uid211_normY_uid20_Divide_q, leftShiftStage2Idx1_uid214_normY_uid20_Divide_q)
    BEGIN
        CASE (leftShiftStage2_uid216_normY_uid20_Divide_s) IS
            WHEN "0" => leftShiftStage2_uid216_normY_uid20_Divide_q <= leftShiftStage1_uid211_normY_uid20_Divide_q;
            WHEN "1" => leftShiftStage2_uid216_normY_uid20_Divide_q <= leftShiftStage2Idx1_uid214_normY_uid20_Divide_q;
            WHEN OTHERS => leftShiftStage2_uid216_normY_uid20_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- normYNoLeadOne_uid21_Divide(BITSELECT,20)@0
    normYNoLeadOne_uid21_Divide_in <= leftShiftStage2_uid216_normY_uid20_Divide_q(14 downto 0);
    normYNoLeadOne_uid21_Divide_b <= STD_LOGIC_VECTOR(normYNoLeadOne_uid21_Divide_in(14 downto 0));

    -- yAddr_uid29_Divide_bit_select_merged(BITSELECT,293)@0
    yAddr_uid29_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(normYNoLeadOne_uid21_Divide_b(14 downto 7));
    yAddr_uid29_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(normYNoLeadOne_uid21_Divide_b(6 downto 0));

    -- memoryC3_uid92_invTabGen_lutmem(DUALMEM,267)@0 + 2
    memoryC3_uid92_invTabGen_lutmem_aa <= yAddr_uid29_Divide_bit_select_merged_b;
    memoryC3_uid92_invTabGen_lutmem_ena_NotRstA <= not (areset);
    memoryC3_uid92_invTabGen_lutmem_reset0 <= areset;
    memoryC3_uid92_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 15,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V_memoryC3_uid92_invTabGen_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => memoryC3_uid92_invTabGen_lutmem_ena_NotRstA,
        sclr => memoryC3_uid92_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC3_uid92_invTabGen_lutmem_aa,
        q_a => memoryC3_uid92_invTabGen_lutmem_ir
    );
    memoryC3_uid92_invTabGen_lutmem_r <= STD_LOGIC_VECTOR(memoryC3_uid92_invTabGen_lutmem_ir(14 downto 0));

    -- redist3_yAddr_uid29_Divide_bit_select_merged_c_2(DELAY,308)
    redist3_yAddr_uid29_Divide_bit_select_merged_c_2_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist3_yAddr_uid29_Divide_bit_select_merged_c_2_delay_0 <= (others => '0');
            ELSE
                redist3_yAddr_uid29_Divide_bit_select_merged_c_2_delay_0 <= STD_LOGIC_VECTOR(yAddr_uid29_Divide_bit_select_merged_c);
            END IF;
        END IF;
    END PROCESS;
    redist3_yAddr_uid29_Divide_bit_select_merged_c_2_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q <= STD_LOGIC_VECTOR(redist3_yAddr_uid29_Divide_bit_select_merged_c_2_delay_0);
            END IF;
        END IF;
    END PROCESS;

    -- prodXY_uid118_pT1_uid100_invPolyEval_cma(CHAINMULTADD,278)@2 + 4
    -- in b@5
    prodXY_uid118_pT1_uid100_invPolyEval_cma_reset <= areset;
    prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0 <= '1';
    prodXY_uid118_pT1_uid100_invPolyEval_cma_ena1 <= prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0;
    prodXY_uid118_pT1_uid100_invPolyEval_cma_ena2 <= prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0;

    prodXY_uid118_pT1_uid100_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q),7));
    prodXY_uid118_pT1_uid100_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(memoryC3_uid92_invTabGen_lutmem_r),15));
    prodXY_uid118_pT1_uid100_invPolyEval_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 7,
        ax_clken => "0",
        ax_width => 15,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 22,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid118_pT1_uid100_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid118_pT1_uid100_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid118_pT1_uid100_invPolyEval_cma_reset,
        clr(1) => prodXY_uid118_pT1_uid100_invPolyEval_cma_reset,
        ay => prodXY_uid118_pT1_uid100_invPolyEval_cma_a0,
        ax => prodXY_uid118_pT1_uid100_invPolyEval_cma_c0,
        resulta => prodXY_uid118_pT1_uid100_invPolyEval_cma_s0
    );
    prodXY_uid118_pT1_uid100_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 22, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid118_pT1_uid100_invPolyEval_cma_s0, xout => prodXY_uid118_pT1_uid100_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid118_pT1_uid100_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid118_pT1_uid100_invPolyEval_cma_qq0(21 downto 0));

    -- osig_uid119_pT1_uid100_invPolyEval(BITSELECT,118)@6
    osig_uid119_pT1_uid100_invPolyEval_b <= prodXY_uid118_pT1_uid100_invPolyEval_cma_q(21 downto 7);

    -- highBBits_uid102_invPolyEval(BITSELECT,101)@6
    highBBits_uid102_invPolyEval_b <= osig_uid119_pT1_uid100_invPolyEval_b(14 downto 1);

    -- redist0_yAddr_uid29_Divide_bit_select_merged_b_4(DELAY,305)
    redist0_yAddr_uid29_Divide_bit_select_merged_b_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_0 <= (others => '0');
            ELSE
                redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_0 <= STD_LOGIC_VECTOR(yAddr_uid29_Divide_bit_select_merged_b);
            END IF;
        END IF;
    END PROCESS;
    redist0_yAddr_uid29_Divide_bit_select_merged_b_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_1 <= redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_0;
                redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_2 <= redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_1;
                redist0_yAddr_uid29_Divide_bit_select_merged_b_4_q <= STD_LOGIC_VECTOR(redist0_yAddr_uid29_Divide_bit_select_merged_b_4_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- memoryC2_uid89_invTabGen_lutmem(DUALMEM,266)@4 + 2
    memoryC2_uid89_invTabGen_lutmem_aa <= redist0_yAddr_uid29_Divide_bit_select_merged_b_4_q;
    memoryC2_uid89_invTabGen_lutmem_ena_NotRstA <= not (areset);
    memoryC2_uid89_invTabGen_lutmem_reset0 <= areset;
    memoryC2_uid89_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 22,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V_memoryC2_uid89_invTabGen_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => memoryC2_uid89_invTabGen_lutmem_ena_NotRstA,
        sclr => memoryC2_uid89_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC2_uid89_invTabGen_lutmem_aa,
        q_a => memoryC2_uid89_invTabGen_lutmem_ir
    );
    memoryC2_uid89_invTabGen_lutmem_r <= STD_LOGIC_VECTOR(memoryC2_uid89_invTabGen_lutmem_ir(21 downto 0));

    -- s1sumAHighB_uid103_invPolyEval(ADD,102)@6
    s1sumAHighB_uid103_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 22 => memoryC2_uid89_invTabGen_lutmem_r(21)) & memoryC2_uid89_invTabGen_lutmem_r));
    s1sumAHighB_uid103_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 14 => highBBits_uid102_invPolyEval_b(13)) & highBBits_uid102_invPolyEval_b));
    s1sumAHighB_uid103_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid103_invPolyEval_a) + SIGNED(s1sumAHighB_uid103_invPolyEval_b));
    s1sumAHighB_uid103_invPolyEval_q <= STD_LOGIC_VECTOR(s1sumAHighB_uid103_invPolyEval_o(22 downto 0));

    -- lowRangeB_uid101_invPolyEval(BITSELECT,100)@6
    lowRangeB_uid101_invPolyEval_in <= osig_uid119_pT1_uid100_invPolyEval_b(0 downto 0);
    lowRangeB_uid101_invPolyEval_b <= STD_LOGIC_VECTOR(lowRangeB_uid101_invPolyEval_in(0 downto 0));

    -- s1_uid104_invPolyEval(BITJOIN,103)@6
    s1_uid104_invPolyEval_q <= s1sumAHighB_uid103_invPolyEval_q & lowRangeB_uid101_invPolyEval_b;

    -- redist4_yAddr_uid29_Divide_bit_select_merged_c_6(DELAY,309)
    redist4_yAddr_uid29_Divide_bit_select_merged_c_6_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_0 <= (others => '0');
            ELSE
                redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_0 <= STD_LOGIC_VECTOR(redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q);
            END IF;
        END IF;
    END PROCESS;
    redist4_yAddr_uid29_Divide_bit_select_merged_c_6_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_1 <= redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_0;
                redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_2 <= redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_1;
                redist4_yAddr_uid29_Divide_bit_select_merged_c_6_q <= STD_LOGIC_VECTOR(redist4_yAddr_uid29_Divide_bit_select_merged_c_6_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- prodXY_uid121_pT2_uid106_invPolyEval_cma(CHAINMULTADD,279)@6 + 4
    -- in b@9
    prodXY_uid121_pT2_uid106_invPolyEval_cma_reset <= areset;
    prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0 <= '1';
    prodXY_uid121_pT2_uid106_invPolyEval_cma_ena1 <= prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0;
    prodXY_uid121_pT2_uid106_invPolyEval_cma_ena2 <= prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0;

    prodXY_uid121_pT2_uid106_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(redist4_yAddr_uid29_Divide_bit_select_merged_c_6_q),7));
    prodXY_uid121_pT2_uid106_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(s1_uid104_invPolyEval_q),24));
    prodXY_uid121_pT2_uid106_invPolyEval_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 7,
        ax_clken => "0",
        ax_width => 24,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 31
    )
    PORT MAP (
        clk => clk,
        ena(0) => prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid121_pT2_uid106_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid121_pT2_uid106_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid121_pT2_uid106_invPolyEval_cma_reset,
        clr(1) => prodXY_uid121_pT2_uid106_invPolyEval_cma_reset,
        ay => prodXY_uid121_pT2_uid106_invPolyEval_cma_a0,
        ax => prodXY_uid121_pT2_uid106_invPolyEval_cma_c0,
        resulta => prodXY_uid121_pT2_uid106_invPolyEval_cma_s0
    );
    prodXY_uid121_pT2_uid106_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 31, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid121_pT2_uid106_invPolyEval_cma_s0, xout => prodXY_uid121_pT2_uid106_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid121_pT2_uid106_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid121_pT2_uid106_invPolyEval_cma_qq0(30 downto 0));

    -- osig_uid122_pT2_uid106_invPolyEval(BITSELECT,121)@10
    osig_uid122_pT2_uid106_invPolyEval_b <= prodXY_uid121_pT2_uid106_invPolyEval_cma_q(30 downto 7);

    -- highBBits_uid108_invPolyEval(BITSELECT,107)@10
    highBBits_uid108_invPolyEval_b <= osig_uid122_pT2_uid106_invPolyEval_b(23 downto 1);

    -- redist1_yAddr_uid29_Divide_bit_select_merged_b_8(DELAY,306)
    redist1_yAddr_uid29_Divide_bit_select_merged_b_8_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_0 <= (others => '0');
            ELSE
                redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_0 <= STD_LOGIC_VECTOR(redist0_yAddr_uid29_Divide_bit_select_merged_b_4_q);
            END IF;
        END IF;
    END PROCESS;
    redist1_yAddr_uid29_Divide_bit_select_merged_b_8_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_1 <= redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_0;
                redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_2 <= redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_1;
                redist1_yAddr_uid29_Divide_bit_select_merged_b_8_q <= STD_LOGIC_VECTOR(redist1_yAddr_uid29_Divide_bit_select_merged_b_8_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- memoryC1_uid86_invTabGen_lutmem(DUALMEM,265)@8 + 2
    memoryC1_uid86_invTabGen_lutmem_aa <= redist1_yAddr_uid29_Divide_bit_select_merged_b_8_q;
    memoryC1_uid86_invTabGen_lutmem_ena_NotRstA <= not (areset);
    memoryC1_uid86_invTabGen_lutmem_reset0 <= areset;
    memoryC1_uid86_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 30,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V_memoryC1_uid86_invTabGen_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => memoryC1_uid86_invTabGen_lutmem_ena_NotRstA,
        sclr => memoryC1_uid86_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC1_uid86_invTabGen_lutmem_aa,
        q_a => memoryC1_uid86_invTabGen_lutmem_ir
    );
    memoryC1_uid86_invTabGen_lutmem_r <= STD_LOGIC_VECTOR(memoryC1_uid86_invTabGen_lutmem_ir(29 downto 0));

    -- s2sumAHighB_uid109_invPolyEval(ADD,108)@10
    s2sumAHighB_uid109_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => memoryC1_uid86_invTabGen_lutmem_r(29)) & memoryC1_uid86_invTabGen_lutmem_r));
    s2sumAHighB_uid109_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 23 => highBBits_uid108_invPolyEval_b(22)) & highBBits_uid108_invPolyEval_b));
    s2sumAHighB_uid109_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid109_invPolyEval_a) + SIGNED(s2sumAHighB_uid109_invPolyEval_b));
    s2sumAHighB_uid109_invPolyEval_q <= STD_LOGIC_VECTOR(s2sumAHighB_uid109_invPolyEval_o(30 downto 0));

    -- lowRangeB_uid107_invPolyEval(BITSELECT,106)@10
    lowRangeB_uid107_invPolyEval_in <= osig_uid122_pT2_uid106_invPolyEval_b(0 downto 0);
    lowRangeB_uid107_invPolyEval_b <= STD_LOGIC_VECTOR(lowRangeB_uid107_invPolyEval_in(0 downto 0));

    -- s2_uid110_invPolyEval(BITJOIN,109)@10
    s2_uid110_invPolyEval_q <= s2sumAHighB_uid109_invPolyEval_q & lowRangeB_uid107_invPolyEval_b;

    -- topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged(BITSELECT,301)@10
    topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_b <= s2_uid110_invPolyEval_q(31 downto 14);
    topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_c <= s2_uid110_invPolyEval_q(13 downto 0);

    -- zs_uid66_zCount_uid19_Divide(CONSTANT,65)
    zs_uid66_zCount_uid19_Divide_q <= "0000";

    -- aboveLeftY_mergedSignalTM_uid154_pT3_uid112_invPolyEval(BITJOIN,153)@10
    aboveLeftY_mergedSignalTM_uid154_pT3_uid112_invPolyEval_q <= topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_c & zs_uid66_zCount_uid19_Divide_q;

    -- redist5_yAddr_uid29_Divide_bit_select_merged_c_10(DELAY,310)
    redist5_yAddr_uid29_Divide_bit_select_merged_c_10_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_0 <= (others => '0');
            ELSE
                redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_0 <= STD_LOGIC_VECTOR(redist4_yAddr_uid29_Divide_bit_select_merged_c_6_q);
            END IF;
        END IF;
    END PROCESS;
    redist5_yAddr_uid29_Divide_bit_select_merged_c_10_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_1 <= redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_0;
                redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_2 <= redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_1;
                redist5_yAddr_uid29_Divide_bit_select_merged_c_10_q <= STD_LOGIC_VECTOR(redist5_yAddr_uid29_Divide_bit_select_merged_c_10_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- nx_mergedSignalTM_uid141_pT3_uid112_invPolyEval(BITJOIN,140)@10
    nx_mergedSignalTM_uid141_pT3_uid112_invPolyEval_q <= GND_q & redist5_yAddr_uid29_Divide_bit_select_merged_c_10_q;

    -- topRangeX_bottomExtension_uid143_pT3_uid112_invPolyEval(CONSTANT,142)
    topRangeX_bottomExtension_uid143_pT3_uid112_invPolyEval_q <= "0000000000";

    -- topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval(BITJOIN,144)@10
    topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval_q <= nx_mergedSignalTM_uid141_pT3_uid112_invPolyEval_q & topRangeX_bottomExtension_uid143_pT3_uid112_invPolyEval_q;

    -- sm0_uid160_pT3_uid112_invPolyEval_cma(CHAINMULTADD,281)@10 + 4
    -- in b@13
    sm0_uid160_pT3_uid112_invPolyEval_cma_reset <= areset;
    sm0_uid160_pT3_uid112_invPolyEval_cma_ena0 <= '1';
    sm0_uid160_pT3_uid112_invPolyEval_cma_ena1 <= sm0_uid160_pT3_uid112_invPolyEval_cma_ena0;
    sm0_uid160_pT3_uid112_invPolyEval_cma_ena2 <= sm0_uid160_pT3_uid112_invPolyEval_cma_ena0;

    sm0_uid160_pT3_uid112_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval_q),18));
    sm0_uid160_pT3_uid112_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(aboveLeftY_mergedSignalTM_uid154_pT3_uid112_invPolyEval_q),18));
    sm0_uid160_pT3_uid112_invPolyEval_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 18,
        ax_clken => "0",
        ax_width => 18,
        signed_may => "true",
        signed_max => "false",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 36,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => sm0_uid160_pT3_uid112_invPolyEval_cma_ena0,
        ena(1) => sm0_uid160_pT3_uid112_invPolyEval_cma_ena1,
        ena(2) => sm0_uid160_pT3_uid112_invPolyEval_cma_ena2,
        clr(0) => sm0_uid160_pT3_uid112_invPolyEval_cma_reset,
        clr(1) => sm0_uid160_pT3_uid112_invPolyEval_cma_reset,
        ay => sm0_uid160_pT3_uid112_invPolyEval_cma_a0,
        ax => sm0_uid160_pT3_uid112_invPolyEval_cma_c0,
        resulta => sm0_uid160_pT3_uid112_invPolyEval_cma_s0
    );
    sm0_uid160_pT3_uid112_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sm0_uid160_pT3_uid112_invPolyEval_cma_s0, xout => sm0_uid160_pT3_uid112_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    sm0_uid160_pT3_uid112_invPolyEval_cma_q <= STD_LOGIC_VECTOR(sm0_uid160_pT3_uid112_invPolyEval_cma_qq0(35 downto 0));

    -- highBBits_uid162_pT3_uid112_invPolyEval(BITSELECT,161)@14
    highBBits_uid162_pT3_uid112_invPolyEval_b <= sm0_uid160_pT3_uid112_invPolyEval_cma_q(35 downto 18);

    -- sm0_uid159_pT3_uid112_invPolyEval_cma(CHAINMULTADD,280)@10 + 4
    -- in b@13
    sm0_uid159_pT3_uid112_invPolyEval_cma_reset <= areset;
    sm0_uid159_pT3_uid112_invPolyEval_cma_ena0 <= '1';
    sm0_uid159_pT3_uid112_invPolyEval_cma_ena1 <= sm0_uid159_pT3_uid112_invPolyEval_cma_ena0;
    sm0_uid159_pT3_uid112_invPolyEval_cma_ena2 <= sm0_uid159_pT3_uid112_invPolyEval_cma_ena0;

    sm0_uid159_pT3_uid112_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval_q),18));
    sm0_uid159_pT3_uid112_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_b),18));
    sm0_uid159_pT3_uid112_invPolyEval_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 18,
        ax_clken => "0",
        ax_width => 18,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 36,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => sm0_uid159_pT3_uid112_invPolyEval_cma_ena0,
        ena(1) => sm0_uid159_pT3_uid112_invPolyEval_cma_ena1,
        ena(2) => sm0_uid159_pT3_uid112_invPolyEval_cma_ena2,
        clr(0) => sm0_uid159_pT3_uid112_invPolyEval_cma_reset,
        clr(1) => sm0_uid159_pT3_uid112_invPolyEval_cma_reset,
        ay => sm0_uid159_pT3_uid112_invPolyEval_cma_a0,
        ax => sm0_uid159_pT3_uid112_invPolyEval_cma_c0,
        resulta => sm0_uid159_pT3_uid112_invPolyEval_cma_s0
    );
    sm0_uid159_pT3_uid112_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => sm0_uid159_pT3_uid112_invPolyEval_cma_s0, xout => sm0_uid159_pT3_uid112_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    sm0_uid159_pT3_uid112_invPolyEval_cma_q <= STD_LOGIC_VECTOR(sm0_uid159_pT3_uid112_invPolyEval_cma_qq0(35 downto 0));

    -- lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval(ADD,162)@14
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 36 => sm0_uid159_pT3_uid112_invPolyEval_cma_q(35)) & sm0_uid159_pT3_uid112_invPolyEval_cma_q));
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 18 => highBBits_uid162_pT3_uid112_invPolyEval_b(17)) & highBBits_uid162_pT3_uid112_invPolyEval_b));
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_a) + SIGNED(lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_b));
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_q <= STD_LOGIC_VECTOR(lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_o(36 downto 0));

    -- lowRangeB_uid161_pT3_uid112_invPolyEval(BITSELECT,160)@14
    lowRangeB_uid161_pT3_uid112_invPolyEval_in <= sm0_uid160_pT3_uid112_invPolyEval_cma_q(17 downto 0);
    lowRangeB_uid161_pT3_uid112_invPolyEval_b <= STD_LOGIC_VECTOR(lowRangeB_uid161_pT3_uid112_invPolyEval_in(17 downto 0));

    -- lev1_a0_uid164_pT3_uid112_invPolyEval(BITJOIN,163)@14
    lev1_a0_uid164_pT3_uid112_invPolyEval_q <= lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_q & lowRangeB_uid161_pT3_uid112_invPolyEval_b;

    -- os_uid165_pT3_uid112_invPolyEval(BITSELECT,164)@14
    os_uid165_pT3_uid112_invPolyEval_in <= STD_LOGIC_VECTOR(lev1_a0_uid164_pT3_uid112_invPolyEval_q(52 downto 0));
    os_uid165_pT3_uid112_invPolyEval_b <= os_uid165_pT3_uid112_invPolyEval_in(52 downto 20);

    -- highBBits_uid114_invPolyEval(BITSELECT,113)@14
    highBBits_uid114_invPolyEval_b <= os_uid165_pT3_uid112_invPolyEval_b(32 downto 2);

    -- redist2_yAddr_uid29_Divide_bit_select_merged_b_12(DELAY,307)
    redist2_yAddr_uid29_Divide_bit_select_merged_b_12_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_0 <= (others => '0');
            ELSE
                redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_0 <= STD_LOGIC_VECTOR(redist1_yAddr_uid29_Divide_bit_select_merged_b_8_q);
            END IF;
        END IF;
    END PROCESS;
    redist2_yAddr_uid29_Divide_bit_select_merged_b_12_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_1 <= redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_0;
                redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_2 <= redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_1;
                redist2_yAddr_uid29_Divide_bit_select_merged_b_12_q <= STD_LOGIC_VECTOR(redist2_yAddr_uid29_Divide_bit_select_merged_b_12_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- memoryC0_uid83_invTabGen_lutmem(DUALMEM,264)@12 + 2
    memoryC0_uid83_invTabGen_lutmem_aa <= redist2_yAddr_uid29_Divide_bit_select_merged_b_12_q;
    memoryC0_uid83_invTabGen_lutmem_ena_NotRstA <= not (areset);
    memoryC0_uid83_invTabGen_lutmem_reset0 <= areset;
    memoryC0_uid83_invTabGen_lutmem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M20K",
        operation_mode => "ROM",
        width_a => 39,
        widthad_a => 8,
        numwords_a => 256,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        outdata_reg_a => "CLOCK0",
        outdata_sclr_a => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        power_up_uninitialized => "FALSE",
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Voltage_scale_120_link_V_memoryC0_uid83_invTabGen_lutmem.hex"),
        init_file_layout => "PORT_A",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken0 => memoryC0_uid83_invTabGen_lutmem_ena_NotRstA,
        sclr => memoryC0_uid83_invTabGen_lutmem_reset0,
        clock0 => clk,
        address_a => memoryC0_uid83_invTabGen_lutmem_aa,
        q_a => memoryC0_uid83_invTabGen_lutmem_ir
    );
    memoryC0_uid83_invTabGen_lutmem_r <= STD_LOGIC_VECTOR(memoryC0_uid83_invTabGen_lutmem_ir(38 downto 0));

    -- s3sumAHighB_uid115_invPolyEval(ADD,114)@14
    s3sumAHighB_uid115_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 39 => memoryC0_uid83_invTabGen_lutmem_r(38)) & memoryC0_uid83_invTabGen_lutmem_r));
    s3sumAHighB_uid115_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 31 => highBBits_uid114_invPolyEval_b(30)) & highBBits_uid114_invPolyEval_b));
    s3sumAHighB_uid115_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s3sumAHighB_uid115_invPolyEval_a) + SIGNED(s3sumAHighB_uid115_invPolyEval_b));
    s3sumAHighB_uid115_invPolyEval_q <= STD_LOGIC_VECTOR(s3sumAHighB_uid115_invPolyEval_o(39 downto 0));

    -- lowRangeB_uid113_invPolyEval(BITSELECT,112)@14
    lowRangeB_uid113_invPolyEval_in <= os_uid165_pT3_uid112_invPolyEval_b(1 downto 0);
    lowRangeB_uid113_invPolyEval_b <= STD_LOGIC_VECTOR(lowRangeB_uid113_invPolyEval_in(1 downto 0));

    -- s3_uid116_invPolyEval(BITJOIN,115)@14
    s3_uid116_invPolyEval_q <= s3sumAHighB_uid115_invPolyEval_q & lowRangeB_uid113_invPolyEval_b;

    -- fxpInverseRes_uid32_Divide(BITSELECT,31)@14
    fxpInverseRes_uid32_Divide_in <= s3_uid116_invPolyEval_q(39 downto 0);
    fxpInverseRes_uid32_Divide_b <= STD_LOGIC_VECTOR(fxpInverseRes_uid32_Divide_in(39 downto 6));

    -- normYIsOneC2_uid22_Divide(LOGICAL,23)@0
    normYIsOneC2_uid22_Divide_a <= STD_LOGIC_VECTOR("0" & normYNoLeadOne_uid21_Divide_b);
    normYIsOneC2_uid22_Divide_q <= "1" WHEN normYIsOneC2_uid22_Divide_a = zs_uid54_zCount_uid19_Divide_q ELSE "0";

    -- normYIsOneC2_uid25_Divide(BITSELECT,24)@0
    normYIsOneC2_uid25_Divide_b <= leftShiftStage2_uid216_normY_uid20_Divide_q(15 downto 15);

    -- normYIsOne_uid26_Divide(LOGICAL,25)@0 + 1
    normYIsOne_uid26_Divide_qi <= normYIsOneC2_uid25_Divide_b and normYIsOneC2_uid22_Divide_q;
    normYIsOne_uid26_Divide_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => normYIsOne_uid26_Divide_qi, xout => normYIsOne_uid26_Divide_q, clk => clk, aclr => areset, ena => '1' );

    -- redist10_normYIsOne_uid26_Divide_q_14(DELAY,315)
    redist10_normYIsOne_uid26_Divide_q_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 13, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => normYIsOne_uid26_Divide_q, xout => redist10_normYIsOne_uid26_Divide_q_14_q, clk => clk, aclr => areset, ena => '1' );

    -- invResPostOneHandling2_uid34_Divide(MUX,33)@14
    invResPostOneHandling2_uid34_Divide_s <= redist10_normYIsOne_uid26_Divide_q_14_q;
    invResPostOneHandling2_uid34_Divide_combproc: PROCESS (invResPostOneHandling2_uid34_Divide_s, fxpInverseRes_uid32_Divide_b, oneInvRes_uid33_Divide_q)
    BEGIN
        CASE (invResPostOneHandling2_uid34_Divide_s) IS
            WHEN "0" => invResPostOneHandling2_uid34_Divide_q <= fxpInverseRes_uid32_Divide_b;
            WHEN "1" => invResPostOneHandling2_uid34_Divide_q <= oneInvRes_uid33_Divide_q;
            WHEN OTHERS => invResPostOneHandling2_uid34_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- prodXInvY_uid41_Divide_bs2_bit_select_merged(BITSELECT,294)@14
    prodXInvY_uid41_Divide_bs2_bit_select_merged_b <= STD_LOGIC_VECTOR(invResPostOneHandling2_uid34_Divide_q(17 downto 0));
    prodXInvY_uid41_Divide_bs2_bit_select_merged_c <= STD_LOGIC_VECTOR(invResPostOneHandling2_uid34_Divide_q(33 downto 18));

    -- prodXInvY_uid41_Divide_bjB7(BITJOIN,224)@14
    prodXInvY_uid41_Divide_bjB7_q <= GND_q & prodXInvY_uid41_Divide_bs2_bit_select_merged_c;

    -- redist11_xMSB_uid13_Divide_b_14(DELAY,316)
    redist11_xMSB_uid13_Divide_b_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 14, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => xMSB_uid13_Divide_b, xout => redist11_xMSB_uid13_Divide_b_14_q, clk => clk, aclr => areset, ena => '1' );

    -- Const2(CONSTANT,3)
    Const2_q <= "0111111111111111";

    -- xPSX_uid37_Divide(LOGICAL,36)@14
    xPSX_uid37_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => redist11_xMSB_uid13_Divide_b_14_q(0)) & redist11_xMSB_uid13_Divide_b_14_q));
    xPSX_uid37_Divide_q <= STD_LOGIC_VECTOR(Const2_q xor xPSX_uid37_Divide_b);

    -- zMsbY0_uid39_Divide(BITJOIN,38)@14
    zMsbY0_uid39_Divide_q <= GND_q & redist11_xMSB_uid13_Divide_b_14_q;

    -- prodXInvY_uid41_Divide_im4_cma(CHAINMULTADD,285)@14 + 4
    -- in b@17
    prodXInvY_uid41_Divide_im4_cma_reset <= areset;
    prodXInvY_uid41_Divide_im4_cma_ena0 <= '1';
    prodXInvY_uid41_Divide_im4_cma_ena1 <= prodXInvY_uid41_Divide_im4_cma_ena0;
    prodXInvY_uid41_Divide_im4_cma_ena2 <= prodXInvY_uid41_Divide_im4_cma_ena0;

    prodXInvY_uid41_Divide_im4_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(zMsbY0_uid39_Divide_q),16));
    prodXInvY_uid41_Divide_im4_cma_b0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(xPSX_uid37_Divide_q),16));
    prodXInvY_uid41_Divide_im4_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(prodXInvY_uid41_Divide_bjB7_q),17));
    prodXInvY_uid41_Divide_im4_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 16,
        operand_source_may => "preadder",
        az_clken => "0",
        az_width => 16,
        ax_clken => "0",
        ax_width => 17,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 34,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => prodXInvY_uid41_Divide_im4_cma_ena0,
        ena(1) => prodXInvY_uid41_Divide_im4_cma_ena1,
        ena(2) => prodXInvY_uid41_Divide_im4_cma_ena2,
        clr(0) => prodXInvY_uid41_Divide_im4_cma_reset,
        clr(1) => prodXInvY_uid41_Divide_im4_cma_reset,
        ay => prodXInvY_uid41_Divide_im4_cma_a0,
        az => prodXInvY_uid41_Divide_im4_cma_b0,
        ax => prodXInvY_uid41_Divide_im4_cma_c0,
        resulta => prodXInvY_uid41_Divide_im4_cma_s0
    );
    prodXInvY_uid41_Divide_im4_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 34, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid41_Divide_im4_cma_s0, xout => prodXInvY_uid41_Divide_im4_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXInvY_uid41_Divide_im4_cma_q <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_im4_cma_qq0(33 downto 0));

    -- prodXInvY_uid41_Divide_sums_align_1(BITSHIFT,226)@18
    prodXInvY_uid41_Divide_sums_align_1_qint <= prodXInvY_uid41_Divide_im4_cma_q & "000000000000000000";
    prodXInvY_uid41_Divide_sums_align_1_q <= prodXInvY_uid41_Divide_sums_align_1_qint(51 downto 0);

    -- prodXInvY_uid41_Divide_sums_result_add_0_0_lhsMSBs_select(BITSELECT,275)@18
    prodXInvY_uid41_Divide_sums_result_add_0_0_lhsMSBs_select_b <= prodXInvY_uid41_Divide_sums_align_1_q(51 downto 18);

    -- prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums(ADD,276)@18
    prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 34 => prodXInvY_uid41_Divide_sums_result_add_0_0_lhsMSBs_select_b(33)) & prodXInvY_uid41_Divide_sums_result_add_0_0_lhsMSBs_select_b));
    prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((34 downto 18 => prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b(17)) & prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b));
    prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_a) + SIGNED(prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_b));
    prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_q <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_o(34 downto 0));

    -- prodXInvY_uid41_Divide_bjB3(BITJOIN,220)@14
    prodXInvY_uid41_Divide_bjB3_q <= GND_q & prodXInvY_uid41_Divide_bs2_bit_select_merged_b;

    -- xPSXE_uid40_Divide(ADD,39)@14
    xPSXE_uid40_Divide_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => xPSX_uid37_Divide_q(15)) & xPSX_uid37_Divide_q));
    xPSXE_uid40_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 2 => zMsbY0_uid39_Divide_q(1)) & zMsbY0_uid39_Divide_q));
    xPSXE_uid40_Divide_o <= STD_LOGIC_VECTOR(SIGNED(xPSXE_uid40_Divide_a) + SIGNED(xPSXE_uid40_Divide_b));
    xPSXE_uid40_Divide_q <= STD_LOGIC_VECTOR(xPSXE_uid40_Divide_o(16 downto 0));

    -- prodXInvY_uid41_Divide_im0_cma(CHAINMULTADD,284)@14 + 4
    -- in b@17
    prodXInvY_uid41_Divide_im0_cma_reset <= areset;
    prodXInvY_uid41_Divide_im0_cma_ena0 <= '1';
    prodXInvY_uid41_Divide_im0_cma_ena1 <= prodXInvY_uid41_Divide_im0_cma_ena0;
    prodXInvY_uid41_Divide_im0_cma_ena2 <= prodXInvY_uid41_Divide_im0_cma_ena0;

    prodXInvY_uid41_Divide_im0_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(xPSXE_uid40_Divide_q),17));
    prodXInvY_uid41_Divide_im0_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(prodXInvY_uid41_Divide_bjB3_q),19));
    prodXInvY_uid41_Divide_im0_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 19,
        ax_clken => "0",
        ax_width => 17,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 36,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => prodXInvY_uid41_Divide_im0_cma_ena0,
        ena(1) => prodXInvY_uid41_Divide_im0_cma_ena1,
        ena(2) => prodXInvY_uid41_Divide_im0_cma_ena2,
        clr(0) => prodXInvY_uid41_Divide_im0_cma_reset,
        clr(1) => prodXInvY_uid41_Divide_im0_cma_reset,
        ay => prodXInvY_uid41_Divide_im0_cma_c0,
        ax => prodXInvY_uid41_Divide_im0_cma_a0,
        resulta => prodXInvY_uid41_Divide_im0_cma_s0
    );
    prodXInvY_uid41_Divide_im0_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid41_Divide_im0_cma_s0, xout => prodXInvY_uid41_Divide_im0_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXInvY_uid41_Divide_im0_cma_q <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_im0_cma_qq0(35 downto 0));

    -- prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged(BITSELECT,304)@18
    prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b <= prodXInvY_uid41_Divide_im0_cma_q(35 downto 18);
    prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c <= prodXInvY_uid41_Divide_im0_cma_q(17 downto 0);

    -- prodXInvY_uid41_Divide_sums_result_add_0_0_split_join(BITJOIN,277)@18
    prodXInvY_uid41_Divide_sums_result_add_0_0_split_join_q <= prodXInvY_uid41_Divide_sums_result_add_0_0_MSBs_sums_q & prodXInvY_uid41_Divide_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c;

    -- rightShiftInput_uid42_Divide(BITSELECT,41)@18
    rightShiftInput_uid42_Divide_in <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_sums_result_add_0_0_split_join_q(49 downto 0));
    rightShiftInput_uid42_Divide_b <= rightShiftInput_uid42_Divide_in(49 downto 0);

    -- xMSB_uid230_prodPostRightShift_uid43_Divide(BITSELECT,229)@18
    xMSB_uid230_prodPostRightShift_uid43_Divide_b <= rightShiftInput_uid42_Divide_b(49 downto 49);

    -- seMsb_to48_uid259(BITSELECT,258)@18
    seMsb_to48_uid259_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((47 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to48_uid259_b <= seMsb_to48_uid259_in(47 downto 0);

    -- rightShiftStage2Idx3Rng48_uid260_prodPostRightShift_uid43_Divide(BITSELECT,259)@18
    rightShiftStage2Idx3Rng48_uid260_prodPostRightShift_uid43_Divide_b <= rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q(49 downto 48);

    -- rightShiftStage2Idx3_uid261_prodPostRightShift_uid43_Divide(BITJOIN,260)@18
    rightShiftStage2Idx3_uid261_prodPostRightShift_uid43_Divide_q <= seMsb_to48_uid259_b & rightShiftStage2Idx3Rng48_uid260_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to32_uid256(BITSELECT,255)@18
    seMsb_to32_uid256_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to32_uid256_b <= seMsb_to32_uid256_in(31 downto 0);

    -- rightShiftStage2Idx2Rng32_uid257_prodPostRightShift_uid43_Divide(BITSELECT,256)@18
    rightShiftStage2Idx2Rng32_uid257_prodPostRightShift_uid43_Divide_b <= rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q(49 downto 32);

    -- rightShiftStage2Idx2_uid258_prodPostRightShift_uid43_Divide(BITJOIN,257)@18
    rightShiftStage2Idx2_uid258_prodPostRightShift_uid43_Divide_q <= seMsb_to32_uid256_b & rightShiftStage2Idx2Rng32_uid257_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to16_uid253(BITSELECT,252)@18
    seMsb_to16_uid253_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to16_uid253_b <= seMsb_to16_uid253_in(15 downto 0);

    -- rightShiftStage2Idx1Rng16_uid254_prodPostRightShift_uid43_Divide(BITSELECT,253)@18
    rightShiftStage2Idx1Rng16_uid254_prodPostRightShift_uid43_Divide_b <= rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q(49 downto 16);

    -- rightShiftStage2Idx1_uid255_prodPostRightShift_uid43_Divide(BITJOIN,254)@18
    rightShiftStage2Idx1_uid255_prodPostRightShift_uid43_Divide_q <= seMsb_to16_uid253_b & rightShiftStage2Idx1Rng16_uid254_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to12_uid248(BITSELECT,247)@18
    seMsb_to12_uid248_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to12_uid248_b <= seMsb_to12_uid248_in(11 downto 0);

    -- rightShiftStage1Idx3Rng12_uid249_prodPostRightShift_uid43_Divide(BITSELECT,248)@18
    rightShiftStage1Idx3Rng12_uid249_prodPostRightShift_uid43_Divide_b <= rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q(49 downto 12);

    -- rightShiftStage1Idx3_uid250_prodPostRightShift_uid43_Divide(BITJOIN,249)@18
    rightShiftStage1Idx3_uid250_prodPostRightShift_uid43_Divide_q <= seMsb_to12_uid248_b & rightShiftStage1Idx3Rng12_uid249_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to8_uid245(BITSELECT,244)@18
    seMsb_to8_uid245_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((7 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to8_uid245_b <= seMsb_to8_uid245_in(7 downto 0);

    -- rightShiftStage1Idx2Rng8_uid246_prodPostRightShift_uid43_Divide(BITSELECT,245)@18
    rightShiftStage1Idx2Rng8_uid246_prodPostRightShift_uid43_Divide_b <= rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q(49 downto 8);

    -- rightShiftStage1Idx2_uid247_prodPostRightShift_uid43_Divide(BITJOIN,246)@18
    rightShiftStage1Idx2_uid247_prodPostRightShift_uid43_Divide_q <= seMsb_to8_uid245_b & rightShiftStage1Idx2Rng8_uid246_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to4_uid242(BITSELECT,241)@18
    seMsb_to4_uid242_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((3 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to4_uid242_b <= seMsb_to4_uid242_in(3 downto 0);

    -- rightShiftStage1Idx1Rng4_uid243_prodPostRightShift_uid43_Divide(BITSELECT,242)@18
    rightShiftStage1Idx1Rng4_uid243_prodPostRightShift_uid43_Divide_b <= rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q(49 downto 4);

    -- rightShiftStage1Idx1_uid244_prodPostRightShift_uid43_Divide(BITJOIN,243)@18
    rightShiftStage1Idx1_uid244_prodPostRightShift_uid43_Divide_q <= seMsb_to4_uid242_b & rightShiftStage1Idx1Rng4_uid243_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to3_uid237(BITSELECT,236)@18
    seMsb_to3_uid237_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((2 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to3_uid237_b <= seMsb_to3_uid237_in(2 downto 0);

    -- rightShiftStage0Idx3Rng3_uid238_prodPostRightShift_uid43_Divide(BITSELECT,237)@18
    rightShiftStage0Idx3Rng3_uid238_prodPostRightShift_uid43_Divide_b <= rightShiftInput_uid42_Divide_b(49 downto 3);

    -- rightShiftStage0Idx3_uid239_prodPostRightShift_uid43_Divide(BITJOIN,238)@18
    rightShiftStage0Idx3_uid239_prodPostRightShift_uid43_Divide_q <= seMsb_to3_uid237_b & rightShiftStage0Idx3Rng3_uid238_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to2_uid234(BITSELECT,233)@18
    seMsb_to2_uid234_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => xMSB_uid230_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid230_prodPostRightShift_uid43_Divide_b));
    seMsb_to2_uid234_b <= seMsb_to2_uid234_in(1 downto 0);

    -- rightShiftStage0Idx2Rng2_uid235_prodPostRightShift_uid43_Divide(BITSELECT,234)@18
    rightShiftStage0Idx2Rng2_uid235_prodPostRightShift_uid43_Divide_b <= rightShiftInput_uid42_Divide_b(49 downto 2);

    -- rightShiftStage0Idx2_uid236_prodPostRightShift_uid43_Divide(BITJOIN,235)@18
    rightShiftStage0Idx2_uid236_prodPostRightShift_uid43_Divide_q <= seMsb_to2_uid234_b & rightShiftStage0Idx2Rng2_uid235_prodPostRightShift_uid43_Divide_b;

    -- rightShiftStage0Idx1Rng1_uid232_prodPostRightShift_uid43_Divide(BITSELECT,231)@18
    rightShiftStage0Idx1Rng1_uid232_prodPostRightShift_uid43_Divide_b <= rightShiftInput_uid42_Divide_b(49 downto 1);

    -- rightShiftStage0Idx1_uid233_prodPostRightShift_uid43_Divide(BITJOIN,232)@18
    rightShiftStage0Idx1_uid233_prodPostRightShift_uid43_Divide_q <= xMSB_uid230_prodPostRightShift_uid43_Divide_b & rightShiftStage0Idx1Rng1_uid232_prodPostRightShift_uid43_Divide_b;

    -- rightShiftStage0_uid241_prodPostRightShift_uid43_Divide(MUX,240)@18
    rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_s <= rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_b;
    rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_combproc: PROCESS (rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_s, rightShiftInput_uid42_Divide_b, rightShiftStage0Idx1_uid233_prodPostRightShift_uid43_Divide_q, rightShiftStage0Idx2_uid236_prodPostRightShift_uid43_Divide_q, rightShiftStage0Idx3_uid239_prodPostRightShift_uid43_Divide_q)
    BEGIN
        CASE (rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_s) IS
            WHEN "00" => rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q <= rightShiftInput_uid42_Divide_b;
            WHEN "01" => rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q <= rightShiftStage0Idx1_uid233_prodPostRightShift_uid43_Divide_q;
            WHEN "10" => rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q <= rightShiftStage0Idx2_uid236_prodPostRightShift_uid43_Divide_q;
            WHEN "11" => rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q <= rightShiftStage0Idx3_uid239_prodPostRightShift_uid43_Divide_q;
            WHEN OTHERS => rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1_uid252_prodPostRightShift_uid43_Divide(MUX,251)@18
    rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_s <= rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_c;
    rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_combproc: PROCESS (rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_s, rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q, rightShiftStage1Idx1_uid244_prodPostRightShift_uid43_Divide_q, rightShiftStage1Idx2_uid247_prodPostRightShift_uid43_Divide_q, rightShiftStage1Idx3_uid250_prodPostRightShift_uid43_Divide_q)
    BEGIN
        CASE (rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_s) IS
            WHEN "00" => rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q <= rightShiftStage0_uid241_prodPostRightShift_uid43_Divide_q;
            WHEN "01" => rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q <= rightShiftStage1Idx1_uid244_prodPostRightShift_uid43_Divide_q;
            WHEN "10" => rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q <= rightShiftStage1Idx2_uid247_prodPostRightShift_uid43_Divide_q;
            WHEN "11" => rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q <= rightShiftStage1Idx3_uid250_prodPostRightShift_uid43_Divide_q;
            WHEN OTHERS => rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_notEnable(LOGICAL,345)
    redist8_r_uid81_zCount_uid19_Divide_q_18_notEnable_q <= not (VCC_q);

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_nor(LOGICAL,346)
    redist8_r_uid81_zCount_uid19_Divide_q_18_nor_q <= STD_LOGIC_VECTOR(not (redist8_r_uid81_zCount_uid19_Divide_q_18_notEnable_q or redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena_q));

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_mem_last(CONSTANT,342)
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_last_q <= "01111";

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_cmp(LOGICAL,343)
    redist8_r_uid81_zCount_uid19_Divide_q_18_cmp_q <= "1" WHEN redist8_r_uid81_zCount_uid19_Divide_q_18_mem_last_q = redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_q ELSE "0";

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_cmpReg(REG,344)
    redist8_r_uid81_zCount_uid19_Divide_q_18_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist8_r_uid81_zCount_uid19_Divide_q_18_cmpReg_q <= "0";
            ELSE
                redist8_r_uid81_zCount_uid19_Divide_q_18_cmpReg_q <= redist8_r_uid81_zCount_uid19_Divide_q_18_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena(REG,347)
    redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena_q <= "0";
            ELSE
                IF (redist8_r_uid81_zCount_uid19_Divide_q_18_nor_q = "1") THEN
                    redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena_q <= redist8_r_uid81_zCount_uid19_Divide_q_18_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_enaAnd(LOGICAL,348)
    redist8_r_uid81_zCount_uid19_Divide_q_18_enaAnd_q <= STD_LOGIC_VECTOR(redist8_r_uid81_zCount_uid19_Divide_q_18_sticky_ena_q and VCC_q);

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt(COUNTER,340)
    -- low=0, high=16, step=1, init=0
    redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_eq <= '0';
            ELSE
                IF (redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i = TO_UNSIGNED(15, 5)) THEN
                    redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_eq <= '1';
                ELSE
                    redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_eq <= '0';
                END IF;
                IF (redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_eq = '1') THEN
                    redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i <= redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i + 16;
                ELSE
                    redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i <= redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_i, 5));

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_wraddr(REG,341)
    redist8_r_uid81_zCount_uid19_Divide_q_18_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist8_r_uid81_zCount_uid19_Divide_q_18_wraddr_q <= "10000";
            ELSE
                redist8_r_uid81_zCount_uid19_Divide_q_18_wraddr_q <= redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist8_r_uid81_zCount_uid19_Divide_q_18_mem(DUALMEM,339)
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ia <= STD_LOGIC_VECTOR(r_uid81_zCount_uid19_Divide_q);
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_aa <= redist8_r_uid81_zCount_uid19_Divide_q_18_wraddr_q;
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ab <= redist8_r_uid81_zCount_uid19_Divide_q_18_rdcnt_q;
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ena_OrRstB <= areset or redist8_r_uid81_zCount_uid19_Divide_q_18_enaAnd_q(0);
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_reset0 <= areset;
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 5,
        widthad_a => 5,
        numwords_a => 17,
        width_b => 5,
        widthad_b => 5,
        numwords_b => 17,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken1 => redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist8_r_uid81_zCount_uid19_Divide_q_18_mem_reset0,
        clock1 => clk,
        address_a => redist8_r_uid81_zCount_uid19_Divide_q_18_mem_aa,
        data_a => redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist8_r_uid81_zCount_uid19_Divide_q_18_mem_ab,
        q_b => redist8_r_uid81_zCount_uid19_Divide_q_18_mem_iq
    );
    redist8_r_uid81_zCount_uid19_Divide_q_18_mem_q <= STD_LOGIC_VECTOR(redist8_r_uid81_zCount_uid19_Divide_q_18_mem_iq(4 downto 0));

    -- cWOut_uid35_Divide(CONSTANT,34)
    cWOut_uid35_Divide_q <= "10000";

    -- rShiftCount_uid36_Divide(SUB,35)@18
    rShiftCount_uid36_Divide_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & cWOut_uid35_Divide_q));
    rShiftCount_uid36_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & redist8_r_uid81_zCount_uid19_Divide_q_18_mem_q));
    rShiftCount_uid36_Divide_o <= STD_LOGIC_VECTOR(SIGNED(rShiftCount_uid36_Divide_a) - SIGNED(rShiftCount_uid36_Divide_b));
    rShiftCount_uid36_Divide_q <= STD_LOGIC_VECTOR(rShiftCount_uid36_Divide_o(5 downto 0));

    -- rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged(BITSELECT,295)@18
    rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(rShiftCount_uid36_Divide_q(1 downto 0));
    rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(rShiftCount_uid36_Divide_q(3 downto 2));
    rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_d <= STD_LOGIC_VECTOR(rShiftCount_uid36_Divide_q(5 downto 4));

    -- rightShiftStage2_uid263_prodPostRightShift_uid43_Divide(MUX,262)@18
    rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_s <= rightShiftStageSel0Dto0_uid240_prodPostRightShift_uid43_Divide_bit_select_merged_d;
    rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_combproc: PROCESS (rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_s, rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q, rightShiftStage2Idx1_uid255_prodPostRightShift_uid43_Divide_q, rightShiftStage2Idx2_uid258_prodPostRightShift_uid43_Divide_q, rightShiftStage2Idx3_uid261_prodPostRightShift_uid43_Divide_q)
    BEGIN
        CASE (rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_s) IS
            WHEN "00" => rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_q <= rightShiftStage1_uid252_prodPostRightShift_uid43_Divide_q;
            WHEN "01" => rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_q <= rightShiftStage2Idx1_uid255_prodPostRightShift_uid43_Divide_q;
            WHEN "10" => rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_q <= rightShiftStage2Idx2_uid258_prodPostRightShift_uid43_Divide_q;
            WHEN "11" => rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_q <= rightShiftStage2Idx3_uid261_prodPostRightShift_uid43_Divide_q;
            WHEN OTHERS => rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- prodPostRightShiftPost_uid44_Divide(BITSELECT,43)@18
    prodPostRightShiftPost_uid44_Divide_in <= rightShiftStage2_uid263_prodPostRightShift_uid43_Divide_q(48 downto 0);
    prodPostRightShiftPost_uid44_Divide_b <= STD_LOGIC_VECTOR(prodPostRightShiftPost_uid44_Divide_in(48 downto 15));

    -- prodPostRightShiftPostRnd_uid46_Divide(ADD,45)@18
    prodPostRightShiftPostRnd_uid46_Divide_a <= STD_LOGIC_VECTOR("0" & prodPostRightShiftPost_uid44_Divide_b);
    prodPostRightShiftPostRnd_uid46_Divide_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000" & VCC_q);
    prodPostRightShiftPostRnd_uid46_Divide_o <= STD_LOGIC_VECTOR(UNSIGNED(prodPostRightShiftPostRnd_uid46_Divide_a) + UNSIGNED(prodPostRightShiftPostRnd_uid46_Divide_b));
    prodPostRightShiftPostRnd_uid46_Divide_q <= STD_LOGIC_VECTOR(prodPostRightShiftPostRnd_uid46_Divide_o(34 downto 0));

    -- prodPostRightShiftPostRndRange_uid47_Divide(BITSELECT,46)@18
    prodPostRightShiftPostRndRange_uid47_Divide_in <= prodPostRightShiftPostRnd_uid46_Divide_q(33 downto 0);
    prodPostRightShiftPostRndRange_uid47_Divide_b <= STD_LOGIC_VECTOR(prodPostRightShiftPostRndRange_uid47_Divide_in(33 downto 1));

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_notEnable(LOGICAL,355)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_notEnable_q <= not (VCC_q);

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_nor(LOGICAL,356)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_nor_q <= STD_LOGIC_VECTOR(not (redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_notEnable_q or redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena_q));

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_last(CONSTANT,352)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_last_q <= "010";

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmp(LOGICAL,353)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmp_b <= STD_LOGIC_VECTOR("0" & redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_q);
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmp_q <= "1" WHEN redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_last_q = redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmp_b ELSE "0";

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmpReg(REG,354)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmpReg_q <= "0";
            ELSE
                redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmpReg_q <= redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena(REG,357)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena_q <= "0";
            ELSE
                IF (redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_nor_q = "1") THEN
                    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena_q <= redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_enaAnd(LOGICAL,358)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_enaAnd_q <= STD_LOGIC_VECTOR(redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_sticky_ena_q and VCC_q);

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt(COUNTER,350)
    -- low=0, high=3, step=1, init=0
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_i <= TO_UNSIGNED(0, 2);
            ELSE
                redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_i <= redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_i, 2));

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_wraddr(REG,351)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_wraddr_q <= "11";
            ELSE
                redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_wraddr_q <= redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem(DUALMEM,349)
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ia <= STD_LOGIC_VECTOR(in_1_Voltage_range_int16_tpl);
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_aa <= redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_wraddr_q;
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ab <= redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_rdcnt_q;
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ena_OrRstB <= areset or redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_enaAnd_q(0);
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_reset0 <= areset;
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 16,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken1 => redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_reset0,
        clock1 => clk,
        address_a => redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_aa,
        data_a => redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_ab,
        q_b => redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_iq
    );
    redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_q <= STD_LOGIC_VECTOR(redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_iq(15 downto 0));

    -- yIsZero_uid27_Divide(LOGICAL,26)@5 + 1
    yIsZero_uid27_Divide_b <= STD_LOGIC_VECTOR("000000000000000" & GND_q);
    yIsZero_uid27_Divide_qi <= "1" WHEN redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_q = yIsZero_uid27_Divide_b ELSE "0";
    yIsZero_uid27_Divide_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => yIsZero_uid27_Divide_qi, xout => yIsZero_uid27_Divide_q, clk => clk, aclr => areset, ena => '1' );

    -- redist9_yIsZero_uid27_Divide_q_13(DELAY,314)
    redist9_yIsZero_uid27_Divide_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 12, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => yIsZero_uid27_Divide_q, xout => redist9_yIsZero_uid27_Divide_q_13_q, clk => clk, aclr => areset, ena => '1' );

    -- resFinal_uid52_Divide(MUX,51)@18
    resFinal_uid52_Divide_s <= redist9_yIsZero_uid27_Divide_q_13_q;
    resFinal_uid52_Divide_combproc: PROCESS (resFinal_uid52_Divide_s, prodPostRightShiftPostRndRange_uid47_Divide_b, cstOvf_uid51_Divide_q_const_q)
    BEGIN
        CASE (resFinal_uid52_Divide_s) IS
            WHEN "0" => resFinal_uid52_Divide_q <= prodPostRightShiftPostRndRange_uid47_Divide_b;
            WHEN "1" => resFinal_uid52_Divide_q <= cstOvf_uid51_Divide_q_const_q;
            WHEN OTHERS => resFinal_uid52_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Mult_bs1_bit_select_merged(BITSELECT,296)@18
    Mult_bs1_bit_select_merged_b <= resFinal_uid52_Divide_q(17 downto 0);
    Mult_bs1_bit_select_merged_c <= resFinal_uid52_Divide_q(32 downto 18);

    -- Mult_bjA8(BITJOIN,182)@18
    Mult_bjA8_q <= GND_q & Mult_bs1_bit_select_merged_b;

    -- redist7_Add1_MSBs_sums_q_13_notEnable(LOGICAL,335)
    redist7_Add1_MSBs_sums_q_13_notEnable_q <= not (VCC_q);

    -- redist7_Add1_MSBs_sums_q_13_nor(LOGICAL,336)
    redist7_Add1_MSBs_sums_q_13_nor_q <= STD_LOGIC_VECTOR(not (redist7_Add1_MSBs_sums_q_13_notEnable_q or redist7_Add1_MSBs_sums_q_13_sticky_ena_q));

    -- redist7_Add1_MSBs_sums_q_13_mem_last(CONSTANT,332)
    redist7_Add1_MSBs_sums_q_13_mem_last_q <= "01001";

    -- redist7_Add1_MSBs_sums_q_13_cmp(LOGICAL,333)
    redist7_Add1_MSBs_sums_q_13_cmp_b <= STD_LOGIC_VECTOR("0" & redist7_Add1_MSBs_sums_q_13_rdcnt_q);
    redist7_Add1_MSBs_sums_q_13_cmp_q <= "1" WHEN redist7_Add1_MSBs_sums_q_13_mem_last_q = redist7_Add1_MSBs_sums_q_13_cmp_b ELSE "0";

    -- redist7_Add1_MSBs_sums_q_13_cmpReg(REG,334)
    redist7_Add1_MSBs_sums_q_13_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist7_Add1_MSBs_sums_q_13_cmpReg_q <= "0";
            ELSE
                redist7_Add1_MSBs_sums_q_13_cmpReg_q <= redist7_Add1_MSBs_sums_q_13_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist7_Add1_MSBs_sums_q_13_sticky_ena(REG,337)
    redist7_Add1_MSBs_sums_q_13_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist7_Add1_MSBs_sums_q_13_sticky_ena_q <= "0";
            ELSE
                IF (redist7_Add1_MSBs_sums_q_13_nor_q = "1") THEN
                    redist7_Add1_MSBs_sums_q_13_sticky_ena_q <= redist7_Add1_MSBs_sums_q_13_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist7_Add1_MSBs_sums_q_13_enaAnd(LOGICAL,338)
    redist7_Add1_MSBs_sums_q_13_enaAnd_q <= STD_LOGIC_VECTOR(redist7_Add1_MSBs_sums_q_13_sticky_ena_q and VCC_q);

    -- redist7_Add1_MSBs_sums_q_13_rdcnt(COUNTER,330)
    -- low=0, high=10, step=1, init=0
    redist7_Add1_MSBs_sums_q_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist7_Add1_MSBs_sums_q_13_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist7_Add1_MSBs_sums_q_13_rdcnt_eq <= '0';
            ELSE
                IF (redist7_Add1_MSBs_sums_q_13_rdcnt_i = TO_UNSIGNED(9, 4)) THEN
                    redist7_Add1_MSBs_sums_q_13_rdcnt_eq <= '1';
                ELSE
                    redist7_Add1_MSBs_sums_q_13_rdcnt_eq <= '0';
                END IF;
                IF (redist7_Add1_MSBs_sums_q_13_rdcnt_eq = '1') THEN
                    redist7_Add1_MSBs_sums_q_13_rdcnt_i <= redist7_Add1_MSBs_sums_q_13_rdcnt_i + 6;
                ELSE
                    redist7_Add1_MSBs_sums_q_13_rdcnt_i <= redist7_Add1_MSBs_sums_q_13_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist7_Add1_MSBs_sums_q_13_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist7_Add1_MSBs_sums_q_13_rdcnt_i, 4));

    -- Add1_rhsMSBs_select_bit_select_merged(BITSELECT,292)@5
    Add1_rhsMSBs_select_bit_select_merged_b <= in_2_Voltage_sfix16_En9_tpl(15 downto 6);
    Add1_rhsMSBs_select_bit_select_merged_c <= in_2_Voltage_sfix16_En9_tpl(5 downto 0);

    -- Add1_PreShift_0(BITSHIFT,11)@5
    Add1_PreShift_0_qint <= redist13_GPIn1_in_1_Voltage_range_int16_tpl_5_mem_q & "000000";
    Add1_PreShift_0_q <= Add1_PreShift_0_qint(21 downto 0);

    -- Add1_lhsMSBs_select(BITSELECT,171)@5
    Add1_lhsMSBs_select_b <= Add1_PreShift_0_q(21 downto 6);

    -- Add1_MSBs_sums(ADD,172)@5 + 1
    Add1_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => Add1_lhsMSBs_select_b(15)) & Add1_lhsMSBs_select_b));
    Add1_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 10 => Add1_rhsMSBs_select_bit_select_merged_b(9)) & Add1_rhsMSBs_select_bit_select_merged_b));
    Add1_MSBs_sums_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                Add1_MSBs_sums_o <= (others => '0');
            ELSE
                Add1_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(Add1_MSBs_sums_a) + SIGNED(Add1_MSBs_sums_b));
            END IF;
        END IF;
    END PROCESS;
    Add1_MSBs_sums_q <= STD_LOGIC_VECTOR(Add1_MSBs_sums_o(16 downto 0));

    -- redist7_Add1_MSBs_sums_q_13_wraddr(REG,331)
    redist7_Add1_MSBs_sums_q_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist7_Add1_MSBs_sums_q_13_wraddr_q <= "1010";
            ELSE
                redist7_Add1_MSBs_sums_q_13_wraddr_q <= redist7_Add1_MSBs_sums_q_13_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist7_Add1_MSBs_sums_q_13_mem(DUALMEM,329)
    redist7_Add1_MSBs_sums_q_13_mem_ia <= STD_LOGIC_VECTOR(Add1_MSBs_sums_q);
    redist7_Add1_MSBs_sums_q_13_mem_aa <= redist7_Add1_MSBs_sums_q_13_wraddr_q;
    redist7_Add1_MSBs_sums_q_13_mem_ab <= redist7_Add1_MSBs_sums_q_13_rdcnt_q;
    redist7_Add1_MSBs_sums_q_13_mem_ena_OrRstB <= areset or redist7_Add1_MSBs_sums_q_13_enaAnd_q(0);
    redist7_Add1_MSBs_sums_q_13_mem_reset0 <= areset;
    redist7_Add1_MSBs_sums_q_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 17,
        widthad_a => 4,
        numwords_a => 11,
        width_b => 17,
        widthad_b => 4,
        numwords_b => 11,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken1 => redist7_Add1_MSBs_sums_q_13_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist7_Add1_MSBs_sums_q_13_mem_reset0,
        clock1 => clk,
        address_a => redist7_Add1_MSBs_sums_q_13_mem_aa,
        data_a => redist7_Add1_MSBs_sums_q_13_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist7_Add1_MSBs_sums_q_13_mem_ab,
        q_b => redist7_Add1_MSBs_sums_q_13_mem_iq
    );
    redist7_Add1_MSBs_sums_q_13_mem_q <= STD_LOGIC_VECTOR(redist7_Add1_MSBs_sums_q_13_mem_iq(16 downto 0));

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_notEnable(LOGICAL,325)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_notEnable_q <= not (VCC_q);

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_nor(LOGICAL,326)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_nor_q <= STD_LOGIC_VECTOR(not (redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_notEnable_q or redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena_q));

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_last(CONSTANT,322)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_last_q <= "01010";

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmp(LOGICAL,323)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmp_b <= STD_LOGIC_VECTOR("0" & redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_q);
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmp_q <= "1" WHEN redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_last_q = redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmp_b ELSE "0";

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmpReg(REG,324)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmpReg_q <= "0";
            ELSE
                redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmpReg_q <= redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena(REG,327)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena_q <= "0";
            ELSE
                IF (redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_nor_q = "1") THEN
                    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena_q <= redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_enaAnd(LOGICAL,328)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_enaAnd_q <= STD_LOGIC_VECTOR(redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_sticky_ena_q and VCC_q);

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt(COUNTER,320)
    -- low=0, high=11, step=1, init=0
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_eq <= '0';
            ELSE
                IF (redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i = TO_UNSIGNED(10, 4)) THEN
                    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_eq <= '1';
                ELSE
                    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_eq <= '0';
                END IF;
                IF (redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_eq = '1') THEN
                    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i <= redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i + 5;
                ELSE
                    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i <= redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_i, 4));

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_wraddr(REG,321)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_wraddr_q <= "1011";
            ELSE
                redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_wraddr_q <= redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem(DUALMEM,319)
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ia <= STD_LOGIC_VECTOR(Add1_rhsMSBs_select_bit_select_merged_c);
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_aa <= redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_wraddr_q;
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ab <= redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_rdcnt_q;
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ena_OrRstB <= areset or redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_enaAnd_q(0);
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_reset0 <= areset;
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 6,
        widthad_a => 4,
        numwords_a => 12,
        width_b => 6,
        widthad_b => 4,
        numwords_b => 12,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_sclr_b => "SCLEAR",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Agilex 5"
    )
    PORT MAP (
        clocken1 => redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_reset0,
        clock1 => clk,
        address_a => redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_aa,
        data_a => redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_ab,
        q_b => redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_iq
    );
    redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_q <= STD_LOGIC_VECTOR(redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_iq(5 downto 0));

    -- Add1_split_join(BITJOIN,173)@18
    Add1_split_join_q <= redist7_Add1_MSBs_sums_q_13_mem_q & redist6_Add1_rhsMSBs_select_bit_select_merged_c_13_mem_q;

    -- Mult_bs2_bit_select_merged(BITSELECT,302)@18
    Mult_bs2_bit_select_merged_b <= Add1_split_join_q(17 downto 0);
    Mult_bs2_bit_select_merged_c <= Add1_split_join_q(22 downto 18);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- Mult_ma3_cma(CHAINMULTADD,286)@18 + 4
    -- in b@21
    Mult_ma3_cma_reset <= areset;
    Mult_ma3_cma_ena0 <= '1';
    Mult_ma3_cma_ena1 <= Mult_ma3_cma_ena0;
    Mult_ma3_cma_ena2 <= Mult_ma3_cma_ena0;

    Mult_ma3_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Mult_bs2_bit_select_merged_c),15));
    Mult_ma3_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Mult_bjA8_q),19));
    Mult_ma3_cma_a1 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Mult_bs1_bit_select_merged_c),15));
    Mult_ma3_cma_c1 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Mult_bjB6_q),19));
    Mult_ma3_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_sumof2",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 19,
        by_clken => "0",
        by_width => 19,
        ax_clken => "0",
        bx_clken => "0",
        ax_width => 15,
        bx_width => 15,
        signed_may => "true",
        signed_mby => "true",
        signed_max => "true",
        signed_mbx => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 35
    )
    PORT MAP (
        clk => clk,
        ena(0) => Mult_ma3_cma_ena0,
        ena(1) => Mult_ma3_cma_ena1,
        ena(2) => Mult_ma3_cma_ena2,
        clr(0) => Mult_ma3_cma_reset,
        clr(1) => Mult_ma3_cma_reset,
        ay => Mult_ma3_cma_c1,
        by => Mult_ma3_cma_c0,
        ax => Mult_ma3_cma_a1,
        bx => Mult_ma3_cma_a0,
        resulta => Mult_ma3_cma_s0
    );
    Mult_ma3_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 35, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => Mult_ma3_cma_s0, xout => Mult_ma3_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    Mult_ma3_cma_q <= STD_LOGIC_VECTOR(Mult_ma3_cma_qq0(34 downto 0));

    -- Mult_sums_align_1(BITSHIFT,188)@22
    Mult_sums_align_1_qint <= Mult_ma3_cma_q & "000000000000000000";
    Mult_sums_align_1_q <= Mult_sums_align_1_qint(52 downto 0);

    -- Mult_sums_result_add_0_0_lhsMSBs_select(BITSELECT,270)@22
    Mult_sums_result_add_0_0_lhsMSBs_select_b <= Mult_sums_align_1_q(52 downto 18);

    -- Mult_sums_result_add_0_0_MSBs_sums(ADD,271)@22
    Mult_sums_result_add_0_0_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 35 => Mult_sums_result_add_0_0_lhsMSBs_select_b(34)) & Mult_sums_result_add_0_0_lhsMSBs_select_b));
    Mult_sums_result_add_0_0_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((38 downto 38 => Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b(37)) & Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b));
    Mult_sums_result_add_0_0_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(Mult_sums_result_add_0_0_MSBs_sums_a) + SIGNED(Mult_sums_result_add_0_0_MSBs_sums_b));
    Mult_sums_result_add_0_0_MSBs_sums_q <= STD_LOGIC_VECTOR(Mult_sums_result_add_0_0_MSBs_sums_o(38 downto 0));

    -- Mult_im10_cma(CHAINMULTADD,283)@18 + 4
    -- in b@21
    Mult_im10_cma_reset <= areset;
    Mult_im10_cma_ena0 <= '1';
    Mult_im10_cma_ena1 <= Mult_im10_cma_ena0;
    Mult_im10_cma_ena2 <= Mult_im10_cma_ena0;

    Mult_im10_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Mult_bs1_bit_select_merged_c),15));
    Mult_im10_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Mult_bs2_bit_select_merged_c),11));
    Mult_im10_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 15,
        ax_clken => "0",
        ax_width => 11,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 26,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => Mult_im10_cma_ena0,
        ena(1) => Mult_im10_cma_ena1,
        ena(2) => Mult_im10_cma_ena2,
        clr(0) => Mult_im10_cma_reset,
        clr(1) => Mult_im10_cma_reset,
        ay => Mult_im10_cma_a0,
        ax => Mult_im10_cma_c0,
        resulta => Mult_im10_cma_s0
    );
    Mult_im10_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 26, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => Mult_im10_cma_s0, xout => Mult_im10_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    Mult_im10_cma_q <= STD_LOGIC_VECTOR(Mult_im10_cma_qq0(19 downto 0));

    -- Mult_im0_cma(CHAINMULTADD,282)@18 + 4
    -- in b@21
    Mult_im0_cma_reset <= areset;
    Mult_im0_cma_ena0 <= '1';
    Mult_im0_cma_ena1 <= Mult_im0_cma_ena0;
    Mult_im0_cma_ena2 <= Mult_im0_cma_ena0;

    Mult_im0_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(Mult_bs1_bit_select_merged_b),18));
    Mult_im0_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(Mult_bs2_bit_select_merged_b),18));
    Mult_im0_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 18,
        ax_clken => "0",
        ax_width => 18,
        signed_may => "false",
        signed_max => "false",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 36,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => Mult_im0_cma_ena0,
        ena(1) => Mult_im0_cma_ena1,
        ena(2) => Mult_im0_cma_ena2,
        clr(0) => Mult_im0_cma_reset,
        clr(1) => Mult_im0_cma_reset,
        ay => Mult_im0_cma_a0,
        ax => Mult_im0_cma_c0,
        resulta => Mult_im0_cma_s0
    );
    Mult_im0_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 36, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => Mult_im0_cma_s0, xout => Mult_im0_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    Mult_im0_cma_q <= STD_LOGIC_VECTOR(Mult_im0_cma_qq0(35 downto 0));

    -- Mult_sums_join_0(BITJOIN,187)@22
    Mult_sums_join_0_q <= Mult_im10_cma_q & Mult_im0_cma_q;

    -- Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged(BITSELECT,303)@22
    Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_b <= Mult_sums_join_0_q(55 downto 18);
    Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c <= Mult_sums_join_0_q(17 downto 0);

    -- Mult_sums_result_add_0_0_split_join(BITJOIN,272)@22
    Mult_sums_result_add_0_0_split_join_q <= Mult_sums_result_add_0_0_MSBs_sums_q & Mult_sums_result_add_0_0_rhsMSBs_select_bit_select_merged_c;

    -- Convert4_rnd_trunc(BITSHIFT,288)@22
    Convert4_rnd_trunc_qint <= Mult_sums_result_add_0_0_split_join_q(55 downto 0);
    Convert4_rnd_trunc_q <= Convert4_rnd_trunc_qint(55 downto 21);

    -- Convert4_rnd_add(ADD,289)@22
    Convert4_rnd_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => Convert4_rnd_trunc_q(34)) & Convert4_rnd_trunc_q));
    Convert4_rnd_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 2 => Convert4_rnd_bias_q(1)) & Convert4_rnd_bias_q));
    Convert4_rnd_add_o <= STD_LOGIC_VECTOR(SIGNED(Convert4_rnd_add_a) + SIGNED(Convert4_rnd_add_b));
    Convert4_rnd_add_q <= STD_LOGIC_VECTOR(Convert4_rnd_add_o(35 downto 0));

    -- Convert4_rnd_shift(BITSHIFT,290)@22
    Convert4_rnd_shift_qint <= Convert4_rnd_add_q;
    Convert4_rnd_shift_q <= Convert4_rnd_shift_qint(35 downto 1);

    -- Convert4_sel_x(BITSELECT,10)@22
    Convert4_sel_x_b <= STD_LOGIC_VECTOR(Convert4_rnd_shift_q(15 downto 0));

    -- redist12_Convert4_sel_x_b_1(DELAY,317)
    redist12_Convert4_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist12_Convert4_sel_x_b_1_q <= (others => '0');
            ELSE
                redist12_Convert4_sel_x_b_1_q <= Convert4_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- GPOut(GPOUT,8)@23
    out_1_Fraction_ND_ufix16_En16_x_tpl <= redist12_Convert4_sel_x_b_1_q;

END normal;
