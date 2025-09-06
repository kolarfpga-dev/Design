//Simple register slice for the ss interface
//Single Sided
//Assumes both interfaces are operating on the same clock domain
`include "generic_macros.sv"
module ss_reg_slice(
  interface in,
  interface out
);
    `reg_decl(out_saved, 1, 'h0, in.clk, in.rst)
   always_comb begin
     out_saved_nxt = out.ready;
   end
  always @(posedge in.clk) begin
    if(out_saved_reg) begin
      out.valid<= in.valid;
      out.data <= in.data;
      out.keep <= in.keep;
      out.last <= in.last;
      out.user <= in.user;
    end
  end
endmodule
        
  