module MEM_Stage(
    input clk, rst, writeBackEn_EXE_Reg, memRead, memWrite,
    input [31:0] address, data,
    inout [15:0] sramData,
    output [17:0] sramAddress,
    output [4:0] sramCtrl,
    output [31:0] memResult,
    output writeBackEn, ready
);

    SRAM_Controller sramctrl(clk, rst, memWrite, memRead, address, data, memResult, ready, sramData, sramAddress,
        sramCtrl[4], sramCtrl[3], sramCtrl[2], sramCtrl[1], sramCtrl[0]);

    assign writeBackEn = ready ? writeBackEn_EXE_Reg : 1'b0; 

endmodule



module MEM_Stage_Old(
    input clk, rst, memRead, memWrite,
    input [31:0] address, data,
    output [31:0] memResult
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