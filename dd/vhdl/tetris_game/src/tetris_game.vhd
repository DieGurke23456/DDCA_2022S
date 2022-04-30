library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.vga_gfx_cntrl_pkg.all;
use work.math_pkg.all;
use work.gc_cntrl_pkg.all;
use work.audio_cntrl_pkg.all;
use work.ram_pkg.all;
use work.tetris_util_pkg.all;

entity tetris_game is
	port (
		clk : in std_logic;
		res_n : in std_logic;
		
		--connection to the VGA graphics controller
		gfx_instr       : out std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
		gfx_instr_wr    : out std_logic;
		gfx_instr_full  : in std_logic;
		gfx_frame_sync  : in std_logic;
		
		--connection to the GameCube controller
		gc_cntrl_state : in gc_cntrl_state_t;
		gc_cntrl_rumble : out std_logic;
		
		--connection to the audio controller
		synth_cntrl : out synth_cntrl_vec_t(0 to 1)
	); 
end entity;