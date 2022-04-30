library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.vga_gfx_cntrl_pkg.all;

package tetris_util_pkg is
	subtype tetromino_t is std_logic_vector(2 downto 0);
	constant TET_T : tetromino_t := "000";
	constant TET_I : tetromino_t := "001";
	constant TET_O : tetromino_t := "010";
	constant TET_S : tetromino_t := "011";
	constant TET_Z : tetromino_t := "100";
	constant TET_J : tetromino_t := "101";
	constant TET_L : tetromino_t := "110";
	--constant TET_DOT: tetromino_t := "111";
	
	subtype rotation_t is std_logic_vector(1 downto 0);
	constant ROT_0   : rotation_t := "00";
	constant ROT_90  : rotation_t := "01";
	constant ROT_180 : rotation_t := "10";
	constant ROT_270 : rotation_t := "11";
	
	subtype tetromino_blocks_t is std_logic_vector(15 downto 0);
	
	
	-- Example: get_blocks(TET_Z, ROT_0) = 0x4c80
	--  ┌──┬──┬──┬──┐
	--  │  │██│  │  │ 0x4
	--  ├──┼██┼──┼──┤
	--  │█████│  │  │ 0xc
	--  ├██┼──┼──┼──┤
	--  │██│  │  │  │ 0x8
	--  ├──┼──┼──┼──┤
	--  │  │  │  │  │ 0x0
	--  └──┴──┴──┴──┘
	--     0x4c80
	function get_blocks(tetromino : tetromino_t; rotation : std_logic_vector(1 downto 0)) return std_logic_vector;
	
	
	-- tetromio coordinate system
	--     0  1  2  3
	--   ┼──┼──┼──┼──┼─► x
	-- 0 │15│14│13│12│
	--   ┼──┼──┼──┼──┤
	-- 1 │11│10│ 9│ 8│
	--   ┼──┼──┼──┼──┤
	-- 2 │ 7│ 6│ 5│ 4│
	--   ┼──┼──┼──┼──┤
	-- 3 │ 3│ 2│ 1│ 0│
	--   ┼──┴──┴──┴──┘
	--   ▼
	--   y
	function is_tetromino_solid_at(tetromino : tetromino_t; rotation : rotation_t; x, y : std_logic_vector(1 downto 0)) return boolean;
	
	
	component tetromino_collider is
		generic (
			BLOCKS_X : integer;
			BLOCKS_Y : integer
		);
		port (
			clk : in std_logic;
			res_n : in std_logic;
			start : in std_logic;
			busy : out std_logic;
			collision_detected : out std_logic;
			tetromino_x : in std_logic_vector(log2c(BLOCKS_X) downto 0);
			tetromino_y : in std_logic_vector(log2c(BLOCKS_Y) downto 0);
			tetromino : in tetromino_t;
			rotation : in rotation_t;
			block_map_x : out std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
			block_map_y : out std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
			block_map_rd : out std_logic;
			block_map_solid : in std_logic
		);
	end component;
	
	component tetromino_drawer is
		generic (
			BLOCK_SIZE : integer;
			BLOCK_ROW : integer
		);
		port (
			clk : in std_logic;
			res_n : in std_logic;
			start : in std_logic;
			busy : out std_logic;
			x : in std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
			y : in std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
			tetromino : in tetromino_t;
			rotation : in rotation_t;
			gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
			gfx_instr_wr : out std_logic;
			gfx_instr_full : in std_logic
		);
	end component;
end package;


package body tetris_util_pkg is

	function is_tetromino_solid_at(tetromino : tetromino_t; rotation : rotation_t; x, y : std_logic_vector(1 downto 0)) return boolean is
		variable tetromino_blocks : tetromino_blocks_t;
	begin
		tetromino_blocks := get_blocks(tetromino, rotation);
		return tetromino_blocks(to_integer(unsigned((not y) & (not x)))) = '1';
	end function;
	
	function get_blocks(tetromino : std_logic_vector(2 downto 0); rotation : std_logic_vector(1 downto 0)) return std_logic_vector is
		variable ret_val : std_logic_vector(15 downto 0);
	begin
		case tetromino is
			when TET_T =>
				case rotation is
					when "00" => ret_val := x"4e00";
					when "01" => ret_val := x"4640";
					when "10" => ret_val := x"0e40";
					when "11" => ret_val := x"4c40";
					when others => ret_val := x"0000";
				end case;

			when TET_I => 
				case rotation(0) is
					when '0' => ret_val := x"4444";
					when '1' => ret_val := x"0f00";
					when others => ret_val := x"0000";
				end case;

			when TET_O =>
				ret_val := x"0660";

			when TET_S =>
				case rotation(0) is
					when '0' => ret_val := x"6c00";
					when '1' => ret_val := x"8c40";
					when others => ret_val := x"0000";
				end case;

			when TET_Z =>
				case rotation(0) is
					when '0' => ret_val := x"c600";
					when '1' => ret_val := x"4c80";
					when others => ret_val := x"0000";
				end case;

			when TET_L =>
				case rotation is
					when "00" => ret_val := x"4460";
					when "01" => ret_val := x"e800";
					when "10" => ret_val := x"c440";
					when "11" => ret_val := x"2e00";
					when others => ret_val := x"0000";
				end case;

			when TET_J =>
				case rotation is
					when "00" => ret_val := x"44c0";
					when "01" => ret_val := x"8e00";
					when "10" => ret_val := x"c880";
					when "11" => ret_val := x"e200";
					when others => ret_val := x"0000";
				end case;

			when others => ret_val := x"0000";
		end case;
		return ret_val;
	end function;

end package body;
