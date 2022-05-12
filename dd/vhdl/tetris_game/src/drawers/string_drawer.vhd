library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tetris_util_pkg.all;
use work.vga_gfx_cntrl_pkg.all;
use work.tetris_drawers_pkg.all;
entity string_drawer is
	generic (
		BLOCK_SIZE : integer; -- size of a block in px
		BLOCKS_X: integer;    -- size of coordinate system in x dimension
		BLOCKS_Y: integer;     -- size of coordinate system in y dimension
        MAX_LENGTH: integer --max-length of strings that can be passed to instance
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		start : in std_logic;
		busy : out std_logic;
		x : in integer range 0 to (BLOCKS_X - 1);
		y : in integer range 0 to (BLOCKS_Y - 1);
		string_to_draw : in string(1 to MAX_LENGTH);
        chars_to_draw : in integer range 0 to MAX_LENGTH;
		gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH - 1 downto 0);
		gfx_instr_wr : out std_logic;
		gfx_instr_full : in std_logic
	);
end entity;


architecture arch of string_drawer is
	type fsm_state_t is (SD_IDLE, MOVE_GP, MOVE_GP_X, MOVE_GP_Y, BB_X, BB_Y, DRAW_STRING, BB_WIDTH, BB_HEIGHT);
	type state_t is record 
		fsm_state : fsm_state_t;
        current_index : integer range 1 to MAX_LENGTH;
	end record;
	
	signal state, state_nxt : state_t;
begin
	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => SD_IDLE,
				current_index => 1
			);
		elsif (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;
	
	next_state : process(all)
	begin
		state_nxt <= state;
		busy <= '1';
		gfx_instr_wr <= '0';
		gfx_instr <= (others=>'0');
		
		case state.fsm_state is
			when SD_IDLE => 
				busy <= '0';
				if (start = '1') then
					busy <= '1';
					state_nxt.fsm_state <= MOVE_GP;
				end if;
			
			when MOVE_GP =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= MOVE_GP_X;
					gfx_instr <= gfx_instr_move_gp(relative => false);
					gfx_instr_wr <= '1';
				end if;
			
			when MOVE_GP_X =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= MOVE_GP_Y;
					gfx_instr_wr <= '1';
					gfx_instr <= gfx_instr_unsigned((x) * BLOCK_SIZE);
				end if;
				
			when MOVE_GP_Y =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= DRAW_STRING;
					gfx_instr_wr <= '1';
					gfx_instr <= gfx_instr_unsigned((y) * BLOCK_SIZE);
				end if;
            when DRAW_STRING => 
                if (state.current_index > MAX_LENGTH or state.current_index > chars_to_draw) then
                    state_nxt.fsm_state <= SD_IDLE;
                elsif(gfx_instr_full = '0') then 
                    gfx_instr_wr <= '1';
                    gfx_instr <= gfx_instr_bit_blit(
						movx => true, movy => false,
						alpha_mode => false,
						vflip => false, hflip => False
					);
                    state_nxt.fsm_state <= BB_X;
                end if;
			when BB_X =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= BB_Y;
					gfx_instr_wr <= '1';
					gfx_instr <= gfx_instr_unsigned(get_bb_x_from_char(string_to_draw(state.current_index)) * BLOCK_SIZE);
				end if;
			when BB_Y =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= BB_WIDTH;
					gfx_instr_wr <= '1';
					gfx_instr <= gfx_instr_unsigned(get_bb_y_from_char(string_to_draw(state.current_index)) * BLOCK_SIZE);
				end if;
			when BB_WIDTH =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= BB_HEIGHT;
					gfx_instr_wr <= '1';
					gfx_instr <= std_logic_vector(to_unsigned(BLOCK_SIZE, GFX_INSTR_WIDTH));
				end if;
			when BB_HEIGHT =>
				if (gfx_instr_full = '0') then
					state_nxt.fsm_state <= DRAW_STRING;
					state_nxt.current_index <= state.current_index + 1;
					gfx_instr_wr <= '1';
					gfx_instr <= std_logic_vector(to_unsigned(BLOCK_SIZE, GFX_INSTR_WIDTH));
				end if;
		end case;
	end process;
end architecture;
