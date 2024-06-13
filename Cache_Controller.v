`define IDLE 2'd0
`define READ_LOW 2'd1
`define READ_HIGH 2'd3

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
    input  sramReady
);

    // ADDRESS DECODE
    wire word = address[2];
    wire [5:0] index = address[8:3];
    wire [9:0] tag = address[18:9];

    // CACHE MEMORY
    reg [63:0] dataWay0 [0:63];
    reg [63:0] dataWay1 [0:63];
    reg [9:0] tagWay0 [0:63];
    reg [9:0] tagWay1 [0:63];
    reg [0:63] validWay0;
    reg [0:63] validWay1;
    reg [0:63] LRU;

    // COMBINATIONAL LOGIC
    initial begin
        validWay0 = 64'b0;
        validWay1 = 64'b0;
        LRU = 64'b0;
    end

    wire hit, hitWay0, hitWay1;
    assign hitWay0 = (tagWay0[index] == tag) & validWay0[index];
    assign hitWay1 = (tagWay1[index] == tag) & validWay1[index];
    assign hit = hitWay0 | hitWay1;
    assign ready = ~(wrEn | rdEn) | (wrEn & sramReady) | (rdEn & (hit | sramReady));

    wire [63:0] readBlock; 
    assign readBlock = hitWay0 ? (dataWay0[index]) : (hitWay1 ? dataWay1[index] : sramReadData);
    assign readData = word ? readBlock[63:32] : readBlock[31:0] ;

    assign sramRdEn = rdEn & ~hit;
    assign sramWrEn = wrEn; 
    assign sramAddress = address;
    assign sramWriteData = writeData; 

    always @(posedge clk) begin
        if(rst) begin
            validWay0 = 64'b0;
            validWay1 = 64'b0;
            LRU = 64'b0;
        end
        else if(wrEn & hit) begin
            validWay0[index] <= hitWay0 ? 1'b0 : validWay0[index];
            validWay1[index] <= hitWay1 ? 1'b0 : validWay1[index];
        end
        else if(rdEn & hit) begin
            LRU[index] <= hitWay0 ? 1'b0 : 1'b1;
        end
        else if(rdEn & sramReady & ~hit) begin
            if(LRU[index]==1'b0) begin
                dataWay1[index] <= sramReadData;
                tagWay1[index] <= tag;
                validWay1[index] <= 1'b1;
                LRU[index] <= 1'b1;
            end
            else begin
                dataWay0[index] <= sramReadData;
                tagWay0[index] <= tag;
                validWay0[index] <= 1'b1;
                LRU[index] <= 1'b0;
            end
        end
    end

endmodule