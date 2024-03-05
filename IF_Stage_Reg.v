module IF_Stage_Reg(
    input clk, rst, freeze, flush,
    input[31:0] pcIn, instructionIn,
    output reg[31:0] pc, instruction
);
    always @(posedge) begin
        pc = pcIn;
        instruction = instructionIn;
    end
endmodule