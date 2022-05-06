entity tb_vga_gfx_cntrl is 
end entity;

architecture bhv of tb_vga_gfx_cntrl is 
    signal clk: std_logic := 0;
    signal res_n: std_logic := 0;

    signal gfx_initializer_start : std_logic;
	signal gfx_initializer_busy : std_logic;
	signal gfx_initializer_instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
	signal gfx_initializer_instr_wr : std_logic;

    type vga_gfx_cnrl_output_t is record 
        gfx_instr_full: std_logic;
        gfx_frame_sync  : std_logic;
        sram_dq : std_logic_vector(15 downto 0);
        sram_addr : std_logic_vector(19 downto 0);
        sram_ub_n : std_logic;
        sram_lb_n : std_logic;
        sram_we_n : std_logic;
        sram_ce_n : std_logic;
        sram_oe_n : std_logic;
        vga_hsync       : std_logic;
        vga_vsync       : std_logic;
        vga_dac_clk     : std_logic;
        vga_dac_blank_n : std_logic;
        vga_dac_sync_n  : std_logic;
        vga_dac_r       : std_logic_vector(7 downto 0);
        vga_dac_g       : std_logic_vector(7 downto 0);
        vga_dac_b       : std_logic_vector(7 downto 0);
    end record;
    type fsm_state_t is (
    );
    type state_t is  record
        fsm_state: fsm_state_t;
    end record;
    signal state, state_nxt:fsm_state;
    signal precomp_vga_gfx_cntrl_output, my_vga_gfx_cntrl_output:  vga_gfx_cnrl_output_t;
begin 
    precompiled_vga_gfx_cntrl_inst: precompiled_vga_gfx_cntrl        
    port (
        clk   => clk,
        res_n => res_n,
        
        display_clk   => DISPLAY_CLK,
        display_res_n => DISPLAY_RES_N,
    
        --instruction interface
        gfx_instr       => GFX_INSTR,
        gfx_instr_wr    => GFX_INSTR_WR, 
        gfx_instr_full  => precomp_vga_gfx_cntrl_output.gfx_instr_full,
        gfx_frame_sync  => precomp_vga_gfx_cntrl_output.gfx_frame_sync,
        
        --external interface to SRAM
        sram_dq => precomp_vga_gfx_cntrl_output.sram_dq,
        sram_addr => precomp_vga_gfx_cntrl_output.sram_addr,
        sram_ub_n => precomp_vga_gfx_cntrl_output.sram_ub_n,
        sram_lb_n => precomp_vga_gfx_cntrl_output.sram_lb_n,
        sram_we_n => precomp_vga_gfx_cntrl_output.sram_we_n,
        sram_ce_n => precomp_vga_gfx_cntrl_output.sram_ce_n,
        sram_oe_n => precomp_vga_gfx_cntrl_output.sram_oe_n,
        
        -- connection to VGA connector/DAC
        vga_hsync       => precomp_vga_gfx_cntrl_output.vga_hsync, 
        vga_vsync       => precomp_vga_gfx_cntrl_output.vga_vsync, 
        vga_dac_clk     => precomp_vga_gfx_cntrl_output.vga_dac_clk, 
        vga_dac_blank_n => precomp_vga_gfx_cntrl_output.vga_dac_blank_n, 
        vga_dac_sync_n  => precomp_vga_gfx_cntrl_output.vga_dac_sync_n, 
        vga_dac_r       => precomp_vga_gfx_cntrl_output.vga_dac_r, 
        vga_dac_g       => precomp_vga_gfx_cntrl_output.vga_dac_g, 
        vga_dac_b       => precomp_vga_gfx_cntrl_output.vga_dac_b 
    );

    clk_toggle: process 
    begin 
        clk <= not clk after 10 ns;
    end process;

    single_reset: processs 
    begin 
        wait for 20 ns;
        res_n <= not res_n;
        wait;
    end process;

    next_state: process
        procedure write_instr(instr : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0); next_state : fsm_state_t) is
            begin
                if (gfx_instr_full = '0') then
                    GFX_INSTR_WR <= '1';
                    GFX_INSTR <= instr;
                    state_nxt.fsm_state <= next_state;
                end if;
            end procedure;
    begin 
        state_nxt <= state;

        GFX_INSTR_WR <= '0';
		GFX_INSTR <= (others=>'0');

        case state.fsm_state is 
            when RESET =>
                state_nxt.fsm_state <= WAIT_INIT;
                gfx_initializer_start <= '1';
                gfx_instr <= gfx_initializer_instr;
                gfx_instr_wr <= gfx_initializer_instr_wr;
            when WAIT_INIT => 
                GFX_INSTR <= gfx_initializer_instr;
                GFX_INSTR_WR <= gfx_initializer_instr_wr;
                if (gfx_initializer_busy = '0') then
                    state_nxt.fsm_state <= CLEAR_BLOCK_MAP_INIT;
                end if;
            
        end case;
    end process;

    gfx_initializer : block 
        constant INIT_INSTR : gfx_instr_array_t(0 to 17+17+3-1) := (
            gfx_instr_load_palette(0),
            x"5bcd", x"642e", x"746f", x"7cd1",
            x"8d32", x"9593", x"a5f4", x"b696",
            x"c6d7", x"c6f7", x"cf17", x"cf38",
            x"d738", x"d779", x"df99", x"ffff",
            gfx_instr_load_palette(1),
            x"0000", x"8000", x"0400", x"8400", 
            x"0010", x"8010", x"0410", x"bdf7",
            x"8410", x"f800", x"07e0", x"ffe0",
            x"001f", x"f81f", x"07ff", x"ffff",
            gfx_instr_cfg(en_db=>true, en_tpg=>false),
            gfx_instr_clear(color=>x"e"),
            gfx_instr_select_palette(alpha_color=>x"f", palette_index=>0)
        );
    
        signal instr_cnt : integer := 0;
        signal instr_cnt_nxt : integer := 0;

        signal gfx_initializer_instr_nxt : std_logic_vector(GFX_INSTR_WIDTH-1 downto 0);
        signal instr_busy, instr_busy_nxt : std_logic;
        signal running, running_nxt : std_logic;
    begin
        gfx_initializer_busy <= running;

        sync : process(clk, res_n)
        begin
            if (res_n = '0') then
                instr_cnt <= 0;
                gfx_initializer_instr <= (others=>'0');
                running <= '0';
            elsif (rising_edge(clk)) then
                gfx_initializer_instr <= gfx_initializer_instr_nxt;
                instr_cnt <= instr_cnt_nxt;
                running <= running_nxt;
            end if;
        end process;
        
        next_state : process(all)
        begin
            gfx_initializer_instr_wr <= '0';
            
            instr_cnt_nxt <= instr_cnt;
            gfx_initializer_instr_nxt <= gfx_initializer_instr;
            running_nxt <= running;
            
            if (gfx_initializer_start = '1') then
                instr_cnt_nxt <= 1;
                running_nxt <= '1';
                gfx_initializer_instr_nxt <= INIT_INSTR(0);
            end if;

            if (running = '1') then
                if (gfx_instr_full = '0') then
                    gfx_initializer_instr_wr <= '1';
                    
                    if (instr_cnt = 0) then
                        running_nxt <= '0';
                    elsif (instr_cnt = INIT_INSTR'length-1) then
                        instr_cnt_nxt <= 0;
                        gfx_initializer_instr_nxt <= INIT_INSTR(instr_cnt);
                    else
                        gfx_initializer_instr_nxt <= INIT_INSTR(instr_cnt);
                        instr_cnt_nxt <= instr_cnt + 1;
                    end if;
                end if;
            end if;
        end process;
    end block;

end architecture;