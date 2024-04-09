`timescale 1ns/1ns
module Top_Level_TB();
    reg clk, rst, freeze, branchTaken;
    reg[31:0] branchAddress;
    wire[31:0] pc, instruction;
    

    IF_Stage CUT(clk, rst, freeze, branchTaken, branchAddress, pc, instruction);
    initial begin
        clk = 0;
        rst = 1;
        #100 rst = 0;
        freeze = 0;
        branchTaken = 0;
        branchAddress = 32'b0;
        #1000
        $stop;
    end
    always begin
        #10 clk = ~clk;
    end
endmodule
