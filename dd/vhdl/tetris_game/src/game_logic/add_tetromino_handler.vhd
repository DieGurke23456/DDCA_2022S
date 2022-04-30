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

    type fsm_state_t is (ATH_IDLE, ADD_TETROMINO, ADD_BLOCK);
    type state_t is record 
        fsm_state: fsm_state_t;
        current_index : integer range 0 to tetromino_blocks_t'length - 1; -- iterate through blocks 
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
                    current_index => 0,
                    out_matrix => EMPTY_MATRIX
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
                    state_nxt.current_index <= 0;
                end if;
            WHEN ADD_TETROMINO => 
                state_nxt.out_matrix <= in_matrix;
                blocks_solid := get_blocks(tetromino, rotation);
                if state.current_index < tetromino_blocks_t'length then
                    state_nxt.fsm_state <= ADD_BLOCK;
                else 
                    state_nxt.current_index <= 0;
                    state_nxt.fsm_state <= ATH_IDLE;
                end if;
            WHEN ADD_BLOCK => 
                if blocks_solid(state.current_index) = '1' then
                    out_matrix(3 - state.current_index / (2*2) + y)(3 - state.current_index mod (2*2) + x) <= get_T_BB_from_tetromino(tetromino);
                end if;
                state_nxt.current_index <= state.current_index + 1;
                state_nxt.fsm_state <= ADD_TETROMINO;
        end case;
    end process;

end architecture;
