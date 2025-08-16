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
use std.TextIO.all;
USE work.DF_fixp16_alu_av_FOC_safe_path.all;
use work.dspba_sim_library_package.all;

entity DF_fixp16_alu_av_FOC_stm is
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
end DF_fixp16_alu_av_FOC_stm;

architecture normal of DF_fixp16_alu_av_FOC_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal clk_stm_sig_stopped : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal h_areset_stm_sig : std_logic := '1';
    signal clk_Iu_stm_sig_stop : std_logic := '0';
    signal clk_Iw_stm_sig_stop : std_logic := '0';
    signal clk_vu_pwm_stm_sig_stop : std_logic := '0';
    signal clk_vv_pwm_stm_sig_stop : std_logic := '0';
    signal clk_vw_pwm_stm_sig_stop : std_logic := '0';

    function str_to_stdvec(inp: string) return std_logic_vector is
        variable temp: std_logic_vector(inp'range) := (others => 'X');
    begin
        for i in inp'range loop
            IF ((inp(i) = '1')) THEN
                temp(i) := '1';
            elsif (inp(i) = '0') then
                temp(i) := '0';
            END IF;
            end loop;
            return temp;
        end function str_to_stdvec;
        

    begin

    clk <= clk_stm_sig;
    clk_process: process 
    begin
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 4800 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            clk_stm_sig_stopped <= '1';
            wait;
        end if;
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 4800 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            clk_stm_sig_stopped <= '1';
            wait;
        end if;
    end process;

    areset <= areset_stm_sig;
    areset_process: process begin
        areset_stm_sig <= '1';
        wait for 7500 ps;
        wait for 1023*10000 ps; -- additional reset delay
        areset_stm_sig <= '0';
        wait;
    end process;

    h_areset <= h_areset_stm_sig;
    h_areset_process: process begin
        h_areset_stm_sig <= '1';
        wait for 7500 ps;
        wait for 1023*10000 ps; -- additional reset delay
        h_areset_stm_sig <= '0';
        wait;
    end process;

        end_of_sim_msg_p: process(clk_stm_sig_stopped, clk_stm_sig_stopped)
        begin
            if (clk_stm_sig_stopped = '1' AND clk_stm_sig_stopped = '1') then
                if (report_mismatch_failure_detected) then
                    report "Simulation finished. Mismatches were detected between the Simulink and RTL simulations." severity NOTE;
                elsif (report_mismatch_warning_detected) then
                    report "Simulation finished. Mismatches defined as warnings were detected between the Simulink and RTL simulations, but no mismatches defined as errors were detected. Check signal mismatch messages above." severity NOTE;
                else
                    report "Simulation finished. No mismatches were detected between the Simulink and RTL simulations." severity NOTE;
                end if;
            end if;
        end process;
        
        -- Driving gnd for busIn signals

        busIn_writedata_stm <= (others => '0');
        busIn_address_stm <= (others => '0');
        busIn_write_stm <= (others => '0');
        busIn_read_stm <= (others => '0');

        -- Generating stub busOut - no stimulus
        -- initialize all outputs to 0
        busOut_readdatavalid_stm <= (others => '0');
        busOut_readdata_stm <= (others => '0');
        busOut_waitrequest_stm <= (others => '0');

        -- Generating stimulus for Iu
        Iu_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn2 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_ChannelIn2.stm");
            variable in_5_Iu_tpl_int_0 : Integer;
            variable in_5_Iu_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Iu_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Iu_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Iu)
                IF (endfile(data_file_ChannelIn2)) THEN
                    clk_Iu_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn2, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_5_Iu_tpl_int_0);
                    in_5_Iu_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_5_Iu_tpl_int_0, 16));
                    Iu_stm <= in_5_Iu_tpl_temp;
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Iw
        Iw_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn2 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_ChannelIn2.stm");
            variable in_6_Iw_tpl_int_0 : Integer;
            variable in_6_Iw_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Iw_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Iw_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Iw)
                IF (endfile(data_file_ChannelIn2)) THEN
                    clk_Iw_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn2, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_6_Iw_tpl_int_0);
                    in_6_Iw_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_6_Iw_tpl_int_0, 16));
                    Iw_stm <= in_6_Iw_tpl_temp;
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for vu_pwm
        vu_pwm_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut1_vunroll_x : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_ChannelOut1_vunroll_x.stm");
            variable out_11_uvw_0_tpl_int_0 : Integer;
            variable out_11_uvw_0_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            vu_pwm_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to vu_pwm)
                IF (endfile(data_file_ChannelOut1_vunroll_x)) THEN
                    clk_vu_pwm_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut1_vunroll_x, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, out_11_uvw_0_tpl_int_0);
                    out_11_uvw_0_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_uvw_0_tpl_int_0, 16));
                    vu_pwm_stm <= out_11_uvw_0_tpl_temp;
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for vv_pwm
        vv_pwm_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut1_vunroll_x : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_ChannelOut1_vunroll_x.stm");
            variable out_11_uvw_1_tpl_int_0 : Integer;
            variable out_11_uvw_1_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            vv_pwm_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to vv_pwm)
                IF (endfile(data_file_ChannelOut1_vunroll_x)) THEN
                    clk_vv_pwm_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut1_vunroll_x, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, out_11_uvw_1_tpl_int_0);
                    out_11_uvw_1_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_uvw_1_tpl_int_0, 16));
                    vv_pwm_stm <= out_11_uvw_1_tpl_temp;
                    read(L, dummy_int);
                    read(L, dummy_int);

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for vw_pwm
        vw_pwm_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut1_vunroll_x : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_ChannelOut1_vunroll_x.stm");
            variable out_11_uvw_2_tpl_int_0 : Integer;
            variable out_11_uvw_2_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            vw_pwm_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to vw_pwm)
                IF (endfile(data_file_ChannelOut1_vunroll_x)) THEN
                    clk_vw_pwm_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut1_vunroll_x, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, out_11_uvw_2_tpl_int_0);
                    out_11_uvw_2_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_uvw_2_tpl_int_0, 16));
                    vw_pwm_stm <= out_11_uvw_2_tpl_temp;
                    read(L, dummy_int);

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_Iu_stm_sig_stop OR clk_Iw_stm_sig_stop OR clk_vu_pwm_stm_sig_stop OR clk_vv_pwm_stm_sig_stop OR clk_vw_pwm_stm_sig_stop OR '0';


    END normal;
