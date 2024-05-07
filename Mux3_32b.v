module Mux3_32b(
    input select, 
    input[31:0] in1, in2, in3,
    output[31:0] out
    );

    assign out = (select==2'b00) ? in1 : (select==2'b01) ? in2 : in3;
    
endmodule
