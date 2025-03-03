-- Legal Notice: Copyright 2017 Intel Corporation.  All rights reserved.
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
use work.dspba_library_package.all;

-- This entity is identical to 'dspba_reg_w_attributes', but without the 
-- addition of altera attributes. Must keep these two entities in sync.
entity dspba_reg is
    generic (
        width : natural := 8;
        init_value : std_logic_vector;
        reset_high : std_logic := '1';
        reset_kind : string := "ASYNC"
    );
    port (
        clk   : in  std_logic;
        aclr  : in  std_logic;
        ena   : in  std_logic := '1';
        xin   : in  std_logic_vector(width-1 downto 0);
        xout  : out std_logic_vector(width-1 downto 0)
    );
end dspba_reg;

architecture reg of dspba_reg is
    constant init_value_internal : std_logic_vector(width-1 downto 0) := init_value;
begin
    async_reset: if reset_kind = "ASYNC" generate
        process(clk, aclr)
        begin
            if aclr = reset_high then
                xout <= init_value_internal;
            elsif rising_edge(clk) then
                if  ena = '1' then
                    xout <= xin;
                end if;
            end if;
        end process;
    end generate;
    sync_reset: if reset_kind = "SYNC" generate
        process(clk)
        begin
            if rising_edge(clk) then
                if aclr = reset_high then
                    xout <= init_value_internal;
                elsif ena = '1' then
                    xout <= xin;
                end if;
            end if;
        end process;
    end generate;
    none_reset: if reset_kind = "NONE" generate
        process(clk)
        begin
            if rising_edge(clk) then
                if  ena = '1' then
                    xout <= xin;
                end if;
            end if;
        end process;
    end generate;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use work.dspba_library_package.all;

-- This entity is identical to 'dspba_reg', but with the addition
-- of altera attributes. Must keep these two entities in sync.
entity dspba_reg_w_attributes is
    generic (
        width : natural := 8;
        init_value : std_logic_vector;
        reset_high : std_logic := '1';
        reset_kind : string := "ASYNC";
        attributes : string := ""
    );
    port (
        clk   : in  std_logic;
        aclr  : in  std_logic;
        ena   : in  std_logic := '1';
        xin   : in  std_logic_vector(width-1 downto 0);
        xout  : out std_logic_vector(width-1 downto 0)
    );
end dspba_reg_w_attributes;

architecture a1 of dspba_reg_w_attributes is
    signal reg : std_logic_vector(width-1 downto 0);
    attribute altera_attribute : string;
    attribute altera_attribute of reg : signal is attributes;
    constant init_value_internal : std_logic_vector(width-1 downto 0) := init_value;
begin
    xout <= reg;
    async_reset: if reset_kind = "ASYNC" generate
        process(clk, aclr)
        begin
            if aclr = reset_high then
                reg <= init_value_internal;
            elsif rising_edge(clk) then
                if  ena = '1' then
                    reg <= xin;
                end if;
            end if;
        end process;
    end generate;
    sync_reset: if reset_kind = "SYNC" generate
        process(clk)
        begin
            if rising_edge(clk) then
                if aclr = reset_high then
                    reg <= init_value_internal;
                elsif ena = '1' then
                    reg <= xin;
                end if;
            end if;
        end process;
    end generate;
    none_reset: if reset_kind = "NONE" generate
        process(clk)
        begin
            if rising_edge(clk) then
                if  ena = '1' then
                    reg <= xin;
                end if;
            end if;
        end process;
    end generate;
end architecture;


library IEEE;
use IEEE.std_logic_1164.all;
use work.dspba_library_package.all;

entity dspba_delay is
    generic (
        width : natural := 8;
        depth : natural := 1;
        reset_high : std_logic := '1';
        reset_kind : string := "ASYNC";
        phase : natural := 0;
        modulus : positive := 1
    );
    port (
        clk   : in  std_logic;
        aclr  : in  std_logic;
        ena   : in  std_logic := '1';
        xin   : in  std_logic_vector(width-1 downto 0);
        xout  : out std_logic_vector(width-1 downto 0)
    );
end dspba_delay;

architecture delay of dspba_delay is
    type delay_array is array (depth downto 0) of std_logic_vector(width-1 downto 0);
    signal delay_signals : delay_array;
    constant init_value : std_logic_vector(width - 1 downto 0) := (others => '0');
begin
    delay_signals(depth) <= xin;

    delay_block: if 0 < depth generate
    begin
        delay_loop: for i in depth-1 downto 0 generate
        begin
            with_reset: if 0 = (phase+depth-1-i) mod modulus generate
                reg: dspba_reg
                    generic map (
                        width => width, 
                        init_value => init_value, 
                        reset_high => reset_high, 
                        reset_kind => reset_kind)
                    port map (clk, aclr, ena, delay_signals(i + 1), delay_signals(i));
            end generate;

            without_reset: if 0 /= (phase+depth-1-i) mod modulus generate
                reg: dspba_reg
                    generic map (
                        width => width, 
                        init_value => init_value, 
                        reset_high => reset_high, 
                        reset_kind => "NONE") 
                    port map (clk, aclr, ena, delay_signals(i + 1), delay_signals(i));
            end generate;
        end generate;
    end generate;

    xout <= delay_signals(0);
end delay;

--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use work.dspba_library_package.all;

entity dspba_sync_reg is
    generic (
        width1 : natural := 8;
        init_value : std_logic_vector;
        width2 : natural := 8;
        depth : natural := 2;
        pulse_multiplier : natural := 1;
        counter_width : natural := 8;
        reset1_high : std_logic := '1';
        reset2_high : std_logic := '1';
        reset_kind : string := "ASYNC";
        implementation : string := "ASYNC" -- ASYNC, SYNC, SYNC_LITE
    );
    port (
        clk1    : in std_logic;
        aclr1   : in std_logic;
        ena     : in std_logic_vector(0 downto 0);
        xin     : in std_logic_vector(width1-1 downto 0);
        xout    : out std_logic_vector(width1-1 downto 0);
        clk2    : in std_logic;
        aclr2   : in std_logic;
        sxout   : out std_logic_vector(width2-1 downto 0)
    );
end entity;

architecture sync_reg of dspba_sync_reg is
    type bit_array is array (depth downto 0) of std_logic_vector(0 downto 0);

    signal iclk_enable : std_logic_vector(0 downto 0);
    signal iclk_data : std_logic_vector(width1-1 downto 0);
    signal oclk_data : std_logic_vector(width2-1 downto 0); 
    signal sync_regs : bit_array;
    signal oclk_enable : std_logic;

    constant init_value_internal : std_logic_vector(width1-1 downto 0) := init_value;
    
    signal counter : UNSIGNED(counter_width-1 downto 0);
    signal ena_internal : std_logic_vector(0 downto 0);
begin
    impl_async: if implementation = "ASYNC" generate 

        no_multiplication: if pulse_multiplier=1 generate
            ena_internal <= ena;
        end generate;

        with_multiplication: if pulse_multiplier > 1 generate

            ena_internal <= "1" when counter > 0 else ena;

            async_reset: if reset_kind="ASYNC" generate
                    process (clk1, aclr1)
                    begin   
                        if aclr1=reset1_high then
                            counter <= (others => '0');
                        elsif clk1'event and clk1='1' then
                            if counter>0 then
                                if counter=pulse_multiplier-1 then
                                    counter <= (others => '0');
                                else 
                                    counter <= counter + TO_UNSIGNED(1, counter_width);
                                end if;
                            else
                                if ena(0)='1' then
                                    counter <= TO_UNSIGNED(1, counter_width);
                                end if;
                            end if;
                        end if;
                    end process;
            end generate;

            sync_reset: if reset_kind="SYNC" generate
                    process (clk1)
                    begin
                        if clk1'event and clk1='1' then
                            if aclr1=reset1_high then
                                counter <= (others => '0');
                            else
                                if counter>0 then
                                    if counter=pulse_multiplier-1 then
                                        counter <= (others => '0');
                                    else 
                                        counter <= counter + TO_UNSIGNED(1, counter_width);
                                    end if;
                                else
                                    if ena(0)='1' then
                                        counter <= TO_UNSIGNED(1, counter_width);
                                    end if;
                                end if;
                            end if;
                        end if;
                    end process;
            end generate;

            none_reset: if reset_kind="NONE" generate
                    process (clk1, aclr1) 
                    begin
                        if clk1'event and clk1='1' then
                            if counter>0 then
                                if counter=pulse_multiplier-1 then
                                    counter <= (others => '0');
                                else 
                                    counter <= counter + TO_UNSIGNED(1, counter_width);
                                end if;
                            else
                                if ena(0)='1' then
                                    counter <= TO_UNSIGNED(1, counter_width);
                                end if;
                            end if;
                        end if;
                    end process;
            end generate;
        end generate;

        reg_iclk_en: dspba_reg
            generic map (
                width => 1, 
                init_value => "0", 
                reset_high => reset1_high, 
                reset_kind => reset_kind) 
            port map (clk1, aclr1, '1', ena_internal, iclk_enable);

        reg_iclk_data: dspba_reg
            generic map (
                width => width1, 
                init_value => init_value_internal, 
                reset_high => reset1_high, 
                reset_kind => reset_kind) 
            port map (clk1, aclr1, ena(0), xin, iclk_data);

        sync_regs(0) <= iclk_enable;  
        loop_sync: for i in 1 to depth generate
            reg_sync: dspba_reg_w_attributes 
                    generic map (
                        width => 1, 
                        init_value => "0", 
                        reset_high => reset2_high, 
                        reset_kind => reset_kind,
                        attributes => "-name ADV_NETLIST_OPT_ALLOWED NEVER_ALLOW; -name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS; -name DONT_MERGE_REGISTER ON; -name PRESERVE_REGISTER ON; -name FORCE_SYNCH_CLEAR ON")
                    port map (clk2, aclr2, '1', sync_regs(i - 1), sync_regs(i));
        end generate;
        oclk_enable <= sync_regs(depth)(0);

        reg_oclk_data: dspba_reg_w_attributes
            generic map (
                width => width2, 
                init_value => init_value_internal(width2 - 1 downto 0), 
                reset_high => reset2_high, 
                reset_kind => reset_kind,
                attributes => "-name SYNCHRONIZER_IDENTIFICATION OFF")
            port map (clk2, aclr2, oclk_enable, iclk_data(width2 - 1 downto 0), oclk_data);

    end generate;

    impl_sync: if implementation = "SYNC" generate

        reg_iclk_data: dspba_reg
            generic map (
                width => width1, 
                init_value => init_value_internal, 
                reset_high => reset1_high, 
                reset_kind => reset_kind) 
            port map (clk1, aclr1, ena(0), xin, iclk_data);

        reg_oclk_data: dspba_reg
            generic map (
                width => width2, 
                init_value => init_value_internal(width2 - 1 downto 0), 
                reset_high => reset2_high, 
                reset_kind => reset_kind) 
            port map (clk2, aclr2, '1', iclk_data(width2 - 1 downto 0), oclk_data);

    end generate;

    impl_sync_lite: if implementation = "SYNC_LITE" generate

        reg_iclk_data: dspba_reg
            generic map (
                width => width1, 
                init_value => init_value_internal, 
                reset_high => reset1_high, 
                reset_kind => reset_kind) 
            port map (clk1, aclr1, ena(0), xin, iclk_data);

        oclk_data <= iclk_data(width2-1 downto 0);
        
    end generate;

    xout <= iclk_data;
    sxout <= oclk_data;

end sync_reg;

--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dspba_pipe is
    generic(
        num_bits   : positive  := 8;
        num_stages : natural   := 0;
        init_value : std_logic := 'X'
    );
    port(
        clk: in    std_logic;
        d  : in    std_logic_vector(num_bits-1 downto 0);
        q  :   out std_logic_vector(num_bits-1 downto 0)
    );
end entity dspba_pipe;

architecture rtl of dspba_pipe is
    attribute altera_attribute : string;
    attribute altera_attribute of rtl : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION off";

    type stage_array_type is array(0 to num_stages) of std_logic_vector(num_bits-1 downto 0);
    signal stage_array : stage_array_type;
begin
    stage_array(0) <= d;

    g_pipe : for i in 1 to num_stages generate
        p_stage : process (clk) is
        begin
            if rising_edge(clk) then
                stage_array(i) <= stage_array(i-1);
            end if;
        end process p_stage;
    end generate g_pipe;

    q <= stage_array(num_stages);

end rtl;

-----------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library altera_mf;
use altera_mf.altera_mf_components.all;

-- The only purpose of this wrapper is so that we can apply timing constraints
-- to dcfifo_mixed_widths using SDC_ENTITY_FILE qsf setting. It appears that 
-- SDC_ENTITY_FILE cannot be applied directly to dcfifo_mixed_widths.
entity dspba_dcfifo_mixed_widths is
    generic(
        lpm_width   : natural;
        lpm_width_r : natural;
        lpm_numwords : natural;
        lpm_showahead : string;
        lpm_type    :   string;
        lpm_hint    :   string;
        overflow_checking   :   string;
        underflow_checking  :   string;
        use_eab :   string;
        add_ram_output_register :   string;
        intended_device_family : string;
        lpm_widthu : natural;
        lpm_widthu_r : natural;
        clocks_are_synchronized :   string;
        rdsync_delaypipe : natural;
        wrsync_delaypipe : natural;
        write_aclr_synch  :   string;
        read_aclr_synch  :   string
    );
    port(
        rdreq: in    std_logic;
        wrclk: in    std_logic;
        rdclk: in    std_logic;
        aclr: in    std_logic;
        wrreq: in    std_logic;
        data  : in    std_logic_vector(lpm_width-1 downto 0);
        rdempty: out    std_logic;
        q  :   out std_logic_vector(lpm_width_r-1 downto 0)
    );
end entity dspba_dcfifo_mixed_widths;

architecture rtl of dspba_dcfifo_mixed_widths is
begin

    dcfifo_mixed_widths_component : dcfifo_mixed_widths
    generic map (
        lpm_width => lpm_width,
        lpm_width_r => lpm_width_r,
        lpm_numwords => lpm_numwords,
        lpm_showahead => lpm_showahead,
        lpm_type => lpm_type,
        lpm_hint  => lpm_hint,
        overflow_checking => overflow_checking,
        underflow_checking => underflow_checking,
        use_eab => use_eab,
        add_ram_output_register => add_ram_output_register,
        intended_device_family => intended_device_family,
        lpm_widthu => lpm_widthu,
        lpm_widthu_r => lpm_widthu_r,
        clocks_are_synchronized => clocks_are_synchronized,
        rdsync_delaypipe => rdsync_delaypipe,
        wrsync_delaypipe => wrsync_delaypipe, 
        write_aclr_synch => write_aclr_synch, 
        read_aclr_synch => read_aclr_synch 
    )
    port map (
        rdreq => rdreq,
        wrclk => wrclk,
        rdclk => rdclk,
        aclr => aclr,
        wrreq => wrreq,
        data => data,
        rdempty => rdempty,
        q => q
    );

end rtl;
