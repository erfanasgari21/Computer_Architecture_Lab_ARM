module MEM_Stage(
    input clk, rst, memRead, memWrite,
    input [31:0] address, data,
    output [31:0] memResult
);

    reg[31:0] memory[0:63];
    
    assign memResult = memRead ? memory[(address-1024)>>4]: 32'b0;
    always @(posedge clk) begin
        if(memWrite) memory[(address-1024)>>4] <= data;
    end
endmodule