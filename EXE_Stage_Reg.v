module EXE_Stage_Reg(
    input clk, rst, 
    input writeBackEnIn, memReadEnIn, memWriteEnIn, 
    input[31:0] resultALUIn, storeValIn,
    input[3:0] destIn,

    output reg writeBackEn, memReadEn, memWriteEn, 
    output reg[31:0] resultALU, storeVal,
    output reg[3:0] dest
);
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            {writeBackEn, memReadEn, memWriteEn} <= 3'b0;
            {exeCmd, dest, statusReg} <= 12'b0;
            shiftOperand <= 12'b0;
            signedImm24 <= 24'b0;
            {pc, valRn, valRm} <= 96'b0;
        end
        else begin
            {writeBackEn, memReadEn, memWriteEn, b, s, imm} <= {writeBackEnIn, memReadEnIn, memWriteEnIn, bIn, sIn, immIn};
            {exeCmd, dest, statusReg} <= {exeCmdIn, destIn, statusRegIn};
            shiftOperand <= shiftOperandIn;
            signedImm24 <= signedImm24In;
            {pc, valRn, valRm} <= {pcIn, valRnIn, valRmIn};
        end
    end
endmodule