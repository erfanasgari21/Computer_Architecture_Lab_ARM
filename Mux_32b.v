module Mux_32b(
    input branchTaken, 
    input[31:0] branchAddress, pcIn
    output[31:0] pcOut
    );

    assign pcOut = branchTaken ? pcIn : branchAddress;
    
endmodule