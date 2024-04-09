module Mux_9b(
    input select, 
    input[8:0] in1, in2,
    output[8:0] out
    );

    assign out = ~select ? in1 : in2;
    
endmodule