derive_pll_clocks -create_base_clocks
derive_clock_uncertainty
set_false_path -from [get_clocks {clk}] -to [get_clocks {c0|altpll_component|auto_generated|pll1|clk[0]}];