`define IDLE 2'd0;
`define READ_LOW 2'd1;
`define READ_HIGH 2'd2;
`define WRITE 2'd3;

module Cache_Controller(
    input clk, rst,

    input [31:0] address,
    input [31:0] writeData,
    input wrEn, rdEn,
    output [31:0] readData,
    output ready,

    // Sram Controller
    output [31:0] sramAddress,
    output [31:0] sramWriteData,
    output sramWrEn, sramRdEn, 
    input  [63:0] sramReadData,
    input  sramReady,
);

    // ADDRESS DECODE
    wire word = address[2];
    wire index = address[8:3];
    wire tag = address[18:9];

    // CACHE MEMORY
    reg [63:0] dataWay0 [0:63];
    reg [63:0] dataWay1 [0:63];
    reg [9:0] tagWay0 [0:63];
    reg [9:0] tagWay1 [0:63];
    reg [0:63] validWay0;
    reg [0:63] validWay1;
    reg [0:63] LRU;

    // COMBINATIONAL LOGIC
    wire hit, hitWay0, hitWay1;
    assign hitWay0 = (tagWay0[index] == tag) & validWay0;
    assign hitWay1 = (tagWay1[index] == tag) & validWay1;
    
    assign hit = hitWay0 | hitWay1;

    wire [63:0] readBlock; 
    assign readBlock = hitWay0 ? dataWay0[index] : hitWay1 ? dataWay1[index] : sramReadData;
    assign readData = word ? readBlock[63:32] : readBlock[31:0] ;

    assign sramRdEn = rdEn & ~hit;
    assign sramWrEn = wrEn; 
    assign ready = hit | (sramReady & (state == `READ_HIGH | state == `WRITE))  ; // note: to be completed
    assign sramAddress = address;
    assign sramWriteData = writeData; 

    // STATE MACHINE
    reg [1:0] ps, ns;

    always @(ps,)

endmodule