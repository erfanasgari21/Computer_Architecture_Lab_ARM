module Register_File(
    input clk, rst,
    input[3:0] src1, src2, destWB,
    input[31:0] resultWB,
    input writeBackEn,
    output[31:0] reg1, reg2
);
    integer i;
    reg[15:0] registerFile[14:0];
    
    assign reg1 = registerFile[src1];
    assign reg2 = registerFile[src2];

    initial begin
        for(i=0; i<14; i=i+1) begin
                registerFile[i] <= i;
        end
    end
    
    always @(negedge clk or posedge rst) begin
        if(rst) begin
            for(i=0; i<14; i=i+1) begin
                registerFile[i] <= 16'b0;
            end
        end
        else if(writeBackEn) begin
            registerFile[destWB] <= resultWB;
        end
    end
endmodule