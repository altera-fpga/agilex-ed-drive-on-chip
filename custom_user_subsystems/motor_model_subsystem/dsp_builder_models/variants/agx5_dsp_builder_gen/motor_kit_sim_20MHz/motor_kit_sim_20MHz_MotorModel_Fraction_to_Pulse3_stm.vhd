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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3
-- VHDL created on Fri Jun  6 03:42:57 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;

entity motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3_stm is
    port (
        in_1_Fraction_ND_ufix16_En16_tpl_stm : out std_logic_vector(15 downto 0);
        out_1_PulseDensity_Bool_x_tpl_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3_stm;

architecture normal of motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal clk_GPIn_stm_sig_stop : std_logic := '0';
    signal clk_GPOut_stm_sig_stop : std_logic := '0';

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


        -- Generating stimulus for GPIn
        GPIn_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3_GPIn.stm");
            variable in_1_Fraction_ND_ufix16_En16_tpl_int_0 : Integer;
            variable in_1_Fraction_ND_ufix16_En16_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            in_1_Fraction_ND_ufix16_En16_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                in_1_Fraction_ND_ufix16_En16_tpl_stm <= (others => '0');
            end loop;
            while true loop
            
                IF (endfile(data_file_GPIn)) THEN
                    clk_GPIn_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn, L);
                    
                    read(L, in_1_Fraction_ND_ufix16_En16_tpl_int_0);
                    in_1_Fraction_ND_ufix16_En16_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_1_Fraction_ND_ufix16_En16_tpl_int_0, 16));
                    in_1_Fraction_ND_ufix16_En16_tpl_stm <= in_1_Fraction_ND_ufix16_En16_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for GPOut
        GPOut_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_Fraction_to_Pulse3_GPOut.stm");
            variable out_1_PulseDensity_Bool_x_tpl_int_0 : Integer;
            variable out_1_PulseDensity_Bool_x_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            out_1_PulseDensity_Bool_x_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                IF (endfile(data_file_GPOut)) THEN
                    clk_GPOut_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut, L);
                    
                    read(L, out_1_PulseDensity_Bool_x_tpl_int_0);
                    out_1_PulseDensity_Bool_x_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_PulseDensity_Bool_x_tpl_int_0, 1));
                    out_1_PulseDensity_Bool_x_tpl_stm <= out_1_PulseDensity_Bool_x_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_GPIn_stm_sig_stop OR clk_GPOut_stm_sig_stop OR '0';


    END normal;
