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

architecture ex1 of tetris_game is

	type gfx_instr_array_t is array(natural range<>) of std_logic_vector;
	constant DISPLAY_WIDTH : integer := 320;
	constant DISPLAY_HEIGHT : integer := 240;
	constant BLOCK_SIZE : integer := 12; 
	constant BLOCK_SIZE_SLV : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(BLOCK_SIZE, log2c(BLOCK_SIZE)));
	constant BLOCKS_X : integer := 10;
	constant BLOCKS_Y : integer := 20;

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

	signal tc_start : std_logic;
	signal tc_busy : std_logic;
	signal tc_collision_detected :  std_logic;
	signal tc_block_map_x : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
	signal tc_block_map_y : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
	signal tc_block_map_rd : std_logic;
	signal tc_block_map_solid : std_logic;

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
		TEST_WRITE_BLOCK_MAP, TEST_WRITE_BLOCK_MAP_2,
		PROCESS_INPUT,
		TEST_MOVEMENT, WAIT_CHECK_COLLISION,
		DRAW_TETROMINO, WAIT_DRAW_TETROMINO,
		DRAW_COLLISION_BORDER, 
		DRAW_COLLISION_BORDER_1,
		DRAW_COLLISION_BORDER_2,
		DRAW_COLLISION_BORDER_3, 
		DRAW_COLLISION_BORDER_4,
		DRAW_COLLISION_BORDER_5, 
		DRAW_COLLISION_BORDER_6,
		DRAW_COLLISION_BORDER_7,
		DRAW_COLLISION_BORDER_8, 
		DRAW_COLLISION_BORDER_9,
		DRAW_COLLISION_BORDER_10,
		DRAW_COLLISION_BORDER_11,
		DRAW_COLLISION_BORDER_12,
		DRAW_COLLISION_BORDER_13,
		DRAW_COLLISION_BORDER_14,
		DRAW_COLLISION_BORDER_15,
		DRAW_COLLISION_BORDER_16,
		DRAW_COLLISION_BORDER_17,
		CLEAR_BLOCK_MAP_INIT, CLEAR_BLOCK_MAP_WRITE,
		START_DECIMAL_PRINTER, WAIT_DECIMAL_PRINTER
	);
	
	type state_t is record
		fsm_state : fsm_state_t;
		last_controller_state : gc_cntrl_state_t;
		cur_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
		cur_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
		cur_tetromino : tetromino_t;
		cur_rotation : rotation_t;
		
		dest_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
		dest_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
		dest_tetromino : tetromino_t;
		dest_rotation : rotation_t;
		
		next_tetromino : tetromino_t;

		row_counter : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
		column_counter : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
	end record;
	
	signal state, state_nxt : state_t;
	
	constant COLLISION_BORDER : gfx_instr_array_t(0 to 17)(GFX_INSTR_WIDTH-1 downto 0) := (
		gfx_instr_move_gp(relative=>false),
		gfx_instr_unsigned(BLOCKS_X*BLOCK_SIZE),
		gfx_instr_unsigned(0),
		gfx_instr_draw_line(color=>x"f", movx=>false, movy=>false, relative=>True),
		gfx_instr_unsigned(0),
		gfx_instr_unsigned(239),
		gfx_instr_move_gp(relative=>false),
		gfx_instr_unsigned(0),
		gfx_instr_unsigned(9*12),
		gfx_instr_draw_line(color=>x"f", movx=>true, movy=>true, relative=>True),
		gfx_instr_unsigned(2*BLOCK_SIZE-1),
		gfx_instr_unsigned(0),
		gfx_instr_draw_line(color=>x"f", movx=>true, movy=>true, relative=>True),
		gfx_instr_unsigned(0),
		gfx_instr_unsigned(BLOCK_SIZE-1),
		gfx_instr_draw_line(color=>x"f", movx=>true, movy=>true, relative=>True),
		gfx_instr_signed(-(2*BLOCK_SIZE-1)),
		gfx_instr_unsigned(0)
	);
begin

	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => RESET,
				last_controller_state => GC_BUTTONS_RESET_VALUE,
				cur_tetromino => TET_Z,
				next_tetromino => TET_I,
				others => (others=>'0')
			);
		elsif (rising_edge(clk)) then
			state <= state_nxt;
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

		gfx_instr_wr <= '0';
		gfx_instr <= (others=>'0');

		--tetromino drawer
		td_start <= '0';
		td_x <= (others=>'0');
		td_y <= (others=>'0');
		
		--block map stuff
		block_map_rd_x <= (others=>'0');
		block_map_rd_y <= (others=>'0');
		block_map_rd <= '0';
		block_map_wr <= '0';
		block_map_wr_x <= (others=>'0');
		block_map_wr_y <= (others=>'0');
		block_map_wr_data <= (others=>'0');


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
					state_nxt.fsm_state <= CLEAR_BLOCK_MAP_INIT;
				end if;
			
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
				write_instr(gfx_instr_clear(color=>x"c"), TEST_WRITE_BLOCK_MAP);
				
			when TEST_WRITE_BLOCK_MAP =>
				block_map_wr <= '1';
				block_map_wr_x <= std_logic_vector(to_unsigned(0, block_map_wr_x'length));
				block_map_wr_y <= std_logic_vector(to_unsigned(9, block_map_wr_y'length));
				block_map_wr_data <= "1";
				state_nxt.fsm_state <= TEST_WRITE_BLOCK_MAP_2;
				
			when TEST_WRITE_BLOCK_MAP_2 =>
				block_map_wr <= '1';
				block_map_wr_x <= std_logic_vector(to_unsigned(1, block_map_wr_x'length));
				block_map_wr_y <= std_logic_vector(to_unsigned(9, block_map_wr_y'length));
				block_map_wr_data <= "1";
				state_nxt.fsm_state <= PROCESS_INPUT;

			
			--██╗███╗   ██╗██████╗ ██╗   ██╗████████╗
			--██║████╗  ██║██╔══██╗██║   ██║╚══██╔══╝
			--██║██╔██╗ ██║██████╔╝██║   ██║   ██║   
			--██║██║╚██╗██║██╔═══╝ ██║   ██║   ██║   
			--██║██║ ╚████║██║     ╚██████╔╝   ██║   
			--╚═╝╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝   
			when PROCESS_INPUT =>
				state_nxt.last_controller_state <= gc_cntrl_state;
				state_nxt.fsm_state <= DRAW_COLLISION_BORDER;
				
				state_nxt.dest_tetromino_x <= state.cur_tetromino_x;
				state_nxt.dest_tetromino_y <= state.cur_tetromino_y;
				state_nxt.dest_tetromino <= state.cur_tetromino;
				state_nxt.dest_rotation <= state.cur_rotation;

				if (gc_cntrl_state.btn_right = '1' and state.last_controller_state.btn_right = '0') then
					state_nxt.dest_tetromino_x <= std_logic_vector(signed(state.cur_tetromino_x) + 1);
					state_nxt.fsm_state <= TEST_MOVEMENT;
				end if;
				if (gc_cntrl_state.btn_left = '1' and state.last_controller_state.btn_left = '0') then
					state_nxt.dest_tetromino_x <= std_logic_vector(signed(state.cur_tetromino_x) - 1);
					state_nxt.fsm_state <= TEST_MOVEMENT;
				end if;
				if (gc_cntrl_state.btn_up = '1' and state.last_controller_state.btn_up = '0') then
					state_nxt.dest_tetromino_y <= std_logic_vector(signed(state.cur_tetromino_y) - 1);
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
				
				
				if (gc_cntrl_state.btn_b = '1' and state.last_controller_state.btn_b = '0') then
					prng_en <= '1';
					state_nxt.cur_tetromino <= state.next_tetromino;
					state_nxt.cur_tetromino_x <= std_logic_vector(to_unsigned(BLOCKS_X/2-1, state.cur_tetromino_x'length));
					state_nxt.cur_tetromino_y <= (others=>'0');
					state_nxt.cur_rotation <= ROT_0;
					state_nxt.next_tetromino <= prng_value;
				end if;

			when TEST_MOVEMENT =>
				tc_start <= '1';
				state_nxt.fsm_state <= WAIT_CHECK_COLLISION;
			
			when WAIT_CHECK_COLLISION =>
				if (tc_busy = '0') then
					if (tc_collision_detected = '0') then
						state_nxt.cur_tetromino_x <= state.dest_tetromino_x;
						state_nxt.cur_tetromino_y <= state.dest_tetromino_y;
						state_nxt.cur_rotation <= state.dest_rotation;
						state_nxt.cur_tetromino <= state.dest_tetromino;
					end if;
					state_nxt.fsm_state <= DRAW_COLLISION_BORDER;
				end if;
			
			--██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗ 
			--██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
			--██████╔╝██║   ██║██████╔╝██║  ██║█████╗  ██████╔╝
			--██╔══██╗██║   ██║██╔══██╗██║  ██║██╔══╝  ██╔══██╗
			--██████╔╝╚██████╔╝██║  ██║██████╔╝███████╗██║  ██║
			--╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝
			when DRAW_COLLISION_BORDER => write_instr(COLLISION_BORDER(0), DRAW_COLLISION_BORDER_1);
			when DRAW_COLLISION_BORDER_1 => write_instr(COLLISION_BORDER(1), DRAW_COLLISION_BORDER_2);
			when DRAW_COLLISION_BORDER_2 => write_instr(COLLISION_BORDER(2), DRAW_COLLISION_BORDER_3);
			when DRAW_COLLISION_BORDER_3 => write_instr(COLLISION_BORDER(3), DRAW_COLLISION_BORDER_4);
			when DRAW_COLLISION_BORDER_4 => write_instr(COLLISION_BORDER(4), DRAW_COLLISION_BORDER_5);
			when DRAW_COLLISION_BORDER_5 => write_instr(COLLISION_BORDER(5), DRAW_COLLISION_BORDER_6);
			when DRAW_COLLISION_BORDER_6 => write_instr(COLLISION_BORDER(6), DRAW_COLLISION_BORDER_7);
			when DRAW_COLLISION_BORDER_7 => write_instr(COLLISION_BORDER(7), DRAW_COLLISION_BORDER_8);
			when DRAW_COLLISION_BORDER_8 => write_instr(COLLISION_BORDER(8), DRAW_COLLISION_BORDER_9);
			when DRAW_COLLISION_BORDER_9 => write_instr(COLLISION_BORDER(9), DRAW_COLLISION_BORDER_10);
			when DRAW_COLLISION_BORDER_10 => write_instr(COLLISION_BORDER(10), DRAW_COLLISION_BORDER_11);
			when DRAW_COLLISION_BORDER_11 => write_instr(COLLISION_BORDER(11), DRAW_COLLISION_BORDER_12);
			when DRAW_COLLISION_BORDER_12 => write_instr(COLLISION_BORDER(12), DRAW_COLLISION_BORDER_13);
			when DRAW_COLLISION_BORDER_13 => write_instr(COLLISION_BORDER(13), DRAW_COLLISION_BORDER_14);
			when DRAW_COLLISION_BORDER_14 => write_instr(COLLISION_BORDER(14), DRAW_COLLISION_BORDER_15);
			when DRAW_COLLISION_BORDER_15 => write_instr(COLLISION_BORDER(15), DRAW_COLLISION_BORDER_16);
			when DRAW_COLLISION_BORDER_16 => write_instr(COLLISION_BORDER(16), DRAW_COLLISION_BORDER_17);
			when DRAW_COLLISION_BORDER_17 => write_instr(COLLISION_BORDER(17), DRAW_TETROMINO);


			--██████╗ ██╗      ██████╗  ██████╗██╗  ██╗███████╗
			--██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝██╔════╝
			--██████╔╝██║     ██║   ██║██║     █████╔╝ ███████╗
			--██╔══██╗██║     ██║   ██║██║     ██╔═██╗ ╚════██║
			--██████╔╝███████╗╚██████╔╝╚██████╗██║  ██╗███████║
			--╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝
			when DRAW_TETROMINO =>
				td_start <= '1';
				state_nxt.fsm_state <= WAIT_DRAW_TETROMINO;
				
				
			when WAIT_DRAW_TETROMINO =>
				td_x <= std_logic_vector(resize(signed(state.cur_tetromino_x)*BLOCK_SIZE, td_x'length));
				td_y <= std_logic_vector(resize(signed(state.cur_tetromino_y)*BLOCK_SIZE, td_y'length));
				
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
		tetromino      => state.cur_tetromino,
		rotation       => state.cur_rotation,
		gfx_instr      => td_gfx_instr,
		gfx_instr_wr   => td_gfx_instr_wr,
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


	block_map : block 
		signal block_map_rd_addr : std_logic_vector(log2c(BLOCKS_X*BLOCKS_Y)-1 downto 0);
		signal block_map_wr_addr : std_logic_vector(log2c(BLOCKS_X*BLOCKS_Y)-1 downto 0);
	begin
		process(all)
		begin
			block_map_rd_addr <= std_logic_vector(resize(unsigned(block_map_rd_x) + BLOCKS_X * unsigned(block_map_rd_y), block_map_rd_addr'length));
			block_map_wr_addr <= std_logic_vector(resize(unsigned(block_map_wr_x) + BLOCKS_X * unsigned(block_map_wr_y), block_map_wr_addr'length));
			if (tc_block_map_rd = '1') then
				block_map_rd_addr <= std_logic_vector(resize(unsigned(tc_block_map_x) + BLOCKS_X * unsigned(tc_block_map_y), block_map_rd_addr'length));
			end if;
		end process;
		
		tc_block_map_solid <= block_map_rd_data(0);
		
		block_map : dp_ram_1c1r1w
		generic map (
			ADDR_WIDTH => log2c(BLOCKS_X*BLOCKS_Y),
			DATA_WIDTH => 1
		)
		port map (
			clk      => clk,
			rd1_addr => block_map_rd_addr,
			rd1_data => block_map_rd_data,
			rd1      => block_map_rd or tc_block_map_rd,
			wr2_addr => block_map_wr_addr,
			wr2_data => block_map_wr_data,
			wr2      => block_map_wr
		);
	end block;


	synth_cntrl(0).high_time <= x"30";
	synth_cntrl(0).low_time <= x"30"; 
	synth_cntrl(0).play <= gc_cntrl_state.btn_left;
	synth_cntrl(1).high_time <= x"22";
	synth_cntrl(1).low_time <= x"22"; 
	synth_cntrl(1).play <=  gc_cntrl_state.btn_right;

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
