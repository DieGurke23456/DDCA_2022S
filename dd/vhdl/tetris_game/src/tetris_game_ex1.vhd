library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.vga_gfx_cntrl_pkg.all;
use work.math_pkg.all;
use work.gc_cntrl_pkg.all;
use work.audio_cntrl_pkg.all;
use work.ram_pkg.all;
use work.tetris_util_pkg.all;
use work.decimal_printer_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_game_logic_pkg.all;
use work.tetris_audio_pkg.all;

architecture ex1 of tetris_game is

	type gfx_instr_array_t is array(natural range<>) of std_logic_vector;
	constant FALL_RATE : integer := 2;
	constant BPS : integer := 7;
	constant DISPLAY_WIDTH : integer := 320;
	constant DISPLAY_HEIGHT : integer := 240;
	constant BLOCK_SIZE : integer := 12; 
	constant BLOCK_SIZE_SLV : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(BLOCK_SIZE, log2c(BLOCK_SIZE)));
	
	constant BLOCKS_X : integer := 10;
	constant BLOCKS_Y : integer := 20;

	constant BLOCKS_VIEW_X : integer := DISPLAY_WIDTH / BLOCK_SIZE;
	constant BLOCKS_VIEW_Y : integer := DISPLAY_WIDTH / BLOCK_SIZE;

	constant OFFSET_X : integer := 4;
	constant OFFSET_Y : integer := 0;

	constant NEXT_TETROMINO_X_POS: integer := BLOCKS_VIEW_X  - 6;
	constant NEXT_TETROMINO_Y_POS: integer := BLOCKS_VIEW_Y / 2;


	--decimal printer signals
	signal dp_gfx_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal dp_gfx_instr_wr : std_logic;
	signal dp_start : std_logic;
	signal dp_busy : std_logic;

	signal gfx_initializer_start : std_logic;
	signal gfx_initializer_busy : std_logic;
	signal gfx_initializer_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal gfx_initializer_instr_wr : std_logic;
	
	signal td_start : std_logic;
	signal td_x : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0); --signed
	signal td_y : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0); --signed
	signal td_busy : std_logic;
	signal td_gfx_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal td_gfx_instr_wr : std_logic;

	--block drawer 
	signal bd_start : std_logic;
	signal bd_busy : std_logic;
	signal bd_x : integer range 0 to (BLOCKS_X - 1);
	signal bd_y : integer range 0 to (BLOCKS_Y - 1);
	signal bd_block : t_bb_block;
	signal bd_gfx_instr: std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal bd_gfx_instr_wr : std_logic;

	--block line drawer 
	signal bld_start : std_logic;
	signal bld_busy : std_logic;
	signal bld_x : integer range 0 to (BLOCKS_VIEW_X - 1);
	signal bld_y : integer range 0 to (BLOCKS_VIEW_Y - 1);
	signal bld_length : integer range 0 to (BLOCKS_VIEW_Y);
	signal bld_dir : std_logic; -- 0 means x dir, 1 means y dir
	signal bld_block : t_bb_block;
	signal bld_gfx_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal bld_gfx_instr_wr : std_logic;

	--matrix drawer
	constant wall_row: t_bb_block_row(0 to BLOCKS_X - 1) := (
		T_BB_WALL,T_BB_WALL,T_BB_WALL,T_BB_WALL,
		others => T_BB_EMPTY
	);
	constant EMPTY_MATRIX: t_bb_block_matrix(0 to BLOCKS_Y - 1) :=(
		others => (EMPTY_ROW)
	);

	signal timer_gravity_done, timer_gravity_start : std_logic;

	signal timer_song_done, timer_song_start : std_logic;
	-- add_tetromino_handler 
	signal ath_start,ath_busy :std_logic;
	signal ath_out_matrix : t_bb_block_matrix(0 to BLOCKS_Y -1);

	--rows_full_handler 
	signal rfh_start,rfh_busy : std_logic;
	signal rfh_out_matrix: t_bb_block_matrix(0 to BLOCKS_Y -1);
	signal rfh_rows_removed: std_logic_vector(BLOCKS_Y - 1 downto 0);

	--matrix drawer
	signal md_start,md_busy : std_logic;
	signal md_x : integer range 0 to (BLOCKS_VIEW_X - 1);
	signal md_y : integer range 0 to (BLOCKS_VIEW_Y - 1);
	signal md_gfx_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal md_gfx_instr_wr : std_logic;	
	
	-- tetromino_collider 
	signal tc_start,tc_busy,tc_collision_detected, tc_block_map_rd,tc_block_map_solid : std_logic;
	signal tc_block_map_x : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
	signal tc_block_map_y : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);

	signal block_map_rd_x : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
	signal block_map_rd_y : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
	signal block_map_rd : std_logic;
	signal block_map_rd_data : std_logic_vector(0 downto 0);
	
	signal block_map_wr_x : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
	signal block_map_wr_y : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
	signal block_map_wr : std_logic;
	signal block_map_wr_data : std_logic_vector(0 downto 0);

	signal prng_value : std_logic_vector(2 downto 0);
	signal prng_en : std_logic;

	type fsm_state_t is (
		RESET, WAIT_INIT, 
		DO_FRAME_SYNC, WAIT_FRAME_SYNC,
		CLEAR_SCREEN,
		PROCESS_INPUT,
		TEST_MOVEMENT, WAIT_CHECK_COLLISION,
		DRAW_TETROMINO, WAIT_DRAW_TETROMINO,
		DRAW_NEXT_TETROMINO, WAIT_DRAW_NEXT_TETROMINO,
		DRAW_WALL_1,
		WAIT_DRAW_WALL_1,
		DRAW_WALL_2,
		WAIT_DRAW_WALL_2,
		DRAW_TEST_MATRIX,
		WAIT_DRAW_TEST_MATRIX,
		CLEAR_BLOCK_MAP_INIT, CLEAR_BLOCK_MAP_WRITE,
		START_DECIMAL_PRINTER, WAIT_DECIMAL_PRINTER,
		TEST_ADD_TETROMINO_HANDLER,
		WAIT_TEST_ADD_TETROMINO_HANDLER,
		TEST_ROWS_FULL_HANDLER,
		WAIT_ROWS_FULL_HANDLER,
		START_GRAVITY_TIMER,
		WAIT_AUDIO_SYNC_DELAY
	);

	signal td_cur_tetromino : tetromino_t;
	signal td_cur_rotation : rotation_t;
	
	type state_t is record
		fsm_state : fsm_state_t;
		last_controller_state : gc_cntrl_state_t;
		cur_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
		cur_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
		cur_tetromino : tetromino_t;
		cur_rotation : rotation_t;
		detected_collision: std_logic;
		current_wall_column: natural;
		current_wall_block: natural;
		
		dest_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
		dest_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
		dest_tetromino : tetromino_t;
		dest_rotation : rotation_t;
		
		next_tetromino : tetromino_t;

		row_counter : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
		column_counter : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
		block_matrix : t_bb_block_matrix(BLOCKS_Y - 1 downto 0);
		audio_sync_delay_counter : integer range 0 to 10;
		note_index : integer range 0 to TETRIS_THEME'length;
	end record;
	signal state, state_nxt : state_t;
	
	type tetromino_object_t is record
		x: std_logic_vector(log2c(BLOCKS_X) downto 0);
		y: std_logic_vector(log2c(BLOCKS_Y) downto 0);
		tetromino: tetromino_t;
		rotation: rotation_t;
	end record;
	constant test_tetromino : tetromino_object_t := (
		x => std_logic_vector(to_unsigned(0, tetromino_object_t.x'length)),
		y => std_logic_vector(to_unsigned(8, tetromino_object_t.y'length)),
		tetromino => TET_I,
		rotation => ROT_90);
	
begin
	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => RESET,
				last_controller_state => GC_BUTTONS_RESET_VALUE,
				cur_tetromino => TET_Z,
				next_tetromino => TET_I,
				detected_collision => '0',
				current_wall_block => 0,
				current_wall_column => 0,
				block_matrix => EMPTY_MATRIX,
				audio_sync_delay_counter => 0,
				note_index => 0,
				others => (others=>'0')
			);
		elsif (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;

	audio : process(timer_song_done)
	begin
		if(rising_edge(timer_song_done)) then 
			synth_cntrl(0).high_time <= high_time_from_pitch(TETRIS_THEME(state.note_index).pitch);
			synth_cntrl(0).low_time <= high_time_from_pitch(TETRIS_THEME(state.note_index).pitch);
			synth_cntrl(1).low_time <= high_time_from_pitch(TETRIS_THEME(state.note_index).pitch);
			synth_cntrl(1).high_time <= high_time_from_pitch(TETRIS_THEME(state.note_index).pitch);
		end if;
	end process;

	next_state : process(all)
		procedure write_instr(instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0); next_state : fsm_state_t) is
		begin
			if (gfx_instr_full = '0') then
				gfx_instr_wr <= '1';
				gfx_instr <= instr;
				state_nxt.fsm_state <= next_state;
			end if;
		end procedure;
	begin
		state_nxt <= state;
		
		prng_en <= '0';
		dp_start <= '0'; -- decimal printer 
		tc_start <= '0'; -- tetromino collider
		gfx_initializer_start <= '0';
		--synth_cntrl(1).play <= '1';
		gfx_instr_wr <= '0';
		gfx_instr <= (others=>'0');
		td_start <= '0';
		td_x <= (others=>'0');
		td_y <= (others=>'0');

		bd_start <= '0';
		bld_start <= '0';
		md_start <= '0';
		ath_start <= '0';
		rfh_start <= '0';
		timer_gravity_start <= '0';
		timer_song_start <= '0';
		
		--block map stuff
		block_map_rd_x <= (others=>'0');
		block_map_rd_y <= (others=>'0');
		block_map_rd <= '0';
		block_map_wr <= '0';
		block_map_wr_x <= (others=>'0');
		block_map_wr_y <= (others=>'0');
		block_map_wr_data <= (others=>'0');

		synth_cntrl(0).play <= '1';
		synth_cntrl(1).play <= '1';
		
		case state.fsm_state is
			when RESET =>
				state_nxt.fsm_state <= WAIT_INIT;
				gfx_initializer_start <= '1';
				gfx_instr <= gfx_initializer_instr;
				gfx_instr_wr <= gfx_initializer_instr_wr;
				
			when WAIT_INIT =>
				gfx_instr <= gfx_initializer_instr;
				gfx_instr_wr <= gfx_initializer_instr_wr;
				if (gfx_initializer_busy = '0') then
					state_nxt.fsm_state <= START_GRAVITY_TIMER;
				end if;
			when START_GRAVITY_TIMER => 
				timer_gravity_start <= '1';
				timer_song_start <= '1';
				state_nxt.fsm_state <= CLEAR_BLOCK_MAP_INIT; 
			when CLEAR_BLOCK_MAP_INIT =>
				state_nxt.cur_tetromino_x <= std_logic_vector(to_unsigned(BLOCKS_X/2-1, state.cur_tetromino_x'length));
				state_nxt.cur_tetromino_y <= (others=>'0');
				state_nxt.row_counter <= (others=>'0');
				state_nxt.column_counter <= (others=>'0');
				state_nxt.fsm_state <= CLEAR_BLOCK_MAP_WRITE;
			
			when CLEAR_BLOCK_MAP_WRITE =>
				if (unsigned(state.column_counter) = BLOCKS_X-1) then
					state_nxt.column_counter <= (others=>'0');
					if (unsigned(state.row_counter) = BLOCKS_Y-1) then
						state_nxt.fsm_state <= DO_FRAME_SYNC;
					else
						state_nxt.row_counter <= std_logic_vector(unsigned(state.row_counter) + 1);
					end if;
				else
					state_nxt.column_counter <= std_logic_vector(unsigned(state.column_counter) + 1);
				end if;
				
				block_map_wr_x <= state.column_counter;
				block_map_wr_y <= state.row_counter;
				block_map_wr_data <= (others=>'0');
				block_map_wr <= '1';			
			when DO_FRAME_SYNC =>
				if (gfx_instr_full = '0') then
					gfx_instr_wr <= '1';
					gfx_instr <= gfx_instr_frame_sync;
					state_nxt.fsm_state <= WAIT_FRAME_SYNC;
				end if;
			
			when WAIT_FRAME_SYNC =>
				if (gfx_frame_sync = '1') then
					state_nxt.fsm_state <= CLEAR_SCREEN;
				end if;
			
			when CLEAR_SCREEN =>
				write_instr(gfx_instr_clear(color=>x"c"), PROCESS_INPUT);
			--██╗███╗   ██╗██████╗ ██╗   ██╗████████╗
			--██║████╗  ██║██╔══██╗██║   ██║╚══██╔══╝
			--██║██╔██╗ ██║██████╔╝██║   ██║   ██║   
			--██║██║╚██╗██║██╔═══╝ ██║   ██║   ██║   
			--██║██║ ╚████║██║     ╚██████╔╝   ██║   
			--╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝   
			when PROCESS_INPUT =>
				state_nxt.last_controller_state <= gc_cntrl_state;
				state_nxt.fsm_state <= DRAW_WALL_1;
				
				state_nxt.dest_tetromino_x <= state.cur_tetromino_x;
				state_nxt.dest_tetromino_y <= state.cur_tetromino_y;
				state_nxt.dest_tetromino <= state.cur_tetromino;
				state_nxt.dest_rotation <= state.cur_rotation;
				if(timer_song_done = '1') then 
					state_nxt.fsm_state <= WAIT_AUDIO_SYNC_DELAY;
					state_nxt.note_index <= state.note_index + 1;
					timer_song_start <= '1';
				end if;
				if(timer_gravity_done = '1') then
					state_nxt.dest_tetromino_y <= std_logic_vector(signed(state.cur_tetromino_y) + 1);

					timer_gravity_start <= '1'; 
				end if;				
				if (gc_cntrl_state.btn_right = '1' and state.last_controller_state.btn_right = '0') then
					state_nxt.dest_tetromino_x <= std_logic_vector(signed(state.cur_tetromino_x) + 1);
					state_nxt.fsm_state <= TEST_MOVEMENT;
				end if;
				if (gc_cntrl_state.btn_left = '1' and state.last_controller_state.btn_left = '0') then
					state_nxt.dest_tetromino_x <= std_logic_vector(signed(state.cur_tetromino_x) - 1);
					state_nxt.fsm_state <= TEST_MOVEMENT;
				end if;
				if (gc_cntrl_state.btn_down = '1' and state.last_controller_state.btn_down = '0') then
					state_nxt.dest_tetromino_y <= std_logic_vector(signed(state.cur_tetromino_y) + 1);
					state_nxt.fsm_state <= TEST_MOVEMENT;
				end if;
				if (gc_cntrl_state.btn_a = '1' and state.last_controller_state.btn_a = '0') then
					state_nxt.dest_rotation <= std_logic_vector(unsigned(state.cur_rotation) + 1);
					state_nxt.fsm_state <= TEST_MOVEMENT;
				end if;
				if (gc_cntrl_state.btn_x = '1' and state.last_controller_state.btn_x = '0') then
					state_nxt.fsm_state <= TEST_ROWS_FULL_HANDLER;
				end if;
			when WAIT_AUDIO_SYNC_DELAY => 
				if(state.audio_sync_delay_counter < 10) then
					state_nxt.audio_sync_delay_counter <= state.audio_sync_delay_counter + 1;
					synth_cntrl(0).play <= '0';
					synth_cntrl(1).play <= '0';
				else 
					state_nxt.audio_sync_delay_counter <= 0;
					state_nxt.fsm_state <= TEST_MOVEMENT;
				end if;

			when TEST_ADD_TETROMINO_HANDLER => 
				ath_start <= '1';
				state_nxt.fsm_state <= WAIT_TEST_ADD_TETROMINO_HANDLER;
			when WAIT_TEST_ADD_TETROMINO_HANDLER => 
				if(ath_busy = '0') then
					state_nxt.block_matrix <= ath_out_matrix;
					state_nxt.fsm_state <= TEST_ROWS_FULL_HANDLER;
					prng_en <= '1';
					state_nxt.cur_tetromino <= state.next_tetromino;
					state_nxt.cur_tetromino_x <= std_logic_vector(to_unsigned(BLOCKS_X/2-1, state.cur_tetromino_x'length));
					state_nxt.cur_tetromino_y <= (others=>'0');
					state_nxt.cur_rotation <= ROT_0;
					state_nxt.next_tetromino <= prng_value;
				end if;
			when TEST_ROWS_FULL_HANDLER => 
				rfh_start <= '1';
				state_nxt.fsm_state <= WAIT_ROWS_FULL_HANDLER; 
			when WAIT_ROWS_FULL_HANDLER => 
				if (rfh_busy = '0') then
					state_nxt.block_matrix <= rfh_out_matrix;
					state_nxt.fsm_state <= DRAW_WALL_1;
				end if;
			when TEST_MOVEMENT =>
				tc_start <= '1';
				state_nxt.fsm_state <= WAIT_CHECK_COLLISION;
			when WAIT_CHECK_COLLISION =>
				if (tc_busy = '0') then
					state_nxt.fsm_state <= DRAW_WALL_1;
					if (tc_collision_detected = '0') then
						state_nxt.cur_tetromino_x <= state.dest_tetromino_x;
						state_nxt.cur_tetromino_y <= state.dest_tetromino_y;
						state_nxt.cur_rotation <= state.dest_rotation;
						state_nxt.cur_tetromino <= state.dest_tetromino;
					else
						if(to_integer(signed(state.dest_tetromino_y)) - to_integer(signed(state.cur_tetromino_y)) > 0) then 
							state_nxt.fsm_state <= TEST_ADD_TETROMINO_HANDLER;
						end if;
					end if;
				end if;

			--██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗ 
			--██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
			--██████╔╝██║   ██║██████╔╝██║  ██║█████╗  ██████╔╝
			--██╔══██╗██║   ██║██╔══██╗██║  ██║██╔══╝  ██╔══██╗
			--██████╔╝╚██████╔╝██║  ██║██████╔╝███████╗██║  ██║
			--╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝
			when DRAW_WALL_1 => 
				bld_start <= '1';
				bld_x <= OFFSET_X - 1;
				bld_y <= 0;
				bld_length <= BLOCKS_Y;
				bld_dir <= '0';
				state_nxt.fsm_state <= WAIT_DRAW_WALL_1;
			when WAIT_DRAW_WALL_1 =>
				if (bld_busy = '0') then 
					state_nxt.fsm_state <= DRAW_WALL_2;
				end if;
				gfx_instr <= bld_gfx_instr;
				gfx_instr_wr <= bld_gfx_instr_wr;
				bld_block <= T_BB_WALL;
			when DRAW_WALL_2 =>
				bld_start <= '1';
				bld_x <= OFFSET_X + BLOCKS_X;
				bld_y <= 0;
				bld_length <= BLOCKS_Y;
				bld_dir <= '0';
				state_nxt.fsm_state <= WAIT_DRAW_WALL_2;
			when WAIT_DRAW_WALL_2 =>
				if (bld_busy = '0') then 
					state_nxt.fsm_state <= DRAW_TEST_MATRIX;
				end if;
				gfx_instr <= bld_gfx_instr;
				gfx_instr_wr <= bld_gfx_instr_wr;
				bld_block <= T_BB_WALL;
			--██████╗ ██╗      ██████╗  ██████╗██╗  ██╗███████╗
			--██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝██╔════╝
			--██████╔╝██║     ██║   ██║██║     █████╔╝ ███████╗
			--██╔══██╗██║     ██║   ██║██║     ██╔═██╗ ╚════██║
			--██████╔╝███████╗╚██████╔╝╚██████╗██║  ██╗███████║
			--╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝
			when DRAW_TEST_MATRIX => 
				md_start <= '1';
				state_nxt.fsm_state <= WAIT_DRAW_TEST_MATRIX;
			when WAIT_DRAW_TEST_MATRIX => 
				md_x <= OFFSET_X;
				md_y <= OFFSET_Y;
				gfx_instr <= md_gfx_instr;
				gfx_instr_wr <= md_gfx_instr_wr;
				if(md_busy = '0') then
					state_nxt.fsm_state <= DRAW_TETROMINO;
				end if;
			when DRAW_TETROMINO =>
				td_start <= '1';
				state_nxt.fsm_state <= WAIT_DRAW_TETROMINO;
			when WAIT_DRAW_TETROMINO =>
				td_x <= std_logic_vector(resize((signed(state.cur_tetromino_x) + OFFSET_X) * BLOCK_SIZE, td_x'length));
				td_y <= std_logic_vector(resize(signed(state.cur_tetromino_y) * BLOCK_SIZE, td_y'length));
				td_cur_tetromino <= state.cur_tetromino;
				td_cur_rotation <= state.cur_rotation;
				
				gfx_instr <= td_gfx_instr;
				gfx_instr_wr <= td_gfx_instr_wr;
				if (td_busy = '0') then
					state_nxt.fsm_state <= DRAW_NEXT_TETROMINO;
				end if;
			when DRAW_NEXT_TETROMINO => 
				td_start <= '1';
				state_nxt.fsm_state <= WAIT_DRAW_NEXT_TETROMINO;
			when WAIT_DRAW_NEXT_TETROMINO => 
				td_x <= std_logic_vector(resize(to_signed(NEXT_TETROMINO_X_POS, log2c(BLOCKS_VIEW_X) + 1) * BLOCK_SIZE, td_x'length));
				td_y <= std_logic_vector(resize(to_signed(NEXT_TETROMINO_Y_POS, log2c(BLOCKS_VIEW_Y) + 1) * BLOCK_SIZE, td_y'length));
				td_cur_tetromino <= state.next_tetromino;
				td_cur_rotation <= ROT_0;
				
				gfx_instr <= td_gfx_instr;
				gfx_instr_wr <= td_gfx_instr_wr;
				if (td_busy = '0') then
					state_nxt.fsm_state <= START_DECIMAL_PRINTER;
				end if;
			
			--██╗      █████╗ ██████╗ ███████╗██╗     
			--██║     ██╔══██╗██╔══██╗██╔════╝██║     
			--██║     ███████║██████╔╝█████╗  ██║     
			--██║     ██╔══██║██╔══██╗██╔══╝  ██║     
			--███████╗██║  ██║██████╔╝███████╗███████╗
			--╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝
			when START_DECIMAL_PRINTER =>
				dp_start <= '1';
				state_nxt.fsm_state <= WAIT_DECIMAL_PRINTER;
				
			when WAIT_DECIMAL_PRINTER =>
				gfx_instr <= dp_gfx_instr;
				gfx_instr_wr <= dp_gfx_instr_wr;
				if (dp_busy = '0') then
					state_nxt.fsm_state <= DO_FRAME_SYNC;
				end if;
			
		end case;
	end process;

	gfx_initializer : block 
		constant INIT_INSTR : gfx_instr_array_t(0 to 17+17+3-1) := (
			gfx_instr_load_palette(0),
			x"5bcd", x"642e", x"746f", x"7cd1",
			x"8d32", x"9593", x"a5f4", x"b696",
			x"c6d7", x"c6f7", x"cf17", x"cf38",
			x"d738", x"d779", x"df99", x"ffff",
			gfx_instr_load_palette(1),
			x"0000", x"8000", x"0400", x"8400", 
			x"0010", x"8010", x"0410", x"bdf7",
			x"8410", x"f800", x"07e0", x"ffe0",
			x"001f", x"f81f", x"07ff", x"ffff",
			gfx_instr_cfg(en_db=>true, en_tpg=>false),
			gfx_instr_clear(color=>x"e"),
			gfx_instr_select_palette(alpha_color=>x"f", palette_index=>0)
		);
		
		signal instr_cnt : integer := 0;
		signal instr_cnt_nxt : integer := 0;
	
		signal gfx_initializer_instr_nxt : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
		signal instr_busy, instr_busy_nxt : std_logic;
		signal running, running_nxt : std_logic;
	begin
		gfx_initializer_busy <= running;
	
		sync : process(clk, res_n)
		begin
			if (res_n = '0') then
				instr_cnt <= 0;
				gfx_initializer_instr <= (others=>'0');
				running <= '0';
			elsif (rising_edge(clk)) then
				gfx_initializer_instr <= gfx_initializer_instr_nxt;
				instr_cnt <= instr_cnt_nxt;
				running <= running_nxt;
			end if;
		end process;
		
		next_state : process(all)
		begin
			gfx_initializer_instr_wr <= '0';
			
			instr_cnt_nxt <= instr_cnt;
			gfx_initializer_instr_nxt <= gfx_initializer_instr;
			running_nxt <= running;
			
			if (gfx_initializer_start = '1') then
				instr_cnt_nxt <= 1;
				running_nxt <= '1';
				gfx_initializer_instr_nxt <= INIT_INSTR(0);
			end if;
	
			if (running = '1') then
				if (gfx_instr_full = '0') then
					gfx_initializer_instr_wr <= '1';
					
					if (instr_cnt = 0) then
						running_nxt <= '0';
					elsif (instr_cnt = INIT_INSTR'length-1) then
						instr_cnt_nxt <= 0;
						gfx_initializer_instr_nxt <= INIT_INSTR(instr_cnt);
					else
						gfx_initializer_instr_nxt <= INIT_INSTR(instr_cnt);
						instr_cnt_nxt <= instr_cnt + 1;
					end if;
				end if;
			end if;
		end process;
	end block;

	add_tetromino_handler_inst: add_tetromino_handler
	generic map (
    	ROWS => EMPTY_MATRIX'length,
    	COLUMNS =>EMPTY_MATRIX(0)'length
	)
	port map (
		clk => clk,
		res_n => res_n,
		start => ath_start,
		busy => ath_busy,
		in_matrix => state.block_matrix,
		out_matrix => ath_out_matrix,
		tetromino => state.cur_tetromino,
		rotation => state.cur_rotation,
		x => to_integer(unsigned(state.cur_tetromino_x)),
		y => to_integer(unsigned(state.cur_tetromino_y))
	);

	rows_full_handler_inst: rows_full_handler 
	generic map (
		ROWS => EMPTY_MATRIX'length,
		COLUMNS =>EMPTY_MATRIX(0)'length
	)
	port map(
		clk => clk,
		res_n => res_n,
		start => rfh_start,
		busy => rfh_busy,
		in_matrix => state.block_matrix,
		out_matrix => rfh_out_matrix,
		rows_removed => rfh_rows_removed
	);
	
	tetromino_drawer_inst : tetromino_drawer
	generic map (
		BLOCK_SIZE => BLOCK_SIZE,
		BLOCK_ROW => 5
	)
	port map (
		clk            => clk,
		res_n          => res_n,
		start          => td_start,
		busy           => td_busy,
		x              => td_x,
		y              => td_y,
		tetromino      => td_cur_tetromino,
		rotation       => td_cur_rotation,
		gfx_instr      => td_gfx_instr,
		gfx_instr_wr   => td_gfx_instr_wr,
		gfx_instr_full => gfx_instr_full
	);

	block_drawer_inst : block_drawer
	generic map (
        BLOCK_SIZE => BLOCK_SIZE,        -- size of a block in px
        BLOCKS_X => BLOCKS_VIEW_X,    -- size of coordinate system in x dimension
        BLOCKS_Y => BLOCKS_VIEW_Y     -- size of coordinate system in y dimension
    ) port map (
        clk => clk,
        res_n => res_n,
        start => bd_start,
        busy => bd_busy,
        x => bd_x,
        y => bd_y,
        block_to_draw => bd_block,
        gfx_instr => bd_gfx_instr,
        gfx_instr_wr => bd_gfx_instr_wr,
        gfx_instr_full => gfx_instr_full
    );

	block_line_drawer_instance : block_line_drawer
        generic map (
            BLOCK_SIZE => BLOCK_SIZE, -- size of a block in px
            BLOCKS_X => BLOCKS_VIEW_X,    -- size of coordinate system in x dimension
            BLOCKS_Y => BLOCKS_VIEW_Y     -- size of coordinate system in y dimension
        )
        port map(
            clk => clk,
            res_n => res_n,
            start => bld_start,
            busy => bld_busy,
            x_start => bld_x,
            y_start => bld_y,
            length=> bld_length,
            direction=> bld_dir, -- 0 means x dir, 1 means y dir
            block_to_draw => bld_block,
            gfx_instr => bld_gfx_instr,
            gfx_instr_wr => bld_gfx_instr_wr,
            gfx_instr_full=> gfx_instr_full
    );

	block_matrix_drawer_inst : block_matrix_drawer 
		generic map (
			BLOCK_SIZE => BLOCK_SIZE,
			BLOCKS_X => BLOCKS_VIEW_X,
			BLOCKS_Y => BLOCKS_VIEW_Y,
			ROWS => EMPTY_MATRIX'length,
			COLUMNS => EMPTY_MATRIX(0)'length
		)
		port map (
			clk => clk,
			res_n => res_n,
			start => md_start,
			busy => md_busy,
			x_start => md_x,
			y_start => md_y,
			matrix_to_draw => state.block_matrix,
			gfx_instr => md_gfx_instr,
			gfx_instr_wr => md_gfx_instr_wr,
			gfx_instr_full => gfx_instr_full
		);
	
	decimal_printer_inst : decimal_printer
	port map (
		clk            => clk,
		res_n          => res_n,
		gfx_instr      => dp_gfx_instr,
		gfx_instr_wr   => dp_gfx_instr_wr,
		gfx_instr_full => gfx_instr_full,
		start          => dp_start,
		busy           => dp_busy,
		x              => x"00c8",
		y              => x"0014",
		number         => gc_cntrl_state.trigger_l & gc_cntrl_state.trigger_r
	);
	
	tetromino_collider_inst : tetromino_collider
	generic map (
		BLOCKS_X => BLOCKS_X,
		BLOCKS_Y => BLOCKS_Y
	)
	port map (
		clk                => clk,
		res_n              => res_n,
		start              => tc_start,
		busy               => tc_busy,
		collision_detected => tc_collision_detected,
		tetromino_x        => state.dest_tetromino_x,
		tetromino_y        => state.dest_tetromino_y,
		tetromino          => state.dest_tetromino,
		rotation           => state.dest_rotation,
		block_map_x        => tc_block_map_x,
		block_map_y        => tc_block_map_y,
		block_map_rd       => tc_block_map_rd,
		block_map_solid    => tc_block_map_solid
	);

	timer_gravity_inst: cycles_timer 
	generic map (
        CYCLES => 50000000/FALL_RATE 
    ) port map (
        finished => timer_gravity_done,
        clk => clk,
        res_n => res_n,
        start => timer_gravity_start
    );

	timer_song_inst: cycles_timer 
	generic map (
		CYCLES => 50000000/BPS
	) port map (
        finished => timer_song_done,
        clk => clk,
        res_n => res_n,
        start => timer_song_start
    );

    block_map : block 
        signal block_map_x_int : integer;
        signal block_map_y_int : integer;
        signal next_solid : std_logic;
    begin
        x_y: process(clk)
        begin
            block_map_x_int <= to_integer(unsigned(tc_block_map_x));
            block_map_y_int <= to_integer(unsigned(tc_block_map_y));
            if (tc_block_map_rd = '1') then
                block_map_x_int <= to_integer(unsigned(tc_block_map_x));
                block_map_y_int <= to_integer(unsigned(tc_block_map_y));
            end if;
        end process;

        check_solid :process(clk)
        begin 
            tc_block_map_solid <= next_solid;
            if(tc_block_map_rd = '0') then 
            elsif (block_map_y_int > -1 and block_map_y_int < EMPTY_MATRIX'length and block_map_x_int > -1 and block_map_x_int < BLOCKS_X) then 
                echo ("checking block " & integer'image(block_map_x_int) & " " & integer'image(block_map_y_int) & LF); 
                if (state.block_matrix(EMPTY_MATRIX'length - 1 - block_map_y_int)(wall_row'length - 1 - block_map_x_int) = T_BB_EMPTY) then 
                    next_solid <= '0';
                    echo("empty!"&LF);
                else 
                    next_solid <= '1';
                    echo("blocked!"&LF);
                end if;
            end if;
        end process;
    end block;


	--synth_cntrl(0).high_time <= x"30";
	--synth_cntrl(0).low_time <= x"30"; 
	--synth_cntrl(0).play <= gc_cntrl_state.btn_left;
	--synth_cntrl(1).high_time <= x"22";
	--synth_cntrl(1).low_time <= x"22"; 
	--synth_cntrl(1).play <=  gc_cntrl_state.btn_right;

	gc_cntrl_rumble <= gc_cntrl_state.btn_a;

	prng : block
		signal lfsr : std_logic_vector(14 downto 0); --15 bit
	begin
		sync : process(clk, res_n)
		begin
			if (res_n = '0') then
				lfsr <= std_logic_vector(to_unsigned(1234,lfsr'length));
				prng_value <= (others=>'0');
			elsif (rising_edge(clk)) then
				if (prng_en = '1') then
					lfsr(lfsr'length-1 downto 1) <= lfsr(lfsr'length-2 downto 0);
					lfsr(0) <= lfsr(14) xor lfsr(13);
					
					prng_value <= (others=>'0');
					for i in 0 to lfsr'length/3-1 loop
						if (lfsr((i+1)*3-1 downto i*3) /= "111") then
							prng_value <= lfsr((i+1)*3-1 downto i*3);
							exit;
						end if;
					end loop;
				end if;
			end if;
		end process;
	end block;

end architecture;
