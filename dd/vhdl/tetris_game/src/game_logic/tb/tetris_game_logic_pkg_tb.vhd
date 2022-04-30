library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_game_logic_pkg.all;
use work.vga_gfx_cntrl_pkg.all;


entity tb_tetris_game_logic_pkg is
end tb_tetris_game_logic_pkg;
architecture bhv of tb_tetris_game_logic_pkg is
    constant TEST_MATRIX_A : t_bb_block_matrix(4 downto 0) := (
        (T_BB_I,     T_BB_I, T_BB_I),
        (T_BB_EMPTY, T_BB_T, T_BB_CARO),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_T,     T_BB_T, T_BB_T)
    );
    constant OUT_MATRIX_A : t_solidity_matrix(4 downto 0) := (
        "111",
        "011",
        "111",
        "111",
        "111"
    );
    constant TEST_MATRIX_B : t_bb_block_matrix(4 downto 0) := (
        (T_BB_EMPTY,     T_BB_I, T_BB_I),
        (T_BB_T,     T_BB_T, T_BB_EMPTY),
        (T_BB_T,     T_BB_EMPTY, T_BB_T),
        (T_BB_EMPTY, T_BB_T, T_BB_CARO),
        (T_BB_T,     T_BB_T, T_BB_T)
    );
    constant OUT_MATRIX_B : t_solidity_matrix(4 downto 0) := (
        "011",
        "110",
        "101",
        "011",
        "111"
    );

begin 
    main : process
        begin
        
        report "1 :is_solid_at(row)";
        assert is_solid_at(TEST_MATRIX_A(0), 0) = '1' report "test 1 failed!" severity error; 
        
        report "2 :is_solid_at(row)";
        assert is_solid_at(TEST_MATRIX_A(1), 0) = '0' report "test 2 failed!" severity error;
        
        report "3 :is_solid_at(matrix)";
        assert is_solid_at(TEST_MATRIX_A, 0, 0) = '1' report "test 3 failed!" severity error;

        report "4 :is_solid_at(matrix)";
        assert is_solid_at(TEST_MATRIX_A, 0,1) = '0' report "test 4 failed!" severity error;

        report "5 :equals(rows)";
        assert equals(OUT_MATRIX_A(0), OUT_MATRIX_A(0)) report "test 5 failed!" severity error;

        report "6 :equals(rows)";
        assert not equals(OUT_MATRIX_A(0), OUT_MATRIX_A(1)) report "test 6 failed!" severity error;

        report "7 :row_to_solidity_vector";
        assert equals(row_to_solidity_vector(TEST_MATRIX_A(0)), OUT_MATRIX_A(0)) report "test 7 failed!" severity error;
        
        report "8 :row_to_solidity_vector";
        assert equals(row_to_solidity_vector(TEST_MATRIX_A(1)), OUT_MATRIX_A(1)) report "test 8 failed!" severity error;
        
        report "9 :equals(matrixs)";
        assert equals(OUT_MATRIX_A, OUT_MATRIX_A) report "test 9 failed!" severity error;

        report "10 :equals(matrixs)";
        assert not equals(OUT_MATRIX_A, OUT_MATRIX_B) report "test 10 failed!" severity error;
        
        report "11 :matrix_to_solidity_matrix";
        assert equals(matrix_to_solidity_matrix(TEST_MATRIX_A), OUT_MATRIX_A) report "test 11 failed!" severity error;

        report "12 :matrix_to_solidity_matrix";
        assert equals(matrix_to_solidity_matrix(TEST_MATRIX_B), OUT_MATRIX_B) report "test 12 failed!" severity error;        
        
        wait;

    end process;    

end architecture;