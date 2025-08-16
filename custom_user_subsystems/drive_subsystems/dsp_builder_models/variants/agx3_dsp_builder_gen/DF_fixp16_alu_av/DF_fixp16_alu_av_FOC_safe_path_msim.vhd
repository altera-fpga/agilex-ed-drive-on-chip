-- safe_path for DF_fixp16_alu_av_FOC given rtl dir is ./../../dsp_builder_gen (modelsim)
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE DF_fixp16_alu_av_FOC_safe_path is
	FUNCTION safe_path( path: string ) RETURN string;
END DF_fixp16_alu_av_FOC_safe_path;

PACKAGE body DF_fixp16_alu_av_FOC_safe_path IS
	FUNCTION safe_path( path: string )
		RETURN string IS
	BEGIN
		RETURN path;
	END FUNCTION safe_path;
END DF_fixp16_alu_av_FOC_safe_path;
