library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tetris_util_pkg.all;
use work.vga_gfx_cntrl_pkg.all;
use work.tetris_drawers_pkg.all;
entity block_line_drawer is
	generic (
		BLOCK_SIZE : integer; -- size of a block in px
		BLOCKS_X: integer;    -- size of coordinate system in x dimension
		BLOCKS_Y: integer     -- size of coordinate system in y dimension
	);
	port (
		clk : in std_logic;
		res_n : in std_logic;
		start : in std_logic;
		busy : out std_logic;
		x_start : in integer range 0 to (BLOCKS_X - 1);
		y_start : in integer range 0 to (BLOCKS_Y - 1);
		length: in integer range 0 to (BLOCKS_Y);
		direction: in std_logic; -- 0 means x dir, 1 means y dir
		block_to_draw : t_bb_block;
		gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH - 1 downto 0);
		gfx_instr_wr : out std_logic;
		gfx_instr_full : in std_logic
	);
end entity;


architecture arch of block_line_drawer is
	type fsm_state_t is (BLD_IDLE, DRAW_WALL, DRAW_BLOCK, WAIT_DRAW_BLOCK);
	type state_t is record 
		fsm_state : fsm_state_t;
		current_block: integer range 0 to (BLOCKS_Y - 1);
		current_x_cord: integer range 0 to (BLOCKS_X - 1);
		current_y_cord: integer range 0 to (BLOCKS_Y - 1);
	end record;
	
	signal state, state_nxt : state_t;
	-- block drawer 
	signal bd_start : std_logic;
	signal bd_busy : std_logic;
	signal bd_x : integer range 0 to (BLOCKS_X - 1);
	signal bd_y : integer range 0 to (BLOCKS_Y - 1);
	signal bd_gfx_instr: std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal bd_gfx_instr_wr : std_logic;

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
        block_to_draw => block_to_draw,
        gfx_instr => bd_gfx_instr,
        gfx_instr_wr => bd_gfx_instr_wr,
        gfx_instr_full => gfx_instr_full
    );

	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => BLD_IDLE,
				current_block => 0,
				current_x_cord => 0,
				current_y_cord => 0
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
			when BLD_IDLE => 
				busy <= '0';
				if (start = '1') then
					busy <= '1';
					state_nxt.fsm_state <= DRAW_WALL;
					state_nxt.current_x_cord <= x_start;
					state_nxt.current_y_cord <= y_start;
					state_nxt.current_block <= 0;
				end if;
			when DRAW_WALL =>
				state_nxt.fsm_state <= BLD_IDLE;
				if state.current_block < length then
					state_nxt.fsm_state <= DRAW_BLOCK;
				else 
					state_nxt.current_block <= 0;
					state_nxt.fsm_state <= BLD_IDLE;
				end if;
			when DRAW_BLOCK =>
				bd_start <= '1';
				state_nxt.fsm_state <= WAIT_DRAW_BLOCK;
			when WAIT_DRAW_BLOCK => 
				bd_x <= state.current_x_cord;
				bd_y <= state.current_y_cord;
				gfx_instr <= bd_gfx_instr;
				gfx_instr_wr <= bd_gfx_instr_wr;
				if (bd_busy = '0') then
					state_nxt.current_block <= state.current_block + 1;
					state_nxt.fsm_state <= DRAW_WALL;
					if direction = '1' then
						state_nxt.current_x_cord <= state.current_x_cord + 1;
					else 
						state_nxt.current_y_cord <= state.current_y_cord + 1;
					end if;
				end if;
		end case;
	end process;
end architecture;
