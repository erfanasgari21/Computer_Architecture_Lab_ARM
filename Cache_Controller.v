module Cache_Controller(
    input clk, rst,

    input [31:0] address,
    input [31:0] writeData,
    input wrEn, rdEn,
    output [31:0] readData,
    output ready,

    // Sram Controller
    output [31:0] sramAddress,
    output [31:0] sramWriteData,
    output sramWrEn, sramRdEn, 
    input  [63:0] sramReadData,
    input  sramReady,
);

    assign sramRdEn = rdEn & ~hit;
    assign sramWrEn = wrEn; 
    assign ready = hit | sramReady;

endmodule