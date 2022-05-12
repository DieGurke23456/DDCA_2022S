library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.vga_gfx_cntrl_pkg.all;


entity tb_rows_full_handler is
end tb_rows_full_handler;
architecture bhv of tb_rows_full_handler is
    signal RES_SIGNAL, START_SIGNAL, BUSY_SIGNAL : std_logic;
    signal CLK_SIGNAL : std_logic := '0';

    type fsm_state_t is (WAIT_RESET, START_STRING_DRAWER, WAIT_STRING_DRAWER, CHECK_RESULT);

begin 
    I_STRING_DRAWER : string_drawer 
    generic map(
		BLOCK_SIZE => 12 integer; -- size of a block in px
		BLOCKS_X => 20 integer;    -- size of coordinate system in x dimension
		BLOCKS_Y: integer;     -- size of coordinate system in y dimension
        MAX_LENTGH: integer --max-length of strings that can be passed to instance
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		start : in std_logic;
		busy : out std_logic;
		x : in integer range 0 to (BLOCKS_X - 1);
		y : in integer range 0 to (BLOCKS_Y - 1);
		string_to_draw : in string range 0 to MAX_LENTGH - 1;
        chars_to_draw : in integer range 0 to MAX_LENGTH;
		gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
		gfx_instr_wr : out std_logic;
		gfx_instr_full : in std_logic
	);
    
    clk_toggle : process 
	begin
		wait for 10 ns;
		CLK_SIGNAL <= not CLK_SIGNAL;
	end process clk_toggle; 

    reset_single : process
    begin
        RES_SIGNAL <= '0'; 
        wait for 10 ns;
        RES_SIGNAL <= '1';
        wait;
    end process reset_single;
    
    timeout_detection : process
    begin 
        wait for 3000 us;
        report "test-timeout";
        report "test failed!";
        finish;
    end process timeout_detection;
    sync : process(CLK_SIGNAL)
	begin
		if (rising_edge(CLK_SIGNAL)) then
			state <= state_nxt;
		end if;
	end process;

    next_state : process(all)
    begin
        state_nxt <= state;
        START_SIGNAL <= '0';
        case state.fsm_state is 
            WHEN WAIT_RESET => 
                if RES_SIGNAL = '1' then
                    state_nxt.fsm_state <= START_ROWS_FULL_HANDLER;
                else 
                    state_nxt.fsm_state <= WAIT_RESET;
                end if;
            WHEN START_STRING_DRAWER => 
                report "starting test!";
                START_SIGNAL <= '1';
                state_nxt.fsm_state <= WAIT_ROWS_FULL_HANDLER;
            WHEN WAIT_STRING_DRAWER =>
                if (BUSY_SIGNAL = '0') then
					state_nxt.fsm_state <= CHECK_RESULT;
                    state_nxt.stored_matrix <= OUT_MATRIX;
				end if;
            WHEN CHECK_RESULT => 
        end case;
    end process;
    

end architecture;