
module SRAM(
    input clk, rst, memRead, memWrite,
    input [17:0] address, 
    inout [15:0] data,
    output [15:0] memResult
);
    integer i=0;
    reg[31:0] memory[0:63];
    wire[31:0] temp;

    initial begin
        for(i=0; i<64; i=i+1) begin
                memory[i] <= 0;
        end
    end
    assign memResult = memRead ? memory[(address-32'd1024)>>2]: 32'b0;
    always @(posedge clk) begin
        if(memWrite) memory[(address-1024)>>2] <= data;
    end
endmodule