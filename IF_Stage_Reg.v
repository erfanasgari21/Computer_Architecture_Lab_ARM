module IF_Stage_Reg(
    input clk, rst, freeze, flush, ready,
    input[31:0] pcIn, instructionIn,
    output reg[31:0] pc, instruction
);
    wire stall;
    assign stall = freeze | ~ready;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            pc = 32'b0;
            instruction = 32'b0;
        end 
        else if(flush) begin
            pc = 32'b0;
            instruction = 32'b0;
        end 
        else if(stall==1'b0) begin
            pc = pcIn;
            instruction = instructionIn;
        end
    end
endmodule