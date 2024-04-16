module WB_Stage(
    input clk, rst,
    input [31:0] dst, memOut, aluOut,
    output [31:0] pc,
);
    
    assign pc = pcIn;
endmodule