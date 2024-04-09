module ALU(
    input [31:0] in1, in2, c,
    input [3:0] aluCmd,
    output reg [31:0] result,
    output [3:0] statusBits,
);
    reg V, C;
    wire N, Z;

    always @(aluCmd, in1, in2, c) begin
        {V, C, result} = 34'b0;
        case(aluCmd)
            4'b0001: result = in1;
            4'b1001: result = ~in1;
            4'b0010: begin
                {C, result} = in1 + in2;
                V = (result[31] != in1[31]) && (in1[31]==in2[31]);
            end
            4'b0011: begin
                {C, result} = in1 + in2 + c;
                V = (result[31] != in1[31]) && (in1[31]==in2[31]);
            end
            4'b0100: begin 
                {C, result} = in1 - in2;
                V = (result[31] != in1[31]) && (in1[31]==~in2[31]);
            end
            4'b0101: begin 
                {C, result} = in1 - in2 - ~c;
                V = (result[31] != in1[31]) && (in1[31]==~in2[31]);
            end
            4'b0110: result = in1 & in2;
            4'b0111: result = in1 | in2;
            4'b1000: result = in1 ^ in2;
            4'b0110: result = in1 & in2;
        endcase
    end

    assign N = result[31];
    assign Z = (result == 0);
    assign statusBits = {N, Z, V, C};

endmodule