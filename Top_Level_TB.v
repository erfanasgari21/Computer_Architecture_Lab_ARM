`timescale 1ns/1ns
module Top_Level_TB();
    reg clk, rst, forwardingEn;
    

    Top_Level CUT(clk, rst, forwardingEn);
    initial begin
        clk = 0;
        forwardingEn = 0;
        rst = 1;
        #100 rst = 0;

        #100000
        $stop;
    end
    always begin
        #10 clk = ~clk;
    end
endmodule
