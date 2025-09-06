create_clock -period 10 -name sys_clk [get_ports clk]
#Gotta fix next constraint
#set_false_path [get_ports rst]
