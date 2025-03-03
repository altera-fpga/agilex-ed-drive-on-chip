-- Legal Notice: Copyright 2021 Intel Corporation.  All rights reserved.
-- Your use of  Intel  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Intel FPGA Software License Agreement,
-- Intel  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Intel and sold by
-- Intel or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_s10_optimized_package.all;
use work.dspba_library_package.all;

entity fpadd_fp64_we11_wf52_stratix10 is
    generic (
        PIPELINE : INTEGER := 1; 
        SUBTRACT : INTEGER := 0;
        SPEED    : INTEGER := 3
    ); 
    port 
    (
        clk   : in  std_logic;
        a     : in  std_logic_vector (63 downto 0);
        b     : in  std_logic_vector (63 downto 0);
        s     : out std_logic_vector (63 downto 0)
    );
end entity;

architecture rtl of fpadd_fp64_we11_wf52_stratix10 is
    component fpadd_fp64_we11_wf52_stratix10_speed2 is
    generic (
        PIPELINE : INTEGER := 1; 
        SUBTRACT : INTEGER := 0 
    ); 
        port 
        (
            clk   : in  std_logic;
            a     : in  std_logic_vector (63 downto 0);
            b     : in  std_logic_vector (63 downto 0);
            s     : out std_logic_vector (63 downto 0)
        );
    end component;

    component fpadd_fp64_we11_wf52_stratix10_speed3 is
    generic (
        PIPELINE : INTEGER := 1; 
        SUBTRACT : INTEGER := 0 
    ); 
        port 
        (
            clk   : in  std_logic;
            a     : in  std_logic_vector (63 downto 0);
            b     : in  std_logic_vector (63 downto 0);
            s     : out std_logic_vector (63 downto 0)
        );
    end component;

    component fpadd_fp64_we11_wf52_stratix10_speed5 is
    generic (
        PIPELINE : INTEGER := 1; 
        SUBTRACT : INTEGER := 0 
    ); 
        port 
        (
            clk   : in  std_logic;
            a     : in  std_logic_vector (63 downto 0);
            b     : in  std_logic_vector (63 downto 0);
            s     : out std_logic_vector (63 downto 0)
        );
    end component;

signal s_sig : std_logic_vector(63 downto 0);
begin

sg: if (SPEED <= 2) generate
        unit : fpadd_fp64_we11_wf52_stratix10_speed2
            generic map (PIPELINE => PIPELINE, SUBTRACT => SUBTRACT)
            port    map (clk => clk, a => a, b => b, s => s_sig);
        s <= s_sig;
    else generate
        sg2: if (SPEED<=3) generate
            unit : fpadd_fp64_we11_wf52_stratix10_speed3
                generic map (PIPELINE => PIPELINE, SUBTRACT => SUBTRACT)
                port    map (clk => clk, a => a, b => b, s => s_sig);
            s <= s_sig;
        else generate
            --rollback to the fast version 
            unit : fpadd_fp64_we11_wf52_stratix10_speed5 
                generic map (PIPELINE => PIPELINE, SUBTRACT => SUBTRACT)
                port    map (clk => clk, a => a, b => b, s => s_sig);
            s <= s_sig;
        end generate;
    end generate;
end;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.dspba_s10_optimized_package.all;
use work.dspba_library_package.all;

entity fpadd_fp64_we11_wf52_stratix10_speed5 is
    generic (
        PIPELINE : INTEGER := 1; 
        SUBTRACT : INTEGER := 0 
    ); 
    port 
    (
        clk   : in  std_logic;
        a     : in  std_logic_vector (63 downto 0);
        b     : in  std_logic_vector (63 downto 0);
        s     : out std_logic_vector (63 downto 0)
    );
end entity;

architecture rtl of fpadd_fp64_we11_wf52_stratix10_speed5 is

component s10_leading_zero_counter is 
    generic (
        SIZE     : INTEGER := 40;
        OUT_SIZE : INTEGER := 6;
        PIPELINE : INTEGER := 1
    ); 
    port (
        clk  : in  std_logic;
        din  : in  std_logic_vector(SIZE-1 downto 0);
        dout : out std_logic_vector(OUT_SIZE-1 downto 0)
    );
end component;

component right_shifter_53bit_s10_growth is
    generic ( PIPELINE : integer := 1);
    port (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(52 downto 0);
        shiftValue    : in  std_logic_vector(5 downto 0);
        result      : out std_logic_vector(52+63 downto 0)
    );
end component;

component right_shifter_53bit_out55bit_s10_sticky_opt is
    generic ( 
        PIPELINE : integer := 1
    );
    port (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(52 downto 0);
        shiftValue  : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(54 downto 0);
        sticky      : out std_logic
    );
end component;

component delay_reg_chain is
    generic (
        width : natural := 8;
        depth : natural := 1
    );
    port (
        clk   : in  std_logic;
        xin   : in  std_logic_vector(width-1 downto 0);
        xout  : out std_logic_vector(width-1 downto 0)
    );
end component;

component int_add_or_sub is
    generic (
        width     : integer := 8;
        issigned  : integer := 0;
        growth    : integer := 0;
        issub     : integer := 0;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : out std_logic_vector(width+growth-1 downto 0)
    );
end component;

component generic_mux_2to1 is
    generic (
        width     : integer := 8;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : in  std_logic;
        q     : out std_logic_vector(width-1 downto 0)
    );
end component;

component logical_reducing_and is
    generic (
        width     : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end component;

component logical_reducing_nor is
    generic (
        width     : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end component;

component exp_exc_out_enc is
    port (
        exp_comp  : in  std_logic_vector(10 downto 0);
        outIsZero : in  std_logic;
        outIsNaN  : in  std_logic;
        outIsInf  : in  std_logic;
        exp_out   : out std_logic_vector(10 downto 0)
    );
end component;

component frac_exc_out_enc is
    port (
        frac_comp : in  std_logic_vector(51 downto 0);
        outIsZero : in  std_logic;
        outIsNaN  : in  std_logic;
        outIsInf  : in  std_logic;
        frac_out  : out std_logic_vector(51 downto 0)
    );
end component;

component sign_exc_out_enc is
    port (
        sign_comp    : in  std_logic;
        outIsZero    : in  std_logic;
        outIsNaN     : in  std_logic;
        outIsInf     : in  std_logic;
        bothNegative : in  std_logic;
        sign_out     : out std_logic
    );
end component;

component left_shifter_57bit is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(56 downto 0);
        shiftValue  : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(56 downto 0)
    );
end component;

component int_add_or_sub_pipe is
    generic (
        width     : integer := 8;
        issigned  : integer := 0;
        growth    : integer := 0;
        issub     : integer := 0;
        levels    : integer := 1;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : out std_logic_vector(width+growth-1 downto 0)
    );
end component;

constant IS_PIPELINED : INTEGER := PIPELINE;
constant INPUT_PIPELINE_STAGE_VALUE : INTEGER := 1;
constant INPUT_PIPELINE_STAGE : INTEGER := IS_PIPELINED*INPUT_PIPELINE_STAGE_VALUE; 


signal right_shifter_53bit_s10_growth_output : std_logic_vector(52+63 downto 0);
signal a_reg, b_reg, a_reg1, b_reg1, a_reg2, b_reg2 : std_logic_vector(63 downto 0);

signal signA, signB : std_logic;
signal expA, expB : std_logic_vector(10 downto 0);
signal fracA, fracB : std_logic_vector(51 downto 0);
signal expAMax, expBMax, expAZero, expBZero, fracAZero, fracBZero : std_logic;
signal aIsInf, aIsNaN, aIsZero, bIsInf, bIsNaN, bIsZero : std_logic;
signal outIsNaN : std_logic;

signal exp_frac_a, exp_frac_b : std_logic_vector(62 downto 0);
signal exp_frac_cmp : std_logic_vector(63 downto 0);
signal exp_frac_a_gte_b : std_logic;

signal x, y         : std_logic_vector(63 downto 0);
signal expX, expX_d10, expY   : std_logic_vector(10 downto 0);
signal fracX, fracY : std_logic_vector(51 downto 0);
signal mantX, mantX_d3, mantY : std_logic_vector(52 downto 0);
signal signX, signX_d12, signY : std_logic_vector(0 downto 0);

signal eff_sub, eff_sub_d3 : std_logic_vector(0 downto 0);


signal mantY_right_shift : std_logic_vector(53+54-1 downto 0);
signal exp_diff : std_logic_vector(10 downto 0);
signal exp_diff_sat : std_logic_vector(5 downto 0);
signal sticky_range : std_logic_vector(52 downto 0);
signal sticky : std_logic;
signal right_shift_output, right_shift_output_reg : std_logic_vector(54 downto 0);

signal aligned_y : std_logic_vector(54 downto 0);

signal mant_sum_raw, base_x_mant, base_y_xor : std_logic_vector(56 downto 0);
signal mant_sum, mant_sum_d1, left_shift_output : std_logic_vector(56 downto 0);
signal clz_value : std_logic_vector(5 downto 0);

signal inc_2 : std_logic_vector(1 downto 0);
signal exp_x_inc : std_logic_vector(11 downto 0);
signal exp_x_sub : std_logic_vector(12 downto 0);

signal frac_out_pre_rnd : std_logic_vector(52 downto 0);
signal frac_out_post_rnd : std_logic_vector(53 downto 0);

signal l_bit, r_bit, s_bit : std_logic;
signal rnd_bit : std_logic_vector(0 downto 0);

signal count_m2 : std_logic_vector(6 downto 0);
signal expX_Cor : std_logic_vector(11 downto 0);


signal s_out : std_Logic_vector(63 downto 0);

signal sgn_post_exc : std_logic;
signal exc_post_exc : std_logic_vector(10 downto 0);
signal frc_post_exc : std_logic_vector(51 downto 0);

signal bothZero : std_logic;
signal bothNegative : std_Logic;
signal outIsZero : std_logic;
signal outIsInf  : std_logic;

signal xIsZero, yIsZero : std_logic;

signal concExc : std_logic_vector(2 downto 0);
signal expUdf, expOvf : std_logic;
signal aIsReg, bIsReg : std_logic;

signal aIsZero_d1, bIsZero_d1 : std_logic;
signal aIsReg_d, bIsReg_d, bothZero_d, bothNegative_d, outIsNaN_d, aIsInf_d, bIsInf_d : std_logic;

signal xIsZero_d1, yIsZero_d1 : std_logic;
signal sticky_d2 : std_logic;

signal expX_post_first_update, expX_post_first_update_d4 : std_logic_vector(11 downto 0);
signal expX_d6 : std_logic_vector(10 downto 0);

signal frac_out_post_rnd_d : std_logic_vector(51 downto 0);
signal b_post_sign : std_logic_vector(63 downto 0);
begin

sg : if SUBTRACT=1 generate
    b_post_sign <= not(b(63)) & b(62 downto 0);
else generate
    b_post_sign <= b;
end generate;


---------------------------------------------------------------------------
-- SCHEDULE TIME  0 -------------------------------------------------------
---------------------------------------------------------------------------
a_reg_label: delay_reg_chain generic map(width => 64, depth => INPUT_PIPELINE_STAGE) port map (clk => clk, xin => a,  xout => a_reg);     
b_reg_label: delay_reg_chain generic map(width => 64, depth => INPUT_PIPELINE_STAGE) port map (clk => clk, xin => b_post_sign,  xout => b_reg);     

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE)  ---------------------------------
---------------------------------------------------------------------------
exp_frac_a <= a_reg(62 downto 0);
exp_frac_b <= b_reg(62 downto 0);

expFrac_cmp: int_add_or_sub_pipe
    generic map ( width => 63, issigned => 0, growth => 1, issub => 1, levels => 2, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => exp_frac_a, y => exp_frac_b, s => exp_frac_cmp); --result available at cycle 3

a_reg1_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => a_reg, xout => a_reg1);     
b_reg1_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => b_reg, xout => b_reg1);     

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+1)  ---------------------------------
---------------------------------------------------------------------------
a_reg2_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => a_reg1, xout => a_reg2);     
b_reg2_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => b_reg1, xout => b_reg2);     
     
signA <= a_reg1(63);
signB <= b_reg1(63);
     
expA  <= a_reg1(62 downto 52);
expB  <= b_reg1(62 downto 52);

fracA <= a_reg1(51 downto 0);
fracB <= b_reg1(51 downto 0);

expAMax_label   : logical_reducing_and generic map ( width => expA'length ) port map (d => expA, q => expAMax);
expBMax_label   : logical_reducing_and generic map ( width => expB'length ) port map (d => expB, q => expBMax);

expAZero_label  : logical_reducing_nor generic map ( width => expA'length) port map (d => expA, q => expAZero);
expBZero_label  : logical_reducing_nor generic map ( width => expB'length) port map (d => expB, q => expBZero);

fracAZero_label : logical_reducing_nor generic map ( width => fracA'length) port map (d=> fracA, q => fracAZero);
fracBZero_label : logical_reducing_nor generic map ( width => fracB'length) port map (d=> fracB, q => fracBZero);

aIsInf  <= expAMax and fracAZero;
aIsNaN  <= expAMax and (not(fracAZero));
aIsZero <= expAZero; --flush to zero
aIsReg  <= not(aIsInf) and not(aIsNaN) and not(aIsZero);

bIsInf  <= expBMax and fracBZero;
bIsNaN  <= expBMax and (not(fracBZero));
bIsZero <= expBZero; 
bIsReg  <= not(bIsInf) and not(bIsNaN) and not(bIsZero);

bothZero     <= (aIsZero and bIsZero);
bothNegative <= signA and signB;
outIsNaN     <= (aIsNaN or bIsNaN) or (aIsInf and bIsInf and (signA xor signB));      

aIsZeroReg_label: delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => aIsZero, xout(0) => aIsZero_d1 );
bIsZeroReg_label: delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => bIsZero, xout(0) => bIsZero_d1 );

aIsRegRegister_label       : delay_reg_chain generic map(width => 1, depth => 14*IS_PIPELINED) port map (clk => clk, xin(0) => aIsReg, xout(0) => aIsReg_d);     
bIsRegRegister_label       : delay_reg_chain generic map(width => 1, depth => 14*IS_PIPELINED) port map (clk => clk, xin(0) => bIsReg, xout(0) => bIsReg_d);     
bothZeroRegister_label     : delay_reg_chain generic map(width => 1, depth => 14*IS_PIPELINED) port map (clk => clk, xin(0) => bothZero, xout(0) => bothZero_d);     
bothNegativeRegister_label : delay_reg_chain generic map(width => 1, depth => 14*IS_PIPELINED) port map (clk => clk, xin(0) => bothNegative, xout(0) => bothNegative_d);     
outIsNaNRegister_label     : delay_reg_chain generic map(width => 1, depth => 14*IS_PIPELINED) port map (clk => clk, xin(0) => outIsNaN, xout(0) => outIsNaN_d);     
aIsInfRegister_label       : delay_reg_chain generic map(width => 1, depth => 14*IS_PIPELINED) port map (clk => clk, xin(0) => aIsInf, xout(0) => aIsInf_d);     
bIsInfRegister_label       : delay_reg_chain generic map(width => 1, depth => 14*IS_PIPELINED) port map (clk => clk, xin(0) => bIsInf, xout(0) => bIsInf_d);     

---------------------------------------------------------------------------
-- SCHEDULE TIME (INPUT_PIPELINE_STAGE+2) ---------------------------------
---------------------------------------------------------------------------
exp_frac_a_gte_b <= exp_frac_cmp(63);

x_label: generic_mux_2to1 generic map ( width => 64, pipelined => IS_PIPELINED) port map ( clk => clk, x => a_reg2, y => b_reg2, s => exp_frac_a_gte_b, q => x );
y_label: generic_mux_2to1 generic map ( width => 64, pipelined => IS_PIPELINED) port map ( clk => clk, x => b_reg2, y => a_reg2, s => exp_frac_a_gte_b, q => y );

xIsZero <= bIsZero_d1 when exp_frac_a_gte_b='1' else aIsZero_d1;
yIsZero <= aIsZero_d1 when exp_frac_a_gte_b='1' else bIsZero_d1;

xIsZeroReg_label : delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => xIsZero, xout(0) => xIsZero_d1 );
yIsZeroReg_label : delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => yIsZero, xout(0) => yIsZero_d1 );

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+3) --------------------------------
---------------------------------------------------------------------------
    
expX <= x(62 downto 52);
expY <= y(62 downto 52);

fracX <= x(51 downto 0);
fracY <= y(51 downto 0);

signX <= x(63 downto 63);
signY <= y(63 downto 63);

eff_sub <= signX xor signY;

signX_delay_label:          delay_reg_chain generic map(width =>  1,          depth => 12*IS_PIPELINED) port map (clk => clk, xin => signX, xout => signX_d12); --output @16
expX_delay_to_first_update: delay_reg_chain generic map(width => expX'length, depth => 6 *IS_PIPELINED) port map (clk => clk, xin => expX,  xout => expX_d6);     

exp_diff_label: int_add_or_sub
    generic map ( width => expX'length, issigned => 0, growth => 0, issub => 1, pipelined => 0)
    port    map ( clk => clk, x => expX, y => expY, s => exp_diff);

--rather than saturating the expDiff, it may be better to merge this into the sticky computation
exp_diff_sat <= exp_diff(5 downto 0) when exp_diff(10 downto 6)="00000" else "110111"; 

mantX <= not(xIsZero_d1) & fracX;
mantY <= not(yIsZero_d1) & fracY;

rsno: right_shifter_53bit_out55bit_s10_sticky_opt generic map (PIPELINE => IS_PIPELINED)
    port map ( clk => clk, datain => mantY, shiftValue => exp_diff_sat, result=> right_shift_output, sticky => sticky); --right_Shift_output and sticky are available @ cycle 7

eff_op_delay: delay_reg_chain generic map( width =>  1, depth => 3*IS_PIPELINED) port map (clk => clk, xin => eff_sub, xout => eff_sub_d3);
mantX_delay : delay_reg_chain generic map( width => 53, depth => 3*IS_PIPELINED) port map (clk => clk, xin => mantX,   xout => mantX_d3);     

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+6) --------------------------------
---------------------------------------------------------------------------
stickyReg_label: delay_reg_chain generic map( width => 1, depth => 2*IS_PIPELINED) port map (clk => clk, xin(0) => sticky, xout(0) => sticky_d2);
aligned_y <= right_shift_output; -- (1+52)+1+1 = 55 bits

base_x_mant <= "0" & "0" & mantX_d3 & "0" & (eff_sub_d3 and not(sticky));
base_y_xor  <= ("0" & "0" & aligned_y) XOR (56 downto 0 => eff_sub_d3(0));

mant_sum_raw_label : int_add_or_sub_pipe
    generic map ( width => base_x_mant'length, issigned => 0, growth => 0, issub => 0, levels => 2, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => base_x_mant, y => base_y_xor, s => mant_sum_raw);

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+8) --------------------------------
---------------------------------------------------------------------------
    
--one bit captures possible overflow;
-- 1 + (1+52) + 1 + 1
mant_sum <= mant_sum_raw(55 downto 0) & sticky_d2;

mant_sum_delay: delay_reg_chain generic map(width => mant_sum'length, depth => 1*IS_PIPELINED) port map (clk => clk, xin => mant_sum, xout => mant_sum_d1); --@10 mant_sum_d1 

--now we need to count leading zeros
clz: s10_leading_zero_counter  
generic map (SIZE => mant_sum'length, OUT_SIZE => 6, PIPELINE => IS_PIPELINED) port map (clk  => clk, din  => mant_sum, dout => clz_value); --@10 available

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+9) --------------------------------
---------------------------------------------------------------------------

first_exp_update : int_add_or_sub
    generic map ( width => expX'length, issigned => 0, growth => 1, issub => 1, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => expX_d6, y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(clz_value), expX'length)), s => expX_post_first_update); --@11
   
ls: left_shifter_57bit generic map (PIPELINE => IS_PIPELINED) port map ( clk => clk, datain => mant_sum_d1, shiftValue => clz_value, result => left_shift_output); --@13

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+10) -------------------------------
---------------------------------------------------------------------------
expX_delay_to_second_update: delay_reg_chain generic map(width => expX_post_first_update'length, depth => 4*IS_PIPELINED) port map (clk => clk, xin => expX_post_first_update, xout => expX_post_first_update_d4);--@15

---------------------------------------------------------------------------
-- SCHEDULE TIME (INPUT_PIPELINE_STAGE+12) --------------------------------
---------------------------------------------------------------------------

frac_out_pre_rnd <= left_shift_output(55 downto 3);
l_bit <= left_shift_output(4);
r_bit <= left_shift_output(3);
s_bit <= left_shift_output(2) or left_shift_output(1) or left_shift_output(0);
rnd_bit(0) <= not(not(l_bit) and (r_bit) and not(s_bit));

frac_out_post_rnd_label: int_add_or_sub_pipe
    generic map ( width => 54, issigned => 0, growth => 0, issub => 0, levels => 2, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(frac_out_pre_rnd), 54)), 
                              y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(rnd_bit),54)), s => frac_out_post_rnd);

---------------------------------------------------------------------------
-- SCHEDULE TIME (INPUT_PIPELINE_STAGE+14) --------------------------------
---------------------------------------------------------------------------

inc_2     <= "10" when frac_out_post_rnd(53)='1' else "01";

second_exp_update : int_add_or_sub
    generic map ( width => expX_post_first_update'length, issigned => 0, growth => 0, issub => 0, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => expX_post_first_update_d4, y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(inc_2), 12)) , s => expX_cor); --@16

 
frac_post_rnd_delay: delay_reg_chain generic map (width => 52, depth => IS_PIPELINED) port map (clk => clk, xin => frac_out_post_rnd(52 downto 1), xout => frac_out_post_rnd_d); --@16
 
---------------------------------------------------------------------------
-- SCHEDULE TIME (INPUT_PIPELINE_STAGE+15) --------------------------------
---------------------------------------------------------------------------
 
expUdf <= NOr(expX_cor(10 downto 0)) or expX_cor(11);
expOvf <= And(expX_cor(10 downto 0)) and not(expX_cor(11));

outIsZero <= bothZero_d or (aIsReg_d and bIsReg_d and expUdf);
outIsInf  <= ((aIsInf_d or bIsInf_d) and not(outIsNaN_d)) or (aIsReg_d and bIsReg_d and expOvf);

concExc <= outIszero & outIsNaN_d & outIsInf;

exp_exc_out_enc_label  : exp_exc_out_enc  port map ( exp_comp => expX_cor(10 downto 0), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, exp_out => exc_post_exc);
frac_exc_out_enc_label : frac_exc_out_enc port map ( frac_comp => frac_out_post_rnd_d, outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, frac_out => frc_post_exc);                   
sign_exc_out_enc_label : sign_exc_out_enc port map ( sign_comp => signX_d12(0), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, bothNegative => bothNegative_d, sign_out => sgn_post_exc);
                     
s_out <= sgn_post_exc & exc_post_exc & frc_post_exc;

output_register: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) 
    port map (clk => clk, xin => s_out, xout => s);

---------------------------------------------------------------------------
-- SCHEDULE TIME (INPUT_PIPELINE_STAGE+16) --------------------------------
---------------------------------------------------------------------------     
-- LATENCY 17 when INPUT_PIPELINE_STAGE is 1.
end rtl;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_s10_optimized_package.all;
use work.dspba_library_package.all;

entity fpadd_fp64_we11_wf52_stratix10_speed3 is
generic (
    PIPELINE : INTEGER := 1; 
    SUBTRACT : INTEGER := 0 
); 
    port 
    (
        clk   : in  std_logic;
        a     : in  std_logic_vector (63 downto 0);
        b     : in  std_logic_vector (63 downto 0);
        s     : out std_logic_vector (63 downto 0)
    );

end entity;

architecture rtl of fpadd_fp64_we11_wf52_stratix10_Speed3 is

component right_shifter_53bit_out55bit_s10_sticky_opt is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(52 downto 0);
        shiftValue    : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(54 downto 0);
        sticky      : out std_logic
    );
end component;

component delay_reg_chain is
    generic (
        width : natural := 8;
        depth : natural := 1
    );
    port (
        clk   : in  std_logic;
        xin   : in  std_logic_vector(width-1 downto 0);
        xout  : out std_logic_vector(width-1 downto 0)
    );
end component;

component int_add_or_sub is
    generic (
        width     : integer := 8;
        issigned  : integer := 0;
        growth    : integer := 0;
        issub     : integer := 0;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
          y     : in  std_logic_vector(width-1 downto 0);
        s  : out std_logic_vector(width+growth-1 downto 0)
    );
end component;

component generic_mux_2to1 is
    generic (
        width     : integer := 8;
          pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : in  std_logic;
        q     : out std_logic_vector(width-1 downto 0)
    );
end component;

component logical_reducing_and is
    generic (
        width : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end component;

component logical_reducing_nor is
    generic (
        width : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end component;

component exp_exc_out_enc is
    port (
        exp_comp  : in  std_logic_vector(10 downto 0);
        outIsZero : in  std_logic;
        outIsNaN  : in  std_logic;
        outIsInf  : in  std_logic;
        exp_out   : out std_logic_vector(10 downto 0)
    );
end component;

component frac_exc_out_enc is
    port (
        frac_comp  : in  std_logic_vector(51 downto 0);
        outIsZero  : in  std_logic;
        outIsNaN   : in  std_logic;
        outIsInf   : in  std_logic;
        frac_out   : out std_logic_vector(51 downto 0)
    );
end component;

component sign_exc_out_enc is
    port (
        sign_comp    : in  std_logic;
        outIsZero    : in  std_logic;
        outIsNaN     : in  std_logic;
        outIsInf     : in  std_logic;
        bothNegative : in  std_logic;
        sign_out     : out std_logic
    );
end component;

component left_shifter_57bit is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(56 downto 0);
        shiftValue  : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(56 downto 0)
    );
end component;

constant IS_PIPELINED : INTEGER := PIPELINE;
constant INPUT_PIPELINE_STAGE_VALUE : INTEGER := 1;
constant INPUT_PIPELINE_STAGE : INTEGER := IS_PIPELINED*INPUT_PIPELINE_STAGE_VALUE; 

signal right_shifter_53bit_s10_growth_output : std_logic_vector(52+63 downto 0);

signal a_reg, b_reg, a_reg2, b_reg2 : std_logic_vector(63 downto 0);

signal signA, signB : std_logic;
signal expA, expB : std_logic_vector(10 downto 0);
signal fracA, fracB : std_logic_vector(51 downto 0);
signal expAMax, expBMax, expAZero, expBZero, fracAZero, fracBZero : std_logic;
signal aIsInf, aIsNaN, aIsZero, bIsInf, bIsNaN, bIsZero : std_logic;
signal outIsNaN : std_logic;

signal exp_frac_a, exp_frac_b : std_logic_vector(62 downto 0);
signal exp_frac_cmp : std_logic_vector(63 downto 0);
signal exp_frac_a_gte_b : std_logic;

signal x, y         : std_logic_vector(63 downto 0);
signal expX, expX_d10, expY   : std_logic_vector(10 downto 0);
signal fracX, fracY : std_logic_vector(51 downto 0);
signal mantX, mantX_d4, mantY : std_logic_vector(52 downto 0);
signal signX, signX_d10, signY : std_logic_vector(0 downto 0);

signal eff_sub, eff_sub_d4 : std_logic_vector(0 downto 0);


signal mantY_right_shift : std_logic_vector(53+54-1 downto 0);
signal exp_diff : std_logic_vector(10 downto 0);
signal exp_diff_sat : std_logic_vector(5 downto 0);
signal sticky_range : std_logic_vector(52 downto 0);
signal sticky : std_logic;
signal right_shift_output, right_shift_output_reg : std_logic_vector(54 downto 0);

signal aligned_y : std_logic_vector(54 downto 0);

signal mant_sum_raw, base_x_mant, base_y_xor : std_logic_vector(56 downto 0);
signal mant_sum, mant_sum_d1, left_shift_output : std_logic_vector(56 downto 0);
signal clz_value, clz_value_d4 : std_logic_vector(5 downto 0);

signal inc_2 : std_logic_vector(1 downto 0);
signal exp_x_inc : std_logic_vector(11 downto 0);
signal exp_x_sub : std_logic_vector(12 downto 0);

signal frac_out_pre_rnd : std_logic_vector(52 downto 0);
signal frac_out_post_rnd : std_logic_vector(53 downto 0);

signal l_bit, r_bit, s_bit : std_logic;
signal rnd_bit : std_logic_vector(0 downto 0);

signal count_m2 : std_logic_vector(6 downto 0);
signal expX_Cor : std_logic_vector(11 downto 0);

signal s_out : std_Logic_vector(63 downto 0);

signal sgn_post_exc : std_logic;
signal exc_post_exc : std_logic_vector(10 downto 0);
signal frc_post_exc : std_logic_vector(51 downto 0);

signal bothZero : std_logic;
signal bothNegative : std_Logic;
signal outIsZero : std_logic;
signal outIsInf  : std_logic;

signal xIsZero, yIsZero : std_logic;

signal concExc : std_logic_vector(2 downto 0);
signal expUdf, expOvf : std_logic;
signal aIsReg, bIsReg : std_logic;

signal aIsZero_d1, bIsZero_d1 : std_logic;
signal aIsReg_d, bIsReg_d, bothZero_d, bothNegative_d, outIsNaN_d, aIsInf_d, bIsInf_d : std_logic;

signal xIsZero_d1, yIsZero_d1 : std_logic;
signal sticky_d1 : std_logic;

signal expX_post_first_update, expX_post_first_update_d3 : std_logic_vector(11 downto 0);
signal expX_d5 : std_logic_vector(10 downto 0);

signal b_post_sign : std_logic_vector(63 downto 0);
begin

sg : if SUBTRACT=1 generate
    b_post_sign <= not(b(63)) & b(62 downto 0);
else generate
    b_post_sign <= b;
end generate;

---------------------------------------------------------------------------
-- SCHEDULE TIME  0 -------------------------------------------------------
---------------------------------------------------------------------------
a_reg_label: delay_reg_chain generic map(width => 64, depth => INPUT_PIPELINE_STAGE) port map (clk => clk, xin => a,  xout => a_reg);     
b_reg_label: delay_reg_chain generic map(width => 64, depth => INPUT_PIPELINE_STAGE) port map (clk => clk, xin => b_post_sign,  xout => b_reg);     

---------------------------------------------------------------------------
-- SCHEDULE TIME  INPUT_PIPELINE_STAGE ------------------------------------
---------------------------------------------------------------------------
a_reg2_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => a_reg, xout => a_reg2);     
b_reg2_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => b_reg, xout => b_reg2);     

exp_frac_a <= a_reg(62 downto 0);
exp_frac_b <= b_reg(62 downto 0);

expFrac_cmp: int_add_or_sub
    generic map ( width => 63, issigned => 0, growth => 1, issub => 1, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => exp_frac_a, y => exp_frac_b, s => exp_frac_cmp);

signA <= a_reg(63);
signB <= b_reg(63);
     
expA <= a_reg(62 downto 52);
expB <= b_reg(62 downto 52);

fracA <= a_reg(51 downto 0);
fracB <= b_reg(51 downto 0);

--exceptions signals
expAMax_label   : logical_reducing_and generic map ( width => expA'length ) port map (d => expA, q => expAMax);
expBMax_label   : logical_reducing_and generic map ( width => expB'length ) port map (d => expB, q => expBMax);

expAZero_label  : logical_reducing_nor generic map ( width => expA'length)  port map (d => expA, q => expAZero);
expBZero_label  : logical_reducing_nor generic map ( width => expB'length)  port map (d => expB, q => expBZero);

fracAZero_label : logical_reducing_nor generic map ( width => fracA'length) port map (d=> fracA, q => fracAZero);
fracBZero_label : logical_reducing_nor generic map ( width => fracB'length) port map (d=> fracB, q => fracBZero);

aIsInf  <= expAMax and fracAZero;
aIsNaN  <= expAMax and (not(fracAZero));
aIsZero <= expAZero; --flush to zero
aIsReg  <= not(aIsInf) and not(aIsNaN) and not(aIsZero);

bIsInf <= expBMax and fracBZero;
bIsNaN <= expBMax and (not(fracBZero));
bIsZero <= expBZero; 
bIsReg <= not(bIsInf) and not(bIsNaN) and not(bIsZero);

bothZero <= (aIsZero and bIsZero);
bothNegative <= signA and signB;
outIsNaN <= (aIsNaN or bIsNaN) or (aIsInf and bIsInf and (signA xor signB)); 

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 1) ------------------------------
---------------------------------------------------------------------------
exp_frac_a_gte_b <= exp_frac_cmp(63);

x_label: generic_mux_2to1 generic map ( width => 64, pipelined => IS_PIPELINED) port map ( clk => clk, x => a_reg2, y => b_reg2, s => exp_frac_a_gte_b, q => x );
y_label: generic_mux_2to1 generic map ( width => 64, pipelined => IS_PIPELINED) port map ( clk => clk, x => b_reg2, y => a_reg2, s => exp_frac_a_gte_b, q => y );

aIsZeroReg_label: delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => aIsZero, xout(0) => aIsZero_d1 );
bIsZeroReg_label: delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => bIsZero, xout(0) => bIsZero_d1 );

xIsZero <= bIsZero_d1 when exp_frac_a_gte_b='1' else aIsZero_d1;
yIsZero <= aIsZero_d1 when exp_frac_a_gte_b='1' else bIsZero_d1;

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 2) ------------------------------
---------------------------------------------------------------------------
xIsZeroReg_label : delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => xIsZero, xout(0) => xIsZero_d1 );
yIsZeroReg_label : delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => yIsZero, xout(0) => yIsZero_d1 );
    
expX <= x(62 downto 52);
expY <= y(62 downto 52);

fracX <= x(51 downto 0);
fracY <= y(51 downto 0);

signX <= x(63 downto 63);
signY <= y(63 downto 63);

signX_delay_label: delay_reg_chain generic map(width =>  1, depth => 9*IS_PIPELINED) port map (clk => clk, xin => signX, xout => signX_d10);     


--difference tells us how much we shift the mantissa of y compared to that of X.
--it may be better to compute eA-eB and eB-eA and select between them at schedule time 2.
--in this way there would not be much logi on the select line goining into the alignment
--shifter.
exp_diff_label: int_add_or_sub
    generic map ( width => expX'length, issigned => 0, growth => 0, issub => 1, pipelined => 0)
    port    map ( clk => clk, x => expX, y => expY, s => exp_diff);


exp_diff_sat <= exp_diff(5 downto 0) when exp_diff(10 downto 6)="00000" else "110111"; 

--rather than saturating the expDiff, it may be better to merge this into the sticky computation
mantX <= not(xIsZero_d1) & fracX;
mantY <= not(yIsZero_d1) & fracY;

rsno: right_shifter_53bit_out55bit_s10_sticky_opt generic map (PIPELINE => IS_PIPELINED)
    port map ( clk => clk, datain => mantY, shiftValue => exp_diff_sat, result=> right_shift_output, sticky => sticky);

eff_sub <= signX xor signY;

eff_op_delay: delay_reg_chain generic map( width =>  1, depth => 3*IS_PIPELINED) port map (clk => clk, xin => eff_sub, xout => eff_sub_d4);
mantX_delay : delay_reg_chain generic map( width => 53, depth => 3*IS_PIPELINED) port map (clk => clk, xin => mantX, xout => mantX_d4);     

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 5) ------------------------------
---------------------------------------------------------------------------

stickyReg_label: delay_reg_chain generic map( width => 1, depth => 1*IS_PIPELINED) port map (clk => clk, xin(0) => sticky, xout(0) => sticky_d1);

aligned_y <= right_shift_output; -- (1+52)+1+1 = 55 bits

base_x_mant <= "0" & "0" & mantX_d4 & "0" & (eff_sub_d4 and not(sticky));
base_y_xor  <= ("0" & "0" & aligned_y) XOR (56 downto 0 => eff_sub_d4(0));

mant_sum_raw_label : int_add_or_sub
    generic map ( width => base_x_mant'length, issigned => 0, growth => 0, issub => 0, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => base_x_mant, y => base_y_xor, s => mant_sum_raw);

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 6) ------------------------------
---------------------------------------------------------------------------
    
--one bit captures possible overflow;
-- 1 + (1+52) + 1 + 1
mant_sum <= mant_sum_raw(55 downto 0) & sticky_d1;

mant_sum_delay: delay_reg_chain generic map(width => mant_sum'length, depth => 1*IS_PIPELINED) port map (clk => clk, xin => mant_sum, xout => mant_sum_d1);     

--now we need to count leading zeros
clz: s10_leading_zero_counter  
generic map (SIZE => mant_sum'length, OUT_SIZE => 6, PIPELINE => IS_PIPELINED) port map (clk  => clk, din  => mant_sum, dout => clz_value);

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 7) ------------------------------
---------------------------------------------------------------------------
expX_delay_to_first_update: delay_reg_chain generic map(width => expX'length, depth => 5*IS_PIPELINED) port map (clk => clk, xin => expX, xout => expX_d5);     

first_exp_update : int_add_or_sub
    generic map ( width => expX'length, issigned => 0, growth => 1, issub => 1, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => expX_d5, y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(clz_value), expX'length)) , s => expX_post_first_update);

clz_value_delay_label : delay_reg_chain generic map(width => 6, depth => 4*IS_PIPELINED) 
    port map (clk => clk, xin => clz_value, xout => clz_value_d4);     

ls: left_shifter_57bit generic map (PIPELINE => IS_PIPELINED) port map ( clk => clk, datain => mant_sum_d1, shiftValue => clz_value, result => left_shift_output);

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 10) -----------------------------
---------------------------------------------------------------------------

frac_out_pre_rnd <= left_shift_output(55 downto 3);
l_bit <= left_shift_output(4);
r_bit <= left_shift_output(3);
s_bit <= left_shift_output(2) or left_shift_output(1) or left_shift_output(0);
rnd_bit(0) <= not(not(l_bit) and (r_bit) and not(s_bit));

frac_out_post_rnd_label: int_add_or_sub
    generic map ( width => 54, issigned => 0, growth => 0, issub => 0, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(frac_out_pre_rnd), 54)), 
                               y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(rnd_bit),54)), s => frac_out_post_rnd);

                                        
---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 11) -----------------------------
---------------------------------------------------------------------------

expX_delay_to_second_update: delay_reg_chain generic map(width => expX_post_first_update'length, depth => 3*IS_PIPELINED) port map (clk => clk, xin => expX_post_first_update, xout => expX_post_first_update_d3);     

inc_2     <= "10" when frac_out_post_rnd(53)='1' else "01";
second_exp_update : int_add_or_sub
    generic map ( width => expX_post_first_update'length, issigned => 0, growth => 0, issub => 0, pipelined => 0)
    port    map ( clk => clk, x => expX_post_first_update_d3, y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(inc_2), 12)) , s => expX_cor);

aIsRegRegister_label       : delay_reg_chain generic map(width => 1, depth => 11*IS_PIPELINED) port map (clk => clk, xin(0) => aIsReg, xout(0) => aIsReg_d);     
bIsRegRegister_label       : delay_reg_chain generic map(width => 1, depth => 11*IS_PIPELINED) port map (clk => clk, xin(0) => bIsReg, xout(0) => bIsReg_d);     
bothZeroRegister_label     : delay_reg_chain generic map(width => 1, depth => 11*IS_PIPELINED) port map (clk => clk, xin(0) => bothZero, xout(0) => bothZero_d);     
bothNegativeRegister_label : delay_reg_chain generic map(width => 1, depth => 11*IS_PIPELINED) port map (clk => clk, xin(0) => bothNegative, xout(0) => bothNegative_d);     
outIsNaNRegister_label     : delay_reg_chain generic map(width => 1, depth => 11*IS_PIPELINED) port map (clk => clk, xin(0) => outIsNaN, xout(0) => outIsNaN_d);     

aIsInfRegister_label       : delay_reg_chain generic map(width => 1, depth => 11*IS_PIPELINED) port map (clk => clk, xin(0) => aIsInf, xout(0) => aIsInf_d);     
bIsInfRegister_label       : delay_reg_chain generic map(width => 1, depth => 11*IS_PIPELINED) port map (clk => clk, xin(0) => bIsInf, xout(0) => bIsInf_d);     

expUdf <= NOr(expX_cor(10 downto 0)) or expX_cor(11);
expOvf <= And(expX_cor(10 downto 0)) and not(expX_cor(11));

outIsZero <= bothZero_d or (aIsReg_d and bIsReg_d and expUdf);
outIsInf  <= ((aIsInf_d or bIsInf_d) and not(outIsNaN_d)) or (aIsReg_d and bIsReg_d and expOvf);

concExc <= outIszero & outIsNaN_d & outIsInf;

exp_exc_out_enc_label  : exp_exc_out_enc  port map ( exp_comp => expX_cor(10 downto 0), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, exp_out => exc_post_exc);
frac_exc_out_enc_label : frac_exc_out_enc port map ( frac_comp => frac_out_post_rnd(52 downto 1), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, frac_out => frc_post_exc);
sign_exc_out_enc_label : sign_exc_out_enc port map ( sign_comp => signX_d10(0), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, bothNegative => bothNegative_d, sign_out => sgn_post_exc);
                     
s_out <= sgn_post_exc & exc_post_exc & frc_post_exc;

output_register: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) 
    port map (clk => clk, xin => s_out, xout => s);     

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE + 12) -----------------------------
---------------------------------------------------------------------------
-- LATENCY 13 when INPUT_PIPELINE_STAGE is 1.
end rtl;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.dspba_s10_optimized_package.all;
use work.dspba_library_package.all;


entity fpadd_fp64_we11_wf52_stratix10_speed2 is
generic (
    PIPELINE : INTEGER := 1; 
    SUBTRACT : INTEGER := 0 
); 
    port 
    (
        clk   : in  std_logic;
        a       : in  std_logic_vector (63 downto 0);
        b       : in  std_logic_vector (63 downto 0);
        s     : out std_logic_vector (63 downto 0)
    );

end entity;

architecture rtl of fpadd_fp64_we11_wf52_stratix10_speed2 is

component s10_leading_zero_counter is 
generic (
    SIZE : INTEGER := 40;
    OUT_SIZE : INTEGER := 6;
     PIPELINE : INTEGER := 1
); 
port (
    clk  : in  std_logic;
    din  : in  std_logic_vector(SIZE-1 downto 0);
    dout : out std_logic_vector(OUT_SIZE-1 downto 0)
);
end component;


component right_shifter_53bit_s10_growth is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(52 downto 0);
        shiftValue    : in  std_logic_vector(5 downto 0);
        result      : out std_logic_vector(52+63 downto 0)
    );
end component;

component right_shifter_53bit_out55bit_s10_sticky_opt is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(52 downto 0);
        shiftValue    : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(54 downto 0);
        sticky      : out std_logic
    );
end component;

component delay_reg_chain is
    generic (
        width : natural := 8;
        depth : natural := 1
    );
    port (
        clk   : in  std_logic;
        xin   : in  std_logic_vector(width-1 downto 0);
        xout  : out std_logic_vector(width-1 downto 0)
    );
end component;

component int_add_or_sub is
    generic (
        width     : integer := 8;
        issigned  : integer := 0;
        growth    : integer := 0;
        issub     : integer := 0;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : out std_logic_vector(width+growth-1 downto 0)
    );
end component;

component generic_mux_2to1 is
    generic (
        width     : integer := 8;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : in  std_logic;
        q     : out std_logic_vector(width-1 downto 0)
    );
end component;

component logical_reducing_and is
    generic (
        width : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end component;

component logical_reducing_nor is
    generic (
        width : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end component;

component exp_exc_out_enc is
    port (
        exp_comp  : in  std_logic_vector(10 downto 0);
        outIsZero : in  std_logic;
        outIsNaN  : in  std_logic;
        outIsInf  : in  std_logic;
        exp_out   : out std_logic_vector(10 downto 0)
    );
end component;

component frac_exc_out_enc is
    port (
        frac_comp  : in  std_logic_vector(51 downto 0);
        outIsZero  : in  std_logic;
        outIsNaN   : in  std_logic;
        outIsInf   : in  std_logic;
        frac_out   : out std_logic_vector(51 downto 0)
    );
end component;

component sign_exc_out_enc is
    port (
        sign_comp    : in  std_logic;
        outIsZero    : in  std_logic;
        outIsNaN     : in  std_logic;
        outIsInf     : in  std_logic;
        bothNegative : in  std_logic;
        sign_out     : out std_logic
    );
end component;

component left_shifter_57bit is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(56 downto 0);
        shiftValue  : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(56 downto 0)
    );
end component;

constant IS_PIPELINED : INTEGER := PIPELINE;
constant INPUT_PIPELINE_STAGE_VALUE : INTEGER := 1;
constant INPUT_PIPELINE_STAGE : INTEGER := IS_PIPELINED*INPUT_PIPELINE_STAGE_VALUE; 

signal right_shifter_53bit_s10_growth_output : std_logic_vector(52+63 downto 0);

signal a_reg, b_reg, a_reg2, b_reg2 : std_logic_vector(63 downto 0);

signal signA, signB : std_logic;
signal expA, expB : std_logic_vector(10 downto 0);
signal fracA, fracB : std_logic_vector(51 downto 0);
signal expAMax, expBMax, expAZero, expBZero, fracAZero, fracBZero : std_logic;
signal aIsInf, aIsNaN, aIsZero, bIsInf, bIsNaN, bIsZero : std_logic;
signal outIsNaN : std_logic;

signal exp_frac_a, exp_frac_b : std_logic_vector(62 downto 0);
signal exp_frac_cmp : std_logic_vector(63 downto 0);
signal exp_frac_a_gte_b : std_logic;

signal x, y         : std_logic_vector(63 downto 0);
signal expX, expX_d10, expY   : std_logic_vector(10 downto 0);
signal fracX, fracY : std_logic_vector(51 downto 0);
signal mantX, mantX_d, mantY : std_logic_vector(52 downto 0);
signal signX, signX_d3, signY : std_logic_vector(0 downto 0);

signal eff_sub, eff_sub_d : std_logic_vector(0 downto 0);

signal mantY_right_shift : std_logic_vector(53+54-1 downto 0);
signal exp_diff : std_logic_vector(10 downto 0);
signal exp_diff_sat : std_logic_vector(5 downto 0);
signal sticky_range : std_logic_vector(52 downto 0);
signal sticky : std_logic;
signal right_shift_output, right_shift_output_reg : std_logic_vector(54 downto 0);

signal aligned_y : std_logic_vector(54 downto 0);

signal mant_sum_raw, base_x_mant, base_y_xor : std_logic_vector(56 downto 0);
signal mant_sum, mant_sum_d1, left_shift_output : std_logic_vector(56 downto 0);
signal clz_value, clz_value_d4 : std_logic_vector(5 downto 0);

signal inc_2 : std_logic_vector(1 downto 0);
signal exp_x_inc : std_logic_vector(11 downto 0);
signal exp_x_sub : std_logic_vector(12 downto 0);

signal frac_out_pre_rnd : std_logic_vector(52 downto 0);
signal frac_out_post_rnd : std_logic_vector(53 downto 0);

signal l_bit, r_bit, s_bit : std_logic;
signal rnd_bit : std_logic_vector(0 downto 0);

signal count_m2 : std_logic_vector(6 downto 0);
signal expX_Cor : std_logic_vector(11 downto 0);

signal s_out : std_Logic_vector(63 downto 0);

signal sgn_post_exc : std_logic;
signal exc_post_exc : std_logic_vector(10 downto 0);
signal frc_post_exc : std_logic_vector(51 downto 0);

signal bothZero : std_logic;
signal bothNegative : std_Logic;
signal outIsZero : std_logic;
signal outIsInf  : std_logic;

signal xIsZero, yIsZero : std_logic;

signal concExc : std_logic_vector(2 downto 0);
signal expUdf, expOvf : std_logic;
signal aIsReg, bIsReg : std_logic;

signal aIsZero_d1, bIsZero_d1 : std_logic;
signal aIsReg_d, bIsReg_d, bothZero_d, bothNegative_d, outIsNaN_d, aIsInf_d, bIsInf_d : std_logic;

signal xIsZero_d1, yIsZero_d1 : std_logic;
signal sticky_d1 : std_logic;

signal expX_post_first_update, expX_post_first_update_d : std_logic_vector(11 downto 0);
signal expX_d2 : std_logic_vector(10 downto 0);
signal b_post_sign : std_logic_vector(63 downto 0);
begin

sg : if SUBTRACT=1 generate
    b_post_sign <= not(b(63)) & b(62 downto 0);
else generate
    b_post_sign <= b;
end generate;


---------------------------------------------------------------------------
-- SCHEDULE TIME  0 -------------------------------------------------------
---------------------------------------------------------------------------
a_reg_label: delay_reg_chain generic map(width => 64, depth => INPUT_PIPELINE_STAGE) port map (clk => clk, xin => a,  xout => a_reg);     
b_reg_label: delay_reg_chain generic map(width => 64, depth => INPUT_PIPELINE_STAGE) port map (clk => clk, xin => b_post_sign,  xout => b_reg);     

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE) ------------------------------------
---------------------------------------------------------------------------
a_reg2_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => a_reg, xout => a_reg2);     
b_reg2_label: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) port map (clk => clk, xin => b_reg, xout => b_reg2);     

exp_frac_a <= a_reg(62 downto 0);
exp_frac_b <= b_reg(62 downto 0);

expFrac_cmp: int_add_or_sub
    generic map ( width => 63, issigned => 0, growth => 1, issub => 1, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => exp_frac_a, y => exp_frac_b, s => exp_frac_cmp);

signA <= a_reg(63);
signB <= b_reg(63);
     
expA <= a_reg(62 downto 52);
expB <= b_reg(62 downto 52);

fracA <= a_reg(51 downto 0);
fracB <= b_reg(51 downto 0);

expAMax_label : logical_reducing_and generic map ( width => expA'length ) port map (d => expA, q => expAMax);
expBMax_label : logical_reducing_and generic map ( width => expB'length ) port map (d => expB, q => expBMax);

expAZero_label : logical_reducing_nor generic map ( width => expA'length) port map (d => expA, q => expAZero);
expBZero_label : logical_reducing_nor generic map ( width => expB'length) port map (d => expB, q => expBZero);

fracAZero_label : logical_reducing_nor generic map ( width => fracA'length) port map (d=> fracA, q => fracAZero);
fracBZero_label : logical_reducing_nor generic map ( width => fracB'length) port map (d=> fracB, q => fracBZero);


aIsInf <= expAMax and fracAZero;
aIsNaN <= expAMax and (not(fracAZero));
aIsZero <= expAZero; --flush to zero
aIsReg <= not(aIsInf) and not(aIsNaN) and not(aIsZero);

bIsInf <= expBMax and fracBZero;
bIsNaN <= expBMax and (not(fracBZero));
bIsZero <= expBZero; 
bIsReg <= not(bIsInf) and not(bIsNaN) and not(bIsZero);

bothZero <= (aIsZero and bIsZero);
bothNegative <= signA and signB;
outIsNaN <= (aIsNaN or bIsNaN) or (aIsInf and bIsInf and (signA xor signB)); 

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+1) --------------------------------
---------------------------------------------------------------------------
exp_frac_a_gte_b <= exp_frac_cmp(63);

x_label: generic_mux_2to1 generic map ( width => 64, pipelined => IS_PIPELINED) port map ( clk => clk, x => a_reg2, y => b_reg2, s => exp_frac_a_gte_b, q => x );
y_label: generic_mux_2to1 generic map ( width => 64, pipelined => IS_PIPELINED) port map ( clk => clk, x => b_reg2, y => a_reg2, s => exp_frac_a_gte_b, q => y );

aIsZeroReg_label: delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => aIsZero, xout(0) => aIsZero_d1 );
bIsZeroReg_label: delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => bIsZero, xout(0) => bIsZero_d1 );

xIsZero <= bIsZero_d1 when exp_frac_a_gte_b='1' else aIsZero_d1;
yIsZero <= aIsZero_d1 when exp_frac_a_gte_b='1' else bIsZero_d1;

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+2) --------------------------------
---------------------------------------------------------------------------

xIsZeroReg_label : delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => xIsZero, xout(0) => xIsZero_d1 );
yIsZeroReg_label : delay_reg_chain generic map ( width => 1, depth => 1*IS_PIPELINED) port map ( clk => clk, xin(0) => yIsZero, xout(0) => yIsZero_d1 );
    
expX <= x(62 downto 52);
expY <= y(62 downto 52);

fracX <= x(51 downto 0);
fracY <= y(51 downto 0);

signX <= x(63 downto 63);
signY <= y(63 downto 63);

signX_delay_label: delay_reg_chain generic map(width =>  1, depth => 3*IS_PIPELINED) port map (clk => clk, xin => signX, xout => signX_d3);     
expX_delay_to_first_update: delay_reg_chain generic map(width => expX'length, depth => 2*IS_PIPELINED) port map (clk => clk, xin => expX, xout => expX_d2);

exp_diff_label: int_add_or_sub
    generic map ( width => expX'length, issigned => 0, growth => 0, issub => 1, pipelined => 0)
    port    map ( clk => clk, x => expX, y => expY, s => exp_diff);


exp_diff_sat <= exp_diff(5 downto 0) when exp_diff(10 downto 6)="00000" else "110111"; 

mantX <= not(xIsZero_d1) & fracX;
mantY <= not(yIsZero_d1) & fracY;

rsno: right_shifter_53bit_out55bit_s10_sticky_opt generic map (PIPELINE => 0)
    port map ( clk => clk, datain => mantY, shiftValue => exp_diff_sat, result=> right_shift_output, sticky => sticky);

eff_sub <= signX xor signY;

eff_op_delay: delay_reg_chain generic map( width =>  1, depth => 0) port map (clk => clk, xin => eff_sub, xout => eff_sub_d);
mantX_delay : delay_reg_chain generic map( width => 53, depth => 0) port map (clk => clk, xin => mantX,   xout => mantX_d);     

stickyReg_label: delay_reg_chain generic map( width => 1, depth => 1*IS_PIPELINED) port map (clk => clk, xin(0) => sticky, xout(0) => sticky_d1);

aligned_y <= right_shift_output; -- (1+52)+1+1 = 55 bits

base_x_mant <= "0" & "0" & mantX_d & "0" & (eff_sub_d and not(sticky));
base_y_xor  <= ("0" & "0" & aligned_y) XOR (56 downto 0 => eff_sub_d(0));

mant_sum_raw_label : int_add_or_sub
    generic map ( width => base_x_mant'length, issigned => 0, growth => 0, issub => 0, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => base_x_mant, y => base_y_xor, s => mant_sum_raw);

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+3) --------------------------------
---------------------------------------------------------------------------
mant_sum <= mant_sum_raw(55 downto 0) & sticky_d1;
mant_sum_delay: delay_reg_chain generic map(width => mant_sum'length, depth => 1*IS_PIPELINED) port map (clk => clk, xin => mant_sum, xout => mant_sum_d1);     
clz: s10_leading_zero_counter  
generic map (SIZE => mant_sum'length, OUT_SIZE => 6, PIPELINE => IS_PIPELINED) port map (clk  => clk, din  => mant_sum, dout => clz_value);

---------------------------------------------------------------------------
-- SCHEDULE TIME  (INPUT_PIPELINE_STAGE+4) --------------------------------
---------------------------------------------------------------------------

first_exp_update : int_add_or_sub
    generic map ( width => expX'length, issigned => 0, growth => 1, issub => 1, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => expX_d2, y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(clz_value), expX'length)) , s => expX_post_first_update);


clz_value_delay_label : delay_reg_chain generic map(width => 6, depth => 1*IS_PIPELINED) 
    port map (clk => clk, xin => clz_value, xout => clz_value_d4);     

     
ls: left_shifter_57bit generic map (PIPELINE => 0) port map ( clk => clk, datain => mant_sum_d1, shiftValue => clz_value, result => left_shift_output);

frac_out_pre_rnd <= left_shift_output(55 downto 3);
l_bit <= left_shift_output(4);
r_bit <= left_shift_output(3);
s_bit <= left_shift_output(2) or left_shift_output(1) or left_shift_output(0);
rnd_bit(0) <= not(not(l_bit) and (r_bit) and not(s_bit));

frac_out_post_rnd_label: int_add_or_sub
    generic map ( width => 54, issigned => 0, growth => 0, issub => 0, pipelined => IS_PIPELINED)
    port    map ( clk => clk, x => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(frac_out_pre_rnd), 54)), 
                              y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(rnd_bit),54)), s => frac_out_post_rnd);

---------------------------------------------------------------------------
-- SCHEDULE TIME (INPUT_PIPELINE_STAGE+5) ---------------------------------
---------------------------------------------------------------------------

expX_delay_to_second_update: delay_reg_chain generic map(width => expX_post_first_update'length, depth => 0) port map (clk => clk, xin => expX_post_first_update, xout => expX_post_first_update_d);     
inc_2     <= "10" when frac_out_post_rnd(53)='1' else "01";

second_exp_update : int_add_or_sub
    generic map ( width => expX_post_first_update'length, issigned => 0, growth => 0, issub => 0, pipelined => 0)
    port    map ( clk => clk, x => expX_post_first_update_d, y => STD_LOGIC_VECTOR(RESIZE(UNSIGNED(inc_2), 12)) , s => expX_cor);


aIsRegRegister_label       : delay_reg_chain generic map(width => 1, depth => 5*IS_PIPELINED) port map (clk => clk, xin(0) => aIsReg, xout(0) => aIsReg_d);     
bIsRegRegister_label       : delay_reg_chain generic map(width => 1, depth => 5*IS_PIPELINED) port map (clk => clk, xin(0) => bIsReg, xout(0) => bIsReg_d);     
bothZeroRegister_label     : delay_reg_chain generic map(width => 1, depth => 5*IS_PIPELINED) port map (clk => clk, xin(0) => bothZero, xout(0) => bothZero_d);     
bothNegativeRegister_label : delay_reg_chain generic map(width => 1, depth => 5*IS_PIPELINED) port map (clk => clk, xin(0) => bothNegative, xout(0) => bothNegative_d);     
outIsNaNRegister_label     : delay_reg_chain generic map(width => 1, depth => 5*IS_PIPELINED) port map (clk => clk, xin(0) => outIsNaN, xout(0) => outIsNaN_d);     

aIsInfRegister_label       : delay_reg_chain generic map(width => 1, depth => 5*IS_PIPELINED) port map (clk => clk, xin(0) => aIsInf, xout(0) => aIsInf_d);     
bIsInfRegister_label       : delay_reg_chain generic map(width => 1, depth => 5*IS_PIPELINED) port map (clk => clk, xin(0) => bIsInf, xout(0) => bIsInf_d);     

expUdf <= NOr(expX_cor(10 downto 0)) or expX_cor(11);
expOvf <= And(expX_cor(10 downto 0)) and not(expX_cor(11));

outIsZero <= bothZero_d or (aIsReg_d and bIsReg_d and expUdf);
outIsInf  <= ((aIsInf_d or bIsInf_d) and not(outIsNaN_d)) or (aIsReg_d and bIsReg_d and expOvf);

concExc <= outIszero & outIsNaN_d & outIsInf;


exp_exc_out_enc_label  : exp_exc_out_enc  port map ( exp_comp => expX_cor(10 downto 0), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, exp_out => exc_post_exc);
frac_exc_out_enc_label : frac_exc_out_enc port map ( frac_comp => frac_out_post_rnd(52 downto 1), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, frac_out => frc_post_exc);
sign_exc_out_enc_label : sign_exc_out_enc port map ( sign_comp => signX_d3(0), outIsZero => outIsZero, outIsNaN => outIsNaN_d, outIsInf => outIsInf, bothNegative => bothNegative_d, sign_out => sgn_post_exc);
                     
s_out <= sgn_post_exc & exc_post_exc & frc_post_exc;

output_register: delay_reg_chain generic map(width => 64, depth => 1*IS_PIPELINED) 
    port map (clk => clk, xin => s_out, xout => s);  

--LATENCY 7 cycles.
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity exp_exc_out_enc is
    port (
        exp_comp  : in  std_logic_vector(10 downto 0);
        outIsZero : in  std_logic;
        outIsNaN  : in  std_logic;
        outIsInf  : in  std_logic;
        exp_out   : out std_logic_vector(10 downto 0)
    );
end exp_exc_out_enc;

architecture rtl of exp_exc_out_enc is
signal concExc : std_logic_vector(2 downto 0);
begin

concExc <= outIszero & outIsNaN & outIsInf;

with concExc select
exp_out <= "00000000000" when "100",
           "11111111111" when "010"|"001",
           exp_comp      when others;
end rtl;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity frac_exc_out_enc is
    port (
        frac_comp : in  std_logic_vector(51 downto 0);
          outIsZero : in  std_logic;
          outIsNaN  : in  std_logic;
          outIsInf  : in  std_logic;
        frac_out  : out std_logic_vector(51 downto 0)
    );
end frac_exc_out_enc;

architecture rtl of frac_exc_out_enc is
signal concExc : std_logic_vector(2 downto 0);
begin

concExc <= outIszero & outIsNaN & outIsInf;

with concExc select
frac_out <= "0000000000000000000000000000000000000000000000000000" when "100"|"001",
            "0000000000000000000000000000000000000000000000000001" when "010",
            frac_comp                                              when others;
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_exc_out_enc is
    port (
        sign_comp    : in  std_logic;
        outIsZero    : in  std_logic;
        outIsNaN     : in  std_logic;
        outIsInf     : in  std_logic;
        bothNegative : in  std_logic;
        sign_out     : out std_logic
    );
end sign_exc_out_enc;

architecture rtl of sign_exc_out_enc is
signal concExc : std_logic_vector(2 downto 0);
begin

concExc <= outIszero & outIsNaN & outIsInf;

with (bothNegative & concExc)  select                     
sign_out <= '0' when "0010"|"1010"|"0100",
            '1' when "1100",
            sign_comp when others;
                     
end rtl;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity delay_reg_chain is
    generic (
        width : natural := 8;
        depth : natural := 1
    );
    port (
        clk   : in  std_logic;
        xin   : in  std_logic_vector(width-1 downto 0);
        xout  : out std_logic_vector(width-1 downto 0)
    );
end delay_reg_chain;

architecture delay of delay_reg_chain is
    type delay_array is array (depth downto 0) of std_logic_vector(width-1 downto 0);
    signal delay_signals : delay_array;
begin
    delay_signals(0) <= xin;

delay_block: if depth > 0 generate
    fg : for i in 1 to depth generate
        p: process(clk)
        begin
            if clk'event and clk='1' then
                delay_signals(i) <= delay_signals(i-1);                
            end if;
        end process;
    end generate;
end generate;
xout <= delay_signals(depth);     
end delay;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity int_add_or_sub is
    generic (
        width     : integer := 8;
        issigned  : integer := 0;
        growth    : integer := 0;
        issub     : integer := 0;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : out std_logic_vector(width+growth-1 downto 0)
    );
end int_add_or_sub;

architecture rtl of int_add_or_sub is
begin

fg_signed: if (issigned=1) generate
-- SIGNED TYPES
    fg_signed_pipe : if (pipelined=1) generate
    --PIPELINED
        fg_signed_pipe_add: if (issub=0) generate
        --ADD
            fg_signed_pipe_add_reg: process(clk)
            begin
                if (clk'event and clk='1') then
                    s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) + RESIZE(SIGNED(y), width+growth));
                end if;
            end process;
        else generate
        --SUB 
            fg_signed_pipe_sub_reg : process(clk)
            begin
                if (clk'event and clk='1') then
                    s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) - RESIZE(SIGNED(y), width+growth));
                end if;
            end process;
        end generate;        
    else generate
    --COMBINATORIAL    
        fg_signed_comb_add : if (issub=0) generate
        --ADD
            s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) + RESIZE(SIGNED(y), width+growth));
        else generate
        --SUB 
            s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) - RESIZE(SIGNED(y), width+growth));
        end generate;
    end generate;

else generate
-- UNSIGNED TYPES
    fg_unsigned_pipe : if (pipelined=1) generate
    --PIPELINED
        fg_unsigned_pipe_add: if (issub=0) generate
        --ADD
            fg_unsigned_pipe_add_reg: process(clk)
            begin
                if (clk'event and clk='1') then
                    s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) + RESIZE(UNSIGNED(y), width+growth));
                end if;
            end process;
        else generate
        --SUB
            fg_unsigned_pipe_sub_reg : process(clk)
            begin
                if (clk'event and clk='1') then
                    s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) - RESIZE(UNSIGNED(y), width+growth));
                end if;
            end process;
        end generate;        
    else generate
    --COMBINATORIAL    
        fg_unsigned_comb_add : if (issub=0) generate
        --ADD 
            s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) + RESIZE(UNSIGNED(y), width+growth));
        else generate
        --SUB 
            s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) - RESIZE(UNSIGNED(y), width+growth));
        end generate;
    end generate;
end generate;
end rtl;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity int_add_or_sub_pipe is
    generic (
          width     : integer := 8;
          issigned  : integer := 0;
          growth    : integer := 0;
          issub     : integer := 0;
          levels    : integer := 1;
          pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : out std_logic_vector(width+growth-1 downto 0)
    );
end int_add_or_sub_pipe;

architecture rtl of int_add_or_sub_pipe is
CONSTANT l_chunk_size : INTEGER := INTEGER(CEIL(REAL(WIDTH) / REAL(levels)));
CONSTANT h_chunk_size : INTEGER := width - l_chunk_size;

CONSTANT lcs : INTEGER := INTEGER(CEIL(REAL(WIDTH) / REAL(levels)));
CONSTANT hcs : INTEGER := width - l_chunk_size;

signal xh, yh : std_logic_vector(hcs-1 downto 0);
signal sl     : std_logic_vector(lcs downto 0);
signal sl_d   : std_logic_vector(lcs-1 downto 0);
signal sh     : std_logic_vector(hcs+growth downto 0);

signal slm : std_logic_vector(1+lcs+1-1 downto 0);
begin

ig_levels_1 : if levels=1 generate
    fg_signed: if (issigned=1) generate
        fg_signed_pipe : if (pipelined=1) generate
            fg_signed_pipe_add: if (issub=0) generate
                fg_signed_pipe_add_reg: process(clk)
                begin
                    if (clk'event and clk='1') then
                        s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) + RESIZE(SIGNED(y), width+growth));
                    end if;
                end process;
            else generate
                fg_signed_pipe_sub_reg : process(clk)
                begin
                    if (clk'event and clk='1') then
                        s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) - RESIZE(SIGNED(y), width+growth));
                    end if;
                end process;
            end generate;        
        else generate
            fg_signed_comb_add : if (issub=0) generate
                s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) + RESIZE(SIGNED(y), width+growth));
            else generate
                s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) - RESIZE(SIGNED(y), width+growth));
            end generate;
        end generate;
    else generate

        fg_unsigned_pipe : if (pipelined=1) generate
            fg_unsigned_pipe_add: if (issub=0) generate
                fg_unsigned_pipe_add_reg: process(clk)
                begin
                    if (clk'event and clk='1') then
                        s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) + RESIZE(UNSIGNED(y), width+growth));
                    end if;
                end process;
            else generate
                fg_unsigned_pipe_sub_reg : process(clk)
                begin
                    if (clk'event and clk='1') then
                        s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) - RESIZE(UNSIGNED(y), width+growth));
                    end if;
                end process;
            end generate;        
        else generate
            fg_unsigned_comb_add : if (issub=0) generate
                s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) + RESIZE(UNSIGNED(y), width+growth));
            else generate
                s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) - RESIZE(UNSIGNED(y), width+growth));
            end generate;
        end generate;
    end generate;
else generate
--only works for levels 2
    assert (LEVELS=2) report "LEVEL2 tasselation supported only by this component" severity error;

    fg_signed: if (issigned=1) generate
    -- SIGNED TYPE
        fg_signed_pipe : if (pipelined=1) generate
        -- PIPELINED
            fg_signed_pipe_add: if (issub=0) generate
            -- ADD
            -- SIGNED pipelined addition
                fg_signed_pipe_add_reg: process(clk)
                begin
                    if (clk'event and clk='1') then
                        -- SCHEDULE TIME 0
                        -- low chunk sum grows by 1 bit, 
                        sl <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x(lcs-1 downto 0)), lcs+1) + RESIZE(UNSIGNED(y(lcs-1 downto 0)), lcs+1)); --out @1
                        xh <= x(width-1 downto lcs); --out @1
                        yh <= y(width-1 downto lcs); --out @1
                        -- SCHEDULE TIME 1
                        -- lsb extend to inject carry-in
                        sh <= STD_LOGIC_VECTOR(RESIZE(SIGNED(xh & sl(lcs)), growth+hcs+1) + RESIZE(SIGNED(yh & sl(lcs)), growth+hcs+1)); --out @2
                        sl_d <= sl(lcs-1 downto 0); --out @2
                    end if;
                end process;
                s <= sh(hcs+growth downto 1) & sl_d;
            else generate
            -- SUB
            -- SIGNED extended pipelined subtraction
                fg_signed_pipe_sub_reg : process(clk)
                begin
                    if (clk'event and clk='1') then
                        -- SCHEDULE TIME 0
                        -- subtraction implemented as addition with 2's complement "-y"
                        -- the "+1" required by 2's complement is injected via LSB carry-in extension
                        slm <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x(lcs-1 downto 0) & "1"), 1+lcs+1) + RESIZE(UNSIGNED(not(y(lcs-1 downto 0)) & "1"), 1+lcs+1)); --out @1
                        xh  <= x(width-1 downto lcs); --out @1
                        yh  <= y(width-1 downto lcs); --out @1
                        -- SCHEDULE TIME 1
                        sh  <= STD_LOGIC_VECTOR(RESIZE(SIGNED(xh & sl(lcs)), growth+hcs+1) + SIGNED(NOT(STD_LOGIC_VECTOR(RESIZE(SIGNED(yh & sl(lcs)), growth+hcs+1))))); --out @2
                        sl_d <= slm(lcs downto 1); --out @2
                    end if;
                end process;
                -- SCHEDULE TIME 2
                s <= sh(hcs+growth downto 1) & sl_d;
            end generate;        
        else generate
        -- COMBINATORIAL
            fg_signed_comb_add : if (issub=0) generate
            -- ADD
                s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) + RESIZE(SIGNED(y), width+growth));
            else generate
            -- SUB
                s <= STD_LOGIC_VECTOR(RESIZE(SIGNED(x), width+growth) - RESIZE(SIGNED(y), width+growth));
            end generate;
        end generate;
    else generate
    --UNSIGNED
        fg_unsigned_pipe : if (pipelined=1) generate
            fg_unsigned_pipe_add: if (issub=0) generate
            ----------------------------------------------------------------------------------------------------
            -- UNSIGNED pipelined addition
                fg_unsigned_pipe_add_reg: process(clk)
                begin
                    if (clk'event and clk='1') then
                        sl <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x(lcs-1 downto 0)), lcs+1) + RESIZE(UNSIGNED(y(lcs-1 downto 0)), lcs+1));
                        xh <= x(width-1 downto lcs);
                        yh <= y(width-1 downto lcs);
                        sh <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(xh & sl(lcs)), growth+hcs+1) + RESIZE(UNSIGNED(yh & sl(lcs)), growth+hcs+1));
                        sl_d <= sl(lcs-1 downto 0);
                    end if;
                end process;
                s <= sh(hcs+growth downto 1) & sl_d;
            else generate
            ----------------------------------------------------------------------------------------------------
            -- UNSIGNED pipelined subtraction
                fg_unsigned_pipe_sub_reg : process(clk)
                begin
                    if (clk'event and clk='1') then
                        slm <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x(lcs-1 downto 0) & "1"), 1+lcs+1) + RESIZE(UNSIGNED(not(y(lcs-1 downto 0)) & "1"), 1+lcs+1));
                        xh <= x(width-1 downto lcs);
                        yh <= y(width-1 downto lcs);
                        sh <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(xh & slm(1+lcs)), growth+hcs+1) + UNSIGNED(NOT(STD_LOGIC_VECTOR(RESIZE(UNSIGNED(yh & slm(1+lcs)), growth+hcs+1)))));
                        sl_d <= slm(lcs downto 1);
                    end if;
                end process;
                s <= sh(hcs+growth downto 1) & sl_d;
            end generate;        
        else generate
        --combinatorial
            fg_unsigned_comb_add : if (issub=0) generate
                s <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x), width+growth) + RESIZE(UNSIGNED(y), width+growth));
            else generate
                slm <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(x(lcs-1 downto 0) & "1"), 1+lcs+1) + RESIZE(UNSIGNED(not(y(lcs-1 downto 0)) & "1"), 1+lcs+1));
                xh <= x(width-1 downto lcs);
                yh <= y(width-1 downto lcs);
                sh <= STD_LOGIC_VECTOR(RESIZE(UNSIGNED(xh & slm(1+lcs)), growth+hcs+1) + UNSIGNED(NOT(STD_LOGIC_VECTOR(RESIZE(UNSIGNED(yh & slm(1+lcs)), growth+hcs+1)))));
                sl_d <= slm(lcs downto 1);
                s <= sh(hcs+growth downto 1) & sl_d;            
            end generate;
        end generate;
    end generate;
end generate;
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_mux_2to1 is
    generic (
        width     : integer := 8;
        pipelined : integer := 1
    );
    port (
        clk   : in  std_logic;
        x     : in  std_logic_vector(width-1 downto 0);
        y     : in  std_logic_vector(width-1 downto 0);
        s     : in  std_logic;
        q     : out std_logic_vector(width-1 downto 0)
    );
end generic_mux_2to1;

architecture rtl of generic_mux_2to1 is
begin
pfg: if pipelined=1 generate
    pfg_p: process (clk)
    begin
        if (clk'event and clk='1') then
            q <= x when s='0' else y;
        end if;
    end process;
else generate
    with s select 
    q <= x when '0', y when others;
end generate;
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity logical_reducing_and is
    generic (
        width     : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end logical_reducing_and;

architecture rtl of logical_reducing_and is
begin
    q <= and(d);
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity logical_reducing_nor is
    generic (
        width     : integer := 8
    );
    port (
        d     : in  std_logic_vector(width-1 downto 0);
        q     : out std_logic
    );
end logical_reducing_nor;

architecture rtl of logical_reducing_nor is
begin
    q <= nor(d);
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity right_shifter_53bit_s10_sticky_opt is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(52 downto 0);
        shiftValue  : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(53 downto 0);
        sticky      : out std_logic
    );
end entity;

architecture rtl of right_shifter_53bit_s10_sticky_opt is
    component s10_barrel_shifter_core is
    generic (
        SIZE       : integer  := 32;
        SHIFT_SIZE : integer  :=  4; 
        LSB        : integer  :=  0;
        PIPELINE   : integer  :=  1;
        REC_LEVEL  : integer  :=  0
    );
    port(    
        clk   : in  std_logic;
        din   : in  std_Logic_vector(SIZE-1 downto 0);
        shift : in  std_logic_vector(SHIFT_SIZE-1 downto 0);
        dout  : out std_logic_vector(SIZE-1 downto LSB)
    );
    end component;
    
signal rev_datain : std_logic_vector(52 downto 0);
signal first_level_input, first_level_output : std_logic_vector(3+53 downto 0);
signal first_level_shift, first_level_shift_d : std_logic_vector(1 downto 0);

signal second_level_input_raw, second_level_output_raw : std_logic_vector(12+53 downto 0);
type second_level_input_type is array(3 downto 0) of std_logic_vector(16 downto 0);
signal second_level_input, second_level_output  : second_level_input_type;
signal second_level_shift : std_logic_vector(1 downto 0);
signal level_2_output_sticky : std_logic;

signal third_level_input_raw, third_level_output_raw : std_logic_vector(48+52 downto 0);
type third_level_input_type is array(15 downto 0) of std_logic_vector(6 downto 0);
signal third_level_input, third_level_output  : third_level_input_type;
signal third_level_shift : std_logic_vector(1 downto 0);
signal level_3_output_sticky : std_logic;

signal result_raw : std_logic_vector(52+63 downto 0);
begin

---------------------------------------------------------------------------
-- SCHEDULE TIME  0 -------------------------------------------------------
---------------------------------------------------------------------------

-- we can't do right shift, but we can do left shift.
-- consequently, we will emulate the right shift by 
-- left shifting the reversed bits
reverse : for i in 0 to 52 generate
    rev_datain(i) <= datain(52-i);
end generate;

-------------------------------------------------------------------
third_level_input_raw(100 downto 53) <= "000000000000000000000000000000000000000000000000";    
third_level_input_raw(52 downto 0)   <= rev_datain;
third_level_shift                    <= shiftValue(5 downto 4);

dl3 : for i in 0 to 15 generate
    dl3_j : for j in 0 to 6 generate
            dl3_if : if (j*16+i) <= 100 generate
                third_level_input(i)(j) <= third_level_input_raw(j*16+i);
            end generate;
    end generate;
end generate;

l3fg : for i in 0 to 15 generate    
    l3fg_if: if (i<=4) generate
        l3_core: s10_barrel_shifter_core 
            generic map (SIZE => 7, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => third_level_input(i), shift => third_level_shift, dout => third_level_output(i));
    else generate    
        l3_core: s10_barrel_shifter_core 
            generic map (SIZE => 6, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => third_level_input(i)(5 downto 0), shift => third_level_shift, dout => third_level_output(i)(5 downto 0));
    end generate;
end generate;

---------------------------------------------------------------------------
-- SCHEDULE TIME  1 -------------------------------------------------------
---------------------------------------------------------------------------
dl3_out : for i in 0 to 15 generate
    dl3_out_j : for j in 0 to 6 generate 
        dl3_out_if : if (16*j+i) <= 100 generate
            third_level_output_raw(16*j+i) <= third_level_output(i)(j);    
        end generate;
    end generate;
end generate;

second_level_input_raw(65 downto 54) <= "000000000000";    
second_level_input_raw(53 downto 0) <= third_level_output_raw(53 downto 0);

sl_pipe_gen : if (PIPELINE=0) generate
    second_level_shift <= shiftValue(3 downto 2);
    level_3_output_sticky <= OR ( third_level_output_raw(100 downto 54) );
else generate
    process(clk)
    begin
        if (clk'event and clk='1') then
            second_level_shift <= shiftValue(3 downto 2);
            level_3_output_sticky <= OR ( third_level_output_raw(100 downto 54) );
        end if;
    end process;
end generate;

--input signal grows by 12 to accompodate for the size increase;
--the shifts by bits [3:2] is equivalent to 4 shifts 
dl2 : for i in 0 to 3 generate
    dl2_j : for j in 0 to 16 generate
        dl2_if : if (j*4+i)<=65 generate
            second_level_input(i)(j) <= second_level_input_raw(j*4+i);
        end generate;
    end generate;
end generate;

l2fg : for i in 0 to 3 generate
    l2fg_if : if i<2 generate     
        l2_core: s10_barrel_shifter_core 
            generic map (SIZE => 17, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => second_level_input(i), shift => second_level_shift, dout => second_level_output(i));
    else generate
        l2_core: s10_barrel_shifter_core 
            generic map (SIZE => 16, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => second_level_input(i)(15 downto 0), shift => second_level_shift, dout => second_level_output(i)(15 downto 0));
    end generate;
end generate;

dl2_out : for i in 0 to 3 generate
    dl2_out_j : for j in 0 to 16 generate 
        dl2_out_if : if (4*j+i) <= 65 generate
            second_level_output_raw(4*j+i) <= second_level_output(i)(j);    
        end generate;
    end generate;
end generate;

---------------------------------------------------------------------------
-- SCHEDULE TIME  2 -------------------------------------------------------
---------------------------------------------------------------------------
fl_pipe_gen : if (PIPELINE=0) generate
    first_level_shift <= shiftValue(1 downto 0);
    level_2_output_sticky <= OR (level_3_output_sticky & second_level_output_raw(65 downto 54) );
else generate
    process(clk)
    begin
        if (clk'event and clk='1') then
            first_level_shift_d <= shiftValue(1 downto 0);
            first_level_shift   <= first_level_shift_d;
            level_2_output_sticky <= OR (level_3_output_sticky & second_level_output_raw(65 downto 54) );
        end if;
    end process;
end generate;

    
first_level_input(56 downto 54) <= "000";
first_level_input(53 downto  0) <= second_level_output_raw(53 downto 0);

l1_core: s10_barrel_shifter_core 
    generic map (SIZE => 57, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
    port map    (clk   => clk, din => first_level_input, shift => first_level_shift, dout => first_level_output);

---------------------------------------------------------------------------
-- SCHEDULE TIME  3 -------------------------------------------------------
---------------------------------------------------------------------------
sticky <= OR (level_2_output_sticky & first_level_output(56 downto 54));

final_fg : for i in 0 to 53 generate
    result(i) <= first_level_output(53-i);
end generate;
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity left_shifter_57bit is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(56 downto 0);
        shiftValue    : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(56 downto 0)
    );
end entity;

architecture rtl of left_shifter_57bit is
    component s10_barrel_shifter_core is
    generic (
        SIZE       : integer  := 32;
        SHIFT_SIZE : integer  :=  4; 
        LSB        : integer  :=  0;
        PIPELINE   : integer  :=  1;
        REC_LEVEL  : integer  :=  0
    );
    port(    
        clk   : in  std_logic;
        din   : in  std_Logic_vector(SIZE-1 downto 0);
        shift : in  std_logic_vector(SHIFT_SIZE-1 downto 0);
        dout  : out std_logic_vector(SIZE-1 downto LSB)
    );
    end component;
    
signal first_level_input, first_level_output : std_logic_vector(56 downto 0);
signal first_level_shift, first_level_shift_d : std_logic_vector(1 downto 0);
signal l1_core_1_drop3_0, l1_core_1_drop3_1 : std_logic_vector(2 downto 0);

signal second_level_input_raw, second_level_output_raw : std_logic_vector(56 downto 0);
type second_level_input_type is array(3 downto 0) of std_logic_vector(14 downto 0);
signal second_level_input, second_level_output  : second_level_input_type;
signal second_level_shift : std_logic_vector(1 downto 0);

signal third_level_input_raw, third_level_output_raw : std_logic_vector(56 downto 0);
type third_level_input_type is array(15 downto 0) of std_logic_vector(3 downto 0);
signal third_level_input, third_level_output  : third_level_input_type;
signal third_level_shift, third_level_shift_tmp : std_logic_vector(1 downto 0);

begin

---------------------------------------------------------------------------
-- SCHEDULE TIME  0 -------------------------------------------------------
---------------------------------------------------------------------------

first_level_input(56 downto  0) <= datain;
first_level_shift <= shiftValue(1 downto 0);

l1_core_0: s10_barrel_shifter_core 
    generic map (SIZE => 20, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
    port map    (clk   => clk, din => first_level_input(19 downto 0), shift => first_level_shift, dout => first_level_output(19 downto 0));

l1_core_1: s10_barrel_shifter_core 
    generic map (SIZE => 23, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
    port map    (clk   => clk, din => first_level_input(39 downto 17), shift => first_level_shift, dout(22 downto 3) => first_level_output(39 downto 20), dout(2 downto 0) => l1_core_1_drop3_0);

l1_core_2: s10_barrel_shifter_core 
    generic map (SIZE => 20, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
    port map    (clk   => clk, din => first_level_input(56 downto 37), shift => first_level_shift, dout(19 downto 3) => first_level_output(56 downto 40), dout(2 downto 0) => l1_core_1_drop3_1);

---------------------------------------------------------------------------
-- SCHEDULE TIME  1 -------------------------------------------------------
---------------------------------------------------------------------------
second_level_input_raw(56 downto 0) <= first_level_output(56 downto 0);

sl_pipe_gen : if (PIPELINE=0) generate
    second_level_shift <= shiftValue(3 downto 2);
else generate
    process(clk)
    begin
        if (clk'event and clk='1') then
            second_level_shift <= shiftValue(3 downto 2);
        end if;
    end process;
end generate;

dl2 : for i in 0 to 3 generate
    dl2_j : for j in 0 to 15 generate
        dl2_if : if (j*4+i)<=56 generate
            second_level_input(i)(j) <= second_level_input_raw(j*4+i);
        end generate;
    end generate;
end generate;

l2fg : for i in 0 to 3 generate
    l2fg_if : if i<1 generate     
        l2_core: s10_barrel_shifter_core 
            generic map (SIZE => 15, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => second_level_input(i), shift => second_level_shift, dout => second_level_output(i));
    else generate
        l2_core: s10_barrel_shifter_core 
            generic map (SIZE => 14, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => second_level_input(i)(13 downto 0), shift => second_level_shift, dout => second_level_output(i)(13 downto 0));
    end generate;
end generate;

---------------------------------------------------------------------------
-- SCHEDULE TIME  2 -------------------------------------------------------
---------------------------------------------------------------------------
dl2_out : for i in 0 to 3 generate
    dl2_out_j : for j in 0 to 15 generate 
        dl2_out_if : if (4*j+i) <= 56 generate
            second_level_output_raw(4*j+i) <= second_level_output(i)(j);    
        end generate;
    end generate;
end generate;

third_level_input_raw(56 downto 0) <= second_level_output_raw(56 downto 0);

tl_pipe_gen : if (PIPELINE=0) generate
    third_level_shift <= shiftValue(5 downto 4);
else generate
    process(clk)
    begin
        if (clk'event and clk='1') then
                third_level_shift_tmp <= shiftValue(5 downto 4);
                third_level_shift <= third_level_shift_tmp;
        end if;
    end process;
end generate;

dl3 : for i in 0 to 15 generate
    dl3_j : for j in 0 to 3 generate
            dl3_if : if (j*16+i) <= 56 generate
                third_level_input(i)(j) <= third_level_input_raw(j*16+i);
            end generate;
    end generate;
end generate;

l3fg : for i in 0 to 15 generate    
    l3fg_if: if (i<=8) generate
        l3_core: s10_barrel_shifter_core 
            generic map (SIZE => 4, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => third_level_input(i), shift => third_level_shift, dout => third_level_output(i));
    else generate    
        l3_core: s10_barrel_shifter_core 
            generic map (SIZE => 3, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => third_level_input(i)(2 downto 0), shift => third_level_shift, dout => third_level_output(i)(2 downto 0));
    end generate;
end generate;

---------------------------------------------------------------------------
-- SCHEDULE TIME  3 -------------------------------------------------------
---------------------------------------------------------------------------
dl3_out : for i in 0 to 15 generate
    dl3_out_j : for j in 0 to 3 generate 
        dl3_out_if : if (16*j+i) <= 56 generate
            third_level_output_raw(16*j+i) <= third_level_output(i)(j);    
        end generate;
    end generate;
end generate;

result <= third_level_output_raw(56 downto 0);
end rtl;


--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.dspba_s10_optimized_package.all;

entity right_shifter_53bit_out55bit_s10_sticky_opt is
    generic ( PIPELINE : integer := 1);
    port 
    (
        clk         : in  std_logic;
        datain      : in  std_logic_vector(52 downto 0);
        shiftValue  : in  std_logic_vector(5  downto 0);
        result      : out std_logic_vector(54 downto 0);
        sticky      : out std_logic
    );
end entity;

architecture rtl of right_shifter_53bit_out55bit_s10_sticky_opt is
    
signal rev_datain : std_logic_vector(52 downto 0);
signal first_level_input, first_level_output : std_logic_vector(3+54 downto 0);
signal first_level_shift, first_level_shift_d : std_logic_vector(1 downto 0);

signal second_level_input_raw, second_level_output_raw : std_logic_vector(12+54 downto 0);
type second_level_input_type is array(3 downto 0) of std_logic_vector(16 downto 0);
signal second_level_input, second_level_output  : second_level_input_type;
signal second_level_shift : std_logic_vector(1 downto 0);
signal level_2_output_sticky : std_logic;

signal third_level_input_raw, third_level_output_raw : std_logic_vector(48+52 downto 0);
type third_level_input_type is array(15 downto 0) of std_logic_vector(6 downto 0);
signal third_level_input, third_level_output  : third_level_input_type;
signal third_level_shift : std_logic_vector(1 downto 0);
signal level_3_output_sticky : std_logic;

signal result_raw : std_logic_vector(52+63 downto 0);
signal l1_core_1_drop3_0, l1_core_1_drop3_1 : std_logic_vector(2 downto 0);
begin

---------------------------------------------------------------------------
-- SCHEDULE TIME  0 -------------------------------------------------------
---------------------------------------------------------------------------

-- we can't do right shift, but we can do left shift.
-- consequently, we will emulate the right shift by 
-- left shifting the reversed bits
reverse : for i in 0 to 52 generate
    rev_datain(i) <= datain(52-i);
end generate;

-------------------------------------------------------------------
third_level_input_raw(100 downto 53) <= "000000000000000000000000000000000000000000000000";    
third_level_input_raw(52 downto 0)   <= rev_datain;
third_level_shift                    <= shiftValue(5 downto 4);

dl3 : for i in 0 to 15 generate
    dl3_j : for j in 0 to 6 generate
            dl3_if : if (j*16+i) <= 100 generate
                third_level_input(i)(j) <= third_level_input_raw(j*16+i);
            end generate;
    end generate;
end generate;

l3fg : for i in 0 to 15 generate    
    l3fg_if: if (i<=4) generate
        l3_core: s10_barrel_shifter_core 
            generic map (SIZE => 7, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => third_level_input(i), shift => third_level_shift, dout => third_level_output(i));
    else generate    
        l3_core: s10_barrel_shifter_core 
            generic map (SIZE => 6, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => third_level_input(i)(5 downto 0), shift => third_level_shift, dout => third_level_output(i)(5 downto 0));
    end generate;
end generate;

---------------------------------------------------------------------------
-- SCHEDULE TIME  1 -------------------------------------------------------
---------------------------------------------------------------------------
dl3_out : for i in 0 to 15 generate
    dl3_out_j : for j in 0 to 6 generate 
        dl3_out_if : if (16*j+i) <= 100 generate
            third_level_output_raw(16*j+i) <= third_level_output(i)(j);    
        end generate;
    end generate;
end generate;

second_level_input_raw(66 downto 55) <= "000000000000";    
second_level_input_raw(54 downto 0) <= third_level_output_raw(54 downto 0);

sl_pipe_gen : if (PIPELINE=0) generate
    second_level_shift <= shiftValue(3 downto 2);
    level_3_output_sticky <= OR ( third_level_output_raw(100 downto 55) );
else generate
    process(clk)
    begin
        if (clk'event and clk='1') then
            second_level_shift <= shiftValue(3 downto 2);
            level_3_output_sticky <= OR ( third_level_output_raw(100 downto 55) );
        end if;
    end process;
end generate;

dl2 : for i in 0 to 3 generate
    dl2_j : for j in 0 to 16 generate
        dl2_if : if (j*4+i)<=66 generate
            second_level_input(i)(j) <= second_level_input_raw(j*4+i);
        end generate;
    end generate;
end generate;

l2fg : for i in 0 to 3 generate
    l2fg_if : if i<3 generate     
        l2_core: s10_barrel_shifter_core 
            generic map (SIZE => 17, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => second_level_input(i), shift => second_level_shift, dout => second_level_output(i));
    else generate
        l2_core: s10_barrel_shifter_core 
            generic map (SIZE => 16, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
            port map    (clk   => clk, din => second_level_input(i)(15 downto 0), shift => second_level_shift, dout => second_level_output(i)(15 downto 0));
    end generate;
end generate;

---------------------------------------------------------------------------
-- SCHEDULE TIME  2 -------------------------------------------------------
---------------------------------------------------------------------------
dl2_out : for i in 0 to 3 generate
    dl2_out_j : for j in 0 to 16 generate 
        dl2_out_if : if (4*j+i) <= 66 generate
            second_level_output_raw(4*j+i) <= second_level_output(i)(j);    
        end generate;
    end generate;
end generate;

fl_pipe_gen : if (PIPELINE=0) generate
    first_level_shift <= shiftValue(1 downto 0);
    level_2_output_sticky <= OR (level_3_output_sticky & second_level_output_raw(66 downto 55) );
else generate
    process(clk)
    begin
        if (clk'event and clk='1') then
            first_level_shift_d <= shiftValue(1 downto 0);
            first_level_shift   <= first_level_shift_d;
            level_2_output_sticky <= OR (level_3_output_sticky & second_level_output_raw(66 downto 55) );
        end if;
    end process;
end generate;

    
first_level_input(57 downto 55) <= "000";
first_level_input(54 downto  0) <=     second_level_output_raw(54 downto 0);

l1_core_0: s10_barrel_shifter_core 
    generic map (SIZE => 20, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
    port map    (clk   => clk, din => first_level_input(19 downto 0), shift => first_level_shift, dout => first_level_output(19 downto 0));

l1_core_1: s10_barrel_shifter_core 
    generic map (SIZE => 23, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
    port map    (clk   => clk, din => first_level_input(39 downto 17), shift => first_level_shift, dout(22 downto 3) => first_level_output(39 downto 20), dout(2 downto 0) => l1_core_1_drop3_0);

l1_core_2: s10_barrel_shifter_core 
    generic map (SIZE => 21, SHIFT_SIZE => 2, LSB => 0, PIPELINE => PIPELINE, REC_LEVEL => 0) 
    port map    (clk   => clk, din => first_level_input(57 downto 37), shift => first_level_shift, dout(20 downto 3) => first_level_output(57 downto 40), dout(2 downto 0) => l1_core_1_drop3_1);    
    
---------------------------------------------------------------------------
-- SCHEDULE TIME  3 -------------------------------------------------------
---------------------------------------------------------------------------
    
sticky <= OR (level_2_output_sticky & first_level_output(57 downto 55));

final_fg : for i in 0 to 54 generate
    result(i) <= first_level_output(54-i);
end generate;

end rtl;

