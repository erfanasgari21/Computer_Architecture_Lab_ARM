module MEM_Stage(
    input clk, rst, memRead, memWrite,
    input [31:0] address, data,
    inout [15:0] sramData,
    output [17:0] sramAddress,
    output [4:0] sramCtrl,
    output [31:0] memResult,
);
    SRAM_Controller sramctrl(    input clk, rst, wrEn,
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
    output          SRAM_OE_N);
endmodule



module MEM_Stage_Old(
    input clk, rst, memRead, memWrite,
    input [31:0] address, data,
    output [31:0] memResult
);
    integer i=0;
    reg[31:0] memory[0:63];
    wire[31:0] temp;

    initial begin
        for(i=0; i<64; i=i+1) begin
                memory[i] <= 0;
        end
    end
    assign memResult = memRead ? memory[(address-32'd1024)>>2]: 32'b0;
    always @(posedge clk) begin
        if(memWrite) memory[(address-1024)>>2] <= data;
    end
endmodule