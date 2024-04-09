module Mux_4b(
    input select, 
    input[3:0] in1, in2,
    output[3:0] out
    );

    assign out = ~select ? in1 : in2;
    
endmodule
