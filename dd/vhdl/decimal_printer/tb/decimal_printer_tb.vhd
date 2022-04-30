library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


use work.vga_gfx_cntrl_pkg.all;
use work.gfx_util_pkg.all;
use work.vga_gfx_cntrl_pkg.all;
use work.bb_rom_pkg.all;
use work.decimal_printer_pkg.all;

entity decimal_printer_tb is
end entity;

architecture bench of decimal_printer_tb is

	signal clk : std_logic;
	signal res_n : std_logic;
	signal gfx_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal gfx_instr_wr : std_logic;
	signal gfx_instr_full : std_logic;
	signal gfx_frame_sync : std_logic;
	signal start : std_logic;
	signal busy : std_logic;
	signal x : std_logic_vector(15 downto 0);
	signal y : std_logic_vector(15 downto 0);
	signal number : std_logic_vector(15 downto 0);

	signal dump_frame : std_logic;

	signal init_gfx_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal init_gfx_instr_wr : std_logic;
begin

	uut : decimal_printer
	port map (
		clk            => clk,
		res_n          => res_n,
		gfx_instr      => gfx_instr,
		gfx_instr_wr   => gfx_instr_wr,
		gfx_instr_full => gfx_instr_full,
		start          => start,
		busy           => busy,
		x              => x,
		y              => y,
		number         => number
	);

	stimulus : process
	begin
		wait;
	end process;

	interpreter : block
		signal interpreter_gfx_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	begin
		interpreter_gfx_instr <= gfx_instr when gfx_instr_wr = '1' else init_gfx_instr;
	
		gfx_instr_interpreter_inst : entity work.gfx_instr_interpreter
		generic map (
			OUTPUT_DIR => "./",
			BB_ROM => MEMORY_CONTENTS
		)
		port map (
			clk            => clk,
			gfx_instr      => interpreter_gfx_instr,
			gfx_instr_wr   => gfx_instr_wr or init_gfx_instr_wr,
			gfx_frame_sync => gfx_frame_sync,
			dump_frame     => dump_frame
		);
	end block;

end architecture;

