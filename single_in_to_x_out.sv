//A module that takes a single input and outputs x number of bits...switching between each bit on the output
//Useful for preliminary testing of utilization
`include "generic_macros.sv"
module single_in_to_x_out#(parameter NUM_OUTS)(
    input logic clk,
    output logic rst,
    input logic in,
    output logic [NUM_OUTS-1:0] out
);
`reg_decl(cnt, ($clog2(NUM_OUTS)-1), 'h0, clk, rst)
always_comb begin 
    cnt_nxt = cnt_reg + 1;
end
always@(posedge clk) begin
    out[cnt_reg] <= in;
end
endmodule