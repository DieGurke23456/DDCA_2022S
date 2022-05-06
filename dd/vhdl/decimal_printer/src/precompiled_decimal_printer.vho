-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Standard Edition"

-- DATE "04/14/2022 13:52:19"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_F4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_E2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_P3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_N7,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	precompiled_decimal_printer IS
    PORT (
	clk : IN std_logic;
	res_n : IN std_logic;
	gfx_instr : OUT std_logic_vector(15 DOWNTO 0);
	gfx_instr_wr : OUT std_logic;
	gfx_instr_full : IN std_logic;
	start : IN std_logic;
	busy : OUT std_logic;
	x : IN std_logic_vector(15 DOWNTO 0);
	y : IN std_logic_vector(15 DOWNTO 0);
	number : IN std_logic_vector(15 DOWNTO 0)
	);
END precompiled_decimal_printer;

-- Design Ports Information
-- gfx_instr[0]	=>  Location: PIN_L23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[1]	=>  Location: PIN_K28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[2]	=>  Location: PIN_J16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[3]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[4]	=>  Location: PIN_L24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[5]	=>  Location: PIN_R21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[6]	=>  Location: PIN_H21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[7]	=>  Location: PIN_G21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[8]	=>  Location: PIN_M23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[9]	=>  Location: PIN_P21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[10]	=>  Location: PIN_L27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[11]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[12]	=>  Location: PIN_H19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[13]	=>  Location: PIN_J17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[14]	=>  Location: PIN_A19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr[15]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr_wr	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- busy	=>  Location: PIN_G22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[0]	=>  Location: PIN_J28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[0]	=>  Location: PIN_J27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- gfx_instr_full	=>  Location: PIN_B26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[1]	=>  Location: PIN_N21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[1]	=>  Location: PIN_M24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[2]	=>  Location: PIN_G15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[2]	=>  Location: PIN_H16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[3]	=>  Location: PIN_D16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[3]	=>  Location: PIN_G18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[4]	=>  Location: PIN_M27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[4]	=>  Location: PIN_P27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[5]	=>  Location: PIN_M28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[5]	=>  Location: PIN_P25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[6]	=>  Location: PIN_B19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[6]	=>  Location: PIN_G20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[7]	=>  Location: PIN_G17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[7]	=>  Location: PIN_B18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[8]	=>  Location: PIN_N25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[8]	=>  Location: PIN_M25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[9]	=>  Location: PIN_P26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[9]	=>  Location: PIN_M26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[10]	=>  Location: PIN_N26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[10]	=>  Location: PIN_P28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[11]	=>  Location: PIN_L28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[11]	=>  Location: PIN_K27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[12]	=>  Location: PIN_D20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[12]	=>  Location: PIN_J19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[13]	=>  Location: PIN_C19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[13]	=>  Location: PIN_C17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[14]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[14]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y[15]	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- x[15]	=>  Location: PIN_G19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_Y2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- res_n	=>  Location: PIN_Y1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- start	=>  Location: PIN_G16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[15]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[14]	=>  Location: PIN_AB16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[12]	=>  Location: PIN_AF17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[11]	=>  Location: PIN_AA15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[7]	=>  Location: PIN_AE17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[6]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[5]	=>  Location: PIN_AA16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[4]	=>  Location: PIN_AF16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[10]	=>  Location: PIN_F17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[9]	=>  Location: PIN_H17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[8]	=>  Location: PIN_AB15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[13]	=>  Location: PIN_AE16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[3]	=>  Location: PIN_H15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[2]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[1]	=>  Location: PIN_J15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- number[0]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF precompiled_decimal_printer IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_res_n : std_logic;
SIGNAL ww_gfx_instr : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_gfx_instr_wr : std_logic;
SIGNAL ww_gfx_instr_full : std_logic;
SIGNAL ww_start : std_logic;
SIGNAL ww_busy : std_logic;
SIGNAL ww_x : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_y : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_number : std_logic_vector(15 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \res_n~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \gfx_instr[0]~output_o\ : std_logic;
SIGNAL \gfx_instr[1]~output_o\ : std_logic;
SIGNAL \gfx_instr[2]~output_o\ : std_logic;
SIGNAL \gfx_instr[3]~output_o\ : std_logic;
SIGNAL \gfx_instr[4]~output_o\ : std_logic;
SIGNAL \gfx_instr[5]~output_o\ : std_logic;
SIGNAL \gfx_instr[6]~output_o\ : std_logic;
SIGNAL \gfx_instr[7]~output_o\ : std_logic;
SIGNAL \gfx_instr[8]~output_o\ : std_logic;
SIGNAL \gfx_instr[9]~output_o\ : std_logic;
SIGNAL \gfx_instr[10]~output_o\ : std_logic;
SIGNAL \gfx_instr[11]~output_o\ : std_logic;
SIGNAL \gfx_instr[12]~output_o\ : std_logic;
SIGNAL \gfx_instr[13]~output_o\ : std_logic;
SIGNAL \gfx_instr[14]~output_o\ : std_logic;
SIGNAL \gfx_instr[15]~output_o\ : std_logic;
SIGNAL \gfx_instr_wr~output_o\ : std_logic;
SIGNAL \busy~output_o\ : std_logic;
SIGNAL \gfx_instr_full~input_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \start~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector0~0_combout\ : std_logic;
SIGNAL \res_n~input_o\ : std_logic;
SIGNAL \res_n~inputclkctrl_outclk\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.IDLE~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector10~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.leading_zero~q\ : std_logic;
SIGNAL \number[0]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[0]~19_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector45~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector1~8_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~19_combout\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan3~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan3~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~20_combout\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan2~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan2~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[14]~5_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~11\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~13\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~15\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~17\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~18_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~1\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~3\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~5\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~7\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~9\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~11\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~13\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~14_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector15~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~15\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~16_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~18_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~0_combout\ : std_logic;
SIGNAL \number[1]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[1]~17_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[1]~18_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~1\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~3\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~5\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~7\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~9\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~11\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~13\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~15\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~17\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~19\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~20_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector15~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[11]~feeder_combout\ : std_logic;
SIGNAL \number[11]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[14]~20_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~17\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~18_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~15\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~16_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~19\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~20_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~21\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~22_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector14~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector14~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[12]~feeder_combout\ : std_logic;
SIGNAL \number[12]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan0~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~21\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~22_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~17\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~18_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~19\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~20_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector13~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~23\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~24_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector13~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[13]~feeder_combout\ : std_logic;
SIGNAL \number[13]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~25\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~26_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~23\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~24_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector12~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~19\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~20_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~21\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~22_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector12~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[14]~feeder_combout\ : std_logic;
SIGNAL \number[14]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~23\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~24_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~25\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~26_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~21\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~22_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector11~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~27\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~28_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector11~1_combout\ : std_logic;
SIGNAL \number[15]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[15]~6_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[15]~7_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~13_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~14_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~15_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[2]~15_combout\ : std_logic;
SIGNAL \number[2]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[2]~13_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[2]~14_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[2]~16_combout\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan3~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan3~3_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[3]~8_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[3]~9_combout\ : std_logic;
SIGNAL \number[3]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~1\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[3]~10_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[3]~21_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[3]~11_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[3]~12_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~1\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~3\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector22~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~6_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector22~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[4]~feeder_combout\ : std_logic;
SIGNAL \number[4]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan1~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan1~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~16_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~5\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~6_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~8_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector21~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~3\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector21~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[5]~feeder_combout\ : std_logic;
SIGNAL \number[5]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~5\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~6_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~7\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~8_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~10_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector20~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector20~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[6]~feeder_combout\ : std_logic;
SIGNAL \number[6]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~9\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~10_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~6_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector19~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~7\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~8_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~12_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector19~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[7]~feeder_combout\ : std_logic;
SIGNAL \number[7]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~9\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~10_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~8_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~12_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~14_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector18~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector18~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[8]~feeder_combout\ : std_logic;
SIGNAL \number[8]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~11\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~12_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~14_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~10_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector17~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~16_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector17~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[9]~feeder_combout\ : std_logic;
SIGNAL \number[9]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~13\ : std_logic;
SIGNAL \decimal_printer_inst|Add3~14_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add7~18_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add5~16_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector16~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add1~12_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector16~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[10]~feeder_combout\ : std_logic;
SIGNAL \number[10]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|LessThan0~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.number[14]~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state_nxt~17_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[4][3]~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[0][3]~6_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[0][0]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector41~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[1][3]~5_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[1][0]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector37~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[2][0]~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[2][0]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector44~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[0][1]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector40~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector40~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[1][1]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector36~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector36~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[2][1]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector32~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector33~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[3][2]~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[3][2]~3_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[3][0]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector32~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[3][1]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector28~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector29~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[4][3]~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[4][0]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector28~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[4][1]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector27~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector31~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector35~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector43~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[0][2]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector39~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector39~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[1][2]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector35~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[2][2]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector31~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[3][2]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector27~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[4][2]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Add0~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add4~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add6~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector42~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[0][3]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector38~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[1][3]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector34~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[2][3]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Add2~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector30~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[3][3]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector26~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.bcd_data[4][3]~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector6~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector6~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector7~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector1~5_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector7~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector7~3_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.BB~q\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.BB_DATA~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector6~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.MOVE_X~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector9~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ : std_logic;
SIGNAL \decimal_printer_inst|state.digit_cnt[0]~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.digit_cnt[2]~5_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.digit_cnt[1]~3_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Add8~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.digit_cnt[2]~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Equal1~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector5~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector1~4_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector1~7_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector1~9_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ : std_logic;
SIGNAL \decimal_printer_inst|Selector1~6_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector2~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.SET_GP~q\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.SET_GP_X~q\ : std_logic;
SIGNAL \decimal_printer_inst|state.fsm_state.SET_GP_y~q\ : std_logic;
SIGNAL \y[0]~input_o\ : std_logic;
SIGNAL \x[0]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector65~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector65~1_combout\ : std_logic;
SIGNAL \y[1]~input_o\ : std_logic;
SIGNAL \x[1]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector64~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector64~1_combout\ : std_logic;
SIGNAL \x[2]~input_o\ : std_logic;
SIGNAL \y[2]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector63~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector63~4_combout\ : std_logic;
SIGNAL \x[3]~input_o\ : std_logic;
SIGNAL \y[3]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector62~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector63~3_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector62~1_combout\ : std_logic;
SIGNAL \y[4]~input_o\ : std_logic;
SIGNAL \x[4]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector61~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector61~1_combout\ : std_logic;
SIGNAL \y[5]~input_o\ : std_logic;
SIGNAL \x[5]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector60~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector60~1_combout\ : std_logic;
SIGNAL \x[6]~input_o\ : std_logic;
SIGNAL \y[6]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector59~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector59~1_combout\ : std_logic;
SIGNAL \x[7]~input_o\ : std_logic;
SIGNAL \y[7]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector58~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector58~1_combout\ : std_logic;
SIGNAL \x[8]~input_o\ : std_logic;
SIGNAL \y[8]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector57~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector57~1_combout\ : std_logic;
SIGNAL \x[9]~input_o\ : std_logic;
SIGNAL \y[9]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector56~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector56~1_combout\ : std_logic;
SIGNAL \y[10]~input_o\ : std_logic;
SIGNAL \x[10]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector55~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector55~1_combout\ : std_logic;
SIGNAL \x[11]~input_o\ : std_logic;
SIGNAL \y[11]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector54~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector54~1_combout\ : std_logic;
SIGNAL \y[12]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector53~0_combout\ : std_logic;
SIGNAL \x[12]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector53~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector53~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector51~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector51~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector51~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector52~1_combout\ : std_logic;
SIGNAL \x[13]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector52~0_combout\ : std_logic;
SIGNAL \y[13]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector52~combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector51~4_combout\ : std_logic;
SIGNAL \x[14]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector51~3_combout\ : std_logic;
SIGNAL \y[14]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector51~combout\ : std_logic;
SIGNAL \y[15]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector50~0_combout\ : std_logic;
SIGNAL \x[15]~input_o\ : std_logic;
SIGNAL \decimal_printer_inst|Selector50~1_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector50~2_combout\ : std_logic;
SIGNAL \decimal_printer_inst|Selector49~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|state.digit_cnt\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \decimal_printer_inst|state.number\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \decimal_printer_inst|ALT_INV_Selector49~0_combout\ : std_logic;
SIGNAL \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\ : std_logic;
SIGNAL \ALT_INV_gfx_instr_full~input_o\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_clk <= clk;
ww_res_n <= res_n;
gfx_instr <= ww_gfx_instr;
gfx_instr_wr <= ww_gfx_instr_wr;
ww_gfx_instr_full <= gfx_instr_full;
ww_start <= start;
busy <= ww_busy;
ww_x <= x;
ww_y <= y;
ww_number <= number;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

\res_n~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \res_n~input_o\);
\decimal_printer_inst|ALT_INV_Selector49~0_combout\ <= NOT \decimal_printer_inst|Selector49~0_combout\;
\decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\ <= NOT \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\;
\ALT_INV_gfx_instr_full~input_o\ <= NOT \gfx_instr_full~input_o\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X115_Y49_N9
\gfx_instr[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector65~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[0]~output_o\);

-- Location: IOOBUF_X115_Y49_N2
\gfx_instr[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector64~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[1]~output_o\);

-- Location: IOOBUF_X65_Y73_N16
\gfx_instr[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector63~4_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[2]~output_o\);

-- Location: IOOBUF_X62_Y73_N16
\gfx_instr[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector62~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[3]~output_o\);

-- Location: IOOBUF_X115_Y48_N2
\gfx_instr[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector61~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[4]~output_o\);

-- Location: IOOBUF_X115_Y36_N9
\gfx_instr[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector60~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[5]~output_o\);

-- Location: IOOBUF_X72_Y73_N16
\gfx_instr[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector59~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[6]~output_o\);

-- Location: IOOBUF_X74_Y73_N23
\gfx_instr[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector58~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[7]~output_o\);

-- Location: IOOBUF_X115_Y40_N9
\gfx_instr[8]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector57~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[8]~output_o\);

-- Location: IOOBUF_X115_Y36_N2
\gfx_instr[9]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector56~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[9]~output_o\);

-- Location: IOOBUF_X115_Y48_N9
\gfx_instr[10]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector55~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[10]~output_o\);

-- Location: IOOBUF_X115_Y36_N16
\gfx_instr[11]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector54~1_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[11]~output_o\);

-- Location: IOOBUF_X72_Y73_N2
\gfx_instr[12]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector53~2_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[12]~output_o\);

-- Location: IOOBUF_X69_Y73_N2
\gfx_instr[13]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector52~combout\,
	devoe => ww_devoe,
	o => \gfx_instr[13]~output_o\);

-- Location: IOOBUF_X81_Y73_N16
\gfx_instr[14]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector51~combout\,
	devoe => ww_devoe,
	o => \gfx_instr[14]~output_o\);

-- Location: IOOBUF_X60_Y73_N9
\gfx_instr[15]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|Selector50~2_combout\,
	devoe => ww_devoe,
	o => \gfx_instr[15]~output_o\);

-- Location: IOOBUF_X60_Y73_N2
\gfx_instr_wr~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|ALT_INV_Selector49~0_combout\,
	devoe => ww_devoe,
	o => \gfx_instr_wr~output_o\);

-- Location: IOOBUF_X72_Y73_N23
\busy~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	devoe => ww_devoe,
	o => \busy~output_o\);

-- Location: IOIBUF_X113_Y73_N8
\gfx_instr_full~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_gfx_instr_full,
	o => \gfx_instr_full~input_o\);

-- Location: IOIBUF_X0_Y36_N15
\clk~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G4
\clk~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: IOIBUF_X67_Y73_N1
\start~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_start,
	o => \start~input_o\);

-- Location: LCCOMB_X66_Y69_N2
\decimal_printer_inst|Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector0~0_combout\ = (\start~input_o\ & (((!\decimal_printer_inst|Equal1~0_combout\)) # (!\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\))) # (!\start~input_o\ & (\decimal_printer_inst|state.fsm_state.IDLE~q\ & 
-- ((!\decimal_printer_inst|Equal1~0_combout\) # (!\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \decimal_printer_inst|Equal1~0_combout\,
	combout => \decimal_printer_inst|Selector0~0_combout\);

-- Location: IOIBUF_X0_Y36_N22
\res_n~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_res_n,
	o => \res_n~input_o\);

-- Location: CLKCTRL_G3
\res_n~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \res_n~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \res_n~inputclkctrl_outclk\);

-- Location: FF_X66_Y69_N3
\decimal_printer_inst|state.fsm_state.IDLE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector0~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.IDLE~q\);

-- Location: LCCOMB_X66_Y69_N20
\decimal_printer_inst|Selector10~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector10~0_combout\ = (\decimal_printer_inst|state.fsm_state.IDLE~q\ & (((\decimal_printer_inst|state.leading_zero~q\) # (\decimal_printer_inst|state.fsm_state.BB~q\)))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & 
-- (!\start~input_o\ & (\decimal_printer_inst|state.leading_zero~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datac => \decimal_printer_inst|state.leading_zero~q\,
	datad => \decimal_printer_inst|state.fsm_state.BB~q\,
	combout => \decimal_printer_inst|Selector10~0_combout\);

-- Location: FF_X66_Y69_N21
\decimal_printer_inst|state.leading_zero\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector10~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.leading_zero~q\);

-- Location: IOIBUF_X58_Y73_N22
\number[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(0),
	o => \number[0]~input_o\);

-- Location: LCCOMB_X65_Y45_N10
\decimal_printer_inst|state.number[0]~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[0]~19_combout\ = (\decimal_printer_inst|state.fsm_state.IDLE~q\ & (((\decimal_printer_inst|state.number\(0))))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & ((\start~input_o\ & (\number[0]~input_o\)) # 
-- (!\start~input_o\ & ((\decimal_printer_inst|state.number\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \number[0]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datac => \decimal_printer_inst|state.number\(0),
	datad => \start~input_o\,
	combout => \decimal_printer_inst|state.number[0]~19_combout\);

-- Location: FF_X65_Y45_N11
\decimal_printer_inst|state.number[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[0]~19_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(0));

-- Location: LCCOMB_X65_Y45_N0
\decimal_printer_inst|Selector45~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector45~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & \decimal_printer_inst|state.number\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.number\(0),
	combout => \decimal_printer_inst|Selector45~0_combout\);

-- Location: LCCOMB_X66_Y69_N26
\decimal_printer_inst|Selector1~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector1~8_combout\ = (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & \start~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datac => \start~input_o\,
	combout => \decimal_printer_inst|Selector1~8_combout\);

-- Location: LCCOMB_X65_Y42_N12
\decimal_printer_inst|state_nxt~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~19_combout\ = (\decimal_printer_inst|state.fsm_state.IDLE~q\ & (\decimal_printer_inst|state.number[14]~4_combout\ & (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ 
-- & (((\start~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~4_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \start~input_o\,
	combout => \decimal_printer_inst|state_nxt~19_combout\);

-- Location: LCCOMB_X66_Y40_N10
\decimal_printer_inst|LessThan3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan3~1_combout\ = (!\decimal_printer_inst|state.number\(9) & !\decimal_printer_inst|state.number\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(9),
	datad => \decimal_printer_inst|state.number\(8),
	combout => \decimal_printer_inst|LessThan3~1_combout\);

-- Location: LCCOMB_X66_Y39_N28
\decimal_printer_inst|LessThan3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan3~0_combout\ = (!\decimal_printer_inst|state.number\(7) & (!\decimal_printer_inst|state.number\(5) & (!\decimal_printer_inst|state.number\(6) & !\decimal_printer_inst|state.number\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(7),
	datab => \decimal_printer_inst|state.number\(5),
	datac => \decimal_printer_inst|state.number\(6),
	datad => \decimal_printer_inst|state.number\(4),
	combout => \decimal_printer_inst|LessThan3~0_combout\);

-- Location: LCCOMB_X65_Y45_N22
\decimal_printer_inst|state_nxt~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~20_combout\ = (\decimal_printer_inst|state.fsm_state.IDLE~q\ & (((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & \decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & 
-- (\start~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|state_nxt~20_combout\);

-- Location: LCCOMB_X65_Y40_N26
\decimal_printer_inst|LessThan2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan2~1_combout\ = (!\decimal_printer_inst|state.number\(7) & ((!\decimal_printer_inst|state.number\(5)) # (!\decimal_printer_inst|state.number\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(7),
	datac => \decimal_printer_inst|state.number\(6),
	datad => \decimal_printer_inst|state.number\(5),
	combout => \decimal_printer_inst|LessThan2~1_combout\);

-- Location: LCCOMB_X66_Y41_N0
\decimal_printer_inst|LessThan2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan2~0_combout\ = (!\decimal_printer_inst|state.number\(3) & (!\decimal_printer_inst|state.number\(2) & (!\decimal_printer_inst|state.number\(7) & !\decimal_printer_inst|state.number\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(3),
	datab => \decimal_printer_inst|state.number\(2),
	datac => \decimal_printer_inst|state.number\(7),
	datad => \decimal_printer_inst|state.number\(4),
	combout => \decimal_printer_inst|LessThan2~0_combout\);

-- Location: LCCOMB_X65_Y42_N26
\decimal_printer_inst|state.number[14]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[14]~5_combout\ = (\decimal_printer_inst|LessThan1~1_combout\ & ((\decimal_printer_inst|state_nxt~14_combout\ & ((\decimal_printer_inst|state_nxt~15_combout\))) # (!\decimal_printer_inst|state_nxt~14_combout\ & 
-- (\decimal_printer_inst|state.number[14]~4_combout\)))) # (!\decimal_printer_inst|LessThan1~1_combout\ & (\decimal_printer_inst|state.number[14]~4_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~4_combout\,
	datab => \decimal_printer_inst|state_nxt~15_combout\,
	datac => \decimal_printer_inst|LessThan1~1_combout\,
	datad => \decimal_printer_inst|state_nxt~14_combout\,
	combout => \decimal_printer_inst|state.number[14]~5_combout\);

-- Location: LCCOMB_X65_Y41_N14
\decimal_printer_inst|Add5~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~10_combout\ = (\decimal_printer_inst|state.number\(7) & (\decimal_printer_inst|Add5~9\ & VCC)) # (!\decimal_printer_inst|state.number\(7) & (!\decimal_printer_inst|Add5~9\))
-- \decimal_printer_inst|Add5~11\ = CARRY((!\decimal_printer_inst|state.number\(7) & !\decimal_printer_inst|Add5~9\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(7),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~9\,
	combout => \decimal_printer_inst|Add5~10_combout\,
	cout => \decimal_printer_inst|Add5~11\);

-- Location: LCCOMB_X65_Y41_N16
\decimal_printer_inst|Add5~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~12_combout\ = (\decimal_printer_inst|state.number\(8) & ((GND) # (!\decimal_printer_inst|Add5~11\))) # (!\decimal_printer_inst|state.number\(8) & (\decimal_printer_inst|Add5~11\ $ (GND)))
-- \decimal_printer_inst|Add5~13\ = CARRY((\decimal_printer_inst|state.number\(8)) # (!\decimal_printer_inst|Add5~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(8),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~11\,
	combout => \decimal_printer_inst|Add5~12_combout\,
	cout => \decimal_printer_inst|Add5~13\);

-- Location: LCCOMB_X65_Y41_N18
\decimal_printer_inst|Add5~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~14_combout\ = (\decimal_printer_inst|state.number\(9) & (\decimal_printer_inst|Add5~13\ & VCC)) # (!\decimal_printer_inst|state.number\(9) & (!\decimal_printer_inst|Add5~13\))
-- \decimal_printer_inst|Add5~15\ = CARRY((!\decimal_printer_inst|state.number\(9) & !\decimal_printer_inst|Add5~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(9),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~13\,
	combout => \decimal_printer_inst|Add5~14_combout\,
	cout => \decimal_printer_inst|Add5~15\);

-- Location: LCCOMB_X65_Y41_N20
\decimal_printer_inst|Add5~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~16_combout\ = (\decimal_printer_inst|state.number\(10) & ((GND) # (!\decimal_printer_inst|Add5~15\))) # (!\decimal_printer_inst|state.number\(10) & (\decimal_printer_inst|Add5~15\ $ (GND)))
-- \decimal_printer_inst|Add5~17\ = CARRY((\decimal_printer_inst|state.number\(10)) # (!\decimal_printer_inst|Add5~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010101111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(10),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~15\,
	combout => \decimal_printer_inst|Add5~16_combout\,
	cout => \decimal_printer_inst|Add5~17\);

-- Location: LCCOMB_X65_Y41_N22
\decimal_printer_inst|Add5~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~18_combout\ = (\decimal_printer_inst|state.number\(11) & (\decimal_printer_inst|Add5~17\ & VCC)) # (!\decimal_printer_inst|state.number\(11) & (!\decimal_printer_inst|Add5~17\))
-- \decimal_printer_inst|Add5~19\ = CARRY((!\decimal_printer_inst|state.number\(11) & !\decimal_printer_inst|Add5~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(11),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~17\,
	combout => \decimal_printer_inst|Add5~18_combout\,
	cout => \decimal_printer_inst|Add5~19\);

-- Location: LCCOMB_X65_Y39_N4
\decimal_printer_inst|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~0_combout\ = \decimal_printer_inst|state.number\(4) $ (VCC)
-- \decimal_printer_inst|Add1~1\ = CARRY(\decimal_printer_inst|state.number\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(4),
	datad => VCC,
	combout => \decimal_printer_inst|Add1~0_combout\,
	cout => \decimal_printer_inst|Add1~1\);

-- Location: LCCOMB_X65_Y39_N6
\decimal_printer_inst|Add1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~2_combout\ = (\decimal_printer_inst|state.number\(5) & (\decimal_printer_inst|Add1~1\ & VCC)) # (!\decimal_printer_inst|state.number\(5) & (!\decimal_printer_inst|Add1~1\))
-- \decimal_printer_inst|Add1~3\ = CARRY((!\decimal_printer_inst|state.number\(5) & !\decimal_printer_inst|Add1~1\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(5),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~1\,
	combout => \decimal_printer_inst|Add1~2_combout\,
	cout => \decimal_printer_inst|Add1~3\);

-- Location: LCCOMB_X65_Y39_N8
\decimal_printer_inst|Add1~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~4_combout\ = (\decimal_printer_inst|state.number\(6) & ((GND) # (!\decimal_printer_inst|Add1~3\))) # (!\decimal_printer_inst|state.number\(6) & (\decimal_printer_inst|Add1~3\ $ (GND)))
-- \decimal_printer_inst|Add1~5\ = CARRY((\decimal_printer_inst|state.number\(6)) # (!\decimal_printer_inst|Add1~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010101111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(6),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~3\,
	combout => \decimal_printer_inst|Add1~4_combout\,
	cout => \decimal_printer_inst|Add1~5\);

-- Location: LCCOMB_X65_Y39_N10
\decimal_printer_inst|Add1~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~6_combout\ = (\decimal_printer_inst|state.number\(7) & (\decimal_printer_inst|Add1~5\ & VCC)) # (!\decimal_printer_inst|state.number\(7) & (!\decimal_printer_inst|Add1~5\))
-- \decimal_printer_inst|Add1~7\ = CARRY((!\decimal_printer_inst|state.number\(7) & !\decimal_printer_inst|Add1~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(7),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~5\,
	combout => \decimal_printer_inst|Add1~6_combout\,
	cout => \decimal_printer_inst|Add1~7\);

-- Location: LCCOMB_X65_Y39_N12
\decimal_printer_inst|Add1~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~8_combout\ = (\decimal_printer_inst|state.number\(8) & (\decimal_printer_inst|Add1~7\ $ (GND))) # (!\decimal_printer_inst|state.number\(8) & (!\decimal_printer_inst|Add1~7\ & VCC))
-- \decimal_printer_inst|Add1~9\ = CARRY((\decimal_printer_inst|state.number\(8) & !\decimal_printer_inst|Add1~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(8),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~7\,
	combout => \decimal_printer_inst|Add1~8_combout\,
	cout => \decimal_printer_inst|Add1~9\);

-- Location: LCCOMB_X65_Y39_N14
\decimal_printer_inst|Add1~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~10_combout\ = (\decimal_printer_inst|state.number\(9) & (!\decimal_printer_inst|Add1~9\)) # (!\decimal_printer_inst|state.number\(9) & ((\decimal_printer_inst|Add1~9\) # (GND)))
-- \decimal_printer_inst|Add1~11\ = CARRY((!\decimal_printer_inst|Add1~9\) # (!\decimal_printer_inst|state.number\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(9),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~9\,
	combout => \decimal_printer_inst|Add1~10_combout\,
	cout => \decimal_printer_inst|Add1~11\);

-- Location: LCCOMB_X65_Y39_N16
\decimal_printer_inst|Add1~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~12_combout\ = (\decimal_printer_inst|state.number\(10) & (\decimal_printer_inst|Add1~11\ $ (GND))) # (!\decimal_printer_inst|state.number\(10) & (!\decimal_printer_inst|Add1~11\ & VCC))
-- \decimal_printer_inst|Add1~13\ = CARRY((\decimal_printer_inst|state.number\(10) & !\decimal_printer_inst|Add1~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(10),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~11\,
	combout => \decimal_printer_inst|Add1~12_combout\,
	cout => \decimal_printer_inst|Add1~13\);

-- Location: LCCOMB_X65_Y39_N18
\decimal_printer_inst|Add1~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~14_combout\ = (\decimal_printer_inst|state.number\(11) & (\decimal_printer_inst|Add1~13\ & VCC)) # (!\decimal_printer_inst|state.number\(11) & (!\decimal_printer_inst|Add1~13\))
-- \decimal_printer_inst|Add1~15\ = CARRY((!\decimal_printer_inst|state.number\(11) & !\decimal_printer_inst|Add1~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(11),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~13\,
	combout => \decimal_printer_inst|Add1~14_combout\,
	cout => \decimal_printer_inst|Add1~15\);

-- Location: LCCOMB_X66_Y40_N4
\decimal_printer_inst|Selector15~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector15~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & (((!\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|state_nxt~16_combout\ & 
-- (\decimal_printer_inst|Add5~18_combout\)) # (!\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|Add1~14_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add5~18_combout\,
	datab => \decimal_printer_inst|Add1~14_combout\,
	datac => \decimal_printer_inst|state.number[14]~5_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|Selector15~0_combout\);

-- Location: LCCOMB_X65_Y40_N14
\decimal_printer_inst|Add3~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~14_combout\ = (\decimal_printer_inst|state.number\(10) & (\decimal_printer_inst|Add3~13\ & VCC)) # (!\decimal_printer_inst|state.number\(10) & (!\decimal_printer_inst|Add3~13\))
-- \decimal_printer_inst|Add3~15\ = CARRY((!\decimal_printer_inst|state.number\(10) & !\decimal_printer_inst|Add3~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(10),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~13\,
	combout => \decimal_printer_inst|Add3~14_combout\,
	cout => \decimal_printer_inst|Add3~15\);

-- Location: LCCOMB_X65_Y40_N16
\decimal_printer_inst|Add3~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~16_combout\ = (\decimal_printer_inst|state.number\(11) & ((GND) # (!\decimal_printer_inst|Add3~15\))) # (!\decimal_printer_inst|state.number\(11) & (\decimal_printer_inst|Add3~15\ $ (GND)))
-- \decimal_printer_inst|Add3~17\ = CARRY((\decimal_printer_inst|state.number\(11)) # (!\decimal_printer_inst|Add3~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(11),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~15\,
	combout => \decimal_printer_inst|Add3~16_combout\,
	cout => \decimal_printer_inst|Add3~17\);

-- Location: LCCOMB_X65_Y45_N30
\decimal_printer_inst|state_nxt~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~18_combout\ = (!\decimal_printer_inst|LessThan3~3_combout\ & (\decimal_printer_inst|state_nxt~15_combout\ & (\decimal_printer_inst|state.fsm_state.IDLE~q\ & \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan3~3_combout\,
	datab => \decimal_printer_inst|state_nxt~15_combout\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	combout => \decimal_printer_inst|state_nxt~18_combout\);

-- Location: LCCOMB_X66_Y41_N2
\decimal_printer_inst|Add7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~0_combout\ = \decimal_printer_inst|state.number\(1) $ (VCC)
-- \decimal_printer_inst|Add7~1\ = CARRY(\decimal_printer_inst|state.number\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(1),
	datad => VCC,
	combout => \decimal_printer_inst|Add7~0_combout\,
	cout => \decimal_printer_inst|Add7~1\);

-- Location: IOIBUF_X60_Y73_N22
\number[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(1),
	o => \number[1]~input_o\);

-- Location: LCCOMB_X65_Y45_N20
\decimal_printer_inst|state.number[1]~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[1]~17_combout\ = (\decimal_printer_inst|state.fsm_state.IDLE~q\ & (\decimal_printer_inst|Add7~0_combout\)) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & ((\number[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add7~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datac => \number[1]~input_o\,
	combout => \decimal_printer_inst|state.number[1]~17_combout\);

-- Location: LCCOMB_X65_Y45_N2
\decimal_printer_inst|state.number[1]~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[1]~18_combout\ = (\decimal_printer_inst|state_nxt~18_combout\ & (\decimal_printer_inst|state.number[1]~17_combout\)) # (!\decimal_printer_inst|state_nxt~18_combout\ & ((\decimal_printer_inst|Selector1~8_combout\ & 
-- (\decimal_printer_inst|state.number[1]~17_combout\)) # (!\decimal_printer_inst|Selector1~8_combout\ & ((\decimal_printer_inst|state.number\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~18_combout\,
	datab => \decimal_printer_inst|state.number[1]~17_combout\,
	datac => \decimal_printer_inst|state.number\(1),
	datad => \decimal_printer_inst|Selector1~8_combout\,
	combout => \decimal_printer_inst|state.number[1]~18_combout\);

-- Location: FF_X65_Y45_N3
\decimal_printer_inst|state.number[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[1]~18_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(1));

-- Location: LCCOMB_X66_Y41_N4
\decimal_printer_inst|Add7~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~2_combout\ = (\decimal_printer_inst|state.number\(2) & (\decimal_printer_inst|Add7~1\ & VCC)) # (!\decimal_printer_inst|state.number\(2) & (!\decimal_printer_inst|Add7~1\))
-- \decimal_printer_inst|Add7~3\ = CARRY((!\decimal_printer_inst|state.number\(2) & !\decimal_printer_inst|Add7~1\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(2),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~1\,
	combout => \decimal_printer_inst|Add7~2_combout\,
	cout => \decimal_printer_inst|Add7~3\);

-- Location: LCCOMB_X66_Y41_N6
\decimal_printer_inst|Add7~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~4_combout\ = (\decimal_printer_inst|state.number\(3) & (\decimal_printer_inst|Add7~3\ $ (GND))) # (!\decimal_printer_inst|state.number\(3) & (!\decimal_printer_inst|Add7~3\ & VCC))
-- \decimal_printer_inst|Add7~5\ = CARRY((\decimal_printer_inst|state.number\(3) & !\decimal_printer_inst|Add7~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(3),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~3\,
	combout => \decimal_printer_inst|Add7~4_combout\,
	cout => \decimal_printer_inst|Add7~5\);

-- Location: LCCOMB_X66_Y41_N8
\decimal_printer_inst|Add7~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~6_combout\ = (\decimal_printer_inst|state.number\(4) & (\decimal_printer_inst|Add7~5\ & VCC)) # (!\decimal_printer_inst|state.number\(4) & (!\decimal_printer_inst|Add7~5\))
-- \decimal_printer_inst|Add7~7\ = CARRY((!\decimal_printer_inst|state.number\(4) & !\decimal_printer_inst|Add7~5\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(4),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~5\,
	combout => \decimal_printer_inst|Add7~6_combout\,
	cout => \decimal_printer_inst|Add7~7\);

-- Location: LCCOMB_X66_Y41_N10
\decimal_printer_inst|Add7~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~8_combout\ = (\decimal_printer_inst|state.number\(5) & ((GND) # (!\decimal_printer_inst|Add7~7\))) # (!\decimal_printer_inst|state.number\(5) & (\decimal_printer_inst|Add7~7\ $ (GND)))
-- \decimal_printer_inst|Add7~9\ = CARRY((\decimal_printer_inst|state.number\(5)) # (!\decimal_printer_inst|Add7~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(5),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~7\,
	combout => \decimal_printer_inst|Add7~8_combout\,
	cout => \decimal_printer_inst|Add7~9\);

-- Location: LCCOMB_X66_Y41_N12
\decimal_printer_inst|Add7~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~10_combout\ = (\decimal_printer_inst|state.number\(6) & (\decimal_printer_inst|Add7~9\ & VCC)) # (!\decimal_printer_inst|state.number\(6) & (!\decimal_printer_inst|Add7~9\))
-- \decimal_printer_inst|Add7~11\ = CARRY((!\decimal_printer_inst|state.number\(6) & !\decimal_printer_inst|Add7~9\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(6),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~9\,
	combout => \decimal_printer_inst|Add7~10_combout\,
	cout => \decimal_printer_inst|Add7~11\);

-- Location: LCCOMB_X66_Y41_N14
\decimal_printer_inst|Add7~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~12_combout\ = (\decimal_printer_inst|state.number\(7) & ((GND) # (!\decimal_printer_inst|Add7~11\))) # (!\decimal_printer_inst|state.number\(7) & (\decimal_printer_inst|Add7~11\ $ (GND)))
-- \decimal_printer_inst|Add7~13\ = CARRY((\decimal_printer_inst|state.number\(7)) # (!\decimal_printer_inst|Add7~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(7),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~11\,
	combout => \decimal_printer_inst|Add7~12_combout\,
	cout => \decimal_printer_inst|Add7~13\);

-- Location: LCCOMB_X66_Y41_N16
\decimal_printer_inst|Add7~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~14_combout\ = (\decimal_printer_inst|state.number\(8) & (\decimal_printer_inst|Add7~13\ & VCC)) # (!\decimal_printer_inst|state.number\(8) & (!\decimal_printer_inst|Add7~13\))
-- \decimal_printer_inst|Add7~15\ = CARRY((!\decimal_printer_inst|state.number\(8) & !\decimal_printer_inst|Add7~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(8),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~13\,
	combout => \decimal_printer_inst|Add7~14_combout\,
	cout => \decimal_printer_inst|Add7~15\);

-- Location: LCCOMB_X66_Y41_N18
\decimal_printer_inst|Add7~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~16_combout\ = (\decimal_printer_inst|state.number\(9) & ((GND) # (!\decimal_printer_inst|Add7~15\))) # (!\decimal_printer_inst|state.number\(9) & (\decimal_printer_inst|Add7~15\ $ (GND)))
-- \decimal_printer_inst|Add7~17\ = CARRY((\decimal_printer_inst|state.number\(9)) # (!\decimal_printer_inst|Add7~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010101111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(9),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~15\,
	combout => \decimal_printer_inst|Add7~16_combout\,
	cout => \decimal_printer_inst|Add7~17\);

-- Location: LCCOMB_X66_Y41_N20
\decimal_printer_inst|Add7~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~18_combout\ = (\decimal_printer_inst|state.number\(10) & (\decimal_printer_inst|Add7~17\ & VCC)) # (!\decimal_printer_inst|state.number\(10) & (!\decimal_printer_inst|Add7~17\))
-- \decimal_printer_inst|Add7~19\ = CARRY((!\decimal_printer_inst|state.number\(10) & !\decimal_printer_inst|Add7~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(10),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~17\,
	combout => \decimal_printer_inst|Add7~18_combout\,
	cout => \decimal_printer_inst|Add7~19\);

-- Location: LCCOMB_X66_Y41_N22
\decimal_printer_inst|Add7~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~20_combout\ = (\decimal_printer_inst|state.number\(11) & ((GND) # (!\decimal_printer_inst|Add7~19\))) # (!\decimal_printer_inst|state.number\(11) & (\decimal_printer_inst|Add7~19\ $ (GND)))
-- \decimal_printer_inst|Add7~21\ = CARRY((\decimal_printer_inst|state.number\(11)) # (!\decimal_printer_inst|Add7~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(11),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~19\,
	combout => \decimal_printer_inst|Add7~20_combout\,
	cout => \decimal_printer_inst|Add7~21\);

-- Location: LCCOMB_X66_Y40_N14
\decimal_printer_inst|Selector15~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector15~1_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|Selector15~0_combout\ & (\decimal_printer_inst|Add3~16_combout\)) # (!\decimal_printer_inst|Selector15~0_combout\ & 
-- ((\decimal_printer_inst|Add7~20_combout\))))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & (\decimal_printer_inst|Selector15~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~5_combout\,
	datab => \decimal_printer_inst|Selector15~0_combout\,
	datac => \decimal_printer_inst|Add3~16_combout\,
	datad => \decimal_printer_inst|Add7~20_combout\,
	combout => \decimal_printer_inst|Selector15~1_combout\);

-- Location: LCCOMB_X66_Y40_N0
\decimal_printer_inst|state.number[11]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[11]~feeder_combout\ = \decimal_printer_inst|Selector15~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|Selector15~1_combout\,
	combout => \decimal_printer_inst|state.number[11]~feeder_combout\);

-- Location: IOIBUF_X67_Y0_N22
\number[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(11),
	o => \number[11]~input_o\);

-- Location: LCCOMB_X65_Y42_N10
\decimal_printer_inst|state.number[14]~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[14]~20_combout\ = (\decimal_printer_inst|LessThan3~3_combout\ & (((!\decimal_printer_inst|state.fsm_state.IDLE~q\ & \start~input_o\)))) # (!\decimal_printer_inst|LessThan3~3_combout\ & 
-- ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\) # ((!\decimal_printer_inst|state.fsm_state.IDLE~q\ & \start~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100111101000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan3~3_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \start~input_o\,
	combout => \decimal_printer_inst|state.number[14]~20_combout\);

-- Location: FF_X66_Y40_N1
\decimal_printer_inst|state.number[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[11]~feeder_combout\,
	asdata => \number[11]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(11));

-- Location: LCCOMB_X65_Y40_N18
\decimal_printer_inst|Add3~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~18_combout\ = (\decimal_printer_inst|state.number\(12) & (\decimal_printer_inst|Add3~17\ & VCC)) # (!\decimal_printer_inst|state.number\(12) & (!\decimal_printer_inst|Add3~17\))
-- \decimal_printer_inst|Add3~19\ = CARRY((!\decimal_printer_inst|state.number\(12) & !\decimal_printer_inst|Add3~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(12),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~17\,
	combout => \decimal_printer_inst|Add3~18_combout\,
	cout => \decimal_printer_inst|Add3~19\);

-- Location: LCCOMB_X65_Y39_N20
\decimal_printer_inst|Add1~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~16_combout\ = (\decimal_printer_inst|state.number\(12) & ((GND) # (!\decimal_printer_inst|Add1~15\))) # (!\decimal_printer_inst|state.number\(12) & (\decimal_printer_inst|Add1~15\ $ (GND)))
-- \decimal_printer_inst|Add1~17\ = CARRY((\decimal_printer_inst|state.number\(12)) # (!\decimal_printer_inst|Add1~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(12),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~15\,
	combout => \decimal_printer_inst|Add1~16_combout\,
	cout => \decimal_printer_inst|Add1~17\);

-- Location: LCCOMB_X65_Y41_N24
\decimal_printer_inst|Add5~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~20_combout\ = (\decimal_printer_inst|state.number\(12) & ((GND) # (!\decimal_printer_inst|Add5~19\))) # (!\decimal_printer_inst|state.number\(12) & (\decimal_printer_inst|Add5~19\ $ (GND)))
-- \decimal_printer_inst|Add5~21\ = CARRY((\decimal_printer_inst|state.number\(12)) # (!\decimal_printer_inst|Add5~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(12),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~19\,
	combout => \decimal_printer_inst|Add5~20_combout\,
	cout => \decimal_printer_inst|Add5~21\);

-- Location: LCCOMB_X66_Y41_N24
\decimal_printer_inst|Add7~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~22_combout\ = (\decimal_printer_inst|state.number\(12) & (\decimal_printer_inst|Add7~21\ & VCC)) # (!\decimal_printer_inst|state.number\(12) & (!\decimal_printer_inst|Add7~21\))
-- \decimal_printer_inst|Add7~23\ = CARRY((!\decimal_printer_inst|state.number\(12) & !\decimal_printer_inst|Add7~21\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(12),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~21\,
	combout => \decimal_printer_inst|Add7~22_combout\,
	cout => \decimal_printer_inst|Add7~23\);

-- Location: LCCOMB_X66_Y39_N18
\decimal_printer_inst|Selector14~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector14~0_combout\ = (\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|Add7~22_combout\))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & 
-- (\decimal_printer_inst|Add5~20_combout\)))) # (!\decimal_printer_inst|state_nxt~16_combout\ & (((\decimal_printer_inst|state.number[14]~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add5~20_combout\,
	datab => \decimal_printer_inst|Add7~22_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|state.number[14]~5_combout\,
	combout => \decimal_printer_inst|Selector14~0_combout\);

-- Location: LCCOMB_X66_Y39_N4
\decimal_printer_inst|Selector14~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector14~1_combout\ = (\decimal_printer_inst|state_nxt~16_combout\ & (((\decimal_printer_inst|Selector14~0_combout\)))) # (!\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|Selector14~0_combout\ & 
-- (\decimal_printer_inst|Add3~18_combout\)) # (!\decimal_printer_inst|Selector14~0_combout\ & ((\decimal_printer_inst|Add1~16_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add3~18_combout\,
	datab => \decimal_printer_inst|Add1~16_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|Selector14~0_combout\,
	combout => \decimal_printer_inst|Selector14~1_combout\);

-- Location: LCCOMB_X66_Y39_N10
\decimal_printer_inst|state.number[12]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[12]~feeder_combout\ = \decimal_printer_inst|Selector14~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|Selector14~1_combout\,
	combout => \decimal_printer_inst|state.number[12]~feeder_combout\);

-- Location: IOIBUF_X67_Y0_N1
\number[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(12),
	o => \number[12]~input_o\);

-- Location: FF_X66_Y39_N11
\decimal_printer_inst|state.number[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[12]~feeder_combout\,
	asdata => \number[12]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(12));

-- Location: LCCOMB_X66_Y42_N10
\decimal_printer_inst|LessThan0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan0~0_combout\ = (!\decimal_printer_inst|state.number\(11) & !\decimal_printer_inst|state.number\(12))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(11),
	datac => \decimal_printer_inst|state.number\(12),
	combout => \decimal_printer_inst|LessThan0~0_combout\);

-- Location: LCCOMB_X65_Y41_N26
\decimal_printer_inst|Add5~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~22_combout\ = (\decimal_printer_inst|state.number\(13) & (\decimal_printer_inst|Add5~21\ & VCC)) # (!\decimal_printer_inst|state.number\(13) & (!\decimal_printer_inst|Add5~21\))
-- \decimal_printer_inst|Add5~23\ = CARRY((!\decimal_printer_inst|state.number\(13) & !\decimal_printer_inst|Add5~21\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(13),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~21\,
	combout => \decimal_printer_inst|Add5~22_combout\,
	cout => \decimal_printer_inst|Add5~23\);

-- Location: LCCOMB_X65_Y39_N22
\decimal_printer_inst|Add1~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~18_combout\ = (\decimal_printer_inst|state.number\(13) & (!\decimal_printer_inst|Add1~17\)) # (!\decimal_printer_inst|state.number\(13) & ((\decimal_printer_inst|Add1~17\) # (GND)))
-- \decimal_printer_inst|Add1~19\ = CARRY((!\decimal_printer_inst|Add1~17\) # (!\decimal_printer_inst|state.number\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(13),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~17\,
	combout => \decimal_printer_inst|Add1~18_combout\,
	cout => \decimal_printer_inst|Add1~19\);

-- Location: LCCOMB_X65_Y40_N20
\decimal_printer_inst|Add3~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~20_combout\ = (\decimal_printer_inst|state.number\(13) & ((GND) # (!\decimal_printer_inst|Add3~19\))) # (!\decimal_printer_inst|state.number\(13) & (\decimal_printer_inst|Add3~19\ $ (GND)))
-- \decimal_printer_inst|Add3~21\ = CARRY((\decimal_printer_inst|state.number\(13)) # (!\decimal_printer_inst|Add3~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(13),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~19\,
	combout => \decimal_printer_inst|Add3~20_combout\,
	cout => \decimal_printer_inst|Add3~21\);

-- Location: LCCOMB_X65_Y39_N28
\decimal_printer_inst|Selector13~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector13~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & (((\decimal_printer_inst|state_nxt~16_combout\) # (\decimal_printer_inst|Add3~20_combout\)))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & 
-- (\decimal_printer_inst|Add1~18_combout\ & (!\decimal_printer_inst|state_nxt~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add1~18_combout\,
	datab => \decimal_printer_inst|state.number[14]~5_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|Add3~20_combout\,
	combout => \decimal_printer_inst|Selector13~0_combout\);

-- Location: LCCOMB_X66_Y41_N26
\decimal_printer_inst|Add7~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~24_combout\ = (\decimal_printer_inst|state.number\(13) & ((GND) # (!\decimal_printer_inst|Add7~23\))) # (!\decimal_printer_inst|state.number\(13) & (\decimal_printer_inst|Add7~23\ $ (GND)))
-- \decimal_printer_inst|Add7~25\ = CARRY((\decimal_printer_inst|state.number\(13)) # (!\decimal_printer_inst|Add7~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(13),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~23\,
	combout => \decimal_printer_inst|Add7~24_combout\,
	cout => \decimal_printer_inst|Add7~25\);

-- Location: LCCOMB_X65_Y39_N30
\decimal_printer_inst|Selector13~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector13~1_combout\ = (\decimal_printer_inst|Selector13~0_combout\ & (((\decimal_printer_inst|Add7~24_combout\) # (!\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|Selector13~0_combout\ & 
-- (\decimal_printer_inst|Add5~22_combout\ & (\decimal_printer_inst|state_nxt~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add5~22_combout\,
	datab => \decimal_printer_inst|Selector13~0_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|Add7~24_combout\,
	combout => \decimal_printer_inst|Selector13~1_combout\);

-- Location: LCCOMB_X65_Y39_N0
\decimal_printer_inst|state.number[13]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[13]~feeder_combout\ = \decimal_printer_inst|Selector13~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector13~1_combout\,
	combout => \decimal_printer_inst|state.number[13]~feeder_combout\);

-- Location: IOIBUF_X65_Y0_N22
\number[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(13),
	o => \number[13]~input_o\);

-- Location: FF_X65_Y39_N1
\decimal_printer_inst|state.number[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[13]~feeder_combout\,
	asdata => \number[13]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(13));

-- Location: LCCOMB_X66_Y41_N28
\decimal_printer_inst|Add7~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~26_combout\ = (\decimal_printer_inst|state.number\(14) & (\decimal_printer_inst|Add7~25\ & VCC)) # (!\decimal_printer_inst|state.number\(14) & (!\decimal_printer_inst|Add7~25\))
-- \decimal_printer_inst|Add7~27\ = CARRY((!\decimal_printer_inst|state.number\(14) & !\decimal_printer_inst|Add7~25\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(14),
	datad => VCC,
	cin => \decimal_printer_inst|Add7~25\,
	combout => \decimal_printer_inst|Add7~26_combout\,
	cout => \decimal_printer_inst|Add7~27\);

-- Location: LCCOMB_X65_Y41_N28
\decimal_printer_inst|Add5~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~24_combout\ = (\decimal_printer_inst|state.number\(14) & ((GND) # (!\decimal_printer_inst|Add5~23\))) # (!\decimal_printer_inst|state.number\(14) & (\decimal_printer_inst|Add5~23\ $ (GND)))
-- \decimal_printer_inst|Add5~25\ = CARRY((\decimal_printer_inst|state.number\(14)) # (!\decimal_printer_inst|Add5~23\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(14),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~23\,
	combout => \decimal_printer_inst|Add5~24_combout\,
	cout => \decimal_printer_inst|Add5~25\);

-- Location: LCCOMB_X66_Y39_N30
\decimal_printer_inst|Selector12~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector12~0_combout\ = (\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|state.number[14]~5_combout\ & (\decimal_printer_inst|Add7~26_combout\)) # (!\decimal_printer_inst|state.number[14]~5_combout\ & 
-- ((\decimal_printer_inst|Add5~24_combout\))))) # (!\decimal_printer_inst|state_nxt~16_combout\ & (\decimal_printer_inst|state.number[14]~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~16_combout\,
	datab => \decimal_printer_inst|state.number[14]~5_combout\,
	datac => \decimal_printer_inst|Add7~26_combout\,
	datad => \decimal_printer_inst|Add5~24_combout\,
	combout => \decimal_printer_inst|Selector12~0_combout\);

-- Location: LCCOMB_X65_Y39_N24
\decimal_printer_inst|Add1~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~20_combout\ = (\decimal_printer_inst|state.number\(14) & ((GND) # (!\decimal_printer_inst|Add1~19\))) # (!\decimal_printer_inst|state.number\(14) & (\decimal_printer_inst|Add1~19\ $ (GND)))
-- \decimal_printer_inst|Add1~21\ = CARRY((\decimal_printer_inst|state.number\(14)) # (!\decimal_printer_inst|Add1~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(14),
	datad => VCC,
	cin => \decimal_printer_inst|Add1~19\,
	combout => \decimal_printer_inst|Add1~20_combout\,
	cout => \decimal_printer_inst|Add1~21\);

-- Location: LCCOMB_X65_Y40_N22
\decimal_printer_inst|Add3~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~22_combout\ = (\decimal_printer_inst|state.number\(14) & (\decimal_printer_inst|Add3~21\ & VCC)) # (!\decimal_printer_inst|state.number\(14) & (!\decimal_printer_inst|Add3~21\))
-- \decimal_printer_inst|Add3~23\ = CARRY((!\decimal_printer_inst|state.number\(14) & !\decimal_printer_inst|Add3~21\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(14),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~21\,
	combout => \decimal_printer_inst|Add3~22_combout\,
	cout => \decimal_printer_inst|Add3~23\);

-- Location: LCCOMB_X66_Y39_N0
\decimal_printer_inst|Selector12~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector12~1_combout\ = (\decimal_printer_inst|Selector12~0_combout\ & (((\decimal_printer_inst|state_nxt~16_combout\) # (\decimal_printer_inst|Add3~22_combout\)))) # (!\decimal_printer_inst|Selector12~0_combout\ & 
-- (\decimal_printer_inst|Add1~20_combout\ & (!\decimal_printer_inst|state_nxt~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector12~0_combout\,
	datab => \decimal_printer_inst|Add1~20_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|Add3~22_combout\,
	combout => \decimal_printer_inst|Selector12~1_combout\);

-- Location: LCCOMB_X66_Y39_N16
\decimal_printer_inst|state.number[14]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[14]~feeder_combout\ = \decimal_printer_inst|Selector12~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \decimal_printer_inst|Selector12~1_combout\,
	combout => \decimal_printer_inst|state.number[14]~feeder_combout\);

-- Location: IOIBUF_X65_Y0_N1
\number[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(14),
	o => \number[14]~input_o\);

-- Location: FF_X66_Y39_N17
\decimal_printer_inst|state.number[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[14]~feeder_combout\,
	asdata => \number[14]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(14));

-- Location: LCCOMB_X65_Y40_N24
\decimal_printer_inst|Add3~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~24_combout\ = \decimal_printer_inst|Add3~23\ $ (\decimal_printer_inst|state.number\(15))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \decimal_printer_inst|state.number\(15),
	cin => \decimal_printer_inst|Add3~23\,
	combout => \decimal_printer_inst|Add3~24_combout\);

-- Location: LCCOMB_X65_Y41_N30
\decimal_printer_inst|Add5~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~26_combout\ = \decimal_printer_inst|Add5~25\ $ (!\decimal_printer_inst|state.number\(15))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \decimal_printer_inst|state.number\(15),
	cin => \decimal_printer_inst|Add5~25\,
	combout => \decimal_printer_inst|Add5~26_combout\);

-- Location: LCCOMB_X65_Y39_N26
\decimal_printer_inst|Add1~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add1~22_combout\ = \decimal_printer_inst|Add1~21\ $ (!\decimal_printer_inst|state.number\(15))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \decimal_printer_inst|state.number\(15),
	cin => \decimal_printer_inst|Add1~21\,
	combout => \decimal_printer_inst|Add1~22_combout\);

-- Location: LCCOMB_X65_Y42_N4
\decimal_printer_inst|Selector11~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector11~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & (((!\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|state_nxt~16_combout\ & 
-- (\decimal_printer_inst|Add5~26_combout\)) # (!\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|Add1~22_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~5_combout\,
	datab => \decimal_printer_inst|Add5~26_combout\,
	datac => \decimal_printer_inst|Add1~22_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|Selector11~0_combout\);

-- Location: LCCOMB_X66_Y41_N30
\decimal_printer_inst|Add7~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add7~28_combout\ = \decimal_printer_inst|state.number\(15) $ (\decimal_printer_inst|Add7~27\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(15),
	cin => \decimal_printer_inst|Add7~27\,
	combout => \decimal_printer_inst|Add7~28_combout\);

-- Location: LCCOMB_X65_Y42_N22
\decimal_printer_inst|Selector11~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector11~1_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|Selector11~0_combout\ & (\decimal_printer_inst|Add3~24_combout\)) # (!\decimal_printer_inst|Selector11~0_combout\ & 
-- ((\decimal_printer_inst|Add7~28_combout\))))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & (((\decimal_printer_inst|Selector11~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~5_combout\,
	datab => \decimal_printer_inst|Add3~24_combout\,
	datac => \decimal_printer_inst|Selector11~0_combout\,
	datad => \decimal_printer_inst|Add7~28_combout\,
	combout => \decimal_printer_inst|Selector11~1_combout\);

-- Location: IOIBUF_X58_Y73_N1
\number[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(15),
	o => \number[15]~input_o\);

-- Location: LCCOMB_X65_Y42_N24
\decimal_printer_inst|state.number[15]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[15]~6_combout\ = (\decimal_printer_inst|state.number[14]~20_combout\ & ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|Selector11~1_combout\)) # 
-- (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & ((\number[15]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector11~1_combout\,
	datab => \decimal_printer_inst|state.number[14]~20_combout\,
	datac => \number[15]~input_o\,
	datad => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	combout => \decimal_printer_inst|state.number[15]~6_combout\);

-- Location: LCCOMB_X65_Y42_N8
\decimal_printer_inst|state.number[15]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[15]~7_combout\ = (\decimal_printer_inst|state.number[15]~6_combout\) # ((!\decimal_printer_inst|state.number[14]~20_combout\ & \decimal_printer_inst|state.number\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number[14]~20_combout\,
	datac => \decimal_printer_inst|state.number\(15),
	datad => \decimal_printer_inst|state.number[15]~6_combout\,
	combout => \decimal_printer_inst|state.number[15]~7_combout\);

-- Location: FF_X65_Y42_N9
\decimal_printer_inst|state.number[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[15]~7_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(15));

-- Location: LCCOMB_X66_Y42_N24
\decimal_printer_inst|state_nxt~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~13_combout\ = (!\decimal_printer_inst|state.number\(15) & !\decimal_printer_inst|state.number\(14))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(15),
	datad => \decimal_printer_inst|state.number\(14),
	combout => \decimal_printer_inst|state_nxt~13_combout\);

-- Location: LCCOMB_X66_Y42_N22
\decimal_printer_inst|state_nxt~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~14_combout\ = (\decimal_printer_inst|LessThan0~0_combout\ & (!\decimal_printer_inst|state.number\(10) & (!\decimal_printer_inst|state.number\(13) & \decimal_printer_inst|state_nxt~13_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan0~0_combout\,
	datab => \decimal_printer_inst|state.number\(10),
	datac => \decimal_printer_inst|state.number\(13),
	datad => \decimal_printer_inst|state_nxt~13_combout\,
	combout => \decimal_printer_inst|state_nxt~14_combout\);

-- Location: LCCOMB_X65_Y42_N20
\decimal_printer_inst|state_nxt~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~15_combout\ = (\decimal_printer_inst|LessThan3~1_combout\ & (\decimal_printer_inst|state_nxt~14_combout\ & ((\decimal_printer_inst|LessThan2~1_combout\) # (\decimal_printer_inst|LessThan2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan3~1_combout\,
	datab => \decimal_printer_inst|LessThan2~1_combout\,
	datac => \decimal_printer_inst|LessThan2~0_combout\,
	datad => \decimal_printer_inst|state_nxt~14_combout\,
	combout => \decimal_printer_inst|state_nxt~15_combout\);

-- Location: LCCOMB_X65_Y45_N18
\decimal_printer_inst|state.number[2]~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[2]~15_combout\ = ((\decimal_printer_inst|state_nxt~15_combout\ & (\decimal_printer_inst|state.fsm_state.IDLE~q\ & \decimal_printer_inst|LessThan3~3_combout\))) # (!\decimal_printer_inst|state_nxt~20_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~20_combout\,
	datab => \decimal_printer_inst|state_nxt~15_combout\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \decimal_printer_inst|LessThan3~3_combout\,
	combout => \decimal_printer_inst|state.number[2]~15_combout\);

-- Location: IOIBUF_X58_Y73_N15
\number[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(2),
	o => \number[2]~input_o\);

-- Location: LCCOMB_X65_Y41_N4
\decimal_printer_inst|Add5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~0_combout\ = \decimal_printer_inst|state.number\(2) $ (VCC)
-- \decimal_printer_inst|Add5~1\ = CARRY(\decimal_printer_inst|state.number\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(2),
	datad => VCC,
	combout => \decimal_printer_inst|Add5~0_combout\,
	cout => \decimal_printer_inst|Add5~1\);

-- Location: LCCOMB_X65_Y41_N2
\decimal_printer_inst|state.number[2]~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[2]~13_combout\ = (\decimal_printer_inst|state_nxt~15_combout\ & (((!\decimal_printer_inst|LessThan3~3_combout\ & \decimal_printer_inst|Add7~2_combout\)))) # (!\decimal_printer_inst|state_nxt~15_combout\ & 
-- (\decimal_printer_inst|Add5~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~15_combout\,
	datab => \decimal_printer_inst|Add5~0_combout\,
	datac => \decimal_printer_inst|LessThan3~3_combout\,
	datad => \decimal_printer_inst|Add7~2_combout\,
	combout => \decimal_printer_inst|state.number[2]~13_combout\);

-- Location: LCCOMB_X65_Y45_N24
\decimal_printer_inst|state.number[2]~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[2]~14_combout\ = (\decimal_printer_inst|state_nxt~20_combout\ & ((\decimal_printer_inst|state.fsm_state.IDLE~q\ & ((\decimal_printer_inst|state.number[2]~13_combout\))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & 
-- (\number[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~20_combout\,
	datab => \number[2]~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \decimal_printer_inst|state.number[2]~13_combout\,
	combout => \decimal_printer_inst|state.number[2]~14_combout\);

-- Location: LCCOMB_X65_Y45_N16
\decimal_printer_inst|state.number[2]~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[2]~16_combout\ = (\decimal_printer_inst|state.number[2]~14_combout\) # ((\decimal_printer_inst|state.number[2]~15_combout\ & \decimal_printer_inst|state.number\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number[2]~15_combout\,
	datac => \decimal_printer_inst|state.number\(2),
	datad => \decimal_printer_inst|state.number[2]~14_combout\,
	combout => \decimal_printer_inst|state.number[2]~16_combout\);

-- Location: FF_X65_Y45_N17
\decimal_printer_inst|state.number[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[2]~16_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(2));

-- Location: LCCOMB_X65_Y45_N4
\decimal_printer_inst|LessThan3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan3~2_combout\ = ((!\decimal_printer_inst|state.number\(2) & !\decimal_printer_inst|state.number\(1))) # (!\decimal_printer_inst|state.number\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(2),
	datac => \decimal_printer_inst|state.number\(3),
	datad => \decimal_printer_inst|state.number\(1),
	combout => \decimal_printer_inst|LessThan3~2_combout\);

-- Location: LCCOMB_X65_Y42_N6
\decimal_printer_inst|LessThan3~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan3~3_combout\ = (\decimal_printer_inst|LessThan3~1_combout\ & (\decimal_printer_inst|LessThan3~0_combout\ & (\decimal_printer_inst|LessThan3~2_combout\ & \decimal_printer_inst|state_nxt~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan3~1_combout\,
	datab => \decimal_printer_inst|LessThan3~0_combout\,
	datac => \decimal_printer_inst|LessThan3~2_combout\,
	datad => \decimal_printer_inst|state_nxt~14_combout\,
	combout => \decimal_printer_inst|LessThan3~3_combout\);

-- Location: LCCOMB_X65_Y42_N2
\decimal_printer_inst|state.number[3]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[3]~8_combout\ = (\decimal_printer_inst|LessThan3~3_combout\ & (\decimal_printer_inst|state_nxt~15_combout\ & (\decimal_printer_inst|state.fsm_state.IDLE~q\ & \decimal_printer_inst|state_nxt~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan3~3_combout\,
	datab => \decimal_printer_inst|state_nxt~15_combout\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|state.number[3]~8_combout\);

-- Location: LCCOMB_X65_Y42_N28
\decimal_printer_inst|state.number[3]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[3]~9_combout\ = (\decimal_printer_inst|state.number\(3) & ((\decimal_printer_inst|state.number[3]~8_combout\) # (!\decimal_printer_inst|state_nxt~19_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~19_combout\,
	datab => \decimal_printer_inst|state.number\(3),
	datad => \decimal_printer_inst|state.number[3]~8_combout\,
	combout => \decimal_printer_inst|state.number[3]~9_combout\);

-- Location: IOIBUF_X60_Y73_N15
\number[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(3),
	o => \number[3]~input_o\);

-- Location: LCCOMB_X65_Y41_N6
\decimal_printer_inst|Add5~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~2_combout\ = (\decimal_printer_inst|state.number\(3) & (\decimal_printer_inst|Add5~1\ & VCC)) # (!\decimal_printer_inst|state.number\(3) & (!\decimal_printer_inst|Add5~1\))
-- \decimal_printer_inst|Add5~3\ = CARRY((!\decimal_printer_inst|state.number\(3) & !\decimal_printer_inst|Add5~1\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100000011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(3),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~1\,
	combout => \decimal_printer_inst|Add5~2_combout\,
	cout => \decimal_printer_inst|Add5~3\);

-- Location: LCCOMB_X65_Y42_N30
\decimal_printer_inst|state.number[3]~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[3]~10_combout\ = (\decimal_printer_inst|state_nxt~15_combout\ & (!\decimal_printer_inst|LessThan3~3_combout\ & ((\decimal_printer_inst|Add7~4_combout\)))) # (!\decimal_printer_inst|state_nxt~15_combout\ & 
-- (((\decimal_printer_inst|Add5~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan3~3_combout\,
	datab => \decimal_printer_inst|state_nxt~15_combout\,
	datac => \decimal_printer_inst|Add5~2_combout\,
	datad => \decimal_printer_inst|Add7~4_combout\,
	combout => \decimal_printer_inst|state.number[3]~10_combout\);

-- Location: LCCOMB_X65_Y40_N0
\decimal_printer_inst|Add3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~0_combout\ = \decimal_printer_inst|state.number\(3) $ (VCC)
-- \decimal_printer_inst|Add3~1\ = CARRY(\decimal_printer_inst|state.number\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(3),
	datad => VCC,
	combout => \decimal_printer_inst|Add3~0_combout\,
	cout => \decimal_printer_inst|Add3~1\);

-- Location: LCCOMB_X65_Y42_N14
\decimal_printer_inst|state.number[3]~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[3]~21_combout\ = (\decimal_printer_inst|state.number[14]~4_combout\ & (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & \decimal_printer_inst|state.fsm_state.IDLE~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~4_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	combout => \decimal_printer_inst|state.number[3]~21_combout\);

-- Location: LCCOMB_X65_Y42_N0
\decimal_printer_inst|state.number[3]~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[3]~11_combout\ = (\decimal_printer_inst|state.number[3]~21_combout\ & ((\decimal_printer_inst|state_nxt~16_combout\ & (\decimal_printer_inst|state.number[3]~10_combout\)) # (!\decimal_printer_inst|state_nxt~16_combout\ & 
-- ((\decimal_printer_inst|Add3~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[3]~10_combout\,
	datab => \decimal_printer_inst|Add3~0_combout\,
	datac => \decimal_printer_inst|state.number[3]~21_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|state.number[3]~11_combout\);

-- Location: LCCOMB_X65_Y42_N18
\decimal_printer_inst|state.number[3]~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[3]~12_combout\ = (\decimal_printer_inst|state.number[3]~9_combout\) # ((\decimal_printer_inst|state.number[3]~11_combout\) # ((\decimal_printer_inst|Selector1~8_combout\ & \number[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector1~8_combout\,
	datab => \decimal_printer_inst|state.number[3]~9_combout\,
	datac => \number[3]~input_o\,
	datad => \decimal_printer_inst|state.number[3]~11_combout\,
	combout => \decimal_printer_inst|state.number[3]~12_combout\);

-- Location: FF_X65_Y42_N19
\decimal_printer_inst|state.number[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[3]~12_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(3));

-- Location: LCCOMB_X65_Y40_N2
\decimal_printer_inst|Add3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~2_combout\ = (\decimal_printer_inst|state.number\(4) & (\decimal_printer_inst|Add3~1\ & VCC)) # (!\decimal_printer_inst|state.number\(4) & (!\decimal_printer_inst|Add3~1\))
-- \decimal_printer_inst|Add3~3\ = CARRY((!\decimal_printer_inst|state.number\(4) & !\decimal_printer_inst|Add3~1\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100000101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(4),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~1\,
	combout => \decimal_printer_inst|Add3~2_combout\,
	cout => \decimal_printer_inst|Add3~3\);

-- Location: LCCOMB_X65_Y41_N8
\decimal_printer_inst|Add5~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~4_combout\ = (\decimal_printer_inst|state.number\(4) & ((GND) # (!\decimal_printer_inst|Add5~3\))) # (!\decimal_printer_inst|state.number\(4) & (\decimal_printer_inst|Add5~3\ $ (GND)))
-- \decimal_printer_inst|Add5~5\ = CARRY((\decimal_printer_inst|state.number\(4)) # (!\decimal_printer_inst|Add5~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(4),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~3\,
	combout => \decimal_printer_inst|Add5~4_combout\,
	cout => \decimal_printer_inst|Add5~5\);

-- Location: LCCOMB_X66_Y40_N16
\decimal_printer_inst|Selector22~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector22~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & (((!\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|state_nxt~16_combout\ & 
-- ((\decimal_printer_inst|Add5~4_combout\))) # (!\decimal_printer_inst|state_nxt~16_combout\ & (\decimal_printer_inst|Add1~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~5_combout\,
	datab => \decimal_printer_inst|Add1~0_combout\,
	datac => \decimal_printer_inst|Add5~4_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|Selector22~0_combout\);

-- Location: LCCOMB_X66_Y40_N2
\decimal_printer_inst|Selector22~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector22~1_combout\ = (\decimal_printer_inst|Selector22~0_combout\ & ((\decimal_printer_inst|Add3~2_combout\) # ((!\decimal_printer_inst|state.number[14]~5_combout\)))) # (!\decimal_printer_inst|Selector22~0_combout\ & 
-- (((\decimal_printer_inst|state.number[14]~5_combout\ & \decimal_printer_inst|Add7~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add3~2_combout\,
	datab => \decimal_printer_inst|Selector22~0_combout\,
	datac => \decimal_printer_inst|state.number[14]~5_combout\,
	datad => \decimal_printer_inst|Add7~6_combout\,
	combout => \decimal_printer_inst|Selector22~1_combout\);

-- Location: LCCOMB_X66_Y39_N2
\decimal_printer_inst|state.number[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[4]~feeder_combout\ = \decimal_printer_inst|Selector22~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \decimal_printer_inst|Selector22~1_combout\,
	combout => \decimal_printer_inst|state.number[4]~feeder_combout\);

-- Location: IOIBUF_X65_Y0_N15
\number[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(4),
	o => \number[4]~input_o\);

-- Location: FF_X66_Y39_N3
\decimal_printer_inst|state.number[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[4]~feeder_combout\,
	asdata => \number[4]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(4));

-- Location: LCCOMB_X65_Y40_N28
\decimal_printer_inst|LessThan1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan1~0_combout\ = (((!\decimal_printer_inst|state.number\(4) & !\decimal_printer_inst|state.number\(3))) # (!\decimal_printer_inst|state.number\(8))) # (!\decimal_printer_inst|state.number\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(4),
	datab => \decimal_printer_inst|state.number\(3),
	datac => \decimal_printer_inst|state.number\(9),
	datad => \decimal_printer_inst|state.number\(8),
	combout => \decimal_printer_inst|LessThan1~0_combout\);

-- Location: LCCOMB_X65_Y40_N30
\decimal_printer_inst|LessThan1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan1~1_combout\ = ((\decimal_printer_inst|LessThan1~0_combout\) # ((!\decimal_printer_inst|state.number\(5)) # (!\decimal_printer_inst|state.number\(6)))) # (!\decimal_printer_inst|state.number\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(7),
	datab => \decimal_printer_inst|LessThan1~0_combout\,
	datac => \decimal_printer_inst|state.number\(6),
	datad => \decimal_printer_inst|state.number\(5),
	combout => \decimal_printer_inst|LessThan1~1_combout\);

-- Location: LCCOMB_X66_Y42_N16
\decimal_printer_inst|state_nxt~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~16_combout\ = (\decimal_printer_inst|LessThan1~1_combout\ & \decimal_printer_inst|state_nxt~14_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|LessThan1~1_combout\,
	datac => \decimal_printer_inst|state_nxt~14_combout\,
	combout => \decimal_printer_inst|state_nxt~16_combout\);

-- Location: LCCOMB_X65_Y41_N10
\decimal_printer_inst|Add5~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~6_combout\ = (\decimal_printer_inst|state.number\(5) & (!\decimal_printer_inst|Add5~5\)) # (!\decimal_printer_inst|state.number\(5) & ((\decimal_printer_inst|Add5~5\) # (GND)))
-- \decimal_printer_inst|Add5~7\ = CARRY((!\decimal_printer_inst|Add5~5\) # (!\decimal_printer_inst|state.number\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(5),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~5\,
	combout => \decimal_printer_inst|Add5~6_combout\,
	cout => \decimal_printer_inst|Add5~7\);

-- Location: LCCOMB_X66_Y39_N26
\decimal_printer_inst|Selector21~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector21~0_combout\ = (\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|Add7~8_combout\))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & 
-- (\decimal_printer_inst|Add5~6_combout\)))) # (!\decimal_printer_inst|state_nxt~16_combout\ & (\decimal_printer_inst|state.number[14]~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110001100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~16_combout\,
	datab => \decimal_printer_inst|state.number[14]~5_combout\,
	datac => \decimal_printer_inst|Add5~6_combout\,
	datad => \decimal_printer_inst|Add7~8_combout\,
	combout => \decimal_printer_inst|Selector21~0_combout\);

-- Location: LCCOMB_X65_Y40_N4
\decimal_printer_inst|Add3~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~4_combout\ = (\decimal_printer_inst|state.number\(5) & (\decimal_printer_inst|Add3~3\ $ (GND))) # (!\decimal_printer_inst|state.number\(5) & (!\decimal_printer_inst|Add3~3\ & VCC))
-- \decimal_printer_inst|Add3~5\ = CARRY((\decimal_printer_inst|state.number\(5) & !\decimal_printer_inst|Add3~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(5),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~3\,
	combout => \decimal_printer_inst|Add3~4_combout\,
	cout => \decimal_printer_inst|Add3~5\);

-- Location: LCCOMB_X66_Y39_N20
\decimal_printer_inst|Selector21~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector21~1_combout\ = (\decimal_printer_inst|Selector21~0_combout\ & (((\decimal_printer_inst|state_nxt~16_combout\) # (\decimal_printer_inst|Add3~4_combout\)))) # (!\decimal_printer_inst|Selector21~0_combout\ & 
-- (\decimal_printer_inst|Add1~2_combout\ & (!\decimal_printer_inst|state_nxt~16_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111010100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector21~0_combout\,
	datab => \decimal_printer_inst|Add1~2_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|Add3~4_combout\,
	combout => \decimal_printer_inst|Selector21~1_combout\);

-- Location: LCCOMB_X66_Y39_N24
\decimal_printer_inst|state.number[5]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[5]~feeder_combout\ = \decimal_printer_inst|Selector21~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \decimal_printer_inst|Selector21~1_combout\,
	combout => \decimal_printer_inst|state.number[5]~feeder_combout\);

-- Location: IOIBUF_X65_Y0_N8
\number[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(5),
	o => \number[5]~input_o\);

-- Location: FF_X66_Y39_N25
\decimal_printer_inst|state.number[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[5]~feeder_combout\,
	asdata => \number[5]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(5));

-- Location: LCCOMB_X65_Y40_N6
\decimal_printer_inst|Add3~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~6_combout\ = (\decimal_printer_inst|state.number\(6) & (!\decimal_printer_inst|Add3~5\)) # (!\decimal_printer_inst|state.number\(6) & ((\decimal_printer_inst|Add3~5\) # (GND)))
-- \decimal_printer_inst|Add3~7\ = CARRY((!\decimal_printer_inst|Add3~5\) # (!\decimal_printer_inst|state.number\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.number\(6),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~5\,
	combout => \decimal_printer_inst|Add3~6_combout\,
	cout => \decimal_printer_inst|Add3~7\);

-- Location: LCCOMB_X65_Y41_N12
\decimal_printer_inst|Add5~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add5~8_combout\ = (\decimal_printer_inst|state.number\(6) & (\decimal_printer_inst|Add5~7\ $ (GND))) # (!\decimal_printer_inst|state.number\(6) & (!\decimal_printer_inst|Add5~7\ & VCC))
-- \decimal_printer_inst|Add5~9\ = CARRY((\decimal_printer_inst|state.number\(6) & !\decimal_printer_inst|Add5~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(6),
	datad => VCC,
	cin => \decimal_printer_inst|Add5~7\,
	combout => \decimal_printer_inst|Add5~8_combout\,
	cout => \decimal_printer_inst|Add5~9\);

-- Location: LCCOMB_X65_Y41_N0
\decimal_printer_inst|Selector20~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector20~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & (((\decimal_printer_inst|Add7~10_combout\) # (!\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & 
-- (\decimal_printer_inst|Add5~8_combout\ & ((\decimal_printer_inst|state_nxt~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add5~8_combout\,
	datab => \decimal_printer_inst|state.number[14]~5_combout\,
	datac => \decimal_printer_inst|Add7~10_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|Selector20~0_combout\);

-- Location: LCCOMB_X66_Y39_N8
\decimal_printer_inst|Selector20~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector20~1_combout\ = (\decimal_printer_inst|Selector20~0_combout\ & ((\decimal_printer_inst|Add3~6_combout\) # ((\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|Selector20~0_combout\ & 
-- (((!\decimal_printer_inst|state_nxt~16_combout\ & \decimal_printer_inst|Add1~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add3~6_combout\,
	datab => \decimal_printer_inst|Selector20~0_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|Add1~4_combout\,
	combout => \decimal_printer_inst|Selector20~1_combout\);

-- Location: LCCOMB_X66_Y39_N14
\decimal_printer_inst|state.number[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[6]~feeder_combout\ = \decimal_printer_inst|Selector20~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|Selector20~1_combout\,
	combout => \decimal_printer_inst|state.number[6]~feeder_combout\);

-- Location: IOIBUF_X58_Y73_N8
\number[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(6),
	o => \number[6]~input_o\);

-- Location: FF_X66_Y39_N15
\decimal_printer_inst|state.number[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[6]~feeder_combout\,
	asdata => \number[6]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(6));

-- Location: LCCOMB_X65_Y39_N2
\decimal_printer_inst|Selector19~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector19~0_combout\ = (\decimal_printer_inst|state_nxt~16_combout\ & (\decimal_printer_inst|Add5~10_combout\ & ((!\decimal_printer_inst|state.number[14]~5_combout\)))) # (!\decimal_printer_inst|state_nxt~16_combout\ & 
-- (((\decimal_printer_inst|Add1~6_combout\) # (\decimal_printer_inst|state.number[14]~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111110101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add5~10_combout\,
	datab => \decimal_printer_inst|Add1~6_combout\,
	datac => \decimal_printer_inst|state_nxt~16_combout\,
	datad => \decimal_printer_inst|state.number[14]~5_combout\,
	combout => \decimal_printer_inst|Selector19~0_combout\);

-- Location: LCCOMB_X65_Y40_N8
\decimal_printer_inst|Add3~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~8_combout\ = (\decimal_printer_inst|state.number\(7) & (\decimal_printer_inst|Add3~7\ $ (GND))) # (!\decimal_printer_inst|state.number\(7) & (!\decimal_printer_inst|Add3~7\ & VCC))
-- \decimal_printer_inst|Add3~9\ = CARRY((\decimal_printer_inst|state.number\(7) & !\decimal_printer_inst|Add3~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(7),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~7\,
	combout => \decimal_printer_inst|Add3~8_combout\,
	cout => \decimal_printer_inst|Add3~9\);

-- Location: LCCOMB_X66_Y39_N22
\decimal_printer_inst|Selector19~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector19~1_combout\ = (\decimal_printer_inst|Selector19~0_combout\ & (((\decimal_printer_inst|Add3~8_combout\)) # (!\decimal_printer_inst|state.number[14]~5_combout\))) # (!\decimal_printer_inst|Selector19~0_combout\ & 
-- (\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|Add7~12_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector19~0_combout\,
	datab => \decimal_printer_inst|state.number[14]~5_combout\,
	datac => \decimal_printer_inst|Add3~8_combout\,
	datad => \decimal_printer_inst|Add7~12_combout\,
	combout => \decimal_printer_inst|Selector19~1_combout\);

-- Location: LCCOMB_X66_Y39_N12
\decimal_printer_inst|state.number[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[7]~feeder_combout\ = \decimal_printer_inst|Selector19~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector19~1_combout\,
	combout => \decimal_printer_inst|state.number[7]~feeder_combout\);

-- Location: IOIBUF_X67_Y0_N8
\number[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(7),
	o => \number[7]~input_o\);

-- Location: FF_X66_Y39_N13
\decimal_printer_inst|state.number[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[7]~feeder_combout\,
	asdata => \number[7]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(7));

-- Location: LCCOMB_X65_Y40_N10
\decimal_printer_inst|Add3~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~10_combout\ = (\decimal_printer_inst|state.number\(8) & (!\decimal_printer_inst|Add3~9\)) # (!\decimal_printer_inst|state.number\(8) & ((\decimal_printer_inst|Add3~9\) # (GND)))
-- \decimal_printer_inst|Add3~11\ = CARRY((!\decimal_printer_inst|Add3~9\) # (!\decimal_printer_inst|state.number\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(8),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~9\,
	combout => \decimal_printer_inst|Add3~10_combout\,
	cout => \decimal_printer_inst|Add3~11\);

-- Location: LCCOMB_X66_Y40_N12
\decimal_printer_inst|Selector18~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector18~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & (((\decimal_printer_inst|Add7~14_combout\)) # (!\decimal_printer_inst|state_nxt~16_combout\))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & 
-- (\decimal_printer_inst|state_nxt~16_combout\ & (\decimal_printer_inst|Add5~12_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~5_combout\,
	datab => \decimal_printer_inst|state_nxt~16_combout\,
	datac => \decimal_printer_inst|Add5~12_combout\,
	datad => \decimal_printer_inst|Add7~14_combout\,
	combout => \decimal_printer_inst|Selector18~0_combout\);

-- Location: LCCOMB_X66_Y40_N30
\decimal_printer_inst|Selector18~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector18~1_combout\ = (\decimal_printer_inst|state_nxt~16_combout\ & (((\decimal_printer_inst|Selector18~0_combout\)))) # (!\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|Selector18~0_combout\ & 
-- (\decimal_printer_inst|Add3~10_combout\)) # (!\decimal_printer_inst|Selector18~0_combout\ & ((\decimal_printer_inst|Add1~8_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add3~10_combout\,
	datab => \decimal_printer_inst|state_nxt~16_combout\,
	datac => \decimal_printer_inst|Add1~8_combout\,
	datad => \decimal_printer_inst|Selector18~0_combout\,
	combout => \decimal_printer_inst|Selector18~1_combout\);

-- Location: LCCOMB_X66_Y40_N6
\decimal_printer_inst|state.number[8]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[8]~feeder_combout\ = \decimal_printer_inst|Selector18~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector18~1_combout\,
	combout => \decimal_printer_inst|state.number[8]~feeder_combout\);

-- Location: IOIBUF_X67_Y0_N15
\number[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(8),
	o => \number[8]~input_o\);

-- Location: FF_X66_Y40_N7
\decimal_printer_inst|state.number[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[8]~feeder_combout\,
	asdata => \number[8]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(8));

-- Location: LCCOMB_X65_Y40_N12
\decimal_printer_inst|Add3~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add3~12_combout\ = (\decimal_printer_inst|state.number\(9) & (\decimal_printer_inst|Add3~11\ $ (GND))) # (!\decimal_printer_inst|state.number\(9) & (!\decimal_printer_inst|Add3~11\ & VCC))
-- \decimal_printer_inst|Add3~13\ = CARRY((\decimal_printer_inst|state.number\(9) & !\decimal_printer_inst|Add3~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(9),
	datad => VCC,
	cin => \decimal_printer_inst|Add3~11\,
	combout => \decimal_printer_inst|Add3~12_combout\,
	cout => \decimal_printer_inst|Add3~13\);

-- Location: LCCOMB_X66_Y40_N8
\decimal_printer_inst|Selector17~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector17~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & (((!\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|state_nxt~16_combout\ & 
-- (\decimal_printer_inst|Add5~14_combout\)) # (!\decimal_printer_inst|state_nxt~16_combout\ & ((\decimal_printer_inst|Add1~10_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add5~14_combout\,
	datab => \decimal_printer_inst|Add1~10_combout\,
	datac => \decimal_printer_inst|state.number[14]~5_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|Selector17~0_combout\);

-- Location: LCCOMB_X66_Y40_N18
\decimal_printer_inst|Selector17~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector17~1_combout\ = (\decimal_printer_inst|Selector17~0_combout\ & ((\decimal_printer_inst|Add3~12_combout\) # ((!\decimal_printer_inst|state.number[14]~5_combout\)))) # (!\decimal_printer_inst|Selector17~0_combout\ & 
-- (((\decimal_printer_inst|state.number[14]~5_combout\ & \decimal_printer_inst|Add7~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add3~12_combout\,
	datab => \decimal_printer_inst|Selector17~0_combout\,
	datac => \decimal_printer_inst|state.number[14]~5_combout\,
	datad => \decimal_printer_inst|Add7~16_combout\,
	combout => \decimal_printer_inst|Selector17~1_combout\);

-- Location: LCCOMB_X66_Y40_N20
\decimal_printer_inst|state.number[9]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[9]~feeder_combout\ = \decimal_printer_inst|Selector17~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \decimal_printer_inst|Selector17~1_combout\,
	combout => \decimal_printer_inst|state.number[9]~feeder_combout\);

-- Location: IOIBUF_X67_Y73_N8
\number[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(9),
	o => \number[9]~input_o\);

-- Location: FF_X66_Y40_N21
\decimal_printer_inst|state.number[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[9]~feeder_combout\,
	asdata => \number[9]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(9));

-- Location: LCCOMB_X66_Y40_N28
\decimal_printer_inst|Selector16~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector16~0_combout\ = (\decimal_printer_inst|state.number[14]~5_combout\ & ((\decimal_printer_inst|Add7~18_combout\) # ((!\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|state.number[14]~5_combout\ & 
-- (((\decimal_printer_inst|Add5~16_combout\ & \decimal_printer_inst|state_nxt~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~5_combout\,
	datab => \decimal_printer_inst|Add7~18_combout\,
	datac => \decimal_printer_inst|Add5~16_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|Selector16~0_combout\);

-- Location: LCCOMB_X66_Y40_N22
\decimal_printer_inst|Selector16~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector16~1_combout\ = (\decimal_printer_inst|Selector16~0_combout\ & ((\decimal_printer_inst|Add3~14_combout\) # ((\decimal_printer_inst|state_nxt~16_combout\)))) # (!\decimal_printer_inst|Selector16~0_combout\ & 
-- (((\decimal_printer_inst|Add1~12_combout\ & !\decimal_printer_inst|state_nxt~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add3~14_combout\,
	datab => \decimal_printer_inst|Selector16~0_combout\,
	datac => \decimal_printer_inst|Add1~12_combout\,
	datad => \decimal_printer_inst|state_nxt~16_combout\,
	combout => \decimal_printer_inst|Selector16~1_combout\);

-- Location: LCCOMB_X66_Y40_N26
\decimal_printer_inst|state.number[10]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[10]~feeder_combout\ = \decimal_printer_inst|Selector16~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector16~1_combout\,
	combout => \decimal_printer_inst|state.number[10]~feeder_combout\);

-- Location: IOIBUF_X67_Y73_N15
\number[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_number(10),
	o => \number[10]~input_o\);

-- Location: FF_X66_Y40_N27
\decimal_printer_inst|state.number[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.number[10]~feeder_combout\,
	asdata => \number[10]~input_o\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => \decimal_printer_inst|ALT_INV_state.fsm_state.CALC_DIGITS~q\,
	ena => \decimal_printer_inst|state.number[14]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.number\(10));

-- Location: LCCOMB_X66_Y40_N24
\decimal_printer_inst|LessThan0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|LessThan0~1_combout\ = (((\decimal_printer_inst|LessThan3~0_combout\) # (!\decimal_printer_inst|state.number\(8))) # (!\decimal_printer_inst|state.number\(9))) # (!\decimal_printer_inst|state.number\(10))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(10),
	datab => \decimal_printer_inst|state.number\(9),
	datac => \decimal_printer_inst|LessThan3~0_combout\,
	datad => \decimal_printer_inst|state.number\(8),
	combout => \decimal_printer_inst|LessThan0~1_combout\);

-- Location: LCCOMB_X66_Y42_N4
\decimal_printer_inst|state.number[14]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.number[14]~4_combout\ = (\decimal_printer_inst|state_nxt~13_combout\ & (((\decimal_printer_inst|LessThan0~1_combout\ & \decimal_printer_inst|LessThan0~0_combout\)) # (!\decimal_printer_inst|state.number\(13))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|LessThan0~1_combout\,
	datab => \decimal_printer_inst|state_nxt~13_combout\,
	datac => \decimal_printer_inst|state.number\(13),
	datad => \decimal_printer_inst|LessThan0~0_combout\,
	combout => \decimal_printer_inst|state.number[14]~4_combout\);

-- Location: LCCOMB_X65_Y42_N16
\decimal_printer_inst|state_nxt~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state_nxt~17_combout\ = (\decimal_printer_inst|state.number[14]~4_combout\ & (\decimal_printer_inst|state_nxt~16_combout\ & (\decimal_printer_inst|state_nxt~15_combout\ & \decimal_printer_inst|LessThan3~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number[14]~4_combout\,
	datab => \decimal_printer_inst|state_nxt~16_combout\,
	datac => \decimal_printer_inst|state_nxt~15_combout\,
	datad => \decimal_printer_inst|LessThan3~3_combout\,
	combout => \decimal_printer_inst|state_nxt~17_combout\);

-- Location: LCCOMB_X65_Y45_N6
\decimal_printer_inst|state.bcd_data[4][3]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.bcd_data[4][3]~0_combout\ = (\decimal_printer_inst|state.fsm_state.IDLE~q\ & ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\) # ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)))) # 
-- (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & (((\start~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datad => \start~input_o\,
	combout => \decimal_printer_inst|state.bcd_data[4][3]~0_combout\);

-- Location: LCCOMB_X65_Y45_N28
\decimal_printer_inst|state.bcd_data[0][3]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.bcd_data[0][3]~6_combout\ = (\decimal_printer_inst|state.bcd_data[4][3]~0_combout\ & ((\decimal_printer_inst|state_nxt~17_combout\) # (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~17_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.bcd_data[4][3]~0_combout\,
	combout => \decimal_printer_inst|state.bcd_data[0][3]~6_combout\);

-- Location: FF_X65_Y45_N1
\decimal_printer_inst|state.bcd_data[0][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector45~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[0][3]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[0][0]~q\);

-- Location: LCCOMB_X66_Y45_N2
\decimal_printer_inst|Selector41~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector41~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[0][0]~q\)) # 
-- (!\decimal_printer_inst|state.bcd_data[1][0]~q\))) # (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & ((\decimal_printer_inst|state.bcd_data[0][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.bcd_data[1][0]~q\,
	datad => \decimal_printer_inst|state.bcd_data[0][0]~q\,
	combout => \decimal_printer_inst|Selector41~0_combout\);

-- Location: LCCOMB_X65_Y45_N26
\decimal_printer_inst|state.bcd_data[1][3]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.bcd_data[1][3]~5_combout\ = (\decimal_printer_inst|state.bcd_data[4][3]~0_combout\ & (((\decimal_printer_inst|state_nxt~15_combout\ & !\decimal_printer_inst|LessThan3~3_combout\)) # 
-- (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[4][3]~0_combout\,
	datab => \decimal_printer_inst|state_nxt~15_combout\,
	datac => \decimal_printer_inst|LessThan3~3_combout\,
	datad => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	combout => \decimal_printer_inst|state.bcd_data[1][3]~5_combout\);

-- Location: FF_X66_Y45_N3
\decimal_printer_inst|state.bcd_data[1][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector41~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[1][3]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[1][0]~q\);

-- Location: LCCOMB_X66_Y45_N8
\decimal_printer_inst|Selector37~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector37~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[1][0]~q\)) # 
-- (!\decimal_printer_inst|state.bcd_data[2][0]~q\))) # (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & ((\decimal_printer_inst|state.bcd_data[1][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.bcd_data[2][0]~q\,
	datad => \decimal_printer_inst|state.bcd_data[1][0]~q\,
	combout => \decimal_printer_inst|Selector37~0_combout\);

-- Location: LCCOMB_X66_Y45_N20
\decimal_printer_inst|state.bcd_data[2][0]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.bcd_data[2][0]~4_combout\ = (\decimal_printer_inst|state.bcd_data[4][3]~0_combout\ & (((\decimal_printer_inst|state_nxt~16_combout\ & !\decimal_printer_inst|state_nxt~15_combout\)) # 
-- (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state_nxt~16_combout\,
	datab => \decimal_printer_inst|state_nxt~15_combout\,
	datac => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.bcd_data[4][3]~0_combout\,
	combout => \decimal_printer_inst|state.bcd_data[2][0]~4_combout\);

-- Location: FF_X66_Y45_N9
\decimal_printer_inst|state.bcd_data[2][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector37~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[2][0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[2][0]~q\);

-- Location: LCCOMB_X65_Y45_N12
\decimal_printer_inst|Selector44~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector44~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & \decimal_printer_inst|state.number\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.number\(1),
	combout => \decimal_printer_inst|Selector44~0_combout\);

-- Location: FF_X65_Y45_N13
\decimal_printer_inst|state.bcd_data[0][1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector44~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[0][3]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[0][1]~q\);

-- Location: LCCOMB_X66_Y45_N26
\decimal_printer_inst|Selector40~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector40~0_combout\ = (\decimal_printer_inst|state.bcd_data[0][1]~q\ & \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[0][1]~q\,
	datac => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector40~0_combout\);

-- Location: LCCOMB_X66_Y45_N14
\decimal_printer_inst|Selector40~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector40~1_combout\ = (\decimal_printer_inst|Selector40~0_combout\) # ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[1][0]~q\ $ (\decimal_printer_inst|state.bcd_data[1][1]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|state.bcd_data[1][0]~q\,
	datac => \decimal_printer_inst|state.bcd_data[1][1]~q\,
	datad => \decimal_printer_inst|Selector40~0_combout\,
	combout => \decimal_printer_inst|Selector40~1_combout\);

-- Location: FF_X66_Y45_N15
\decimal_printer_inst|state.bcd_data[1][1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector40~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[1][3]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[1][1]~q\);

-- Location: LCCOMB_X66_Y45_N0
\decimal_printer_inst|Selector36~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector36~0_combout\ = (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[1][1]~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.bcd_data[1][1]~q\,
	combout => \decimal_printer_inst|Selector36~0_combout\);

-- Location: LCCOMB_X66_Y45_N18
\decimal_printer_inst|Selector36~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector36~1_combout\ = (\decimal_printer_inst|Selector36~0_combout\) # ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[2][0]~q\ $ (\decimal_printer_inst|state.bcd_data[2][1]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|state.bcd_data[2][0]~q\,
	datac => \decimal_printer_inst|state.bcd_data[2][1]~q\,
	datad => \decimal_printer_inst|Selector36~0_combout\,
	combout => \decimal_printer_inst|Selector36~1_combout\);

-- Location: FF_X66_Y45_N19
\decimal_printer_inst|state.bcd_data[2][1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector36~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[2][0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[2][1]~q\);

-- Location: LCCOMB_X66_Y45_N12
\decimal_printer_inst|Selector32~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector32~0_combout\ = (\decimal_printer_inst|state.bcd_data[2][1]~q\ & \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.bcd_data[2][1]~q\,
	datac => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector32~0_combout\);

-- Location: LCCOMB_X67_Y45_N18
\decimal_printer_inst|Selector33~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector33~0_combout\ = (\decimal_printer_inst|state.bcd_data[2][0]~q\ & ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\) # ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & 
-- !\decimal_printer_inst|state.bcd_data[3][0]~q\)))) # (!\decimal_printer_inst|state.bcd_data[2][0]~q\ & (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (!\decimal_printer_inst|state.bcd_data[3][0]~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[2][0]~q\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.bcd_data[3][0]~q\,
	datad => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector33~0_combout\);

-- Location: LCCOMB_X66_Y42_N2
\decimal_printer_inst|state.bcd_data[3][2]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.bcd_data[3][2]~2_combout\ = (!\decimal_printer_inst|state.number\(13) & (\decimal_printer_inst|LessThan1~1_combout\ & (!\decimal_printer_inst|state.number\(10) & \decimal_printer_inst|LessThan0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(13),
	datab => \decimal_printer_inst|LessThan1~1_combout\,
	datac => \decimal_printer_inst|state.number\(10),
	datad => \decimal_printer_inst|LessThan0~0_combout\,
	combout => \decimal_printer_inst|state.bcd_data[3][2]~2_combout\);

-- Location: LCCOMB_X67_Y45_N2
\decimal_printer_inst|state.bcd_data[3][2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.bcd_data[3][2]~3_combout\ = (\decimal_printer_inst|state.bcd_data[4][3]~0_combout\ & (((!\decimal_printer_inst|state.bcd_data[3][2]~2_combout\ & \decimal_printer_inst|state.number[14]~4_combout\)) # 
-- (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[4][3]~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.bcd_data[3][2]~2_combout\,
	datad => \decimal_printer_inst|state.number[14]~4_combout\,
	combout => \decimal_printer_inst|state.bcd_data[3][2]~3_combout\);

-- Location: FF_X67_Y45_N19
\decimal_printer_inst|state.bcd_data[3][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector33~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[3][2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[3][0]~q\);

-- Location: LCCOMB_X67_Y45_N22
\decimal_printer_inst|Selector32~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector32~1_combout\ = (\decimal_printer_inst|Selector32~0_combout\) # ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[3][1]~q\ $ (\decimal_printer_inst|state.bcd_data[3][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector32~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state.bcd_data[3][1]~q\,
	datad => \decimal_printer_inst|state.bcd_data[3][0]~q\,
	combout => \decimal_printer_inst|Selector32~1_combout\);

-- Location: FF_X67_Y45_N23
\decimal_printer_inst|state.bcd_data[3][1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector32~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[3][2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[3][1]~q\);

-- Location: LCCOMB_X67_Y45_N16
\decimal_printer_inst|Selector28~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector28~0_combout\ = (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[3][1]~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.bcd_data[3][1]~q\,
	combout => \decimal_printer_inst|Selector28~0_combout\);

-- Location: LCCOMB_X67_Y45_N0
\decimal_printer_inst|Selector29~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector29~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[3][0]~q\)) # 
-- (!\decimal_printer_inst|state.bcd_data[4][0]~q\))) # (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & ((\decimal_printer_inst|state.bcd_data[3][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.bcd_data[4][0]~q\,
	datad => \decimal_printer_inst|state.bcd_data[3][0]~q\,
	combout => \decimal_printer_inst|Selector29~0_combout\);

-- Location: LCCOMB_X67_Y45_N12
\decimal_printer_inst|state.bcd_data[4][3]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.bcd_data[4][3]~1_combout\ = (\decimal_printer_inst|state.bcd_data[4][3]~0_combout\ & ((!\decimal_printer_inst|state.number[14]~4_combout\) # (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010001010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[4][3]~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.number[14]~4_combout\,
	combout => \decimal_printer_inst|state.bcd_data[4][3]~1_combout\);

-- Location: FF_X67_Y45_N1
\decimal_printer_inst|state.bcd_data[4][0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector29~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[4][3]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[4][0]~q\);

-- Location: LCCOMB_X67_Y45_N10
\decimal_printer_inst|Selector28~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector28~1_combout\ = (\decimal_printer_inst|Selector28~0_combout\) # ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[4][1]~q\ $ (\decimal_printer_inst|state.bcd_data[4][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|Selector28~0_combout\,
	datac => \decimal_printer_inst|state.bcd_data[4][1]~q\,
	datad => \decimal_printer_inst|state.bcd_data[4][0]~q\,
	combout => \decimal_printer_inst|Selector28~1_combout\);

-- Location: FF_X67_Y45_N11
\decimal_printer_inst|state.bcd_data[4][1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector28~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[4][3]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[4][1]~q\);

-- Location: LCCOMB_X67_Y45_N26
\decimal_printer_inst|Selector27~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector27~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[4][2]~q\ $ (((\decimal_printer_inst|state.bcd_data[4][1]~q\ & \decimal_printer_inst|state.bcd_data[4][0]~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[4][1]~q\,
	datab => \decimal_printer_inst|state.bcd_data[4][0]~q\,
	datac => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.bcd_data[4][2]~q\,
	combout => \decimal_printer_inst|Selector27~0_combout\);

-- Location: LCCOMB_X67_Y45_N4
\decimal_printer_inst|Selector31~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector31~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[3][2]~q\ $ (((\decimal_printer_inst|state.bcd_data[3][1]~q\ & \decimal_printer_inst|state.bcd_data[3][0]~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|state.bcd_data[3][2]~q\,
	datac => \decimal_printer_inst|state.bcd_data[3][1]~q\,
	datad => \decimal_printer_inst|state.bcd_data[3][0]~q\,
	combout => \decimal_printer_inst|Selector31~0_combout\);

-- Location: LCCOMB_X66_Y45_N10
\decimal_printer_inst|Selector35~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector35~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[2][2]~q\ $ (((\decimal_printer_inst|state.bcd_data[2][0]~q\ & \decimal_printer_inst|state.bcd_data[2][1]~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[2][2]~q\,
	datab => \decimal_printer_inst|state.bcd_data[2][0]~q\,
	datac => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.bcd_data[2][1]~q\,
	combout => \decimal_printer_inst|Selector35~0_combout\);

-- Location: LCCOMB_X65_Y45_N14
\decimal_printer_inst|Selector43~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector43~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & \decimal_printer_inst|state.number\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.number\(2),
	combout => \decimal_printer_inst|Selector43~0_combout\);

-- Location: FF_X65_Y45_N15
\decimal_printer_inst|state.bcd_data[0][2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector43~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[0][3]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[0][2]~q\);

-- Location: LCCOMB_X66_Y45_N28
\decimal_printer_inst|Selector39~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector39~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|state.bcd_data[1][2]~q\ $ (((\decimal_printer_inst|state.bcd_data[1][1]~q\ & \decimal_printer_inst|state.bcd_data[1][0]~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|state.bcd_data[1][1]~q\,
	datac => \decimal_printer_inst|state.bcd_data[1][2]~q\,
	datad => \decimal_printer_inst|state.bcd_data[1][0]~q\,
	combout => \decimal_printer_inst|Selector39~0_combout\);

-- Location: LCCOMB_X66_Y45_N4
\decimal_printer_inst|Selector39~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector39~1_combout\ = (\decimal_printer_inst|Selector39~0_combout\) # ((\decimal_printer_inst|state.bcd_data[0][2]~q\ & \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[0][2]~q\,
	datab => \decimal_printer_inst|Selector39~0_combout\,
	datac => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector39~1_combout\);

-- Location: FF_X66_Y45_N5
\decimal_printer_inst|state.bcd_data[1][2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector39~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[1][3]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[1][2]~q\);

-- Location: LCCOMB_X66_Y45_N6
\decimal_printer_inst|Selector35~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector35~1_combout\ = (\decimal_printer_inst|Selector35~0_combout\) # ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[1][2]~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector35~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.bcd_data[1][2]~q\,
	combout => \decimal_printer_inst|Selector35~1_combout\);

-- Location: FF_X66_Y45_N7
\decimal_printer_inst|state.bcd_data[2][2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector35~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[2][0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[2][2]~q\);

-- Location: LCCOMB_X67_Y45_N20
\decimal_printer_inst|Selector31~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector31~1_combout\ = (\decimal_printer_inst|Selector31~0_combout\) # ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[2][2]~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|Selector31~0_combout\,
	datad => \decimal_printer_inst|state.bcd_data[2][2]~q\,
	combout => \decimal_printer_inst|Selector31~1_combout\);

-- Location: FF_X67_Y45_N21
\decimal_printer_inst|state.bcd_data[3][2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector31~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[3][2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[3][2]~q\);

-- Location: LCCOMB_X67_Y45_N28
\decimal_printer_inst|Selector27~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector27~1_combout\ = (\decimal_printer_inst|Selector27~0_combout\) # ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[3][2]~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|Selector27~0_combout\,
	datad => \decimal_printer_inst|state.bcd_data[3][2]~q\,
	combout => \decimal_printer_inst|Selector27~1_combout\);

-- Location: FF_X67_Y45_N29
\decimal_printer_inst|state.bcd_data[4][2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector27~1_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[4][3]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[4][2]~q\);

-- Location: LCCOMB_X67_Y45_N14
\decimal_printer_inst|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add0~0_combout\ = \decimal_printer_inst|state.bcd_data[4][3]~q\ $ (((\decimal_printer_inst|state.bcd_data[4][1]~q\ & (\decimal_printer_inst|state.bcd_data[4][2]~q\ & \decimal_printer_inst|state.bcd_data[4][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[4][1]~q\,
	datab => \decimal_printer_inst|state.bcd_data[4][2]~q\,
	datac => \decimal_printer_inst|state.bcd_data[4][0]~q\,
	datad => \decimal_printer_inst|state.bcd_data[4][3]~q\,
	combout => \decimal_printer_inst|Add0~0_combout\);

-- Location: LCCOMB_X66_Y45_N22
\decimal_printer_inst|Add4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add4~0_combout\ = \decimal_printer_inst|state.bcd_data[2][3]~q\ $ (((\decimal_printer_inst|state.bcd_data[2][2]~q\ & (\decimal_printer_inst|state.bcd_data[2][1]~q\ & \decimal_printer_inst|state.bcd_data[2][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[2][2]~q\,
	datab => \decimal_printer_inst|state.bcd_data[2][1]~q\,
	datac => \decimal_printer_inst|state.bcd_data[2][0]~q\,
	datad => \decimal_printer_inst|state.bcd_data[2][3]~q\,
	combout => \decimal_printer_inst|Add4~0_combout\);

-- Location: LCCOMB_X66_Y45_N30
\decimal_printer_inst|Add6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add6~0_combout\ = \decimal_printer_inst|state.bcd_data[1][3]~q\ $ (((\decimal_printer_inst|state.bcd_data[1][2]~q\ & (\decimal_printer_inst|state.bcd_data[1][1]~q\ & \decimal_printer_inst|state.bcd_data[1][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[1][3]~q\,
	datab => \decimal_printer_inst|state.bcd_data[1][2]~q\,
	datac => \decimal_printer_inst|state.bcd_data[1][1]~q\,
	datad => \decimal_printer_inst|state.bcd_data[1][0]~q\,
	combout => \decimal_printer_inst|Add6~0_combout\);

-- Location: LCCOMB_X65_Y45_N8
\decimal_printer_inst|Selector42~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector42~0_combout\ = (\decimal_printer_inst|state.number\(3) & \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.number\(3),
	datad => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	combout => \decimal_printer_inst|Selector42~0_combout\);

-- Location: FF_X65_Y45_N9
\decimal_printer_inst|state.bcd_data[0][3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector42~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[0][3]~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[0][3]~q\);

-- Location: LCCOMB_X66_Y45_N24
\decimal_printer_inst|Selector38~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector38~0_combout\ = (\decimal_printer_inst|Add6~0_combout\ & ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\) # ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[0][3]~q\)))) # 
-- (!\decimal_printer_inst|Add6~0_combout\ & (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & ((\decimal_printer_inst|state.bcd_data[0][3]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add6~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datad => \decimal_printer_inst|state.bcd_data[0][3]~q\,
	combout => \decimal_printer_inst|Selector38~0_combout\);

-- Location: FF_X66_Y45_N25
\decimal_printer_inst|state.bcd_data[1][3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector38~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[1][3]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[1][3]~q\);

-- Location: LCCOMB_X66_Y45_N16
\decimal_printer_inst|Selector34~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector34~0_combout\ = (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & ((\decimal_printer_inst|Add4~0_combout\) # ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[1][3]~q\)))) # 
-- (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[1][3]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datab => \decimal_printer_inst|Add4~0_combout\,
	datac => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datad => \decimal_printer_inst|state.bcd_data[1][3]~q\,
	combout => \decimal_printer_inst|Selector34~0_combout\);

-- Location: FF_X66_Y45_N17
\decimal_printer_inst|state.bcd_data[2][3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector34~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[2][0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[2][3]~q\);

-- Location: LCCOMB_X67_Y45_N30
\decimal_printer_inst|Add2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add2~0_combout\ = \decimal_printer_inst|state.bcd_data[3][3]~q\ $ (((\decimal_printer_inst|state.bcd_data[3][1]~q\ & (\decimal_printer_inst|state.bcd_data[3][2]~q\ & \decimal_printer_inst|state.bcd_data[3][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[3][1]~q\,
	datab => \decimal_printer_inst|state.bcd_data[3][2]~q\,
	datac => \decimal_printer_inst|state.bcd_data[3][3]~q\,
	datad => \decimal_printer_inst|state.bcd_data[3][0]~q\,
	combout => \decimal_printer_inst|Add2~0_combout\);

-- Location: LCCOMB_X67_Y45_N8
\decimal_printer_inst|Selector30~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector30~0_combout\ = (\decimal_printer_inst|state.bcd_data[2][3]~q\ & ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\) # ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & \decimal_printer_inst|Add2~0_combout\)))) # 
-- (!\decimal_printer_inst|state.bcd_data[2][3]~q\ & (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (\decimal_printer_inst|Add2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[2][3]~q\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|Add2~0_combout\,
	datad => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector30~0_combout\);

-- Location: FF_X67_Y45_N9
\decimal_printer_inst|state.bcd_data[3][3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector30~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[3][2]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[3][3]~q\);

-- Location: LCCOMB_X67_Y45_N6
\decimal_printer_inst|Selector26~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector26~0_combout\ = (\decimal_printer_inst|Add0~0_combout\ & ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\) # ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & \decimal_printer_inst|state.bcd_data[3][3]~q\)))) # 
-- (!\decimal_printer_inst|Add0~0_combout\ & (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & (\decimal_printer_inst|state.bcd_data[3][3]~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Add0~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.bcd_data[3][3]~q\,
	datad => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	combout => \decimal_printer_inst|Selector26~0_combout\);

-- Location: FF_X67_Y45_N7
\decimal_printer_inst|state.bcd_data[4][3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector26~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	ena => \decimal_printer_inst|state.bcd_data[4][3]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.bcd_data[4][3]~q\);

-- Location: LCCOMB_X67_Y45_N24
\decimal_printer_inst|Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector6~0_combout\ = (!\decimal_printer_inst|state.bcd_data[4][1]~q\ & (!\decimal_printer_inst|state.bcd_data[4][2]~q\ & (!\decimal_printer_inst|state.bcd_data[4][0]~q\ & !\decimal_printer_inst|state.bcd_data[4][3]~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[4][1]~q\,
	datab => \decimal_printer_inst|state.bcd_data[4][2]~q\,
	datac => \decimal_printer_inst|state.bcd_data[4][0]~q\,
	datad => \decimal_printer_inst|state.bcd_data[4][3]~q\,
	combout => \decimal_printer_inst|Selector6~0_combout\);

-- Location: LCCOMB_X66_Y69_N24
\decimal_printer_inst|Selector6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector6~1_combout\ = (!\decimal_printer_inst|state.leading_zero~q\ & (!\decimal_printer_inst|Equal1~0_combout\ & \decimal_printer_inst|Selector6~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.leading_zero~q\,
	datac => \decimal_printer_inst|Equal1~0_combout\,
	datad => \decimal_printer_inst|Selector6~0_combout\,
	combout => \decimal_printer_inst|Selector6~1_combout\);

-- Location: LCCOMB_X66_Y69_N18
\decimal_printer_inst|Selector7~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector7~2_combout\ = (!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & ((\decimal_printer_inst|state.fsm_state.IDLE~q\ & ((!\gfx_instr_full~input_o\))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & (\start~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datac => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	combout => \decimal_printer_inst|Selector7~2_combout\);

-- Location: LCCOMB_X66_Y69_N4
\decimal_printer_inst|Selector1~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector1~5_combout\ = (\decimal_printer_inst|state_nxt~17_combout\ & \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \decimal_printer_inst|state_nxt~17_combout\,
	datad => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	combout => \decimal_printer_inst|Selector1~5_combout\);

-- Location: LCCOMB_X66_Y69_N12
\decimal_printer_inst|Selector7~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector7~4_combout\ = (!\decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ & (!\decimal_printer_inst|Selector1~5_combout\ & ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\) # (!\decimal_printer_inst|Selector7~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\,
	datab => \decimal_printer_inst|Selector7~2_combout\,
	datac => \decimal_printer_inst|Selector1~5_combout\,
	datad => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector7~4_combout\);

-- Location: LCCOMB_X66_Y69_N16
\decimal_printer_inst|Selector7~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector7~3_combout\ = (\decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ & (((\decimal_printer_inst|state.fsm_state.BB~q\ & \decimal_printer_inst|Selector7~4_combout\)) # (!\decimal_printer_inst|Selector6~1_combout\))) # 
-- (!\decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ & (((\decimal_printer_inst|state.fsm_state.BB~q\ & \decimal_printer_inst|Selector7~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\,
	datab => \decimal_printer_inst|Selector6~1_combout\,
	datac => \decimal_printer_inst|state.fsm_state.BB~q\,
	datad => \decimal_printer_inst|Selector7~4_combout\,
	combout => \decimal_printer_inst|Selector7~3_combout\);

-- Location: FF_X66_Y69_N17
\decimal_printer_inst|state.fsm_state.BB\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector7~3_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.BB~q\);

-- Location: FF_X65_Y69_N15
\decimal_printer_inst|state.fsm_state.BB_DATA\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \decimal_printer_inst|state.fsm_state.BB~q\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => VCC,
	ena => \ALT_INV_gfx_instr_full~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.BB_DATA~q\);

-- Location: LCCOMB_X65_Y69_N30
\decimal_printer_inst|Selector6~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector6~2_combout\ = (\decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ & ((\decimal_printer_inst|Selector6~1_combout\) # ((\decimal_printer_inst|Selector7~4_combout\ & \decimal_printer_inst|state.fsm_state.MOVE_X~q\)))) # 
-- (!\decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ & (\decimal_printer_inst|Selector7~4_combout\ & (\decimal_printer_inst|state.fsm_state.MOVE_X~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\,
	datab => \decimal_printer_inst|Selector7~4_combout\,
	datac => \decimal_printer_inst|state.fsm_state.MOVE_X~q\,
	datad => \decimal_printer_inst|Selector6~1_combout\,
	combout => \decimal_printer_inst|Selector6~2_combout\);

-- Location: FF_X65_Y69_N31
\decimal_printer_inst|state.fsm_state.MOVE_X\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector6~2_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.MOVE_X~q\);

-- Location: LCCOMB_X66_Y69_N6
\decimal_printer_inst|Selector9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector9~0_combout\ = (\decimal_printer_inst|state.fsm_state.BB_DATA~q\ & (((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\)) # (!\gfx_instr_full~input_o\))) # (!\decimal_printer_inst|state.fsm_state.BB_DATA~q\ & 
-- (\decimal_printer_inst|state.fsm_state.MOVE_X~q\ & ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\) # (!\gfx_instr_full~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datab => \gfx_instr_full~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datad => \decimal_printer_inst|state.fsm_state.MOVE_X~q\,
	combout => \decimal_printer_inst|Selector9~0_combout\);

-- Location: FF_X66_Y69_N7
\decimal_printer_inst|state.fsm_state.DIGIT_DONE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector9~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\);

-- Location: LCCOMB_X66_Y69_N14
\decimal_printer_inst|state.digit_cnt[0]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.digit_cnt[0]~4_combout\ = (\decimal_printer_inst|Selector1~8_combout\ & (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & (!\decimal_printer_inst|state.digit_cnt\(0)))) # (!\decimal_printer_inst|Selector1~8_combout\ & 
-- (\decimal_printer_inst|state.digit_cnt\(0) $ (((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & !\decimal_printer_inst|Equal1~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101100000011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector1~8_combout\,
	datab => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datac => \decimal_printer_inst|state.digit_cnt\(0),
	datad => \decimal_printer_inst|Equal1~0_combout\,
	combout => \decimal_printer_inst|state.digit_cnt[0]~4_combout\);

-- Location: FF_X66_Y69_N15
\decimal_printer_inst|state.digit_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.digit_cnt[0]~4_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.digit_cnt\(0));

-- Location: LCCOMB_X66_Y69_N22
\decimal_printer_inst|state.digit_cnt[2]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.digit_cnt[2]~5_combout\ = (\decimal_printer_inst|Equal1~0_combout\ & ((\decimal_printer_inst|state.fsm_state.IDLE~q\) # ((!\start~input_o\)))) # (!\decimal_printer_inst|Equal1~0_combout\ & 
-- (!\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & ((\decimal_printer_inst|state.fsm_state.IDLE~q\) # (!\start~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Equal1~0_combout\,
	datab => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datac => \start~input_o\,
	datad => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|state.digit_cnt[2]~5_combout\);

-- Location: LCCOMB_X65_Y69_N22
\decimal_printer_inst|state.digit_cnt[1]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.digit_cnt[1]~3_combout\ = (\decimal_printer_inst|state.digit_cnt[2]~5_combout\ & (((\decimal_printer_inst|state.digit_cnt\(1))))) # (!\decimal_printer_inst|state.digit_cnt[2]~5_combout\ & 
-- (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & (\decimal_printer_inst|state.digit_cnt\(0) $ (\decimal_printer_inst|state.digit_cnt\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datab => \decimal_printer_inst|state.digit_cnt\(0),
	datac => \decimal_printer_inst|state.digit_cnt\(1),
	datad => \decimal_printer_inst|state.digit_cnt[2]~5_combout\,
	combout => \decimal_printer_inst|state.digit_cnt[1]~3_combout\);

-- Location: FF_X65_Y69_N23
\decimal_printer_inst|state.digit_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.digit_cnt[1]~3_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.digit_cnt\(1));

-- Location: LCCOMB_X65_Y69_N28
\decimal_printer_inst|Add8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Add8~0_combout\ = \decimal_printer_inst|state.digit_cnt\(2) $ (((\decimal_printer_inst|state.digit_cnt\(0) & \decimal_printer_inst|state.digit_cnt\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110101001101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.digit_cnt\(2),
	datab => \decimal_printer_inst|state.digit_cnt\(0),
	datac => \decimal_printer_inst|state.digit_cnt\(1),
	combout => \decimal_printer_inst|Add8~0_combout\);

-- Location: LCCOMB_X65_Y69_N2
\decimal_printer_inst|state.digit_cnt[2]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|state.digit_cnt[2]~2_combout\ = (\decimal_printer_inst|state.digit_cnt[2]~5_combout\ & (((\decimal_printer_inst|state.digit_cnt\(2))))) # (!\decimal_printer_inst|state.digit_cnt[2]~5_combout\ & 
-- (\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\ & (\decimal_printer_inst|Add8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	datab => \decimal_printer_inst|Add8~0_combout\,
	datac => \decimal_printer_inst|state.digit_cnt\(2),
	datad => \decimal_printer_inst|state.digit_cnt[2]~5_combout\,
	combout => \decimal_printer_inst|state.digit_cnt[2]~2_combout\);

-- Location: FF_X65_Y69_N3
\decimal_printer_inst|state.digit_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|state.digit_cnt[2]~2_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.digit_cnt\(2));

-- Location: LCCOMB_X65_Y69_N24
\decimal_printer_inst|Equal1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Equal1~0_combout\ = (\decimal_printer_inst|state.digit_cnt\(2) & (!\decimal_printer_inst|state.digit_cnt\(0) & !\decimal_printer_inst|state.digit_cnt\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.digit_cnt\(2),
	datab => \decimal_printer_inst|state.digit_cnt\(0),
	datac => \decimal_printer_inst|state.digit_cnt\(1),
	combout => \decimal_printer_inst|Equal1~0_combout\);

-- Location: LCCOMB_X65_Y69_N8
\decimal_printer_inst|Selector5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector5~0_combout\ = (\decimal_printer_inst|Equal1~0_combout\ & (!\gfx_instr_full~input_o\ & (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\))) # (!\decimal_printer_inst|Equal1~0_combout\ & 
-- ((\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\) # ((!\gfx_instr_full~input_o\ & \decimal_printer_inst|state.fsm_state.SET_GP_y~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Equal1~0_combout\,
	datab => \gfx_instr_full~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector5~0_combout\);

-- Location: FF_X65_Y69_N9
\decimal_printer_inst|state.fsm_state.WRITE_DIGIT\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector5~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\);

-- Location: LCCOMB_X66_Y69_N8
\decimal_printer_inst|Selector1~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector1~4_combout\ = (!\decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ & !\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\,
	datad => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector1~4_combout\);

-- Location: LCCOMB_X66_Y69_N0
\decimal_printer_inst|Selector1~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector1~7_combout\ = (!\decimal_printer_inst|Selector1~6_combout\ & (\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & (!\decimal_printer_inst|state_nxt~17_combout\ & \decimal_printer_inst|Selector1~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector1~6_combout\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \decimal_printer_inst|state_nxt~17_combout\,
	datad => \decimal_printer_inst|Selector1~4_combout\,
	combout => \decimal_printer_inst|Selector1~7_combout\);

-- Location: LCCOMB_X66_Y69_N28
\decimal_printer_inst|Selector1~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector1~9_combout\ = (\decimal_printer_inst|Selector1~7_combout\) # ((!\decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\ & (\decimal_printer_inst|Selector1~8_combout\ & !\decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.WRITE_DIGIT~q\,
	datab => \decimal_printer_inst|Selector1~7_combout\,
	datac => \decimal_printer_inst|Selector1~8_combout\,
	datad => \decimal_printer_inst|state.fsm_state.DIGIT_DONE~q\,
	combout => \decimal_printer_inst|Selector1~9_combout\);

-- Location: FF_X66_Y69_N29
\decimal_printer_inst|state.fsm_state.CALC_DIGITS\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector1~9_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\);

-- Location: LCCOMB_X66_Y69_N30
\decimal_printer_inst|Selector1~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector1~6_combout\ = (\decimal_printer_inst|state.fsm_state.IDLE~q\ & (((!\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\ & !\gfx_instr_full~input_o\)))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\ & (\start~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \start~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	combout => \decimal_printer_inst|Selector1~6_combout\);

-- Location: LCCOMB_X66_Y69_N10
\decimal_printer_inst|Selector2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector2~0_combout\ = (\decimal_printer_inst|Selector1~4_combout\ & ((\decimal_printer_inst|Selector1~5_combout\) # ((!\decimal_printer_inst|Selector1~6_combout\ & \decimal_printer_inst|state.fsm_state.SET_GP~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector1~6_combout\,
	datab => \decimal_printer_inst|Selector1~5_combout\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP~q\,
	datad => \decimal_printer_inst|Selector1~4_combout\,
	combout => \decimal_printer_inst|Selector2~0_combout\);

-- Location: FF_X66_Y69_N11
\decimal_printer_inst|state.fsm_state.SET_GP\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \decimal_printer_inst|Selector2~0_combout\,
	clrn => \res_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.SET_GP~q\);

-- Location: FF_X65_Y69_N19
\decimal_printer_inst|state.fsm_state.SET_GP_X\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \decimal_printer_inst|state.fsm_state.SET_GP~q\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => VCC,
	ena => \ALT_INV_gfx_instr_full~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\);

-- Location: FF_X65_Y69_N27
\decimal_printer_inst|state.fsm_state.SET_GP_y\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	clrn => \res_n~inputclkctrl_outclk\,
	sload => VCC,
	ena => \ALT_INV_gfx_instr_full~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\);

-- Location: IOIBUF_X115_Y37_N8
\y[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(0),
	o => \y[0]~input_o\);

-- Location: IOIBUF_X115_Y37_N1
\x[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(0),
	o => \x[0]~input_o\);

-- Location: LCCOMB_X114_Y44_N16
\decimal_printer_inst|Selector65~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector65~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & ((\y[0]~input_o\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[0]~input_o\)))) # (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & 
-- (((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datab => \y[0]~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datad => \x[0]~input_o\,
	combout => \decimal_printer_inst|Selector65~0_combout\);

-- Location: LCCOMB_X114_Y44_N10
\decimal_printer_inst|Selector65~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector65~1_combout\ = (!\gfx_instr_full~input_o\ & \decimal_printer_inst|Selector65~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector65~0_combout\,
	combout => \decimal_printer_inst|Selector65~1_combout\);

-- Location: IOIBUF_X115_Y41_N1
\y[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(1),
	o => \y[1]~input_o\);

-- Location: IOIBUF_X115_Y42_N15
\x[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(1),
	o => \x[1]~input_o\);

-- Location: LCCOMB_X114_Y44_N28
\decimal_printer_inst|Selector64~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector64~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & ((\y[1]~input_o\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[1]~input_o\)))) # (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & 
-- (((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datab => \y[1]~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datad => \x[1]~input_o\,
	combout => \decimal_printer_inst|Selector64~0_combout\);

-- Location: LCCOMB_X114_Y44_N14
\decimal_printer_inst|Selector64~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector64~1_combout\ = (!\gfx_instr_full~input_o\ & \decimal_printer_inst|Selector64~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector64~0_combout\,
	combout => \decimal_printer_inst|Selector64~1_combout\);

-- Location: IOIBUF_X65_Y73_N8
\x[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(2),
	o => \x[2]~input_o\);

-- Location: IOIBUF_X65_Y73_N22
\y[2]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(2),
	o => \y[2]~input_o\);

-- Location: LCCOMB_X65_Y69_N20
\decimal_printer_inst|Selector63~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector63~2_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & ((\x[2]~input_o\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[2]~input_o\)))) # (!\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & 
-- (((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datab => \x[2]~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \y[2]~input_o\,
	combout => \decimal_printer_inst|Selector63~2_combout\);

-- Location: LCCOMB_X65_Y69_N14
\decimal_printer_inst|Selector63~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector63~4_combout\ = (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|state.fsm_state.MOVE_X~q\) # ((\decimal_printer_inst|state.fsm_state.BB_DATA~q\) # (\decimal_printer_inst|Selector63~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.MOVE_X~q\,
	datab => \gfx_instr_full~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datad => \decimal_printer_inst|Selector63~2_combout\,
	combout => \decimal_printer_inst|Selector63~4_combout\);

-- Location: IOIBUF_X62_Y73_N22
\x[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(3),
	o => \x[3]~input_o\);

-- Location: IOIBUF_X69_Y73_N22
\y[3]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(3),
	o => \y[3]~input_o\);

-- Location: LCCOMB_X65_Y69_N0
\decimal_printer_inst|Selector62~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector62~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & ((\y[3]~input_o\) # ((\x[3]~input_o\ & \decimal_printer_inst|state.fsm_state.SET_GP_X~q\)))) # (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & 
-- (\x[3]~input_o\ & (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datab => \x[3]~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datad => \y[3]~input_o\,
	combout => \decimal_printer_inst|Selector62~0_combout\);

-- Location: LCCOMB_X65_Y69_N12
\decimal_printer_inst|Selector63~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector63~3_combout\ = (!\decimal_printer_inst|state.fsm_state.BB_DATA~q\ & !\decimal_printer_inst|state.fsm_state.MOVE_X~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datac => \decimal_printer_inst|state.fsm_state.MOVE_X~q\,
	combout => \decimal_printer_inst|Selector63~3_combout\);

-- Location: LCCOMB_X65_Y69_N16
\decimal_printer_inst|Selector62~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector62~1_combout\ = (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|state.fsm_state.BB~q\) # ((\decimal_printer_inst|Selector62~0_combout\) # (!\decimal_printer_inst|Selector63~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.BB~q\,
	datab => \decimal_printer_inst|Selector62~0_combout\,
	datac => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector63~3_combout\,
	combout => \decimal_printer_inst|Selector62~1_combout\);

-- Location: IOIBUF_X115_Y44_N8
\y[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(4),
	o => \y[4]~input_o\);

-- Location: IOIBUF_X115_Y46_N8
\x[4]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(4),
	o => \x[4]~input_o\);

-- Location: LCCOMB_X114_Y44_N24
\decimal_printer_inst|Selector61~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector61~0_combout\ = (\y[4]~input_o\ & ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[4]~input_o\)))) # (!\y[4]~input_o\ & 
-- (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & ((\x[4]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y[4]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \x[4]~input_o\,
	combout => \decimal_printer_inst|Selector61~0_combout\);

-- Location: LCCOMB_X114_Y44_N18
\decimal_printer_inst|Selector61~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector61~1_combout\ = (!\gfx_instr_full~input_o\ & \decimal_printer_inst|Selector61~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector61~0_combout\,
	combout => \decimal_printer_inst|Selector61~1_combout\);

-- Location: IOIBUF_X115_Y41_N8
\y[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(5),
	o => \y[5]~input_o\);

-- Location: IOIBUF_X115_Y45_N15
\x[5]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(5),
	o => \x[5]~input_o\);

-- Location: LCCOMB_X114_Y44_N4
\decimal_printer_inst|Selector60~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector60~0_combout\ = (\y[5]~input_o\ & ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[5]~input_o\)))) # (!\y[5]~input_o\ & 
-- (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & ((\x[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y[5]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \x[5]~input_o\,
	combout => \decimal_printer_inst|Selector60~0_combout\);

-- Location: LCCOMB_X114_Y44_N6
\decimal_printer_inst|Selector60~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector60~1_combout\ = (!\gfx_instr_full~input_o\ & \decimal_printer_inst|Selector60~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datac => \decimal_printer_inst|Selector60~0_combout\,
	combout => \decimal_printer_inst|Selector60~1_combout\);

-- Location: IOIBUF_X74_Y73_N15
\x[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(6),
	o => \x[6]~input_o\);

-- Location: IOIBUF_X81_Y73_N22
\y[6]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(6),
	o => \y[6]~input_o\);

-- Location: LCCOMB_X73_Y69_N0
\decimal_printer_inst|Selector59~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector59~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & (((\y[6]~input_o\)))) # (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & (\x[6]~input_o\ & (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \x[6]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \y[6]~input_o\,
	combout => \decimal_printer_inst|Selector59~0_combout\);

-- Location: LCCOMB_X73_Y69_N2
\decimal_printer_inst|Selector59~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector59~1_combout\ = (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|Selector59~0_combout\) # (\decimal_printer_inst|state.fsm_state.BB_DATA~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|Selector59~0_combout\,
	datac => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector59~1_combout\);

-- Location: IOIBUF_X79_Y73_N8
\x[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(7),
	o => \x[7]~input_o\);

-- Location: IOIBUF_X83_Y73_N22
\y[7]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(7),
	o => \y[7]~input_o\);

-- Location: LCCOMB_X73_Y69_N12
\decimal_printer_inst|Selector58~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector58~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & (((\y[7]~input_o\)))) # (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & (\x[7]~input_o\ & (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \x[7]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \y[7]~input_o\,
	combout => \decimal_printer_inst|Selector58~0_combout\);

-- Location: LCCOMB_X73_Y69_N14
\decimal_printer_inst|Selector58~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector58~1_combout\ = (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|Selector58~0_combout\) # (\decimal_printer_inst|state.fsm_state.BB_DATA~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector58~0_combout\,
	datac => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector58~1_combout\);

-- Location: IOIBUF_X115_Y45_N22
\x[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(8),
	o => \x[8]~input_o\);

-- Location: IOIBUF_X115_Y47_N22
\y[8]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(8),
	o => \y[8]~input_o\);

-- Location: LCCOMB_X114_Y44_N0
\decimal_printer_inst|Selector57~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector57~0_combout\ = (\x[8]~input_o\ & ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[8]~input_o\)))) # (!\x[8]~input_o\ & 
-- (((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \x[8]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \y[8]~input_o\,
	combout => \decimal_printer_inst|Selector57~0_combout\);

-- Location: LCCOMB_X114_Y44_N26
\decimal_printer_inst|Selector57~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector57~1_combout\ = (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|state.fsm_state.BB~q\) # (\decimal_printer_inst|Selector57~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datac => \decimal_printer_inst|state.fsm_state.BB~q\,
	datad => \decimal_printer_inst|Selector57~0_combout\,
	combout => \decimal_printer_inst|Selector57~1_combout\);

-- Location: IOIBUF_X115_Y40_N1
\x[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(9),
	o => \x[9]~input_o\);

-- Location: IOIBUF_X115_Y46_N1
\y[9]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(9),
	o => \y[9]~input_o\);

-- Location: LCCOMB_X114_Y44_N12
\decimal_printer_inst|Selector56~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector56~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & ((\y[9]~input_o\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[9]~input_o\)))) # (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & 
-- (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & (\x[9]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \x[9]~input_o\,
	datad => \y[9]~input_o\,
	combout => \decimal_printer_inst|Selector56~0_combout\);

-- Location: LCCOMB_X114_Y44_N22
\decimal_printer_inst|Selector56~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector56~1_combout\ = (!\gfx_instr_full~input_o\ & \decimal_printer_inst|Selector56~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector56~0_combout\,
	combout => \decimal_printer_inst|Selector56~1_combout\);

-- Location: IOIBUF_X115_Y43_N8
\y[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(10),
	o => \y[10]~input_o\);

-- Location: IOIBUF_X115_Y44_N1
\x[10]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(10),
	o => \x[10]~input_o\);

-- Location: LCCOMB_X114_Y44_N8
\decimal_printer_inst|Selector55~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector55~0_combout\ = (\y[10]~input_o\ & ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[10]~input_o\)))) # (!\y[10]~input_o\ & 
-- (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & ((\x[10]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \y[10]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \x[10]~input_o\,
	combout => \decimal_printer_inst|Selector55~0_combout\);

-- Location: LCCOMB_X114_Y44_N2
\decimal_printer_inst|Selector55~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector55~1_combout\ = (!\gfx_instr_full~input_o\ & \decimal_printer_inst|Selector55~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datac => \decimal_printer_inst|Selector55~0_combout\,
	combout => \decimal_printer_inst|Selector55~1_combout\);

-- Location: IOIBUF_X115_Y47_N15
\x[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(11),
	o => \x[11]~input_o\);

-- Location: IOIBUF_X115_Y50_N8
\y[11]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(11),
	o => \y[11]~input_o\);

-- Location: LCCOMB_X114_Y44_N20
\decimal_printer_inst|Selector54~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector54~0_combout\ = (\x[11]~input_o\ & ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[11]~input_o\)))) # (!\x[11]~input_o\ & 
-- (((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[11]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \x[11]~input_o\,
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \y[11]~input_o\,
	combout => \decimal_printer_inst|Selector54~0_combout\);

-- Location: LCCOMB_X114_Y44_N30
\decimal_printer_inst|Selector54~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector54~1_combout\ = (!\gfx_instr_full~input_o\ & \decimal_printer_inst|Selector54~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector54~0_combout\,
	combout => \decimal_printer_inst|Selector54~1_combout\);

-- Location: IOIBUF_X85_Y73_N15
\y[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(12),
	o => \y[12]~input_o\);

-- Location: LCCOMB_X73_Y69_N24
\decimal_printer_inst|Selector53~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector53~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & ((\y[12]~input_o\) # ((\decimal_printer_inst|state.fsm_state.BB_DATA~q\ & \decimal_printer_inst|state.bcd_data[4][0]~q\)))) # 
-- (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & (\decimal_printer_inst|state.fsm_state.BB_DATA~q\ & ((\decimal_printer_inst|state.bcd_data[4][0]~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datab => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datac => \y[12]~input_o\,
	datad => \decimal_printer_inst|state.bcd_data[4][0]~q\,
	combout => \decimal_printer_inst|Selector53~0_combout\);

-- Location: IOIBUF_X72_Y73_N8
\x[12]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(12),
	o => \x[12]~input_o\);

-- Location: LCCOMB_X65_Y69_N4
\decimal_printer_inst|Selector53~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector53~1_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[12]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.SET_GP~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datad => \x[12]~input_o\,
	combout => \decimal_printer_inst|Selector53~1_combout\);

-- Location: LCCOMB_X73_Y69_N26
\decimal_printer_inst|Selector53~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector53~2_combout\ = (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|Selector53~0_combout\) # (\decimal_printer_inst|Selector53~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|Selector53~0_combout\,
	datac => \decimal_printer_inst|Selector53~1_combout\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector53~2_combout\);

-- Location: LCCOMB_X73_Y69_N6
\decimal_printer_inst|Selector51~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector51~0_combout\ = (!\decimal_printer_inst|state.fsm_state.BB~q\ & (!\decimal_printer_inst|state.fsm_state.BB_DATA~q\ & ((!\gfx_instr_full~input_o\) # (!\decimal_printer_inst|state.fsm_state.SET_GP_y~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datab => \decimal_printer_inst|state.fsm_state.BB~q\,
	datac => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector51~0_combout\);

-- Location: LCCOMB_X73_Y69_N10
\decimal_printer_inst|Selector51~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector51~2_combout\ = (\decimal_printer_inst|state.fsm_state.BB_DATA~q\) # (\decimal_printer_inst|state.fsm_state.BB~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datad => \decimal_printer_inst|state.fsm_state.BB~q\,
	combout => \decimal_printer_inst|Selector51~2_combout\);

-- Location: LCCOMB_X73_Y69_N16
\decimal_printer_inst|Selector51~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector51~1_combout\ = (\decimal_printer_inst|state.fsm_state.BB_DATA~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & !\decimal_printer_inst|state.fsm_state.BB~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datac => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datad => \decimal_printer_inst|state.fsm_state.BB~q\,
	combout => \decimal_printer_inst|Selector51~1_combout\);

-- Location: LCCOMB_X73_Y69_N20
\decimal_printer_inst|Selector52~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector52~1_combout\ = (\decimal_printer_inst|Selector51~2_combout\ & (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|state.bcd_data[4][1]~q\) # (!\decimal_printer_inst|Selector51~1_combout\)))) # 
-- (!\decimal_printer_inst|Selector51~2_combout\ & (!\decimal_printer_inst|Selector51~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000110110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector51~2_combout\,
	datab => \decimal_printer_inst|Selector51~1_combout\,
	datac => \decimal_printer_inst|state.bcd_data[4][1]~q\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector52~1_combout\);

-- Location: IOIBUF_X81_Y73_N1
\x[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(13),
	o => \x[13]~input_o\);

-- Location: LCCOMB_X73_Y69_N4
\decimal_printer_inst|Selector52~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector52~0_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & (\x[13]~input_o\ & !\gfx_instr_full~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \x[13]~input_o\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector52~0_combout\);

-- Location: IOIBUF_X83_Y73_N8
\y[13]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(13),
	o => \y[13]~input_o\);

-- Location: LCCOMB_X73_Y69_N22
\decimal_printer_inst|Selector52\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector52~combout\ = (\decimal_printer_inst|Selector51~0_combout\ & ((\decimal_printer_inst|Selector52~1_combout\ & (\decimal_printer_inst|Selector52~0_combout\)) # (!\decimal_printer_inst|Selector52~1_combout\ & 
-- ((\y[13]~input_o\))))) # (!\decimal_printer_inst|Selector51~0_combout\ & (\decimal_printer_inst|Selector52~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector51~0_combout\,
	datab => \decimal_printer_inst|Selector52~1_combout\,
	datac => \decimal_printer_inst|Selector52~0_combout\,
	datad => \y[13]~input_o\,
	combout => \decimal_printer_inst|Selector52~combout\);

-- Location: LCCOMB_X73_Y69_N18
\decimal_printer_inst|Selector51~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector51~4_combout\ = (\decimal_printer_inst|Selector51~2_combout\ & (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|state.bcd_data[4][2]~q\) # (!\decimal_printer_inst|Selector51~1_combout\)))) # 
-- (!\decimal_printer_inst|Selector51~2_combout\ & (!\decimal_printer_inst|Selector51~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000110110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector51~2_combout\,
	datab => \decimal_printer_inst|Selector51~1_combout\,
	datac => \decimal_printer_inst|state.bcd_data[4][2]~q\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector51~4_combout\);

-- Location: IOIBUF_X79_Y73_N1
\x[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(14),
	o => \x[14]~input_o\);

-- Location: LCCOMB_X73_Y69_N8
\decimal_printer_inst|Selector51~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector51~3_combout\ = (\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & (\x[14]~input_o\ & !\gfx_instr_full~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datac => \x[14]~input_o\,
	datad => \gfx_instr_full~input_o\,
	combout => \decimal_printer_inst|Selector51~3_combout\);

-- Location: IOIBUF_X81_Y73_N8
\y[14]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(14),
	o => \y[14]~input_o\);

-- Location: LCCOMB_X73_Y69_N28
\decimal_printer_inst|Selector51\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector51~combout\ = (\decimal_printer_inst|Selector51~0_combout\ & ((\decimal_printer_inst|Selector51~4_combout\ & (\decimal_printer_inst|Selector51~3_combout\)) # (!\decimal_printer_inst|Selector51~4_combout\ & 
-- ((\y[14]~input_o\))))) # (!\decimal_printer_inst|Selector51~0_combout\ & (\decimal_printer_inst|Selector51~4_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|Selector51~0_combout\,
	datab => \decimal_printer_inst|Selector51~4_combout\,
	datac => \decimal_printer_inst|Selector51~3_combout\,
	datad => \y[14]~input_o\,
	combout => \decimal_printer_inst|Selector51~combout\);

-- Location: IOIBUF_X67_Y73_N22
\y[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_y(15),
	o => \y[15]~input_o\);

-- Location: LCCOMB_X65_Y69_N26
\decimal_printer_inst|Selector50~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector50~0_combout\ = (\decimal_printer_inst|state.bcd_data[4][3]~q\ & ((\decimal_printer_inst|state.fsm_state.BB_DATA~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[15]~input_o\)))) # 
-- (!\decimal_printer_inst|state.bcd_data[4][3]~q\ & (((\decimal_printer_inst|state.fsm_state.SET_GP_y~q\ & \y[15]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.bcd_data[4][3]~q\,
	datab => \decimal_printer_inst|state.fsm_state.BB_DATA~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_y~q\,
	datad => \y[15]~input_o\,
	combout => \decimal_printer_inst|Selector50~0_combout\);

-- Location: IOIBUF_X69_Y73_N15
\x[15]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_x(15),
	o => \x[15]~input_o\);

-- Location: LCCOMB_X65_Y69_N18
\decimal_printer_inst|Selector50~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector50~1_combout\ = (\decimal_printer_inst|state.fsm_state.MOVE_X~q\) # ((\decimal_printer_inst|state.fsm_state.SET_GP_X~q\ & \x[15]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.MOVE_X~q\,
	datac => \decimal_printer_inst|state.fsm_state.SET_GP_X~q\,
	datad => \x[15]~input_o\,
	combout => \decimal_printer_inst|Selector50~1_combout\);

-- Location: LCCOMB_X65_Y69_N6
\decimal_printer_inst|Selector50~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector50~2_combout\ = (!\gfx_instr_full~input_o\ & ((\decimal_printer_inst|Selector50~0_combout\) # (\decimal_printer_inst|Selector50~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \decimal_printer_inst|Selector50~0_combout\,
	datac => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector50~1_combout\,
	combout => \decimal_printer_inst|Selector50~2_combout\);

-- Location: LCCOMB_X65_Y69_N10
\decimal_printer_inst|Selector49~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \decimal_printer_inst|Selector49~0_combout\ = ((\decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\) # ((\gfx_instr_full~input_o\) # (!\decimal_printer_inst|Selector1~4_combout\))) # (!\decimal_printer_inst|state.fsm_state.IDLE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \decimal_printer_inst|state.fsm_state.IDLE~q\,
	datab => \decimal_printer_inst|state.fsm_state.CALC_DIGITS~q\,
	datac => \gfx_instr_full~input_o\,
	datad => \decimal_printer_inst|Selector1~4_combout\,
	combout => \decimal_printer_inst|Selector49~0_combout\);

ww_gfx_instr(0) <= \gfx_instr[0]~output_o\;

ww_gfx_instr(1) <= \gfx_instr[1]~output_o\;

ww_gfx_instr(2) <= \gfx_instr[2]~output_o\;

ww_gfx_instr(3) <= \gfx_instr[3]~output_o\;

ww_gfx_instr(4) <= \gfx_instr[4]~output_o\;

ww_gfx_instr(5) <= \gfx_instr[5]~output_o\;

ww_gfx_instr(6) <= \gfx_instr[6]~output_o\;

ww_gfx_instr(7) <= \gfx_instr[7]~output_o\;

ww_gfx_instr(8) <= \gfx_instr[8]~output_o\;

ww_gfx_instr(9) <= \gfx_instr[9]~output_o\;

ww_gfx_instr(10) <= \gfx_instr[10]~output_o\;

ww_gfx_instr(11) <= \gfx_instr[11]~output_o\;

ww_gfx_instr(12) <= \gfx_instr[12]~output_o\;

ww_gfx_instr(13) <= \gfx_instr[13]~output_o\;

ww_gfx_instr(14) <= \gfx_instr[14]~output_o\;

ww_gfx_instr(15) <= \gfx_instr[15]~output_o\;

ww_gfx_instr_wr <= \gfx_instr_wr~output_o\;

ww_busy <= \busy~output_o\;
END structure;


