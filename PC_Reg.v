module PC_Reg(
    input clk, rst, freeze,
    input[31:0] pcIn,
    output reg[31:0] pcOut
    );

    always @posedge(clk, rst)
    begin
        if(rst==1'b1)
            pcOut = 32'b0;
        else if(freeze==1'b0)
            pcOut = pcIn;
    end
    
endmodule