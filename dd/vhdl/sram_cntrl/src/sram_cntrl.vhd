
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.math_pkg.all;
use work.ram_pkg.all;


entity sram_cntrl is
	generic (
		ADDR_WIDTH : integer := 20;
		DATA_WIDTH : integer := 16;
		WR_BUF_SIZE : integer := 8
	);
	port (
		clk : in  std_logic;
		res_n : in std_logic;

		-- write interface
		wr_addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
		wr_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
		wr      : in std_logic;
		wr_full : out std_logic;
		wr_half_full : out std_logic;
	
		-- read interface
		rd_addr  : in std_logic_vector(ADDR_WIDTH-1 downto 0);
		rd       : in std_logic;
		rd_busy  : out std_logic;
		rd_data  : out std_logic_vector(DATA_WIDTH-1 downto 0);
		rd_valid : out std_logic;
		
		-- external interface to SRAM
		sram_dq : inout std_logic_vector(DATA_WIDTH-1 downto 0);
		sram_addr : out std_logic_vector(ADDR_WIDTH-1 downto 0);
		sram_ub_n : out std_logic;
		sram_lb_n : out std_logic;
		sram_we_n : out std_logic;
		sram_ce_n : out std_logic;
		sram_oe_n : out std_logic
	);
begin
	assert DATA_WIDTH = 16 severity failure;
end entity;


architecture arch of sram_cntrl is
	signal wr_fifo_rd_valid : std_logic;
	signal wr_fifo_rd_ack   : std_logic;
	signal wr_fifo_rd_data  : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal wr_fifo_rd_addr  : std_logic_vector(ADDR_WIDTH-1 downto 0);
	
	
	--next SRAM signals for the SRAM output registers 
	signal sram_addr_nxt : std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal sram_ub_n_nxt : std_logic;
	signal sram_lb_n_nxt : std_logic;
	signal sram_we_n_nxt : std_logic;
	signal sram_ce_n_nxt : std_logic;
	signal sram_oe_n_nxt : std_logic;
	signal sram_drive_data : std_logic;
	signal sram_drive_data_nxt : std_logic;
	signal sram_data_out : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal sram_data_out_nxt : std_logic_vector(DATA_WIDTH-1 downto 0);
	
	signal read_issued : std_logic;
	
	type sram_cntrl_state_t is (IDLE, WRITE1, WRITE2);
	signal state : sram_cntrl_state_t;
	signal state_nxt : sram_cntrl_state_t;
begin

	wr_fifo_block : block
		signal fifo_data_out : std_logic_vector(DATA_WIDTH + ADDR_WIDTH - 1 downto 0);
	begin
		wr_fifo : fifo_1c1r1w_fwft
		generic map (
			DEPTH      => WR_BUF_SIZE,
			DATA_WIDTH => fifo_data_out'length
		)
		port map (
			clk       => clk,
			res_n     => res_n,
			rd_data   => fifo_data_out,
			rd_ack    => wr_fifo_rd_ack,
			rd_valid  => wr_fifo_rd_valid,
			wr_data   => wr_data & wr_addr,
			wr        => wr,
			full      => wr_full,
			half_full => wr_half_full
		);
		wr_fifo_rd_addr <= fifo_data_out(ADDR_WIDTH-1 downto 0);
		wr_fifo_rd_data <= fifo_data_out(DATA_WIDTH+ADDR_WIDTH-1 downto ADDR_WIDTH);
	end block;

	sync : process(clk, res_n)
	begin
		if (res_n = '0') then
			sram_addr <= (others => '0');
			sram_ub_n <= '1';
			sram_lb_n <= '1';
			sram_we_n <= '1';
			sram_ce_n <= '1';
			sram_oe_n <= '1';
			sram_drive_data <= '0';
			sram_data_out <= (others => '0');
			state <= IDLE;
		elsif (rising_edge(clk)) then
			sram_addr <= sram_addr_nxt;
			sram_ub_n <= sram_ub_n_nxt;
			sram_lb_n <= sram_lb_n_nxt;
			sram_we_n <= sram_we_n_nxt;
			sram_ce_n <= sram_ce_n_nxt;
			--sram_ce_n <= '0';
			sram_oe_n <= sram_oe_n_nxt;
			sram_drive_data <= sram_drive_data_nxt;
			sram_data_out <= sram_data_out_nxt; 
			state <= state_nxt;
			
		end if;
	end process;
	
	sram_dq <= sram_data_out when sram_drive_data = '1' else (others=>'Z');
	
	next_state : process(all)
	begin
		state_nxt <= state;
		rd_busy <= '0';
		
		-- FIFO control signals
		wr_fifo_rd_ack <= '0';
		
		--SRAM signals
		sram_addr_nxt <= (others=>'0');
		sram_ub_n_nxt <= '1';
		sram_lb_n_nxt <= '1';
		sram_we_n_nxt <= '1';
		sram_ce_n_nxt <= '1';
		sram_oe_n_nxt <= '1';
		sram_drive_data_nxt <= '0';
		sram_data_out_nxt <= (others=>'0'); 
		
		case state is
			when IDLE =>
				if (rd = '1') then
					sram_addr_nxt <= rd_addr;
					sram_ce_n_nxt <= '0';
					sram_oe_n_nxt <= '0';
					sram_lb_n_nxt <= '0';
					sram_ub_n_nxt <= '0';
				elsif (wr_fifo_rd_valid = '1') then
					state_nxt <= WRITE1;
					sram_addr_nxt <= wr_fifo_rd_addr;
					sram_data_out_nxt <= wr_fifo_rd_data;
					sram_drive_data_nxt <= '1';
					sram_ce_n_nxt <= '0';
					sram_oe_n_nxt <= '0';
			end if;
			
			when WRITE1 =>
				state_nxt <= WRITE2;
				sram_addr_nxt <= wr_fifo_rd_addr;
				sram_data_out_nxt <= wr_fifo_rd_data;
				sram_drive_data_nxt <= '1';
				sram_ce_n_nxt <= '0';
				sram_oe_n_nxt <= '0';
				sram_we_n_nxt <= '0';
				sram_ub_n_nxt <= '0';
				sram_lb_n_nxt <= '0';
				rd_busy <= '1'; -- no reads during a write
		
			when WRITE2 =>
				state_nxt <= IDLE;
				sram_addr_nxt <= wr_fifo_rd_addr;
				sram_data_out_nxt <= wr_fifo_rd_data;
				sram_drive_data_nxt <= '1';
				sram_ce_n_nxt <= '0';
				sram_oe_n_nxt <= '0';
				wr_fifo_rd_ack <= '1';
				rd_busy <= '1'; -- no reads during a write
			
			when others =>
		end case;
	end process;
	
	rd_output_buffer : process(clk, res_n)
	begin
		if (res_n = '0') then
			rd_data <= (others=>'0');
			rd_valid <= '0';
			read_issued <= '0';
		elsif (rising_edge(clk)) then
			rd_valid <= '0';
			read_issued <= rd and not rd_busy;
			if (read_issued) then
				rd_data <= sram_dq;
				rd_valid <= '1';
			end if;
		end if;
	end process;
	
end architecture;

