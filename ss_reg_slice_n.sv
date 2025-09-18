//Generates n number of register slices
//Creates 0 or more register slices
//Does NOT perform any type of clock domain crossing
`include "ss_macros.sv"
module ss_reg_slice_n#(parameter NUM_REG_SLICES = 2)(
  interface in,
  interface out
);

    generate//If it is 0 register slices, we have a special condition
        if(NUM_REG_SLICES == 0) begin
            `SS_INTF_CONNECT(in, out)
        end
    endgenerate

    generate
        if(NUM_REG_SLICES > 0) begin
            genvar i;
            //Instantiate the appropriate number of interfaces
            `SS_CLONE(in, middle_interfaces[NUM_REG_SLICES:0])
            `SS_INTF_CONNECT(in, middle_interfaces[0])//Connect to the first "middle interface"
            for(i = 0; i < NUM_REG_SLICES; i++) begin
                ss_reg_slice ssrm_inst(middle_interfaces[i], middle_interfaces[i+1]);
            end
            `SS_INTF_CONNECT(middle_interfaces[NUM_REG_SLICES], out)
        end
    endgenerate
endmodule