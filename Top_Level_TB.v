`timescale 1ns/1ns
module Top_Level_TB();
    reg clk, rst;
    

    Top_Level CUT(clk, rst);
    initial begin
        clk = 0;
        rst = 1;
        #100 rst = 0;

        #100000
        $stop;
    end
    always begin
        #10 clk = ~clk;
    end
endmodule
