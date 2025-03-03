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

-- VHDL created from standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters
-- VHDL created on Wed Aug  7 11:03:58 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;

entity standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        busOut_waitrequest_stm : out std_logic_vector(0 downto 0);
        MM_valid_out_stm : out std_logic_vector(0 downto 0);
        ia_A_stm : out std_logic_vector(15 downto 0);
        ib_A_stm : out std_logic_vector(15 downto 0);
        ic_A_stm : out std_logic_vector(15 downto 0);
        dTheta_dt_rad_s_stm : out std_logic_vector(15 downto 0);
        ThetaMech_one_turn_stm : out std_logic_vector(15 downto 0);
        ready_stm : out std_logic_vector(0 downto 0);
        MM_valid_in_stm : out std_logic_vector(0 downto 0);
        Vabc_range_V_cfg_stm : out std_logic_vector(15 downto 0);
        Va_V_stm : out std_logic_vector(15 downto 0);
        Vb_V_stm : out std_logic_vector(15 downto 0);
        Vc_V_stm : out std_logic_vector(15 downto 0);
        SampleTime_s_cfg_stm : out std_logic_vector(15 downto 0);
        Rphase_ohm_cfg_stm : out std_logic_vector(15 downto 0);
        inv_Lphase_1_H_cfg_stm : out std_logic_vector(15 downto 0);
        PolePairs_int_cfg_stm : out std_logic_vector(15 downto 0);
        Ke_Vs_rad_cfg_stm : out std_logic_vector(15 downto 0);
        Kt_Nm_A_cfg_stm : out std_logic_vector(15 downto 0);
        inv_J_1_kgm2_cfg_stm : out std_logic_vector(15 downto 0);
        LoadT_Nm_stm : out std_logic_vector(15 downto 0);
        DC_link_range_V_cfg_stm : out std_logic_vector(15 downto 0);
        DC_link_V_stm : out std_logic_vector(15 downto 0);
        Iabc_range_cfg_stm : out std_logic_vector(15 downto 0);
        clk : out std_logic;
        areset : out std_logic;
        h_areset : out std_logic
    );
end standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_stm;

architecture normal of standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal h_areset_stm_sig : std_logic := '1';
    signal clk_busIn_stm_sig_stop : std_logic := '0';
    signal clk_MM_valid_out_stm_sig_stop : std_logic := '0';
    signal clk_ia_A_stm_sig_stop : std_logic := '0';
    signal clk_ib_A_stm_sig_stop : std_logic := '0';
    signal clk_ic_A_stm_sig_stop : std_logic := '0';
    signal clk_dTheta_dt_rad_s_stm_sig_stop : std_logic := '0';
    signal clk_ThetaMech_one_turn_stm_sig_stop : std_logic := '0';
    signal clk_ready_stm_sig_stop : std_logic := '0';
    signal clk_MM_valid_in_stm_sig_stop : std_logic := '0';
    signal clk_Vabc_range_V_cfg_stm_sig_stop : std_logic := '0';
    signal clk_Va_V_stm_sig_stop : std_logic := '0';
    signal clk_Vb_V_stm_sig_stop : std_logic := '0';
    signal clk_Vc_V_stm_sig_stop : std_logic := '0';
    signal clk_SampleTime_s_cfg_stm_sig_stop : std_logic := '0';
    signal clk_Rphase_ohm_cfg_stm_sig_stop : std_logic := '0';
    signal clk_inv_Lphase_1_H_cfg_stm_sig_stop : std_logic := '0';
    signal clk_PolePairs_int_cfg_stm_sig_stop : std_logic := '0';
    signal clk_Ke_Vs_rad_cfg_stm_sig_stop : std_logic := '0';
    signal clk_Kt_Nm_A_cfg_stm_sig_stop : std_logic := '0';
    signal clk_inv_J_1_kgm2_cfg_stm_sig_stop : std_logic := '0';
    signal clk_LoadT_Nm_stm_sig_stop : std_logic := '0';
    signal clk_DC_link_range_V_cfg_stm_sig_stop : std_logic := '0';
    signal clk_DC_link_V_stm_sig_stop : std_logic := '0';
    signal clk_Iabc_range_cfg_stm_sig_stop : std_logic := '0';

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
            wait;
        end if;
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 24800 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
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

        -- Generating stub busOut - no stimulus
        -- initialize all outputs to 0
        busOut_readdatavalid_stm <= (others => '0');
        busOut_readdata_stm <= (others => '0');
        busOut_waitrequest_stm <= (others => '0');

        -- Generating stimulus for MM_valid_out
        MM_valid_out_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPIn.stm");
            variable in_1_MM_valid_out_tpl_int_0 : Integer;
            variable in_1_MM_valid_out_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            MM_valid_out_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                MM_valid_out_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to MM_valid_out)
                IF (endfile(data_file_GPIn)) THEN
                    clk_MM_valid_out_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn, L);
                    
                    read(L, in_1_MM_valid_out_tpl_int_0);
                    in_1_MM_valid_out_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_1_MM_valid_out_tpl_int_0, 1));
                    MM_valid_out_stm <= in_1_MM_valid_out_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ia_A
        ia_A_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn1 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPIn1.stm");
            variable in_2_ia_A_tpl_int_0 : Integer;
            variable in_2_ia_A_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            ia_A_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                ia_A_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to ia_A)
                IF (endfile(data_file_GPIn1)) THEN
                    clk_ia_A_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn1, L);
                    
                    read(L, in_2_ia_A_tpl_int_0);
                    in_2_ia_A_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_2_ia_A_tpl_int_0, 16));
                    ia_A_stm <= in_2_ia_A_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ib_A
        ib_A_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn2 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPIn2.stm");
            variable in_3_ib_A_tpl_int_0 : Integer;
            variable in_3_ib_A_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            ib_A_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                ib_A_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to ib_A)
                IF (endfile(data_file_GPIn2)) THEN
                    clk_ib_A_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn2, L);
                    
                    read(L, in_3_ib_A_tpl_int_0);
                    in_3_ib_A_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_3_ib_A_tpl_int_0, 16));
                    ib_A_stm <= in_3_ib_A_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ic_A
        ic_A_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn3 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPIn3.stm");
            variable in_4_ic_A_tpl_int_0 : Integer;
            variable in_4_ic_A_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            ic_A_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                ic_A_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to ic_A)
                IF (endfile(data_file_GPIn3)) THEN
                    clk_ic_A_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn3, L);
                    
                    read(L, in_4_ic_A_tpl_int_0);
                    in_4_ic_A_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_4_ic_A_tpl_int_0, 16));
                    ic_A_stm <= in_4_ic_A_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for dTheta_dt_rad_s
        dTheta_dt_rad_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn4 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPIn4.stm");
            variable in_5_dTheta_dt_rad_s_tpl_int_0 : Integer;
            variable in_5_dTheta_dt_rad_s_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            dTheta_dt_rad_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                dTheta_dt_rad_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to dTheta_dt_rad_s)
                IF (endfile(data_file_GPIn4)) THEN
                    clk_dTheta_dt_rad_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn4, L);
                    
                    read(L, in_5_dTheta_dt_rad_s_tpl_int_0);
                    in_5_dTheta_dt_rad_s_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_5_dTheta_dt_rad_s_tpl_int_0, 16));
                    dTheta_dt_rad_s_stm <= in_5_dTheta_dt_rad_s_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ThetaMech_one_turn
        ThetaMech_one_turn_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn5 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPIn5.stm");
            variable in_6_ThetaMech_one_turn_tpl_int_0 : Integer;
            variable in_6_ThetaMech_one_turn_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            ThetaMech_one_turn_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                ThetaMech_one_turn_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to ThetaMech_one_turn)
                IF (endfile(data_file_GPIn5)) THEN
                    clk_ThetaMech_one_turn_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn5, L);
                    
                    read(L, in_6_ThetaMech_one_turn_tpl_int_0);
                    in_6_ThetaMech_one_turn_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_6_ThetaMech_one_turn_tpl_int_0, 16));
                    ThetaMech_one_turn_stm <= in_6_ThetaMech_one_turn_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ready
        ready_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn6 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPIn6.stm");
            variable in_7_ready_tpl_int_0 : Integer;
            variable in_7_ready_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            ready_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                ready_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to ready)
                IF (endfile(data_file_GPIn6)) THEN
                    clk_ready_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn6, L);
                    
                    read(L, in_7_ready_tpl_int_0);
                    in_7_ready_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_7_ready_tpl_int_0, 1));
                    ready_stm <= in_7_ready_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for MM_valid_in
        MM_valid_in_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut.stm");
            variable out_1_MM_valid_in_tpl_int_0 : Integer;
            variable out_1_MM_valid_in_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            MM_valid_in_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to MM_valid_in)
                IF (endfile(data_file_GPOut)) THEN
                    clk_MM_valid_in_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_MM_valid_in_tpl_int_0);
                    out_1_MM_valid_in_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_MM_valid_in_tpl_int_0, 1));
                    MM_valid_in_stm <= out_1_MM_valid_in_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vabc_range_V_cfg
        Vabc_range_V_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut13 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut13.stm");
            variable out_2_Vabc_range_V_cfg_tpl_int_0 : Integer;
            variable out_2_Vabc_range_V_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Vabc_range_V_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Vabc_range_V_cfg)
                IF (endfile(data_file_GPOut13)) THEN
                    clk_Vabc_range_V_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut13, L);
                    
                    read(L, out_2_Vabc_range_V_cfg_tpl_int_0);
                    out_2_Vabc_range_V_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_2_Vabc_range_V_cfg_tpl_int_0, 16));
                    Vabc_range_V_cfg_stm <= out_2_Vabc_range_V_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Va_V
        Va_V_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut8 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut8.stm");
            variable out_3_Va_V_tpl_int_0 : Integer;
            variable out_3_Va_V_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Va_V_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Va_V)
                IF (endfile(data_file_GPOut8)) THEN
                    clk_Va_V_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut8, L);
                    
                    read(L, out_3_Va_V_tpl_int_0);
                    out_3_Va_V_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_3_Va_V_tpl_int_0, 16));
                    Va_V_stm <= out_3_Va_V_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vb_V
        Vb_V_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut9 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut9.stm");
            variable out_4_Vb_V_tpl_int_0 : Integer;
            variable out_4_Vb_V_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Vb_V_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Vb_V)
                IF (endfile(data_file_GPOut9)) THEN
                    clk_Vb_V_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut9, L);
                    
                    read(L, out_4_Vb_V_tpl_int_0);
                    out_4_Vb_V_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_4_Vb_V_tpl_int_0, 16));
                    Vb_V_stm <= out_4_Vb_V_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vc_V
        Vc_V_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut10 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut10.stm");
            variable out_5_Vc_V_tpl_int_0 : Integer;
            variable out_5_Vc_V_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Vc_V_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Vc_V)
                IF (endfile(data_file_GPOut10)) THEN
                    clk_Vc_V_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut10, L);
                    
                    read(L, out_5_Vc_V_tpl_int_0);
                    out_5_Vc_V_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_5_Vc_V_tpl_int_0, 16));
                    Vc_V_stm <= out_5_Vc_V_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for SampleTime_s_cfg
        SampleTime_s_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut1 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut1.stm");
            variable out_6_SampleTime_s_cfg_tpl_int_0 : Integer;
            variable out_6_SampleTime_s_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            SampleTime_s_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to SampleTime_s_cfg)
                IF (endfile(data_file_GPOut1)) THEN
                    clk_SampleTime_s_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut1, L);
                    
                    read(L, out_6_SampleTime_s_cfg_tpl_int_0);
                    out_6_SampleTime_s_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_6_SampleTime_s_cfg_tpl_int_0, 16));
                    SampleTime_s_cfg_stm <= out_6_SampleTime_s_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Rphase_ohm_cfg
        Rphase_ohm_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut2 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut2.stm");
            variable out_7_Rphase_ohm_cfg_tpl_int_0 : Integer;
            variable out_7_Rphase_ohm_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Rphase_ohm_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Rphase_ohm_cfg)
                IF (endfile(data_file_GPOut2)) THEN
                    clk_Rphase_ohm_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut2, L);
                    
                    read(L, out_7_Rphase_ohm_cfg_tpl_int_0);
                    out_7_Rphase_ohm_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_7_Rphase_ohm_cfg_tpl_int_0, 16));
                    Rphase_ohm_cfg_stm <= out_7_Rphase_ohm_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for inv_Lphase_1_H_cfg
        inv_Lphase_1_H_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut3 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut3.stm");
            variable out_8_inv_Lphase_1_H_cfg_tpl_int_0 : Integer;
            variable out_8_inv_Lphase_1_H_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            inv_Lphase_1_H_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to inv_Lphase_1_H_cfg)
                IF (endfile(data_file_GPOut3)) THEN
                    clk_inv_Lphase_1_H_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut3, L);
                    
                    read(L, out_8_inv_Lphase_1_H_cfg_tpl_int_0);
                    out_8_inv_Lphase_1_H_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_8_inv_Lphase_1_H_cfg_tpl_int_0, 16));
                    inv_Lphase_1_H_cfg_stm <= out_8_inv_Lphase_1_H_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for PolePairs_int_cfg
        PolePairs_int_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut4 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut4.stm");
            variable out_9_PolePairs_int_cfg_tpl_int_0 : Integer;
            variable out_9_PolePairs_int_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            PolePairs_int_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to PolePairs_int_cfg)
                IF (endfile(data_file_GPOut4)) THEN
                    clk_PolePairs_int_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut4, L);
                    
                    read(L, out_9_PolePairs_int_cfg_tpl_int_0);
                    out_9_PolePairs_int_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_9_PolePairs_int_cfg_tpl_int_0, 16));
                    PolePairs_int_cfg_stm <= out_9_PolePairs_int_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Ke_Vs_rad_cfg
        Ke_Vs_rad_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut5 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut5.stm");
            variable out_10_Ke_Vs_rad_cfg_tpl_int_0 : Integer;
            variable out_10_Ke_Vs_rad_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Ke_Vs_rad_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Ke_Vs_rad_cfg)
                IF (endfile(data_file_GPOut5)) THEN
                    clk_Ke_Vs_rad_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut5, L);
                    
                    read(L, out_10_Ke_Vs_rad_cfg_tpl_int_0);
                    out_10_Ke_Vs_rad_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_10_Ke_Vs_rad_cfg_tpl_int_0, 16));
                    Ke_Vs_rad_cfg_stm <= out_10_Ke_Vs_rad_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Kt_Nm_A_cfg
        Kt_Nm_A_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut6 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut6.stm");
            variable out_11_Kt_Nm_A_cfg_tpl_int_0 : Integer;
            variable out_11_Kt_Nm_A_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Kt_Nm_A_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Kt_Nm_A_cfg)
                IF (endfile(data_file_GPOut6)) THEN
                    clk_Kt_Nm_A_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut6, L);
                    
                    read(L, out_11_Kt_Nm_A_cfg_tpl_int_0);
                    out_11_Kt_Nm_A_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_Kt_Nm_A_cfg_tpl_int_0, 16));
                    Kt_Nm_A_cfg_stm <= out_11_Kt_Nm_A_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for inv_J_1_kgm2_cfg
        inv_J_1_kgm2_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut7 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut7.stm");
            variable out_12_inv_J_1_kgm2_cfg_tpl_int_0 : Integer;
            variable out_12_inv_J_1_kgm2_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            inv_J_1_kgm2_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to inv_J_1_kgm2_cfg)
                IF (endfile(data_file_GPOut7)) THEN
                    clk_inv_J_1_kgm2_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut7, L);
                    
                    read(L, out_12_inv_J_1_kgm2_cfg_tpl_int_0);
                    out_12_inv_J_1_kgm2_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_12_inv_J_1_kgm2_cfg_tpl_int_0, 16));
                    inv_J_1_kgm2_cfg_stm <= out_12_inv_J_1_kgm2_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for LoadT_Nm
        LoadT_Nm_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut11 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut11.stm");
            variable out_13_LoadT_Nm_tpl_int_0 : Integer;
            variable out_13_LoadT_Nm_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            LoadT_Nm_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to LoadT_Nm)
                IF (endfile(data_file_GPOut11)) THEN
                    clk_LoadT_Nm_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut11, L);
                    
                    read(L, out_13_LoadT_Nm_tpl_int_0);
                    out_13_LoadT_Nm_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_13_LoadT_Nm_tpl_int_0, 16));
                    LoadT_Nm_stm <= out_13_LoadT_Nm_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for DC_link_range_V_cfg
        DC_link_range_V_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut14 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut14.stm");
            variable out_14_DC_link_range_V_cfg_tpl_int_0 : Integer;
            variable out_14_DC_link_range_V_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            DC_link_range_V_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to DC_link_range_V_cfg)
                IF (endfile(data_file_GPOut14)) THEN
                    clk_DC_link_range_V_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut14, L);
                    
                    read(L, out_14_DC_link_range_V_cfg_tpl_int_0);
                    out_14_DC_link_range_V_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_14_DC_link_range_V_cfg_tpl_int_0, 16));
                    DC_link_range_V_cfg_stm <= out_14_DC_link_range_V_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for DC_link_V
        DC_link_V_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut12 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut12.stm");
            variable out_15_DC_link_V_tpl_int_0 : Integer;
            variable out_15_DC_link_V_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            DC_link_V_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to DC_link_V)
                IF (endfile(data_file_GPOut12)) THEN
                    clk_DC_link_V_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut12, L);
                    
                    read(L, out_15_DC_link_V_tpl_int_0);
                    out_15_DC_link_V_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_15_DC_link_V_tpl_int_0, 16));
                    DC_link_V_stm <= out_15_DC_link_V_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Iabc_range_cfg
        Iabc_range_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut15 : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_AvalonRegisters_GPOut15.stm");
            variable out_16_Iabc_range_cfg_tpl_int_0 : Integer;
            variable out_16_Iabc_range_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Iabc_range_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Iabc_range_cfg)
                IF (endfile(data_file_GPOut15)) THEN
                    clk_Iabc_range_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut15, L);
                    
                    read(L, out_16_Iabc_range_cfg_tpl_int_0);
                    out_16_Iabc_range_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_16_Iabc_range_cfg_tpl_int_0, 16));
                    Iabc_range_cfg_stm <= out_16_Iabc_range_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_MM_valid_out_stm_sig_stop OR clk_ia_A_stm_sig_stop OR clk_ib_A_stm_sig_stop OR clk_ic_A_stm_sig_stop OR clk_dTheta_dt_rad_s_stm_sig_stop OR clk_ThetaMech_one_turn_stm_sig_stop OR clk_ready_stm_sig_stop OR clk_MM_valid_in_stm_sig_stop OR clk_Vabc_range_V_cfg_stm_sig_stop OR clk_Va_V_stm_sig_stop OR clk_Vb_V_stm_sig_stop OR clk_Vc_V_stm_sig_stop OR clk_SampleTime_s_cfg_stm_sig_stop OR clk_Rphase_ohm_cfg_stm_sig_stop OR clk_inv_Lphase_1_H_cfg_stm_sig_stop OR clk_PolePairs_int_cfg_stm_sig_stop OR clk_Ke_Vs_rad_cfg_stm_sig_stop OR clk_Kt_Nm_A_cfg_stm_sig_stop OR clk_inv_J_1_kgm2_cfg_stm_sig_stop OR clk_LoadT_Nm_stm_sig_stop OR clk_DC_link_range_V_cfg_stm_sig_stop OR clk_DC_link_V_stm_sig_stop OR clk_Iabc_range_cfg_stm_sig_stop OR '0';


    END normal;
