`timescale 1ns/1ns
module Top_Level_TB();
    reg clk, rst, forwardingEn;
    wire [15:0]sramData;
    wire [17:0]sramAddress;
    wire [4:0]sramCtrl;

    Top_Level CUT(clk, rst, forwardingEn, sramData, sramAddress, sramCtrl);
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
