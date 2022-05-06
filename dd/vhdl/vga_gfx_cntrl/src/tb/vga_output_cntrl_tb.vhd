entity tb_vga_output_cntrl is 
end entity;

architecture bhv of tb_vga_output_cntrl is 
    signal clk : std_logic := '0';
    signal res_n : std_logic := '0';
    signal prepare_frame_start, pix_ack : std_logic;
    signal pix_data_r, pix_data_g, pix_data_b: out std_logic_vector(7 downto 0);
    signal vga_hsync,vga_vsync,vga_dac_clk,vga_dac_blank_n,vga_dac_sync_n: std_logic;
    signal vga_dac_r,vga_dac_g,vga_dac_b:std_logic_vector(7 downto 0);

begin 
    tpg_inst: tpg 
        generic map (
            WIDTH => 640,
            HEIGHT => 480
        )
        port (
            clk => clk, 
            res_n => res_n,
            
            prepare_frame_start => PREPARE_FRAME_START,
            pix_ack => PIX_ACK,
            pix_data_r => pix_data_r,
            pix_data_g => pix_data_g,
            pix_data_b => pix_data_b
        );

    vga_output_ctrl_inst: vga_output_ctrl
        generic map (
            WIDTH => 640,
            HEIGHT => 480
        )
        port map (
            --outputs
            vga_hsync       => vga_hsync,  
			vga_vsync       => vga_vsync,  
			vga_dac_clk     => vga_dac_clk,  
			vga_dac_blank_n => vga_dac_blank_n,  
			vga_dac_sync_n  => vga_dac_sync_n,  
			vga_dac_r       => vga_dac_r,  
			vga_dac_g       => vga_dac_g,  
			vga_dac_b       => vga_dac_b,

            --internal interface
            prepare_frame_start => prepare_frame_start,
            pix_data_r => pix_data_r,
            pix_data_g => pix_data_g,
            pix_data_b => pix_data_b,
            prepare_frame_start => PREPARE_FRAME_START,
            pix_ack => pix_ack
        );
        
end architecture;