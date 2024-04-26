module Val_Generator(
    input [31:0] valRm,
    input imm, isMem,
    input [11:0] shiftOperand,
    output reg[31:0] valOut
);
    integer shiftValue=0;
    always@(valRm, imm, shiftOperand, isMem)
    begin
        valOut = 32'b0;
        if(isMem) begin
            valOut = shiftOperand;
        end
        else if(imm) begin
            shiftValue = (shiftOperand[11:8])*2;
            valOut = (shiftOperand[7:0]<<(32-shiftValue)) | (shiftOperand[7:0]>>(shiftValue));
        end
        else if(~shiftOperand[4]) begin
            shiftValue = (shiftOperand[11:7]);
            case(shiftOperand[6:5])
                2'b00: valOut = valRm << shiftValue;
                2'b01: valOut = valRm >> shiftValue;
                2'b10: valOut = valRm >>> shiftValue;
                2'b11: valOut = (valRm >> shiftValue) | (valRm << (32-shiftValue));
            endcase
        end
    end

endmodule