
module SRAM(
    input clk, rst, memWrite_n,
    input [17:0] address, 
    inout [15:0] data
);
    integer i=0;
    reg [15:0] memory[0:127];

    initial begin
        for(i=0; i<128; i=i+1) begin
                memory[i] <= 0;
        end
    end

    assign data = (memWrite_n & (address<=7'd127)) ? memory[address] : 16'bz;
    
    always @(posedge clk) begin
        if(~memWrite_n) memory[address] <= data;
    end
endmodule