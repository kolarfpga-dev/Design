`include "ss.sv"
`include "ss_macros.sv"
`include "ss_reg_slice.sv"
`include "generic_macros.sv"
module register_slice_tb;
  initial $display("Hello world");
  localparam NUM_BYTES = 8;
  localparam USER_BITS = 2;
  ss#(.NUM_BYTES(NUM_BYTES), .USER_BITS(USER_BITS)) ss_inst();
  `SS_CLONE(ss_inst, ss_inst_clone)
  initial begin
    in.rst = 'h1;
    in.clk = 'h0;
    //Hold rst for a few cycles
    for(int i = 0; i < 5; i++) in.clk = ~in.clk;
    in.rst = 'h0;//Lower reset
    for(int i = 0; i < 100; i++) begin
      //Send in the data...randomly
      in.clk = ~in.clk;
      in.valid = $urandom_range(0,1);
      out.ready = $urandom_range(0,1);//Randomly backpressure
      in.keep = $urandom_range(0, (NUM_BYTES / 8) - 1);
      in.last = $urandom_range(0,1);
      in.user = $urandom;
      in.data = $urandom;
    end
    initial $display("Ending simulation");
endmodule