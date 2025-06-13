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

package dspba_s10_optimized_package is

component shift_right_stratix10 is
generic (
    SIZE       : integer  := 32;
    SHIFT_SIZE : integer  :=  4; 
    LSB        : integer  :=  0;
    PIPELINE   : integer  :=  1
);
port(    
    clk   : in  std_logic;
    din   : in  std_Logic_vector(SIZE-1 downto 0);
    shift : in  std_logic_vector(SHIFT_SIZE-1 downto 0);
    dout  : out std_logic_vector(SIZE-1 downto LSB)
);
end component;

component shift_left_stratix10 is
generic (
    SIZE       : integer  := 32;
    SHIFT_SIZE : integer  :=  4; 
    LSB        : integer  :=  0;
    PIPELINE   : integer  :=  1
);
port(    
    clk   : in  std_logic;
    din   : in  std_Logic_vector(SIZE-1 downto 0);
    shift : in  std_logic_vector(SHIFT_SIZE-1 downto 0);
    dout  : out std_logic_vector(SIZE-1 downto LSB)
);
end component;

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

component fpadd_fp64_we11_wf52_Stratix10 is
generic (
    PIPELINE : INTEGER := 1;
    SUBTRACT : INTEGER := 0; 
    SPEED    : INTEGER := 3 
); 
    port 
    (
        clk    : in  std_logic;
        a      : in  std_logic_vector (63 downto 0);
        b      : in  std_logic_vector (63 downto 0);
        s      : out std_logic_vector (63 downto 0)
    );
end component;

end dspba_s10_optimized_package;
