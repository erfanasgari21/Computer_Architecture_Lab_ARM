module ID_Stage_Reg(
    input clk, rst, flush, 
    input writeBackEnIn, memReadEnIn, memWriteEnIn, bIn, sIn, 
    input[3:0] exeCmdIn, 
    input[31:0] pcIn, valRnIn, valRmIn,
    input immIn,
    input[11:0] shiftOperandIn,
    input[23:0] signedImm24In,
    input[3:0] destIn,
    input[3:0] statusRegIn,
    input[3:0] src1In, src2In,

    output reg writeBackEn, memReadEn, memWriteEn, b, s, 
    output reg[3:0] exeCmd, 
    output reg[31:0] pc, valRn, valRm,
    output reg imm,
    output reg[11:0] shiftOperand,
    output reg[23:0] signedImm24,
    output reg[3:0] dest,
    output reg[3:0] statusReg,
    output[3:0] src1, src2
);
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            {writeBackEn, memReadEn, memWriteEn, b, s, imm} <= 6'b0;
            {exeCmd, dest, statusReg} <= 12'b0;
            shiftOperand <= 12'b0;
            signedImm24 <= 24'b0;
            {pc, valRn, valRm} <= 96'b0;
            {src1, src2} <= 8'b0;
        end
        else if(flush) begin
            {writeBackEn, memReadEn, memWriteEn, b, s, imm} <= 6'b0;
            {exeCmd, dest, statusReg} <= 12'b0;
            shiftOperand <= 12'b0;
            signedImm24 <= 24'b0;
            {pc, valRn, valRm} <= 96'b0;
            {src1, src2} <= 8'b0;
        end
        else begin
            {writeBackEn, memReadEn, memWriteEn, b, s, imm} <= {writeBackEnIn, memReadEnIn, memWriteEnIn, bIn, sIn, immIn};
            {exeCmd, dest, statusReg} <= {exeCmdIn, destIn, statusRegIn};
            shiftOperand <= shiftOperandIn;
            signedImm24 <= signedImm24In;
            {pc, valRn, valRm} <= {pcIn, valRnIn, valRmIn};
            {src1, src2} <= {src1In, src2In};
        end
    end
endmodule