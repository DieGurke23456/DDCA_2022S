library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

use work.math_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_util_pkg.all;

package tetris_game_logic_pkg is

    subtype t_solidity_row is std_logic_vector(0 to 2);
    type t_solidity_matrix is array (integer range<>) of t_solidity_row;

    function matrix_to_solidity_matrix(matrix: t_bb_block_matrix) return t_solidity_matrix;
    function row_to_solidity_vector(row: t_bb_block_row) return t_solidity_row;
    function is_solid_at(matrix: t_bb_block_matrix; x: integer; y: integer) return std_logic;
    function is_solid_at(row: t_bb_block_row; x: integer) return std_logic;

    function equals(a,b: t_solidity_row) return boolean;
    function equals(a,b: t_solidity_matrix) return boolean;


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
    function is_solid_at(row: t_bb_block_row; x: integer) return std_logic is
        variable to_return : std_logic := '0';
        begin 
            if (row(x) /= T_BB_EMPTY) then
                to_return := '1';
            end if;
            return to_return;
    end function;

    function is_solid_at(matrix: t_bb_block_matrix; x: integer; y: integer) return std_logic is
        variable to_return :std_logic := '0';
        begin
            if(matrix(y)(x) /= T_BB_EMPTY) then
                to_return := '1';
            end if;
            return to_return;
    end function;

    function row_to_solidity_vector(row: t_bb_block_row) return t_solidity_row is 
        variable to_return : t_solidity_row := (others => '0');
        begin 
            for i in 0 to row'length - 1 loop
                to_return(i) := is_solid_at(row, i);
            end loop;
            return to_return;
    end function;

    function matrix_to_solidity_matrix(matrix: t_bb_block_matrix) return t_solidity_matrix is
        variable to_return : t_solidity_matrix(matrix'length - 1 downto 0);
        begin 
            for i in 0 to matrix'length - 1 loop
                to_return(i) := row_to_solidity_vector(matrix(i));
            end loop;
            return to_return;
    end function;

    function equals(a,b: t_solidity_row) return boolean is
        variable to_return : boolean := true;
        begin
            for i in 0 to a'length - 1 loop 
                if (a(i) /= b(i)) then
                    to_return := false;
                    exit;   -- break
                end if;
            end loop;
            return to_return;
    end function;

    function equals(a,b: t_solidity_matrix) return boolean is 
        variable to_return : boolean := true;
        begin 
            for i in 0 to a'length - 1 loop
                if not equals(a(i), b(i)) then
                    to_return := false;
                    exit;   --break
                end if;
            end loop;
            return to_return;
    end function;
 
end package body;