library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use work.gc_cntrl_pkg.all;
use work.sync_pkg.all;
use std.env.finish;
entity tb_gc_cntrl is
end tb_gc_cntrl;

architecture bhv of tb_gc_cntrl is
	signal RES_N_SIGNAL, DATA_SIGNAL, RUMBLE_SIGNAL: std_logic;
	signal CLK_SIGNAL: std_logic := '0';
	signal CNTRL_STATE_SIGNAL : gc_cntrl_state_t;

	type fsm_states is (
        DATA, SEND_LOW, SEND_HIGH,
        WAIT_POLL, WAIT_FALLING_EDGE_POLL, SAMPLE_POLL, WAIT_TIMEOUT, CHECK_CNTRL_STATE, CHECK_POLL);
    
    signal state: fsm_states:=WAIT_FALLING_EDGE_POLL;
    signal state_next: fsm_states;

	signal clk_cnt: natural := 0;
	signal clk_cnt_next: natural := 0;
	
	signal data_cnt: natural := 0;
	signal data_cnt_next: natural := 0;
	
	signal out_vector: std_logic_vector(63 downto 0);
	signal out_vector_next: std_logic_vector(63 downto 0);
	
	constant poll_cmd_ref: std_logic_vector(24 downto 0) := X"40030" & "000" & "1" & "1"; -- rumble set to 1
	signal poll_cmd_shift_reg: std_logic_vector(24 downto 0) := (Others => '0');
	signal data_synced : std_logic;
	signal data_synced_old: std_logic;
	constant CLK_FREQ: natural := 50000000;
	constant ONE_US : natural :=  CLK_FREQ / (1E6);
	constant REFRESH_TIMEOUT : natural := 100;

	type t_test_vectors is array (0 to 7) of std_logic_vector(63 downto 0);
	signal test_vectors : t_test_vectors;
	signal test_vector_index : natural := 0;
	signal test_vector_index_next : natural := 0;

	component gc_cntrl is
	generic (
		SYNC_STAGES : natural;
        CLK_FREQ: natural;
        REFRESH_TIMEOUT: natural
	);
	port (
		clk   : in std_logic;
		res_n : in std_logic;
		data : inout std_logic;
		rumble : in std_logic;
        cntrl_state : out gc_cntrl_state_t
	);
	end component;

begin
	I_GC_CNTRL : gc_cntrl 
	generic map (
		SYNC_STAGES => 2,
		CLK_FREQ => CLK_FREQ,
		REFRESH_TIMEOUT => 200)
	port map (
		clk => CLK_SIGNAL,
	 	res_n => RES_N_SIGNAL,
		data => DATA_SIGNAL,
		rumble => RUMBLE_SIGNAL,
		cntrl_state => CNTRL_STATE_SIGNAL
	);
	
	clk_toggle : process 
	begin
		wait for 10 ns;
		CLK_SIGNAL <= not CLK_SIGNAL;
	end process clk_toggle; 

	data_checking : process
	begin
		DATA_SIGNAL <= 'Z';
		RUMBLE_SIGNAL <= '1';
		wait;
	end process;
	
	data_sync : sync
	generic map (
		SYNC_STAGES => 2,
		RESET_VALUE => '0'
	)
    port map (
		clk => CLK_SIGNAL,
		res_n => '1',
		data_in => DATA_SIGNAL,
		data_out => data_synced
	);

	generate_test_vectors : process
	variable seed1, seed2 : integer := 12019840; --use your matriculation number
		impure function rand_slv(slv_len : integer) return std_logic_vector is
			variable r : real;
			variable slv : std_logic_vector(slv_len - 1 downto 0);
		begin
			for i in 0 to slv_len-1 loop
				uniform(seed1, seed2, r);
				slv(i) := '1';
				if r > 0.5 then slv(i) := '0'; end if;
			end loop;
			return slv;
		end function;
	begin
		for i in 0 to 7 loop
			test_vectors(i) <= rand_slv(64); 	--generate next test_vector
		end loop;
		report "generated test-vectors";
		
		wait;
	end process generate_test_vectors;
		
	sync_process: process(CLK_SIGNAL)
	begin
		if(rising_edge(CLK_SIGNAL)) then
			clk_cnt <= clk_cnt_next;
			data_cnt <= data_cnt_next;
			state <= state_next;
			out_vector <= test_vectors(0);
			out_vector <= out_vector_next;
			data_synced_old <= data_synced;	
			test_vector_index <= test_vector_index_next; 
		end if;
	end process;

	output_logic: process(state)
	variable to_store: std_logic;
	begin
		case state is 
			when DATA =>
				DATA_SIGNAL <= '0';
			when SEND_LOW =>
				DATA_SIGNAL <= '0';
			when SEND_HIGH =>
				DATA_SIGNAL <= '1';
			when WAIT_POLL =>
				DATA_SIGNAL <= 'Z';
			when WAIT_FALLING_EDGE_POLL =>
				DATA_SIGNAL <= 'Z';
			when SAMPLE_POLL =>
				DATA_SIGNAL <= 'Z';
				if data_synced = 'Z' then --pull-up is not simulated
					to_store := '1';
				else
					to_store := data_synced;
				end if;
				poll_cmd_shift_reg <= poll_cmd_shift_reg(23 downto 0) & to_store;
				--report "to_store: " & to_string(to_store);
			when WAIT_TIMEOUT =>
				DATA_SIGNAL <= 'Z';
			when CHECK_CNTRL_STATE =>
				DATA_SIGNAL <= 'Z';
			when CHECK_POLL =>
				DATA_SIGNAL <= 'Z';
		end case;
	end process;
	
	next_state_logic: process(all)
	begin
		state_next <= state;
		clk_cnt_next <= clk_cnt;
		case state is
			when DATA =>
				if(data_cnt = 0) then 
					if(test_vector_index > 7) then
						report "test finished";
						finish;	
					end if;
					report "sending " & to_hstring(out_vector);
				end if;
				if(data_cnt < 64) then
					state_next <= SEND_LOW;
				else  
					state_next <= CHECK_CNTRL_STATE;
					data_cnt_next <= 0;
					clk_cnt_next <= 0;
				end if;
			when CHECK_CNTRL_STATE =>
				state_next <= WAIT_FALLING_EDGE_POLL;
				report "test vector sent: " & to_hstring(to_slv(to_gc_cntrl_state(out_vector)));
				report "test vector received: " & to_hstring(to_slv(CNTRL_STATE_SIGNAL));
				assert to_hstring(to_slv(to_gc_cntrl_state(out_vector))) = to_hstring(to_slv(CNTRL_STATE_SIGNAL)) report "gc_control state doesn't match: " severity error;
			when SEND_LOW =>
				if (out_vector(63) = '0' and clk_cnt = 3 * ONE_US) or
				   (out_vector(63) = '1' and clk_cnt = ONE_US) then
					state_next <= SEND_HIGH;
					clk_cnt_next <= 0;
				else 
					clk_cnt_next <= clk_cnt + 1;
				end if;
			when SEND_HIGH =>
				if(out_vector(63) = '0' and clk_cnt = ONE_US) or
				  (out_vector(63) = '1' and clk_cnt = 3 * ONE_US) then
					state_next <= DATA;
					out_vector_next <= out_vector(62 downto 0) & out_vector(63);
					clk_cnt_next <= 0; 
					data_cnt_next <= data_cnt + 1;
				else
					clk_cnt_next <= clk_cnt + 1;
				end if;
			when WAIT_POLL =>
				if(clk_cnt = ONE_US + ONE_US/2) then
					state_next <= SAMPLE_POLL;
					clk_cnt_next <= 0;	
				else
					clk_cnt_next <= clk_cnt + 1;
				end if;
			when WAIT_FALLING_EDGE_POLL =>
				if(data_synced = '0' and data_synced_old = 'Z') then 
					state_next <= WAIT_POLL;
				end if;
			when SAMPLE_POLL =>
				if(data_cnt >= 24) then 
					state_next <= CHECK_POLL;
				else 
					data_cnt_next <= data_cnt + 1;
					state_next <= WAIT_FALLING_EDGE_POLL;
				end if;
			when CHECK_POLL =>
				report "poll-cmd: " & to_string(poll_cmd_shift_reg);
				assert poll_cmd_shift_reg = poll_cmd_ref report "received incorrect poll-cmd: " & to_string(poll_cmd_shift_reg) severity failure;
				state_next <= WAIT_TIMEOUT;
			when WAIT_TIMEOUT =>
				if(clk_cnt >= ONE_US * 4 + ONE_US / 2) then
					clk_cnt_next <= 0;
					data_cnt_next <= 0;
					state_next <= DATA;
					test_vector_index_next <= test_vector_index + 1;
					out_vector_next <= test_vectors(test_vector_index);
				else
					clk_cnt_next <= clk_cnt + 1; 
				end if;
		end case;

	end process;
end bhv; 