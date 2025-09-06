create_clock -period 10 -name sys_clk [get_ports clk]
set_false_path -to [get_pins {*rst*}]
