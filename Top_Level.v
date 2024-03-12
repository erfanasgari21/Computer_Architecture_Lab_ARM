module Top_Level(
    input clk, rst
);
    wire [31:0] pc_IF, pc_IF_Reg, pc_ID, pc_ID_reg, pc_EXE, pc_EXE_Reg, pc_MEM, pc_MEM_Reg, pc_WB, pc_WB_Reg;
    wire [31:0] instruction_IF, instruction_IF_Reg;
    IF_Stage        IF(clk, rst, 1'b0, 1'b0, 32'b0, pc_IF, instruction_IF);
    IF_Stage_Reg    IF_Reg(clk, rst, 1'b0, 1'b0, pc_IF, instruction_IF, pc_IF_Reg, instruction_IF_Reg);
    ID_Stage        ID(clk, rst, pc_IF_Reg, pc_ID);
    ID_Stage_Reg    ID_Reg(clk, rst, pc_ID, pc_ID_Reg);
    EXE_Stage       EXE(clk, rst, pc_ID_Reg, pc_EXE);
    EXE_Stage_Reg   EXE_Reg(clk, rst, pc_EXE, pc_EXE_Reg);
    MEM_Stage       MEM(clk, rst, pc_EXE_Reg, pc_MEM);
    MEM_Stage_Reg   MEM_Reg(clk, rst, pc_MEM, pc_MEM_Reg);
    WB_Stage        WB(clk, rst, pc_MEM_Reg, pc_WB);
    WB_Stage_Reg    WB_Reg(clk, rst, pc_WB, pc_WB_Reg);
endmodule