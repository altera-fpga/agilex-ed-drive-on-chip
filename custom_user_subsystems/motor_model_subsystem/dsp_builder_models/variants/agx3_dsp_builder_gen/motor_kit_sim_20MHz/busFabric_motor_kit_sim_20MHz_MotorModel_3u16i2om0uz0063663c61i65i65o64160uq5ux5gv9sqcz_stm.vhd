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

-- VHDL created from busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz
-- VHDL created on Mon Aug 11 01:49:10 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;
use work.dspba_sim_library_package.all;

entity busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm : out std_logic_vector(15 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm : out std_logic_vector(0 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_stm : out std_logic_vector(0 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_stm : out std_logic_vector(15 downto 0);
        clk : out std_logic;
        areset : out std_logic;
        h_areset : out std_logic
    );
end busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_stm;

architecture normal of busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal clk_stm_sig_stopped : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal h_areset_stm_sig : std_logic := '1';
    signal clk_busIn_stm_sig_stop : std_logic := '0';

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
            file data_file_busIn : text open read_mode is safe_path("motor_kit_sim_20MHz/busFabric_motor_kit_sim_20MHz_MotorModel_3u16i2om0uz0063663c61i65i65o64160uq5ux5gv9sqcz_busIn.stm");
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
        -- Driving gnd for in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl signals

        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl signals

        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl signals

        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl signals

        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl signals

        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl signals

        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl signals

        in_AMMregisterPortData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl signals

        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Busy_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl signals

        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Ready_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl signals

        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ThetaMech_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl signals

        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_dTheta_dt_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl signals

        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ia_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl signals

        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ib_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl signals

        in_AMMregisterPortWriteEn_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_ic_Output_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_V_Input_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DC_link_range_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_DSPBA_Start_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Iabc_range_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Ke_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Kt_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_LoadT_Input_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_PolePairs_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Rphase_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Sample_Time_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Va_Input_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vabc_range_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vb_Input_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_Vc_Input_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_J_CFG_x_tpl_stm <= (others => '0');
        -- Driving gnd for out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl signals

        out_AMMregisterWireData_motor_kit_sim_20MHz_MotorModel_AvalonRegisters_inv_Lphase_CFG_x_tpl_stm <= (others => '0');

    clk_stm_sig_stop <= '1';


    END normal;
