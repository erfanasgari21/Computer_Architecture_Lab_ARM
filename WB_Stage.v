module WB_Stage(
    input clk, rst,
    input [3:0] dstIn,
    input [31:0] memResult, aluResult,
    input memReadEn, wbEnIn
    output [3:0] wbDst, 
    output [31:0] wbValue,
    output wbEn
);
    assign wbDst = dstIn;
    assign wbEn = wbEnIn;
    assign wbValue = memReadEn ? memResult : aluResult;
endmodule