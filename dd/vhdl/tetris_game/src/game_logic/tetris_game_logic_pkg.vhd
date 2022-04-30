library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

use work.math_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_util_pkg.all;

package tetris_game_logic_pkg is

    component rows_full_handler is 
    generic (
        ROWS: integer;
        COLUMNS: integer
    );
    port (
        clk: in std_logic;
        res_n : in std_logic;
        start : in std_logic;
        busy : out std_logic;
        in_matrix : in t_bb_block_matrix(ROWS - 1 downto 0);
        out_matrix : out t_bb_block_matrix(ROWS - 1 downto 0);
        rows_removed : out std_logic_vector(3 downto 0)
    );
    end component;

    component add_tetromino_handler is 
    generic (
        ROWS : integer;
        COLUMNS : integer
    ); port (
        clk: in std_logic;
        res_n : in std_logic;
        start : in std_logic;
        busy : out std_logic;
        in_matrix : in t_bb_block_matrix(ROWS - 1 downto 0);
        out_matrix : out t_bb_block_matrix(ROWS - 1 downto 0);
        tetromino : in tetromino_t;
        rotation : in rotation_t;
        x: in integer;
        y: in integer
    );
    end component;

end package;

package body tetris_game_logic_pkg is 
end package body;