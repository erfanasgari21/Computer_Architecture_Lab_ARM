module Val_Generator(
    input [31:0] valRm,
    input imm, isMem
    input [11:0] shiftOperand,
    output [31:0] valOut,
);

    always@(valRm, imm, shiftOperand, signedImm24)
    begin
        valOut = 32'b0;
        if(isMem) begin
            valOut = shiftOperand;
        end
        else if(imm) begin
            valOut = (shiftOperand[7:0] >> shiftOperand[11:8]) | (shiftOperand[7:0] << (32-shiftOperand[11:8]));
        end
        else if(~shiftOperand[4]) begin
            case(shiftOperand[6:5])
                2'b00: valOut = valRm << shiftOperand[11:7];
                2'b01: valOut = valRm >> shiftOperand[11:7];
                2'b10: valOut = valRm >>> shiftOperand[11:7];
                2'b11: valOut = (valRm >> shiftOperand[11:7]) | (valRm << (32-shiftOperand[11:7]))
            endcase
        end
    end

endmodule