`include "ss.sv"
`include "ss_macros.sv"
`include "ss_reg_slice.sv"
`include "generic_macros.sv"
`timescale 1ns/1ps
//Basic register slice tb that does not completely follow AXI-S protocol
//This is because the valid is deasserted randomly
//Just used for visual inspection at this point 
module register_slice_tb;
  initial $display("Register Slice TB");
  localparam NUM_BYTES = 8;
  localparam USER_BITS = 2;
  ss#(.NUM_BYTES(NUM_BYTES), .USER_BITS(USER_BITS)) ss_inst();
  `SS_CLONE(ss_inst, ss_inst_clone)
  ss_reg_slice ss_reg_slice_inst(
    .in(ss_inst),
    .out(ss_inst_clone)
  );
  initial begin
    ss_inst.rst = 'h1;
    ss_inst.clk = 'h0;
    //Hold rst for a few cycles
    for(int i = 0; i < 5; i++) begin 
      ss_inst.clk = ~ss_inst.clk;
      #10;
    end
    ss_inst.rst = 'h0;//Lower reset
    for(int i = 0; i < 100; i++) begin
      //Send in the data...randomly
      ss_inst.clk = ~ss_inst.clk;
      if(ss_inst.clk)begin//Change data at positive edge of clock
        ss_inst_clone.ready = $urandom;//Randomly backpressure
        if(ss_inst_clone.ready || !ss_inst.valid) begin//Do not change values until slave accepts
          ss_inst.valid = $urandom;
          ss_inst.keep  = $urandom;
          ss_inst.last  = $urandom;
          ss_inst.user  = $urandom;
          ss_inst.data  = $urandom;
        end
      end
      #10;
    end
    $display("Ending simulation");
  end
endmodule