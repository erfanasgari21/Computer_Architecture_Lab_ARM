module PC_Adder(
    input[31:0] pcIn,
    output[31:0] pcOut;
    );

    assign pcOut = pcIn + 32'd4;
    
endmodule