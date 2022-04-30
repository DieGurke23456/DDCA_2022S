library ieee;
use ieee.std_logic_1164.all;
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
    signal clk, res_n, tc_start, tc_busy, tc_collision_detected : std_logic;
    
    signal tc_block_map_x : std_logic_vector(log2c(BLOCKS_X)-1 downto 0);
	signal tc_block_map_y : std_logic_vector(log2c(BLOCKS_Y)-1 downto 0);
	signal tc_block_map_rd : std_logic;
	signal tc_block_map_solid : std_logic;

    constant test_matrix : t_bb_block_matrix(BLOCKS_Y - 1 downto 0) :=(
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_T,     T_BB_T, T_BB_T)
    );

    type fsm_state_t is (TB_WAIT);

    type state_t is record 
        fsm_state: fsm_state_t;
        dest_tetromino_x : std_logic_vector(log2c(BLOCKS_X) downto 0); --signed
        dest_tetromino_y : std_logic_vector(log2c(BLOCKS_Y) downto 0); --signed
        dest_tetromino: tetromino_t;
        dest_rotation: rotation_t;
    end record;
    signal state, state_nxt: state_t;
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
        process(all)
        begin
            if (tc_block_map_rd = '1') then
                block_map_x_int <= to_integer(unsigned(tc_block_map_x));
                block_map_y_int <= to_integer(unsigned(tc_block_map_y));
            end if;
        end process;

        check_solid :process(block_map_x_int, block_map_y_int)
        begin 
            if (test_matrix(block_map_y_int)(block_map_x_int) = T_BB_EMPTY) then 
                tc_block_map_solid <= '0';
            else 
                tc_block_map_solid <= '1';
            end if;
        end process;
    end block;

end architecture;