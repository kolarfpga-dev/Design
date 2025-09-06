`include "generic_macros.sv"
`timescale 1ns/1ps
//Basic testbench for visual inspection of x_in_to_single_out.sv
//Seems to be working 
module x_in_to_single_out_tb();
  initial $display("x_in_to_single_out TB");
  localparam NUM_OUTS = 8;
  logic clk;
  logic rst;
  logic in[NUM_OUTS -1:0];
  logic out;
  x_in_to_single_out#(.NUM_OUTS(NUM_OUTS)) sitxo_inst(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
  );
  initial begin
    rst = 'h1;
    clk = 'h0;
    //Hold rst for a few cycles
    for(int i = 0; i < 5; i++) begin 
      clk = ~clk;
      #10;
    end
    rst = 'h0;//Lower reset
    for(int i = 0; i < 100; i++) begin
      //Send in the data...randomly
      clk = ~clk;
      in = $urandom;
      #10;
    end
    $display("Ending simulation");
  end
endmodule