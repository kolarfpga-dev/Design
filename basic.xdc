create_clock -period 10 -name clk [get_ports clk_in]
set_false_path -to [get_pins {rst}]
