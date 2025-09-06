//Converts a logic vector to a single output
//Useful for utilization testing
module x_in_to_single_out#(parameter NUM_INS)(
    input logic clk,
    input logic rst,
    input logic [NUM_INS -1 :0] in,
    output logic out
);
`reg_decl(cnt, ($clog2(NUM_INS)-1), 'h0, clk, rst)
always_comb begin 
    cnt_nxt = cnt_reg + 1;
end
always@(posedge clk) begin
    out <= in[cnt_reg];
end
endmodule