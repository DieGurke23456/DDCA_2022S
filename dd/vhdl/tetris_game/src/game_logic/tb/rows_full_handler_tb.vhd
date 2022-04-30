library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_game_logic_pkg.all;
use work.vga_gfx_cntrl_pkg.all;


entity tb_rows_full_handler is
end tb_rows_full_handler;
architecture bhv of tb_rows_full_handler is
    constant ROWS : integer := 7;
    constant COLUMNS : integer := 3; 

    signal RES_SIGNAL, START_SIGNAL, BUSY_SIGNAL : std_logic;
    signal CLK_SIGNAL : std_logic := '0';
    signal IN_MATRIX, OUT_MATRIX : t_bb_block_matrix(ROWS - 1 downto 0);

    constant TEST_MATRIX : t_bb_block_matrix(ROWS - 1 downto 0) := (
        (T_BB_I,     T_BB_I, T_BB_I),
        (T_BB_EMPTY, T_BB_T, T_BB_CARO),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_T,     T_BB_T, T_BB_T)
    );
    constant TEST_MATRIX_B : t_bb_block_matrix(ROWS - 1 downto 0) := (
        (T_BB_I,     T_BB_I, T_BB_I),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_T,     T_BB_T, T_BB_T),
        (T_BB_EMPTY, T_BB_T, T_BB_CARO),
        (T_BB_T,     T_BB_T, T_BB_T)
    );
    constant EXPECTED_RESULT_MATRIX : t_bb_block_matrix(ROWS - 1 downto 0) := (
        (T_BB_I,     T_BB_I, T_BB_I),
        (T_BB_EMPTY, T_BB_T, T_BB_CARO),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY)
    );
    constant EXPECTED_RESULT_MATRIX_B: t_bb_block_matrix(ROWS - 1 downto 0) := (
        (T_BB_I,     T_BB_I, T_BB_I),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY),
        (T_BB_EMPTY, T_BB_T, T_BB_CARO),
        (T_BB_EMPTY, T_BB_EMPTY, T_BB_EMPTY)
    );

    signal ROWS_REMOVED : std_logic_vector(3 downto 0);


    type fsm_state_t is (
        WAIT_RESET,
        START_ROWS_FULL_HANDLER, WAIT_ROWS_FULL_HANDLER, CHECK_RESULT
    );
    type state_t is record 
        fsm_state : fsm_state_t;
        stored_matrix : t_bb_block_matrix(ROWS - 1 downto 0);
    end record;
    signal state : state_t := (fsm_state => WAIT_RESET, stored_matrix => TEST_MATRIX_B);
    signal state_nxt : state_t;
begin 
    I_ROWS_FULL_HANDLER : rows_full_handler
    generic map (
        ROWS => ROWS,
        COLUMNS => COLUMNS
    ) port map (
        clk => CLK_SIGNAL,
        res_n => RES_SIGNAL,
        start => START_SIGNAL,
        busy => BUSY_SIGNAL,
        in_matrix => IN_MATRIX,
        out_matrix => OUT_MATRIX,
        rows_removed => ROWS_REMOVED
    );
    
    clk_toggle : process 
	begin
		wait for 10 ns;
		CLK_SIGNAL <= not CLK_SIGNAL;
	end process clk_toggle; 
    reset_single : process
    begin
        RES_SIGNAL <= '0'; 
        wait for 10 ns;
        RES_SIGNAL <= '1';
        wait;
    end process reset_single;
    
    timeout_detection : process
    begin 
        wait for 3000 us;
        report "test-timeout";
        report "test failed!";
        finish;
    end process timeout_detection;
    sync : process(CLK_SIGNAL)
	begin
		if (rising_edge(CLK_SIGNAL)) then
			state <= state_nxt;
		end if;
	end process;

    next_state : process(all)
    begin
        state_nxt <= state;
        START_SIGNAL <= '0';
        case state.fsm_state is 
            WHEN WAIT_RESET => 
                if RES_SIGNAL = '1' then
                    state_nxt.fsm_state <= START_ROWS_FULL_HANDLER;
                else 
                    state_nxt.fsm_state <= WAIT_RESET;
                end if;
            WHEN START_ROWS_FULL_HANDLER => 
                report "starting test!";
                START_SIGNAL <= '1';
                state_nxt.fsm_state <= WAIT_ROWS_FULL_HANDLER;
            WHEN WAIT_ROWS_FULL_HANDLER =>
                IN_MATRIX <= TEST_MATRIX_B;
                if (BUSY_SIGNAL = '0') then
					state_nxt.fsm_state <= CHECK_RESULT;
                    state_nxt.stored_matrix <= OUT_MATRIX;
				end if;
            WHEN CHECK_RESULT => 
                if check_matrix_full_rows(TEST_MATRIX_B) = ROWS_REMOVED then
                    report "full_rows test successfull!";
                else
                    report "full_rows test failed!";
                    report to_string(ROWS_REMOVED);
                    report to_string(check_matrix_full_rows(TEST_MATRIX_B));
                end if;
                if equals(merge_columns_of_matrix(delete_rows_of_matrix(TEST_MATRIX_B, check_matrix_full_rows(TEST_MATRIX_B))), state.stored_matrix) then
                    report "test delete rows successfull!";
                    finish;
                else 
                    report "test delete rows failed!";
                    print(state.stored_matrix);
                    echo(""&LF);
                    print(merge_columns_of_matrix(delete_rows_of_matrix(TEST_MATRIX_B, check_matrix_full_rows(TEST_MATRIX_B))));
                    finish;
                end if;
        end case;
    end process;
    

end architecture;