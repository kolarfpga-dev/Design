//Various Design Macros related to the simple stream protocol

//SS-Clone Creates an ss_inst with the same parameters as an existing one
`define SS_CLONE(original_inst_name, cloned_inst_name) \
ss#(.NUM_BYTES(original_inst_name.NUM_BYTES), .USER_BITS(original_inst_name.USER_BITS)) cloned_inst_name();

//Connects an ss-interface to an existing interface
`define SS_INTF_CONNECT(master_interface, slave_interface) \
  assign slave_interface.clk=master_interface.clk; \
  assign slave_interface.rst=master_interface.rst;\
  assign slave_interface.valid=master_interface.valid;\
  assign master_interface.ready=slave_interface.ready;\
  assign slave_interface.data=master_interface.data;\
  assign slave_interface.keep=master_interface.keep;\
  assign slave_interface.last=master_interface.last;\
  assign slave_interface.user=master_interface.user;

//Clone and Connect
`define SS_INTF_CC(mast_intf_name, slave_intf_name)\
`SS_CLONE(mast_intf_name, slave_intf_name)\
`SS_INTF_CONNECT(mast_intf_name, slave_intf_name)