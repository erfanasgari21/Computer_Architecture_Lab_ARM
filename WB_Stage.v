module WB_Stage(
    input clk, rst,
    input [31:0] dstIn, memResult, aluResult,
    input memReadEn, wbEnIn,
    output [31:0] wbDst, wbValue,
    output wbEn
);
    assign wbDst = dstIn;
    assign wbEn = wbEnIn;
    assign wbValue = memReadEn ? memResult : aluResult;
endmodule