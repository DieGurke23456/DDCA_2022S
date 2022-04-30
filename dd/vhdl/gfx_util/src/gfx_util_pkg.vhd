library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package gfx_util_pkg is

	type bb_rom_t is array(natural range<>) of std_logic_vector;

	component gfx_line is
		generic (
			DATA_WIDTH : integer
		);
		port (
			clk : in std_logic;
			res_n : in std_logic;
			start : in std_logic;
			stall : in std_logic;
			busy : out std_logic;
			x0 : in std_logic_vector(DATA_WIDTH-1 downto 0);
			y0 : in std_logic_vector(DATA_WIDTH-1 downto 0);
			x1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
			y1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
			pixel_valid : out std_logic;
			pixel_x : out std_logic_vector(DATA_WIDTH-1 downto 0);
			pixel_y : out std_logic_vector(DATA_WIDTH-1 downto 0)
		);
	end component;
	
	component gfx_bb is
		generic (
			DATA_WIDTH : integer;
			BB_ROM : bb_rom_t
		);
		port (
			clk : in std_logic;
			res_n : in std_logic;
			start : in std_logic;
			stall : in std_logic;
			busy : out std_logic;
			w : in std_logic_vector(DATA_WIDTH-1 downto 0);
			h : in std_logic_vector(DATA_WIDTH-1 downto 0);
			x_src : in std_logic_vector(DATA_WIDTH-1 downto 0);
			y_src : in std_logic_vector(DATA_WIDTH-1 downto 0);
			x_dest : in std_logic_vector(DATA_WIDTH-1 downto 0);
			y_dest : in std_logic_vector(DATA_WIDTH-1 downto 0);
			vflip : in std_logic;
			hflip : in std_logic;
			pixel_valid : out std_logic;
			pixel_color : out std_logic_vector(3 downto 0);
			pixel_x : out std_logic_vector(DATA_WIDTH-1 downto 0);
			pixel_y : out std_logic_vector(DATA_WIDTH-1 downto 0)
		);
	end component;
end package;

