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

-- VHDL created from DF_fixp16_alu_av_FOC_FL_fixp16
-- VHDL created on Fri Jun  6 03:50:16 2025


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.DF_fixp16_alu_av_FOC_safe_path.all;

entity DF_fixp16_alu_av_FOC_FL_fixp16_stm is
    port (
        in_1_dv_tpl_stm : out std_logic_vector(0 downto 0);
        in_2_dc_tpl_stm : out std_logic_vector(7 downto 0);
        in_3_valid_in_tpl_stm : out std_logic_vector(0 downto 0);
        in_4_axis_in_tpl_stm : out std_logic_vector(7 downto 0);
        in_5_Iu_tpl_stm : out std_logic_vector(15 downto 0);
        in_6_Iw_tpl_stm : out std_logic_vector(15 downto 0);
        in_7_Torque_tpl_stm : out std_logic_vector(15 downto 0);
        in_8_IntegralQ_in_tpl_stm : out std_logic_vector(15 downto 0);
        in_9_IntegralD_in_tpl_stm : out std_logic_vector(15 downto 0);
        in_10_phi_el_tpl_stm : out std_logic_vector(15 downto 0);
        in_11_Kp_tpl_stm : out std_logic_vector(15 downto 0);
        in_12_Ki_tpl_stm : out std_logic_vector(15 downto 0);
        in_13_I_Sat_Limit_tpl_stm : out std_logic_vector(15 downto 0);
        in_14_Max_tpl_stm : out std_logic_vector(15 downto 0);
        out_1_qv_tpl_stm : out std_logic_vector(0 downto 0);
        out_2_qc_tpl_stm : out std_logic_vector(7 downto 0);
        out_3_valid_out_tpl_stm : out std_logic_vector(0 downto 0);
        out_4_axis_out_tpl_stm : out std_logic_vector(7 downto 0);
        out_5_Valpha_tpl_stm : out std_logic_vector(31 downto 0);
        out_6_Vbeta_tpl_stm : out std_logic_vector(31 downto 0);
        out_7_IntegralD_out_tpl_stm : out std_logic_vector(15 downto 0);
        out_8_IntegralQ_out_tpl_stm : out std_logic_vector(15 downto 0);
        out_9_Iq_tpl_stm : out std_logic_vector(15 downto 0);
        out_10_Id_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_uvw_0_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_uvw_1_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_uvw_2_tpl_stm : out std_logic_vector(15 downto 0);
        out_12_ready_tpl_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end DF_fixp16_alu_av_FOC_FL_fixp16_stm;

architecture normal of DF_fixp16_alu_av_FOC_FL_fixp16_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal clk_ChannelIn2_stm_sig_stop : std_logic := '0';
    signal clk_ChannelOut1_vunroll_x_stm_sig_stop : std_logic := '0';

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


        -- Generating stimulus for ChannelIn2
        ChannelIn2_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn2 : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_ChannelIn2.stm");
            variable in_1_dv_tpl_int_0 : Integer;
            variable in_1_dv_tpl_temp : std_logic_vector(0 downto 0);
            variable in_2_dc_tpl_int_0 : Integer;
            variable in_2_dc_tpl_temp : std_logic_vector(7 downto 0);
            variable in_3_valid_in_tpl_int_0 : Integer;
            variable in_3_valid_in_tpl_temp : std_logic_vector(0 downto 0);
            variable in_4_axis_in_tpl_int_0 : Integer;
            variable in_4_axis_in_tpl_temp : std_logic_vector(7 downto 0);
            variable in_5_Iu_tpl_int_0 : Integer;
            variable in_5_Iu_tpl_temp : std_logic_vector(15 downto 0);
            variable in_6_Iw_tpl_int_0 : Integer;
            variable in_6_Iw_tpl_temp : std_logic_vector(15 downto 0);
            variable in_7_Torque_tpl_int_0 : Integer;
            variable in_7_Torque_tpl_temp : std_logic_vector(15 downto 0);
            variable in_8_IntegralQ_in_tpl_int_0 : Integer;
            variable in_8_IntegralQ_in_tpl_temp : std_logic_vector(15 downto 0);
            variable in_9_IntegralD_in_tpl_int_0 : Integer;
            variable in_9_IntegralD_in_tpl_temp : std_logic_vector(15 downto 0);
            variable in_10_phi_el_tpl_int_0 : Integer;
            variable in_10_phi_el_tpl_temp : std_logic_vector(15 downto 0);
            variable in_11_Kp_tpl_int_0 : Integer;
            variable in_11_Kp_tpl_temp : std_logic_vector(15 downto 0);
            variable in_12_Ki_tpl_int_0 : Integer;
            variable in_12_Ki_tpl_temp : std_logic_vector(15 downto 0);
            variable in_13_I_Sat_Limit_tpl_int_0 : Integer;
            variable in_13_I_Sat_Limit_tpl_temp : std_logic_vector(15 downto 0);
            variable in_14_Max_tpl_int_0 : Integer;
            variable in_14_Max_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            in_1_dv_tpl_stm <= (others => '0');
            in_2_dc_tpl_stm <= (others => '0');
            in_3_valid_in_tpl_stm <= (others => '0');
            in_4_axis_in_tpl_stm <= (others => '0');
            in_5_Iu_tpl_stm <= (others => '0');
            in_6_Iw_tpl_stm <= (others => '0');
            in_7_Torque_tpl_stm <= (others => '0');
            in_8_IntegralQ_in_tpl_stm <= (others => '0');
            in_9_IntegralD_in_tpl_stm <= (others => '0');
            in_10_phi_el_tpl_stm <= (others => '0');
            in_11_Kp_tpl_stm <= (others => '0');
            in_12_Ki_tpl_stm <= (others => '0');
            in_13_I_Sat_Limit_tpl_stm <= (others => '0');
            in_14_Max_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 10000 ps; -- additional reset delay
                
                in_1_dv_tpl_stm <= (others => '0');
                in_2_dc_tpl_stm <= (others => '0');
                in_3_valid_in_tpl_stm <= (others => '0');
                in_4_axis_in_tpl_stm <= (others => '0');
                in_5_Iu_tpl_stm <= (others => '0');
                in_6_Iw_tpl_stm <= (others => '0');
                in_7_Torque_tpl_stm <= (others => '0');
                in_8_IntegralQ_in_tpl_stm <= (others => '0');
                in_9_IntegralD_in_tpl_stm <= (others => '0');
                in_10_phi_el_tpl_stm <= (others => '0');
                in_11_Kp_tpl_stm <= (others => '0');
                in_12_Ki_tpl_stm <= (others => '0');
                in_13_I_Sat_Limit_tpl_stm <= (others => '0');
                in_14_Max_tpl_stm <= (others => '0');
            end loop;
            while true loop
            
                IF (endfile(data_file_ChannelIn2)) THEN
                    clk_ChannelIn2_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn2, L);
                    
                    read(L, in_1_dv_tpl_int_0);
                    in_1_dv_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_1_dv_tpl_int_0, 1));
                    in_1_dv_tpl_stm <= in_1_dv_tpl_temp;
                    read(L, in_2_dc_tpl_int_0);
                    in_2_dc_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(in_2_dc_tpl_int_0, 8));
                    in_2_dc_tpl_stm <= in_2_dc_tpl_temp;
                    read(L, in_3_valid_in_tpl_int_0);
                    in_3_valid_in_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_3_valid_in_tpl_int_0, 1));
                    in_3_valid_in_tpl_stm <= in_3_valid_in_tpl_temp;
                    read(L, in_4_axis_in_tpl_int_0);
                    in_4_axis_in_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(in_4_axis_in_tpl_int_0, 8));
                    in_4_axis_in_tpl_stm <= in_4_axis_in_tpl_temp;
                    read(L, in_5_Iu_tpl_int_0);
                    in_5_Iu_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_5_Iu_tpl_int_0, 16));
                    in_5_Iu_tpl_stm <= in_5_Iu_tpl_temp;
                    read(L, in_6_Iw_tpl_int_0);
                    in_6_Iw_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_6_Iw_tpl_int_0, 16));
                    in_6_Iw_tpl_stm <= in_6_Iw_tpl_temp;
                    read(L, in_7_Torque_tpl_int_0);
                    in_7_Torque_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_7_Torque_tpl_int_0, 16));
                    in_7_Torque_tpl_stm <= in_7_Torque_tpl_temp;
                    read(L, in_8_IntegralQ_in_tpl_int_0);
                    in_8_IntegralQ_in_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_8_IntegralQ_in_tpl_int_0, 16));
                    in_8_IntegralQ_in_tpl_stm <= in_8_IntegralQ_in_tpl_temp;
                    read(L, in_9_IntegralD_in_tpl_int_0);
                    in_9_IntegralD_in_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_9_IntegralD_in_tpl_int_0, 16));
                    in_9_IntegralD_in_tpl_stm <= in_9_IntegralD_in_tpl_temp;
                    read(L, in_10_phi_el_tpl_int_0);
                    in_10_phi_el_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_10_phi_el_tpl_int_0, 16));
                    in_10_phi_el_tpl_stm <= in_10_phi_el_tpl_temp;
                    read(L, in_11_Kp_tpl_int_0);
                    in_11_Kp_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_11_Kp_tpl_int_0, 16));
                    in_11_Kp_tpl_stm <= in_11_Kp_tpl_temp;
                    read(L, in_12_Ki_tpl_int_0);
                    in_12_Ki_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_12_Ki_tpl_int_0, 16));
                    in_12_Ki_tpl_stm <= in_12_Ki_tpl_temp;
                    read(L, in_13_I_Sat_Limit_tpl_int_0);
                    in_13_I_Sat_Limit_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_13_I_Sat_Limit_tpl_int_0, 16));
                    in_13_I_Sat_Limit_tpl_stm <= in_13_I_Sat_Limit_tpl_temp;
                    read(L, in_14_Max_tpl_int_0);
                    in_14_Max_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_14_Max_tpl_int_0, 16));
                    in_14_Max_tpl_stm <= in_14_Max_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ChannelOut1_vunroll_x
        ChannelOut1_vunroll_x_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut1_vunroll_x : text open read_mode is safe_path("DF_fixp16_alu_av/DF_fixp16_alu_av_FOC_FL_fixp16_ChannelOut1_vunroll_x.stm");
            variable out_1_qv_tpl_int_0 : Integer;
            variable out_1_qv_tpl_temp : std_logic_vector(0 downto 0);
            variable out_2_qc_tpl_int_0 : Integer;
            variable out_2_qc_tpl_temp : std_logic_vector(7 downto 0);
            variable out_3_valid_out_tpl_int_0 : Integer;
            variable out_3_valid_out_tpl_temp : std_logic_vector(0 downto 0);
            variable out_4_axis_out_tpl_int_0 : Integer;
            variable out_4_axis_out_tpl_temp : std_logic_vector(7 downto 0);
            variable out_5_Valpha_tpl_int_0 : Integer;
            variable out_5_Valpha_tpl_temp : std_logic_vector(31 downto 0);
            variable out_6_Vbeta_tpl_int_0 : Integer;
            variable out_6_Vbeta_tpl_temp : std_logic_vector(31 downto 0);
            variable out_7_IntegralD_out_tpl_int_0 : Integer;
            variable out_7_IntegralD_out_tpl_temp : std_logic_vector(15 downto 0);
            variable out_8_IntegralQ_out_tpl_int_0 : Integer;
            variable out_8_IntegralQ_out_tpl_temp : std_logic_vector(15 downto 0);
            variable out_9_Iq_tpl_int_0 : Integer;
            variable out_9_Iq_tpl_temp : std_logic_vector(15 downto 0);
            variable out_10_Id_tpl_int_0 : Integer;
            variable out_10_Id_tpl_temp : std_logic_vector(15 downto 0);
            variable out_11_uvw_0_tpl_int_0 : Integer;
            variable out_11_uvw_0_tpl_temp : std_logic_vector(15 downto 0);
            variable out_11_uvw_1_tpl_int_0 : Integer;
            variable out_11_uvw_1_tpl_temp : std_logic_vector(15 downto 0);
            variable out_11_uvw_2_tpl_int_0 : Integer;
            variable out_11_uvw_2_tpl_temp : std_logic_vector(15 downto 0);
            variable out_12_ready_tpl_int_0 : Integer;
            variable out_12_ready_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            out_1_qv_tpl_stm <= (others => '0');
            out_2_qc_tpl_stm <= (others => '0');
            out_3_valid_out_tpl_stm <= (others => '0');
            out_4_axis_out_tpl_stm <= (others => '0');
            out_5_Valpha_tpl_stm <= (others => '0');
            out_6_Vbeta_tpl_stm <= (others => '0');
            out_7_IntegralD_out_tpl_stm <= (others => '0');
            out_8_IntegralQ_out_tpl_stm <= (others => '0');
            out_9_Iq_tpl_stm <= (others => '0');
            out_10_Id_tpl_stm <= (others => '0');
            out_11_uvw_0_tpl_stm <= (others => '0');
            out_11_uvw_1_tpl_stm <= (others => '0');
            out_11_uvw_2_tpl_stm <= (others => '0');
            out_12_ready_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*10000 ps; -- additional reset delay
            
            while true loop
            
                IF (endfile(data_file_ChannelOut1_vunroll_x)) THEN
                    clk_ChannelOut1_vunroll_x_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut1_vunroll_x, L);
                    
                    read(L, out_1_qv_tpl_int_0);
                    out_1_qv_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_qv_tpl_int_0, 1));
                    out_1_qv_tpl_stm <= out_1_qv_tpl_temp;
                    read(L, out_2_qc_tpl_int_0);
                    out_2_qc_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(out_2_qc_tpl_int_0, 8));
                    out_2_qc_tpl_stm <= out_2_qc_tpl_temp;
                    read(L, out_3_valid_out_tpl_int_0);
                    out_3_valid_out_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_3_valid_out_tpl_int_0, 1));
                    out_3_valid_out_tpl_stm <= out_3_valid_out_tpl_temp;
                    read(L, out_4_axis_out_tpl_int_0);
                    out_4_axis_out_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(out_4_axis_out_tpl_int_0, 8));
                    out_4_axis_out_tpl_stm <= out_4_axis_out_tpl_temp;
                    read(L, out_5_Valpha_tpl_int_0);
                    out_5_Valpha_tpl_temp(31 downto 0) := std_logic_vector(to_signed(out_5_Valpha_tpl_int_0, 32));
                    out_5_Valpha_tpl_stm <= out_5_Valpha_tpl_temp;
                    read(L, out_6_Vbeta_tpl_int_0);
                    out_6_Vbeta_tpl_temp(31 downto 0) := std_logic_vector(to_signed(out_6_Vbeta_tpl_int_0, 32));
                    out_6_Vbeta_tpl_stm <= out_6_Vbeta_tpl_temp;
                    read(L, out_7_IntegralD_out_tpl_int_0);
                    out_7_IntegralD_out_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_7_IntegralD_out_tpl_int_0, 16));
                    out_7_IntegralD_out_tpl_stm <= out_7_IntegralD_out_tpl_temp;
                    read(L, out_8_IntegralQ_out_tpl_int_0);
                    out_8_IntegralQ_out_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_8_IntegralQ_out_tpl_int_0, 16));
                    out_8_IntegralQ_out_tpl_stm <= out_8_IntegralQ_out_tpl_temp;
                    read(L, out_9_Iq_tpl_int_0);
                    out_9_Iq_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_9_Iq_tpl_int_0, 16));
                    out_9_Iq_tpl_stm <= out_9_Iq_tpl_temp;
                    read(L, out_10_Id_tpl_int_0);
                    out_10_Id_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_10_Id_tpl_int_0, 16));
                    out_10_Id_tpl_stm <= out_10_Id_tpl_temp;
                    read(L, out_11_uvw_0_tpl_int_0);
                    out_11_uvw_0_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_uvw_0_tpl_int_0, 16));
                    out_11_uvw_0_tpl_stm <= out_11_uvw_0_tpl_temp;
                    read(L, out_11_uvw_1_tpl_int_0);
                    out_11_uvw_1_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_uvw_1_tpl_int_0, 16));
                    out_11_uvw_1_tpl_stm <= out_11_uvw_1_tpl_temp;
                    read(L, out_11_uvw_2_tpl_int_0);
                    out_11_uvw_2_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_uvw_2_tpl_int_0, 16));
                    out_11_uvw_2_tpl_stm <= out_11_uvw_2_tpl_temp;
                    read(L, out_12_ready_tpl_int_0);
                    out_12_ready_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_12_ready_tpl_int_0, 1));
                    out_12_ready_tpl_stm <= out_12_ready_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_ChannelIn2_stm_sig_stop OR clk_ChannelOut1_vunroll_x_stm_sig_stop OR '0';


    END normal;
