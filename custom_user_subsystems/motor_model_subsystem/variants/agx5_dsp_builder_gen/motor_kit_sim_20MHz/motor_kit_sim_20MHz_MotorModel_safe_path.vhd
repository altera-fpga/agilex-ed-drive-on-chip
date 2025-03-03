-- safe_path for standaloneTopLevel_motor_kit_sim_20MHz_MotorModel_AvalonRegisters given rtl dir is ./../../dsp_builder_gen (quartus)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE motor_kit_sim_20MHz_MotorModel_safe_path is
	FUNCTION safe_path( path: string ) RETURN string;
END motor_kit_sim_20MHz_MotorModel_safe_path;

PACKAGE body motor_kit_sim_20MHz_MotorModel_safe_path IS
	FUNCTION safe_path( path: string )
		RETURN string IS
	BEGIN
		return string'("./../../dsp_builder_gen/") & path;
	END FUNCTION safe_path;
END motor_kit_sim_20MHz_MotorModel_safe_path;
