module PC_Reg(
    input clk, rst, freeze, ready, 
    input[31:0] pcIn,
    output reg[31:0] pcOut
    );

    wire stall;
    assign stall = freeze | ~ready;
    always @(posedge clk or posedge rst)
    begin
        if(rst==1'b1)
            pcOut = 32'b0;
        else if(stall==1'b0)
            pcOut = pcIn;
    end

endmodule