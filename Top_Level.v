module Top_Level(
    input clk, rst
);
    wire [31:0] pc_IF, pc_IF_Reg, pc_EXE, pc_EXE_Reg, pc_MEM, pc_MEM_Reg, pc_WB, pc_WB_Reg;
    wire [31:0] inst_IF, inst_IF_Reg;

    // ID Stage
    wire [31:0] valRn_ID, valRm_ID;
    wire [23:0] signedImm24_ID;
    wire [11:0] shiftOperand_ID;
    wire [3:0] exeCmd_ID, destID_ID;
    wire imm_ID, writeBackEnID_ID, memReadEn_ID, memWriteEn_ID, b_ID, s_ID;
    wire [3:0] src1_ID, src2_ID;
    wire twoSrc_ID;

    // ID Stage Reg
    wire writeBackEn_ID_Reg, memReadEn_ID_Reg, memWriteEn_ID_Reg, b_ID_Reg, s_ID_Reg;
    wire[3:0] exeCmd_ID_Reg;
    wire[31:0] pc_ID_Reg, valRn_ID_Reg, valRm_ID_Reg;
    wire imm_ID_Reg;
    wire[11:0] shiftOperand_ID_Reg;
    wire[23:0] signedImm24_ID_Reg;
    wire[3:0] dest_ID_Reg;

    IF_Stage        IF(clk, rst, 1'b0, 1'b0, 32'b0, pc_IF, inst_IF);
    IF_Stage_Reg    IF_Reg(clk, rst, 1'b0, 1'b0, pc_IF, inst_IF, pc_IF_Reg, inst_IF_Reg);
    ID_Stage        ID(clk, rst, inst_IF_Reg, 32'b0, 4'b0, 1'b0, 1'b0, 4'b0,  valRn_ID, valRm_ID, signedImm24_ID, shiftOperand_ID,exeCmd_ID, destID_ID, imm_ID, writeBackEnID_ID, memReadEn_ID, memWriteEn_ID, b_ID, s_ID, src1_ID, src2_ID,  twoSrc_ID);
    ID_Stage_Reg    ID_Reg(clk, rst, 1'b0, writeBackEnID_ID, memReadEn_ID, memWriteEn_ID, b_ID, s_ID, exeCmd_ID, pc_IF_Reg, valRn_ID, valRm_ID, imm_ID, shiftOperand_ID, signedImm24_ID, destID_ID, writeBackEn_ID_Reg, memReadEn_ID_Reg, memWriteEn_ID_Reg, b_ID_Reg, s_ID_Reg, exeCmd_ID_Reg, pc_ID_Reg, valRn_ID_Reg, valRm_ID_Reg, imm_ID_Reg, shiftOperand_ID_Reg, signedImm24_ID_Reg, dest_ID_Reg);
    // EXE_Stage       EXE(clk, rst, pc_ID_Reg, pc_EXE);
    // EXE_Stage_Reg   EXE_Reg(clk, rst, pc_EXE, pc_EXE_Reg);
    // MEM_Stage       MEM(clk, rst, pc_EXE_Reg, pc_MEM);
    // MEM_Stage_Reg   MEM_Reg(clk, rst, pc_MEM, pc_MEM_Reg);
    // WB_Stage        WB(clk, rst, pc_MEM_Reg, pc_WB);
    // WB_Stage_Reg    WB_Reg(clk, rst, pc_WB, pc_WB_Reg);
endmodule

