module IF_Stage(
    input clk, rst, freeze, branchTaken,
    input[31:0] branchAddress,
    output[31:0] pc, instruction);

    wire[31:0] pcIn, pcOut;
    
    Mux_32b mux_32b(branchTaken, pc, branchAddress, pcIn);
    PC_Reg pc_reg(clk, rst, freeze, pcIn, pcOut);
    PC_Adder pc_adder(pcOut, pc);
    Instruction_Memory instruction_memory(pcOut, instruction);
endmodule