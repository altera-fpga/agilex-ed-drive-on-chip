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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_VoltageScale
-- VHDL created on Mon Aug 11 01:49:10 2025


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
entity motor_kit_sim_20MHz_MotorModel_VoltageScale is
    port (
        in_1_Voltage_range_int16_tpl : in std_logic_vector(15 downto 0);  -- sfix16
        in_2_VoltageA_sfix16_En6_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_4_VoltageC_sfix16_En6_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        in_3_VoltageB_sfix16_En6_tpl : in std_logic_vector(15 downto 0);  -- sfix16_en6
        out_1_FractionA_ND_ufix16_En16_x_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_3_FractionC_ND_ufix16_En16_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        out_2_FractionB_ND_ufix16_En16_tpl : out std_logic_vector(15 downto 0);  -- ufix16_en16
        clk : in std_logic;
        areset : in std_logic
    );
end motor_kit_sim_20MHz_MotorModel_VoltageScale;

architecture normal of motor_kit_sim_20MHz_MotorModel_VoltageScale is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_hconst_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Const_Mult_PostCast_primWireOut_lconst_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Const_Mult_PostCast_primWireOut_mux_x_q : STD_LOGIC_VECTOR (15 downto 0);
    signal Const1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal Const_Mult_PostCast_primWireOut_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Convert1_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Convert2_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Convert3_sel_x_b : STD_LOGIC_VECTOR (17 downto 0);
    signal Convert4_sel_x_b : STD_LOGIC_VECTOR (15 downto 0);
    signal dupName_0_Const_Mult_PostCast_primWireOut_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Add1_PreShift_0_q : STD_LOGIC_VECTOR (21 downto 0);
    signal Add1_PreShift_0_qint : STD_LOGIC_VECTOR (21 downto 0);
    signal Add2_PreShift_0_q : STD_LOGIC_VECTOR (21 downto 0);
    signal Add2_PreShift_0_qint : STD_LOGIC_VECTOR (21 downto 0);
    signal Add3_PreShift_0_q : STD_LOGIC_VECTOR (21 downto 0);
    signal Add3_PreShift_0_qint : STD_LOGIC_VECTOR (21 downto 0);
    signal sR_mergedSignalTM_uid44_Const_Mult_x_q : STD_LOGIC_VECTOR (16 downto 0);
    signal xMSB_uid72_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal yPSE_uid74_Divide_b : STD_LOGIC_VECTOR (15 downto 0);
    signal yPSE_uid74_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal yPSEA_uid76_Divide_a : STD_LOGIC_VECTOR (16 downto 0);
    signal yPSEA_uid76_Divide_b : STD_LOGIC_VECTOR (16 downto 0);
    signal yPSEA_uid76_Divide_o : STD_LOGIC_VECTOR (16 downto 0);
    signal yPSEA_uid76_Divide_q : STD_LOGIC_VECTOR (16 downto 0);
    signal yPS_uid77_Divide_in : STD_LOGIC_VECTOR (15 downto 0);
    signal yPS_uid77_Divide_b : STD_LOGIC_VECTOR (15 downto 0);
    signal normYNoLeadOne_uid80_Divide_in : STD_LOGIC_VECTOR (14 downto 0);
    signal normYNoLeadOne_uid80_Divide_b : STD_LOGIC_VECTOR (14 downto 0);
    signal normYIsOneC2_uid81_Divide_a : STD_LOGIC_VECTOR (15 downto 0);
    signal normYIsOneC2_uid81_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOneC2_uid84_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOne_uid85_Divide_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal normYIsOne_uid85_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsZero_uid86_Divide_b : STD_LOGIC_VECTOR (15 downto 0);
    signal yIsZero_uid86_Divide_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsZero_uid86_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fxpInverseRes_uid91_Divide_in : STD_LOGIC_VECTOR (25 downto 0);
    signal fxpInverseRes_uid91_Divide_b : STD_LOGIC_VECTOR (19 downto 0);
    signal oneInvRes_uid92_Divide_q : STD_LOGIC_VECTOR (19 downto 0);
    signal invResPostOneHandling2_uid93_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal invResPostOneHandling2_uid93_Divide_q : STD_LOGIC_VECTOR (19 downto 0);
    signal cWOut_uid94_Divide_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rShiftCount_uid95_Divide_a : STD_LOGIC_VECTOR (5 downto 0);
    signal rShiftCount_uid95_Divide_b : STD_LOGIC_VECTOR (5 downto 0);
    signal rShiftCount_uid95_Divide_o : STD_LOGIC_VECTOR (5 downto 0);
    signal rShiftCount_uid95_Divide_q : STD_LOGIC_VECTOR (5 downto 0);
    signal xPSX_uid96_Divide_b : STD_LOGIC_VECTOR (1 downto 0);
    signal xPSX_uid96_Divide_q : STD_LOGIC_VECTOR (1 downto 0);
    signal zMsbY0_uid98_Divide_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftInput_uid101_Divide_in : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftInput_uid101_Divide_b : STD_LOGIC_VECTOR (21 downto 0);
    signal prodPostRightShiftPost_uid103_Divide_in : STD_LOGIC_VECTOR (20 downto 0);
    signal prodPostRightShiftPost_uid103_Divide_b : STD_LOGIC_VECTOR (19 downto 0);
    signal prodPostRightShiftPostRnd_uid105_Divide_a : STD_LOGIC_VECTOR (20 downto 0);
    signal prodPostRightShiftPostRnd_uid105_Divide_b : STD_LOGIC_VECTOR (20 downto 0);
    signal prodPostRightShiftPostRnd_uid105_Divide_o : STD_LOGIC_VECTOR (20 downto 0);
    signal prodPostRightShiftPostRnd_uid105_Divide_q : STD_LOGIC_VECTOR (20 downto 0);
    signal prodPostRightShiftPostRndRange_uid106_Divide_in : STD_LOGIC_VECTOR (19 downto 0);
    signal prodPostRightShiftPostRndRange_uid106_Divide_b : STD_LOGIC_VECTOR (18 downto 0);
    signal resFinal_uid111_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal resFinal_uid111_Divide_q : STD_LOGIC_VECTOR (18 downto 0);
    signal zs_uid113_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid115_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid116_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid118_zCount_uid78_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid118_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid119_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid121_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid124_zCount_uid78_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid124_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid125_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid127_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid130_zCount_uid78_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid130_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid131_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid133_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid136_zCount_uid78_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid136_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid138_zCount_uid78_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid139_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid140_zCount_uid78_Divide_q : STD_LOGIC_VECTOR (4 downto 0);
    signal memoryC0_uid142_invTabGen_q : STD_LOGIC_VECTOR (24 downto 0);
    signal memoryC1_uid145_invTabGen_q : STD_LOGIC_VECTOR (16 downto 0);
    signal memoryC2_uid148_invTabGen_q : STD_LOGIC_VECTOR (9 downto 0);
    signal lowRangeB_uid156_invPolyEval_in : STD_LOGIC_VECTOR (0 downto 0);
    signal lowRangeB_uid156_invPolyEval_b : STD_LOGIC_VECTOR (0 downto 0);
    signal highBBits_uid157_invPolyEval_b : STD_LOGIC_VECTOR (9 downto 0);
    signal s1sumAHighB_uid158_invPolyEval_a : STD_LOGIC_VECTOR (17 downto 0);
    signal s1sumAHighB_uid158_invPolyEval_b : STD_LOGIC_VECTOR (17 downto 0);
    signal s1sumAHighB_uid158_invPolyEval_o : STD_LOGIC_VECTOR (17 downto 0);
    signal s1sumAHighB_uid158_invPolyEval_q : STD_LOGIC_VECTOR (17 downto 0);
    signal s1_uid159_invPolyEval_q : STD_LOGIC_VECTOR (18 downto 0);
    signal lowRangeB_uid162_invPolyEval_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lowRangeB_uid162_invPolyEval_b : STD_LOGIC_VECTOR (1 downto 0);
    signal highBBits_uid163_invPolyEval_b : STD_LOGIC_VECTOR (17 downto 0);
    signal s2sumAHighB_uid164_invPolyEval_a : STD_LOGIC_VECTOR (25 downto 0);
    signal s2sumAHighB_uid164_invPolyEval_b : STD_LOGIC_VECTOR (25 downto 0);
    signal s2sumAHighB_uid164_invPolyEval_o : STD_LOGIC_VECTOR (25 downto 0);
    signal s2sumAHighB_uid164_invPolyEval_q : STD_LOGIC_VECTOR (25 downto 0);
    signal s2_uid165_invPolyEval_q : STD_LOGIC_VECTOR (27 downto 0);
    signal osig_uid168_pT1_uid155_invPolyEval_b : STD_LOGIC_VECTOR (10 downto 0);
    signal osig_uid171_pT2_uid161_invPolyEval_b : STD_LOGIC_VECTOR (19 downto 0);
    signal cstOvf_uid110_Divide_q_const_q : STD_LOGIC_VECTOR (18 downto 0);
    signal Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_180_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_181_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_182_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_183_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_184_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Add1_lhsMSBs_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Add1_MSBs_sums_a : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_MSBs_sums_b : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_MSBs_sums_o : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_MSBs_sums_q : STD_LOGIC_VECTOR (16 downto 0);
    signal Add1_split_join_q : STD_LOGIC_VECTOR (22 downto 0);
    signal Add2_lhsMSBs_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Add2_MSBs_sums_a : STD_LOGIC_VECTOR (16 downto 0);
    signal Add2_MSBs_sums_b : STD_LOGIC_VECTOR (16 downto 0);
    signal Add2_MSBs_sums_o : STD_LOGIC_VECTOR (16 downto 0);
    signal Add2_MSBs_sums_q : STD_LOGIC_VECTOR (16 downto 0);
    signal Add2_split_join_q : STD_LOGIC_VECTOR (22 downto 0);
    signal Add3_lhsMSBs_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal Add3_MSBs_sums_a : STD_LOGIC_VECTOR (16 downto 0);
    signal Add3_MSBs_sums_b : STD_LOGIC_VECTOR (16 downto 0);
    signal Add3_MSBs_sums_o : STD_LOGIC_VECTOR (16 downto 0);
    signal Add3_MSBs_sums_q : STD_LOGIC_VECTOR (16 downto 0);
    signal Add3_split_join_q : STD_LOGIC_VECTOR (22 downto 0);
    signal leftShiftStage0Idx1Rng8_uid204_normY_uid79_Divide_in : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx1Rng8_uid204_normY_uid79_Divide_b : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx1_uid205_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage0_uid209_normY_uid79_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid209_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx1Rng2_uid211_normY_uid79_Divide_in : STD_LOGIC_VECTOR (13 downto 0);
    signal leftShiftStage1Idx1Rng2_uid211_normY_uid79_Divide_b : STD_LOGIC_VECTOR (13 downto 0);
    signal leftShiftStage1Idx1_uid212_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx2Rng4_uid214_normY_uid79_Divide_in : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx2Rng4_uid214_normY_uid79_Divide_b : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx2_uid215_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1Idx3Pad6_uid216_normY_uid79_Divide_q : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStage1Idx3Rng6_uid217_normY_uid79_Divide_in : STD_LOGIC_VECTOR (9 downto 0);
    signal leftShiftStage1Idx3Rng6_uid217_normY_uid79_Divide_b : STD_LOGIC_VECTOR (9 downto 0);
    signal leftShiftStage1Idx3_uid218_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage1_uid220_normY_uid79_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid220_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage2Idx1Rng1_uid222_normY_uid79_Divide_in : STD_LOGIC_VECTOR (14 downto 0);
    signal leftShiftStage2Idx1Rng1_uid222_normY_uid79_Divide_b : STD_LOGIC_VECTOR (14 downto 0);
    signal leftShiftStage2Idx1_uid223_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal leftShiftStage2_uid225_normY_uid79_Divide_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid225_normY_uid79_Divide_q : STD_LOGIC_VECTOR (15 downto 0);
    signal xMSB_uid227_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng1_uid231_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (20 downto 0);
    signal rightShiftStage0Idx1_uid232_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal seMsb_to2_uid233_in : STD_LOGIC_VECTOR (1 downto 0);
    signal seMsb_to2_uid233_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0Idx2Rng2_uid234_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (19 downto 0);
    signal rightShiftStage0Idx2_uid235_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal seMsb_to3_uid236_in : STD_LOGIC_VECTOR (2 downto 0);
    signal seMsb_to3_uid236_b : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage0Idx3Rng3_uid237_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (18 downto 0);
    signal rightShiftStage0Idx3_uid238_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStageSel0Dto0_uid239_prodPostRightShift_uid102_Divide_in : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel0Dto0_uid239_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal seMsb_to4_uid241_in : STD_LOGIC_VECTOR (3 downto 0);
    signal seMsb_to4_uid241_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStage1Idx1Rng4_uid242_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (17 downto 0);
    signal rightShiftStage1Idx1_uid243_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal seMsb_to8_uid244_in : STD_LOGIC_VECTOR (7 downto 0);
    signal seMsb_to8_uid244_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage1Idx2Rng8_uid245_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (13 downto 0);
    signal rightShiftStage1Idx2_uid246_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal seMsb_to12_uid247_in : STD_LOGIC_VECTOR (11 downto 0);
    signal seMsb_to12_uid247_b : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage1Idx3Rng12_uid248_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftStage1Idx3_uid249_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStageSel2Dto2_uid250_prodPostRightShift_uid102_Divide_in : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStageSel2Dto2_uid250_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal seMsb_to16_uid252_in : STD_LOGIC_VECTOR (15 downto 0);
    signal seMsb_to16_uid252_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStage2Idx1Rng16_uid253_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage2Idx1_uid254_prodPostRightShift_uid102_Divide_q : STD_LOGIC_VECTOR (21 downto 0);
    signal rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_in : STD_LOGIC_VECTOR (4 downto 0);
    signal rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_b : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftOutConstant_to22_uid257_in : STD_LOGIC_VECTOR (21 downto 0);
    signal shiftOutConstant_to22_uid257_b : STD_LOGIC_VECTOR (21 downto 0);
    signal Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_msb_X_263_in : STD_LOGIC_VECTOR (17 downto 0);
    signal Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_msb_X_263_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_top_X_264_in : STD_LOGIC_VECTOR (17 downto 0);
    signal Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_top_X_264_b : STD_LOGIC_VECTOR (1 downto 0);
    signal Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_not_msb_X_265_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op_top_X_266_q : STD_LOGIC_VECTOR (0 downto 0);
    signal Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op2_267_q : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_const_trz_269_q : STD_LOGIC_VECTOR (3 downto 0);
    signal shiftedOut_uid230_prodPostRightShift_uid102_Divide_bit_select_top_X_trz_270_b : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_a : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_b : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_o : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_n : STD_LOGIC_VECTOR (0 downto 0);
    signal Mult_cma_reset : std_logic;
    signal Mult_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult_cma_c0 : STD_LOGIC_VECTOR (22 downto 0);
    signal Mult_cma_s0 : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult_cma_qq0 : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult_cma_q : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult_cma_ena0 : std_logic;
    signal Mult_cma_ena1 : std_logic;
    signal Mult_cma_ena2 : std_logic;
    signal Mult1_cma_reset : std_logic;
    signal Mult1_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult1_cma_c0 : STD_LOGIC_VECTOR (22 downto 0);
    signal Mult1_cma_s0 : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult1_cma_qq0 : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult1_cma_q : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult1_cma_ena0 : std_logic;
    signal Mult1_cma_ena1 : std_logic;
    signal Mult1_cma_ena2 : std_logic;
    signal Mult2_cma_reset : std_logic;
    signal Mult2_cma_a0 : STD_LOGIC_VECTOR (17 downto 0);
    signal Mult2_cma_c0 : STD_LOGIC_VECTOR (22 downto 0);
    signal Mult2_cma_s0 : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult2_cma_qq0 : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult2_cma_q : STD_LOGIC_VECTOR (40 downto 0);
    signal Mult2_cma_ena0 : std_logic;
    signal Mult2_cma_ena1 : std_logic;
    signal Mult2_cma_ena2 : std_logic;
    signal prodXInvY_uid100_Divide_cma_reset : std_logic;
    signal prodXInvY_uid100_Divide_cma_a0 : STD_LOGIC_VECTOR (1 downto 0);
    signal prodXInvY_uid100_Divide_cma_b0 : STD_LOGIC_VECTOR (1 downto 0);
    signal prodXInvY_uid100_Divide_cma_c0 : STD_LOGIC_VECTOR (19 downto 0);
    signal prodXInvY_uid100_Divide_cma_s0 : STD_LOGIC_VECTOR (22 downto 0);
    signal prodXInvY_uid100_Divide_cma_qq0 : STD_LOGIC_VECTOR (22 downto 0);
    signal prodXInvY_uid100_Divide_cma_q : STD_LOGIC_VECTOR (22 downto 0);
    signal prodXInvY_uid100_Divide_cma_ena0 : std_logic;
    signal prodXInvY_uid100_Divide_cma_ena1 : std_logic;
    signal prodXInvY_uid100_Divide_cma_ena2 : std_logic;
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (7 downto 0);
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (10 downto 0);
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_q : STD_LOGIC_VECTOR (17 downto 0);
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid167_pT1_uid155_invPolyEval_cma_ena2 : std_logic;
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_reset : std_logic;
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_a0 : STD_LOGIC_VECTOR (7 downto 0);
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_c0 : STD_LOGIC_VECTOR (18 downto 0);
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_s0 : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_qq0 : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_ena0 : std_logic;
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_ena1 : std_logic;
    signal prodXY_uid170_pT2_uid161_invPolyEval_cma_ena2 : std_logic;
    signal Convert1_rnd_shift_q : STD_LOGIC_VECTOR (34 downto 0);
    signal Convert1_rnd_shift_qint : STD_LOGIC_VECTOR (40 downto 0);
    signal Convert1_rnd_bs_in : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert1_rnd_bs_b : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert2_rnd_shift_q : STD_LOGIC_VECTOR (34 downto 0);
    signal Convert2_rnd_shift_qint : STD_LOGIC_VECTOR (40 downto 0);
    signal Convert2_rnd_bs_in : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert2_rnd_bs_b : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_shift_q : STD_LOGIC_VECTOR (34 downto 0);
    signal Convert4_rnd_shift_qint : STD_LOGIC_VECTOR (40 downto 0);
    signal Convert4_rnd_bs_in : STD_LOGIC_VECTOR (35 downto 0);
    signal Convert4_rnd_bs_b : STD_LOGIC_VECTOR (35 downto 0);
    signal Add1_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (9 downto 0);
    signal Add1_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (5 downto 0);
    signal Add2_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (9 downto 0);
    signal Add2_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (5 downto 0);
    signal Add3_rhsMSBs_select_bit_select_merged_b : STD_LOGIC_VECTOR (9 downto 0);
    signal Add3_rhsMSBs_select_bit_select_merged_c : STD_LOGIC_VECTOR (5 downto 0);
    signal yAddr_uid88_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (6 downto 0);
    signal yAddr_uid88_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid120_zCount_uid78_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid120_zCount_uid78_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid126_zCount_uid78_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid126_zCount_uid78_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid132_zCount_uid78_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid132_zCount_uid78_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_d : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage2_uid256_prodPostRightShift_uid102_DivideinvSel_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mergedMUXes0_q : STD_LOGIC_VECTOR (21 downto 0);
    signal redist0_yAddr_uid88_Divide_bit_select_merged_b_4_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_1 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_2 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist1_yAddr_uid88_Divide_bit_select_merged_b_8_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_0 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_1 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_2 : STD_LOGIC_VECTOR (6 downto 0);
    signal redist2_yAddr_uid88_Divide_bit_select_merged_c_4_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_0 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal redist7_yIsZero_uid86_Divide_q_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_normYIsOne_uid85_Divide_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_xMSB_uid72_Divide_b_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_Convert4_sel_x_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist11_Convert2_sel_x_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist12_Convert1_sel_x_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_GPIn_in_1_Voltage_range_int16_tpl_3_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_GPIn_in_1_Voltage_range_int16_tpl_3_delay_0 : STD_LOGIC_VECTOR (15 downto 0);
    signal redist13_GPIn_in_1_Voltage_range_int16_tpl_3_delay_1 : STD_LOGIC_VECTOR (15 downto 0);
    signal redist3_Add3_split_join_q_9_mem_reset0 : std_logic;
    signal redist3_Add3_split_join_q_9_mem_ena_OrRstB : std_logic;
    signal redist3_Add3_split_join_q_9_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist3_Add3_split_join_q_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_Add3_split_join_q_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_Add3_split_join_q_9_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist3_Add3_split_join_q_9_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist3_Add3_split_join_q_9_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_Add3_split_join_q_9_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only : boolean;
    attribute preserve_syn_only of redist3_Add3_split_join_q_9_rdcnt_i : signal is true;
    signal redist3_Add3_split_join_q_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist3_Add3_split_join_q_9_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist3_Add3_split_join_q_9_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist3_Add3_split_join_q_9_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_Add3_split_join_q_9_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist3_Add3_split_join_q_9_cmpReg_q : signal is true;
    signal redist3_Add3_split_join_q_9_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_Add3_split_join_q_9_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_Add3_split_join_q_9_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist3_Add3_split_join_q_9_sticky_ena_q : signal is true;
    signal redist3_Add3_split_join_q_9_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_Add2_split_join_q_9_mem_reset0 : std_logic;
    signal redist4_Add2_split_join_q_9_mem_ena_OrRstB : std_logic;
    signal redist4_Add2_split_join_q_9_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist4_Add2_split_join_q_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist4_Add2_split_join_q_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist4_Add2_split_join_q_9_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist4_Add2_split_join_q_9_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist4_Add2_split_join_q_9_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist4_Add2_split_join_q_9_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist4_Add2_split_join_q_9_rdcnt_i : signal is true;
    signal redist4_Add2_split_join_q_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist4_Add2_split_join_q_9_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_Add2_split_join_q_9_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist4_Add2_split_join_q_9_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_Add2_split_join_q_9_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist4_Add2_split_join_q_9_cmpReg_q : signal is true;
    signal redist4_Add2_split_join_q_9_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_Add2_split_join_q_9_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_Add2_split_join_q_9_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist4_Add2_split_join_q_9_sticky_ena_q : signal is true;
    signal redist4_Add2_split_join_q_9_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_Add1_split_join_q_9_mem_reset0 : std_logic;
    signal redist5_Add1_split_join_q_9_mem_ena_OrRstB : std_logic;
    signal redist5_Add1_split_join_q_9_mem_ia : STD_LOGIC_VECTOR (22 downto 0);
    signal redist5_Add1_split_join_q_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_Add1_split_join_q_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_Add1_split_join_q_9_mem_iq : STD_LOGIC_VECTOR (22 downto 0);
    signal redist5_Add1_split_join_q_9_mem_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist5_Add1_split_join_q_9_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_Add1_split_join_q_9_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve_syn_only of redist5_Add1_split_join_q_9_rdcnt_i : signal is true;
    signal redist5_Add1_split_join_q_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist5_Add1_split_join_q_9_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_Add1_split_join_q_9_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist5_Add1_split_join_q_9_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_Add1_split_join_q_9_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist5_Add1_split_join_q_9_cmpReg_q : signal is true;
    signal redist5_Add1_split_join_q_9_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_Add1_split_join_q_9_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_Add1_split_join_q_9_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist5_Add1_split_join_q_9_sticky_ena_q : signal is true;
    signal redist5_Add1_split_join_q_9_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_reset0 : std_logic;
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ena_OrRstB : std_logic;
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ia : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_iq : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve_syn_only of redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i : signal is true;
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_eq : std_logic;
    attribute preserve_syn_only of redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_eq : signal is true;
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist6_r_uid140_zCount_uid78_Divide_q_12_cmpReg_q : signal is true;
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve_syn_only of redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena_q : signal is true;
    signal redist6_r_uid140_zCount_uid78_Divide_q_12_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist5_Add1_split_join_q_9_notEnable(LOGICAL,334)
    redist5_Add1_split_join_q_9_notEnable_q <= not (VCC_q);

    -- redist5_Add1_split_join_q_9_nor(LOGICAL,335)
    redist5_Add1_split_join_q_9_nor_q <= STD_LOGIC_VECTOR(not (redist5_Add1_split_join_q_9_notEnable_q or redist5_Add1_split_join_q_9_sticky_ena_q));

    -- redist5_Add1_split_join_q_9_mem_last(CONSTANT,331)
    redist5_Add1_split_join_q_9_mem_last_q <= "0110";

    -- redist5_Add1_split_join_q_9_cmp(LOGICAL,332)
    redist5_Add1_split_join_q_9_cmp_b <= STD_LOGIC_VECTOR("0" & redist5_Add1_split_join_q_9_rdcnt_q);
    redist5_Add1_split_join_q_9_cmp_q <= "1" WHEN redist5_Add1_split_join_q_9_mem_last_q = redist5_Add1_split_join_q_9_cmp_b ELSE "0";

    -- redist5_Add1_split_join_q_9_cmpReg(REG,333)
    redist5_Add1_split_join_q_9_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist5_Add1_split_join_q_9_cmpReg_q <= "0";
            ELSE
                redist5_Add1_split_join_q_9_cmpReg_q <= redist5_Add1_split_join_q_9_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist5_Add1_split_join_q_9_sticky_ena(REG,336)
    redist5_Add1_split_join_q_9_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist5_Add1_split_join_q_9_sticky_ena_q <= "0";
            ELSE
                IF (redist5_Add1_split_join_q_9_nor_q = "1") THEN
                    redist5_Add1_split_join_q_9_sticky_ena_q <= redist5_Add1_split_join_q_9_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist5_Add1_split_join_q_9_enaAnd(LOGICAL,337)
    redist5_Add1_split_join_q_9_enaAnd_q <= STD_LOGIC_VECTOR(redist5_Add1_split_join_q_9_sticky_ena_q and VCC_q);

    -- redist5_Add1_split_join_q_9_rdcnt(COUNTER,329)
    -- low=0, high=7, step=1, init=0
    redist5_Add1_split_join_q_9_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist5_Add1_split_join_q_9_rdcnt_i <= TO_UNSIGNED(0, 3);
            ELSE
                redist5_Add1_split_join_q_9_rdcnt_i <= redist5_Add1_split_join_q_9_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist5_Add1_split_join_q_9_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist5_Add1_split_join_q_9_rdcnt_i, 3));

    -- redist13_GPIn_in_1_Voltage_range_int16_tpl_3(DELAY,307)
    redist13_GPIn_in_1_Voltage_range_int16_tpl_3_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist13_GPIn_in_1_Voltage_range_int16_tpl_3_delay_0 <= (others => '0');
            ELSE
                redist13_GPIn_in_1_Voltage_range_int16_tpl_3_delay_0 <= STD_LOGIC_VECTOR(in_1_Voltage_range_int16_tpl);
            END IF;
        END IF;
    END PROCESS;
    redist13_GPIn_in_1_Voltage_range_int16_tpl_3_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist13_GPIn_in_1_Voltage_range_int16_tpl_3_delay_1 <= redist13_GPIn_in_1_Voltage_range_int16_tpl_3_delay_0;
                redist13_GPIn_in_1_Voltage_range_int16_tpl_3_q <= STD_LOGIC_VECTOR(redist13_GPIn_in_1_Voltage_range_int16_tpl_3_delay_1);
            END IF;
        END IF;
    END PROCESS;

    -- Add1_PreShift_0(BITSHIFT,35)@3
    Add1_PreShift_0_qint <= redist13_GPIn_in_1_Voltage_range_int16_tpl_3_q & "000000";
    Add1_PreShift_0_q <= Add1_PreShift_0_qint(21 downto 0);

    -- Add1_lhsMSBs_select(BITSELECT,186)@3
    Add1_lhsMSBs_select_b <= Add1_PreShift_0_q(21 downto 6);

    -- Add1_MSBs_sums(ADD,187)@3
    Add1_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => Add1_lhsMSBs_select_b(15)) & Add1_lhsMSBs_select_b));
    Add1_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 10 => Add1_rhsMSBs_select_bit_select_merged_b(9)) & Add1_rhsMSBs_select_bit_select_merged_b));
    Add1_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(Add1_MSBs_sums_a) + SIGNED(Add1_MSBs_sums_b));
    Add1_MSBs_sums_q <= STD_LOGIC_VECTOR(Add1_MSBs_sums_o(16 downto 0));

    -- Add1_rhsMSBs_select_bit_select_merged(BITSELECT,284)@3
    Add1_rhsMSBs_select_bit_select_merged_b <= in_2_VoltageA_sfix16_En6_tpl(15 downto 6);
    Add1_rhsMSBs_select_bit_select_merged_c <= in_2_VoltageA_sfix16_En6_tpl(5 downto 0);

    -- Add1_split_join(BITJOIN,188)@3
    Add1_split_join_q <= Add1_MSBs_sums_q & Add1_rhsMSBs_select_bit_select_merged_c;

    -- redist5_Add1_split_join_q_9_wraddr(REG,330)
    redist5_Add1_split_join_q_9_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist5_Add1_split_join_q_9_wraddr_q <= "111";
            ELSE
                redist5_Add1_split_join_q_9_wraddr_q <= redist5_Add1_split_join_q_9_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist5_Add1_split_join_q_9_mem(DUALMEM,328)
    redist5_Add1_split_join_q_9_mem_ia <= STD_LOGIC_VECTOR(Add1_split_join_q);
    redist5_Add1_split_join_q_9_mem_aa <= redist5_Add1_split_join_q_9_wraddr_q;
    redist5_Add1_split_join_q_9_mem_ab <= redist5_Add1_split_join_q_9_rdcnt_q;
    redist5_Add1_split_join_q_9_mem_ena_OrRstB <= areset or redist5_Add1_split_join_q_9_enaAnd_q(0);
    redist5_Add1_split_join_q_9_mem_reset0 <= areset;
    redist5_Add1_split_join_q_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 23,
        widthad_b => 3,
        numwords_b => 8,
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
        intended_device_family => "Agilex 3"
    )
    PORT MAP (
        clocken1 => redist5_Add1_split_join_q_9_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist5_Add1_split_join_q_9_mem_reset0,
        clock1 => clk,
        address_a => redist5_Add1_split_join_q_9_mem_aa,
        data_a => redist5_Add1_split_join_q_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist5_Add1_split_join_q_9_mem_ab,
        q_b => redist5_Add1_split_join_q_9_mem_iq
    );
    redist5_Add1_split_join_q_9_mem_q <= STD_LOGIC_VECTOR(redist5_Add1_split_join_q_9_mem_iq(22 downto 0));

    -- cstOvf_uid110_Divide_q_const(CONSTANT,175)
    cstOvf_uid110_Divide_q_const_q <= "0111111111111111111";

    -- oneInvRes_uid92_Divide(CONSTANT,91)
    oneInvRes_uid92_Divide_q <= "10000000000000000000";

    -- memoryC2_uid148_invTabGen(LOOKUP,147)@0
    memoryC2_uid148_invTabGen_combproc: PROCESS (yAddr_uid88_Divide_bit_select_merged_b)
    BEGIN
        -- Begin reserved scope level
        CASE (yAddr_uid88_Divide_bit_select_merged_b) IS
            WHEN "0000000" => memoryC2_uid148_invTabGen_q <= "0111111010";
            WHEN "0000001" => memoryC2_uid148_invTabGen_q <= "0111110000";
            WHEN "0000010" => memoryC2_uid148_invTabGen_q <= "0111100011";
            WHEN "0000011" => memoryC2_uid148_invTabGen_q <= "0111011000";
            WHEN "0000100" => memoryC2_uid148_invTabGen_q <= "0111001111";
            WHEN "0000101" => memoryC2_uid148_invTabGen_q <= "0111000101";
            WHEN "0000110" => memoryC2_uid148_invTabGen_q <= "0110111010";
            WHEN "0000111" => memoryC2_uid148_invTabGen_q <= "0110110001";
            WHEN "0001000" => memoryC2_uid148_invTabGen_q <= "0110100110";
            WHEN "0001001" => memoryC2_uid148_invTabGen_q <= "0110011100";
            WHEN "0001010" => memoryC2_uid148_invTabGen_q <= "0110010100";
            WHEN "0001011" => memoryC2_uid148_invTabGen_q <= "0110001001";
            WHEN "0001100" => memoryC2_uid148_invTabGen_q <= "0110000001";
            WHEN "0001101" => memoryC2_uid148_invTabGen_q <= "0101111010";
            WHEN "0001110" => memoryC2_uid148_invTabGen_q <= "0101110010";
            WHEN "0001111" => memoryC2_uid148_invTabGen_q <= "0101101101";
            WHEN "0010000" => memoryC2_uid148_invTabGen_q <= "0101100011";
            WHEN "0010001" => memoryC2_uid148_invTabGen_q <= "0101011100";
            WHEN "0010010" => memoryC2_uid148_invTabGen_q <= "0101010101";
            WHEN "0010011" => memoryC2_uid148_invTabGen_q <= "0101001101";
            WHEN "0010100" => memoryC2_uid148_invTabGen_q <= "0101000111";
            WHEN "0010101" => memoryC2_uid148_invTabGen_q <= "0101000010";
            WHEN "0010110" => memoryC2_uid148_invTabGen_q <= "0100111011";
            WHEN "0010111" => memoryC2_uid148_invTabGen_q <= "0100110101";
            WHEN "0011000" => memoryC2_uid148_invTabGen_q <= "0100110000";
            WHEN "0011001" => memoryC2_uid148_invTabGen_q <= "0100100110";
            WHEN "0011010" => memoryC2_uid148_invTabGen_q <= "0100100011";
            WHEN "0011011" => memoryC2_uid148_invTabGen_q <= "0100100000";
            WHEN "0011100" => memoryC2_uid148_invTabGen_q <= "0100010111";
            WHEN "0011101" => memoryC2_uid148_invTabGen_q <= "0100010010";
            WHEN "0011110" => memoryC2_uid148_invTabGen_q <= "0100001100";
            WHEN "0011111" => memoryC2_uid148_invTabGen_q <= "0100000111";
            WHEN "0100000" => memoryC2_uid148_invTabGen_q <= "0100000011";
            WHEN "0100001" => memoryC2_uid148_invTabGen_q <= "0011111111";
            WHEN "0100010" => memoryC2_uid148_invTabGen_q <= "0011111010";
            WHEN "0100011" => memoryC2_uid148_invTabGen_q <= "0011110101";
            WHEN "0100100" => memoryC2_uid148_invTabGen_q <= "0011110000";
            WHEN "0100101" => memoryC2_uid148_invTabGen_q <= "0011101100";
            WHEN "0100110" => memoryC2_uid148_invTabGen_q <= "0011101001";
            WHEN "0100111" => memoryC2_uid148_invTabGen_q <= "0011100100";
            WHEN "0101000" => memoryC2_uid148_invTabGen_q <= "0011100000";
            WHEN "0101001" => memoryC2_uid148_invTabGen_q <= "0011011100";
            WHEN "0101010" => memoryC2_uid148_invTabGen_q <= "0011011000";
            WHEN "0101011" => memoryC2_uid148_invTabGen_q <= "0011010101";
            WHEN "0101100" => memoryC2_uid148_invTabGen_q <= "0011010001";
            WHEN "0101101" => memoryC2_uid148_invTabGen_q <= "0011001101";
            WHEN "0101110" => memoryC2_uid148_invTabGen_q <= "0011001011";
            WHEN "0101111" => memoryC2_uid148_invTabGen_q <= "0011001000";
            WHEN "0110000" => memoryC2_uid148_invTabGen_q <= "0011000100";
            WHEN "0110001" => memoryC2_uid148_invTabGen_q <= "0010111111";
            WHEN "0110010" => memoryC2_uid148_invTabGen_q <= "0010111100";
            WHEN "0110011" => memoryC2_uid148_invTabGen_q <= "0010111010";
            WHEN "0110100" => memoryC2_uid148_invTabGen_q <= "0010110101";
            WHEN "0110101" => memoryC2_uid148_invTabGen_q <= "0010110010";
            WHEN "0110110" => memoryC2_uid148_invTabGen_q <= "0010110001";
            WHEN "0110111" => memoryC2_uid148_invTabGen_q <= "0010101110";
            WHEN "0111000" => memoryC2_uid148_invTabGen_q <= "0010101010";
            WHEN "0111001" => memoryC2_uid148_invTabGen_q <= "0010101010";
            WHEN "0111010" => memoryC2_uid148_invTabGen_q <= "0010100100";
            WHEN "0111011" => memoryC2_uid148_invTabGen_q <= "0010100100";
            WHEN "0111100" => memoryC2_uid148_invTabGen_q <= "0010100010";
            WHEN "0111101" => memoryC2_uid148_invTabGen_q <= "0010011111";
            WHEN "0111110" => memoryC2_uid148_invTabGen_q <= "0010011100";
            WHEN "0111111" => memoryC2_uid148_invTabGen_q <= "0010011000";
            WHEN "1000000" => memoryC2_uid148_invTabGen_q <= "0010010101";
            WHEN "1000001" => memoryC2_uid148_invTabGen_q <= "0010010101";
            WHEN "1000010" => memoryC2_uid148_invTabGen_q <= "0010010010";
            WHEN "1000011" => memoryC2_uid148_invTabGen_q <= "0010010000";
            WHEN "1000100" => memoryC2_uid148_invTabGen_q <= "0010001110";
            WHEN "1000101" => memoryC2_uid148_invTabGen_q <= "0010001100";
            WHEN "1000110" => memoryC2_uid148_invTabGen_q <= "0010000110";
            WHEN "1000111" => memoryC2_uid148_invTabGen_q <= "0010001000";
            WHEN "1001000" => memoryC2_uid148_invTabGen_q <= "0010000101";
            WHEN "1001001" => memoryC2_uid148_invTabGen_q <= "0010000100";
            WHEN "1001010" => memoryC2_uid148_invTabGen_q <= "0010000100";
            WHEN "1001011" => memoryC2_uid148_invTabGen_q <= "0010000000";
            WHEN "1001100" => memoryC2_uid148_invTabGen_q <= "0001111101";
            WHEN "1001101" => memoryC2_uid148_invTabGen_q <= "0001111100";
            WHEN "1001110" => memoryC2_uid148_invTabGen_q <= "0001111011";
            WHEN "1001111" => memoryC2_uid148_invTabGen_q <= "0001111001";
            WHEN "1010000" => memoryC2_uid148_invTabGen_q <= "0001110110";
            WHEN "1010001" => memoryC2_uid148_invTabGen_q <= "0001110101";
            WHEN "1010010" => memoryC2_uid148_invTabGen_q <= "0001110011";
            WHEN "1010011" => memoryC2_uid148_invTabGen_q <= "0001110010";
            WHEN "1010100" => memoryC2_uid148_invTabGen_q <= "0001101111";
            WHEN "1010101" => memoryC2_uid148_invTabGen_q <= "0001101101";
            WHEN "1010110" => memoryC2_uid148_invTabGen_q <= "0001101100";
            WHEN "1010111" => memoryC2_uid148_invTabGen_q <= "0001101011";
            WHEN "1011000" => memoryC2_uid148_invTabGen_q <= "0001101010";
            WHEN "1011001" => memoryC2_uid148_invTabGen_q <= "0001101000";
            WHEN "1011010" => memoryC2_uid148_invTabGen_q <= "0001100111";
            WHEN "1011011" => memoryC2_uid148_invTabGen_q <= "0001100111";
            WHEN "1011100" => memoryC2_uid148_invTabGen_q <= "0001100100";
            WHEN "1011101" => memoryC2_uid148_invTabGen_q <= "0001100010";
            WHEN "1011110" => memoryC2_uid148_invTabGen_q <= "0001100010";
            WHEN "1011111" => memoryC2_uid148_invTabGen_q <= "0001100000";
            WHEN "1100000" => memoryC2_uid148_invTabGen_q <= "0001011110";
            WHEN "1100001" => memoryC2_uid148_invTabGen_q <= "0001011110";
            WHEN "1100010" => memoryC2_uid148_invTabGen_q <= "0001011100";
            WHEN "1100011" => memoryC2_uid148_invTabGen_q <= "0001011011";
            WHEN "1100100" => memoryC2_uid148_invTabGen_q <= "0001011010";
            WHEN "1100101" => memoryC2_uid148_invTabGen_q <= "0001011010";
            WHEN "1100110" => memoryC2_uid148_invTabGen_q <= "0001011000";
            WHEN "1100111" => memoryC2_uid148_invTabGen_q <= "0001011000";
            WHEN "1101000" => memoryC2_uid148_invTabGen_q <= "0001010111";
            WHEN "1101001" => memoryC2_uid148_invTabGen_q <= "0001010100";
            WHEN "1101010" => memoryC2_uid148_invTabGen_q <= "0001010010";
            WHEN "1101011" => memoryC2_uid148_invTabGen_q <= "0001010001";
            WHEN "1101100" => memoryC2_uid148_invTabGen_q <= "0001001111";
            WHEN "1101101" => memoryC2_uid148_invTabGen_q <= "0001001111";
            WHEN "1101110" => memoryC2_uid148_invTabGen_q <= "0001001111";
            WHEN "1101111" => memoryC2_uid148_invTabGen_q <= "0001001110";
            WHEN "1110000" => memoryC2_uid148_invTabGen_q <= "0001001100";
            WHEN "1110001" => memoryC2_uid148_invTabGen_q <= "0001001100";
            WHEN "1110010" => memoryC2_uid148_invTabGen_q <= "0001001101";
            WHEN "1110011" => memoryC2_uid148_invTabGen_q <= "0001001011";
            WHEN "1110100" => memoryC2_uid148_invTabGen_q <= "0001001010";
            WHEN "1110101" => memoryC2_uid148_invTabGen_q <= "0001001001";
            WHEN "1110110" => memoryC2_uid148_invTabGen_q <= "0001001000";
            WHEN "1110111" => memoryC2_uid148_invTabGen_q <= "0001000111";
            WHEN "1111000" => memoryC2_uid148_invTabGen_q <= "0001000101";
            WHEN "1111001" => memoryC2_uid148_invTabGen_q <= "0001000100";
            WHEN "1111010" => memoryC2_uid148_invTabGen_q <= "0001000100";
            WHEN "1111011" => memoryC2_uid148_invTabGen_q <= "0001000011";
            WHEN "1111100" => memoryC2_uid148_invTabGen_q <= "0001000010";
            WHEN "1111101" => memoryC2_uid148_invTabGen_q <= "0001000010";
            WHEN "1111110" => memoryC2_uid148_invTabGen_q <= "0001000000";
            WHEN "1111111" => memoryC2_uid148_invTabGen_q <= "0001000000";
            WHEN OTHERS => -- unreachable
                           memoryC2_uid148_invTabGen_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- leftShiftStage2Idx1Rng1_uid222_normY_uid79_Divide(BITSELECT,221)@0
    leftShiftStage2Idx1Rng1_uid222_normY_uid79_Divide_in <= leftShiftStage1_uid220_normY_uid79_Divide_q(14 downto 0);
    leftShiftStage2Idx1Rng1_uid222_normY_uid79_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage2Idx1Rng1_uid222_normY_uid79_Divide_in(14 downto 0));

    -- leftShiftStage2Idx1_uid223_normY_uid79_Divide(BITJOIN,222)@0
    leftShiftStage2Idx1_uid223_normY_uid79_Divide_q <= leftShiftStage2Idx1Rng1_uid222_normY_uid79_Divide_b & GND_q;

    -- leftShiftStage1Idx3Rng6_uid217_normY_uid79_Divide(BITSELECT,216)@0
    leftShiftStage1Idx3Rng6_uid217_normY_uid79_Divide_in <= leftShiftStage0_uid209_normY_uid79_Divide_q(9 downto 0);
    leftShiftStage1Idx3Rng6_uid217_normY_uid79_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage1Idx3Rng6_uid217_normY_uid79_Divide_in(9 downto 0));

    -- leftShiftStage1Idx3Pad6_uid216_normY_uid79_Divide(CONSTANT,215)
    leftShiftStage1Idx3Pad6_uid216_normY_uid79_Divide_q <= "000000";

    -- leftShiftStage1Idx3_uid218_normY_uid79_Divide(BITJOIN,217)@0
    leftShiftStage1Idx3_uid218_normY_uid79_Divide_q <= leftShiftStage1Idx3Rng6_uid217_normY_uid79_Divide_b & leftShiftStage1Idx3Pad6_uid216_normY_uid79_Divide_q;

    -- leftShiftStage1Idx2Rng4_uid214_normY_uid79_Divide(BITSELECT,213)@0
    leftShiftStage1Idx2Rng4_uid214_normY_uid79_Divide_in <= leftShiftStage0_uid209_normY_uid79_Divide_q(11 downto 0);
    leftShiftStage1Idx2Rng4_uid214_normY_uid79_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage1Idx2Rng4_uid214_normY_uid79_Divide_in(11 downto 0));

    -- zs_uid125_zCount_uid78_Divide(CONSTANT,124)
    zs_uid125_zCount_uid78_Divide_q <= "0000";

    -- leftShiftStage1Idx2_uid215_normY_uid79_Divide(BITJOIN,214)@0
    leftShiftStage1Idx2_uid215_normY_uid79_Divide_q <= leftShiftStage1Idx2Rng4_uid214_normY_uid79_Divide_b & zs_uid125_zCount_uid78_Divide_q;

    -- leftShiftStage1Idx1Rng2_uid211_normY_uid79_Divide(BITSELECT,210)@0
    leftShiftStage1Idx1Rng2_uid211_normY_uid79_Divide_in <= leftShiftStage0_uid209_normY_uid79_Divide_q(13 downto 0);
    leftShiftStage1Idx1Rng2_uid211_normY_uid79_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage1Idx1Rng2_uid211_normY_uid79_Divide_in(13 downto 0));

    -- zs_uid131_zCount_uid78_Divide(CONSTANT,130)
    zs_uid131_zCount_uid78_Divide_q <= "00";

    -- leftShiftStage1Idx1_uid212_normY_uid79_Divide(BITJOIN,211)@0
    leftShiftStage1Idx1_uid212_normY_uid79_Divide_q <= leftShiftStage1Idx1Rng2_uid211_normY_uid79_Divide_b & zs_uid131_zCount_uid78_Divide_q;

    -- zs_uid113_zCount_uid78_Divide(CONSTANT,112)
    zs_uid113_zCount_uid78_Divide_q <= "0000000000000000";

    -- leftShiftStage0Idx1Rng8_uid204_normY_uid79_Divide(BITSELECT,203)@0
    leftShiftStage0Idx1Rng8_uid204_normY_uid79_Divide_in <= yPS_uid77_Divide_b(7 downto 0);
    leftShiftStage0Idx1Rng8_uid204_normY_uid79_Divide_b <= STD_LOGIC_VECTOR(leftShiftStage0Idx1Rng8_uid204_normY_uid79_Divide_in(7 downto 0));

    -- zs_uid119_zCount_uid78_Divide(CONSTANT,118)
    zs_uid119_zCount_uid78_Divide_q <= "00000000";

    -- leftShiftStage0Idx1_uid205_normY_uid79_Divide(BITJOIN,204)@0
    leftShiftStage0Idx1_uid205_normY_uid79_Divide_q <= leftShiftStage0Idx1Rng8_uid204_normY_uid79_Divide_b & zs_uid119_zCount_uid78_Divide_q;

    -- sR_mergedSignalTM_uid44_Const_Mult_x(BITJOIN,43)@0
    sR_mergedSignalTM_uid44_Const_Mult_x_q <= in_1_Voltage_range_int16_tpl & GND_q;

    -- Const_Mult_PostCast_primWireOut_sel_x(BITSELECT,28)@0
    Const_Mult_PostCast_primWireOut_sel_x_b <= sR_mergedSignalTM_uid44_Const_Mult_x_q(15 downto 0);

    -- Const_Mult_PostCast_primWireOut_hconst_x(CONSTANT,3)
    Const_Mult_PostCast_primWireOut_hconst_x_q <= "0111111111111111";

    -- Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_top_X_264(BITSELECT,263)@0
    Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_top_X_264_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 17 => sR_mergedSignalTM_uid44_Const_Mult_x_q(16)) & sR_mergedSignalTM_uid44_Const_Mult_x_q));
    Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_top_X_264_b <= Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_top_X_264_in(16 downto 15);

    -- Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op_top_X_266(LOGICAL,265)@0
    Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op_top_X_266_q <= "1" WHEN Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_top_X_264_b /= "00" ELSE "0";

    -- Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_msb_X_263(BITSELECT,262)@0
    Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_msb_X_263_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 17 => sR_mergedSignalTM_uid44_Const_Mult_x_q(16)) & sR_mergedSignalTM_uid44_Const_Mult_x_q));
    Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_msb_X_263_b <= Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_msb_X_263_in(17 downto 17);

    -- Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_not_msb_X_265(LOGICAL,264)@0
    Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_not_msb_X_265_q <= STD_LOGIC_VECTOR(not (Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_bit_select_msb_X_263_b));

    -- Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op2_267(LOGICAL,266)@0
    Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op2_267_q <= STD_LOGIC_VECTOR(Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_not_msb_X_265_q and Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op_top_X_266_q);

    -- Const_Mult_PostCast_primWireOut_lconst_x(CONSTANT,5)
    Const_Mult_PostCast_primWireOut_lconst_x_q <= "1000000000000000";

    -- Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_181(BITSELECT,180)@0
    Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_181_b <= sR_mergedSignalTM_uid44_Const_Mult_x_q(15 downto 15);

    -- Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_183(LOGICAL,182)@0
    Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_183_q <= "1" WHEN Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_top_X_181_b = "1" ELSE "0";

    -- Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_180(BITSELECT,179)@0
    Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_180_b <= sR_mergedSignalTM_uid44_Const_Mult_x_q(16 downto 16);

    -- Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_182(LOGICAL,181)@0
    Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_182_q <= STD_LOGIC_VECTOR(not (Const_Mult_PostCast_primWireOut_lcmp_x_bit_select_msb_X_180_b));

    -- Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_184(LOGICAL,183)@0
    Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_184_q <= STD_LOGIC_VECTOR(Const_Mult_PostCast_primWireOut_lcmp_x_not_msb_X_182_q or Const_Mult_PostCast_primWireOut_lcmp_x_logic_op_top_X_183_q);

    -- dupName_0_Const_Mult_PostCast_primWireOut_x(LOGICAL,33)@0
    dupName_0_Const_Mult_PostCast_primWireOut_x_q <= not (Const_Mult_PostCast_primWireOut_lcmp_x_logic_op2_184_q);

    -- Const_Mult_PostCast_primWireOut_mux_x(SELECTOR,6)@0
    Const_Mult_PostCast_primWireOut_mux_x_combproc: PROCESS (dupName_0_Const_Mult_PostCast_primWireOut_x_q, Const_Mult_PostCast_primWireOut_lconst_x_q, Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op2_267_q, Const_Mult_PostCast_primWireOut_hconst_x_q, Const_Mult_PostCast_primWireOut_sel_x_b)
    BEGIN
        Const_Mult_PostCast_primWireOut_mux_x_q <= Const_Mult_PostCast_primWireOut_sel_x_b;
        IF (Const_Mult_PostCast_primWireOut_hcmp_x_new_compare_to_178_logic_op2_267_q = "1") THEN
            Const_Mult_PostCast_primWireOut_mux_x_q <= Const_Mult_PostCast_primWireOut_hconst_x_q;
        END IF;
        IF (dupName_0_Const_Mult_PostCast_primWireOut_x_q = "1") THEN
            Const_Mult_PostCast_primWireOut_mux_x_q <= Const_Mult_PostCast_primWireOut_lconst_x_q;
        END IF;
    END PROCESS;

    -- xMSB_uid72_Divide(BITSELECT,71)@0
    xMSB_uid72_Divide_b <= Const_Mult_PostCast_primWireOut_mux_x_q(15 downto 15);

    -- yPSE_uid74_Divide(LOGICAL,73)@0
    yPSE_uid74_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => xMSB_uid72_Divide_b(0)) & xMSB_uid72_Divide_b));
    yPSE_uid74_Divide_q <= STD_LOGIC_VECTOR(Const_Mult_PostCast_primWireOut_mux_x_q xor yPSE_uid74_Divide_b);

    -- yPSEA_uid76_Divide(ADD,75)@0
    yPSEA_uid76_Divide_a <= STD_LOGIC_VECTOR("0" & yPSE_uid74_Divide_q);
    yPSEA_uid76_Divide_b <= STD_LOGIC_VECTOR("0000000000000000" & xMSB_uid72_Divide_b);
    yPSEA_uid76_Divide_o <= STD_LOGIC_VECTOR(UNSIGNED(yPSEA_uid76_Divide_a) + UNSIGNED(yPSEA_uid76_Divide_b));
    yPSEA_uid76_Divide_q <= STD_LOGIC_VECTOR(yPSEA_uid76_Divide_o(16 downto 0));

    -- yPS_uid77_Divide(BITSELECT,76)@0
    yPS_uid77_Divide_in <= STD_LOGIC_VECTOR(yPSEA_uid76_Divide_q(15 downto 0));
    yPS_uid77_Divide_b <= yPS_uid77_Divide_in(15 downto 0);

    -- leftShiftStage0_uid209_normY_uid79_Divide(MUX,208)@0
    leftShiftStage0_uid209_normY_uid79_Divide_s <= leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_b;
    leftShiftStage0_uid209_normY_uid79_Divide_combproc: PROCESS (leftShiftStage0_uid209_normY_uid79_Divide_s, yPS_uid77_Divide_b, leftShiftStage0Idx1_uid205_normY_uid79_Divide_q, zs_uid113_zCount_uid78_Divide_q)
    BEGIN
        CASE (leftShiftStage0_uid209_normY_uid79_Divide_s) IS
            WHEN "00" => leftShiftStage0_uid209_normY_uid79_Divide_q <= yPS_uid77_Divide_b;
            WHEN "01" => leftShiftStage0_uid209_normY_uid79_Divide_q <= leftShiftStage0Idx1_uid205_normY_uid79_Divide_q;
            WHEN "10" => leftShiftStage0_uid209_normY_uid79_Divide_q <= zs_uid113_zCount_uid78_Divide_q;
            WHEN "11" => leftShiftStage0_uid209_normY_uid79_Divide_q <= zs_uid113_zCount_uid78_Divide_q;
            WHEN OTHERS => leftShiftStage0_uid209_normY_uid79_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid220_normY_uid79_Divide(MUX,219)@0
    leftShiftStage1_uid220_normY_uid79_Divide_s <= leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_c;
    leftShiftStage1_uid220_normY_uid79_Divide_combproc: PROCESS (leftShiftStage1_uid220_normY_uid79_Divide_s, leftShiftStage0_uid209_normY_uid79_Divide_q, leftShiftStage1Idx1_uid212_normY_uid79_Divide_q, leftShiftStage1Idx2_uid215_normY_uid79_Divide_q, leftShiftStage1Idx3_uid218_normY_uid79_Divide_q)
    BEGIN
        CASE (leftShiftStage1_uid220_normY_uid79_Divide_s) IS
            WHEN "00" => leftShiftStage1_uid220_normY_uid79_Divide_q <= leftShiftStage0_uid209_normY_uid79_Divide_q;
            WHEN "01" => leftShiftStage1_uid220_normY_uid79_Divide_q <= leftShiftStage1Idx1_uid212_normY_uid79_Divide_q;
            WHEN "10" => leftShiftStage1_uid220_normY_uid79_Divide_q <= leftShiftStage1Idx2_uid215_normY_uid79_Divide_q;
            WHEN "11" => leftShiftStage1_uid220_normY_uid79_Divide_q <= leftShiftStage1Idx3_uid218_normY_uid79_Divide_q;
            WHEN OTHERS => leftShiftStage1_uid220_normY_uid79_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- vCount_uid115_zCount_uid78_Divide(LOGICAL,114)@0
    vCount_uid115_zCount_uid78_Divide_q <= "1" WHEN yPS_uid77_Divide_b = zs_uid113_zCount_uid78_Divide_q ELSE "0";

    -- mO_uid116_zCount_uid78_Divide(CONSTANT,115)
    mO_uid116_zCount_uid78_Divide_q <= "1111111111111111";

    -- vStagei_uid118_zCount_uid78_Divide(MUX,117)@0
    vStagei_uid118_zCount_uid78_Divide_s <= vCount_uid115_zCount_uid78_Divide_q;
    vStagei_uid118_zCount_uid78_Divide_combproc: PROCESS (vStagei_uid118_zCount_uid78_Divide_s, yPS_uid77_Divide_b, mO_uid116_zCount_uid78_Divide_q)
    BEGIN
        CASE (vStagei_uid118_zCount_uid78_Divide_s) IS
            WHEN "0" => vStagei_uid118_zCount_uid78_Divide_q <= yPS_uid77_Divide_b;
            WHEN "1" => vStagei_uid118_zCount_uid78_Divide_q <= mO_uid116_zCount_uid78_Divide_q;
            WHEN OTHERS => vStagei_uid118_zCount_uid78_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid120_zCount_uid78_Divide_bit_select_merged(BITSELECT,288)@0
    rVStage_uid120_zCount_uid78_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(vStagei_uid118_zCount_uid78_Divide_q(15 downto 8));
    rVStage_uid120_zCount_uid78_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(vStagei_uid118_zCount_uid78_Divide_q(7 downto 0));

    -- vCount_uid121_zCount_uid78_Divide(LOGICAL,120)@0
    vCount_uid121_zCount_uid78_Divide_q <= "1" WHEN rVStage_uid120_zCount_uid78_Divide_bit_select_merged_b = zs_uid119_zCount_uid78_Divide_q ELSE "0";

    -- vStagei_uid124_zCount_uid78_Divide(MUX,123)@0
    vStagei_uid124_zCount_uid78_Divide_s <= vCount_uid121_zCount_uid78_Divide_q;
    vStagei_uid124_zCount_uid78_Divide_combproc: PROCESS (vStagei_uid124_zCount_uid78_Divide_s, rVStage_uid120_zCount_uid78_Divide_bit_select_merged_b, rVStage_uid120_zCount_uid78_Divide_bit_select_merged_c)
    BEGIN
        CASE (vStagei_uid124_zCount_uid78_Divide_s) IS
            WHEN "0" => vStagei_uid124_zCount_uid78_Divide_q <= rVStage_uid120_zCount_uid78_Divide_bit_select_merged_b;
            WHEN "1" => vStagei_uid124_zCount_uid78_Divide_q <= rVStage_uid120_zCount_uid78_Divide_bit_select_merged_c;
            WHEN OTHERS => vStagei_uid124_zCount_uid78_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid126_zCount_uid78_Divide_bit_select_merged(BITSELECT,289)@0
    rVStage_uid126_zCount_uid78_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(vStagei_uid124_zCount_uid78_Divide_q(7 downto 4));
    rVStage_uid126_zCount_uid78_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(vStagei_uid124_zCount_uid78_Divide_q(3 downto 0));

    -- vCount_uid127_zCount_uid78_Divide(LOGICAL,126)@0
    vCount_uid127_zCount_uid78_Divide_q <= "1" WHEN rVStage_uid126_zCount_uid78_Divide_bit_select_merged_b = zs_uid125_zCount_uid78_Divide_q ELSE "0";

    -- vStagei_uid130_zCount_uid78_Divide(MUX,129)@0
    vStagei_uid130_zCount_uid78_Divide_s <= vCount_uid127_zCount_uid78_Divide_q;
    vStagei_uid130_zCount_uid78_Divide_combproc: PROCESS (vStagei_uid130_zCount_uid78_Divide_s, rVStage_uid126_zCount_uid78_Divide_bit_select_merged_b, rVStage_uid126_zCount_uid78_Divide_bit_select_merged_c)
    BEGIN
        CASE (vStagei_uid130_zCount_uid78_Divide_s) IS
            WHEN "0" => vStagei_uid130_zCount_uid78_Divide_q <= rVStage_uid126_zCount_uid78_Divide_bit_select_merged_b;
            WHEN "1" => vStagei_uid130_zCount_uid78_Divide_q <= rVStage_uid126_zCount_uid78_Divide_bit_select_merged_c;
            WHEN OTHERS => vStagei_uid130_zCount_uid78_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid132_zCount_uid78_Divide_bit_select_merged(BITSELECT,290)@0
    rVStage_uid132_zCount_uid78_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(vStagei_uid130_zCount_uid78_Divide_q(3 downto 2));
    rVStage_uid132_zCount_uid78_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(vStagei_uid130_zCount_uid78_Divide_q(1 downto 0));

    -- vCount_uid133_zCount_uid78_Divide(LOGICAL,132)@0
    vCount_uid133_zCount_uid78_Divide_q <= "1" WHEN rVStage_uid132_zCount_uid78_Divide_bit_select_merged_b = zs_uid131_zCount_uid78_Divide_q ELSE "0";

    -- vStagei_uid136_zCount_uid78_Divide(MUX,135)@0
    vStagei_uid136_zCount_uid78_Divide_s <= vCount_uid133_zCount_uid78_Divide_q;
    vStagei_uid136_zCount_uid78_Divide_combproc: PROCESS (vStagei_uid136_zCount_uid78_Divide_s, rVStage_uid132_zCount_uid78_Divide_bit_select_merged_b, rVStage_uid132_zCount_uid78_Divide_bit_select_merged_c)
    BEGIN
        CASE (vStagei_uid136_zCount_uid78_Divide_s) IS
            WHEN "0" => vStagei_uid136_zCount_uid78_Divide_q <= rVStage_uid132_zCount_uid78_Divide_bit_select_merged_b;
            WHEN "1" => vStagei_uid136_zCount_uid78_Divide_q <= rVStage_uid132_zCount_uid78_Divide_bit_select_merged_c;
            WHEN OTHERS => vStagei_uid136_zCount_uid78_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid138_zCount_uid78_Divide(BITSELECT,137)@0
    rVStage_uid138_zCount_uid78_Divide_b <= STD_LOGIC_VECTOR(vStagei_uid136_zCount_uid78_Divide_q(1 downto 1));

    -- vCount_uid139_zCount_uid78_Divide(LOGICAL,138)@0
    vCount_uid139_zCount_uid78_Divide_q <= "1" WHEN rVStage_uid138_zCount_uid78_Divide_b = GND_q ELSE "0";

    -- r_uid140_zCount_uid78_Divide(BITJOIN,139)@0
    r_uid140_zCount_uid78_Divide_q <= vCount_uid115_zCount_uid78_Divide_q & vCount_uid121_zCount_uid78_Divide_q & vCount_uid127_zCount_uid78_Divide_q & vCount_uid133_zCount_uid78_Divide_q & vCount_uid139_zCount_uid78_Divide_q;

    -- leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged(BITSELECT,291)@0
    leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(r_uid140_zCount_uid78_Divide_q(4 downto 3));
    leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(r_uid140_zCount_uid78_Divide_q(2 downto 1));
    leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_d <= STD_LOGIC_VECTOR(r_uid140_zCount_uid78_Divide_q(0 downto 0));

    -- leftShiftStage2_uid225_normY_uid79_Divide(MUX,224)@0
    leftShiftStage2_uid225_normY_uid79_Divide_s <= leftShiftStageSel0Dto3_uid208_normY_uid79_Divide_bit_select_merged_d;
    leftShiftStage2_uid225_normY_uid79_Divide_combproc: PROCESS (leftShiftStage2_uid225_normY_uid79_Divide_s, leftShiftStage1_uid220_normY_uid79_Divide_q, leftShiftStage2Idx1_uid223_normY_uid79_Divide_q)
    BEGIN
        CASE (leftShiftStage2_uid225_normY_uid79_Divide_s) IS
            WHEN "0" => leftShiftStage2_uid225_normY_uid79_Divide_q <= leftShiftStage1_uid220_normY_uid79_Divide_q;
            WHEN "1" => leftShiftStage2_uid225_normY_uid79_Divide_q <= leftShiftStage2Idx1_uid223_normY_uid79_Divide_q;
            WHEN OTHERS => leftShiftStage2_uid225_normY_uid79_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- normYNoLeadOne_uid80_Divide(BITSELECT,79)@0
    normYNoLeadOne_uid80_Divide_in <= leftShiftStage2_uid225_normY_uid79_Divide_q(14 downto 0);
    normYNoLeadOne_uid80_Divide_b <= STD_LOGIC_VECTOR(normYNoLeadOne_uid80_Divide_in(14 downto 0));

    -- yAddr_uid88_Divide_bit_select_merged(BITSELECT,287)@0
    yAddr_uid88_Divide_bit_select_merged_b <= STD_LOGIC_VECTOR(normYNoLeadOne_uid80_Divide_b(14 downto 8));
    yAddr_uid88_Divide_bit_select_merged_c <= STD_LOGIC_VECTOR(normYNoLeadOne_uid80_Divide_b(7 downto 0));

    -- prodXY_uid167_pT1_uid155_invPolyEval_cma(CHAINMULTADD,276)@0 + 4
    -- in b@3
    prodXY_uid167_pT1_uid155_invPolyEval_cma_reset <= areset;
    prodXY_uid167_pT1_uid155_invPolyEval_cma_ena0 <= '1';
    prodXY_uid167_pT1_uid155_invPolyEval_cma_ena1 <= prodXY_uid167_pT1_uid155_invPolyEval_cma_ena0;
    prodXY_uid167_pT1_uid155_invPolyEval_cma_ena2 <= prodXY_uid167_pT1_uid155_invPolyEval_cma_ena0;

    prodXY_uid167_pT1_uid155_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(yAddr_uid88_Divide_bit_select_merged_c),8));
    prodXY_uid167_pT1_uid155_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(memoryC2_uid148_invTabGen_q),11));
    prodXY_uid167_pT1_uid155_invPolyEval_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 8,
        ax_clken => "0",
        ax_width => 11,
        signed_may => "false",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 19,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => prodXY_uid167_pT1_uid155_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid167_pT1_uid155_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid167_pT1_uid155_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid167_pT1_uid155_invPolyEval_cma_reset,
        clr(1) => prodXY_uid167_pT1_uid155_invPolyEval_cma_reset,
        ay => prodXY_uid167_pT1_uid155_invPolyEval_cma_a0,
        ax => prodXY_uid167_pT1_uid155_invPolyEval_cma_c0,
        resulta => prodXY_uid167_pT1_uid155_invPolyEval_cma_s0
    );
    prodXY_uid167_pT1_uid155_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 19, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid167_pT1_uid155_invPolyEval_cma_s0, xout => prodXY_uid167_pT1_uid155_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid167_pT1_uid155_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid167_pT1_uid155_invPolyEval_cma_qq0(17 downto 0));

    -- osig_uid168_pT1_uid155_invPolyEval(BITSELECT,167)@4
    osig_uid168_pT1_uid155_invPolyEval_b <= prodXY_uid167_pT1_uid155_invPolyEval_cma_q(17 downto 7);

    -- highBBits_uid157_invPolyEval(BITSELECT,156)@4
    highBBits_uid157_invPolyEval_b <= osig_uid168_pT1_uid155_invPolyEval_b(10 downto 1);

    -- redist0_yAddr_uid88_Divide_bit_select_merged_b_4(DELAY,294)
    redist0_yAddr_uid88_Divide_bit_select_merged_b_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_0 <= (others => '0');
            ELSE
                redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_0 <= STD_LOGIC_VECTOR(yAddr_uid88_Divide_bit_select_merged_b);
            END IF;
        END IF;
    END PROCESS;
    redist0_yAddr_uid88_Divide_bit_select_merged_b_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_1 <= redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_0;
                redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_2 <= redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_1;
                redist0_yAddr_uid88_Divide_bit_select_merged_b_4_q <= STD_LOGIC_VECTOR(redist0_yAddr_uid88_Divide_bit_select_merged_b_4_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- memoryC1_uid145_invTabGen(LOOKUP,144)@4
    memoryC1_uid145_invTabGen_combproc: PROCESS (redist0_yAddr_uid88_Divide_bit_select_merged_b_4_q)
    BEGIN
        -- Begin reserved scope level
        CASE (redist0_yAddr_uid88_Divide_bit_select_merged_b_4_q) IS
            WHEN "0000000" => memoryC1_uid145_invTabGen_q <= "10000000000000010";
            WHEN "0000001" => memoryC1_uid145_invTabGen_q <= "10000001111110101";
            WHEN "0000010" => memoryC1_uid145_invTabGen_q <= "10000011111010100";
            WHEN "0000011" => memoryC1_uid145_invTabGen_q <= "10000101110011010";
            WHEN "0000100" => memoryC1_uid145_invTabGen_q <= "10000111101001000";
            WHEN "0000101" => memoryC1_uid145_invTabGen_q <= "10001001011100011";
            WHEN "0000110" => memoryC1_uid145_invTabGen_q <= "10001011001101010";
            WHEN "0000111" => memoryC1_uid145_invTabGen_q <= "10001100111011101";
            WHEN "0001000" => memoryC1_uid145_invTabGen_q <= "10001110100111110";
            WHEN "0001001" => memoryC1_uid145_invTabGen_q <= "10010000010001011";
            WHEN "0001010" => memoryC1_uid145_invTabGen_q <= "10010001111000011";
            WHEN "0001011" => memoryC1_uid145_invTabGen_q <= "10010011011101110";
            WHEN "0001100" => memoryC1_uid145_invTabGen_q <= "10010101000000101";
            WHEN "0001101" => memoryC1_uid145_invTabGen_q <= "10010110100001010";
            WHEN "0001110" => memoryC1_uid145_invTabGen_q <= "10011000000000000";
            WHEN "0001111" => memoryC1_uid145_invTabGen_q <= "10011001011100100";
            WHEN "0010000" => memoryC1_uid145_invTabGen_q <= "10011010110111101";
            WHEN "0010001" => memoryC1_uid145_invTabGen_q <= "10011100010000100";
            WHEN "0010010" => memoryC1_uid145_invTabGen_q <= "10011101100111101";
            WHEN "0010011" => memoryC1_uid145_invTabGen_q <= "10011110111101001";
            WHEN "0010100" => memoryC1_uid145_invTabGen_q <= "10100000010000110";
            WHEN "0010101" => memoryC1_uid145_invTabGen_q <= "10100001100010100";
            WHEN "0010110" => memoryC1_uid145_invTabGen_q <= "10100010110010111";
            WHEN "0010111" => memoryC1_uid145_invTabGen_q <= "10100100000001101";
            WHEN "0011000" => memoryC1_uid145_invTabGen_q <= "10100101001110110";
            WHEN "0011001" => memoryC1_uid145_invTabGen_q <= "10100110011010111";
            WHEN "0011010" => memoryC1_uid145_invTabGen_q <= "10100111100100111";
            WHEN "0011011" => memoryC1_uid145_invTabGen_q <= "10101000101101010";
            WHEN "0011100" => memoryC1_uid145_invTabGen_q <= "10101001110101001";
            WHEN "0011101" => memoryC1_uid145_invTabGen_q <= "10101010111011000";
            WHEN "0011110" => memoryC1_uid145_invTabGen_q <= "10101011111111111";
            WHEN "0011111" => memoryC1_uid145_invTabGen_q <= "10101101000011010";
            WHEN "0100000" => memoryC1_uid145_invTabGen_q <= "10101110000101011";
            WHEN "0100001" => memoryC1_uid145_invTabGen_q <= "10101111000110001";
            WHEN "0100010" => memoryC1_uid145_invTabGen_q <= "10110000000101111";
            WHEN "0100011" => memoryC1_uid145_invTabGen_q <= "10110001000100100";
            WHEN "0100100" => memoryC1_uid145_invTabGen_q <= "10110010000010000";
            WHEN "0100101" => memoryC1_uid145_invTabGen_q <= "10110010111110010";
            WHEN "0100110" => memoryC1_uid145_invTabGen_q <= "10110011111001011";
            WHEN "0100111" => memoryC1_uid145_invTabGen_q <= "10110100110011100";
            WHEN "0101000" => memoryC1_uid145_invTabGen_q <= "10110101101100110";
            WHEN "0101001" => memoryC1_uid145_invTabGen_q <= "10110110100100110";
            WHEN "0101010" => memoryC1_uid145_invTabGen_q <= "10110111011100000";
            WHEN "0101011" => memoryC1_uid145_invTabGen_q <= "10111000010010000";
            WHEN "0101100" => memoryC1_uid145_invTabGen_q <= "10111001000111010";
            WHEN "0101101" => memoryC1_uid145_invTabGen_q <= "10111001111011101";
            WHEN "0101110" => memoryC1_uid145_invTabGen_q <= "10111010101110111";
            WHEN "0101111" => memoryC1_uid145_invTabGen_q <= "10111011100001010";
            WHEN "0110000" => memoryC1_uid145_invTabGen_q <= "10111100010011000";
            WHEN "0110001" => memoryC1_uid145_invTabGen_q <= "10111101000100000";
            WHEN "0110010" => memoryC1_uid145_invTabGen_q <= "10111101110100001";
            WHEN "0110011" => memoryC1_uid145_invTabGen_q <= "10111110100011000";
            WHEN "0110100" => memoryC1_uid145_invTabGen_q <= "10111111010001110";
            WHEN "0110101" => memoryC1_uid145_invTabGen_q <= "10111111111111011";
            WHEN "0110110" => memoryC1_uid145_invTabGen_q <= "11000000101100001";
            WHEN "0110111" => memoryC1_uid145_invTabGen_q <= "11000001011000001";
            WHEN "0111000" => memoryC1_uid145_invTabGen_q <= "11000010000011111";
            WHEN "0111001" => memoryC1_uid145_invTabGen_q <= "11000010101110010";
            WHEN "0111010" => memoryC1_uid145_invTabGen_q <= "11000011011000110";
            WHEN "0111011" => memoryC1_uid145_invTabGen_q <= "11000100000001110";
            WHEN "0111100" => memoryC1_uid145_invTabGen_q <= "11000100101010011";
            WHEN "0111101" => memoryC1_uid145_invTabGen_q <= "11000101010010100";
            WHEN "0111110" => memoryC1_uid145_invTabGen_q <= "11000101111010000";
            WHEN "0111111" => memoryC1_uid145_invTabGen_q <= "11000110100001000";
            WHEN "1000000" => memoryC1_uid145_invTabGen_q <= "11000111000111011";
            WHEN "1000001" => memoryC1_uid145_invTabGen_q <= "11000111101100110";
            WHEN "1000010" => memoryC1_uid145_invTabGen_q <= "11001000010001110";
            WHEN "1000011" => memoryC1_uid145_invTabGen_q <= "11001000110110011";
            WHEN "1000100" => memoryC1_uid145_invTabGen_q <= "11001001011010001";
            WHEN "1000101" => memoryC1_uid145_invTabGen_q <= "11001001111101101";
            WHEN "1000110" => memoryC1_uid145_invTabGen_q <= "11001010100000111";
            WHEN "1000111" => memoryC1_uid145_invTabGen_q <= "11001011000010101";
            WHEN "1001000" => memoryC1_uid145_invTabGen_q <= "11001011100100101";
            WHEN "1001001" => memoryC1_uid145_invTabGen_q <= "11001100000101111";
            WHEN "1001010" => memoryC1_uid145_invTabGen_q <= "11001100100110011";
            WHEN "1001011" => memoryC1_uid145_invTabGen_q <= "11001101000110111";
            WHEN "1001100" => memoryC1_uid145_invTabGen_q <= "11001101100111000";
            WHEN "1001101" => memoryC1_uid145_invTabGen_q <= "11001110000110010";
            WHEN "1001110" => memoryC1_uid145_invTabGen_q <= "11001110100101001";
            WHEN "1001111" => memoryC1_uid145_invTabGen_q <= "11001111000011100";
            WHEN "1010000" => memoryC1_uid145_invTabGen_q <= "11001111100001111";
            WHEN "1010001" => memoryC1_uid145_invTabGen_q <= "11001111111111010";
            WHEN "1010010" => memoryC1_uid145_invTabGen_q <= "11010000011100101";
            WHEN "1010011" => memoryC1_uid145_invTabGen_q <= "11010000111001010";
            WHEN "1010100" => memoryC1_uid145_invTabGen_q <= "11010001010101110";
            WHEN "1010101" => memoryC1_uid145_invTabGen_q <= "11010001110001111";
            WHEN "1010110" => memoryC1_uid145_invTabGen_q <= "11010010001101011";
            WHEN "1010111" => memoryC1_uid145_invTabGen_q <= "11010010101000100";
            WHEN "1011000" => memoryC1_uid145_invTabGen_q <= "11010011000011010";
            WHEN "1011001" => memoryC1_uid145_invTabGen_q <= "11010011011101110";
            WHEN "1011010" => memoryC1_uid145_invTabGen_q <= "11010011110111111";
            WHEN "1011011" => memoryC1_uid145_invTabGen_q <= "11010100010001011";
            WHEN "1011100" => memoryC1_uid145_invTabGen_q <= "11010100101010111";
            WHEN "1011101" => memoryC1_uid145_invTabGen_q <= "11010101000100001";
            WHEN "1011110" => memoryC1_uid145_invTabGen_q <= "11010101011100101";
            WHEN "1011111" => memoryC1_uid145_invTabGen_q <= "11010101110101000";
            WHEN "1100000" => memoryC1_uid145_invTabGen_q <= "11010110001101010";
            WHEN "1100001" => memoryC1_uid145_invTabGen_q <= "11010110100100110";
            WHEN "1100010" => memoryC1_uid145_invTabGen_q <= "11010110111100010";
            WHEN "1100011" => memoryC1_uid145_invTabGen_q <= "11010111010011011";
            WHEN "1100100" => memoryC1_uid145_invTabGen_q <= "11010111101010001";
            WHEN "1100101" => memoryC1_uid145_invTabGen_q <= "11011000000000100";
            WHEN "1100110" => memoryC1_uid145_invTabGen_q <= "11011000010110110";
            WHEN "1100111" => memoryC1_uid145_invTabGen_q <= "11011000101100101";
            WHEN "1101000" => memoryC1_uid145_invTabGen_q <= "11011001000010001";
            WHEN "1101001" => memoryC1_uid145_invTabGen_q <= "11011001010111110";
            WHEN "1101010" => memoryC1_uid145_invTabGen_q <= "11011001101101000";
            WHEN "1101011" => memoryC1_uid145_invTabGen_q <= "11011010000001110";
            WHEN "1101100" => memoryC1_uid145_invTabGen_q <= "11011010010110100";
            WHEN "1101101" => memoryC1_uid145_invTabGen_q <= "11011010101010101";
            WHEN "1101110" => memoryC1_uid145_invTabGen_q <= "11011010111110101";
            WHEN "1101111" => memoryC1_uid145_invTabGen_q <= "11011011010010010";
            WHEN "1110000" => memoryC1_uid145_invTabGen_q <= "11011011100110000";
            WHEN "1110001" => memoryC1_uid145_invTabGen_q <= "11011011111001010";
            WHEN "1110010" => memoryC1_uid145_invTabGen_q <= "11011100001100000";
            WHEN "1110011" => memoryC1_uid145_invTabGen_q <= "11011100011110111";
            WHEN "1110100" => memoryC1_uid145_invTabGen_q <= "11011100110001101";
            WHEN "1110101" => memoryC1_uid145_invTabGen_q <= "11011101000011111";
            WHEN "1110110" => memoryC1_uid145_invTabGen_q <= "11011101010110001";
            WHEN "1110111" => memoryC1_uid145_invTabGen_q <= "11011101101000000";
            WHEN "1111000" => memoryC1_uid145_invTabGen_q <= "11011101111001111";
            WHEN "1111001" => memoryC1_uid145_invTabGen_q <= "11011110001011011";
            WHEN "1111010" => memoryC1_uid145_invTabGen_q <= "11011110011100101";
            WHEN "1111011" => memoryC1_uid145_invTabGen_q <= "11011110101101101";
            WHEN "1111100" => memoryC1_uid145_invTabGen_q <= "11011110111110101";
            WHEN "1111101" => memoryC1_uid145_invTabGen_q <= "11011111001111001";
            WHEN "1111110" => memoryC1_uid145_invTabGen_q <= "11011111011111110";
            WHEN "1111111" => memoryC1_uid145_invTabGen_q <= "11011111110000000";
            WHEN OTHERS => -- unreachable
                           memoryC1_uid145_invTabGen_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- s1sumAHighB_uid158_invPolyEval(ADD,157)@4
    s1sumAHighB_uid158_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 17 => memoryC1_uid145_invTabGen_q(16)) & memoryC1_uid145_invTabGen_q));
    s1sumAHighB_uid158_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 10 => highBBits_uid157_invPolyEval_b(9)) & highBBits_uid157_invPolyEval_b));
    s1sumAHighB_uid158_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s1sumAHighB_uid158_invPolyEval_a) + SIGNED(s1sumAHighB_uid158_invPolyEval_b));
    s1sumAHighB_uid158_invPolyEval_q <= STD_LOGIC_VECTOR(s1sumAHighB_uid158_invPolyEval_o(17 downto 0));

    -- lowRangeB_uid156_invPolyEval(BITSELECT,155)@4
    lowRangeB_uid156_invPolyEval_in <= osig_uid168_pT1_uid155_invPolyEval_b(0 downto 0);
    lowRangeB_uid156_invPolyEval_b <= STD_LOGIC_VECTOR(lowRangeB_uid156_invPolyEval_in(0 downto 0));

    -- s1_uid159_invPolyEval(BITJOIN,158)@4
    s1_uid159_invPolyEval_q <= s1sumAHighB_uid158_invPolyEval_q & lowRangeB_uid156_invPolyEval_b;

    -- redist2_yAddr_uid88_Divide_bit_select_merged_c_4(DELAY,296)
    redist2_yAddr_uid88_Divide_bit_select_merged_c_4_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_0 <= (others => '0');
            ELSE
                redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_0 <= STD_LOGIC_VECTOR(yAddr_uid88_Divide_bit_select_merged_c);
            END IF;
        END IF;
    END PROCESS;
    redist2_yAddr_uid88_Divide_bit_select_merged_c_4_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_1 <= redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_0;
                redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_2 <= redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_1;
                redist2_yAddr_uid88_Divide_bit_select_merged_c_4_q <= STD_LOGIC_VECTOR(redist2_yAddr_uid88_Divide_bit_select_merged_c_4_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- prodXY_uid170_pT2_uid161_invPolyEval_cma(CHAINMULTADD,277)@4 + 4
    -- in b@7
    prodXY_uid170_pT2_uid161_invPolyEval_cma_reset <= areset;
    prodXY_uid170_pT2_uid161_invPolyEval_cma_ena0 <= '1';
    prodXY_uid170_pT2_uid161_invPolyEval_cma_ena1 <= prodXY_uid170_pT2_uid161_invPolyEval_cma_ena0;
    prodXY_uid170_pT2_uid161_invPolyEval_cma_ena2 <= prodXY_uid170_pT2_uid161_invPolyEval_cma_ena0;

    prodXY_uid170_pT2_uid161_invPolyEval_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(redist2_yAddr_uid88_Divide_bit_select_merged_c_4_q),8));
    prodXY_uid170_pT2_uid161_invPolyEval_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(s1_uid159_invPolyEval_q),19));
    prodXY_uid170_pT2_uid161_invPolyEval_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m18x18_full",
        clear_type => "sclr",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 19,
        ax_clken => "0",
        ax_width => 8,
        signed_may => "true",
        signed_max => "false",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 27,
        bx_width => 0,
        by_width => 0,
        result_b_width => 0
    )
    PORT MAP (
        clk => clk,
        ena(0) => prodXY_uid170_pT2_uid161_invPolyEval_cma_ena0,
        ena(1) => prodXY_uid170_pT2_uid161_invPolyEval_cma_ena1,
        ena(2) => prodXY_uid170_pT2_uid161_invPolyEval_cma_ena2,
        clr(0) => prodXY_uid170_pT2_uid161_invPolyEval_cma_reset,
        clr(1) => prodXY_uid170_pT2_uid161_invPolyEval_cma_reset,
        ay => prodXY_uid170_pT2_uid161_invPolyEval_cma_c0,
        ax => prodXY_uid170_pT2_uid161_invPolyEval_cma_a0,
        resulta => prodXY_uid170_pT2_uid161_invPolyEval_cma_s0
    );
    prodXY_uid170_pT2_uid161_invPolyEval_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXY_uid170_pT2_uid161_invPolyEval_cma_s0, xout => prodXY_uid170_pT2_uid161_invPolyEval_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXY_uid170_pT2_uid161_invPolyEval_cma_q <= STD_LOGIC_VECTOR(prodXY_uid170_pT2_uid161_invPolyEval_cma_qq0(26 downto 0));

    -- osig_uid171_pT2_uid161_invPolyEval(BITSELECT,170)@8
    osig_uid171_pT2_uid161_invPolyEval_b <= prodXY_uid170_pT2_uid161_invPolyEval_cma_q(26 downto 7);

    -- highBBits_uid163_invPolyEval(BITSELECT,162)@8
    highBBits_uid163_invPolyEval_b <= osig_uid171_pT2_uid161_invPolyEval_b(19 downto 2);

    -- redist1_yAddr_uid88_Divide_bit_select_merged_b_8(DELAY,295)
    redist1_yAddr_uid88_Divide_bit_select_merged_b_8_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_0 <= (others => '0');
            ELSE
                redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_0 <= STD_LOGIC_VECTOR(redist0_yAddr_uid88_Divide_bit_select_merged_b_4_q);
            END IF;
        END IF;
    END PROCESS;
    redist1_yAddr_uid88_Divide_bit_select_merged_b_8_clkproc_1: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (false) THEN
            ELSE
                redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_1 <= redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_0;
                redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_2 <= redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_1;
                redist1_yAddr_uid88_Divide_bit_select_merged_b_8_q <= STD_LOGIC_VECTOR(redist1_yAddr_uid88_Divide_bit_select_merged_b_8_delay_2);
            END IF;
        END IF;
    END PROCESS;

    -- memoryC0_uid142_invTabGen(LOOKUP,141)@8
    memoryC0_uid142_invTabGen_combproc: PROCESS (redist1_yAddr_uid88_Divide_bit_select_merged_b_8_q)
    BEGIN
        -- Begin reserved scope level
        CASE (redist1_yAddr_uid88_Divide_bit_select_merged_b_8_q) IS
            WHEN "0000000" => memoryC0_uid142_invTabGen_q <= "0100000000000000000000100";
            WHEN "0000001" => memoryC0_uid142_invTabGen_q <= "0011111110000001000000000";
            WHEN "0000010" => memoryC0_uid142_invTabGen_q <= "0011111100000011111100100";
            WHEN "0000011" => memoryC0_uid142_invTabGen_q <= "0011111010001000110011010";
            WHEN "0000100" => memoryC0_uid142_invTabGen_q <= "0011111000001111100001100";
            WHEN "0000101" => memoryC0_uid142_invTabGen_q <= "0011110110011000000100011";
            WHEN "0000110" => memoryC0_uid142_invTabGen_q <= "0011110100100010011001011";
            WHEN "0000111" => memoryC0_uid142_invTabGen_q <= "0011110010101110011101111";
            WHEN "0001000" => memoryC0_uid142_invTabGen_q <= "0011110000111100001111100";
            WHEN "0001001" => memoryC0_uid142_invTabGen_q <= "0011101111001011101011111";
            WHEN "0001010" => memoryC0_uid142_invTabGen_q <= "0011101101011100110000110";
            WHEN "0001011" => memoryC0_uid142_invTabGen_q <= "0011101011101111011011101";
            WHEN "0001100" => memoryC0_uid142_invTabGen_q <= "0011101010000011101010100";
            WHEN "0001101" => memoryC0_uid142_invTabGen_q <= "0011101000011001011011010";
            WHEN "0001110" => memoryC0_uid142_invTabGen_q <= "0011100110110000101011110";
            WHEN "0001111" => memoryC0_uid142_invTabGen_q <= "0011100101001001011010000";
            WHEN "0010000" => memoryC0_uid142_invTabGen_q <= "0011100011100011100100000";
            WHEN "0010001" => memoryC0_uid142_invTabGen_q <= "0011100001111111001000000";
            WHEN "0010010" => memoryC0_uid142_invTabGen_q <= "0011100000011100000100000";
            WHEN "0010011" => memoryC0_uid142_invTabGen_q <= "0011011110111010010110010";
            WHEN "0010100" => memoryC0_uid142_invTabGen_q <= "0011011101011001111101000";
            WHEN "0010101" => memoryC0_uid142_invTabGen_q <= "0011011011111010110110101";
            WHEN "0010110" => memoryC0_uid142_invTabGen_q <= "0011011010011101000001011";
            WHEN "0010111" => memoryC0_uid142_invTabGen_q <= "0011011001000000011011101";
            WHEN "0011000" => memoryC0_uid142_invTabGen_q <= "0011010111100101000011111";
            WHEN "0011001" => memoryC0_uid142_invTabGen_q <= "0011010110001010111000100";
            WHEN "0011010" => memoryC0_uid142_invTabGen_q <= "0011010100110001111000001";
            WHEN "0011011" => memoryC0_uid142_invTabGen_q <= "0011010011011010000001011";
            WHEN "0011100" => memoryC0_uid142_invTabGen_q <= "0011010010000011010010100";
            WHEN "0011101" => memoryC0_uid142_invTabGen_q <= "0011010000101101101010100";
            WHEN "0011110" => memoryC0_uid142_invTabGen_q <= "0011001111011001000111110";
            WHEN "0011111" => memoryC0_uid142_invTabGen_q <= "0011001110000101101001001";
            WHEN "0100000" => memoryC0_uid142_invTabGen_q <= "0011001100110011001101010";
            WHEN "0100001" => memoryC0_uid142_invTabGen_q <= "0011001011100001110011000";
            WHEN "0100010" => memoryC0_uid142_invTabGen_q <= "0011001010010001011001000";
            WHEN "0100011" => memoryC0_uid142_invTabGen_q <= "0011001001000001111110001";
            WHEN "0100100" => memoryC0_uid142_invTabGen_q <= "0011000111110011100001010";
            WHEN "0100101" => memoryC0_uid142_invTabGen_q <= "0011000110100110000001010";
            WHEN "0100110" => memoryC0_uid142_invTabGen_q <= "0011000101011001011101000";
            WHEN "0100111" => memoryC0_uid142_invTabGen_q <= "0011000100001101110011100";
            WHEN "0101000" => memoryC0_uid142_invTabGen_q <= "0011000011000011000011100";
            WHEN "0101001" => memoryC0_uid142_invTabGen_q <= "0011000001111001001100010";
            WHEN "0101010" => memoryC0_uid142_invTabGen_q <= "0011000000110000001100100";
            WHEN "0101011" => memoryC0_uid142_invTabGen_q <= "0010111111101000000011100";
            WHEN "0101100" => memoryC0_uid142_invTabGen_q <= "0010111110100000110000001";
            WHEN "0101101" => memoryC0_uid142_invTabGen_q <= "0010111101011010010001100";
            WHEN "0101110" => memoryC0_uid142_invTabGen_q <= "0010111100010100100110110";
            WHEN "0101111" => memoryC0_uid142_invTabGen_q <= "0010111011001111101111000";
            WHEN "0110000" => memoryC0_uid142_invTabGen_q <= "0010111010001011101001010";
            WHEN "0110001" => memoryC0_uid142_invTabGen_q <= "0010111001001000010100110";
            WHEN "0110010" => memoryC0_uid142_invTabGen_q <= "0010111000000101110000101";
            WHEN "0110011" => memoryC0_uid142_invTabGen_q <= "0010110111000011111100010";
            WHEN "0110100" => memoryC0_uid142_invTabGen_q <= "0010110110000010110110100";
            WHEN "0110101" => memoryC0_uid142_invTabGen_q <= "0010110101000010011110111";
            WHEN "0110110" => memoryC0_uid142_invTabGen_q <= "0010110100000010110100100";
            WHEN "0110111" => memoryC0_uid142_invTabGen_q <= "0010110011000011110110110";
            WHEN "0111000" => memoryC0_uid142_invTabGen_q <= "0010110010000101100100101";
            WHEN "0111001" => memoryC0_uid142_invTabGen_q <= "0010110001000111111101110";
            WHEN "0111010" => memoryC0_uid142_invTabGen_q <= "0010110000001011000001001";
            WHEN "0111011" => memoryC0_uid142_invTabGen_q <= "0010101111001110101110011";
            WHEN "0111100" => memoryC0_uid142_invTabGen_q <= "0010101110010011000100101";
            WHEN "0111101" => memoryC0_uid142_invTabGen_q <= "0010101101011000000011010";
            WHEN "0111110" => memoryC0_uid142_invTabGen_q <= "0010101100011101101001101";
            WHEN "0111111" => memoryC0_uid142_invTabGen_q <= "0010101011100011110111001";
            WHEN "1000000" => memoryC0_uid142_invTabGen_q <= "0010101010101010101011001";
            WHEN "1000001" => memoryC0_uid142_invTabGen_q <= "0010101001110010000101001";
            WHEN "1000010" => memoryC0_uid142_invTabGen_q <= "0010101000111010000100100";
            WHEN "1000011" => memoryC0_uid142_invTabGen_q <= "0010101000000010101000100";
            WHEN "1000100" => memoryC0_uid142_invTabGen_q <= "0010100111001011110000111";
            WHEN "1000101" => memoryC0_uid142_invTabGen_q <= "0010100110010101011100110";
            WHEN "1000110" => memoryC0_uid142_invTabGen_q <= "0010100101011111101011110";
            WHEN "1000111" => memoryC0_uid142_invTabGen_q <= "0010100100101010011101100";
            WHEN "1001000" => memoryC0_uid142_invTabGen_q <= "0010100011110101110001001";
            WHEN "1001001" => memoryC0_uid142_invTabGen_q <= "0010100011000001100110011";
            WHEN "1001010" => memoryC0_uid142_invTabGen_q <= "0010100010001101111100110";
            WHEN "1001011" => memoryC0_uid142_invTabGen_q <= "0010100001011010110011101";
            WHEN "1001100" => memoryC0_uid142_invTabGen_q <= "0010100000101000001010100";
            WHEN "1001101" => memoryC0_uid142_invTabGen_q <= "0010011111110110000001001";
            WHEN "1001110" => memoryC0_uid142_invTabGen_q <= "0010011111000100010110111";
            WHEN "1001111" => memoryC0_uid142_invTabGen_q <= "0010011110010011001011011";
            WHEN "1010000" => memoryC0_uid142_invTabGen_q <= "0010011101100010011110000";
            WHEN "1010001" => memoryC0_uid142_invTabGen_q <= "0010011100110010001110101";
            WHEN "1010010" => memoryC0_uid142_invTabGen_q <= "0010011100000010011100100";
            WHEN "1010011" => memoryC0_uid142_invTabGen_q <= "0010011011010011000111100";
            WHEN "1010100" => memoryC0_uid142_invTabGen_q <= "0010011010100100001111000";
            WHEN "1010101" => memoryC0_uid142_invTabGen_q <= "0010011001110101110010101";
            WHEN "1010110" => memoryC0_uid142_invTabGen_q <= "0010011001000111110010001";
            WHEN "1010111" => memoryC0_uid142_invTabGen_q <= "0010011000011010001101000";
            WHEN "1011000" => memoryC0_uid142_invTabGen_q <= "0010010111101101000010111";
            WHEN "1011001" => memoryC0_uid142_invTabGen_q <= "0010010111000000010011011";
            WHEN "1011010" => memoryC0_uid142_invTabGen_q <= "0010010110010011111110001";
            WHEN "1011011" => memoryC0_uid142_invTabGen_q <= "0010010101101000000010111";
            WHEN "1011100" => memoryC0_uid142_invTabGen_q <= "0010010100111100100001001";
            WHEN "1011101" => memoryC0_uid142_invTabGen_q <= "0010010100010001011000100";
            WHEN "1011110" => memoryC0_uid142_invTabGen_q <= "0010010011100110101000111";
            WHEN "1011111" => memoryC0_uid142_invTabGen_q <= "0010010010111100010001110";
            WHEN "1100000" => memoryC0_uid142_invTabGen_q <= "0010010010010010010010110";
            WHEN "1100001" => memoryC0_uid142_invTabGen_q <= "0010010001101000101011110";
            WHEN "1100010" => memoryC0_uid142_invTabGen_q <= "0010010000111111011100010";
            WHEN "1100011" => memoryC0_uid142_invTabGen_q <= "0010010000010110100100000";
            WHEN "1100100" => memoryC0_uid142_invTabGen_q <= "0010001111101110000010110";
            WHEN "1100101" => memoryC0_uid142_invTabGen_q <= "0010001111000101111000001";
            WHEN "1100110" => memoryC0_uid142_invTabGen_q <= "0010001110011110000011111";
            WHEN "1100111" => memoryC0_uid142_invTabGen_q <= "0010001101110110100101101";
            WHEN "1101000" => memoryC0_uid142_invTabGen_q <= "0010001101001111011101010";
            WHEN "1101001" => memoryC0_uid142_invTabGen_q <= "0010001100101000101010010";
            WHEN "1101010" => memoryC0_uid142_invTabGen_q <= "0010001100000010001100100";
            WHEN "1101011" => memoryC0_uid142_invTabGen_q <= "0010001011011100000011110";
            WHEN "1101100" => memoryC0_uid142_invTabGen_q <= "0010001010110110001111101";
            WHEN "1101101" => memoryC0_uid142_invTabGen_q <= "0010001010010000110000000";
            WHEN "1101110" => memoryC0_uid142_invTabGen_q <= "0010001001101011100100100";
            WHEN "1101111" => memoryC0_uid142_invTabGen_q <= "0010001001000110101101000";
            WHEN "1110000" => memoryC0_uid142_invTabGen_q <= "0010001000100010001001000";
            WHEN "1110001" => memoryC0_uid142_invTabGen_q <= "0010000111111101111000100";
            WHEN "1110010" => memoryC0_uid142_invTabGen_q <= "0010000111011001111011010";
            WHEN "1110011" => memoryC0_uid142_invTabGen_q <= "0010000110110110010000111";
            WHEN "1110100" => memoryC0_uid142_invTabGen_q <= "0010000110010010111001001";
            WHEN "1110101" => memoryC0_uid142_invTabGen_q <= "0010000101101111110100000";
            WHEN "1110110" => memoryC0_uid142_invTabGen_q <= "0010000101001101000001000";
            WHEN "1110111" => memoryC0_uid142_invTabGen_q <= "0010000100101010100000001";
            WHEN "1111000" => memoryC0_uid142_invTabGen_q <= "0010000100001000010001000";
            WHEN "1111001" => memoryC0_uid142_invTabGen_q <= "0010000011100110010011100";
            WHEN "1111010" => memoryC0_uid142_invTabGen_q <= "0010000011000100100111011";
            WHEN "1111011" => memoryC0_uid142_invTabGen_q <= "0010000010100011001100100";
            WHEN "1111100" => memoryC0_uid142_invTabGen_q <= "0010000010000010000010100";
            WHEN "1111101" => memoryC0_uid142_invTabGen_q <= "0010000001100001001001011";
            WHEN "1111110" => memoryC0_uid142_invTabGen_q <= "0010000001000000100000110";
            WHEN "1111111" => memoryC0_uid142_invTabGen_q <= "0010000000100000001000100";
            WHEN OTHERS => -- unreachable
                           memoryC0_uid142_invTabGen_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- s2sumAHighB_uid164_invPolyEval(ADD,163)@8
    s2sumAHighB_uid164_invPolyEval_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 25 => memoryC0_uid142_invTabGen_q(24)) & memoryC0_uid142_invTabGen_q));
    s2sumAHighB_uid164_invPolyEval_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((25 downto 18 => highBBits_uid163_invPolyEval_b(17)) & highBBits_uid163_invPolyEval_b));
    s2sumAHighB_uid164_invPolyEval_o <= STD_LOGIC_VECTOR(SIGNED(s2sumAHighB_uid164_invPolyEval_a) + SIGNED(s2sumAHighB_uid164_invPolyEval_b));
    s2sumAHighB_uid164_invPolyEval_q <= STD_LOGIC_VECTOR(s2sumAHighB_uid164_invPolyEval_o(25 downto 0));

    -- lowRangeB_uid162_invPolyEval(BITSELECT,161)@8
    lowRangeB_uid162_invPolyEval_in <= osig_uid171_pT2_uid161_invPolyEval_b(1 downto 0);
    lowRangeB_uid162_invPolyEval_b <= STD_LOGIC_VECTOR(lowRangeB_uid162_invPolyEval_in(1 downto 0));

    -- s2_uid165_invPolyEval(BITJOIN,164)@8
    s2_uid165_invPolyEval_q <= s2sumAHighB_uid164_invPolyEval_q & lowRangeB_uid162_invPolyEval_b;

    -- fxpInverseRes_uid91_Divide(BITSELECT,90)@8
    fxpInverseRes_uid91_Divide_in <= s2_uid165_invPolyEval_q(25 downto 0);
    fxpInverseRes_uid91_Divide_b <= STD_LOGIC_VECTOR(fxpInverseRes_uid91_Divide_in(25 downto 6));

    -- normYIsOneC2_uid81_Divide(LOGICAL,82)@0
    normYIsOneC2_uid81_Divide_a <= STD_LOGIC_VECTOR("0" & normYNoLeadOne_uid80_Divide_b);
    normYIsOneC2_uid81_Divide_q <= "1" WHEN normYIsOneC2_uid81_Divide_a = zs_uid113_zCount_uid78_Divide_q ELSE "0";

    -- normYIsOneC2_uid84_Divide(BITSELECT,83)@0
    normYIsOneC2_uid84_Divide_b <= leftShiftStage2_uid225_normY_uid79_Divide_q(15 downto 15);

    -- normYIsOne_uid85_Divide(LOGICAL,84)@0 + 1
    normYIsOne_uid85_Divide_qi <= normYIsOneC2_uid84_Divide_b and normYIsOneC2_uid81_Divide_q;
    normYIsOne_uid85_Divide_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => normYIsOne_uid85_Divide_qi, xout => normYIsOne_uid85_Divide_q, clk => clk, aclr => areset, ena => '1' );

    -- redist8_normYIsOne_uid85_Divide_q_8(DELAY,302)
    redist8_normYIsOne_uid85_Divide_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => normYIsOne_uid85_Divide_q, xout => redist8_normYIsOne_uid85_Divide_q_8_q, clk => clk, aclr => areset, ena => '1' );

    -- invResPostOneHandling2_uid93_Divide(MUX,92)@8
    invResPostOneHandling2_uid93_Divide_s <= redist8_normYIsOne_uid85_Divide_q_8_q;
    invResPostOneHandling2_uid93_Divide_combproc: PROCESS (invResPostOneHandling2_uid93_Divide_s, fxpInverseRes_uid91_Divide_b, oneInvRes_uid92_Divide_q)
    BEGIN
        CASE (invResPostOneHandling2_uid93_Divide_s) IS
            WHEN "0" => invResPostOneHandling2_uid93_Divide_q <= fxpInverseRes_uid91_Divide_b;
            WHEN "1" => invResPostOneHandling2_uid93_Divide_q <= oneInvRes_uid92_Divide_q;
            WHEN OTHERS => invResPostOneHandling2_uid93_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist9_xMSB_uid72_Divide_b_8(DELAY,303)
    redist9_xMSB_uid72_Divide_b_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => xMSB_uid72_Divide_b, xout => redist9_xMSB_uid72_Divide_b_8_q, clk => clk, aclr => areset, ena => '1' );

    -- Const1(CONSTANT,12)
    Const1_q <= "01";

    -- xPSX_uid96_Divide(LOGICAL,95)@8
    xPSX_uid96_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => redist9_xMSB_uid72_Divide_b_8_q(0)) & redist9_xMSB_uid72_Divide_b_8_q));
    xPSX_uid96_Divide_q <= STD_LOGIC_VECTOR(Const1_q xor xPSX_uid96_Divide_b);

    -- zMsbY0_uid98_Divide(BITJOIN,97)@8
    zMsbY0_uid98_Divide_q <= GND_q & redist9_xMSB_uid72_Divide_b_8_q;

    -- prodXInvY_uid100_Divide_cma(CHAINMULTADD,275)@8 + 4
    -- in b@11
    prodXInvY_uid100_Divide_cma_reset <= areset;
    prodXInvY_uid100_Divide_cma_ena0 <= '1';
    prodXInvY_uid100_Divide_cma_ena1 <= prodXInvY_uid100_Divide_cma_ena0;
    prodXInvY_uid100_Divide_cma_ena2 <= prodXInvY_uid100_Divide_cma_ena0;

    prodXInvY_uid100_Divide_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(zMsbY0_uid98_Divide_q),2));
    prodXInvY_uid100_Divide_cma_b0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(xPSX_uid96_Divide_q),2));
    prodXInvY_uid100_Divide_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(invResPostOneHandling2_uid93_Divide_q),20));
    prodXInvY_uid100_Divide_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 2,
        operand_source_may => "preadder",
        az_clken => "0",
        az_width => 2,
        ax_clken => "0",
        ax_width => 20,
        signed_may => "true",
        signed_max => "false",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        output_clken => "1",
        result_a_width => 23
    )
    PORT MAP (
        clk => clk,
        ena(0) => prodXInvY_uid100_Divide_cma_ena0,
        ena(1) => prodXInvY_uid100_Divide_cma_ena1,
        ena(2) => prodXInvY_uid100_Divide_cma_ena2,
        clr(0) => prodXInvY_uid100_Divide_cma_reset,
        clr(1) => prodXInvY_uid100_Divide_cma_reset,
        ay => prodXInvY_uid100_Divide_cma_a0,
        az => prodXInvY_uid100_Divide_cma_b0,
        ax => prodXInvY_uid100_Divide_cma_c0,
        resulta => prodXInvY_uid100_Divide_cma_s0
    );
    prodXInvY_uid100_Divide_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 23, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => prodXInvY_uid100_Divide_cma_s0, xout => prodXInvY_uid100_Divide_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    prodXInvY_uid100_Divide_cma_q <= STD_LOGIC_VECTOR(prodXInvY_uid100_Divide_cma_qq0(22 downto 0));

    -- rightShiftInput_uid101_Divide(BITSELECT,100)@12
    rightShiftInput_uid101_Divide_in <= STD_LOGIC_VECTOR(prodXInvY_uid100_Divide_cma_q(21 downto 0));
    rightShiftInput_uid101_Divide_b <= rightShiftInput_uid101_Divide_in(21 downto 0);

    -- xMSB_uid227_prodPostRightShift_uid102_Divide(BITSELECT,226)@12
    xMSB_uid227_prodPostRightShift_uid102_Divide_b <= rightShiftInput_uid101_Divide_b(21 downto 21);

    -- seMsb_to12_uid247(BITSELECT,246)@12
    seMsb_to12_uid247_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 1 => xMSB_uid227_prodPostRightShift_uid102_Divide_b(0)) & xMSB_uid227_prodPostRightShift_uid102_Divide_b));
    seMsb_to12_uid247_b <= seMsb_to12_uid247_in(11 downto 0);

    -- rightShiftStage1Idx3Rng12_uid248_prodPostRightShift_uid102_Divide(BITSELECT,247)@12
    rightShiftStage1Idx3Rng12_uid248_prodPostRightShift_uid102_Divide_b <= rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q(21 downto 12);

    -- rightShiftStage1Idx3_uid249_prodPostRightShift_uid102_Divide(BITJOIN,248)@12
    rightShiftStage1Idx3_uid249_prodPostRightShift_uid102_Divide_q <= seMsb_to12_uid247_b & rightShiftStage1Idx3Rng12_uid248_prodPostRightShift_uid102_Divide_b;

    -- seMsb_to8_uid244(BITSELECT,243)@12
    seMsb_to8_uid244_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((7 downto 1 => xMSB_uid227_prodPostRightShift_uid102_Divide_b(0)) & xMSB_uid227_prodPostRightShift_uid102_Divide_b));
    seMsb_to8_uid244_b <= seMsb_to8_uid244_in(7 downto 0);

    -- rightShiftStage1Idx2Rng8_uid245_prodPostRightShift_uid102_Divide(BITSELECT,244)@12
    rightShiftStage1Idx2Rng8_uid245_prodPostRightShift_uid102_Divide_b <= rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q(21 downto 8);

    -- rightShiftStage1Idx2_uid246_prodPostRightShift_uid102_Divide(BITJOIN,245)@12
    rightShiftStage1Idx2_uid246_prodPostRightShift_uid102_Divide_q <= seMsb_to8_uid244_b & rightShiftStage1Idx2Rng8_uid245_prodPostRightShift_uid102_Divide_b;

    -- seMsb_to4_uid241(BITSELECT,240)@12
    seMsb_to4_uid241_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((3 downto 1 => xMSB_uid227_prodPostRightShift_uid102_Divide_b(0)) & xMSB_uid227_prodPostRightShift_uid102_Divide_b));
    seMsb_to4_uid241_b <= seMsb_to4_uid241_in(3 downto 0);

    -- rightShiftStage1Idx1Rng4_uid242_prodPostRightShift_uid102_Divide(BITSELECT,241)@12
    rightShiftStage1Idx1Rng4_uid242_prodPostRightShift_uid102_Divide_b <= rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q(21 downto 4);

    -- rightShiftStage1Idx1_uid243_prodPostRightShift_uid102_Divide(BITJOIN,242)@12
    rightShiftStage1Idx1_uid243_prodPostRightShift_uid102_Divide_q <= seMsb_to4_uid241_b & rightShiftStage1Idx1Rng4_uid242_prodPostRightShift_uid102_Divide_b;

    -- seMsb_to3_uid236(BITSELECT,235)@12
    seMsb_to3_uid236_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((2 downto 1 => xMSB_uid227_prodPostRightShift_uid102_Divide_b(0)) & xMSB_uid227_prodPostRightShift_uid102_Divide_b));
    seMsb_to3_uid236_b <= seMsb_to3_uid236_in(2 downto 0);

    -- rightShiftStage0Idx3Rng3_uid237_prodPostRightShift_uid102_Divide(BITSELECT,236)@12
    rightShiftStage0Idx3Rng3_uid237_prodPostRightShift_uid102_Divide_b <= rightShiftInput_uid101_Divide_b(21 downto 3);

    -- rightShiftStage0Idx3_uid238_prodPostRightShift_uid102_Divide(BITJOIN,237)@12
    rightShiftStage0Idx3_uid238_prodPostRightShift_uid102_Divide_q <= seMsb_to3_uid236_b & rightShiftStage0Idx3Rng3_uid237_prodPostRightShift_uid102_Divide_b;

    -- seMsb_to2_uid233(BITSELECT,232)@12
    seMsb_to2_uid233_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => xMSB_uid227_prodPostRightShift_uid102_Divide_b(0)) & xMSB_uid227_prodPostRightShift_uid102_Divide_b));
    seMsb_to2_uid233_b <= seMsb_to2_uid233_in(1 downto 0);

    -- rightShiftStage0Idx2Rng2_uid234_prodPostRightShift_uid102_Divide(BITSELECT,233)@12
    rightShiftStage0Idx2Rng2_uid234_prodPostRightShift_uid102_Divide_b <= rightShiftInput_uid101_Divide_b(21 downto 2);

    -- rightShiftStage0Idx2_uid235_prodPostRightShift_uid102_Divide(BITJOIN,234)@12
    rightShiftStage0Idx2_uid235_prodPostRightShift_uid102_Divide_q <= seMsb_to2_uid233_b & rightShiftStage0Idx2Rng2_uid234_prodPostRightShift_uid102_Divide_b;

    -- rightShiftStage0Idx1Rng1_uid231_prodPostRightShift_uid102_Divide(BITSELECT,230)@12
    rightShiftStage0Idx1Rng1_uid231_prodPostRightShift_uid102_Divide_b <= rightShiftInput_uid101_Divide_b(21 downto 1);

    -- rightShiftStage0Idx1_uid232_prodPostRightShift_uid102_Divide(BITJOIN,231)@12
    rightShiftStage0Idx1_uid232_prodPostRightShift_uid102_Divide_q <= xMSB_uid227_prodPostRightShift_uid102_Divide_b & rightShiftStage0Idx1Rng1_uid231_prodPostRightShift_uid102_Divide_b;

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_notEnable(LOGICAL,344)
    redist6_r_uid140_zCount_uid78_Divide_q_12_notEnable_q <= not (VCC_q);

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_nor(LOGICAL,345)
    redist6_r_uid140_zCount_uid78_Divide_q_12_nor_q <= STD_LOGIC_VECTOR(not (redist6_r_uid140_zCount_uid78_Divide_q_12_notEnable_q or redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena_q));

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_mem_last(CONSTANT,341)
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_last_q <= "01001";

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_cmp(LOGICAL,342)
    redist6_r_uid140_zCount_uid78_Divide_q_12_cmp_b <= STD_LOGIC_VECTOR("0" & redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_q);
    redist6_r_uid140_zCount_uid78_Divide_q_12_cmp_q <= "1" WHEN redist6_r_uid140_zCount_uid78_Divide_q_12_mem_last_q = redist6_r_uid140_zCount_uid78_Divide_q_12_cmp_b ELSE "0";

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_cmpReg(REG,343)
    redist6_r_uid140_zCount_uid78_Divide_q_12_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid140_zCount_uid78_Divide_q_12_cmpReg_q <= "0";
            ELSE
                redist6_r_uid140_zCount_uid78_Divide_q_12_cmpReg_q <= redist6_r_uid140_zCount_uid78_Divide_q_12_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena(REG,346)
    redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena_q <= "0";
            ELSE
                IF (redist6_r_uid140_zCount_uid78_Divide_q_12_nor_q = "1") THEN
                    redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena_q <= redist6_r_uid140_zCount_uid78_Divide_q_12_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_enaAnd(LOGICAL,347)
    redist6_r_uid140_zCount_uid78_Divide_q_12_enaAnd_q <= STD_LOGIC_VECTOR(redist6_r_uid140_zCount_uid78_Divide_q_12_sticky_ena_q and VCC_q);

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt(COUNTER,339)
    -- low=0, high=10, step=1, init=0
    redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i <= TO_UNSIGNED(0, 4);
                redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_eq <= '0';
            ELSE
                IF (redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i = TO_UNSIGNED(9, 4)) THEN
                    redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_eq <= '1';
                ELSE
                    redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_eq <= '0';
                END IF;
                IF (redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_eq = '1') THEN
                    redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i <= redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i + 6;
                ELSE
                    redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i <= redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_i, 4));

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_wraddr(REG,340)
    redist6_r_uid140_zCount_uid78_Divide_q_12_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist6_r_uid140_zCount_uid78_Divide_q_12_wraddr_q <= "1010";
            ELSE
                redist6_r_uid140_zCount_uid78_Divide_q_12_wraddr_q <= redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist6_r_uid140_zCount_uid78_Divide_q_12_mem(DUALMEM,338)
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ia <= STD_LOGIC_VECTOR(r_uid140_zCount_uid78_Divide_q);
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_aa <= redist6_r_uid140_zCount_uid78_Divide_q_12_wraddr_q;
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ab <= redist6_r_uid140_zCount_uid78_Divide_q_12_rdcnt_q;
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ena_OrRstB <= areset or redist6_r_uid140_zCount_uid78_Divide_q_12_enaAnd_q(0);
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_reset0 <= areset;
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 5,
        widthad_a => 4,
        numwords_a => 11,
        width_b => 5,
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
        intended_device_family => "Agilex 3"
    )
    PORT MAP (
        clocken1 => redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist6_r_uid140_zCount_uid78_Divide_q_12_mem_reset0,
        clock1 => clk,
        address_a => redist6_r_uid140_zCount_uid78_Divide_q_12_mem_aa,
        data_a => redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist6_r_uid140_zCount_uid78_Divide_q_12_mem_ab,
        q_b => redist6_r_uid140_zCount_uid78_Divide_q_12_mem_iq
    );
    redist6_r_uid140_zCount_uid78_Divide_q_12_mem_q <= STD_LOGIC_VECTOR(redist6_r_uid140_zCount_uid78_Divide_q_12_mem_iq(4 downto 0));

    -- cWOut_uid94_Divide(CONSTANT,93)
    cWOut_uid94_Divide_q <= "10000";

    -- rShiftCount_uid95_Divide(SUB,94)@12
    rShiftCount_uid95_Divide_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & cWOut_uid94_Divide_q));
    rShiftCount_uid95_Divide_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0" & redist6_r_uid140_zCount_uid78_Divide_q_12_mem_q));
    rShiftCount_uid95_Divide_o <= STD_LOGIC_VECTOR(SIGNED(rShiftCount_uid95_Divide_a) - SIGNED(rShiftCount_uid95_Divide_b));
    rShiftCount_uid95_Divide_q <= STD_LOGIC_VECTOR(rShiftCount_uid95_Divide_o(5 downto 0));

    -- rightShiftStageSel0Dto0_uid239_prodPostRightShift_uid102_Divide(BITSELECT,238)@12
    rightShiftStageSel0Dto0_uid239_prodPostRightShift_uid102_Divide_in <= rShiftCount_uid95_Divide_q(1 downto 0);
    rightShiftStageSel0Dto0_uid239_prodPostRightShift_uid102_Divide_b <= STD_LOGIC_VECTOR(rightShiftStageSel0Dto0_uid239_prodPostRightShift_uid102_Divide_in(1 downto 0));

    -- rightShiftStage0_uid240_prodPostRightShift_uid102_Divide(MUX,239)@12
    rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_s <= rightShiftStageSel0Dto0_uid239_prodPostRightShift_uid102_Divide_b;
    rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_combproc: PROCESS (rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_s, rightShiftInput_uid101_Divide_b, rightShiftStage0Idx1_uid232_prodPostRightShift_uid102_Divide_q, rightShiftStage0Idx2_uid235_prodPostRightShift_uid102_Divide_q, rightShiftStage0Idx3_uid238_prodPostRightShift_uid102_Divide_q)
    BEGIN
        CASE (rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_s) IS
            WHEN "00" => rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q <= rightShiftInput_uid101_Divide_b;
            WHEN "01" => rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q <= rightShiftStage0Idx1_uid232_prodPostRightShift_uid102_Divide_q;
            WHEN "10" => rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q <= rightShiftStage0Idx2_uid235_prodPostRightShift_uid102_Divide_q;
            WHEN "11" => rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q <= rightShiftStage0Idx3_uid238_prodPostRightShift_uid102_Divide_q;
            WHEN OTHERS => rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel2Dto2_uid250_prodPostRightShift_uid102_Divide(BITSELECT,249)@12
    rightShiftStageSel2Dto2_uid250_prodPostRightShift_uid102_Divide_in <= rShiftCount_uid95_Divide_q(3 downto 0);
    rightShiftStageSel2Dto2_uid250_prodPostRightShift_uid102_Divide_b <= STD_LOGIC_VECTOR(rightShiftStageSel2Dto2_uid250_prodPostRightShift_uid102_Divide_in(3 downto 2));

    -- rightShiftStage1_uid251_prodPostRightShift_uid102_Divide(MUX,250)@12
    rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_s <= rightShiftStageSel2Dto2_uid250_prodPostRightShift_uid102_Divide_b;
    rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_combproc: PROCESS (rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_s, rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q, rightShiftStage1Idx1_uid243_prodPostRightShift_uid102_Divide_q, rightShiftStage1Idx2_uid246_prodPostRightShift_uid102_Divide_q, rightShiftStage1Idx3_uid249_prodPostRightShift_uid102_Divide_q)
    BEGIN
        CASE (rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_s) IS
            WHEN "00" => rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q <= rightShiftStage0_uid240_prodPostRightShift_uid102_Divide_q;
            WHEN "01" => rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q <= rightShiftStage1Idx1_uid243_prodPostRightShift_uid102_Divide_q;
            WHEN "10" => rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q <= rightShiftStage1Idx2_uid246_prodPostRightShift_uid102_Divide_q;
            WHEN "11" => rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q <= rightShiftStage1Idx3_uid249_prodPostRightShift_uid102_Divide_q;
            WHEN OTHERS => rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage2_uid256_prodPostRightShift_uid102_DivideinvSel(LOGICAL,292)@12
    rightShiftStage2_uid256_prodPostRightShift_uid102_DivideinvSel_q <= not (rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_b);

    -- seMsb_to16_uid252(BITSELECT,251)@12
    seMsb_to16_uid252_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => xMSB_uid227_prodPostRightShift_uid102_Divide_b(0)) & xMSB_uid227_prodPostRightShift_uid102_Divide_b));
    seMsb_to16_uid252_b <= seMsb_to16_uid252_in(15 downto 0);

    -- rightShiftStage2Idx1Rng16_uid253_prodPostRightShift_uid102_Divide(BITSELECT,252)@12
    rightShiftStage2Idx1Rng16_uid253_prodPostRightShift_uid102_Divide_b <= rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q(21 downto 16);

    -- rightShiftStage2Idx1_uid254_prodPostRightShift_uid102_Divide(BITJOIN,253)@12
    rightShiftStage2Idx1_uid254_prodPostRightShift_uid102_Divide_q <= seMsb_to16_uid252_b & rightShiftStage2Idx1Rng16_uid253_prodPostRightShift_uid102_Divide_b;

    -- rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide(BITSELECT,254)@12
    rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_in <= rShiftCount_uid95_Divide_q(4 downto 0);
    rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_b <= STD_LOGIC_VECTOR(rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_in(4 downto 4));

    -- shiftOutConstant_to22_uid257(BITSELECT,256)@12
    shiftOutConstant_to22_uid257_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((21 downto 1 => xMSB_uid227_prodPostRightShift_uid102_Divide_b(0)) & xMSB_uid227_prodPostRightShift_uid102_Divide_b));
    shiftOutConstant_to22_uid257_b <= shiftOutConstant_to22_uid257_in(21 downto 0);

    -- shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_const_trz_269(CONSTANT,268)
    shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_const_trz_269_q <= "1011";

    -- shiftedOut_uid230_prodPostRightShift_uid102_Divide_bit_select_top_X_trz_270(BITSELECT,269)@12
    shiftedOut_uid230_prodPostRightShift_uid102_Divide_bit_select_top_X_trz_270_b <= STD_LOGIC_VECTOR(rShiftCount_uid95_Divide_q(5 downto 1));

    -- shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271(COMPARE,270)@12
    shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_a <= STD_LOGIC_VECTOR("00" & shiftedOut_uid230_prodPostRightShift_uid102_Divide_bit_select_top_X_trz_270_b);
    shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_b <= STD_LOGIC_VECTOR("000" & shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_const_trz_269_q);
    shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_a) - UNSIGNED(shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_b));
    shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_n(0) <= not (shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_o(6));

    -- mergedMUXes0(SELECTOR,293)@12
    mergedMUXes0_combproc: PROCESS (shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_n, shiftOutConstant_to22_uid257_b, rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_b, rightShiftStage2Idx1_uid254_prodPostRightShift_uid102_Divide_q, rightShiftStage2_uid256_prodPostRightShift_uid102_DivideinvSel_q, rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q)
    BEGIN
        mergedMUXes0_q <= (others => '0');
        IF (rightShiftStage2_uid256_prodPostRightShift_uid102_DivideinvSel_q = "1") THEN
            mergedMUXes0_q <= STD_LOGIC_VECTOR(rightShiftStage1_uid251_prodPostRightShift_uid102_Divide_q);
        END IF;
        IF (rightShiftStageSel4Dto4_uid255_prodPostRightShift_uid102_Divide_b = "1") THEN
            mergedMUXes0_q <= STD_LOGIC_VECTOR(rightShiftStage2Idx1_uid254_prodPostRightShift_uid102_Divide_q);
        END IF;
        IF (shiftedOut_uid230_prodPostRightShift_uid102_Divide_new_compare_trz_271_n = "1") THEN
            mergedMUXes0_q <= STD_LOGIC_VECTOR(shiftOutConstant_to22_uid257_b);
        END IF;
    END PROCESS;

    -- prodPostRightShiftPost_uid103_Divide(BITSELECT,102)@12
    prodPostRightShiftPost_uid103_Divide_in <= mergedMUXes0_q(20 downto 0);
    prodPostRightShiftPost_uid103_Divide_b <= STD_LOGIC_VECTOR(prodPostRightShiftPost_uid103_Divide_in(20 downto 1));

    -- prodPostRightShiftPostRnd_uid105_Divide(ADD,104)@12
    prodPostRightShiftPostRnd_uid105_Divide_a <= STD_LOGIC_VECTOR("0" & prodPostRightShiftPost_uid103_Divide_b);
    prodPostRightShiftPostRnd_uid105_Divide_b <= STD_LOGIC_VECTOR("00000000000000000000" & VCC_q);
    prodPostRightShiftPostRnd_uid105_Divide_o <= STD_LOGIC_VECTOR(UNSIGNED(prodPostRightShiftPostRnd_uid105_Divide_a) + UNSIGNED(prodPostRightShiftPostRnd_uid105_Divide_b));
    prodPostRightShiftPostRnd_uid105_Divide_q <= STD_LOGIC_VECTOR(prodPostRightShiftPostRnd_uid105_Divide_o(20 downto 0));

    -- prodPostRightShiftPostRndRange_uid106_Divide(BITSELECT,105)@12
    prodPostRightShiftPostRndRange_uid106_Divide_in <= prodPostRightShiftPostRnd_uid105_Divide_q(19 downto 0);
    prodPostRightShiftPostRndRange_uid106_Divide_b <= STD_LOGIC_VECTOR(prodPostRightShiftPostRndRange_uid106_Divide_in(19 downto 1));

    -- yIsZero_uid86_Divide(LOGICAL,85)@0 + 1
    yIsZero_uid86_Divide_b <= STD_LOGIC_VECTOR("000000000000000" & GND_q);
    yIsZero_uid86_Divide_qi <= "1" WHEN Const_Mult_PostCast_primWireOut_mux_x_q = yIsZero_uid86_Divide_b ELSE "0";
    yIsZero_uid86_Divide_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => yIsZero_uid86_Divide_qi, xout => yIsZero_uid86_Divide_q, clk => clk, aclr => areset, ena => '1' );

    -- redist7_yIsZero_uid86_Divide_q_12(DELAY,301)
    redist7_yIsZero_uid86_Divide_q_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 11, reset_kind => "SYNC", phase => 0, modulus => 1024 )
    PORT MAP ( xin => yIsZero_uid86_Divide_q, xout => redist7_yIsZero_uid86_Divide_q_12_q, clk => clk, aclr => areset, ena => '1' );

    -- resFinal_uid111_Divide(MUX,110)@12
    resFinal_uid111_Divide_s <= redist7_yIsZero_uid86_Divide_q_12_q;
    resFinal_uid111_Divide_combproc: PROCESS (resFinal_uid111_Divide_s, prodPostRightShiftPostRndRange_uid106_Divide_b, cstOvf_uid110_Divide_q_const_q)
    BEGIN
        CASE (resFinal_uid111_Divide_s) IS
            WHEN "0" => resFinal_uid111_Divide_q <= prodPostRightShiftPostRndRange_uid106_Divide_b;
            WHEN "1" => resFinal_uid111_Divide_q <= cstOvf_uid110_Divide_q_const_q;
            WHEN OTHERS => resFinal_uid111_Divide_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- Convert3_sel_x(BITSELECT,31)@12
    Convert3_sel_x_b <= resFinal_uid111_Divide_q(17 downto 0);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- Mult_cma(CHAINMULTADD,272)@12 + 4
    -- in b@15
    Mult_cma_reset <= areset;
    Mult_cma_ena0 <= '1';
    Mult_cma_ena1 <= Mult_cma_ena0;
    Mult_cma_ena2 <= Mult_cma_ena0;

    Mult_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Convert3_sel_x_b),18));
    Mult_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist5_Add1_split_join_q_9_mem_q),23));
    Mult_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 18,
        ax_clken => "0",
        ax_width => 23,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        load_const_value => 5,
        output_clken => "1",
        result_a_width => 41
    )
    PORT MAP (
        clk => clk,
        ena(0) => Mult_cma_ena0,
        ena(1) => Mult_cma_ena1,
        ena(2) => Mult_cma_ena2,
        clr(0) => Mult_cma_reset,
        clr(1) => Mult_cma_reset,
        ay => Mult_cma_a0,
        ax => Mult_cma_c0,
        loadconst => '1',
        resulta => Mult_cma_s0
    );
    Mult_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 41, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => Mult_cma_s0, xout => Mult_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    Mult_cma_q <= STD_LOGIC_VECTOR(Mult_cma_qq0(40 downto 0));

    -- Convert4_rnd_shift(BITSHIFT,282)@16
    Convert4_rnd_shift_qint <= Mult_cma_q;
    Convert4_rnd_shift_q <= Convert4_rnd_shift_qint(40 downto 6);

    -- Convert4_rnd_bs(BITSELECT,283)@16
    Convert4_rnd_bs_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => Convert4_rnd_shift_q(34)) & Convert4_rnd_shift_q));
    Convert4_rnd_bs_b <= Convert4_rnd_bs_in(35 downto 0);

    -- Convert4_sel_x(BITSELECT,32)@16
    Convert4_sel_x_b <= STD_LOGIC_VECTOR(Convert4_rnd_bs_b(15 downto 0));

    -- redist10_Convert4_sel_x_b_1(DELAY,304)
    redist10_Convert4_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist10_Convert4_sel_x_b_1_q <= (others => '0');
            ELSE
                redist10_Convert4_sel_x_b_1_q <= Convert4_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- GPOut(GPOUT,22)@17
    out_1_FractionA_ND_ufix16_En16_x_tpl <= redist10_Convert4_sel_x_b_1_q;

    -- redist4_Add2_split_join_q_9_notEnable(LOGICAL,324)
    redist4_Add2_split_join_q_9_notEnable_q <= not (VCC_q);

    -- redist4_Add2_split_join_q_9_nor(LOGICAL,325)
    redist4_Add2_split_join_q_9_nor_q <= STD_LOGIC_VECTOR(not (redist4_Add2_split_join_q_9_notEnable_q or redist4_Add2_split_join_q_9_sticky_ena_q));

    -- redist4_Add2_split_join_q_9_mem_last(CONSTANT,321)
    redist4_Add2_split_join_q_9_mem_last_q <= "0110";

    -- redist4_Add2_split_join_q_9_cmp(LOGICAL,322)
    redist4_Add2_split_join_q_9_cmp_b <= STD_LOGIC_VECTOR("0" & redist4_Add2_split_join_q_9_rdcnt_q);
    redist4_Add2_split_join_q_9_cmp_q <= "1" WHEN redist4_Add2_split_join_q_9_mem_last_q = redist4_Add2_split_join_q_9_cmp_b ELSE "0";

    -- redist4_Add2_split_join_q_9_cmpReg(REG,323)
    redist4_Add2_split_join_q_9_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist4_Add2_split_join_q_9_cmpReg_q <= "0";
            ELSE
                redist4_Add2_split_join_q_9_cmpReg_q <= redist4_Add2_split_join_q_9_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist4_Add2_split_join_q_9_sticky_ena(REG,326)
    redist4_Add2_split_join_q_9_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist4_Add2_split_join_q_9_sticky_ena_q <= "0";
            ELSE
                IF (redist4_Add2_split_join_q_9_nor_q = "1") THEN
                    redist4_Add2_split_join_q_9_sticky_ena_q <= redist4_Add2_split_join_q_9_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist4_Add2_split_join_q_9_enaAnd(LOGICAL,327)
    redist4_Add2_split_join_q_9_enaAnd_q <= STD_LOGIC_VECTOR(redist4_Add2_split_join_q_9_sticky_ena_q and VCC_q);

    -- redist4_Add2_split_join_q_9_rdcnt(COUNTER,319)
    -- low=0, high=7, step=1, init=0
    redist4_Add2_split_join_q_9_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist4_Add2_split_join_q_9_rdcnt_i <= TO_UNSIGNED(0, 3);
            ELSE
                redist4_Add2_split_join_q_9_rdcnt_i <= redist4_Add2_split_join_q_9_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist4_Add2_split_join_q_9_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist4_Add2_split_join_q_9_rdcnt_i, 3));

    -- Add2_PreShift_0(BITSHIFT,36)@3
    Add2_PreShift_0_qint <= redist13_GPIn_in_1_Voltage_range_int16_tpl_3_q & "000000";
    Add2_PreShift_0_q <= Add2_PreShift_0_qint(21 downto 0);

    -- Add2_lhsMSBs_select(BITSELECT,191)@3
    Add2_lhsMSBs_select_b <= Add2_PreShift_0_q(21 downto 6);

    -- Add2_MSBs_sums(ADD,192)@3
    Add2_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => Add2_lhsMSBs_select_b(15)) & Add2_lhsMSBs_select_b));
    Add2_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 10 => Add2_rhsMSBs_select_bit_select_merged_b(9)) & Add2_rhsMSBs_select_bit_select_merged_b));
    Add2_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(Add2_MSBs_sums_a) + SIGNED(Add2_MSBs_sums_b));
    Add2_MSBs_sums_q <= STD_LOGIC_VECTOR(Add2_MSBs_sums_o(16 downto 0));

    -- Add2_rhsMSBs_select_bit_select_merged(BITSELECT,285)@3
    Add2_rhsMSBs_select_bit_select_merged_b <= in_4_VoltageC_sfix16_En6_tpl(15 downto 6);
    Add2_rhsMSBs_select_bit_select_merged_c <= in_4_VoltageC_sfix16_En6_tpl(5 downto 0);

    -- Add2_split_join(BITJOIN,193)@3
    Add2_split_join_q <= Add2_MSBs_sums_q & Add2_rhsMSBs_select_bit_select_merged_c;

    -- redist4_Add2_split_join_q_9_wraddr(REG,320)
    redist4_Add2_split_join_q_9_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist4_Add2_split_join_q_9_wraddr_q <= "111";
            ELSE
                redist4_Add2_split_join_q_9_wraddr_q <= redist4_Add2_split_join_q_9_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist4_Add2_split_join_q_9_mem(DUALMEM,318)
    redist4_Add2_split_join_q_9_mem_ia <= STD_LOGIC_VECTOR(Add2_split_join_q);
    redist4_Add2_split_join_q_9_mem_aa <= redist4_Add2_split_join_q_9_wraddr_q;
    redist4_Add2_split_join_q_9_mem_ab <= redist4_Add2_split_join_q_9_rdcnt_q;
    redist4_Add2_split_join_q_9_mem_ena_OrRstB <= areset or redist4_Add2_split_join_q_9_enaAnd_q(0);
    redist4_Add2_split_join_q_9_mem_reset0 <= areset;
    redist4_Add2_split_join_q_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 23,
        widthad_b => 3,
        numwords_b => 8,
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
        intended_device_family => "Agilex 3"
    )
    PORT MAP (
        clocken1 => redist4_Add2_split_join_q_9_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist4_Add2_split_join_q_9_mem_reset0,
        clock1 => clk,
        address_a => redist4_Add2_split_join_q_9_mem_aa,
        data_a => redist4_Add2_split_join_q_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist4_Add2_split_join_q_9_mem_ab,
        q_b => redist4_Add2_split_join_q_9_mem_iq
    );
    redist4_Add2_split_join_q_9_mem_q <= STD_LOGIC_VECTOR(redist4_Add2_split_join_q_9_mem_iq(22 downto 0));

    -- Mult1_cma(CHAINMULTADD,273)@12 + 4
    -- in b@15
    Mult1_cma_reset <= areset;
    Mult1_cma_ena0 <= '1';
    Mult1_cma_ena1 <= Mult1_cma_ena0;
    Mult1_cma_ena2 <= Mult1_cma_ena0;

    Mult1_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Convert3_sel_x_b),18));
    Mult1_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist4_Add2_split_join_q_9_mem_q),23));
    Mult1_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 18,
        ax_clken => "0",
        ax_width => 23,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        load_const_value => 5,
        output_clken => "1",
        result_a_width => 41
    )
    PORT MAP (
        clk => clk,
        ena(0) => Mult1_cma_ena0,
        ena(1) => Mult1_cma_ena1,
        ena(2) => Mult1_cma_ena2,
        clr(0) => Mult1_cma_reset,
        clr(1) => Mult1_cma_reset,
        ay => Mult1_cma_a0,
        ax => Mult1_cma_c0,
        loadconst => '1',
        resulta => Mult1_cma_s0
    );
    Mult1_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 41, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => Mult1_cma_s0, xout => Mult1_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    Mult1_cma_q <= STD_LOGIC_VECTOR(Mult1_cma_qq0(40 downto 0));

    -- Convert1_rnd_shift(BITSHIFT,278)@16
    Convert1_rnd_shift_qint <= Mult1_cma_q;
    Convert1_rnd_shift_q <= Convert1_rnd_shift_qint(40 downto 6);

    -- Convert1_rnd_bs(BITSELECT,279)@16
    Convert1_rnd_bs_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => Convert1_rnd_shift_q(34)) & Convert1_rnd_shift_q));
    Convert1_rnd_bs_b <= Convert1_rnd_bs_in(35 downto 0);

    -- Convert1_sel_x(BITSELECT,29)@16
    Convert1_sel_x_b <= STD_LOGIC_VECTOR(Convert1_rnd_bs_b(15 downto 0));

    -- redist12_Convert1_sel_x_b_1(DELAY,306)
    redist12_Convert1_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist12_Convert1_sel_x_b_1_q <= (others => '0');
            ELSE
                redist12_Convert1_sel_x_b_1_q <= Convert1_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- GPOut1(GPOUT,23)@17
    out_3_FractionC_ND_ufix16_En16_tpl <= redist12_Convert1_sel_x_b_1_q;

    -- redist3_Add3_split_join_q_9_notEnable(LOGICAL,314)
    redist3_Add3_split_join_q_9_notEnable_q <= not (VCC_q);

    -- redist3_Add3_split_join_q_9_nor(LOGICAL,315)
    redist3_Add3_split_join_q_9_nor_q <= STD_LOGIC_VECTOR(not (redist3_Add3_split_join_q_9_notEnable_q or redist3_Add3_split_join_q_9_sticky_ena_q));

    -- redist3_Add3_split_join_q_9_mem_last(CONSTANT,311)
    redist3_Add3_split_join_q_9_mem_last_q <= "0110";

    -- redist3_Add3_split_join_q_9_cmp(LOGICAL,312)
    redist3_Add3_split_join_q_9_cmp_b <= STD_LOGIC_VECTOR("0" & redist3_Add3_split_join_q_9_rdcnt_q);
    redist3_Add3_split_join_q_9_cmp_q <= "1" WHEN redist3_Add3_split_join_q_9_mem_last_q = redist3_Add3_split_join_q_9_cmp_b ELSE "0";

    -- redist3_Add3_split_join_q_9_cmpReg(REG,313)
    redist3_Add3_split_join_q_9_cmpReg_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist3_Add3_split_join_q_9_cmpReg_q <= "0";
            ELSE
                redist3_Add3_split_join_q_9_cmpReg_q <= redist3_Add3_split_join_q_9_cmp_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist3_Add3_split_join_q_9_sticky_ena(REG,316)
    redist3_Add3_split_join_q_9_sticky_ena_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist3_Add3_split_join_q_9_sticky_ena_q <= "0";
            ELSE
                IF (redist3_Add3_split_join_q_9_nor_q = "1") THEN
                    redist3_Add3_split_join_q_9_sticky_ena_q <= redist3_Add3_split_join_q_9_cmpReg_q;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- redist3_Add3_split_join_q_9_enaAnd(LOGICAL,317)
    redist3_Add3_split_join_q_9_enaAnd_q <= STD_LOGIC_VECTOR(redist3_Add3_split_join_q_9_sticky_ena_q and VCC_q);

    -- redist3_Add3_split_join_q_9_rdcnt(COUNTER,309)
    -- low=0, high=7, step=1, init=0
    redist3_Add3_split_join_q_9_rdcnt_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist3_Add3_split_join_q_9_rdcnt_i <= TO_UNSIGNED(0, 3);
            ELSE
                redist3_Add3_split_join_q_9_rdcnt_i <= redist3_Add3_split_join_q_9_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist3_Add3_split_join_q_9_rdcnt_q <= STD_LOGIC_VECTOR(RESIZE(redist3_Add3_split_join_q_9_rdcnt_i, 3));

    -- Add3_PreShift_0(BITSHIFT,37)@3
    Add3_PreShift_0_qint <= redist13_GPIn_in_1_Voltage_range_int16_tpl_3_q & "000000";
    Add3_PreShift_0_q <= Add3_PreShift_0_qint(21 downto 0);

    -- Add3_lhsMSBs_select(BITSELECT,196)@3
    Add3_lhsMSBs_select_b <= Add3_PreShift_0_q(21 downto 6);

    -- Add3_MSBs_sums(ADD,197)@3
    Add3_MSBs_sums_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 16 => Add3_lhsMSBs_select_b(15)) & Add3_lhsMSBs_select_b));
    Add3_MSBs_sums_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 10 => Add3_rhsMSBs_select_bit_select_merged_b(9)) & Add3_rhsMSBs_select_bit_select_merged_b));
    Add3_MSBs_sums_o <= STD_LOGIC_VECTOR(SIGNED(Add3_MSBs_sums_a) + SIGNED(Add3_MSBs_sums_b));
    Add3_MSBs_sums_q <= STD_LOGIC_VECTOR(Add3_MSBs_sums_o(16 downto 0));

    -- Add3_rhsMSBs_select_bit_select_merged(BITSELECT,286)@3
    Add3_rhsMSBs_select_bit_select_merged_b <= in_3_VoltageB_sfix16_En6_tpl(15 downto 6);
    Add3_rhsMSBs_select_bit_select_merged_c <= in_3_VoltageB_sfix16_En6_tpl(5 downto 0);

    -- Add3_split_join(BITJOIN,198)@3
    Add3_split_join_q <= Add3_MSBs_sums_q & Add3_rhsMSBs_select_bit_select_merged_c;

    -- redist3_Add3_split_join_q_9_wraddr(REG,310)
    redist3_Add3_split_join_q_9_wraddr_clkproc: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist3_Add3_split_join_q_9_wraddr_q <= "111";
            ELSE
                redist3_Add3_split_join_q_9_wraddr_q <= redist3_Add3_split_join_q_9_rdcnt_q;
            END IF;
        END IF;
    END PROCESS;

    -- redist3_Add3_split_join_q_9_mem(DUALMEM,308)
    redist3_Add3_split_join_q_9_mem_ia <= STD_LOGIC_VECTOR(Add3_split_join_q);
    redist3_Add3_split_join_q_9_mem_aa <= redist3_Add3_split_join_q_9_wraddr_q;
    redist3_Add3_split_join_q_9_mem_ab <= redist3_Add3_split_join_q_9_rdcnt_q;
    redist3_Add3_split_join_q_9_mem_ena_OrRstB <= areset or redist3_Add3_split_join_q_9_enaAnd_q(0);
    redist3_Add3_split_join_q_9_mem_reset0 <= areset;
    redist3_Add3_split_join_q_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 23,
        widthad_a => 3,
        numwords_a => 8,
        width_b => 23,
        widthad_b => 3,
        numwords_b => 8,
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
        intended_device_family => "Agilex 3"
    )
    PORT MAP (
        clocken1 => redist3_Add3_split_join_q_9_mem_ena_OrRstB,
        clocken0 => '1',
        clock0 => clk,
        sclr => redist3_Add3_split_join_q_9_mem_reset0,
        clock1 => clk,
        address_a => redist3_Add3_split_join_q_9_mem_aa,
        data_a => redist3_Add3_split_join_q_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist3_Add3_split_join_q_9_mem_ab,
        q_b => redist3_Add3_split_join_q_9_mem_iq
    );
    redist3_Add3_split_join_q_9_mem_q <= STD_LOGIC_VECTOR(redist3_Add3_split_join_q_9_mem_iq(22 downto 0));

    -- Mult2_cma(CHAINMULTADD,274)@12 + 4
    -- in b@15
    Mult2_cma_reset <= areset;
    Mult2_cma_ena0 <= '1';
    Mult2_cma_ena1 <= Mult2_cma_ena0;
    Mult2_cma_ena2 <= Mult2_cma_ena0;

    Mult2_cma_a0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Convert3_sel_x_b),18));
    Mult2_cma_c0 <= STD_LOGIC_VECTOR(RESIZE(SIGNED(redist3_Add3_split_join_q_9_mem_q),23));
    Mult2_cma_DSP0 : tennm_mac
    GENERIC MAP (
        operation_mode => "m27x27",
        clear_type => "sclr",
        use_chainadder => "false",
        ay_scan_in_clken => "0",
        ay_scan_in_width => 18,
        ax_clken => "0",
        ax_width => 23,
        signed_may => "true",
        signed_max => "true",
        input_pipeline_clken => "2",
        second_pipeline_clken => "2",
        load_const_value => 5,
        output_clken => "1",
        result_a_width => 41
    )
    PORT MAP (
        clk => clk,
        ena(0) => Mult2_cma_ena0,
        ena(1) => Mult2_cma_ena1,
        ena(2) => Mult2_cma_ena2,
        clr(0) => Mult2_cma_reset,
        clr(1) => Mult2_cma_reset,
        ay => Mult2_cma_a0,
        ax => Mult2_cma_c0,
        loadconst => '1',
        resulta => Mult2_cma_s0
    );
    Mult2_cma_delay0 : dspba_delay
    GENERIC MAP ( width => 41, depth => 0, reset_kind => "SYNC", phase => 0, modulus => 1 )
    PORT MAP ( xin => Mult2_cma_s0, xout => Mult2_cma_qq0, clk => clk, aclr => areset, ena => '1' );
    Mult2_cma_q <= STD_LOGIC_VECTOR(Mult2_cma_qq0(40 downto 0));

    -- Convert2_rnd_shift(BITSHIFT,280)@16
    Convert2_rnd_shift_qint <= Mult2_cma_q;
    Convert2_rnd_shift_q <= Convert2_rnd_shift_qint(40 downto 6);

    -- Convert2_rnd_bs(BITSELECT,281)@16
    Convert2_rnd_bs_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((35 downto 35 => Convert2_rnd_shift_q(34)) & Convert2_rnd_shift_q));
    Convert2_rnd_bs_b <= Convert2_rnd_bs_in(35 downto 0);

    -- Convert2_sel_x(BITSELECT,30)@16
    Convert2_sel_x_b <= STD_LOGIC_VECTOR(Convert2_rnd_bs_b(15 downto 0));

    -- redist11_Convert2_sel_x_b_1(DELAY,305)
    redist11_Convert2_sel_x_b_1_clkproc_0: PROCESS (clk)
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (areset = '1') THEN
                redist11_Convert2_sel_x_b_1_q <= (others => '0');
            ELSE
                redist11_Convert2_sel_x_b_1_q <= Convert2_sel_x_b;
            END IF;
        END IF;
    END PROCESS;

    -- GPOut2(GPOUT,24)@17
    out_2_FractionB_ND_ufix16_En16_tpl <= redist11_Convert2_sel_x_b_1_q;

END normal;
