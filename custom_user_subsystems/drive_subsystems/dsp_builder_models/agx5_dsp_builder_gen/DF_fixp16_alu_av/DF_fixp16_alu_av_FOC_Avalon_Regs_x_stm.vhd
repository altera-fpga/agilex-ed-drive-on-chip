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

-- VHDL created from standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x
-- VHDL created on Wed Aug  7 11:08:24 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.DF_fixp16_alu_av_FOC_safe_path.all;

entity standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_stm is
    port (
        busIn_writedata_stm : out std_logic_vector(31 downto 0);
        busIn_address_stm : out std_logic_vector(5 downto 0);
        busIn_write_stm : out std_logic_vector(0 downto 0);
        busIn_read_stm : out std_logic_vector(0 downto 0);
        busOut_readdatavalid_stm : out std_logic_vector(0 downto 0);
        busOut_readdata_stm : out std_logic_vector(31 downto 0);
        busOut_waitrequest_stm : out std_logic_vector(0 downto 0);
        qv_s_stm : out std_logic_vector(0 downto 0);
        Valpha_s_stm : out std_logic_vector(31 downto 0);
        Vbeta_s_stm : out std_logic_vector(31 downto 0);
        Iq_s_stm : out std_logic_vector(15 downto 0);
        Id_s_stm : out std_logic_vector(15 downto 0);
        Ready_s_stm : out std_logic_vector(0 downto 0);
        Vuvwin_0_stm : out std_logic_vector(15 downto 0);
        Vuvwin_1_stm : out std_logic_vector(15 downto 0);
        Vuvwin_2_stm : out std_logic_vector(15 downto 0);
        AxisOut_s_stm : out std_logic_vector(7 downto 0);
        dv_stm : out std_logic_vector(0 downto 0);
        axisin_stm : out std_logic_vector(7 downto 0);
        Iu_stm : out std_logic_vector(15 downto 0);
        Iw_stm : out std_logic_vector(15 downto 0);
        Torque_stm : out std_logic_vector(15 downto 0);
        phi_el_stm : out std_logic_vector(15 downto 0);
        Kp_cfg_stm : out std_logic_vector(15 downto 0);
        Ki_cfg_stm : out std_logic_vector(15 downto 0);
        I_Sat_Limit_cfg_stm : out std_logic_vector(15 downto 0);
        MaxV_stm : out std_logic_vector(15 downto 0);
        reset_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic;
        h_areset : out std_logic
    );
end standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_stm;

architecture normal of standaloneTopLevel_DF_fixp16_alu_av_FOC_Avalon_Regs_x_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal h_areset_stm_sig : std_logic := '1';
    signal clk_qv_s_stm_sig_stop : std_logic := '0';
    signal clk_Valpha_s_stm_sig_stop : std_logic := '0';
    signal clk_Vbeta_s_stm_sig_stop : std_logic := '0';
    signal clk_Iq_s_stm_sig_stop : std_logic := '0';
    signal clk_Id_s_stm_sig_stop : std_logic := '0';
    signal clk_Ready_s_stm_sig_stop : std_logic := '0';
    signal clk_Vuvwin_0_stm_sig_stop : std_logic := '0';
    signal clk_Vuvwin_1_stm_sig_stop : std_logic := '0';
    signal clk_Vuvwin_2_stm_sig_stop : std_logic := '0';
    signal clk_AxisOut_s_stm_sig_stop : std_logic := '0';
    signal clk_dv_stm_sig_stop : std_logic := '0';
    signal clk_axisin_stm_sig_stop : std_logic := '0';
    signal clk_Iu_stm_sig_stop : std_logic := '0';
    signal clk_Iw_stm_sig_stop : std_logic := '0';
    signal clk_Torque_stm_sig_stop : std_logic := '0';
    signal clk_phi_el_stm_sig_stop : std_logic := '0';
    signal clk_Kp_cfg_stm_sig_stop : std_logic := '0';
    signal clk_Ki_cfg_stm_sig_stop : std_logic := '0';
    signal clk_I_Sat_Limit_cfg_stm_sig_stop : std_logic := '0';
    signal clk_MaxV_stm_sig_stop : std_logic := '0';
    signal clk_reset_stm_sig_stop : std_logic := '0';

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
            wait;
        end if;
        wait for 200 ps;
        clk_stm_sig <= not clk_stm_sig;
        wait for 4800 ps;
        if (clk_stm_sig_stop = '1') then
            assert (false)
            report "Arrived at end of stimulus data on clk clk" severity NOTE;
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

        -- Generating stimulus for qv_s
        qv_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn3 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn3.stm");
            variable in_1_qv_tpl_int_0 : Integer;
            variable in_1_qv_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            qv_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                qv_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to qv_s)
                IF (endfile(data_file_GPIn3)) THEN
                    clk_qv_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn3, L);
                    
                    read(L, in_1_qv_tpl_int_0);
                    in_1_qv_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_1_qv_tpl_int_0, 1));
                    qv_s_stm <= in_1_qv_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Valpha_s
        Valpha_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn.stm");
            variable in_2_Valpha_tpl_int_0 : Integer;
            variable in_2_Valpha_tpl_temp : std_logic_vector(31 downto 0);

        begin
            -- initialize all outputs to 0
            Valpha_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Valpha_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Valpha_s)
                IF (endfile(data_file_GPIn)) THEN
                    clk_Valpha_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn, L);
                    
                    read(L, in_2_Valpha_tpl_int_0);
                    in_2_Valpha_tpl_temp(31 downto 0) := std_logic_vector(to_signed(in_2_Valpha_tpl_int_0, 32));
                    Valpha_s_stm <= in_2_Valpha_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vbeta_s
        Vbeta_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn1 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn1.stm");
            variable in_3_Vbeta_tpl_int_0 : Integer;
            variable in_3_Vbeta_tpl_temp : std_logic_vector(31 downto 0);

        begin
            -- initialize all outputs to 0
            Vbeta_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Vbeta_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Vbeta_s)
                IF (endfile(data_file_GPIn1)) THEN
                    clk_Vbeta_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn1, L);
                    
                    read(L, in_3_Vbeta_tpl_int_0);
                    in_3_Vbeta_tpl_temp(31 downto 0) := std_logic_vector(to_signed(in_3_Vbeta_tpl_int_0, 32));
                    Vbeta_s_stm <= in_3_Vbeta_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Iq_s
        Iq_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn8 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn8.stm");
            variable in_4_Iq_tpl_int_0 : Integer;
            variable in_4_Iq_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Iq_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Iq_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Iq_s)
                IF (endfile(data_file_GPIn8)) THEN
                    clk_Iq_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn8, L);
                    
                    read(L, in_4_Iq_tpl_int_0);
                    in_4_Iq_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_4_Iq_tpl_int_0, 16));
                    Iq_s_stm <= in_4_Iq_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Id_s
        Id_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn9 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn9.stm");
            variable in_5_Id_tpl_int_0 : Integer;
            variable in_5_Id_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Id_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Id_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Id_s)
                IF (endfile(data_file_GPIn9)) THEN
                    clk_Id_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn9, L);
                    
                    read(L, in_5_Id_tpl_int_0);
                    in_5_Id_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_5_Id_tpl_int_0, 16));
                    Id_s_stm <= in_5_Id_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Ready_s
        Ready_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn2 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn2.stm");
            variable in_6_Ready_tpl_int_0 : Integer;
            variable in_6_Ready_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            Ready_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Ready_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Ready_s)
                IF (endfile(data_file_GPIn2)) THEN
                    clk_Ready_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn2, L);
                    
                    read(L, in_6_Ready_tpl_int_0);
                    in_6_Ready_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_6_Ready_tpl_int_0, 1));
                    Ready_s_stm <= in_6_Ready_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vuvwin_0
        Vuvwin_0_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn4 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn4.stm");
            variable in_7_0_Vuvwin_tpl_int_0 : Integer;
            variable in_7_0_Vuvwin_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Vuvwin_0_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Vuvwin_0_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Vuvwin_0)
                IF (endfile(data_file_GPIn4)) THEN
                    clk_Vuvwin_0_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn4, L);
                    
                    read(L, in_7_0_Vuvwin_tpl_int_0);
                    in_7_0_Vuvwin_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_7_0_Vuvwin_tpl_int_0, 16));
                    Vuvwin_0_stm <= in_7_0_Vuvwin_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vuvwin_1
        Vuvwin_1_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn5 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn5.stm");
            variable in_7_1_Vuvwin_tpl_int_0 : Integer;
            variable in_7_1_Vuvwin_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Vuvwin_1_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Vuvwin_1_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Vuvwin_1)
                IF (endfile(data_file_GPIn5)) THEN
                    clk_Vuvwin_1_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn5, L);
                    
                    read(L, in_7_1_Vuvwin_tpl_int_0);
                    in_7_1_Vuvwin_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_7_1_Vuvwin_tpl_int_0, 16));
                    Vuvwin_1_stm <= in_7_1_Vuvwin_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Vuvwin_2
        Vuvwin_2_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn6 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn6.stm");
            variable in_7_2_Vuvwin_tpl_int_0 : Integer;
            variable in_7_2_Vuvwin_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Vuvwin_2_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                Vuvwin_2_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to Vuvwin_2)
                IF (endfile(data_file_GPIn6)) THEN
                    clk_Vuvwin_2_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn6, L);
                    
                    read(L, in_7_2_Vuvwin_tpl_int_0);
                    in_7_2_Vuvwin_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_7_2_Vuvwin_tpl_int_0, 16));
                    Vuvwin_2_stm <= in_7_2_Vuvwin_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for AxisOut_s
        AxisOut_s_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn7 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPIn7.stm");
            variable in_8_AxisOut_tpl_int_0 : Integer;
            variable in_8_AxisOut_tpl_temp : std_logic_vector(7 downto 0);

        begin
            -- initialize all outputs to 0
            AxisOut_s_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                AxisOut_s_stm <= (others => '0');
            end loop;
            while true loop
            
                -- (ports connected to AxisOut_s)
                IF (endfile(data_file_GPIn7)) THEN
                    clk_AxisOut_s_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn7, L);
                    
                    read(L, in_8_AxisOut_tpl_int_0);
                    in_8_AxisOut_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(in_8_AxisOut_tpl_int_0, 8));
                    AxisOut_s_stm <= in_8_AxisOut_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for dv
        dv_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut11 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut11.stm");
            variable out_1_dv_tpl_int_0 : Integer;
            variable out_1_dv_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            dv_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to dv)
                IF (endfile(data_file_GPOut11)) THEN
                    clk_dv_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut11, L);
                    
                    read(L, out_1_dv_tpl_int_0);
                    out_1_dv_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_dv_tpl_int_0, 1));
                    dv_stm <= out_1_dv_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for axisin
        axisin_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut2 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut2.stm");
            variable out_2_axisin_tpl_int_0 : Integer;
            variable out_2_axisin_tpl_temp : std_logic_vector(7 downto 0);

        begin
            -- initialize all outputs to 0
            axisin_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to axisin)
                IF (endfile(data_file_GPOut2)) THEN
                    clk_axisin_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut2, L);
                    
                    read(L, out_2_axisin_tpl_int_0);
                    out_2_axisin_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(out_2_axisin_tpl_int_0, 8));
                    axisin_stm <= out_2_axisin_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Iu
        Iu_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut3 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut3.stm");
            variable out_3_Iu_tpl_int_0 : Integer;
            variable out_3_Iu_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Iu_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Iu)
                IF (endfile(data_file_GPOut3)) THEN
                    clk_Iu_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut3, L);
                    
                    read(L, out_3_Iu_tpl_int_0);
                    out_3_Iu_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_3_Iu_tpl_int_0, 16));
                    Iu_stm <= out_3_Iu_tpl_temp;

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
            file data_file_GPOut4 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut4.stm");
            variable out_4_Iw_tpl_int_0 : Integer;
            variable out_4_Iw_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Iw_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Iw)
                IF (endfile(data_file_GPOut4)) THEN
                    clk_Iw_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut4, L);
                    
                    read(L, out_4_Iw_tpl_int_0);
                    out_4_Iw_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_4_Iw_tpl_int_0, 16));
                    Iw_stm <= out_4_Iw_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Torque
        Torque_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut5 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut5.stm");
            variable out_5_Torque_tpl_int_0 : Integer;
            variable out_5_Torque_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Torque_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Torque)
                IF (endfile(data_file_GPOut5)) THEN
                    clk_Torque_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut5, L);
                    
                    read(L, out_5_Torque_tpl_int_0);
                    out_5_Torque_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_5_Torque_tpl_int_0, 16));
                    Torque_stm <= out_5_Torque_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for phi_el
        phi_el_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut6 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut6.stm");
            variable out_6_phi_el_tpl_int_0 : Integer;
            variable out_6_phi_el_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            phi_el_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to phi_el)
                IF (endfile(data_file_GPOut6)) THEN
                    clk_phi_el_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut6, L);
                    
                    read(L, out_6_phi_el_tpl_int_0);
                    out_6_phi_el_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_6_phi_el_tpl_int_0, 16));
                    phi_el_stm <= out_6_phi_el_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Kp_cfg
        Kp_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut7 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut7.stm");
            variable out_7_Kp_cfg_tpl_int_0 : Integer;
            variable out_7_Kp_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Kp_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Kp_cfg)
                IF (endfile(data_file_GPOut7)) THEN
                    clk_Kp_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut7, L);
                    
                    read(L, out_7_Kp_cfg_tpl_int_0);
                    out_7_Kp_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_7_Kp_cfg_tpl_int_0, 16));
                    Kp_cfg_stm <= out_7_Kp_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for Ki_cfg
        Ki_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut8 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut8.stm");
            variable out_8_Ki_cfg_tpl_int_0 : Integer;
            variable out_8_Ki_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            Ki_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to Ki_cfg)
                IF (endfile(data_file_GPOut8)) THEN
                    clk_Ki_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut8, L);
                    
                    read(L, out_8_Ki_cfg_tpl_int_0);
                    out_8_Ki_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_8_Ki_cfg_tpl_int_0, 16));
                    Ki_cfg_stm <= out_8_Ki_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for I_Sat_Limit_cfg
        I_Sat_Limit_cfg_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut1 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut1.stm");
            variable out_9_I_Sat_Limit_cfg_tpl_int_0 : Integer;
            variable out_9_I_Sat_Limit_cfg_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            I_Sat_Limit_cfg_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to I_Sat_Limit_cfg)
                IF (endfile(data_file_GPOut1)) THEN
                    clk_I_Sat_Limit_cfg_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut1, L);
                    
                    read(L, out_9_I_Sat_Limit_cfg_tpl_int_0);
                    out_9_I_Sat_Limit_cfg_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_9_I_Sat_Limit_cfg_tpl_int_0, 16));
                    I_Sat_Limit_cfg_stm <= out_9_I_Sat_Limit_cfg_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for MaxV
        MaxV_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut9 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut9.stm");
            variable out_10_MaxV_tpl_int_0 : Integer;
            variable out_10_MaxV_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            MaxV_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to MaxV)
                IF (endfile(data_file_GPOut9)) THEN
                    clk_MaxV_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut9, L);
                    
                    read(L, out_10_MaxV_tpl_int_0);
                    out_10_MaxV_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_10_MaxV_tpl_int_0, 16));
                    MaxV_stm <= out_10_MaxV_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for reset
        reset_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPOut10 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_Avalon_Regs_GPOut10.stm");
            variable out_11_reset_tpl_int_0 : Integer;
            variable out_11_reset_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            reset_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                -- (ports connected to reset)
                IF (endfile(data_file_GPOut10)) THEN
                    clk_reset_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPOut10, L);
                    
                    read(L, out_11_reset_tpl_int_0);
                    out_11_reset_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_11_reset_tpl_int_0, 1));
                    reset_stm <= out_11_reset_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_qv_s_stm_sig_stop OR clk_Valpha_s_stm_sig_stop OR clk_Vbeta_s_stm_sig_stop OR clk_Iq_s_stm_sig_stop OR clk_Id_s_stm_sig_stop OR clk_Ready_s_stm_sig_stop OR clk_Vuvwin_0_stm_sig_stop OR clk_Vuvwin_1_stm_sig_stop OR clk_Vuvwin_2_stm_sig_stop OR clk_AxisOut_s_stm_sig_stop OR clk_dv_stm_sig_stop OR clk_axisin_stm_sig_stop OR clk_Iu_stm_sig_stop OR clk_Iw_stm_sig_stop OR clk_Torque_stm_sig_stop OR clk_phi_el_stm_sig_stop OR clk_Kp_cfg_stm_sig_stop OR clk_Ki_cfg_stm_sig_stop OR clk_I_Sat_Limit_cfg_stm_sig_stop OR clk_MaxV_stm_sig_stop OR clk_reset_stm_sig_stop OR '0';


    END normal;
