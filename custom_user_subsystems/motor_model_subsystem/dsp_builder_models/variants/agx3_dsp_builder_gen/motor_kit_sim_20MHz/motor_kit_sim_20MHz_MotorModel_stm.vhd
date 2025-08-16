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

-- VHDL created from motor_kit_sim_20MHz_MotorModel
-- VHDL created on Mon Aug 11 01:49:11 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;
use work.dspba_sim_library_package.all;

entity motor_kit_sim_20MHz_MotorModel_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        busOut_waitrequest_stm : out std_logic_vector(0 downto 0);
        u_h_stm : out std_logic_vector(0 downto 0);
        v_h_stm : out std_logic_vector(0 downto 0);
        w_h_stm : out std_logic_vector(0 downto 0);
        u_l_stm : out std_logic_vector(0 downto 0);
        v_l_stm : out std_logic_vector(0 downto 0);
        w_l_stm : out std_logic_vector(0 downto 0);
        powerdown_p_stm : out std_logic_vector(0 downto 0);
        powerdown_n_stm : out std_logic_vector(0 downto 0);
        ia_sd_stm : out std_logic_vector(0 downto 0);
        ib_sd_stm : out std_logic_vector(0 downto 0);
        ic_sd_stm : out std_logic_vector(0 downto 0);
        Va_sd_stm : out std_logic_vector(0 downto 0);
        Vb_sd_stm : out std_logic_vector(0 downto 0);
        Vc_sd_stm : out std_logic_vector(0 downto 0);
        QEP_A_stm : out std_logic_vector(0 downto 0);
        QEP_B_stm : out std_logic_vector(0 downto 0);
        Theta_one_turn_k_stm : out std_logic_vector(15 downto 0);
        V_DC_link_sd_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic;
        h_areset : out std_logic
    );
end motor_kit_sim_20MHz_MotorModel_stm;

architecture normal of motor_kit_sim_20MHz_MotorModel_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal clk_stm_sig_stopped : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal h_areset_stm_sig : std_logic := '1';
    signal clk_busIn_stm_sig_stop : std_logic := '0';
    signal clk_busOut_stm_sig_stop : std_logic := '0';
    signal clk_u_h_stm_sig_stop : std_logic := '0';
    signal clk_v_h_stm_sig_stop : std_logic := '0';
    signal clk_w_h_stm_sig_stop : std_logic := '0';
    signal clk_u_l_stm_sig_stop : std_logic := '0';
    signal clk_v_l_stm_sig_stop : std_logic := '0';
    signal clk_w_l_stm_sig_stop : std_logic := '0';
    signal clk_powerdown_p_stm_sig_stop : std_logic := '0';
    signal clk_powerdown_n_stm_sig_stop : std_logic := '0';
    signal clk_ia_sd_stm_sig_stop : std_logic := '0';
    signal clk_ib_sd_stm_sig_stop : std_logic := '0';
    signal clk_ic_sd_stm_sig_stop : std_logic := '0';
    signal clk_Va_sd_stm_sig_stop : std_logic := '0';
    signal clk_Vb_sd_stm_sig_stop : std_logic := '0';
    signal clk_Vc_sd_stm_sig_stop : std_logic := '0';
    signal clk_QEP_A_stm_sig_stop : std_logic := '0';
    signal clk_QEP_B_stm_sig_stop : std_logic := '0';
    signal clk_Theta_one_turn_k_stm_sig_stop : std_logic := '0';
    signal clk_V_DC_link_sd_stm_sig_stop : std_logic := '0';

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
        wait for 24800 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
            clk_stm_sig_stopped <= '1';
            wait;
        end if;
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 24800 ps;
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
        wait for 37500 ps;
        wait for 1023*50000 ps; -- additional reset delay
        areset_stm_sig <= '0';
        wait;
    end process;

    h_areset <= h_areset_stm_sig;
    h_areset_process: process begin
        h_areset_stm_sig <= '1';
        wait for 37500 ps;
        wait for 1023*50000 ps; -- additional reset delay
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
        

        -- Generating stimulus for busIn
        busIn_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_busIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_busIn.stm");
            variable busIn_writedata_int_0 : Integer;
            variable busIn_writedata_temp : std_logic_vector(31 downto 0);
            variable busIn_address_int_0 : Integer;
            variable busIn_address_temp : std_logic_vector(5 downto 0);
            variable busIn_write_int_0 : Integer;
            variable busIn_write_temp : std_logic_vector(0 downto 0);
            variable busIn_read_int_0 : Integer;
            variable busIn_read_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            busIn_writedata_stm <= (others => '0');
            busIn_address_stm <= (others => '0');
            busIn_write_stm <= (others => '0');
            busIn_read_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                IF (endfile(data_file_busIn)) THEN
                    clk_busIn_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_busIn, L);
                    
                    read(L, busIn_writedata_int_0);
                    busIn_writedata_temp(31 downto 0) := std_logic_vector(to_signed(busIn_writedata_int_0, 32));
                    busIn_writedata_stm <= busIn_writedata_temp;
                    read(L, busIn_address_int_0);
                    busIn_address_temp(5 downto 0) := std_logic_vector(to_unsigned(busIn_address_int_0, 6));
                    busIn_address_stm <= busIn_address_temp;
                    read(L, busIn_write_int_0);
                    busIn_write_temp(0 downto 0) := std_logic_vector(to_unsigned(busIn_write_int_0, 1));
                    busIn_write_stm <= busIn_write_temp;
                    read(L, busIn_read_int_0);
                    busIn_read_temp(0 downto 0) := std_logic_vector(to_unsigned(busIn_read_int_0, 1));
                    busIn_read_stm <= busIn_read_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for busOut
        busOut_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_busOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_busOut.stm");
            variable busOut_readdatavalid_int_0 : Integer;
            variable busOut_readdatavalid_temp : std_logic_vector(0 downto 0);
            variable busOut_readdata_int_0 : Integer;
            variable busOut_readdata_temp : std_logic_vector(31 downto 0);
            variable busOut_waitrequest_int_0 : Integer;
            variable busOut_waitrequest_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            busOut_readdatavalid_stm <= (others => '0');
            busOut_readdata_stm <= (others => '0');
            busOut_waitrequest_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                IF (endfile(data_file_busOut)) THEN
                    clk_busOut_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_busOut, L);
                    
                    read(L, busOut_readdatavalid_int_0);
                    busOut_readdatavalid_temp(0 downto 0) := std_logic_vector(to_unsigned(busOut_readdatavalid_int_0, 1));
                    busOut_readdatavalid_stm <= busOut_readdatavalid_temp;
                    read(L, busOut_readdata_int_0);
                    busOut_readdata_temp(31 downto 0) := std_logic_vector(to_signed(busOut_readdata_int_0, 32));
                    busOut_readdata_stm <= busOut_readdata_temp;
                    read(L, busOut_waitrequest_int_0);
                    busOut_waitrequest_temp(0 downto 0) := std_logic_vector(to_unsigned(busOut_waitrequest_int_0, 1));
                    busOut_waitrequest_stm <= busOut_waitrequest_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for u_h
        u_h_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_3_Va_V_tpl_int_0 : Integer;
            variable in_3_Va_V_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            u_h_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                u_h_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to u_h)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_u_h_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_3_Va_V_tpl_int_0);
                    in_3_Va_V_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_3_Va_V_tpl_int_0, 1));
                    u_h_stm <= in_3_Va_V_tpl_temp;
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
                    read(L, dummy_int);

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for v_h
        v_h_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_4_Vb_V_tpl_int_0 : Integer;
            variable in_4_Vb_V_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            v_h_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                v_h_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to v_h)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_v_h_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_4_Vb_V_tpl_int_0);
                    in_4_Vb_V_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_4_Vb_V_tpl_int_0, 1));
                    v_h_stm <= in_4_Vb_V_tpl_temp;
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

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for w_h
        w_h_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_5_Vc_V_tpl_int_0 : Integer;
            variable in_5_Vc_V_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            w_h_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                w_h_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to w_h)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_w_h_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_5_Vc_V_tpl_int_0);
                    in_5_Vc_V_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_5_Vc_V_tpl_int_0, 1));
                    w_h_stm <= in_5_Vc_V_tpl_temp;
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

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for u_l
        u_l_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_6_u_l_tpl_int_0 : Integer;
            variable in_6_u_l_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            u_l_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                u_l_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to u_l)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_u_l_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_6_u_l_tpl_int_0);
                    in_6_u_l_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_6_u_l_tpl_int_0, 1));
                    u_l_stm <= in_6_u_l_tpl_temp;
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

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for v_l
        v_l_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_7_v_l_tpl_int_0 : Integer;
            variable in_7_v_l_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            v_l_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                v_l_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to v_l)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_v_l_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_7_v_l_tpl_int_0);
                    in_7_v_l_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_7_v_l_tpl_int_0, 1));
                    v_l_stm <= in_7_v_l_tpl_temp;
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

        -- Generating stimulus for w_l
        w_l_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_8_w_l_tpl_int_0 : Integer;
            variable in_8_w_l_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            w_l_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                w_l_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to w_l)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_w_l_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
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
                    read(L, in_8_w_l_tpl_int_0);
                    in_8_w_l_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_8_w_l_tpl_int_0, 1));
                    w_l_stm <= in_8_w_l_tpl_temp;
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

        -- Generating stimulus for powerdown_p
        powerdown_p_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_18_Powerdown_p_tpl_int_0 : Integer;
            variable in_18_Powerdown_p_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            powerdown_p_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                powerdown_p_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to powerdown_p)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_powerdown_p_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
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
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_18_Powerdown_p_tpl_int_0);
                    in_18_Powerdown_p_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_18_Powerdown_p_tpl_int_0, 1));
                    powerdown_p_stm <= in_18_Powerdown_p_tpl_temp;
                    read(L, dummy_int);

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for powerdown_n
        powerdown_n_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_19_Powerdown_n_tpl_int_0 : Integer;
            variable in_19_Powerdown_n_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            powerdown_n_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                powerdown_n_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to powerdown_n)
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_powerdown_n_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
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
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, in_19_Powerdown_n_tpl_int_0);
                    in_19_Powerdown_n_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_19_Powerdown_n_tpl_int_0, 1));
                    powerdown_n_stm <= in_19_Powerdown_n_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ia_sd
        ia_sd_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            ia_sd_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to ia_sd)
                IF (endfile(data_file_GPOut)) THEN
                    clk_ia_sd_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    ia_sd_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ib_sd
        ib_sd_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse1_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            ib_sd_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to ib_sd)
                IF (endfile(data_file_GPOut)) THEN
                    clk_ib_sd_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    ib_sd_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ic_sd
        ic_sd_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse2_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            ic_sd_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to ic_sd)
                IF (endfile(data_file_GPOut)) THEN
                    clk_ic_sd_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    ic_sd_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Va_sd
        Va_sd_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            Va_sd_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Va_sd)
                IF (endfile(data_file_GPOut)) THEN
                    clk_Va_sd_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    Va_sd_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vb_sd
        Vb_sd_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse4_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            Vb_sd_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Vb_sd)
                IF (endfile(data_file_GPOut)) THEN
                    clk_Vb_sd_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    Vb_sd_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vc_sd
        Vc_sd_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse5_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            Vc_sd_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Vc_sd)
                IF (endfile(data_file_GPOut)) THEN
                    clk_Vc_sd_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    Vc_sd_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for QEP_A
        QEP_A_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelOut.stm");
            variable out_15_QEP_A_tpl_int_0 : Integer;
            variable out_15_QEP_A_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            QEP_A_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to QEP_A)
                IF (endfile(data_file_ChannelOut)) THEN
                    clk_QEP_A_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut, L);
                    
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
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, out_15_QEP_A_tpl_int_0);
                    out_15_QEP_A_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_15_QEP_A_tpl_int_0, 1));
                    QEP_A_stm <= out_15_QEP_A_tpl_temp;
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

        -- Generating stimulus for QEP_B
        QEP_B_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelOut.stm");
            variable out_16_QEP_B_tpl_int_0 : Integer;
            variable out_16_QEP_B_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            QEP_B_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to QEP_B)
                IF (endfile(data_file_ChannelOut)) THEN
                    clk_QEP_B_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut, L);
                    
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
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, out_16_QEP_B_tpl_int_0);
                    out_16_QEP_B_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_16_QEP_B_tpl_int_0, 1));
                    QEP_B_stm <= out_16_QEP_B_tpl_temp;
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

        -- Generating stimulus for Theta_one_turn_k
        Theta_one_turn_k_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelOut.stm");
            variable out_14_Theta_one_turn_k_tpl_int_0 : Integer;
            variable out_14_Theta_one_turn_k_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Theta_one_turn_k_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Theta_one_turn_k)
                IF (endfile(data_file_ChannelOut)) THEN
                    clk_Theta_one_turn_k_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut, L);
                    
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
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, dummy_int);
                    read(L, out_14_Theta_one_turn_k_tpl_int_0);
                    out_14_Theta_one_turn_k_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_14_Theta_one_turn_k_tpl_int_0, 16));
                    Theta_one_turn_k_stm <= out_14_Theta_one_turn_k_tpl_temp;
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

        -- Generating stimulus for V_DC_link_sd
        V_DC_link_sd_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse6_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            V_DC_link_sd_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to V_DC_link_sd)
                IF (endfile(data_file_GPOut)) THEN
                    clk_V_DC_link_sd_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    V_DC_link_sd_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_u_h_stm_sig_stop OR clk_v_h_stm_sig_stop OR clk_w_h_stm_sig_stop OR clk_u_l_stm_sig_stop OR clk_v_l_stm_sig_stop OR clk_w_l_stm_sig_stop OR clk_powerdown_p_stm_sig_stop OR clk_powerdown_n_stm_sig_stop OR clk_ia_sd_stm_sig_stop OR clk_ib_sd_stm_sig_stop OR clk_ic_sd_stm_sig_stop OR clk_Va_sd_stm_sig_stop OR clk_Vb_sd_stm_sig_stop OR clk_Vc_sd_stm_sig_stop OR clk_QEP_A_stm_sig_stop OR clk_QEP_B_stm_sig_stop OR clk_Theta_one_turn_k_stm_sig_stop OR clk_V_DC_link_sd_stm_sig_stop OR '0';


    END normal;
