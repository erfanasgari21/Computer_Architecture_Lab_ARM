`define IDLE 3'b000
`define WRITE_LOW 3'b001
`define WRITE 3'b010
`define DATA_TRANS 3'b011

module SRAM_Controller (
    input clk,
    input rst,
    
    input wrEn,
    input rdEn,
    input[31:0] address,
    input[31:0] writeData,

    output[31:0] readData,
    output ready,

    inout[15:0]     SRAM_DQ,
    output[17:0]    SRAM_ADDR,
    output          SRAM_WE_N,
    output          SRAM_UB_N,
    output          SRAM_LB_N,
    output          SRAM_CE_N,
    output          SRAM_OE_N
);

    assign {SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} = 4'b0;
    

endmodule