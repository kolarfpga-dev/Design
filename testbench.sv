`include "ss.sv"
`include "ss_macros.sv"
`include "ss_reg_slice.sv"
`include "generic_macros.sv"
module hello_world;
  initial $display("Hello world");
  ss#(.NUM_BYTES(2), .USER_BITS(2)) ss_inst();
  `SS_CLONE(ss_inst, ss_inst_clone)
  //`SS_INTF_CONNECT(ss_inst, ss_inst_clone)
  //`SS_INTF_CC(ss_inst, ss_inst_2)
  ss_reg_slice ss_rs_inst(ss_inst, ss_inst_clone);
endmodule