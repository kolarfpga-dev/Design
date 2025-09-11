`include "ss.sv"
`include "ss_macros.sv"
`include "sra.sv"
`include "generic_macros.sv"
module sra_tb;
  initial $display("Hello world");
  sra#(
    .DATA_WIDTH_BYTES(4), 
    .ADDR_WIDTH(8), 
    .M_USER_BITS(2), 
    .S_USER_BITS(2)) 
  ss_inst();
endmodule