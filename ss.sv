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
  logic clk;
  logic rst;
  logic valid;
  logic ready;
  logic [(NUM_BYTES * 8) - 1:0] data;
  logic [NUM_BYTES - 1:0] keep;
  logic last;
  logic [USER_BITS - 1:0] user;
endinterface