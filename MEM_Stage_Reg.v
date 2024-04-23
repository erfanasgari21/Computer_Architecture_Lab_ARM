module MEM_Stage_Reg(
    input clk, rst, wbEnIn, memReadEnIn,
    input [31:0] aluResultIn, memReadValueIn,
    input [3:0] dstIn,
    output reg wbEn, memReadEn,
    output reg [31:0] aluResult, memReadValue,
    output reg [3:0] dst
);

    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            {wbEn, memReadEn, aluResult, memReadValue, dst} = 70'b0;
        end
        else begin
            {wbEn, memReadEn, aluResult, memReadValue, dst} <= {wbEnIn, memReadEnIn, aluResultIn, memReadValueIn, dstIn};
        end
    end

endmodule