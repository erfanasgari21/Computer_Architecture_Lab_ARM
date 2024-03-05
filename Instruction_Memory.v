module Instruction_Memory(
    input[31:0] address,
    output reg[31:0] instruction
    );

    always @(address)
    case (address)
      32'd0 : instruction = 32'b11100011101000000000000000010100;
      32'd4 : instruction = 32'b11100011101000000001101000000001;
      32'd8: instruction = 32'b11100011101000000010000100000011;
      32'd12: instruction = 32'b11100000100100100011000000000010;
      32'd16: instruction = 32'b11100000101000000100000000000000;
      default: instruction = 32'b0;
    endcase

endmodule