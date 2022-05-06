library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_game_logic_pkg.all;
entity rows_full_handler is 
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
        rows_removed : out integer range 0 to ROWS
    );
end entity;
architecture arch of rows_full_handler is 
    type fsm_state_t is (RFH_IDLE, CHECK_ROWS, CHECK_ROW_FULL, CHECK_BLOCK_IS_EMPTY, REMOVE_FULL_ROWS, REMOVE_FULL_ROW, REMOVE_BLOCK, MERGE_COLUMNS);
    type state_t is record 
        fsm_state: fsm_state_t;
        current_row : integer range 0 to ROWS;
        current_column : integer range 0 to COLUMNS;
        row_adding: integer range 0 to ROWS;
        row_full: std_logic;
        rows_removed: std_logic_vector(ROWS - 1 downto 0);
        rows_removed_count: integer range 0 to ROWS;
        rows_removed_matrix: t_bb_block_matrix(ROWS - 1 downto 0); 
        out_matrix : t_bb_block_matrix(ROWS - 1 downto 0);
    end record;
    constant EMPTY_ROW_CUSTOM:  t_bb_block_row(COLUMNS -1 downto 0) := (others => T_BB_EMPTY);
    constant EMPTY_MATRIX : t_bb_block_matrix(ROWS - 1 downto 0) := (others => EMPTY_ROW_CUSTOM);
    signal state, state_nxt: state_t;
begin

    sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			state <= (
				fsm_state => RFH_IDLE,
				current_row => 0,
				current_column => 0,
				row_full => '0',
                rows_removed => (others => '0'),
                rows_removed_count => 0,
                row_adding => 0,
                rows_removed_matrix => EMPTY_MATRIX,
                out_matrix => EMPTY_MATRIX
			);
		elsif (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;

    next_state : process(all)
    begin
        state_nxt <= state;
		busy <= '1';
        rows_removed <= state.rows_removed_count;
        out_matrix <= state.out_matrix;
        case state.fsm_state is 
            WHEN RFH_IDLE =>
                busy <= '0';
                if (start = '1') then
                    busy <= '1';
                    state_nxt.fsm_state <= CHECK_ROWS;
                    state_nxt.current_row <= 0;
                    state_nxt.current_column <= 0;
                    state_nxt.row_full <= '0';
                    state_nxt.rows_removed <= (others => '0');
                    state_nxt.rows_removed_count <= 0;
                end if;
            WHEN CHECK_ROWS => 
                state_nxt.rows_removed_matrix <= in_matrix;
                if (state.current_row < ROWS) then
                    state_nxt.row_full <= '1';
                    state_nxt.fsm_state <= CHECK_ROW_FULL;
                else
                    state_nxt.current_row <= 0;
                    state_nxt.fsm_state <= REMOVE_FULL_ROWS;
                end if;
                if state.row_full then
                    state_nxt.rows_removed_count <= state.rows_removed_count + 1; 
                end if;
                state_nxt.rows_removed <= state.rows_removed(ROWS - 2 downto 0) & state.row_full;
            WHEN CHECK_ROW_FULL =>
                if state.current_column < COLUMNS then
                    state_nxt.fsm_state <= CHECK_BLOCK_IS_EMPTY;
                else
                    state_nxt.current_column <= 0;
                    state_nxt.current_row <= state.current_row + 1;
                    state_nxt.fsm_state <= CHECK_ROWS;
                end if;
            WHEN CHECK_BLOCK_IS_EMPTY =>                 
                if in_matrix(state.current_row)(state.current_column) = T_BB_EMPTY then 
                    state_nxt.row_full <= '0';
                end if;
                state_nxt.current_column <= state.current_column + 1;
                state_nxt.fsm_state <= CHECK_ROW_FULL;                
            WHEN REMOVE_FULL_ROWS => 
                if state.current_row < ROWS then 
                    state_nxt.fsm_state <= REMOVE_FULL_ROW;
                else 
                    state_nxt.current_row <= 0; 
                    state_nxt.row_adding <= 0;
                    state_nxt.fsm_state <= MERGE_COLUMNS;
                    state_nxt.out_matrix <= EMPTY_MATRIX;
                end if;
            WHEN REMOVE_FULL_ROW => 
                if state.current_column < COLUMNS and state.rows_removed(state.current_row) = '1' then 
                    state_nxt.fsm_state <= REMOVE_BLOCK;
                else 
                    state_nxt.current_column <= 0;
                    state_nxt.current_row <= state.current_row + 1;
                    state_nxt.fsm_state <= REMOVE_FULL_ROWS;
                end if;
            WHEN REMOVE_BLOCK =>
                state_nxt.rows_removed_matrix(state.current_row)(state.current_column) <= T_BB_EMPTY;
                state_nxt.current_column <= state.current_column + 1;
                state_nxt.fsm_state <= REMOVE_FULL_ROW;
            WHEN MERGE_COLUMNS =>
                    if (state.current_row  < state.rows_removed'length) and
                        (state.rows_removed(in_matrix'length - 1 - state.current_row) = '1') then
                        report "deleting row " & integer'image(state.current_row);
                        report integer'image(in_matrix'length -1 -state.current_row);
                    else 
                        state_nxt.out_matrix(state.row_adding) <= in_matrix(state.current_row);
                        state_nxt.row_adding <= state.row_adding + 1;
                    end if;
                    if state.current_row = state_nxt.out_matrix'length then 
                        state_nxt.fsm_state <= RFH_IDLE;
                    else
                        state_nxt.current_row <= state.current_row + 1; 
                        state_nxt.fsm_state <= MERGE_COLUMNS;
                    end if;    
        end case;
    end process;

end architecture;