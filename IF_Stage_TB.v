`timescale 1ns/1ns
module IF_Stage_TB();
    reg clk, rst, freeze, branchTaken;
    reg[31:0] branchAddress, pc, instruction;
    

    IF_Stage CUT(clk, rst, freeze, branchTaken, branchAddress, pc, instruction);
    initial begin
        clk = 0;
        rst = 1;
        #100 rst = 0;

        #1000

        $stop;
    end
    always begin
        #10 clk = ~clk;
    end
endmodule