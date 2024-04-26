module Condition_Check (
    input [3:0] condition, 
    input [3:0] statusReg, 
    output reg out
);
    wire N, Z, C, V;
    assign {N, Z, C, V} = statusReg;
    always @(condition, statusReg) begin
        case(condition) 
            4'b0000: out = Z;
            4'b0001: out = ~Z;
            4'b0010: out = C;
            4'b0011: out = ~C;
            4'b0100: out = N;
            4'b0101: out = ~N;
            4'b0110: out = V;
            4'b0111: out = ~V;
            4'b1000: out = C && ~Z;
            4'b1001: out = ~C || Z;
            4'b1010: out = (N==V);
            4'b1011: out = ~(N==V);
            4'b1100: out = ~Z && (N==V);
            4'b1101: out = Z && ~(N==V);
            4'b1110: out = 1'b1;
            4'b1111: out = 1'b1;
        endcase
    end
endmodule

