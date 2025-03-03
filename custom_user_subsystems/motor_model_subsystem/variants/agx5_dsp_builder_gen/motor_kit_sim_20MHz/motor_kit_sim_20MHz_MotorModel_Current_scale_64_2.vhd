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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_Current_scale_64_2
-- VHDL created on Wed Aug  7 11:03:59 2024


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

USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;
entity motor_kit_sim_20MHz_MotorModel_Current_scale_64_2 is
    port (
        in_1_Current_range_int16_tpl : in std_logic_vector(15 downto 0);  -- sfix16
        in_2_Current_sfix16_En10_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en9
        out_1_Fraction_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        clk : in std_logic;
        areset : in std_logic
    );
end motor_kit_sim_20MHz_MotorModel_Current_scale_64_2;

architecture normal of motor_kit_sim_20MHz_MotorModel_Current_scale_64_2 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Add1_a : STD_LOGIC_VECTOR (25 downto 0);
    signal Add1_b : STD_LOGIC_VECTOR (25 downto 0);
    signal Add1_o : STD_LOGIC_VECTOR (25 downto 0);
    signal Add1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal Const1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Convert4_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Add1_PreShift_0_q : STD_LOGIC_VECTOR (24 downto 0);
    signal Add1_PreShift_0_qint : STD_LOGIC_VECTOR (24 downto 0);
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
    signal Mult_bjB6_q : STD_LOGIC_VECTOR (18 downto 0);
    signal Mult_bjA8_q : STD_LOGIC_VECTOR (18 downto 0);
    signal Mult_sums_join_0_q : STD_LOGIC_VECTOR (58 downto 0);
    signal Mult_sums_align_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal Mult_sums_align_1_qint : STD_LOGIC_VECTOR (52 downto 0);
    signal Mult_sums_result_add_0_0_a : STD_LOGIC_VECTOR (59 downto 0);
    signal Mult_sums_result_add_0_0_b : STD_LOGIC_VECTOR (59 downto 0);
    signal Mult_sums_result_add_0_0_o : STD_LOGIC_VECTOR (59 downto 0);
    signal Mult_sums_result_add_0_0_q : STD_LOGIC_VECTOR (59 downto 0);
    signal leftShiftStage0Idx1Rng8_uid189_normY_uid20_Divide_in : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx1Rng8_uid189_normY_uid20_Divide_b : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx1_uid190_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0_uid194_normY_uid20_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid194_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx1Rng2_uid196_normY_uid20_Divide_in : STD_LOGIC_VECTOR (13 downto 0);
    signal leftShiftStage1Idx1Rng2_uid196_normY_uid20_Divide_b : STD_LOGIC_VECTOR (13 downto 0);
    signal leftShiftStage1Idx1_uid197_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx2Rng4_uid199_normY_uid20_Divide_in : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx2Rng4_uid199_normY_uid20_Divide_b : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx2_uid200_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx3Pad6_uid201_normY_uid20_Divide_q : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStage1Idx3Rng6_uid202_normY_uid20_Divide_in : STD_LOGIC_VECTOR (9 downto 0);
    signal leftShiftStage1Idx3Rng6_uid202_normY_uid20_Divide_b : STD_LOGIC_VECTOR (9 downto 0);
    signal leftShiftStage1Idx3_uid203_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1_uid205_normY_uid20_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid205_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage2Idx1Rng1_uid207_normY_uid20_Divide_in : STD_LOGIC_VECTOR (14 downto 0);
    signal leftShiftStage2Idx1Rng1_uid207_normY_uid20_Divide_b : STD_LOGIC_VECTOR (14 downto 0);
    signal leftShiftStage2Idx1_uid208_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage2_uid210_normY_uid20_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid210_normY_uid20_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal prodXInvY_uid41_Divide_bjB3_q : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid41_Divide_bjB7_q : STD_LOGIC_VECTOR (16 downto 0);
    signal prodXInvY_uid41_Divide_sums_align_1_q : STD_LOGIC_VECTOR (51 downto 0);
    signal prodXInvY_uid41_Divide_sums_align_1_qint : STD_LOGIC_VECTOR (51 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_a : STD_LOGIC_VECTOR (52 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_b : STD_LOGIC_VECTOR (52 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_o : STD_LOGIC_VECTOR (52 downto 0);
    signal prodXInvY_uid41_Divide_sums_result_add_0_0_q : STD_LOGIC_VECTOR (52 downto 0);
    signal xMSB_uid224_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng1_uid226_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx1_uid227_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to2_uid228_in : STD_LOGIC_VECTOR (1 downto 0);
    signal seMsb_to2_uid228_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0Idx2Rng2_uid229_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx2_uid230_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to3_uid231_in : STD_LOGIC_VECTOR (2 downto 0);
    signal seMsb_to3_uid231_b : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage0Idx3Rng3_uid232_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (46 downto 0);
    signal rightShiftStage0Idx3_uid233_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to4_uid236_in : STD_LOGIC_VECTOR (3 downto 0);
    signal seMsb_to4_uid236_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStage1Idx1Rng4_uid237_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage1Idx1_uid238_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to8_uid239_in : STD_LOGIC_VECTOR (7 downto 0);
    signal seMsb_to8_uid239_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage1Idx2Rng8_uid240_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (41 downto 0);
    signal rightShiftStage1Idx2_uid241_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to12_uid242_in : STD_LOGIC_VECTOR (11 downto 0);
    signal seMsb_to12_uid242_b : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage1Idx3Rng12_uid243_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (37 downto 0);
    signal rightShiftStage1Idx3_uid244_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to16_uid247_in : STD_LOGIC_VECTOR (15 downto 0);
    signal seMsb_to16_uid247_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStage2Idx1Rng16_uid248_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (33 downto 0);
    signal rightShiftStage2Idx1_uid249_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to32_uid250_in : STD_LOGIC_VECTOR (31 downto 0);
    signal seMsb_to32_uid250_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage2Idx2Rng32_uid251_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (17 downto 0);
    signal rightShiftStage2Idx2_uid252_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal seMsb_to48_uid253_in : STD_LOGIC_VECTOR (47 downto 0);
    signal seMsb_to48_uid253_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage2Idx3Rng48_uid254_prodPostRightShift_uid43_Divide_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2Idx3_uid255_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
    signal rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_q : STD_LOGIC_VECTOR (49 downto 0);
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
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_reset : std_logic;
    type prodXY_uid118_pT1_uid100_invPolyEval_cma_ahtype is array(NATURAL range <>) of UNSIGNED(6 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ah : prodXY_uid118_pT1_uid100_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of prodXY_uid118_pT1_uid100_invPolyEval_cma_ah : signal is true;
    type prodXY_uid118_pT1_uid100_invPolyEval_cma_chtype is array(NATURAL range <>) of SIGNED(14 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ch : prodXY_uid118_pT1_uid100_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid118_pT1_uid100_invPolyEval_cma_ch : signal is true;
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (6 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (14 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (21 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (21 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_q : STD_LOGIC_VECTOR (21 downto 0);
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid118_pT1_uid100_invPolyEval_cma_ena2 : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ah : prodXY_uid118_pT1_uid100_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid121_pT2_uid106_invPolyEval_cma_ah : signal is true;
    type prodXY_uid121_pT2_uid106_invPolyEval_cma_chtype is array(NATURAL range <>) of SIGNED(23 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ch : prodXY_uid121_pT2_uid106_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXY_uid121_pT2_uid106_invPolyEval_cma_ch : signal is true;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (6 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (23 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (30 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (30 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_q : STD_LOGIC_VECTOR (30 downto 0);
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid121_pT2_uid106_invPolyEval_cma_ena2 : std_logic;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_reset : std_logic;
    type sm0_uid159_pT3_uid112_invPolyEval_cma_ahtype is array(NATURAL range <>) of SIGNED(17 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ah : sm0_uid159_pT3_uid112_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of sm0_uid159_pT3_uid112_invPolyEval_cma_ah : signal is true;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ch : sm0_uid159_pT3_uid112_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of sm0_uid159_pT3_uid112_invPolyEval_cma_ch : signal is true;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ena0 : std_logic;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ena1 : std_logic;
    signal sm0_uid159_pT3_uid112_invPolyEval_cma_ena2 : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_reset : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ah : sm0_uid159_pT3_uid112_invPolyEval_cma_ahtype(0 to 0);
    attribute preserve_syn_only of sm0_uid160_pT3_uid112_invPolyEval_cma_ah : signal is true;
    type sm0_uid160_pT3_uid112_invPolyEval_cma_chtype is array(NATURAL range <>) of UNSIGNED(17 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ch : sm0_uid160_pT3_uid112_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of sm0_uid160_pT3_uid112_invPolyEval_cma_ch : signal is true;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ena0 : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ena1 : std_logic;
    signal sm0_uid160_pT3_uid112_invPolyEval_cma_ena2 : std_logic;
    signal Mult_im0_cma_reset : std_logic;
    signal Mult_im0_cma_ah : sm0_uid160_pT3_uid112_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of Mult_im0_cma_ah : signal is true;
    signal Mult_im0_cma_ch : sm0_uid160_pT3_uid112_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of Mult_im0_cma_ch : signal is true;
    signal Mult_im0_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_im0_cma_c0 : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal Mult_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal Mult_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal Mult_im0_cma_ena0 : std_logic;
    signal Mult_im0_cma_ena1 : std_logic;
    signal Mult_im0_cma_ena2 : std_logic;
    signal Mult_im10_cma_reset : std_logic;
    signal Mult_im10_cma_ah : prodXY_uid118_pT1_uid100_invPolyEval_cma_chtype(0 to 0);
    attribute preserve_syn_only of Mult_im10_cma_ah : signal is true;
    type Mult_im10_cma_chtype is array(NATURAL range <>) of SIGNED(10 downto 0);
    signal Mult_im10_cma_ch : Mult_im10_cma_chtype(0 to 0);
    attribute preserve_syn_only of Mult_im10_cma_ch : signal is true;
    signal Mult_im10_cma_a0 : STD_LOGIC_VECTOR (14 downto 0);
    signal Mult_im10_cma_c0 : STD_LOGIC_VECTOR (10 downto 0);
    signal Mult_im10_cma_s0 : STD_LOGIC_VECTOR (25 downto 0);
    signal Mult_im10_cma_qq0 : STD_LOGIC_VECTOR (25 downto 0);
    signal Mult_im10_cma_q : STD_LOGIC_VECTOR (22 downto 0);
    signal Mult_im10_cma_ena0 : std_logic;
    signal Mult_im10_cma_ena1 : std_logic;
    signal Mult_im10_cma_ena2 : std_logic;
    signal prodXInvY_uid41_Divide_im0_cma_reset : std_logic;
    type prodXInvY_uid41_Divide_im0_cma_ahtype is array(NATURAL range <>) of SIGNED(16 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_ah : prodXInvY_uid41_Divide_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid41_Divide_im0_cma_ah : signal is true;
    type prodXInvY_uid41_Divide_im0_cma_chtype is array(NATURAL range <>) of SIGNED(18 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_ch : prodXInvY_uid41_Divide_im0_cma_chtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid41_Divide_im0_cma_ch : signal is true;
    signal prodXInvY_uid41_Divide_im0_cma_a0 : STD_LOGIC_VECTOR (16 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_s0 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_qq0 : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_q : STD_LOGIC_VECTOR (35 downto 0);
    signal prodXInvY_uid41_Divide_im0_cma_ena0 : std_logic;
    signal prodXInvY_uid41_Divide_im0_cma_ena1 : std_logic;
    signal prodXInvY_uid41_Divide_im0_cma_ena2 : std_logic;
    signal prodXInvY_uid41_Divide_im4_cma_reset : std_logic;
    type prodXInvY_uid41_Divide_im4_cma_ahtype is array(NATURAL range <>) of SIGNED(15 downto 0);
    signal prodXInvY_uid41_Divide_im4_cma_ah : prodXInvY_uid41_Divide_im4_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid41_Divide_im4_cma_ah : signal is true;
    signal prodXInvY_uid41_Divide_im4_cma_bh : prodXInvY_uid41_Divide_im4_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid41_Divide_im4_cma_bh : signal is true;
    signal prodXInvY_uid41_Divide_im4_cma_ch : prodXInvY_uid41_Divide_im0_cma_ahtype(0 to 0);
    attribute preserve_syn_only of prodXInvY_uid41_Divide_im4_cma_ch : signal is true;
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
    signal Mult_ma3_cma_ah : prodXY_uid118_pT1_uid100_invPolyEval_cma_chtype(0 to 1);
    attribute preserve_syn_only of Mult_ma3_cma_ah : signal is true;
    signal Mult_ma3_cma_ch : prodXInvY_uid41_Divide_im0_cma_chtype(0 to 1);
    attribute preserve_syn_only of Mult_ma3_cma_ch : signal is true;
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
    signal Convert4_rnd_trunc_qint : STD_LOGIC_VECTOR (58 downto 0);
    signal Convert4_rnd_add_a : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_add_b : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_add_o : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_add_q : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_shift_q : STD_LOGIC_VECTOR (34 downto 0);
    signal Convert4_rnd_shift_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal Mult_bs2_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_bs2_bit_select_merged_c : STD_LOGIC_VECTOR (7 downto 0);
    signal yAddr_uid29_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (7 downto 0);
    signal yAddr_uid29_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (6 downto 0);
    signal prodXInvY_uid41_Divide_bs2_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXInvY_uid41_Divide_bs2_bit_select_merged_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_d : STD_LOGIC_VECTOR (1 downto 0);
    signal Mult_bs1_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_bs1_bit_select_merged_c : STD_LOGIC_VECTOR (14 downto 0);
    signal rVStage_uid61_zCount_uid19_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid61_zCount_uid19_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid67_zCount_uid19_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid67_zCount_uid19_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid73_zCount_uid19_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid73_zCount_uid19_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_d : STD_LOGIC_VECTOR (0 downto 0);
    signal topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_b : STD_LOGIC_VECTOR (17 downto 0);
    signal topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_c : STD_LOGIC_VECTOR (13 downto 0);
    signal muxopt_assign_id0_q_const_q : STD_LOGIC_VECTOR (32 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_5_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_3 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_10_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_3 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_15_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_3 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist3_yAddr_uid29_Divide_bit_select_merged_c_2_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_7_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_1 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_2 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_3 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_12_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_1 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_2 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_3 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist7_normYIsOne_uid26_Divide_q_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_xMSB_uid13_Divide_b_17_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_Convert4_sel_x_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_reset0 : std_logic;
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ena_OrRstB : std_logic;
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_iq : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i : signal is true;
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_eq : signal is true;
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist6_r_uid81_zCount_uid19_Divide_q_22_cmpReg_q : signal is true;
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena_q : signal is true;
    signal redist6_r_uid81_zCount_uid19_Divide_q_22_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_reset0 : std_logic;
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ena_OrRstB : std_logic;
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ia : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_aa : STD_LOGIC_VECTOR (4 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ab : STD_LOGIC_VECTOR (4 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_iq : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i : UNSIGNED (4 downto 0);
    attribute preserve_syn_only of redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i : signal is true;
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_eq : signal is true;
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_wraddr_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_last_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_cmp_b : STD_LOGIC_VECTOR (5 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist10_GPIn_in_1_Current_range_int16_tpl_22_cmpReg_q : signal is true;
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena_q : signal is true;
    signal redist10_GPIn_in_1_Current_range_int16_tpl_22_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- Convert4_rnd_bias(CONSTANT,272)
    Convert4_rnd_bias_q <= "01";

    -- Mult_bjB6(BITJOIN,174)@22
    Mult_bjB6_q <= GND_q & Mult_bs2_bit_select_merged_b;

    -- muxopt_assign_id0_q_const(CONSTANT,287)
    muxopt_assign_id0_q_const_q <= "011111111111111111111111111111111";

    -- oneInvRes_uid33_Divide(CONSTANT,32)
    oneInvRes_uid33_Divide_q <= "1000000000000000000000000000000000";

    -- leftShiftStage2Idx1Rng1_uid207_normY_uid20_Divide(BITSELECT,206)@0
    leftShiftStage2Idx1Rng1_uid207_normY_uid20_Divide_in <= leftShiftStage1_uid205_normY_uid20_Divide_q(14 downto 0);
    leftShiftStage2Idx1Rng1_uid207_normY_uid20_Divide_b <= leftShiftStage2Idx1Rng1_uid207_normY_uid20_Divide_in(14 downto 0);

    -- leftShiftStage2Idx1_uid208_normY_uid20_Divide(BITJOIN,207)@0
    leftShiftStage2Idx1_uid208_normY_uid20_Divide_q <= leftShiftStage2Idx1Rng1_uid207_normY_uid20_Divide_b & GND_q;

    -- leftShiftStage1Idx3Rng6_uid202_normY_uid20_Divide(BITSELECT,201)@0
    leftShiftStage1Idx3Rng6_uid202_normY_uid20_Divide_in <= leftShiftStage0_uid194_normY_uid20_Divide_q(9 downto 0);
    leftShiftStage1Idx3Rng6_uid202_normY_uid20_Divide_b <= leftShiftStage1Idx3Rng6_uid202_normY_uid20_Divide_in(9 downto 0);

    -- leftShiftStage1Idx3Pad6_uid201_normY_uid20_Divide(CONSTANT,200)
    leftShiftStage1Idx3Pad6_uid201_normY_uid20_Divide_q <= "000000";

    -- leftShiftStage1Idx3_uid203_normY_uid20_Divide(BITJOIN,202)@0
    leftShiftStage1Idx3_uid203_normY_uid20_Divide_q <= leftShiftStage1Idx3Rng6_uid202_normY_uid20_Divide_b & leftShiftStage1Idx3Pad6_uid201_normY_uid20_Divide_q;

    -- leftShiftStage1Idx2Rng4_uid199_normY_uid20_Divide(BITSELECT,198)@0
    leftShiftStage1Idx2Rng4_uid199_normY_uid20_Divide_in <= leftShiftStage0_uid194_normY_uid20_Divide_q(11 downto 0);
    leftShiftStage1Idx2Rng4_uid199_normY_uid20_Divide_b <= leftShiftStage1Idx2Rng4_uid199_normY_uid20_Divide_in(11 downto 0);

    -- leftShiftStage1Idx2_uid200_normY_uid20_Divide(BITJOIN,199)@0
    leftShiftStage1Idx2_uid200_normY_uid20_Divide_q <= leftShiftStage1Idx2Rng4_uid199_normY_uid20_Divide_b & zs_uid66_zCount_uid19_Divide_q;

    -- leftShiftStage1Idx1Rng2_uid196_normY_uid20_Divide(BITSELECT,195)@0
    leftShiftStage1Idx1Rng2_uid196_normY_uid20_Divide_in <= leftShiftStage0_uid194_normY_uid20_Divide_q(13 downto 0);
    leftShiftStage1Idx1Rng2_uid196_normY_uid20_Divide_b <= leftShiftStage1Idx1Rng2_uid196_normY_uid20_Divide_in(13 downto 0);

    -- zs_uid72_zCount_uid19_Divide(CONSTANT,71)
    zs_uid72_zCount_uid19_Divide_q <= "00";

    -- leftShiftStage1Idx1_uid197_normY_uid20_Divide(BITJOIN,196)@0
    leftShiftStage1Idx1_uid197_normY_uid20_Divide_q <= leftShiftStage1Idx1Rng2_uid196_normY_uid20_Divide_b & zs_uid72_zCount_uid19_Divide_q;

    -- zs_uid54_zCount_uid19_Divide(CONSTANT,53)
    zs_uid54_zCount_uid19_Divide_q <= "0000000000000000";

    -- leftShiftStage0Idx1Rng8_uid189_normY_uid20_Divide(BITSELECT,188)@0
    leftShiftStage0Idx1Rng8_uid189_normY_uid20_Divide_in <= yPS_uid18_Divide_b(7 downto 0);
    leftShiftStage0Idx1Rng8_uid189_normY_uid20_Divide_b <= leftShiftStage0Idx1Rng8_uid189_normY_uid20_Divide_in(7 downto 0);

    -- zs_uid60_zCount_uid19_Divide(CONSTANT,59)
    zs_uid60_zCount_uid19_Divide_q <= "00000000";

    -- leftShiftStage0Idx1_uid190_normY_uid20_Divide(BITJOIN,189)@0
    leftShiftStage0Idx1_uid190_normY_uid20_Divide_q <= leftShiftStage0Idx1Rng8_uid189_normY_uid20_Divide_b & zs_uid60_zCount_uid19_Divide_q;

    -- xMSB_uid13_Divide(BITSELECT,12)@0
    xMSB_uid13_Divide_b <= STD_LOGIC_VECTOR(in_1_Current_range_int16_tpl(15 downto 15));

    -- yPSE_uid15_Divide(LOGICAL,14)@0
    yPSE_uid15_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => xMSB_uid13_Divide_b(0)) & xMSB_uid13_Divide_b));
    yPSE_uid15_Divide_q <= in_1_Current_range_int16_tpl xor yPSE_uid15_Divide_b;

    -- yPSEA_uid17_Divide(ADD,16)@0
    yPSEA_uid17_Divide_a <= STD_LOGIC_VECTOR("0" & yPSE_uid15_Divide_q);
    yPSEA_uid17_Divide_b <= STD_LOGIC_VECTOR("0000000000000000" & xMSB_uid13_Divide_b);
    yPSEA_uid17_Divide_o <= STD_LOGIC_VECTOR(UNSIGNED(yPSEA_uid17_Divide_a) + UNSIGNED(yPSEA_uid17_Divide_b));
    yPSEA_uid17_Divide_q <= yPSEA_uid17_Divide_o(16 downto 0);

    -- yPS_uid18_Divide(BITSELECT,17)@0
    yPS_uid18_Divide_in <= STD_LOGIC_VECTOR(yPSEA_uid17_Divide_q(15 downto 0));
    yPS_uid18_Divide_b <= STD_LOGIC_VECTOR(yPS_uid18_Divide_in(15 downto 0));

    -- leftShiftStage0_uid194_normY_uid20_Divide(MUX,193)@0
    leftShiftStage0_uid194_normY_uid20_Divide_s <= leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_b;
    leftShiftStage0_uid194_normY_uid20_Divide_combproc: PROCESS (leftShiftStage0_uid194_normY_uid20_Divide_s, yPS_uid18_Divide_b, leftShiftStage0Idx1_uid190_normY_uid20_Divide_q, zs_uid54_zCount_uid19_Divide_q)
    BEGIN
        CASE (leftShiftStage0_uid194_normY_uid20_Divide_s) IS
            WHEN "00" => leftShiftStage0_uid194_normY_uid20_Divide_q <= yPS_uid18_Divide_b;
            WHEN "01" => leftShiftStage0_uid194_normY_uid20_Divide_q <= leftShiftStage0Idx1_uid190_normY_uid20_Divide_q;
            WHEN "10" => leftShiftStage0_uid194_normY_uid20_Divide_q <= zs_uid54_zCount_uid19_Divide_q;
            WHEN "11" => leftShiftStage0_uid194_normY_uid20_Divide_q <= zs_uid54_zCount_uid19_Divide_q;
            WHEN OTHERS => leftShiftStage0_uid194_normY_uid20_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid205_normY_uid20_Divide(MUX,204)@0
    leftShiftStage1_uid205_normY_uid20_Divide_s <= leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_c;
    leftShiftStage1_uid205_normY_uid20_Divide_combproc: PROCESS (leftShiftStage1_uid205_normY_uid20_Divide_s, leftShiftStage0_uid194_normY_uid20_Divide_q, leftShiftStage1Idx1_uid197_normY_uid20_Divide_q, leftShiftStage1Idx2_uid200_normY_uid20_Divide_q, leftShiftStage1Idx3_uid203_normY_uid20_Divide_q)
    BEGIN
        CASE (leftShiftStage1_uid205_normY_uid20_Divide_s) IS
            WHEN "00" => leftShiftStage1_uid205_normY_uid20_Divide_q <= leftShiftStage0_uid194_normY_uid20_Divide_q;
            WHEN "01" => leftShiftStage1_uid205_normY_uid20_Divide_q <= leftShiftStage1Idx1_uid197_normY_uid20_Divide_q;
            WHEN "10" => leftShiftStage1_uid205_normY_uid20_Divide_q <= leftShiftStage1Idx2_uid200_normY_uid20_Divide_q;
            WHEN "11" => leftShiftStage1_uid205_normY_uid20_Divide_q <= leftShiftStage1Idx3_uid203_normY_uid20_Divide_q;
            WHEN OTHERS => leftShiftStage1_uid205_normY_uid20_Divide_q <= (others => '0');
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

    -- rVStage_uid61_zCount_uid19_Divide_bit_select_merged(BITSELECT,282)@0
    rVStage_uid61_zCount_uid19_Divide_bit_select_merged_b <= vStagei_uid59_zCount_uid19_Divide_q(15 downto 8);
    rVStage_uid61_zCount_uid19_Divide_bit_select_merged_c <= vStagei_uid59_zCount_uid19_Divide_q(7 downto 0);

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

    -- rVStage_uid67_zCount_uid19_Divide_bit_select_merged(BITSELECT,283)@0
    rVStage_uid67_zCount_uid19_Divide_bit_select_merged_b <= vStagei_uid65_zCount_uid19_Divide_q(7 downto 4);
    rVStage_uid67_zCount_uid19_Divide_bit_select_merged_c <= vStagei_uid65_zCount_uid19_Divide_q(3 downto 0);

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

    -- rVStage_uid73_zCount_uid19_Divide_bit_select_merged(BITSELECT,284)@0
    rVStage_uid73_zCount_uid19_Divide_bit_select_merged_b <= vStagei_uid71_zCount_uid19_Divide_q(3 downto 2);
    rVStage_uid73_zCount_uid19_Divide_bit_select_merged_c <= vStagei_uid71_zCount_uid19_Divide_q(1 downto 0);

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
    rVStage_uid79_zCount_uid19_Divide_b <= vStagei_uid77_zCount_uid19_Divide_q(1 downto 1);

    -- vCount_uid80_zCount_uid19_Divide(LOGICAL,79)@0
    vCount_uid80_zCount_uid19_Divide_q <= "1" WHEN rVStage_uid79_zCount_uid19_Divide_b = GND_q ELSE "0";

    -- r_uid81_zCount_uid19_Divide(BITJOIN,80)@0
    r_uid81_zCount_uid19_Divide_q <= vCount_uid56_zCount_uid19_Divide_q & vCount_uid62_zCount_uid19_Divide_q & vCount_uid68_zCount_uid19_Divide_q & vCount_uid74_zCount_uid19_Divide_q & vCount_uid80_zCount_uid19_Divide_q;

    -- leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged(BITSELECT,285)@0
    leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_b <= r_uid81_zCount_uid19_Divide_q(4 downto 3);
    leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_c <= r_uid81_zCount_uid19_Divide_q(2 downto 1);
    leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_d <= r_uid81_zCount_uid19_Divide_q(0 downto 0);

    -- leftShiftStage2_uid210_normY_uid20_Divide(MUX,209)@0
    leftShiftStage2_uid210_normY_uid20_Divide_s <= leftShiftStageSel0Dto3_uid193_normY_uid20_Divide_bit_select_merged_d;
    leftShiftStage2_uid210_normY_uid20_Divide_combproc: PROCESS (leftShiftStage2_uid210_normY_uid20_Divide_s, leftShiftStage1_uid205_normY_uid20_Divide_q, leftShiftStage2Idx1_uid208_normY_uid20_Divide_q)
    BEGIN
        CASE (leftShiftStage2_uid210_normY_uid20_Divide_s) IS
            WHEN "0" => leftShiftStage2_uid210_normY_uid20_Divide_q <= leftShiftStage1_uid205_normY_uid20_Divide_q;
            WHEN "1" => leftShiftStage2_uid210_normY_uid20_Divide_q <= leftShiftStage2Idx1_uid208_normY_uid20_Divide_q;
            WHEN OTHERS => leftShiftStage2_uid210_normY_uid20_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- normYNoLeadOne_uid21_Divide(BITSELECT,20)@0
    normYNoLeadOne_uid21_Divide_in <= leftShiftStage2_uid210_normY_uid20_Divide_q(14 downto 0);
    normYNoLeadOne_uid21_Divide_b <= normYNoLeadOne_uid21_Divide_in(14 downto 0);

    -- yAddr_uid29_Divide_bit_select_merged(BITSELECT,278)@0
    yAddr_uid29_Divide_bit_select_merged_b <= normYNoLeadOne_uid21_Divide_b(14 downto 7);
    yAddr_uid29_Divide_bit_select_merged_c <= normYNoLeadOne_uid21_Divide_b(6 downto 0);

    -- memoryC3_uid92_invTabGen_lutmem(DUALMEM,262)@0 + 2
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
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Current_scale_64_2_memoryC3_uid92_invTabGen_lutmem.hex"),
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
    memoryC3_uid92_invTabGen_lutmem_r <= memoryC3_uid92_invTabGen_lutmem_ir(14 downto 0);

    -- redist3_yAddr_uid29_Divide_bit_select_merged_c_2(DELAY,291)
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
                redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q <= redist3_yAddr_uid29_Divide_bit_select_merged_c_2_delay_0;
            END IF;
        END IF;
    END PROCESS;

    -- prodXY_uid118_pT1_uid100_invPolyEval_cma(CHAINMULTADD,263)@2 + 4
    -- out q@7
    prodXY_uid118_pT1_uid100_invPolyEval_cma_reset <= areset;
    prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0 <= '1';
    prodXY_uid118_pT1_uid100_invPolyEval_cma_ena1 <= prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0;
    prodXY_uid118_pT1_uid100_invPolyEval_cma_ena2 <= prodXY_uid118_pT1_uid100_invPolyEval_cma_ena0;
    prodXY_uid118_pT1_uid100_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                prodXY_uid118_pT1_uid100_invPolyEval_cma_ah(0) <= (others => '0');
                prodXY_uid118_pT1_uid100_invPolyEval_cma_ch(0) <= (others => '0');
            ELSE
                prodXY_uid118_pT1_uid100_invPolyEval_cma_ah(0) <= RESIZE(UNSIGNED(redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q),7);
                prodXY_uid118_pT1_uid100_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(memoryC3_uid92_invTabGen_lutmem_r),15);
            END IF;
        END IF;
    END PROCESS;

    prodXY_uid118_pT1_uid100_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(prodXY_uid118_pT1_uid100_invPolyEval_cma_ah(0));
    prodXY_uid118_pT1_uid100_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(prodXY_uid118_pT1_uid100_invPolyEval_cma_ch(0));
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

    -- osig_uid119_pT1_uid100_invPolyEval(BITSELECT,118)@7
    osig_uid119_pT1_uid100_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid118_pT1_uid100_invPolyEval_cma_q(21 downto 7));

    -- highBBits_uid102_invPolyEval(BITSELECT,101)@7
    highBBits_uid102_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid119_pT1_uid100_invPolyEval_b(14 downto 1));

    -- redist0_yAddr_uid29_Divide_bit_select_merged_b_5(DELAY,288)
    redist0_yAddr_uid29_Divide_bit_select_merged_b_5_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_0 <= (others => '0');
            ELSE
                redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_0 <= STD_LOGIC_VECTOR(yAddr_uid29_Divide_bit_select_merged_b);
            END IF;
        END IF;
    END PROCESS;
    redist0_yAddr_uid29_Divide_bit_select_merged_b_5_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_1 <= redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_0;
                redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_2 <= redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_1;
                redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_3 <= redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_2;
                redist0_yAddr_uid29_Divide_bit_select_merged_b_5_q <= redist0_yAddr_uid29_Divide_bit_select_merged_b_5_delay_3;
            END IF;
        END IF;
    END PROCESS;

    -- memoryC2_uid89_invTabGen_lutmem(DUALMEM,261)@5 + 2
    memoryC2_uid89_invTabGen_lutmem_aa <= redist0_yAddr_uid29_Divide_bit_select_merged_b_5_q;
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
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Current_scale_64_2_memoryC2_uid89_invTabGen_lutmem.hex"),
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
    memoryC2_uid89_invTabGen_lutmem_r <= memoryC2_uid89_invTabGen_lutmem_ir(21 downto 0);

    -- s1sumAHighB_uid103_invPolyEval(ADD,102)@7
    s1sumAHighB_uid103_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 22 => memoryC2_uid89_invTabGen_lutmem_r(21)) & memoryC2_uid89_invTabGen_lutmem_r));
    s1sumAHighB_uid103_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((22 downto 14 => highBBits_uid102_invPolyEval_b(13)) & highBBits_uid102_invPolyEval_b));
    s1sumAHighB_uid103_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid103_invPolyEval_a) + SIGNED(s1sumAHighB_uid103_invPolyEval_b));
    s1sumAHighB_uid103_invPolyEval_q <= s1sumAHighB_uid103_invPolyEval_o(22 downto 0);

    -- lowRangeB_uid101_invPolyEval(BITSELECT,100)@7
    lowRangeB_uid101_invPolyEval_in <= osig_uid119_pT1_uid100_invPolyEval_b(0 downto 0);
    lowRangeB_uid101_invPolyEval_b <= lowRangeB_uid101_invPolyEval_in(0 downto 0);

    -- s1_uid104_invPolyEval(BITJOIN,103)@7
    s1_uid104_invPolyEval_q <= s1sumAHighB_uid103_invPolyEval_q & lowRangeB_uid101_invPolyEval_b;

    -- redist4_yAddr_uid29_Divide_bit_select_merged_c_7(DELAY,292)
    redist4_yAddr_uid29_Divide_bit_select_merged_c_7_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_0 <= (others => '0');
            ELSE
                redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_0 <= STD_LOGIC_VECTOR(redist3_yAddr_uid29_Divide_bit_select_merged_c_2_q);
            END IF;
        END IF;
    END PROCESS;
    redist4_yAddr_uid29_Divide_bit_select_merged_c_7_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_1 <= redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_0;
                redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_2 <= redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_1;
                redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_3 <= redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_2;
                redist4_yAddr_uid29_Divide_bit_select_merged_c_7_q <= redist4_yAddr_uid29_Divide_bit_select_merged_c_7_delay_3;
            END IF;
        END IF;
    END PROCESS;

    -- prodXY_uid121_pT2_uid106_invPolyEval_cma(CHAINMULTADD,264)@7 + 4
    -- out q@12
    prodXY_uid121_pT2_uid106_invPolyEval_cma_reset <= areset;
    prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0 <= '1';
    prodXY_uid121_pT2_uid106_invPolyEval_cma_ena1 <= prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0;
    prodXY_uid121_pT2_uid106_invPolyEval_cma_ena2 <= prodXY_uid121_pT2_uid106_invPolyEval_cma_ena0;
    prodXY_uid121_pT2_uid106_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                prodXY_uid121_pT2_uid106_invPolyEval_cma_ah(0) <= (others => '0');
                prodXY_uid121_pT2_uid106_invPolyEval_cma_ch(0) <= (others => '0');
            ELSE
                prodXY_uid121_pT2_uid106_invPolyEval_cma_ah(0) <= RESIZE(UNSIGNED(redist4_yAddr_uid29_Divide_bit_select_merged_c_7_q),7);
                prodXY_uid121_pT2_uid106_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(s1_uid104_invPolyEval_q),24);
            END IF;
        END IF;
    END PROCESS;

    prodXY_uid121_pT2_uid106_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(prodXY_uid121_pT2_uid106_invPolyEval_cma_ah(0));
    prodXY_uid121_pT2_uid106_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(prodXY_uid121_pT2_uid106_invPolyEval_cma_ch(0));
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

    -- osig_uid122_pT2_uid106_invPolyEval(BITSELECT,121)@12
    osig_uid122_pT2_uid106_invPolyEval_b <= STD_LOGIC_VECTOR(prodXY_uid121_pT2_uid106_invPolyEval_cma_q(30 downto 7));

    -- highBBits_uid108_invPolyEval(BITSELECT,107)@12
    highBBits_uid108_invPolyEval_b <= STD_LOGIC_VECTOR(osig_uid122_pT2_uid106_invPolyEval_b(23 downto 1));

    -- redist1_yAddr_uid29_Divide_bit_select_merged_b_10(DELAY,289)
    redist1_yAddr_uid29_Divide_bit_select_merged_b_10_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_0 <= (others => '0');
            ELSE
                redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_0 <= STD_LOGIC_VECTOR(redist0_yAddr_uid29_Divide_bit_select_merged_b_5_q);
            END IF;
        END IF;
    END PROCESS;
    redist1_yAddr_uid29_Divide_bit_select_merged_b_10_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_1 <= redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_0;
                redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_2 <= redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_1;
                redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_3 <= redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_2;
                redist1_yAddr_uid29_Divide_bit_select_merged_b_10_q <= redist1_yAddr_uid29_Divide_bit_select_merged_b_10_delay_3;
            END IF;
        END IF;
    END PROCESS;

    -- memoryC1_uid86_invTabGen_lutmem(DUALMEM,260)@10 + 2
    memoryC1_uid86_invTabGen_lutmem_aa <= redist1_yAddr_uid29_Divide_bit_select_merged_b_10_q;
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
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Current_scale_64_2_memoryC1_uid86_invTabGen_lutmem.hex"),
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
    memoryC1_uid86_invTabGen_lutmem_r <= memoryC1_uid86_invTabGen_lutmem_ir(29 downto 0);

    -- s2sumAHighB_uid109_invPolyEval(ADD,108)@12
    s2sumAHighB_uid109_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => memoryC1_uid86_invTabGen_lutmem_r(29)) & memoryC1_uid86_invTabGen_lutmem_r));
    s2sumAHighB_uid109_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 23 => highBBits_uid108_invPolyEval_b(22)) & highBBits_uid108_invPolyEval_b));
    s2sumAHighB_uid109_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid109_invPolyEval_a) + SIGNED(s2sumAHighB_uid109_invPolyEval_b));
    s2sumAHighB_uid109_invPolyEval_q <= s2sumAHighB_uid109_invPolyEval_o(30 downto 0);

    -- lowRangeB_uid107_invPolyEval(BITSELECT,106)@12
    lowRangeB_uid107_invPolyEval_in <= osig_uid122_pT2_uid106_invPolyEval_b(0 downto 0);
    lowRangeB_uid107_invPolyEval_b <= lowRangeB_uid107_invPolyEval_in(0 downto 0);

    -- s2_uid110_invPolyEval(BITJOIN,109)@12
    s2_uid110_invPolyEval_q <= s2sumAHighB_uid109_invPolyEval_q & lowRangeB_uid107_invPolyEval_b;

    -- topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged(BITSELECT,286)@12
    topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_b <= STD_LOGIC_VECTOR(s2_uid110_invPolyEval_q(31 downto 14));
    topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_c <= STD_LOGIC_VECTOR(s2_uid110_invPolyEval_q(13 downto 0));

    -- zs_uid66_zCount_uid19_Divide(CONSTANT,65)
    zs_uid66_zCount_uid19_Divide_q <= "0000";

    -- aboveLeftY_mergedSignalTM_uid154_pT3_uid112_invPolyEval(BITJOIN,153)@12
    aboveLeftY_mergedSignalTM_uid154_pT3_uid112_invPolyEval_q <= topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_c & zs_uid66_zCount_uid19_Divide_q;

    -- redist5_yAddr_uid29_Divide_bit_select_merged_c_12(DELAY,293)
    redist5_yAddr_uid29_Divide_bit_select_merged_c_12_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_0 <= (others => '0');
            ELSE
                redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_0 <= STD_LOGIC_VECTOR(redist4_yAddr_uid29_Divide_bit_select_merged_c_7_q);
            END IF;
        END IF;
    END PROCESS;
    redist5_yAddr_uid29_Divide_bit_select_merged_c_12_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_1 <= redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_0;
                redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_2 <= redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_1;
                redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_3 <= redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_2;
                redist5_yAddr_uid29_Divide_bit_select_merged_c_12_q <= redist5_yAddr_uid29_Divide_bit_select_merged_c_12_delay_3;
            END IF;
        END IF;
    END PROCESS;

    -- nx_mergedSignalTM_uid141_pT3_uid112_invPolyEval(BITJOIN,140)@12
    nx_mergedSignalTM_uid141_pT3_uid112_invPolyEval_q <= GND_q & redist5_yAddr_uid29_Divide_bit_select_merged_c_12_q;

    -- topRangeX_bottomExtension_uid143_pT3_uid112_invPolyEval(CONSTANT,142)
    topRangeX_bottomExtension_uid143_pT3_uid112_invPolyEval_q <= "0000000000";

    -- topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval(BITJOIN,144)@12
    topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval_q <= nx_mergedSignalTM_uid141_pT3_uid112_invPolyEval_q & topRangeX_bottomExtension_uid143_pT3_uid112_invPolyEval_q;

    -- sm0_uid160_pT3_uid112_invPolyEval_cma(CHAINMULTADD,266)@12 + 4
    -- out q@17
    sm0_uid160_pT3_uid112_invPolyEval_cma_reset <= areset;
    sm0_uid160_pT3_uid112_invPolyEval_cma_ena0 <= '1';
    sm0_uid160_pT3_uid112_invPolyEval_cma_ena1 <= sm0_uid160_pT3_uid112_invPolyEval_cma_ena0;
    sm0_uid160_pT3_uid112_invPolyEval_cma_ena2 <= sm0_uid160_pT3_uid112_invPolyEval_cma_ena0;
    sm0_uid160_pT3_uid112_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                sm0_uid160_pT3_uid112_invPolyEval_cma_ah(0) <= (others => '0');
                sm0_uid160_pT3_uid112_invPolyEval_cma_ch(0) <= (others => '0');
            ELSE
                sm0_uid160_pT3_uid112_invPolyEval_cma_ah(0) <= RESIZE(SIGNED(topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval_q),18);
                sm0_uid160_pT3_uid112_invPolyEval_cma_ch(0) <= RESIZE(UNSIGNED(aboveLeftY_mergedSignalTM_uid154_pT3_uid112_invPolyEval_q),18);
            END IF;
        END IF;
    END PROCESS;

    sm0_uid160_pT3_uid112_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(sm0_uid160_pT3_uid112_invPolyEval_cma_ah(0));
    sm0_uid160_pT3_uid112_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(sm0_uid160_pT3_uid112_invPolyEval_cma_ch(0));
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

    -- highBBits_uid162_pT3_uid112_invPolyEval(BITSELECT,161)@17
    highBBits_uid162_pT3_uid112_invPolyEval_b <= STD_LOGIC_VECTOR(sm0_uid160_pT3_uid112_invPolyEval_cma_q(35 downto 18));

    -- sm0_uid159_pT3_uid112_invPolyEval_cma(CHAINMULTADD,265)@12 + 4
    -- out q@17
    sm0_uid159_pT3_uid112_invPolyEval_cma_reset <= areset;
    sm0_uid159_pT3_uid112_invPolyEval_cma_ena0 <= '1';
    sm0_uid159_pT3_uid112_invPolyEval_cma_ena1 <= sm0_uid159_pT3_uid112_invPolyEval_cma_ena0;
    sm0_uid159_pT3_uid112_invPolyEval_cma_ena2 <= sm0_uid159_pT3_uid112_invPolyEval_cma_ena0;
    sm0_uid159_pT3_uid112_invPolyEval_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                sm0_uid159_pT3_uid112_invPolyEval_cma_ah(0) <= (others => '0');
                sm0_uid159_pT3_uid112_invPolyEval_cma_ch(0) <= (others => '0');
            ELSE
                sm0_uid159_pT3_uid112_invPolyEval_cma_ah(0) <= RESIZE(SIGNED(topRangeX_mergedSignalTM_uid145_pT3_uid112_invPolyEval_q),18);
                sm0_uid159_pT3_uid112_invPolyEval_cma_ch(0) <= RESIZE(SIGNED(topRangeY_uid147_pT3_uid112_invPolyEval_bit_select_merged_b),18);
            END IF;
        END IF;
    END PROCESS;

    sm0_uid159_pT3_uid112_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(sm0_uid159_pT3_uid112_invPolyEval_cma_ah(0));
    sm0_uid159_pT3_uid112_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(sm0_uid159_pT3_uid112_invPolyEval_cma_ch(0));
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

    -- lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval(ADD,162)@17
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 36 => sm0_uid159_pT3_uid112_invPolyEval_cma_q(35)) & sm0_uid159_pT3_uid112_invPolyEval_cma_q));
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((36 downto 18 => highBBits_uid162_pT3_uid112_invPolyEval_b(17)) & highBBits_uid162_pT3_uid112_invPolyEval_b));
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_a) + SIGNED(lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_b));
    lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_q <= lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_o(36 downto 0);

    -- lowRangeB_uid161_pT3_uid112_invPolyEval(BITSELECT,160)@17
    lowRangeB_uid161_pT3_uid112_invPolyEval_in <= sm0_uid160_pT3_uid112_invPolyEval_cma_q(17 downto 0);
    lowRangeB_uid161_pT3_uid112_invPolyEval_b <= lowRangeB_uid161_pT3_uid112_invPolyEval_in(17 downto 0);

    -- lev1_a0_uid164_pT3_uid112_invPolyEval(BITJOIN,163)@17
    lev1_a0_uid164_pT3_uid112_invPolyEval_q <= lev1_a0sumAHighB_uid163_pT3_uid112_invPolyEval_q & lowRangeB_uid161_pT3_uid112_invPolyEval_b;

    -- os_uid165_pT3_uid112_invPolyEval(BITSELECT,164)@17
    os_uid165_pT3_uid112_invPolyEval_in <= STD_LOGIC_VECTOR(lev1_a0_uid164_pT3_uid112_invPolyEval_q(52 downto 0));
    os_uid165_pT3_uid112_invPolyEval_b <= STD_LOGIC_VECTOR(os_uid165_pT3_uid112_invPolyEval_in(52 downto 20));

    -- highBBits_uid114_invPolyEval(BITSELECT,113)@17
    highBBits_uid114_invPolyEval_b <= STD_LOGIC_VECTOR(os_uid165_pT3_uid112_invPolyEval_b(32 downto 2));

    -- redist2_yAddr_uid29_Divide_bit_select_merged_b_15(DELAY,290)
    redist2_yAddr_uid29_Divide_bit_select_merged_b_15_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_0 <= (others => '0');
            ELSE
                redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_0 <= STD_LOGIC_VECTOR(redist1_yAddr_uid29_Divide_bit_select_merged_b_10_q);
            END IF;
        END IF;
    END PROCESS;
    redist2_yAddr_uid29_Divide_bit_select_merged_b_15_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_1 <= redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_0;
                redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_2 <= redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_1;
                redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_3 <= redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_2;
                redist2_yAddr_uid29_Divide_bit_select_merged_b_15_q <= redist2_yAddr_uid29_Divide_bit_select_merged_b_15_delay_3;
            END IF;
        END IF;
    END PROCESS;

    -- memoryC0_uid83_invTabGen_lutmem(DUALMEM,259)@15 + 2
    memoryC0_uid83_invTabGen_lutmem_aa <= redist2_yAddr_uid29_Divide_bit_select_merged_b_15_q;
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
        init_file => safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Current_scale_64_2_memoryC0_uid83_invTabGen_lutmem.hex"),
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
    memoryC0_uid83_invTabGen_lutmem_r <= memoryC0_uid83_invTabGen_lutmem_ir(38 downto 0);

    -- s3sumAHighB_uid115_invPolyEval(ADD,114)@17
    s3sumAHighB_uid115_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 39 => memoryC0_uid83_invTabGen_lutmem_r(38)) & memoryC0_uid83_invTabGen_lutmem_r));
    s3sumAHighB_uid115_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((39 downto 31 => highBBits_uid114_invPolyEval_b(30)) & highBBits_uid114_invPolyEval_b));
    s3sumAHighB_uid115_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s3sumAHighB_uid115_invPolyEval_a) + SIGNED(s3sumAHighB_uid115_invPolyEval_b));
    s3sumAHighB_uid115_invPolyEval_q <= s3sumAHighB_uid115_invPolyEval_o(39 downto 0);

    -- lowRangeB_uid113_invPolyEval(BITSELECT,112)@17
    lowRangeB_uid113_invPolyEval_in <= os_uid165_pT3_uid112_invPolyEval_b(1 downto 0);
    lowRangeB_uid113_invPolyEval_b <= lowRangeB_uid113_invPolyEval_in(1 downto 0);

    -- s3_uid116_invPolyEval(BITJOIN,115)@17
    s3_uid116_invPolyEval_q <= s3sumAHighB_uid115_invPolyEval_q & lowRangeB_uid113_invPolyEval_b;

    -- fxpInverseRes_uid32_Divide(BITSELECT,31)@17
    fxpInverseRes_uid32_Divide_in <= s3_uid116_invPolyEval_q(39 downto 0);
    fxpInverseRes_uid32_Divide_b <= fxpInverseRes_uid32_Divide_in(39 downto 6);

    -- normYIsOneC2_uid22_Divide(LOGICAL,23)@0
    normYIsOneC2_uid22_Divide_a <= STD_LOGIC_VECTOR("0" & normYNoLeadOne_uid21_Divide_b);
    normYIsOneC2_uid22_Divide_q <= "1" WHEN normYIsOneC2_uid22_Divide_a = zs_uid54_zCount_uid19_Divide_q ELSE "0";

    -- normYIsOneC2_uid25_Divide(BITSELECT,24)@0
    normYIsOneC2_uid25_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage2_uid210_normY_uid20_Divide_q(15 downto 15));

    -- normYIsOne_uid26_Divide(LOGICAL,25)@0 + 1
    normYIsOne_uid26_Divide_qi <= normYIsOneC2_uid25_Divide_b and normYIsOneC2_uid22_Divide_q;
    normYIsOne_uid26_Divide_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => normYIsOne_uid26_Divide_qi, xout => normYIsOne_uid26_Divide_q, clk => clk, aclr => areset, ena => '1' );

    -- redist7_normYIsOne_uid26_Divide_q_17(DELAY,295)
    redist7_normYIsOne_uid26_Divide_q_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 16, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => normYIsOne_uid26_Divide_q, xout => redist7_normYIsOne_uid26_Divide_q_17_q, clk => clk, aclr => areset, ena => '1' );

    -- invResPostOneHandling2_uid34_Divide(MUX,33)@17
    invResPostOneHandling2_uid34_Divide_s <= redist7_normYIsOne_uid26_Divide_q_17_q;
    invResPostOneHandling2_uid34_Divide_combproc: PROCESS (invResPostOneHandling2_uid34_Divide_s, fxpInverseRes_uid32_Divide_b, oneInvRes_uid33_Divide_q)
    BEGIN
        CASE (invResPostOneHandling2_uid34_Divide_s) IS
            WHEN "0" => invResPostOneHandling2_uid34_Divide_q <= fxpInverseRes_uid32_Divide_b;
            WHEN "1" => invResPostOneHandling2_uid34_Divide_q <= oneInvRes_uid33_Divide_q;
            WHEN OTHERS => invResPostOneHandling2_uid34_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- prodXInvY_uid41_Divide_bs2_bit_select_merged(BITSELECT,279)@17
    prodXInvY_uid41_Divide_bs2_bit_select_merged_b <= invResPostOneHandling2_uid34_Divide_q(17 downto 0);
    prodXInvY_uid41_Divide_bs2_bit_select_merged_c <= invResPostOneHandling2_uid34_Divide_q(33 downto 18);

    -- prodXInvY_uid41_Divide_bjB7(BITJOIN,218)@17
    prodXInvY_uid41_Divide_bjB7_q <= GND_q & prodXInvY_uid41_Divide_bs2_bit_select_merged_c;

    -- redist8_xMSB_uid13_Divide_b_17(DELAY,296)
    redist8_xMSB_uid13_Divide_b_17 : dspba_delay
    GENERIC MAP ( width => 1, depth => 17, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => xMSB_uid13_Divide_b, xout => redist8_xMSB_uid13_Divide_b_17_q, clk => clk, aclr => areset, ena => '1' );

    -- Const1(CONSTANT,3)
    Const1_q <= "0111111111111111";

    -- xPSX_uid37_Divide(LOGICAL,36)@17
    xPSX_uid37_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => redist8_xMSB_uid13_Divide_b_17_q(0)) & redist8_xMSB_uid13_Divide_b_17_q));
    xPSX_uid37_Divide_q <= Const1_q xor xPSX_uid37_Divide_b;

    -- zMsbY0_uid39_Divide(BITJOIN,38)@17
    zMsbY0_uid39_Divide_q <= GND_q & redist8_xMSB_uid13_Divide_b_17_q;

    -- prodXInvY_uid41_Divide_im4_cma(CHAINMULTADD,270)@17 + 4
    -- out q@22
    prodXInvY_uid41_Divide_im4_cma_reset <= areset;
    prodXInvY_uid41_Divide_im4_cma_ena0 <= '1';
    prodXInvY_uid41_Divide_im4_cma_ena1 <= prodXInvY_uid41_Divide_im4_cma_ena0;
    prodXInvY_uid41_Divide_im4_cma_ena2 <= prodXInvY_uid41_Divide_im4_cma_ena0;
    prodXInvY_uid41_Divide_im4_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                prodXInvY_uid41_Divide_im4_cma_ah(0) <= (others => '0');
                prodXInvY_uid41_Divide_im4_cma_bh(0) <= (others => '0');
                prodXInvY_uid41_Divide_im4_cma_ch(0) <= (others => '0');
            ELSE
                prodXInvY_uid41_Divide_im4_cma_ah(0) <= RESIZE(SIGNED(zMsbY0_uid39_Divide_q),16);
                prodXInvY_uid41_Divide_im4_cma_bh(0) <= RESIZE(SIGNED(xPSX_uid37_Divide_q),16);
                prodXInvY_uid41_Divide_im4_cma_ch(0) <= RESIZE(SIGNED(prodXInvY_uid41_Divide_bjB7_q),17);
            END IF;
        END IF;
    END PROCESS;

    prodXInvY_uid41_Divide_im4_cma_a0 <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_im4_cma_ah(0));
    prodXInvY_uid41_Divide_im4_cma_b0 <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_im4_cma_bh(0));
    prodXInvY_uid41_Divide_im4_cma_c0 <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_im4_cma_ch(0));
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

    -- prodXInvY_uid41_Divide_sums_align_1(BITSHIFT,220)@22
    prodXInvY_uid41_Divide_sums_align_1_qint <= prodXInvY_uid41_Divide_im4_cma_q & "000000000000000000";
    prodXInvY_uid41_Divide_sums_align_1_q <= prodXInvY_uid41_Divide_sums_align_1_qint(51 downto 0);

    -- prodXInvY_uid41_Divide_bjB3(BITJOIN,214)@17
    prodXInvY_uid41_Divide_bjB3_q <= GND_q & prodXInvY_uid41_Divide_bs2_bit_select_merged_b;

    -- xPSXE_uid40_Divide(ADD,39)@17
    xPSXE_uid40_Divide_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => xPSX_uid37_Divide_q(15)) & xPSX_uid37_Divide_q));
    xPSXE_uid40_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 2 => zMsbY0_uid39_Divide_q(1)) & zMsbY0_uid39_Divide_q));
    xPSXE_uid40_Divide_o <= STD_LOGIC_VECTOR(SIGNED(xPSXE_uid40_Divide_a) + SIGNED(xPSXE_uid40_Divide_b));
    xPSXE_uid40_Divide_q <= xPSXE_uid40_Divide_o(16 downto 0);

    -- prodXInvY_uid41_Divide_im0_cma(CHAINMULTADD,269)@17 + 4
    -- out q@22
    prodXInvY_uid41_Divide_im0_cma_reset <= areset;
    prodXInvY_uid41_Divide_im0_cma_ena0 <= '1';
    prodXInvY_uid41_Divide_im0_cma_ena1 <= prodXInvY_uid41_Divide_im0_cma_ena0;
    prodXInvY_uid41_Divide_im0_cma_ena2 <= prodXInvY_uid41_Divide_im0_cma_ena0;
    prodXInvY_uid41_Divide_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                prodXInvY_uid41_Divide_im0_cma_ah(0) <= (others => '0');
                prodXInvY_uid41_Divide_im0_cma_ch(0) <= (others => '0');
            ELSE
                prodXInvY_uid41_Divide_im0_cma_ah(0) <= RESIZE(SIGNED(xPSXE_uid40_Divide_q),17);
                prodXInvY_uid41_Divide_im0_cma_ch(0) <= RESIZE(SIGNED(prodXInvY_uid41_Divide_bjB3_q),19);
            END IF;
        END IF;
    END PROCESS;

    prodXInvY_uid41_Divide_im0_cma_a0 <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_im0_cma_ah(0));
    prodXInvY_uid41_Divide_im0_cma_c0 <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_im0_cma_ch(0));
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

    -- prodXInvY_uid41_Divide_sums_result_add_0_0(ADD,222)@22
    prodXInvY_uid41_Divide_sums_result_add_0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((52 downto 36 => prodXInvY_uid41_Divide_im0_cma_q(35)) & prodXInvY_uid41_Divide_im0_cma_q));
    prodXInvY_uid41_Divide_sums_result_add_0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((52 downto 52 => prodXInvY_uid41_Divide_sums_align_1_q(51)) & prodXInvY_uid41_Divide_sums_align_1_q));
    prodXInvY_uid41_Divide_sums_result_add_0_0_o <= STD_LOGIC_VECTOR(SIGNED(prodXInvY_uid41_Divide_sums_result_add_0_0_a) + SIGNED(prodXInvY_uid41_Divide_sums_result_add_0_0_b));
    prodXInvY_uid41_Divide_sums_result_add_0_0_q <= prodXInvY_uid41_Divide_sums_result_add_0_0_o(52 downto 0);

    -- rightShiftInput_uid42_Divide(BITSELECT,41)@22
    rightShiftInput_uid42_Divide_in <= STD_LOGIC_VECTOR(prodXInvY_uid41_Divide_sums_result_add_0_0_q(49 downto 0));
    rightShiftInput_uid42_Divide_b <= STD_LOGIC_VECTOR(rightShiftInput_uid42_Divide_in(49 downto 0));

    -- xMSB_uid224_prodPostRightShift_uid43_Divide(BITSELECT,223)@22
    xMSB_uid224_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftInput_uid42_Divide_b(49 downto 49));

    -- seMsb_to48_uid253(BITSELECT,252)@22
    seMsb_to48_uid253_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((47 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to48_uid253_b <= STD_LOGIC_VECTOR(seMsb_to48_uid253_in(47 downto 0));

    -- rightShiftStage2Idx3Rng48_uid254_prodPostRightShift_uid43_Divide(BITSELECT,253)@22
    rightShiftStage2Idx3Rng48_uid254_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q(49 downto 48));

    -- rightShiftStage2Idx3_uid255_prodPostRightShift_uid43_Divide(BITJOIN,254)@22
    rightShiftStage2Idx3_uid255_prodPostRightShift_uid43_Divide_q <= seMsb_to48_uid253_b & rightShiftStage2Idx3Rng48_uid254_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to32_uid250(BITSELECT,249)@22
    seMsb_to32_uid250_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to32_uid250_b <= STD_LOGIC_VECTOR(seMsb_to32_uid250_in(31 downto 0));

    -- rightShiftStage2Idx2Rng32_uid251_prodPostRightShift_uid43_Divide(BITSELECT,250)@22
    rightShiftStage2Idx2Rng32_uid251_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q(49 downto 32));

    -- rightShiftStage2Idx2_uid252_prodPostRightShift_uid43_Divide(BITJOIN,251)@22
    rightShiftStage2Idx2_uid252_prodPostRightShift_uid43_Divide_q <= seMsb_to32_uid250_b & rightShiftStage2Idx2Rng32_uid251_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to16_uid247(BITSELECT,246)@22
    seMsb_to16_uid247_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to16_uid247_b <= STD_LOGIC_VECTOR(seMsb_to16_uid247_in(15 downto 0));

    -- rightShiftStage2Idx1Rng16_uid248_prodPostRightShift_uid43_Divide(BITSELECT,247)@22
    rightShiftStage2Idx1Rng16_uid248_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q(49 downto 16));

    -- rightShiftStage2Idx1_uid249_prodPostRightShift_uid43_Divide(BITJOIN,248)@22
    rightShiftStage2Idx1_uid249_prodPostRightShift_uid43_Divide_q <= seMsb_to16_uid247_b & rightShiftStage2Idx1Rng16_uid248_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to12_uid242(BITSELECT,241)@22
    seMsb_to12_uid242_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to12_uid242_b <= STD_LOGIC_VECTOR(seMsb_to12_uid242_in(11 downto 0));

    -- rightShiftStage1Idx3Rng12_uid243_prodPostRightShift_uid43_Divide(BITSELECT,242)@22
    rightShiftStage1Idx3Rng12_uid243_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q(49 downto 12));

    -- rightShiftStage1Idx3_uid244_prodPostRightShift_uid43_Divide(BITJOIN,243)@22
    rightShiftStage1Idx3_uid244_prodPostRightShift_uid43_Divide_q <= seMsb_to12_uid242_b & rightShiftStage1Idx3Rng12_uid243_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to8_uid239(BITSELECT,238)@22
    seMsb_to8_uid239_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((7 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to8_uid239_b <= STD_LOGIC_VECTOR(seMsb_to8_uid239_in(7 downto 0));

    -- rightShiftStage1Idx2Rng8_uid240_prodPostRightShift_uid43_Divide(BITSELECT,239)@22
    rightShiftStage1Idx2Rng8_uid240_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q(49 downto 8));

    -- rightShiftStage1Idx2_uid241_prodPostRightShift_uid43_Divide(BITJOIN,240)@22
    rightShiftStage1Idx2_uid241_prodPostRightShift_uid43_Divide_q <= seMsb_to8_uid239_b & rightShiftStage1Idx2Rng8_uid240_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to4_uid236(BITSELECT,235)@22
    seMsb_to4_uid236_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((3 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to4_uid236_b <= STD_LOGIC_VECTOR(seMsb_to4_uid236_in(3 downto 0));

    -- rightShiftStage1Idx1Rng4_uid237_prodPostRightShift_uid43_Divide(BITSELECT,236)@22
    rightShiftStage1Idx1Rng4_uid237_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q(49 downto 4));

    -- rightShiftStage1Idx1_uid238_prodPostRightShift_uid43_Divide(BITJOIN,237)@22
    rightShiftStage1Idx1_uid238_prodPostRightShift_uid43_Divide_q <= seMsb_to4_uid236_b & rightShiftStage1Idx1Rng4_uid237_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to3_uid231(BITSELECT,230)@22
    seMsb_to3_uid231_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((2 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to3_uid231_b <= STD_LOGIC_VECTOR(seMsb_to3_uid231_in(2 downto 0));

    -- rightShiftStage0Idx3Rng3_uid232_prodPostRightShift_uid43_Divide(BITSELECT,231)@22
    rightShiftStage0Idx3Rng3_uid232_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftInput_uid42_Divide_b(49 downto 3));

    -- rightShiftStage0Idx3_uid233_prodPostRightShift_uid43_Divide(BITJOIN,232)@22
    rightShiftStage0Idx3_uid233_prodPostRightShift_uid43_Divide_q <= seMsb_to3_uid231_b & rightShiftStage0Idx3Rng3_uid232_prodPostRightShift_uid43_Divide_b;

    -- seMsb_to2_uid228(BITSELECT,227)@22
    seMsb_to2_uid228_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => xMSB_uid224_prodPostRightShift_uid43_Divide_b(0)) & xMSB_uid224_prodPostRightShift_uid43_Divide_b));
    seMsb_to2_uid228_b <= STD_LOGIC_VECTOR(seMsb_to2_uid228_in(1 downto 0));

    -- rightShiftStage0Idx2Rng2_uid229_prodPostRightShift_uid43_Divide(BITSELECT,228)@22
    rightShiftStage0Idx2Rng2_uid229_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftInput_uid42_Divide_b(49 downto 2));

    -- rightShiftStage0Idx2_uid230_prodPostRightShift_uid43_Divide(BITJOIN,229)@22
    rightShiftStage0Idx2_uid230_prodPostRightShift_uid43_Divide_q <= seMsb_to2_uid228_b & rightShiftStage0Idx2Rng2_uid229_prodPostRightShift_uid43_Divide_b;

    -- rightShiftStage0Idx1Rng1_uid226_prodPostRightShift_uid43_Divide(BITSELECT,225)@22
    rightShiftStage0Idx1Rng1_uid226_prodPostRightShift_uid43_Divide_b <= STD_LOGIC_VECTOR(rightShiftInput_uid42_Divide_b(49 downto 1));

    -- rightShiftStage0Idx1_uid227_prodPostRightShift_uid43_Divide(BITJOIN,226)@22
    rightShiftStage0Idx1_uid227_prodPostRightShift_uid43_Divide_q <= xMSB_uid224_prodPostRightShift_uid43_Divide_b & rightShiftStage0Idx1Rng1_uid226_prodPostRightShift_uid43_Divide_b;

    -- rightShiftStage0_uid235_prodPostRightShift_uid43_Divide(MUX,234)@22
    rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_s <= rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_b;
    rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_combproc: PROCESS (rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_s, rightShiftInput_uid42_Divide_b, rightShiftStage0Idx1_uid227_prodPostRightShift_uid43_Divide_q, rightShiftStage0Idx2_uid230_prodPostRightShift_uid43_Divide_q, rightShiftStage0Idx3_uid233_prodPostRightShift_uid43_Divide_q)
    BEGIN
        CASE (rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_s) IS
            WHEN "00" => rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q <= rightShiftInput_uid42_Divide_b;
            WHEN "01" => rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q <= rightShiftStage0Idx1_uid227_prodPostRightShift_uid43_Divide_q;
            WHEN "10" => rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q <= rightShiftStage0Idx2_uid230_prodPostRightShift_uid43_Divide_q;
            WHEN "11" => rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q <= rightShiftStage0Idx3_uid233_prodPostRightShift_uid43_Divide_q;
            WHEN OTHERS => rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1_uid246_prodPostRightShift_uid43_Divide(MUX,245)@22
    rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_s <= rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_c;
    rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_combproc: PROCESS (rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_s, rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q, rightShiftStage1Idx1_uid238_prodPostRightShift_uid43_Divide_q, rightShiftStage1Idx2_uid241_prodPostRightShift_uid43_Divide_q, rightShiftStage1Idx3_uid244_prodPostRightShift_uid43_Divide_q)
    BEGIN
        CASE (rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_s) IS
            WHEN "00" => rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q <= rightShiftStage0_uid235_prodPostRightShift_uid43_Divide_q;
            WHEN "01" => rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q <= rightShiftStage1Idx1_uid238_prodPostRightShift_uid43_Divide_q;
            WHEN "10" => rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q <= rightShiftStage1Idx2_uid241_prodPostRightShift_uid43_Divide_q;
            WHEN "11" => rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q <= rightShiftStage1Idx3_uid244_prodPostRightShift_uid43_Divide_q;
            WHEN OTHERS => rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_notEnable(LOGICAL,305)
    redist6_r_uid81_zCount_uid19_Divide_q_22_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_nor(LOGICAL,306)
    redist6_r_uid81_zCount_uid19_Divide_q_22_nor_q <= not (redist6_r_uid81_zCount_uid19_Divide_q_22_notEnable_q or redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena_q);

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_mem_last(CONSTANT,302)
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_last_q <= "010011";

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_cmp(LOGICAL,303)
    redist6_r_uid81_zCount_uid19_Divide_q_22_cmp_b <= STD_LOGIC_VECTOR("0" & redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_q);
    redist6_r_uid81_zCount_uid19_Divide_q_22_cmp_q <= "1" WHEN redist6_r_uid81_zCount_uid19_Divide_q_22_mem_last_q = redist6_r_uid81_zCount_uid19_Divide_q_22_cmp_b ELSE "0";

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_cmpReg(REG,304)
    redist6_r_uid81_zCount_uid19_Divide_q_22_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid81_zCount_uid19_Divide_q_22_cmpReg_q <= "0";
            ELSE
                redist6_r_uid81_zCount_uid19_Divide_q_22_cmpReg_q <= STD_LOGIC_VECTOR(redist6_r_uid81_zCount_uid19_Divide_q_22_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena(REG,307)
    redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena_q <= "0";
            ELSE
                IF (redist6_r_uid81_zCount_uid19_Divide_q_22_nor_q = "1") THEN
                    redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena_q <= STD_LOGIC_VECTOR(redist6_r_uid81_zCount_uid19_Divide_q_22_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_enaAnd(LOGICAL,308)
    redist6_r_uid81_zCount_uid19_Divide_q_22_enaAnd_q <= redist6_r_uid81_zCount_uid19_Divide_q_22_sticky_ena_q and VCC_q;

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt(COUNTER,300)
    -- low=0, high=20, step=1, init=0
    redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_eq <= '0';
            ELSE
                IF (redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i = TO_UNSIGNED(19, 5)) THEN
                    redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_eq <= '1';
                ELSE
                    redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_eq <= '0';
                END IF;
                IF (redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_eq = '1') THEN
                    redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i <= redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i + 12;
                ELSE
                    redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i <= redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_i, 5)));

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_wraddr(REG,301)
    redist6_r_uid81_zCount_uid19_Divide_q_22_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid81_zCount_uid19_Divide_q_22_wraddr_q <= "10100";
            ELSE
                redist6_r_uid81_zCount_uid19_Divide_q_22_wraddr_q <= STD_LOGIC_VECTOR(redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist6_r_uid81_zCount_uid19_Divide_q_22_mem(DUALMEM,299)
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ia <= STD_LOGIC_VECTOR(r_uid81_zCount_uid19_Divide_q);
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_aa <= redist6_r_uid81_zCount_uid19_Divide_q_22_wraddr_q;
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ab <= redist6_r_uid81_zCount_uid19_Divide_q_22_rdcnt_q;
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ena_OrRstB <= areset or redist6_r_uid81_zCount_uid19_Divide_q_22_enaAnd_q(0);
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_reset0 <= areset;
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 5,
        widthad_a => 5,
        numwords_a => 21,
        width_b => 5,
        widthad_b => 5,
        numwords_b => 21,
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
        clocken1 => redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist6_r_uid81_zCount_uid19_Divide_q_22_mem_reset0,
        clock1 => clk,
        address_a => redist6_r_uid81_zCount_uid19_Divide_q_22_mem_aa,
        data_a => redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist6_r_uid81_zCount_uid19_Divide_q_22_mem_ab,
        q_b => redist6_r_uid81_zCount_uid19_Divide_q_22_mem_iq
    );
    redist6_r_uid81_zCount_uid19_Divide_q_22_mem_q <= redist6_r_uid81_zCount_uid19_Divide_q_22_mem_iq(4 downto 0);

    -- cWOut_uid35_Divide(CONSTANT,34)
    cWOut_uid35_Divide_q <= "10000";

    -- rShiftCount_uid36_Divide(SUB,35)@22
    rShiftCount_uid36_Divide_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & cWOut_uid35_Divide_q));
    rShiftCount_uid36_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & redist6_r_uid81_zCount_uid19_Divide_q_22_mem_q));
    rShiftCount_uid36_Divide_o <= STD_LOGIC_VECTOR(SIGNED(rShiftCount_uid36_Divide_a) - SIGNED(rShiftCount_uid36_Divide_b));
    rShiftCount_uid36_Divide_q <= rShiftCount_uid36_Divide_o(5 downto 0);

    -- rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged(BITSELECT,280)@22
    rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_b <= rShiftCount_uid36_Divide_q(1 downto 0);
    rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_c <= rShiftCount_uid36_Divide_q(3 downto 2);
    rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_d <= rShiftCount_uid36_Divide_q(5 downto 4);

    -- rightShiftStage2_uid257_prodPostRightShift_uid43_Divide(MUX,256)@22
    rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_s <= rightShiftStageSel0Dto0_uid234_prodPostRightShift_uid43_Divide_bit_select_merged_d;
    rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_combproc: PROCESS (rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_s, rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q, rightShiftStage2Idx1_uid249_prodPostRightShift_uid43_Divide_q, rightShiftStage2Idx2_uid252_prodPostRightShift_uid43_Divide_q, rightShiftStage2Idx3_uid255_prodPostRightShift_uid43_Divide_q)
    BEGIN
        CASE (rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_s) IS
            WHEN "00" => rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_q <= rightShiftStage1_uid246_prodPostRightShift_uid43_Divide_q;
            WHEN "01" => rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_q <= rightShiftStage2Idx1_uid249_prodPostRightShift_uid43_Divide_q;
            WHEN "10" => rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_q <= rightShiftStage2Idx2_uid252_prodPostRightShift_uid43_Divide_q;
            WHEN "11" => rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_q <= rightShiftStage2Idx3_uid255_prodPostRightShift_uid43_Divide_q;
            WHEN OTHERS => rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- prodPostRightShiftPost_uid44_Divide(BITSELECT,43)@22
    prodPostRightShiftPost_uid44_Divide_in <= rightShiftStage2_uid257_prodPostRightShift_uid43_Divide_q(48 downto 0);
    prodPostRightShiftPost_uid44_Divide_b <= prodPostRightShiftPost_uid44_Divide_in(48 downto 15);

    -- prodPostRightShiftPostRnd_uid46_Divide(ADD,45)@22
    prodPostRightShiftPostRnd_uid46_Divide_a <= STD_LOGIC_VECTOR("0" & prodPostRightShiftPost_uid44_Divide_b);
    prodPostRightShiftPostRnd_uid46_Divide_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000" & VCC_q);
    prodPostRightShiftPostRnd_uid46_Divide_o <= STD_LOGIC_VECTOR(UNSIGNED(prodPostRightShiftPostRnd_uid46_Divide_a) + UNSIGNED(prodPostRightShiftPostRnd_uid46_Divide_b));
    prodPostRightShiftPostRnd_uid46_Divide_q <= prodPostRightShiftPostRnd_uid46_Divide_o(34 downto 0);

    -- prodPostRightShiftPostRndRange_uid47_Divide(BITSELECT,46)@22
    prodPostRightShiftPostRndRange_uid47_Divide_in <= prodPostRightShiftPostRnd_uid46_Divide_q(33 downto 0);
    prodPostRightShiftPostRndRange_uid47_Divide_b <= prodPostRightShiftPostRndRange_uid47_Divide_in(33 downto 1);

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_notEnable(LOGICAL,315)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_nor(LOGICAL,316)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_nor_q <= not (redist10_GPIn_in_1_Current_range_int16_tpl_22_notEnable_q or redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena_q);

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_last(CONSTANT,312)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_last_q <= "010011";

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_cmp(LOGICAL,313)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_cmp_b <= STD_LOGIC_VECTOR("0" & redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_q);
    redist10_GPIn_in_1_Current_range_int16_tpl_22_cmp_q <= "1" WHEN redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_last_q = redist10_GPIn_in_1_Current_range_int16_tpl_22_cmp_b ELSE "0";

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_cmpReg(REG,314)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist10_GPIn_in_1_Current_range_int16_tpl_22_cmpReg_q <= "0";
            ELSE
                redist10_GPIn_in_1_Current_range_int16_tpl_22_cmpReg_q <= STD_LOGIC_VECTOR(redist10_GPIn_in_1_Current_range_int16_tpl_22_cmp_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena(REG,317)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena_q <= "0";
            ELSE
                IF (redist10_GPIn_in_1_Current_range_int16_tpl_22_nor_q = "1") THEN
                    redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena_q <= STD_LOGIC_VECTOR(redist10_GPIn_in_1_Current_range_int16_tpl_22_cmpReg_q);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_enaAnd(LOGICAL,318)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_enaAnd_q <= redist10_GPIn_in_1_Current_range_int16_tpl_22_sticky_ena_q and VCC_q;

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt(COUNTER,310)
    -- low=0, high=20, step=1, init=0
    redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i <= TO_UNSIGNED(0, 5);
                redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_eq <= '0';
            ELSE
                IF (redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i = TO_UNSIGNED(19, 5)) THEN
                    redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_eq <= '1';
                ELSE
                    redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_eq <= '0';
                END IF;
                IF (redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_eq = '1') THEN
                    redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i <= redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i + 12;
                ELSE
                    redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i <= redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_i, 5)));

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_wraddr(REG,311)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist10_GPIn_in_1_Current_range_int16_tpl_22_wraddr_q <= "10100";
            ELSE
                redist10_GPIn_in_1_Current_range_int16_tpl_22_wraddr_q <= STD_LOGIC_VECTOR(redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist10_GPIn_in_1_Current_range_int16_tpl_22_mem(DUALMEM,309)
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ia <= STD_LOGIC_VECTOR(in_1_Current_range_int16_tpl);
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_aa <= redist10_GPIn_in_1_Current_range_int16_tpl_22_wraddr_q;
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ab <= redist10_GPIn_in_1_Current_range_int16_tpl_22_rdcnt_q;
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ena_OrRstB <= areset or redist10_GPIn_in_1_Current_range_int16_tpl_22_enaAnd_q(0);
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_reset0 <= areset;
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 16,
        widthad_a => 5,
        numwords_a => 21,
        width_b => 16,
        widthad_b => 5,
        numwords_b => 21,
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
        clocken1 => redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_reset0,
        clock1 => clk,
        address_a => redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_aa,
        data_a => redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_ab,
        q_b => redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_iq
    );
    redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_q <= redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_iq(15 downto 0);

    -- yIsZero_uid27_Divide(LOGICAL,26)@22
    yIsZero_uid27_Divide_b <= STD_LOGIC_VECTOR("000000000000000" & GND_q);
    yIsZero_uid27_Divide_q <= "1" WHEN redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_q = yIsZero_uid27_Divide_b ELSE "0";

    -- resFinal_uid52_Divide(MUX,51)@22
    resFinal_uid52_Divide_s <= yIsZero_uid27_Divide_q;
    resFinal_uid52_Divide_combproc: PROCESS (resFinal_uid52_Divide_s, prodPostRightShiftPostRndRange_uid47_Divide_b, muxopt_assign_id0_q_const_q)
    BEGIN
        CASE (resFinal_uid52_Divide_s) IS
            WHEN "0" => resFinal_uid52_Divide_q <= prodPostRightShiftPostRndRange_uid47_Divide_b;
            WHEN "1" => resFinal_uid52_Divide_q <= muxopt_assign_id0_q_const_q;
            WHEN OTHERS => resFinal_uid52_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Mult_bs1_bit_select_merged(BITSELECT,281)@22
    Mult_bs1_bit_select_merged_b <= STD_LOGIC_VECTOR(resFinal_uid52_Divide_q(17 downto 0));
    Mult_bs1_bit_select_merged_c <= STD_LOGIC_VECTOR(resFinal_uid52_Divide_q(32 downto 18));

    -- Mult_bjA8(BITJOIN,176)@22
    Mult_bjA8_q <= GND_q & Mult_bs1_bit_select_merged_b;

    -- Add1_PreShift_0(BITSHIFT,11)@22
    Add1_PreShift_0_qint <= redist10_GPIn_in_1_Current_range_int16_tpl_22_mem_q & "000000000";
    Add1_PreShift_0_q <= Add1_PreShift_0_qint(24 downto 0);

    -- Add1(ADD,2)@22
    Add1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 25 => Add1_PreShift_0_q(24)) & Add1_PreShift_0_q));
    Add1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 16 => in_2_Current_sfix16_En10_tpl(15)) & in_2_Current_sfix16_En10_tpl));
    Add1_o <= STD_LOGIC_VECTOR(SIGNED(Add1_a) + SIGNED(Add1_b));
    Add1_q <= Add1_o(25 downto 0);

    -- Mult_bs2_bit_select_merged(BITSELECT,277)@22
    Mult_bs2_bit_select_merged_b <= STD_LOGIC_VECTOR(Add1_q(17 downto 0));
    Mult_bs2_bit_select_merged_c <= STD_LOGIC_VECTOR(Add1_q(25 downto 18));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- Mult_ma3_cma(CHAINMULTADD,271)@22 + 4
    -- out q@27
    Mult_ma3_cma_reset <= areset;
    Mult_ma3_cma_ena0 <= '1';
    Mult_ma3_cma_ena1 <= Mult_ma3_cma_ena0;
    Mult_ma3_cma_ena2 <= Mult_ma3_cma_ena0;
    Mult_ma3_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                Mult_ma3_cma_ah(0) <= (others => '0');
                Mult_ma3_cma_ah(1) <= (others => '0');
                Mult_ma3_cma_ch(0) <= (others => '0');
                Mult_ma3_cma_ch(1) <= (others => '0');
            ELSE
                Mult_ma3_cma_ah(0) <= RESIZE(SIGNED(Mult_bs2_bit_select_merged_c),15);
                Mult_ma3_cma_ah(1) <= RESIZE(SIGNED(Mult_bs1_bit_select_merged_c),15);
                Mult_ma3_cma_ch(0) <= RESIZE(SIGNED(Mult_bjA8_q),19);
                Mult_ma3_cma_ch(1) <= RESIZE(SIGNED(Mult_bjB6_q),19);
            END IF;
        END IF;
    END PROCESS;

    Mult_ma3_cma_a0 <= STD_LOGIC_VECTOR(Mult_ma3_cma_ah(0));
    Mult_ma3_cma_c0 <= STD_LOGIC_VECTOR(Mult_ma3_cma_ch(0));
    Mult_ma3_cma_a1 <= STD_LOGIC_VECTOR(Mult_ma3_cma_ah(1));
    Mult_ma3_cma_c1 <= STD_LOGIC_VECTOR(Mult_ma3_cma_ch(1));
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

    -- Mult_sums_align_1(BITSHIFT,182)@27
    Mult_sums_align_1_qint <= Mult_ma3_cma_q & "000000000000000000";
    Mult_sums_align_1_q <= Mult_sums_align_1_qint(52 downto 0);

    -- Mult_im10_cma(CHAINMULTADD,268)@22 + 4
    -- out q@27
    Mult_im10_cma_reset <= areset;
    Mult_im10_cma_ena0 <= '1';
    Mult_im10_cma_ena1 <= Mult_im10_cma_ena0;
    Mult_im10_cma_ena2 <= Mult_im10_cma_ena0;
    Mult_im10_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                Mult_im10_cma_ah(0) <= (others => '0');
                Mult_im10_cma_ch(0) <= (others => '0');
            ELSE
                Mult_im10_cma_ah(0) <= RESIZE(SIGNED(Mult_bs1_bit_select_merged_c),15);
                Mult_im10_cma_ch(0) <= RESIZE(SIGNED(Mult_bs2_bit_select_merged_c),11);
            END IF;
        END IF;
    END PROCESS;

    Mult_im10_cma_a0 <= STD_LOGIC_VECTOR(Mult_im10_cma_ah(0));
    Mult_im10_cma_c0 <= STD_LOGIC_VECTOR(Mult_im10_cma_ch(0));
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
    Mult_im10_cma_q <= STD_LOGIC_VECTOR(Mult_im10_cma_qq0(22 downto 0));

    -- Mult_im0_cma(CHAINMULTADD,267)@22 + 4
    -- out q@27
    Mult_im0_cma_reset <= areset;
    Mult_im0_cma_ena0 <= '1';
    Mult_im0_cma_ena1 <= Mult_im0_cma_ena0;
    Mult_im0_cma_ena2 <= Mult_im0_cma_ena0;
    Mult_im0_cma_chainmultadd_hyper: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                Mult_im0_cma_ah(0) <= (others => '0');
                Mult_im0_cma_ch(0) <= (others => '0');
            ELSE
                Mult_im0_cma_ah(0) <= RESIZE(UNSIGNED(Mult_bs1_bit_select_merged_b),18);
                Mult_im0_cma_ch(0) <= RESIZE(UNSIGNED(Mult_bs2_bit_select_merged_b),18);
            END IF;
        END IF;
    END PROCESS;

    Mult_im0_cma_a0 <= STD_LOGIC_VECTOR(Mult_im0_cma_ah(0));
    Mult_im0_cma_c0 <= STD_LOGIC_VECTOR(Mult_im0_cma_ch(0));
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

    -- Mult_sums_join_0(BITJOIN,181)@27
    Mult_sums_join_0_q <= Mult_im10_cma_q & Mult_im0_cma_q;

    -- Mult_sums_result_add_0_0(ADD,184)@27
    Mult_sums_result_add_0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((59 downto 59 => Mult_sums_join_0_q(58)) & Mult_sums_join_0_q));
    Mult_sums_result_add_0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((59 downto 53 => Mult_sums_align_1_q(52)) & Mult_sums_align_1_q));
    Mult_sums_result_add_0_0_o <= STD_LOGIC_VECTOR(SIGNED(Mult_sums_result_add_0_0_a) + SIGNED(Mult_sums_result_add_0_0_b));
    Mult_sums_result_add_0_0_q <= Mult_sums_result_add_0_0_o(59 downto 0);

    -- Convert4_rnd_trunc(BITSHIFT,273)@27
    Convert4_rnd_trunc_qint <= Mult_sums_result_add_0_0_q(58 downto 0);
    Convert4_rnd_trunc_q <= Convert4_rnd_trunc_qint(58 downto 24);

    -- Convert4_rnd_add(ADD,274)@27
    Convert4_rnd_add_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => Convert4_rnd_trunc_q(34)) & Convert4_rnd_trunc_q));
    Convert4_rnd_add_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 2 => Convert4_rnd_bias_q(1)) & Convert4_rnd_bias_q));
    Convert4_rnd_add_o <= STD_LOGIC_VECTOR(SIGNED(Convert4_rnd_add_a) + SIGNED(Convert4_rnd_add_b));
    Convert4_rnd_add_q <= Convert4_rnd_add_o(35 downto 0);

    -- Convert4_rnd_shift(BITSHIFT,275)@27
    Convert4_rnd_shift_qint <= Convert4_rnd_add_q;
    Convert4_rnd_shift_q <= Convert4_rnd_shift_qint(35 downto 1);

    -- Convert4_sel_x(BITSELECT,10)@27
    Convert4_sel_x_b <= STD_LOGIC_VECTOR(Convert4_rnd_shift_q(15 downto 0));

    -- redist9_Convert4_sel_x_b_1(DELAY,297)
    redist9_Convert4_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist9_Convert4_sel_x_b_1_q <= (others => '0');
            ELSE
                redist9_Convert4_sel_x_b_1_q <= STD_LOGIC_VECTOR(Convert4_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- GPOut(GPOUT,8)@28
    out_1_Fraction_ND_ufix16_En16_x_tpl <= redist9_Convert4_sel_x_b_1_q;

END normal;
