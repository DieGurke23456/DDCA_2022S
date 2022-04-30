library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.gc_cntrl_pkg.all;
use work.sync_pkg.all;

entity gc_cntrl is
    generic (
        SYNC_STAGES : natural;
        CLK_FREQ: natural;
        REFRESH_TIMEOUT: natural
    );
	port (
		clk   : in std_logic;
		res_n : in std_logic;
		
		data : inout std_logic;
		
		rumble : in std_logic := '0';
        
        cntrl_state : out gc_cntrl_state_t
	);
end entity;

architecture arch of gc_cntrl is
    type fsm_states is (
        WAIT_TIMEOUT, POLL, SEND_LOW, SEND_HIGH,
        WAIT_SAMPLE, WAIT_FALLING_EDGE_DATA,SAMPLE_DATA);
    
    signal state: fsm_states;
    signal state_next: fsm_states;

    signal next_cntrl_state: gc_cntrl_state_t;

    signal shiftreg_btns, shiftreg_btns_next : std_logic_vector(63 downto 0);
    signal poll_cmd, poll_cmd_next: std_logic_vector(24 downto 0);


    signal res_n_synced: std_logic;
    signal data_synced, data_synced_old: std_logic;

    signal clk_cnt, clk_cnt_next: natural;
    signal data_cnt, data_cnt_next: natural;
    
    constant ONE_US : natural :=  CLK_FREQ / (1E6);
    
    --register poll_cmd: std_logic_vector(24 downto 0);
begin
    reset_sync : sync
	generic map (
		SYNC_STAGES => SYNC_STAGES,
		RESET_VALUE => '0'
	)
	port map (
		clk => clk,
		res_n => '1',
		data_in => res_n,
		data_out => res_n_synced
	);

    data_sync : sync
	generic map (
		SYNC_STAGES => SYNC_STAGES,
		RESET_VALUE => '0'
	)
    port map (
		clk => clk,
		res_n => '1',
		data_in => data,
		data_out => data_synced
	);
    
    sync_process: process(clk, res_n)
    begin
        if(res_n = '0') then
            state <= WAIT_TIMEOUT;
            clk_cnt <= 0;
            data_cnt <= 0;
            poll_cmd <= X"40030" & "000" & rumble & "1";
        elsif(rising_edge(clk)) then
            clk_cnt <= clk_cnt_next;
            data_cnt <= data_cnt_next;
            state <= state_next;
            cntrl_state <= next_cntrl_state;
            poll_cmd <= poll_cmd_next; 
            data_synced_old <= data_synced;
            shiftreg_btns <= shiftreg_btns_next;
        end if;
    end process sync_process;
    -- reset_process: process(res_n);
        
    -- begin
    -- end process;

    next_state_logic: process (all)
    begin 
            state_next <= state;
            clk_cnt_next <= clk_cnt;
            data_cnt_next <= data_cnt;
            next_cntrl_state <= cntrl_state;
            poll_cmd_next <= poll_cmd; 
            shiftreg_btns_next <= shiftreg_btns;

            case state is 
                when WAIT_TIMEOUT =>
                    next_cntrl_state <= to_gc_cntrl_state(shiftreg_btns);
                    if(clk_cnt >= REFRESH_TIMEOUT) then
                        --report "ONE_US IN CYCLES " & integer'image(ONE_US); 
                        state_next <= POLL;
                        clk_cnt_next <= 0;
                        data_cnt_next <= 0;
                        poll_cmd_next <= X"40030" & "000" & rumble & "1"; --X"40030" & "000" & rumble & "1";
                    else
                        --state_next <= WAIT_TIMEOUT;
                        clk_cnt_next <= clk_cnt + 1;
                    end if;
                when POLL =>
                    if(data_cnt < 25) then
                        state_next <= SEND_LOW;
                    else
                        state_next <= WAIT_SAMPLE;
                        data_cnt_next <= 0;
                    end if;
                when SEND_LOW =>
                    if ((poll_cmd(24) = '0' and clk_cnt = ONE_US + ONE_US + ONE_US)) or 
                       ((poll_cmd(24) = '1' and clk_cnt = ONE_US)) then
                        state_next <= SEND_HIGH;
                        clk_cnt_next <= 0;
                    else
                        --state_next <= SEND_LOW;
                        clk_cnt_next <= clk_cnt + 1;
                    end if;
                
                when SEND_HIGH =>
                    if ((poll_cmd(24) = '0') and (clk_cnt = ONE_US)) or 
                       ((poll_cmd(24) = '1') and (clk_cnt = ONE_US + ONE_US + ONE_US)) then
                        state_next <= POLL;
                        poll_cmd_next <= poll_cmd(23 downto 0) & poll_cmd(24);
                        clk_cnt_next <= 0;
                        data_cnt_next <= data_cnt + 1;
                    else
                        --state_next <= SEND_HIGH;
                        clk_cnt_next <= clk_cnt + 1;
                    end if;
                when WAIT_SAMPLE =>
                    --report "ONE_US: " & natural'image(ONE_US);
                    if clk_cnt = ONE_US + ONE_US/2 then -- ONE_US * 1.5
                        state_next <= SAMPLE_DATA;
                        clk_cnt_next <= 0;
                    else
                        --state_next <= WAIT_SAMPLE;
                        clk_cnt_next <= clk_cnt + 1;
                    end if;
                when WAIT_FALLING_EDGE_DATA => 
                    if data_synced = '0' and (data_synced_old = '1' or data_synced_old ='Z') then
                        state_next <= WAIT_SAMPLE;
                    end if;
                when SAMPLE_DATA => 
                    shiftreg_btns_next <= shiftreg_btns(62 downto 0) & data_synced;
                    if data_cnt = 64 then
                        state_next <= WAIT_TIMEOUT;
                    else
                        state_next <= WAIT_FALLING_EDGE_DATA;
                        data_cnt_next <= data_cnt + 1;
                    end if;
            end case;
    end process next_state_logic;

    output_logic: process (state) 
    begin
        case state is
            when WAIT_TIMEOUT =>
                data <= 'Z';
            when POLL =>
                data <= 'Z';
            when SEND_LOW =>
                data <= '0';
            when SEND_HIGH =>
                data <= 'Z';
            when WAIT_SAMPLE =>
                data <= 'Z';
            when WAIT_FALLING_EDGE_DATA =>
                data <= 'Z';
            when SAMPLE_DATA =>
                data <= 'Z';
        end case;
    end process;

end architecture;
