library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;

use work.tetris_util_pkg.all;
use work.tetris_drawers_pkg.all;
use work.tetris_game_logic_pkg.all;
use work.vga_gfx_cntrl_pkg.all;

entity tb_add_tetromino_handler is
end tb_add_tetromino_handler;
architecture bhv of tb_add_tetromino_handler is
    constant ROWS : integer := 20;
    constant COLUMNS : integer := 10;
    signal RES_SIGNAL, START_SIGNAL, BUSY_SIGNAL : std_logic;
    signal CLK_SIGNAL : std_logic := '0';
    signal IN_MATRIX, OUT_MATRIX : t_bb_block_matrix(ROWS - 1 downto 0); 
    signal IN_TETROMINO : tetromino_t;
    signal IN_ROTATION : rotation_t;
    signal IN_X, IN_Y : integer;

    --constant EMPTY_ROW : t_bb_block_row (0 to COLUMNS - 1) := (others => T_BB_EMPTY);
    constant EMPTY_MATRIX : t_bb_block_matrix (0 to ROWS - 1) := (others => EMPTY_ROW);  
    
    type fsm_state_t is (
        WAIT_RESET,
        START_ADD_TETROMINO_HANDLER, WAIT_TETROMINO_HANDLER, CHECK_RESULT
    );
    type state_t is record 
        fsm_state : fsm_state_t;
        stored_matrix : t_bb_block_matrix(ROWS - 1 downto 0);
    end record;

    signal state : state_t := (fsm_state => WAIT_RESET, stored_matrix => EMPTY_MATRIX);
    signal state_nxt : state_t;

begin 

    I_ADD_TETROMINO_HANDLER : add_tetromino_handler
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
        tetromino => IN_TETROMINO,
        x => IN_X,
        y => IN_Y,
        rotation => IN_ROTATION
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
                    state_nxt.fsm_state <= START_ADD_TETROMINO_HANDLER;
                else                     
                    state_nxt.fsm_state <= WAIT_RESET;
                end if;
            WHEN START_ADD_TETROMINO_HANDLER => 
                report "starting test!";
                START_SIGNAL <= '1';
                state_nxt.fsm_state <= WAIT_TETROMINO_HANDLER;
            WHEN WAIT_TETROMINO_HANDLER =>
                IN_MATRIX <= EMPTY_MATRIX;
                IN_TETROMINO <= TET_T;
                IN_ROTATION <= ROT_0;
                IN_X <= 0;
                IN_Y <= 0;
                if (BUSY_SIGNAL = '0') then
					state_nxt.fsm_state <= CHECK_RESULT;
                    state_nxt.stored_matrix <= OUT_MATRIX;
				end if;
            WHEN CHECK_RESULT => 
                if equals(add_tetromino_to_matrix(EMPTY_MATRIX,TET_T, ROT_0, 0, 0),state.stored_matrix) then
                    report "test delete rows successfull!";
                    finish;
                else 
                    report "test delete rows failed!";
                    print(state.stored_matrix);
                    echo(""&LF);
                    print(add_tetromino_to_matrix(EMPTY_MATRIX,TET_T, ROT_0, 0, 0));
                    finish;
                end if;
        end case;
    end process; 


end architecture;