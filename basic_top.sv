//Basic top module that can be used to get utilization estimates
//Instantiate modules inside of this 
`include "ss_macros.sv"
module basic_top(
    input logic clk,
    input logic rst,
    input logic in,
    output logic out
);
//Datawidth of register utilization top
parameter NUM_BYTES = 8;
parameter DW = NUM_BYTES * 8;
// keep width + data width + valid + last + user
parameter KEEP_WIDTH = $clog2(DW);
parameter LVW = KEEP_WIDTH + DW + 3;
logic[LVW-1:0] s;
single_in_to_x_out#(.NUM_OUTS(LVW)) s_in_t_x(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(s)
);
ss#(.NUM_BYTES(NUM_BYTES), .USER_BITS(1)) ss_inst();
`SS_CLONE(ss_inst, ss_inst_2)
assign ss_inst.clk  = clk;
assign ss_inst.rst  = rst;
assign ss_inst.data = s[DW-1:0];
assign ss_inst.keep = s[DW+KEEP_WIDTH - 1:DW];
assign ss_inst.valid =s[DW+KEEP_WIDTH];
assign ss_inst.last = s[DW+KEEP_WIDTH + 1];
assign ss_inst.user = s[DW+KEEP_WIDTH + 2];

ss_reg_slice ssrs_inst(
    .in(ss_inst),
    .out(ss_inst_2)
);
logic [LVW-1:0] s2;
logic out_no_buf;
assign s2[DW-1:0]  = ss_inst_2.data; 
assign s2[DW+KEEP_WIDTH - 1:DW] = ss_inst_2.keep; 
assign s2[DW+KEEP_WIDTH]    = ss_inst_2.valid; 
assign s2[DW+KEEP_WIDTH + 1]    = ss_inst_2.last; 
assign s2[DW+KEEP_WIDTH + 2]    = ss_inst_2.user; 
assign ss_inst_2.ready = 'h1;
x_in_to_single_out#(.NUM_INS(LVW)) s_out_inst(
    .clk(clk),
    .rst(rst),
    .in(s2),
    .out(out_no_buf)
);
always @ (posedge clk) begin
    out <= out_no_buf;
end
endmodule