library ieee;
use ieee.std_logic_1164.all;
use work.tetris_audio_pkg.all;
entity duration_counter is
    generic(
        SIXTEENTH_CYCLE_TIME: integer
    );
    port(
        clk: in std_logic;
        res_n: in std_logic;
        start: in std_logic;
        duration: in duration_t;
        finished: in std_logic
    );
end entity;
architecture arch of duration_counter is 
begin 

end architecture;