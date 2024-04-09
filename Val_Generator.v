module Val_Generator(
    input [31:0] valRm,
    input imm,
    input [11:0] shiftOperand,
    input [23:0] signedImm24,

    output [31:0] valOut,
);

    always@(valRm, imm, shiftOperand, signedImm24)
    begin
        if(imm) begin
            valOut = (shiftOperand[7:0] >> shiftOperand[11:8]) | (shiftOperand[7:0] << (32-shiftOperand[11:8]));
        end
        else if(~shiftOperand[4]) begin
            case(shiftOperand[6:5])
                2'b00: valRm << shiftOperand[11:7];
                2'b01: valRm >> shiftOperand[11:7];
                2'b10: //
                2'b11: //
            endcase
        end
    end

endmodule