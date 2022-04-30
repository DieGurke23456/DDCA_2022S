library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tetris_util_pkg.all;
use work.vga_gfx_cntrl_pkg.all;
use work.tetris_drawers_pkg.all;

entity block_matrix_drawer is 
generic (
    BLOCK_SIZE: integer;
    BLOCKS_X: integer;
    BLOCKS_Y: integer;
    ROWS: integer;
    COLUMNS: integer
);
port (
    clk : in std_logic;
    res_n : in std_logic;
    start : in std_logic;
    busy : out std_logic;
    x_start : in integer range 0 to (BLOCKS_X - 1);
    y_start : in integer range 0 to (BLOCKS_Y - 1);
    matrix_to_draw: in t_bb_block_matrix (ROWS - 1 downto 0);
    gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH - 1 downto 0);
    gfx_instr_wr : out std_logic;
    gfx_instr_full : in std_logic
);
end entity;

architecture arch of block_matrix_drawer is
    type fsm_state_t is (MD_IDLE, DRAW_MATRIX, DRAW_ROW, DRAW_BLOCK, WAIT_DRAW_BLOCK);
    type state_t is record 
        fsm_state : fsm_state_t;
        current_row: integer range 0 to (ROWS - 1);
        current_column: integer range 0 to matrix_to_draw(0)'length - 1;
    end record;

    signal state, state_nxt : state_t;
	-- block drawer 
	signal bd_start : std_logic;
	signal bd_busy : std_logic;
	signal bd_x : integer range 0 to (BLOCKS_X - 1);
	signal bd_y : integer range 0 to (BLOCKS_Y - 1);
	signal bd_gfx_instr: std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal bd_gfx_instr_wr : std_logic;
    signal bd_block_to_draw : t_bb_block;
begin 

    block_drawer_inst : block_drawer

    generic map (
        BLOCK_SIZE => BLOCK_SIZE,        -- size of a block in px
        BLOCKS_X => BLOCKS_X,    		 -- size of coordinate system in x dimension
        BLOCKS_Y => BLOCKS_Y     		 -- size of coordinate system in y dimension
    ) port map (
        clk => clk,
        res_n => res_n,
        start => bd_start,
        busy => bd_busy,
        x => bd_x,
        y => bd_y,
        block_to_draw => bd_block_to_draw,
        gfx_instr => bd_gfx_instr,
        gfx_instr_wr => bd_gfx_instr_wr,
        gfx_instr_full => gfx_instr_full
    );

    sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => MD_IDLE,
				current_row => 0,
                current_column => 0
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
		bd_x <= 0;
		bd_y <= 0;
		bd_start <= '0';

		case state.fsm_state is
			when MD_IDLE => 
				busy <= '0';
				if (start = '1') then
					busy <= '1';
					state_nxt.fsm_state <= DRAW_MATRIX;
					state_nxt.current_row <= 0;
                    state_nxt.current_column <= 0;
				end if;
			when DRAW_MATRIX =>
				if state.current_row < ROWS then
					state_nxt.fsm_state <= DRAW_ROW;
				else 
					state_nxt.current_row <= 0;
					state_nxt.fsm_state <= MD_IDLE;
				end if;
            when DRAW_ROW => 
                if state.current_column < COLUMNS then
                    state_nxt.fsm_state <= DRAW_BLOCK;
                else
                    state_nxt.current_column <= 0;
                    state_nxt.current_row <= state.current_row + 1;
                    state_nxt.fsm_state <= DRAW_MATRIX;
                end if;
			when DRAW_BLOCK =>
				bd_start <= '1';
				state_nxt.fsm_state <= WAIT_DRAW_BLOCK;
			when WAIT_DRAW_BLOCK => 
				bd_x <= x_start + state.current_column;
				bd_y <= y_start + state.current_row;
                bd_block_to_draw <= matrix_to_draw(ROWS - 1 - state.current_row)(COLUMNS - 1 - state.current_column);
				gfx_instr <= bd_gfx_instr;
				gfx_instr_wr <= bd_gfx_instr_wr;
				if (bd_busy = '0') then
					state_nxt.current_column <= state.current_column + 1;
					state_nxt.fsm_state <= DRAW_ROW;
				end if;
		end case;
	end process;

end architecture;