//ss is intended to be a simple streaming protocol that can be easily used for packet processing applications
//There is always a master and a slave. A master sends data and a slave recieves it
//Data is organized into packets. A packet is one or more bytes
//User information is not associated per byte and is application specific
//Once a master attempts to send data, it must keep attempting until the slave accepts it
//All bytes are considered valid until the end of the packet
//The last word of a packet may have null bytes or bytes that are not part of the packet. This is indicated by keep
//A data transfer is considered successful if valid and ready are high on the same cycle
//The slave may wait to assert ready until master asserts valid
//The master may NOT wait to assert valid until a slave asserts ready
//The interface is synchronous and operates on a per cycle basis
//Signals
//clk - the clock used for the synchronous data transfers
//rst - the synchronous rst
//valid - indicates master is attempting to send data
//ready - indicates the slave is willing to accept data this cycle
//data  - the actual data of the transfer. Must be a multiple of bytes. (BIG ENDIAN)
//keep  - indicates the number of bytes valid in the last word of a packet. (BIG ENDIAN)
//last  - indicates the last word of a packet
//user  - sideband data associated with the packet. Application specific
interface ss #(
  parameter NUM_BYTES = 1,
  parameter USER_BITS = 1
);
  //Local parameters
  localparam DATA_SIZE = (NUM_BYTES * 8);
  localparam KEEP_SIZE = NUM_BYTES;

  logic clk;
  logic rst;
  logic valid;
  logic ready;
  logic [DATA_SIZE - 1:0] data;
  logic [KEEP_SIZE - 1:0] keep;
  logic last;
  logic [USER_BITS - 1:0] user;

  //Interface related functions
  function logic get_valid();
    return valid;
  endfunction
  function void set_valid(logic valid_nxt);
    valid = valid_nxt;
  endfunction
  function logic get_ready();
    return ready;
  endfunction
  function void set_ready(logic ready_nxt);
    ready = ready_nxt;
  endfunction
  function logic[DATA_SIZE-1:0] get_data();
    return data;
  endfunction
  function void set_data(logic [DATA_SIZE-1:0] data_nxt);
    data = data_nxt;
  endfunction
  function logic[KEEP_SIZE-1:0] get_keep();
    return keep;
  endfunction
  function void set_keep(logic [KEEP_SIZE - 1:0] keep_nxt);
    keep = keep_nxt;
  endfunction
  function logic get_last();
    return last;
  endfunction
  function logic set_last(logic last_nxt);
    last = last_nxt;
  endfunction
  function logic[USER_BITS-1:0] get_user();
    return user;
  endfunction
  function void set_user(logic [USER_BITS-1:0] user_nxt);
    user = user_nxt;
  endfunction
endinterface