library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

use work.math_pkg.all;
use work.tetris_util_pkg.all;
use work.vga_gfx_cntrl_pkg.all;

package tetris_drawers_pkg is
    constant BB_BLOCK_SIZE: natural := 12;
    
    --constant ROWS: natural := 20;
    --constant COLUMNS: natural := 10;

    subtype t_bb_x_cords is natural range 0 to 10;
    subtype t_bb_y_cords is natural range 0 to 9;
    type t_bb_block is(
        T_BB_EMPTY,
        T_BB_T,
        T_BB_I,
        T_BB_O,
        T_BB_S,
        T_BB_Z,
        T_BB_J,
        T_BB_L,
        T_BB_CARO,
        T_BB_WALL
    );
    subtype t_slv_block is std_logic_vector(3 downto 0);
    type t_bb_block_row is array (integer range <>) of t_bb_block;
    
    --TODO change row span using constants 
    type t_bb_block_matrix is array (integer range <>) of t_bb_block_row(0 to 2);
    
    subtype t_filled_rows is std_logic_vector(3 downto 0); 

    constant EMPTY_ROW : t_bb_block_row (0 to 2) := (others => T_BB_EMPTY);
    
    function get_T_BB_from_tetromino(tetromino :tetromino_t) return t_bb_block;

    function get_tetromino_from_T_BB(t_bb: t_bb_block) return tetromino_t;

    function get_bb_x_from_t_BB(t_bb: t_bb_block) return t_bb_x_cords;
    function get_bb_y_from_t_BB(t_bb: t_bb_block) return t_bb_y_cords; 

    function check_block_row_full(row: t_bb_block_row) return boolean;
    function check_block_row_empty(row: t_bb_block_row) return boolean;

    function check_matrix_full_rows(matrix: t_bb_block_matrix) return t_filled_rows;
    function delete_rows_of_matrix(matrix: t_bb_block_matrix; to_delete: t_filled_rows) return t_bb_block_matrix;
    function merge_columns_of_matrix(matrix: t_bb_block_matrix) return t_bb_block_matrix;

    function add_tetromino_to_matrix(matrix: t_bb_block_matrix; tetromino: tetromino_t; rotation: rotation_t; x: integer; y: integer) return t_bb_block_matrix; 

    function equals(a,b: t_bb_block_row) return boolean;
    function equals(a,b: t_bb_block_matrix) return boolean;

    function to_string(b: t_bb_block) return string;
    procedure echo (arg : in string := "");
    procedure print(row: t_bb_block_row);
    procedure print(matrix: t_bb_block_matrix);
    

    component block_drawer is
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
			x : in integer range 0 to (BLOCKS_X - 1);
			y : in integer range 0 to (BLOCKS_Y - 1);
            block_to_draw : t_bb_block;
			gfx_instr : out std_logic_vector(GFX_INSTR_WIDTH - 1 downto 0);
			gfx_instr_wr : out std_logic;
			gfx_instr_full : in std_logic
		);
	end component;
    
    component block_line_drawer is
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
    end component;
    component block_matrix_drawer is 
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
    end component;



end package;

package body tetris_drawers_pkg is 
    function get_T_BB_from_tetromino(tetromino :tetromino_t) return t_bb_block is
        variable to_return : t_bb_block := T_BB_EMPTY; 
    begin
        case tetromino is 
            when TET_T => to_return := T_BB_T;
            when TET_I => to_return := T_BB_I;
            when TET_O => to_return := T_BB_O;
            when TET_S => to_return := T_BB_S;
            when TET_Z => to_return := T_BB_Z;
            when TET_J => to_return := T_BB_J;
            when TET_L => to_return := T_BB_L; 
            when OTHERS => to_return := T_BB_EMPTY;
        end case; 
        return to_return;
    end function;
    
    function get_tetromino_from_T_BB(t_bb: t_bb_block) return tetromino_t is
        variable to_return : tetromino_t := TET_T;
    begin
        case t_bb is
            when T_BB_T => to_return := TET_T; 
            when T_BB_I => to_return := TET_I; 
            when T_BB_O => to_return := TET_O; 
            when T_BB_S => to_return := TET_S; 
            when T_BB_Z => to_return := TET_Z; 
            when T_BB_J => to_return := TET_J; 
            when T_BB_L => to_return := TET_L;
            when OTHERS => return "ZZZ";
        end case;
        return to_return;
    end function;     

    
    function get_bb_x_from_t_BB(t_bb: t_bb_block) return t_bb_x_cords is
        variable to_return : t_bb_x_cords;
    begin
        case t_bb is
            when T_BB_EMPTY=> to_return := 1;
            when T_BB_T=> to_return := 0;
            when T_BB_I=> to_return := 1;
            when T_BB_O=> to_return := 2;
            when T_BB_S=> to_return := 3;
            when T_BB_Z=> to_return := 4;
            when T_BB_J=> to_return := 5;
            when T_BB_L=> to_return := 6;
            when T_BB_CARO=> to_return := 7;
            when T_BB_WALL=> to_return := 0;            
        end case;
        return to_return;
    end function;

    function get_bb_y_from_t_BB(t_bb: t_bb_block) return t_bb_y_cords is
        variable to_return : t_bb_y_cords;
    begin
        case t_bb is
            when T_BB_T | T_BB_I | T_BB_O | T_BB_S | T_BB_Z | T_BB_J | T_BB_L | T_BB_CARO => 
                to_return := 5;
            when T_BB_WALL => 
                to_return := 6;
            when others => 
                to_return := 6;
        end case;
        return to_return; 
    end function;

    function check_block_row_full(row: t_bb_block_row) return boolean is 
        variable to_return : boolean := true;
    begin 
        for i in 0 to (row'length - 1) loop 
            if row(i) = T_BB_EMPTY then
                to_return := false;
                exit;
            end if;
        end loop;
        return to_return;
    end function;

    function check_block_row_empty(row: t_bb_block_row) return boolean is 
    begin
        return equals(row, EMPTY_ROW);
    end function;

    
    function check_matrix_full_rows(matrix: t_bb_block_matrix) return t_filled_rows is
        variable to_return : t_filled_rows:= "0000";
        variable cur_row : integer;
    begin 
        for row in 1 to 4 loop 
            cur_row := matrix'length - row;
            if check_block_row_full(matrix(cur_row)) then 
                to_return(row - 1) := '1';
            end if;
        end loop;
        return to_return;
    end function;

    function delete_rows_of_matrix(matrix: t_bb_block_matrix; to_delete: t_filled_rows) return t_bb_block_matrix is 
        variable to_return: t_bb_block_matrix(matrix'length - 1 downto 0);
        variable cur_row: integer;
    begin
        for i in 0 to matrix'length - 4 loop 
            to_return(i) := matrix(i);
        end loop;

        for i in 0 to to_delete'length - 1 loop 
            cur_row := matrix'length - i - 1;
            if to_delete(i)='1' then
                to_return(cur_row) := (others => T_BB_EMPTY);
            else 
                to_return(cur_row) := matrix(cur_row);
            end if;
        end loop;
        return to_return;
    end function;

    function merge_columns_of_matrix(matrix: t_bb_block_matrix) return t_bb_block_matrix is
        variable to_return: t_bb_block_matrix(matrix'length - 1 downto 0);
        variable row_adding: integer:= (matrix'length - 1);
    begin
        for i in (matrix'length - 1) downto 0 loop
            if not check_block_row_empty(matrix(i)) then
                to_return(row_adding) := matrix(i);
                row_adding := row_adding - 1;
            end if; 
        end loop;
        return to_return;
    end function;

    function add_tetromino_to_matrix(matrix: t_bb_block_matrix; tetromino: tetromino_t; rotation: rotation_t; x: integer; y: integer) return t_bb_block_matrix is 
        variable to_return: t_bb_block_matrix(matrix'length - 1 downto 0);
        variable blocks: tetromino_blocks_t;
        variable block_bb: t_bb_block; 
    begin   
        blocks := get_blocks(tetromino, rotation);
        to_return := matrix;
        block_bb := get_T_BB_from_tetromino(tetromino);
        for i in 0 to 3 loop
            for j in  0 to 3 loop 
                if blocks((3-i)*4 + (3-j)) = '1' then
                    to_return(y + i )(x + j) := block_bb;
                end if;
            end loop;
        end loop;
        return to_return;
    end function;




    --region misc
    function to_string(b: t_bb_block) return string is
    begin
        case b is 
            when T_BB_T => return "T_BB_T"; 
            when T_BB_I => return "T_BB_I"; 
            when T_BB_O => return "T_BB_O"; 
            when T_BB_S => return "T_BB_S"; 
            when T_BB_Z => return "T_BB_Z"; 
            when T_BB_J => return "T_BB_J"; 
            when T_BB_L => return "T_BB_L"; 
            when T_BB_EMPTY => return "T_BB_E"; 
            when T_BB_CARO => return "T_BB_C"; 
            when T_BB_WALL => return "T_BB_W";
        end case;
    end function;
    
    procedure print(row: t_bb_block_row) is
    begin
        for i in 0 to row'length - 1 loop 
            echo(to_string(row(i)) & " ");
        end loop;
        echo("" & LF);
    end procedure;

    procedure print(matrix: t_bb_block_matrix) is 
    begin 
        for i in 0 to matrix'length - 1 loop
            print(matrix(i));
        end loop;
    end procedure;

    
    procedure echo (arg : in string := "") is
    begin
        std.textio.write(std.textio.output, arg);
    end procedure echo;
    
    function equals(a,b: t_bb_block_row) return boolean is
    begin 
        for i in 0 to a'length - 1 loop
            if a(i) /= b(i) then 
                return false;
            end if;
        end loop;
        return true;
    end function;
    
    function equals(a,b: t_bb_block_matrix) return boolean is
    begin 
        for i in 0 to a'length - 1 loop
            if not equals(a(i), b(i)) then
                return false;
            end if;
        end loop;
        return true;
    end function;
    --endregion
    


end package body;