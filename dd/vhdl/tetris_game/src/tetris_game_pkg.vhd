library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.vga_gfx_cntrl_pkg.all;
use work.gc_cntrl_pkg.all;
use work.audio_cntrl_pkg.all;

package tetris_game_pkg is

	component tetris_game is
		port (
			clk : in std_logic;
			res_n : in std_logic;
			gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
			gfx_instr_wr : out std_logic;
			gfx_instr_full : in std_logic;
			gfx_frame_sync : in std_logic;
			gc_cntrl_state : in gc_cntrl_state_t;
			gc_cntrl_rumble : out std_logic;
			synth_cntrl : out synth_cntrl_vec_t(0 to 1)
		);
	end component;
end package;

