library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use std.env.finish;
use work.tetris_game_logic_pkg.all;
use work.math_pkg.all;


entity tb_timer is 
end tb_timer;
architecture bhv of tb_timer is

    constant CYCLES: integer := 100;
    constant CLOCK_PERIOD: integer := 20; -- period in ns 
    signal res_n, t_start, t_finished: std_logic;
    signal clk: std_logic := '0';

begin 
    timer_inst : cycles_timer 
    generic map (
        CYCLES => CYCLES
    )
    port map (
        clk                => clk,
        res_n              => res_n,
        start              => t_start,
        finished           => t_finished
    );

    clk_toggle : process 
    begin
        wait for 10 ns;
        clk <= not clk;
    end process clk_toggle; 


    reset_single : process
    begin
        res_n <= '0'; 
        wait for 20 ns;
        res_n <= '1';
        wait;
    end process reset_single;

    timeout_detection : process
    begin 
        wait for 300000 us;
        report "test-timeout";
        report "test failed!";
        finish;
    end process timeout_detection;
    
    main : process 
    begin 
        report "waiting for reset";
        while not res_n = '1' loop -- wait for reset 
        end loop;  
        wait for 20 ns;
        assert t_finished = '0' report "test failed!";

        report "starting counter!";
        t_start <= '1';
        wait for 40 ns;
        t_start <= '0';
        assert t_finished = '0' report "test failed!";

        wait for 2020 ns;
        assert t_finished = '1' report "test failed!";

        report "restarting counter!";
        t_start <= '1';
        wait for 40 ns;
        t_start <= '0';
        wait for 20 ns;
        assert t_finished = '0' report "test failed!";
        wait for 2020 ns;

        assert t_finished = '1' report "test failed!";
        report "done";
        
        finish;
        wait;
    end process;
end architecture;