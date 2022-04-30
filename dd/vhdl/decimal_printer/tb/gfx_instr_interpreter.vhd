library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use std.textio.all;
use ieee.std_logic_textio.all;

use work.gfx_util_pkg.all;
use work.vga_gfx_cntrl_pkg.all;
use work.bb_rom_pkg.all;
use work.image_buffer_pkg.all;
use work.math_pkg.all;

entity gfx_instr_interpreter is
	generic (
		OUTPUT_DIR : string := "./";
		BB_ROM : bb_rom_t := MEMORY_CONTENTS
	);
	port (
		clk   : in std_logic;

		gfx_instr       : in std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
		gfx_instr_wr    : in std_logic;
		gfx_frame_sync  : out std_logic;
		
		dump_frame : in std_logic
	);
end entity;



architecture arch of gfx_instr_interpreter is
	constant WIDTH : integer := 320;
	constant HEIGHT : integer := 240;
	
	--use this signal to store the color palettes
	type color_array_t is array(natural range<>) of std_logic_vector(15 downto 0);
	signal palette : color_array_t(0 to 16*32-1) := (others=>x"0000");

	-- you can use these signals for the internal registers 
	signal gp_x : std_logic_vector(15 downto 0) := (others=>'0');
	signal gp_y : std_logic_vector(15 downto 0) := (others=>'0');
	signal selected_palette : std_logic_vector(4 downto 0) := (others=>'0');
	signal alpha_color : std_logic_vector(3 downto 0) := (others=>'0');
	
	
	shared variable img : image_buffer_t;
	
	--gets the actual 16-bit color value from the currently selected palette
	impure function get_palette_color(color : std_logic_vector(3 downto 0)) return std_logic_vector is
	begin
		return palette(to_integer(unsigned(selected_palette) * 16 + unsigned(color)));
	end function;

	--gets a pixel (4-bit) from the bit blitter memory
	function get_pixel_bb_rom(x,y : integer) return std_logic_vector is
		constant BB_ROM_ADDR_WIDTH : integer := log2c(BB_ROM'length);
	begin
		return BB_ROM(y*(2**(BB_ROM_ADDR_WIDTH/2)) + x);
	end function;

begin
	--be sure to initalize your image buffer(s)
	init_buffers : process
	begin
		img.Init(WIDTH, HEIGHT, 16);
		wait;
	end process;

	demo_access : process
	begin
		wait for 1 ns;
		report "write to the pixel in the top left corner";
		img.set_pixel(0, 0, x"0000");
		assert img.get_pixel(0, 0) = x"0000" severity error;
		
		report "write to the pixel at position x=y=1";
		img.set_pixel(1, 1, get_palette_color(get_pixel_bb_rom(42,42)));
		assert img.get_pixel(1, 1) = get_palette_color(get_pixel_bb_rom(42,42)) severity error;
		wait;
	end process;
	
	
	demo_access2 : process
	begin
		wait for 2 ns;
		report "shared variables can be accessed from multiple processes!";
		report "write to the pixel in the lower right corner";
		img.set_pixel(319, 239, x"ddca");
		assert img.get_pixel(319, 239) = x"ddca" severity error;
		report "done";
		wait;
	end process;
end architecture;
