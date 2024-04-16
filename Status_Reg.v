module Status_Reg(
    input s,
    input [3:0] statusIn,

    output reg[3:0] status
);

    always @(negedge clk or posedge rst) begin
        if(rst) begin
            status = 4'b0;
        end 
        else if(s) begin
            status = statusIn;
        end
    end
endmodule