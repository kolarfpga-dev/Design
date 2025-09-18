start_gui
create_project project_1 {C:/Users/james/OneDrive/Documents/Work/Vivado Projects/Experimentation/Versal-Prime-9-16-2025/project_1} -part xcvm1102-sfva784-2MP-i-S
add_files -norecurse {C:/Users/james/OneDrive/Documents/Github/ss_reg_slice_n.sv C:/Users/james/OneDrive/Documents/Github/generic_macros.sv C:/Users/james/OneDrive/Documents/Github/basic_top.sv C:/Users/james/OneDrive/Documents/Github/ss_macros.sv C:/Users/james/OneDrive/Documents/Github/testbench.sv C:/Users/james/OneDrive/Documents/Github/x_in_to_single_out.sv C:/Users/james/OneDrive/Documents/Github/single_in_to_x_out.sv C:/Users/james/OneDrive/Documents/Github/ss.sv C:/Users/james/OneDrive/Documents/Github/sra.sv C:/Users/james/OneDrive/Documents/Github/ss_reg_slice.sv C:/Users/james/OneDrive/Documents/Github/sra_macros.sv}
update_compile_order -fileset sources_1
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse {C:/Users/james/OneDrive/Documents/Github/x_in_to_single_out_tb.sv C:/Users/james/OneDrive/Documents/Github/testbench.sv C:/Users/james/OneDrive/Documents/Github/single_in_to_x_out_tb.sv C:/Users/james/OneDrive/Documents/Github/sra_tb.sv C:/Users/james/OneDrive/Documents/Github/register_slice_tb.sv}
update_compile_order -fileset sim_1
set_property top basic_top [current_fileset]
