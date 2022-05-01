library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.tetris_game_logic_pkg.all; 
use work.tetris_drawers_pkg.all;

entity cycles_timer is 
    generic (
        CYCLES: integer
    ); port (
        finished: out std_logic;
        clk: in std_logic;
        res_n: in std_logic;
        start: in std_logic
    );
end entity;

architecture arch of cycles_timer is
    type fsm_state_t is (T_IDLE, T_COUNTING);
    type state_t is record 
        fsm_state: fsm_state_t;
        finished: std_logic;
        count: integer range 0 to CYCLES;
    end record;
    signal state, state_nxt: state_t; 
begin
    finished <= state.finished; 

    sync : process(clk, res_n)
	begin
        if (res_n = '0') then 
            state <= (
                fsm_state => T_IDLE,
                finished => '0',
                count => 0
            );
		elsif (rising_edge(clk)) then
			state <= state_nxt;
		end if;
	end process;

    next_state : process(all)
    begin 
        state_nxt <= state;
        case state.fsm_state is 
            WHEN T_IDLE => 
                if (start = '1') then
                    state_nxt.fsm_state <= T_COUNTING;
                    state_nxt.count <= 0;
                    state_nxt.finished <= '0';
                end if;
            WHEN T_COUNTING =>
                if state.count < CYCLES then 
                    state_nxt.count <= state.count + 1;
                    state_nxt.fsm_state <= T_COUNTING;
                else 
                    state_nxt.fsm_state <= T_IDLE;
                    state_nxt.finished <= '1';
                    state_nxt.count <= 0;
                end if; 
        end case;
    end process;
end architecture;
