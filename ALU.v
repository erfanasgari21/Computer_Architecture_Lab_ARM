module ALU(
    input [31:0] in1, in2,
    input c,
    input [3:0] aluCmd,
    output reg [31:0] resultALU,
    output [3:0] statusBits
);
    reg V, C;
    wire N, Z;

    always @(aluCmd, in1, in2, c) begin
        {V, C, resultALU} = 34'b0;
        case(aluCmd)
            4'b0001: resultALU = in2;
            4'b1001: resultALU = ~in2;
            4'b0010: begin
                {C, resultALU} = in1 + in2;
                V = (resultALU[31] != in1[31]) && (in1[31]==in2[31]);
            end
            4'b0011: begin
                {C, resultALU} = in1 + in2 + c;
                V = (resultALU[31] != in1[31]) && (in1[31]==in2[31]);
            end
            4'b0100: begin 
                {C, resultALU} = in1 - in2;
                V = (resultALU[31] != in1[31]) && (in1[31]==~in2[31]);
            end
            4'b0101: begin 
                {C, resultALU} = in1 - in2 - {31'b0, ~c};
                V = (resultALU[31] != in1[31]) && (in1[31]==~in2[31]);
            end
            4'b0110: resultALU = in1 & in2;
            4'b0111: resultALU = in1 | in2;
            4'b1000: resultALU = in1 ^ in2;
            4'b0110: resultALU = in1 & in2;
        endcase
    end

    assign N = resultALU[31];
    assign Z = (resultALU == 32'b0);
    assign statusBits = {N, Z, C, V};

endmodule