module ID_Stage(
    input clk, rst,
    //from IF stage
    input[31:0] instruction,
    //from WB stage
    input[31:0] resultWB,
    input[3:0] destWB,
    input writeBackEnWB,
    //from HazardDetect module
    input hazard,
    //from Status register 
    input[3:0] statusReg,
    //to ID stage register
    output[31:0] valRn, valRm,
    output[23:0] signedImm24,
    output[11:0] shiftOperand,
    output[3:0] exeCmd, destID,
    output imm, writeBackEnID, memReadEn, memWriteEn, b, s,
    //to HazardDetect module
    output[3:0] src1, src2, 
    output twoSrc
);
    wire[8:0] controlOut;
    wire conditionOut;
    assign signedImm24 = instruction[23:0];
    assign shiftOperand = instruction[11:0];
    assign destID = instruction[15:12];
    assign imm = instruction[25];
    assign src1 = instruction[19:16];
    Mux_4b mux_4b(memWriteEn, instruction[3:0], destID, src2);
    Register_File register_file(clk, rst, src1, src2, destWB, resultWB, writeBackEnWB, valRn, valRm);
    Control_Unit control_unit(instruction[27:26], instruction[24:21], instruction[20], controlOut);
    Condition_Check condition_check(instruction[31:28], statusReg, conditionOut);
    Mux_9b mux_9b(~conditionOut || hazard, controlOut, 9'b0, {exeCmd, memReadEn, memWriteEn, writeBackEnID, b, s});
endmodule