module Control_Unit(
    input[1:0] mode,
    input[3:0] opCode,
    input sIn,
    output reg[3:0] exeCmd,
    output reg memRead, memWrite, writeBackEn, b, sOut
);
    always @(mode or opCode or sIn) begin
        {exeCmd, memRead, memWrite, writeBackEn, b, sOut} = 9'b0;
        case(mode)
            2'b00: begin
                sOut <= sIn;
                case(opCode)
                    4'b1101: {exeCmd, writeBackEn} <= {4'b0001, 1'b1}; //MOVE
                    4'b1111: {exeCmd, writeBackEn} <= {4'b1001, 1'b1}; //MVN
                    4'b0100: {exeCmd, writeBackEn} <= {4'b0010, 1'b1}; //ADD
                    4'b0101: {exeCmd, writeBackEn} <= {4'b0011, 1'b1}; //ADC
                    4'b0010: {exeCmd, writeBackEn} <= {4'b0100, 1'b1}; //SUB
                    4'b0110: {exeCmd, writeBackEn} <= {4'b0101, 1'b1}; //SBC
                    4'b0000: {exeCmd, writeBackEn} <= {4'b0110, 1'b1}; //AND
                    4'b1100: {exeCmd, writeBackEn} <= {4'b0111, 1'b1}; //ORR
                    4'b0001: {exeCmd, writeBackEn} <= {4'b1000, 1'b1}; //EOR
                    4'b1010: exeCmd <= 4'b0100;                        //CMP
                    4'b1000: exeCmd <= 4'b0110;                        //TST
                endcase
            end

            2'b01: begin
                exeCmd <= 4'b0010;
                sOut <= 1'b1;
                case(sIn)
                    1'b1: {memRead, writeBackEn} <= {1'b1, 1'b1}; //LDR
                    1'b0: memWrite <= 1'b1;                       //STR
                endcase
            end
            
            2'b10:
                b <= 1'b1;

        endcase
    end        

endmodule
