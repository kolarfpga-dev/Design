//Simple Register Access Interface
//Essentially just two ss(Simple Stream) interfaces
//Not recommended to reach into, use the functions
//Keep in mind that the streaming interface user bits have address bits added to them
//The user field of the streaming interfaces = {USER_BITS, ADDR_BITS};
//Does not use keep or last. All transactions are one word and keep is assumed to be all ones

`include "generic_macros.sv"
`define M_USER_FIELD SSM_USER_WIDTH-1:ADDR_WIDTH
`define S_USER_FIELD SSS_USER_WIDTH-1:ADDR_WIDTH
`define ADDR_FIELD ADDR_WIDTH:0
interface sra#(
    parameter DATA_WIDTH_BYTES = 4, //Data width (in bytes) for writes and reads
    parameter ADDR_WIDTH = 8,       //Address width for write and reads
    parameter M_USER_BITS = 2,      //User bits for M->S transactions
    parameter S_USER_BITS = 2       //User bits for S->M transactions
)
();
  localparam SSM_USER_WIDTH =   M_USER_BITS + ADDR_WIDTH;//Simple stream M->S user width
  localparam SSS_USER_WIDTH =   S_USER_BITS + ADDR_WIDTH;//Simple stream S-> user width
  
  ss#(.NUM_BYTES(DATA_WIDTH_BYTES), .USER_BITS(SSM_USER_WIDTH)) ssm();//Simple stream M->S interface
  ss#(.NUM_BYTES(DATA_WIDTH_BYTES), .USER_BITS(SSS_USER_WIDTH)) sss();//Simple stream S->M interface
  logic rst, clk;//Common clock and reset
  assign ssm.clk = clk;
  assign sss.clk = clk;
  assign ssm.rst = rst;
  assign sss.rst = rst;

  //Reset Functions
  function logic get_rst();
    return rst;
  endfunction
  function void set_rst(logic rst_nxt);
    rst = rst_nxt;
  endfunction
  
  //M-S Functions
  function logic get_master_valid();
    return ssm.get_valid();
  endfunction
  function void set_master_valid(logic valid_nxt);
    ssm.set_valid(valid_nxt);
  endfunction
  function logic get_master_ready();
    return ssm.get_ready();
  endfunction
  function void set_master_ready(logic ready_nxt);
    ssm.set_ready(ready_nxt);
  endfunction
  function logic[ssm.DATA_SIZE-1:0] get_master_data();
    return ssm.get_data();
  endfunction
  function void set_master_data(logic [ssm.DATA_SIZE-1:0] data_nxt);
    ssm.set_data(data_nxt);
  endfunction
  function logic[M_USER_BITS-1:0] get_master_user();
    return ssm.get_user()[`M_USER_FIELD];
  endfunction
  function void set_master_user(logic[SSM_USER_WIDTH - 1:0] user_nxt);
    ssm.set_user({user_nxt, ssm.get_user()[`M_USER_FIELD]});
  endfunction
  function logic[ADDR_WIDTH-1:0] get_master_addr();
    return ssm.get_user()[`ADDR_FIELD];
  endfunction
  function void set_master_addr(logic[ADDR_WIDTH - 1:0] addr_nxt);
    ssm.set_user({get_master_user(), addr_nxt});
  endfunction

  //S->M Functions
  function logic get_slave_valid();
    return sss.get_valid();
  endfunction
  function void set_slave_valid(logic valid_nxt);
    sss.set_valid(valid_nxt);
  endfunction
  function logic get_slave_ready();
    return sss.get_ready();
  endfunction
  function void set_slave_ready(logic ready_nxt);
    sss.set_ready(ready_nxt);
  endfunction
  function logic[sss.DATA_SIZE-1:0] get_slave_data();
    return sss.get_data();
  endfunction
  function void set_slave_data(logic [sss.DATA_SIZE-1:0] data_nxt);
    sss.set_data(data_nxt);
  endfunction
  function logic[M_USER_BITS-1:0] get_slave_user();
    return sss.get_user()[`M_USER_FIELD];
  endfunction
  function void set_slave_user(logic[SSS_USER_WIDTH - 1:0] user_nxt);
    sss.set_user({user_nxt, sss.get_user()[`M_USER_FIELD]});
  endfunction
  function logic[ADDR_WIDTH-1:0] get_slave_addr();
    return sss.get_user()[`ADDR_FIELD];
  endfunction
  function void set_slave_addr(logic[ADDR_WIDTH - 1:0] addr_nxt);
    sss.set_user({get_slave_user(), addr_nxt});
  endfunction
endinterface