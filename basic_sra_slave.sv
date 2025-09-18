//Basic slave for the SRA protocol
//Has a master interface for read/writes transactions coming to the slave
//Has a slave interface for the response
//M->S user bit has a width of one and 1'h0-> write, 1'h1 -> read
//S-M  user bit has a width of one and 1'b0->success, 1'h1 ->failed
`include "generic_macros.sv"
module basic_sra_slave(
    interface sra_intf,
);

  typedef logic[0:0]{
    WRITE = 1'h0,
    READ  = 1'h1
  } TRANS_T;
  typedef logic[0:0]{
    SUCCESS = 1'h0,
    FAIL  = 1'h1
  } RESPONSE_T;
  //Slave logic
  always_comb begin
    if(sra_intf.get_rst()) begin//Reset values
        sra_intf.set_slave_ready(1'h1);//We will be ready to accept since we are resetting
        sra_intf.set_slave_valid(1'h0);//We have nothing to give since we are in reset
    end else begin
        
    end
  end
endmodule

