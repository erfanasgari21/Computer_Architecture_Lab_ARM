module EXE_Stage_Reg(
    input clk, rst, ready,
    input writeBackEnIn, memReadEnIn, memWriteEnIn, 
    input[31:0] resultALUIn, storeValIn,
    input[3:0] destIn,

    output reg writeBackEn, memReadEn, memWriteEn, 
    output reg[31:0] resultALU, storeVal,
    output reg[3:0] dest
);
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            {writeBackEn, memReadEn, memWriteEn} <= 3'b0;
            {resultALU, storeVal} <= 64'b0;
            dest <= 4'b0;
        end
        else if(ready) begin
                {writeBackEn, memReadEn, memWriteEn} <= {writeBackEnIn, memReadEnIn, memWriteEnIn};
                {resultALU, storeVal} <= {resultALUIn, storeValIn};
                dest <= destIn;
        end
    end
endmodule