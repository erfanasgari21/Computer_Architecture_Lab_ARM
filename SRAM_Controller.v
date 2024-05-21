`define IDLE 3'd0
`define WRITE_LOW 3'd1
`define WRITE_HIGH 3'd2
`define READ_ADDR 3'd3
`define READ_LOW 3'd4
`define READ_HIGH 3'd5
`define STALL 3'd6

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