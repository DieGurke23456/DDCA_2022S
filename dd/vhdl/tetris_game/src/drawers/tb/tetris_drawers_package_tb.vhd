library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.vga_gfx_cntrl_pkg.all;


entity tb_tetris_drawers_package is
end tb_tetris_drawers_package;

architecture bhv of tb_tetris_drawers_package is
    signal RES_SIGNAL, START_SIGNAL, BUSY_SIGNAL : std_logic;
    signal CLK_SIGNAL: std_logic := '0';
    constant BLOCKS_X : natural := 10;
    constant BLOCKS_Y : natural := 20;
    signal X_SIGNAL: integer range 0 to (BLOCKS_X - 1);
    signal Y_SIGNAL: integer range 0 to (BLOCKS_Y - 1);
    signal BLOCK_TO_DRAW_SIGNAL : t_bb_block;
    signal GFX_INSTR_VECTOR : std_logic_vector(GFX_INSTR_WIDTH - 1 downto 0);
    signal GFX_INSTR_WR_SIGNAL, GFX_INSTR_FULL_SIGNAL: std_logic; 

begin
    I_BLOCK_DRAWER : block_drawer
    generic map (
        BLOCK_SIZE => 12,        -- size of a block in px
        BLOCKS_X => BLOCKS_X,    -- size of coordinate system in x dimension
        BLOCKS_Y => BLOCKS_Y     -- size of coordinate system in y dimension
    ) port map (
        clk => CLK_SIGNAL,
        res_n => RES_SIGNAL,
        start => START_SIGNAL,
        busy => BUSY_SIGNAL,
        x => X_SIGNAL,
        y => Y_SIGNAL,
        block_to_draw => BLOCK_TO_DRAW_SIGNAL,
        gfx_instr => GFX_INSTR_VECTOR,
        gfx_instr_wr => GFX_INSTR_WR_SIGNAL,
        gfx_instr_full => GFX_INSTR_FULL_SIGNAL
    );

    clk_toggle : process 
	begin
		wait for 10 ns;
		CLK_SIGNAL <= not CLK_SIGNAL;
	end process clk_toggle; 

    main : process
        variable test_tetromino: tetromino_t;
        variable test_t_bb: t_bb_block;
        variable test_x_cords: t_bb_x_cords;
        variable test_y_cords: t_bb_y_cords;
        variable test_matrix_a: t_bb_block_matrix(0 to 4) := (
            (T_BB_I,     T_BB_I, T_BB_I),
            (T_BB_EMPTY, T_BB_T, T_BB_CARO),
            (T_BB_T,     T_BB_T, T_BB_T),
            (T_BB_T,     T_BB_T, T_BB_T),
            (T_BB_T,     T_BB_T, T_BB_T)
        );
        variable out_matrix_a: t_bb_block_matrix(0 to 4) := (
            (T_BB_I,     T_BB_I, T_BB_I),
            (T_BB_EMPTY, T_BB_T, T_BB_CARO),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY)
        );
        variable merged_matrix_a: t_bb_block_matrix(0 to 4) := (
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_I,     T_BB_I, T_BB_I),
            (T_BB_EMPTY, T_BB_T, T_BB_CARO)
        );
        variable test_matrix_b: t_bb_block_matrix(0 to 4) := (
            (T_BB_I,     T_BB_I, T_BB_I),
            (T_BB_T,     T_BB_T, T_BB_T),
            (T_BB_T,     T_BB_T, T_BB_T),
            (T_BB_EMPTY, T_BB_T, T_BB_CARO),
            (T_BB_T,     T_BB_T, T_BB_T)
        );
        variable out_matrix_b: t_bb_block_matrix(0 to 4) := (
            (T_BB_I,     T_BB_I, T_BB_I),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_T, T_BB_CARO),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY)
        );
        variable merged_matrix_b: t_bb_block_matrix(0 to 4) := (
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_I,     T_BB_I, T_BB_I),
            (T_BB_EMPTY, T_BB_T, T_BB_CARO)
        );
        constant EMPTY_MATRIX: t_bb_block_matrix(0 to 4) := (
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
            (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY)
        );


    begin
        report "testing get_T_BB_from_tetromino" ;
        if get_T_BB_from_tetromino(TET_T) = T_BB_T then 
            report "test 1 passed";
        else
            report "test 1 failed";
        end if;
        
        if get_tetromino_from_T_BB(T_BB_T) = TET_T then 
            report "test 2 passed";
        else 
            report "test 2 failed";
        end if;

        report "testing get_bb_x_from_t_BB";
        
        if get_bb_x_from_t_BB(T_BB_T) = 0 then
            report "test 3 passed";
        else 
            report "test 3 failed";
        end if;

        if get_bb_y_from_t_BB(T_BB_T) = 5 then 
            report "test 4 passed";
        else 
            report "test 4 failed";
        end if;

        if check_block_row_full(test_matrix_a(2)) then 
            report "test 5 passed";
        else if check_matrix_full_rows(test_matrix_a) = "0111" then
            report "test 7 passed";
        else
            report to_string(check_matrix_full_rows(test_matrix_a));
        end if;
            report "test 5 failed";
        end if;

        if check_block_row_full(test_matrix_a(1)) then 
            report "test 6 failed";
        else 
            report "test 6 passed";
        end if;
        if check_matrix_full_rows(test_matrix_a) = "0111" then
            report "test 7 passed";
            report to_string(check_matrix_full_rows(test_matrix_a));
        else
            report to_string(check_matrix_full_rows(test_matrix_a));
        end if;

        if check_matrix_full_rows(test_matrix_b) = "1101" then
            report "test 8 passed";
            report to_string(check_matrix_full_rows(test_matrix_b));
        else
            report "test 8 failed";
        end if;

        if equals(test_matrix_a(0), test_matrix_a(0)) then
            report "test 10 passed";
        else
            report "test 10 failed";
        end if;
        if not equals(test_matrix_a(0), test_matrix_a(1)) then
            report "test 11 passed";
        else
            report "test 11 failed";
        end if;

        if equals(test_matrix_a,test_matrix_a) then 
            report "test 12 passed";
        else
            report "test 12 failed";
        end if;
        if not equals(test_matrix_a,test_matrix_b) then 
            report "test 12 passed";
        else
            report "test 12 failed";
        end if;

        if equals(out_matrix_a, delete_rows_of_matrix(test_matrix_a, check_matrix_full_rows(test_matrix_a))) then
            report "test 13 passed";
        else 
            report "test 13 failed";
        end if;

        if check_block_row_empty(EMPTY_ROW) then 
            report "test_empty_1 passed";
        else 
            report "test_empty_1 failed";
        end if; 

        if check_block_row_empty(out_matrix_a(0)) then
            report "test_empty_2 failed";
        else 
            report "test_empty_2 passed";
        end if;

        if check_block_row_empty(out_matrix_a(2)) then
            report "test_empty_3 passed";
        else
            report "test_empty_3 failed";
        end if;
        
        if equals(out_matrix_b, delete_rows_of_matrix(test_matrix_b, check_matrix_full_rows(test_matrix_b))) then
            report "test 14 passed";
        else 
            report "test 14 failed";
            echo(""&LF);
            print(out_matrix_b);
            echo(""&LF);
            print(delete_rows_of_matrix(test_matrix_b, check_matrix_full_rows(test_matrix_b)));
        end if;

        if equals(merged_matrix_a,
                merge_columns_of_matrix(
                    delete_rows_of_matrix(test_matrix_b, check_matrix_full_rows(test_matrix_b))
                )
            ) then
            report "test 15 passed";
        else
            report "test 15 failed";
            print(merged_matrix_a);
            echo(""&LF);
            print(                merge_columns_of_matrix(
                delete_rows_of_matrix(test_matrix_b, check_matrix_full_rows(test_matrix_b))
            ));
            echo(""&LF);
        end if;
        print(add_tetromino_to_matrix(EMPTY_MATRIX, TET_T, ROT_0, 0,3));

        finish;

        wait;	
	end process;
end bhv; 