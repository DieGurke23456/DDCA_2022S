library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use std.env.finish;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_game_logic_pkg.all;
use work.vga_gfx_cntrl_pkg.all;
use work.math_pkg.all;


entity tb_matrix_for_collision_map is 
end tb_matrix_for_collision_map;
architecture bhv of tb_matrix_for_collision_map is
    constant BLOCKS_X: integer := 3;
    constant BLOCKS_Y: integer := 5;
    signal clk: std_logic := '0';
    signal res_n, tc_start, tc_busy, tc_collision_detected : std_logic;
    
    signal tc_block_map_x : std_logic_vector(log2c(BLOCKS_X)-1 downto 0) := (others => '0');
	signal tc_block_map_y : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0) := (others => '0');
	signal tc_block_map_rd : std_logic;
	signal tc_block_map_solid : std_logic;

    constant test_matrix : t_bb_block_matrix(0 to BLOCKS_Y - 1) :=(
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY,     T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY,     T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_WALL,     T_BB_WALL, T_BB_WALL)
    );

    type fsm_state_t is (WAIT_RESET, START_TETROMINO_COLLIDER, WAIT_TETROMINO_COLLIDER, CHECK_RESULT);
    
    type state_t is record 
        fsm_state: fsm_state_t;
        dest_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
        dest_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
        dest_tetromino: tetromino_t;
        dest_rotation: rotation_t;
    end record;

    -- test case here! 
    signal state : state_t := (
        fsm_state => WAIT_RESET, 
        dest_tetromino_x => "000",
        dest_tetromino_y => "0000",
        dest_tetromino => TET_T,
        dest_rotation => ROT_0
    );
    signal state_nxt : state_t;
begin 
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
        signal block_map_x_int : integer;
        signal block_map_y_int : integer;
    begin
        x_y: process(all)
        begin
            block_map_x_int <= to_integer(unsigned(tc_block_map_x));
            block_map_y_int <= to_integer(unsigned(tc_block_map_y));
            if (tc_block_map_rd = '1') then
                block_map_x_int <= to_integer(unsigned(tc_block_map_x));
                block_map_y_int <= to_integer(unsigned(tc_block_map_y));
            end if;
        end process;

        check_solid :process(all)
        begin 
            echo ("checking block " & integer'image(block_map_x_int) & " " & integer'image(block_map_y_int) & LF); 
            if (block_map_y_int > -1 and block_map_y_int < test_matrix'length and block_map_x_int > -1 and block_map_x_int < BLOCKS_X) then 
                if (test_matrix(test_matrix'length - 1 - block_map_y_int)(block_map_x_int) = T_BB_EMPTY) then 
                    tc_block_map_solid <= '0';
                else 
                    tc_block_map_solid <= '1';
                end if;
            end if;
        end process;
    end block;

    clk_toggle : process 
    begin
        wait for 10 ns;
        clk <= not clk;
    end process clk_toggle; 

    reset_single : process
    begin
        res_n <= '0'; 
        wait for 10 ns;
        res_n <= '1';
        wait;
    end process reset_single;

    timeout_detection : process
    begin 
        report "timeout_detection!!";
        wait for 300000 us;
        report "test-timeout";
        report "test failed!";
        finish;
    end process timeout_detection;

    sync : process(clk)
	begin
		if (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;

    next_state : process(all)
        variable out_matrix: t_bb_block_matrix := test_matrix;
    begin 
        state_nxt <= state;
        tc_start <= '0';
        case state.fsm_state is 
            WHEN WAIT_RESET => 
                report "WAIT_RESET!";
                if res_n = '1' then
                    report "starting test!";
                    state_nxt.fsm_state <= START_TETROMINO_COLLIDER;
                else 
                    state_nxt.fsm_state <= WAIT_RESET;
                end if;
            WHEN START_TETROMINO_COLLIDER => 
                echo("START_TETROMINO_COLLIDER!!" & LF);
                tc_start <= '1';
                state_nxt.fsm_state <= CHECK_RESULT;
            WHEN CHECK_RESULT => 
                state_nxt.fsm_state <= WAIT_TETROMINO_COLLIDER;
            WHEN WAIT_TETROMINO_COLLIDER =>
                echo("WAIT_TETROMINO_COLLIDER" & LF );
                if (tc_busy = '0') then
                    if (tc_collision_detected = '0') then
                        echo("no collision_detected!");
                    else
                        echo("collision_detected!");
                    end if;
                    echo(LF &"out_matrix: "&LF);
                    print(add_tetromino_to_matrix(test_matrix, TET_T, ROT_0, 0, 0));
                    finish;
                end if;
        end case;
    end process;
end architecture;