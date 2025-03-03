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

-- VHDL created from motor_kit_sim_20MHz_MotorModel_MM_16fixed
-- VHDL created on Wed Aug  7 11:04:00 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.TextIO.all;
USE work.motor_kit_sim_20MHz_MotorModel_safe_path.all;

entity motor_kit_sim_20MHz_MotorModel_MM_16fixed_stm is
    port (
        in_1_valid_in_tpl_stm : out std_logic_vector(0 downto 0);
        in_2_channel_in_tpl_stm : out std_logic_vector(7 downto 0);
        in_12_PolePairs_int_tpl_stm : out std_logic_vector(15 downto 0);
        in_13_Ke_Vs_rad_tpl_stm : out std_logic_vector(15 downto 0);
        in_17_DC_link_tpl_stm : out std_logic_vector(15 downto 0);
        in_3_Va_V_tpl_stm : out std_logic_vector(0 downto 0);
        in_4_Vb_V_tpl_stm : out std_logic_vector(0 downto 0);
        in_5_Vc_V_tpl_stm : out std_logic_vector(0 downto 0);
        in_6_u_l_tpl_stm : out std_logic_vector(0 downto 0);
        in_7_v_l_tpl_stm : out std_logic_vector(0 downto 0);
        in_8_w_l_tpl_stm : out std_logic_vector(0 downto 0);
        in_9_SampleTime_s_tpl_stm : out std_logic_vector(15 downto 0);
        in_10_Rphase_ohm_tpl_stm : out std_logic_vector(15 downto 0);
        in_11_inv_Lphase_1_H_tpl_stm : out std_logic_vector(15 downto 0);
        in_14_Kt_Nm_A_tpl_stm : out std_logic_vector(15 downto 0);
        in_15_inv_J_1_kgm2_tpl_stm : out std_logic_vector(15 downto 0);
        in_16_LoadT_Nm_tpl_stm : out std_logic_vector(15 downto 0);
        out_1_valid_out_tpl_stm : out std_logic_vector(0 downto 0);
        out_2_channel_out_tpl_stm : out std_logic_vector(7 downto 0);
        out_3_did_dt_A_s_tpl_stm : out std_logic_vector(32 downto 0);
        out_4_diq_dt_A_s_tpl_stm : out std_logic_vector(32 downto 0);
        out_8_id_A_tpl_stm : out std_logic_vector(26 downto 0);
        out_9_iq_A_tpl_stm : out std_logic_vector(26 downto 0);
        out_10_T_Nm_tpl_stm : out std_logic_vector(19 downto 0);
        out_5_ia_A_tpl_stm : out std_logic_vector(15 downto 0);
        out_6_ib_A_tpl_stm : out std_logic_vector(15 downto 0);
        out_7_ic_A_tpl_stm : out std_logic_vector(15 downto 0);
        out_11_Vd_V_tpl_stm : out std_logic_vector(15 downto 0);
        out_12_Vq_V_tpl_stm : out std_logic_vector(15 downto 0);
        out_13_dTheta_dt_rad_s_k_tpl_stm : out std_logic_vector(31 downto 0);
        out_14_Theta_one_turn_k_tpl_stm : out std_logic_vector(15 downto 0);
        out_15_QEP_A_tpl_stm : out std_logic_vector(0 downto 0);
        out_16_QEP_B_tpl_stm : out std_logic_vector(0 downto 0);
        out_17_DC_link_A_tpl_stm : out std_logic_vector(18 downto 0);
        out_18_ready_tpl_stm : out std_logic_vector(0 downto 0);
        in_18_Powerdown_p_tpl_stm : out std_logic_vector(0 downto 0);
        in_19_Powerdown_n_tpl_stm : out std_logic_vector(0 downto 0);
        clk : out std_logic;
        areset : out std_logic
    );
end motor_kit_sim_20MHz_MotorModel_MM_16fixed_stm;

architecture normal of motor_kit_sim_20MHz_MotorModel_MM_16fixed_stm is

    signal clk_stm_sig : std_logic := '0';
    signal clk_stm_sig_stop : std_logic := '0';
    signal areset_stm_sig : std_logic := '1';
    signal clk_ChannelIn_stm_sig_stop : std_logic := '0';
    signal clk_ChannelOut_stm_sig_stop : std_logic := '0';
    signal clk_GPIn_stm_sig_stop : std_logic := '0';

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


        -- Generating stimulus for ChannelIn
        ChannelIn_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelIn.stm");
            variable in_1_valid_in_tpl_int_0 : Integer;
            variable in_1_valid_in_tpl_temp : std_logic_vector(0 downto 0);
            variable in_2_channel_in_tpl_int_0 : Integer;
            variable in_2_channel_in_tpl_temp : std_logic_vector(7 downto 0);
            variable in_12_PolePairs_int_tpl_int_0 : Integer;
            variable in_12_PolePairs_int_tpl_temp : std_logic_vector(15 downto 0);
            variable in_13_Ke_Vs_rad_tpl_int_0 : Integer;
            variable in_13_Ke_Vs_rad_tpl_temp : std_logic_vector(15 downto 0);
            variable in_17_DC_link_tpl_int_0 : Integer;
            variable in_17_DC_link_tpl_temp : std_logic_vector(15 downto 0);
            variable in_3_Va_V_tpl_int_0 : Integer;
            variable in_3_Va_V_tpl_temp : std_logic_vector(0 downto 0);
            variable in_4_Vb_V_tpl_int_0 : Integer;
            variable in_4_Vb_V_tpl_temp : std_logic_vector(0 downto 0);
            variable in_5_Vc_V_tpl_int_0 : Integer;
            variable in_5_Vc_V_tpl_temp : std_logic_vector(0 downto 0);
            variable in_6_u_l_tpl_int_0 : Integer;
            variable in_6_u_l_tpl_temp : std_logic_vector(0 downto 0);
            variable in_7_v_l_tpl_int_0 : Integer;
            variable in_7_v_l_tpl_temp : std_logic_vector(0 downto 0);
            variable in_8_w_l_tpl_int_0 : Integer;
            variable in_8_w_l_tpl_temp : std_logic_vector(0 downto 0);
            variable in_9_SampleTime_s_tpl_int_0 : Integer;
            variable in_9_SampleTime_s_tpl_temp : std_logic_vector(15 downto 0);
            variable in_10_Rphase_ohm_tpl_int_0 : Integer;
            variable in_10_Rphase_ohm_tpl_temp : std_logic_vector(15 downto 0);
            variable in_11_inv_Lphase_1_H_tpl_int_0 : Integer;
            variable in_11_inv_Lphase_1_H_tpl_temp : std_logic_vector(15 downto 0);
            variable in_14_Kt_Nm_A_tpl_int_0 : Integer;
            variable in_14_Kt_Nm_A_tpl_temp : std_logic_vector(15 downto 0);
            variable in_15_inv_J_1_kgm2_tpl_int_0 : Integer;
            variable in_15_inv_J_1_kgm2_tpl_temp : std_logic_vector(15 downto 0);
            variable in_16_LoadT_Nm_tpl_int_0 : Integer;
            variable in_16_LoadT_Nm_tpl_temp : std_logic_vector(15 downto 0);

        begin
            -- initialize all outputs to 0
            in_1_valid_in_tpl_stm <= (others => '0');
            in_2_channel_in_tpl_stm <= (others => '0');
            in_12_PolePairs_int_tpl_stm <= (others => '0');
            in_13_Ke_Vs_rad_tpl_stm <= (others => '0');
            in_17_DC_link_tpl_stm <= (others => '0');
            in_3_Va_V_tpl_stm <= (others => '0');
            in_4_Vb_V_tpl_stm <= (others => '0');
            in_5_Vc_V_tpl_stm <= (others => '0');
            in_6_u_l_tpl_stm <= (others => '0');
            in_7_v_l_tpl_stm <= (others => '0');
            in_8_w_l_tpl_stm <= (others => '0');
            in_9_SampleTime_s_tpl_stm <= (others => '0');
            in_10_Rphase_ohm_tpl_stm <= (others => '0');
            in_11_inv_Lphase_1_H_tpl_stm <= (others => '0');
            in_14_Kt_Nm_A_tpl_stm <= (others => '0');
            in_15_inv_J_1_kgm2_tpl_stm <= (others => '0');
            in_16_LoadT_Nm_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                in_1_valid_in_tpl_stm <= (others => '0');
                in_2_channel_in_tpl_stm <= (others => '0');
                in_12_PolePairs_int_tpl_stm <= (others => '0');
                in_13_Ke_Vs_rad_tpl_stm <= (others => '0');
                in_17_DC_link_tpl_stm <= (others => '0');
                in_3_Va_V_tpl_stm <= (others => '0');
                in_4_Vb_V_tpl_stm <= (others => '0');
                in_5_Vc_V_tpl_stm <= (others => '0');
                in_6_u_l_tpl_stm <= (others => '0');
                in_7_v_l_tpl_stm <= (others => '0');
                in_8_w_l_tpl_stm <= (others => '0');
                in_9_SampleTime_s_tpl_stm <= (others => '0');
                in_10_Rphase_ohm_tpl_stm <= (others => '0');
                in_11_inv_Lphase_1_H_tpl_stm <= (others => '0');
                in_14_Kt_Nm_A_tpl_stm <= (others => '0');
                in_15_inv_J_1_kgm2_tpl_stm <= (others => '0');
                in_16_LoadT_Nm_tpl_stm <= (others => '0');
            end loop;
            while true loop
            
                IF (endfile(data_file_ChannelIn)) THEN
                    clk_ChannelIn_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelIn, L);
                    
                    read(L, in_1_valid_in_tpl_int_0);
                    in_1_valid_in_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_1_valid_in_tpl_int_0, 1));
                    in_1_valid_in_tpl_stm <= in_1_valid_in_tpl_temp;
                    read(L, in_2_channel_in_tpl_int_0);
                    in_2_channel_in_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(in_2_channel_in_tpl_int_0, 8));
                    in_2_channel_in_tpl_stm <= in_2_channel_in_tpl_temp;
                    read(L, in_12_PolePairs_int_tpl_int_0);
                    in_12_PolePairs_int_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_12_PolePairs_int_tpl_int_0, 16));
                    in_12_PolePairs_int_tpl_stm <= in_12_PolePairs_int_tpl_temp;
                    read(L, in_13_Ke_Vs_rad_tpl_int_0);
                    in_13_Ke_Vs_rad_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_13_Ke_Vs_rad_tpl_int_0, 16));
                    in_13_Ke_Vs_rad_tpl_stm <= in_13_Ke_Vs_rad_tpl_temp;
                    read(L, in_17_DC_link_tpl_int_0);
                    in_17_DC_link_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_17_DC_link_tpl_int_0, 16));
                    in_17_DC_link_tpl_stm <= in_17_DC_link_tpl_temp;
                    read(L, in_3_Va_V_tpl_int_0);
                    in_3_Va_V_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_3_Va_V_tpl_int_0, 1));
                    in_3_Va_V_tpl_stm <= in_3_Va_V_tpl_temp;
                    read(L, in_4_Vb_V_tpl_int_0);
                    in_4_Vb_V_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_4_Vb_V_tpl_int_0, 1));
                    in_4_Vb_V_tpl_stm <= in_4_Vb_V_tpl_temp;
                    read(L, in_5_Vc_V_tpl_int_0);
                    in_5_Vc_V_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_5_Vc_V_tpl_int_0, 1));
                    in_5_Vc_V_tpl_stm <= in_5_Vc_V_tpl_temp;
                    read(L, in_6_u_l_tpl_int_0);
                    in_6_u_l_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_6_u_l_tpl_int_0, 1));
                    in_6_u_l_tpl_stm <= in_6_u_l_tpl_temp;
                    read(L, in_7_v_l_tpl_int_0);
                    in_7_v_l_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_7_v_l_tpl_int_0, 1));
                    in_7_v_l_tpl_stm <= in_7_v_l_tpl_temp;
                    read(L, in_8_w_l_tpl_int_0);
                    in_8_w_l_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_8_w_l_tpl_int_0, 1));
                    in_8_w_l_tpl_stm <= in_8_w_l_tpl_temp;
                    read(L, in_9_SampleTime_s_tpl_int_0);
                    in_9_SampleTime_s_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_9_SampleTime_s_tpl_int_0, 16));
                    in_9_SampleTime_s_tpl_stm <= in_9_SampleTime_s_tpl_temp;
                    read(L, in_10_Rphase_ohm_tpl_int_0);
                    in_10_Rphase_ohm_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_10_Rphase_ohm_tpl_int_0, 16));
                    in_10_Rphase_ohm_tpl_stm <= in_10_Rphase_ohm_tpl_temp;
                    read(L, in_11_inv_Lphase_1_H_tpl_int_0);
                    in_11_inv_Lphase_1_H_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_11_inv_Lphase_1_H_tpl_int_0, 16));
                    in_11_inv_Lphase_1_H_tpl_stm <= in_11_inv_Lphase_1_H_tpl_temp;
                    read(L, in_14_Kt_Nm_A_tpl_int_0);
                    in_14_Kt_Nm_A_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_14_Kt_Nm_A_tpl_int_0, 16));
                    in_14_Kt_Nm_A_tpl_stm <= in_14_Kt_Nm_A_tpl_temp;
                    read(L, in_15_inv_J_1_kgm2_tpl_int_0);
                    in_15_inv_J_1_kgm2_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_15_inv_J_1_kgm2_tpl_int_0, 16));
                    in_15_inv_J_1_kgm2_tpl_stm <= in_15_inv_J_1_kgm2_tpl_temp;
                    read(L, in_16_LoadT_Nm_tpl_int_0);
                    in_16_LoadT_Nm_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(in_16_LoadT_Nm_tpl_int_0, 16));
                    in_16_LoadT_Nm_tpl_stm <= in_16_LoadT_Nm_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for ChannelOut
        ChannelOut_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_ChannelOut : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_ChannelOut.stm");
            variable out_1_valid_out_tpl_int_0 : Integer;
            variable out_1_valid_out_tpl_temp : std_logic_vector(0 downto 0);
            variable out_2_channel_out_tpl_int_0 : Integer;
            variable out_2_channel_out_tpl_temp : std_logic_vector(7 downto 0);
            variable out_3_did_dt_A_s_tpl_int_0 : Integer;
            variable out_3_did_dt_A_s_tpl_int_1 : Integer;
            variable out_3_did_dt_A_s_tpl_temp : std_logic_vector(32 downto 0);
            variable out_4_diq_dt_A_s_tpl_int_0 : Integer;
            variable out_4_diq_dt_A_s_tpl_int_1 : Integer;
            variable out_4_diq_dt_A_s_tpl_temp : std_logic_vector(32 downto 0);
            variable out_8_id_A_tpl_int_0 : Integer;
            variable out_8_id_A_tpl_temp : std_logic_vector(26 downto 0);
            variable out_9_iq_A_tpl_int_0 : Integer;
            variable out_9_iq_A_tpl_temp : std_logic_vector(26 downto 0);
            variable out_10_T_Nm_tpl_int_0 : Integer;
            variable out_10_T_Nm_tpl_temp : std_logic_vector(19 downto 0);
            variable out_5_ia_A_tpl_int_0 : Integer;
            variable out_5_ia_A_tpl_temp : std_logic_vector(15 downto 0);
            variable out_6_ib_A_tpl_int_0 : Integer;
            variable out_6_ib_A_tpl_temp : std_logic_vector(15 downto 0);
            variable out_7_ic_A_tpl_int_0 : Integer;
            variable out_7_ic_A_tpl_temp : std_logic_vector(15 downto 0);
            variable out_11_Vd_V_tpl_int_0 : Integer;
            variable out_11_Vd_V_tpl_temp : std_logic_vector(15 downto 0);
            variable out_12_Vq_V_tpl_int_0 : Integer;
            variable out_12_Vq_V_tpl_temp : std_logic_vector(15 downto 0);
            variable out_13_dTheta_dt_rad_s_k_tpl_int_0 : Integer;
            variable out_13_dTheta_dt_rad_s_k_tpl_temp : std_logic_vector(31 downto 0);
            variable out_14_Theta_one_turn_k_tpl_int_0 : Integer;
            variable out_14_Theta_one_turn_k_tpl_temp : std_logic_vector(15 downto 0);
            variable out_15_QEP_A_tpl_int_0 : Integer;
            variable out_15_QEP_A_tpl_temp : std_logic_vector(0 downto 0);
            variable out_16_QEP_B_tpl_int_0 : Integer;
            variable out_16_QEP_B_tpl_temp : std_logic_vector(0 downto 0);
            variable out_17_DC_link_A_tpl_int_0 : Integer;
            variable out_17_DC_link_A_tpl_temp : std_logic_vector(18 downto 0);
            variable out_18_ready_tpl_int_0 : Integer;
            variable out_18_ready_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            out_1_valid_out_tpl_stm <= (others => '0');
            out_2_channel_out_tpl_stm <= (others => '0');
            out_3_did_dt_A_s_tpl_stm <= (others => '0');
            out_4_diq_dt_A_s_tpl_stm <= (others => '0');
            out_8_id_A_tpl_stm <= (others => '0');
            out_9_iq_A_tpl_stm <= (others => '0');
            out_10_T_Nm_tpl_stm <= (others => '0');
            out_5_ia_A_tpl_stm <= (others => '0');
            out_6_ib_A_tpl_stm <= (others => '0');
            out_7_ic_A_tpl_stm <= (others => '0');
            out_11_Vd_V_tpl_stm <= (others => '0');
            out_12_Vq_V_tpl_stm <= (others => '0');
            out_13_dTheta_dt_rad_s_k_tpl_stm <= (others => '0');
            out_14_Theta_one_turn_k_tpl_stm <= (others => '0');
            out_15_QEP_A_tpl_stm <= (others => '0');
            out_16_QEP_B_tpl_stm <= (others => '0');
            out_17_DC_link_A_tpl_stm <= (others => '0');
            out_18_ready_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            wait for 1023*50000 ps; -- additional reset delay
            
            while true loop
            
                IF (endfile(data_file_ChannelOut)) THEN
                    clk_ChannelOut_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_ChannelOut, L);
                    
                    read(L, out_1_valid_out_tpl_int_0);
                    out_1_valid_out_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_1_valid_out_tpl_int_0, 1));
                    out_1_valid_out_tpl_stm <= out_1_valid_out_tpl_temp;
                    read(L, out_2_channel_out_tpl_int_0);
                    out_2_channel_out_tpl_temp(7 downto 0) := std_logic_vector(to_unsigned(out_2_channel_out_tpl_int_0, 8));
                    out_2_channel_out_tpl_stm <= out_2_channel_out_tpl_temp;
                    read(L, out_3_did_dt_A_s_tpl_int_0);
                    out_3_did_dt_A_s_tpl_temp(31 downto 0) := std_logic_vector(to_signed(out_3_did_dt_A_s_tpl_int_0, 32));
                    read(L, out_3_did_dt_A_s_tpl_int_1);
                    out_3_did_dt_A_s_tpl_temp(32 downto 32) := std_logic_vector(to_unsigned(out_3_did_dt_A_s_tpl_int_1, 1));
                    out_3_did_dt_A_s_tpl_stm <= out_3_did_dt_A_s_tpl_temp;
                    read(L, out_4_diq_dt_A_s_tpl_int_0);
                    out_4_diq_dt_A_s_tpl_temp(31 downto 0) := std_logic_vector(to_signed(out_4_diq_dt_A_s_tpl_int_0, 32));
                    read(L, out_4_diq_dt_A_s_tpl_int_1);
                    out_4_diq_dt_A_s_tpl_temp(32 downto 32) := std_logic_vector(to_unsigned(out_4_diq_dt_A_s_tpl_int_1, 1));
                    out_4_diq_dt_A_s_tpl_stm <= out_4_diq_dt_A_s_tpl_temp;
                    read(L, out_8_id_A_tpl_int_0);
                    out_8_id_A_tpl_temp(26 downto 0) := std_logic_vector(to_unsigned(out_8_id_A_tpl_int_0, 27));
                    out_8_id_A_tpl_stm <= out_8_id_A_tpl_temp;
                    read(L, out_9_iq_A_tpl_int_0);
                    out_9_iq_A_tpl_temp(26 downto 0) := std_logic_vector(to_unsigned(out_9_iq_A_tpl_int_0, 27));
                    out_9_iq_A_tpl_stm <= out_9_iq_A_tpl_temp;
                    read(L, out_10_T_Nm_tpl_int_0);
                    out_10_T_Nm_tpl_temp(19 downto 0) := std_logic_vector(to_unsigned(out_10_T_Nm_tpl_int_0, 20));
                    out_10_T_Nm_tpl_stm <= out_10_T_Nm_tpl_temp;
                    read(L, out_5_ia_A_tpl_int_0);
                    out_5_ia_A_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_5_ia_A_tpl_int_0, 16));
                    out_5_ia_A_tpl_stm <= out_5_ia_A_tpl_temp;
                    read(L, out_6_ib_A_tpl_int_0);
                    out_6_ib_A_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_6_ib_A_tpl_int_0, 16));
                    out_6_ib_A_tpl_stm <= out_6_ib_A_tpl_temp;
                    read(L, out_7_ic_A_tpl_int_0);
                    out_7_ic_A_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_7_ic_A_tpl_int_0, 16));
                    out_7_ic_A_tpl_stm <= out_7_ic_A_tpl_temp;
                    read(L, out_11_Vd_V_tpl_int_0);
                    out_11_Vd_V_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_11_Vd_V_tpl_int_0, 16));
                    out_11_Vd_V_tpl_stm <= out_11_Vd_V_tpl_temp;
                    read(L, out_12_Vq_V_tpl_int_0);
                    out_12_Vq_V_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_12_Vq_V_tpl_int_0, 16));
                    out_12_Vq_V_tpl_stm <= out_12_Vq_V_tpl_temp;
                    read(L, out_13_dTheta_dt_rad_s_k_tpl_int_0);
                    out_13_dTheta_dt_rad_s_k_tpl_temp(31 downto 0) := std_logic_vector(to_signed(out_13_dTheta_dt_rad_s_k_tpl_int_0, 32));
                    out_13_dTheta_dt_rad_s_k_tpl_stm <= out_13_dTheta_dt_rad_s_k_tpl_temp;
                    read(L, out_14_Theta_one_turn_k_tpl_int_0);
                    out_14_Theta_one_turn_k_tpl_temp(15 downto 0) := std_logic_vector(to_unsigned(out_14_Theta_one_turn_k_tpl_int_0, 16));
                    out_14_Theta_one_turn_k_tpl_stm <= out_14_Theta_one_turn_k_tpl_temp;
                    read(L, out_15_QEP_A_tpl_int_0);
                    out_15_QEP_A_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_15_QEP_A_tpl_int_0, 1));
                    out_15_QEP_A_tpl_stm <= out_15_QEP_A_tpl_temp;
                    read(L, out_16_QEP_B_tpl_int_0);
                    out_16_QEP_B_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_16_QEP_B_tpl_int_0, 1));
                    out_16_QEP_B_tpl_stm <= out_16_QEP_B_tpl_temp;
                    read(L, out_17_DC_link_A_tpl_int_0);
                    out_17_DC_link_A_tpl_temp(18 downto 0) := std_logic_vector(to_unsigned(out_17_DC_link_A_tpl_int_0, 19));
                    out_17_DC_link_A_tpl_stm <= out_17_DC_link_A_tpl_temp;
                    read(L, out_18_ready_tpl_int_0);
                    out_18_ready_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(out_18_ready_tpl_int_0, 1));
                    out_18_ready_tpl_stm <= out_18_ready_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

        -- Generating stimulus for GPIn
        GPIn_stm_init_p: process

            variable L : line;
            variable dummy_int : Integer;
            file data_file_GPIn : text open read_mode is safe_path("motor_kit_sim_20MHz/motor_kit_sim_20MHz_MotorModel_MM_16fixed_GPIn.stm");
            variable in_18_Powerdown_p_tpl_int_0 : Integer;
            variable in_18_Powerdown_p_tpl_temp : std_logic_vector(0 downto 0);
            variable in_19_Powerdown_n_tpl_int_0 : Integer;
            variable in_19_Powerdown_n_tpl_temp : std_logic_vector(0 downto 0);

        begin
            -- initialize all outputs to 0
            in_18_Powerdown_p_tpl_stm <= (others => '0');
            in_19_Powerdown_n_tpl_stm <= (others => '0');

            wait for 201 ps; -- wait delay
            
            for tick in 1 to 1023 loop
            
                wait for 50000 ps; -- additional reset delay
                
                in_18_Powerdown_p_tpl_stm <= (others => '0');
                in_19_Powerdown_n_tpl_stm <= (others => '0');
            end loop;
            while true loop
            
                IF (endfile(data_file_GPIn)) THEN
                    clk_GPIn_stm_sig_stop <= '1';
                    wait;
                ELSE
                    readline(data_file_GPIn, L);
                    
                    read(L, in_18_Powerdown_p_tpl_int_0);
                    in_18_Powerdown_p_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_18_Powerdown_p_tpl_int_0, 1));
                    in_18_Powerdown_p_tpl_stm <= in_18_Powerdown_p_tpl_temp;
                    read(L, in_19_Powerdown_n_tpl_int_0);
                    in_19_Powerdown_n_tpl_temp(0 downto 0) := std_logic_vector(to_unsigned(in_19_Powerdown_n_tpl_int_0, 1));
                    in_19_Powerdown_n_tpl_stm <= in_19_Powerdown_n_tpl_temp;

                    deallocate(L);
                END IF;
                -- -- wait for rising edge to pass (assert signals just after rising edge)
                wait until clk_stm_sig'EVENT and clk_stm_sig = '1';
                wait for 1 ps; -- wait delay
                
                end loop;
            wait;
        END PROCESS;

    clk_stm_sig_stop <= clk_ChannelIn_stm_sig_stop OR clk_ChannelOut_stm_sig_stop OR clk_GPIn_stm_sig_stop OR '0';


    END normal;
