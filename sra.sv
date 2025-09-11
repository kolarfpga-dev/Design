//Simple Register Access Interface
//Essentially just two ss(Simple Stream) interfaces
//Not recommended to reach into 
`include "generic_macros.sv"

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

endinterface