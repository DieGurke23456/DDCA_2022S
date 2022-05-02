library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_game_logic_pkg.all;

entity add_tetromino_handler is 
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
end entity;
architecture arch of add_tetromino_handler is 

    type fsm_state_t is (ATH_IDLE, ADD_TETROMINO,ADD_TETROMINO_ROW, ADD_BLOCK);
    type state_t is record 
        fsm_state: fsm_state_t;
        current_x: integer;
        current_y: integer;
        out_matrix : t_bb_block_matrix(ROWS - 1 downto 0);
    end record;
    signal state, state_nxt: state_t;

    constant EMPTY_ROW_CUSTOM:  t_bb_block_row(COLUMNS -1 downto 0) := (others => T_BB_EMPTY);
    constant EMPTY_MATRIX : t_bb_block_matrix(ROWS - 1 downto 0) := (others => EMPTY_ROW_CUSTOM);
begin
    sync : process(clk, res_n)
        begin
            if (res_n = '0') then
                state <= (
                    fsm_state => ATH_IDLE,
                    out_matrix => EMPTY_MATRIX,
                    current_x => 0,
                    current_y => 0
                );
            elsif (rising_edge(clk)) then
                state <= state_nxt;
            end if;
        end process;

    next_state : process(all)
        variable blocks_solid: tetromino_blocks_t;
    begin 
    state_nxt <= state;
        busy <= '1';
        out_matrix <= state.out_matrix;
        case state.fsm_state is 
            WHEN ATH_IDLE =>
                busy <= '0';
                if (start = '1') then
                    busy <= '1';
                    state_nxt.fsm_state <= ADD_TETROMINO;
                    state_nxt.out_matrix <= in_matrix;
                    state_nxt.current_x <= 0;
                    state_nxt.current_y <= 0;
                end if;
            WHEN ADD_TETROMINO => 
                if state.current_y < 4 then 
                    state_nxt.fsm_state <= ADD_TETROMINO_ROW;
                else 
                    state_nxt.current_y <= 0;
                    state_nxt.fsm_state <= ATH_IDLE;
                end if;
            WHEN ADD_TETROMINO_ROW => 
                if state.current_x < 4 then 
                    state_nxt.fsm_state <= ADD_BLOCK;
                else
                    state_nxt.current_y <= state.current_y + 1;
                    state_nxt.current_x <= 0;
                    state_nxt.fsm_state <= ADD_TETROMINO;
                end if;
            WHEN ADD_BLOCK => 
                state_nxt.current_x <= state.current_x + 1;
                state_nxt.fsm_state <= ADD_TETROMINO;
                if is_tetromino_solid_at(tetromino, rotation, std_logic_vector(to_unsigned(state.current_x, 2)), std_logic_vector(to_unsigned(state.current_y, 2))) then
                    state_nxt.out_matrix(out_matrix'length - 1 - y - state.current_y)(out_matrix(0)'length - x - state.current_x - 1) <= get_T_BB_from_tetromino(tetromino);
                end if; 
        end case;
    end process;

end architecture;
