module EXE_Stage(
    //from ID stage
    input clk, rst,
    input[3:0] exeCmd,
    input memReadEn, memWriteEn,
    input[31:0] pc,
    input[31:0] valRn, valRm,
    input imm,
    input[11:0] shiftOperand,
    input[23:0] signedImm24,
    input[3:0] statusRegID,

    //to MEM stage
    output [31:0]resultALU, branchAddress,
    //to Status register
    output [3:0] statusRegEXE
);
    wire[31:0] val1, val2;
    wire C, isMem;

    assign val1 = valRn;
    assign C = statusRegID[3];
    assign isMem = memReadEn || memWriteEn;

    Val_Generator val_generator(valRm, imm, isMem, shiftOperand, val2);
    Branch_Adder branch_adder(pc, signedImm24, branchAddress);
    ALU alu(val1, val2, C, exeCmd, resultALU, statusRegEXE);
endmodule