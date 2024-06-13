`define IDLE 4'd0
`define WRITE_LOW 4'd1
`define WRITE_HIGH 4'd2
`define STALL 4'd3
`define READ0 4'd4
`define READ1 4'd5
`define READ2 4'd6
`define READ3 4'd7
`define READY 4'd8

module SRAM_Controller (
    input clk,
    input rst,
    
    input wrEn,
    input rdEn,
    
    input[31:0] address,
    input[31:0] writeData,

    output[63:0] readData,
    output reg ready,

    inout[15:0]     SRAM_DQ,
    output reg [17:0] SRAM_ADDR,
    output reg      SRAM_WE_N,
    output          SRAM_UB_N,
    output          SRAM_LB_N,
    output          SRAM_CE_N,
    output          SRAM_OE_N
);
    reg [3:0] ps, ns;
    reg cntEn, cntLd;
    reg [15:0] data0, data1, data2, data3;
    wire [16:0] sramAddress;
    wire co;

    Counter_3b cnt3b(clk, rst, cntEn, cntLd, 3'b100, co);

    assign {SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} = 4'b0;

    assign sramAddress = ((address-1024))>>2;

    always @(ps, wrEn, rdEn, co) begin
        ns = `IDLE;
        case(ps) 
            `IDLE :         ns = wrEn ? `WRITE_LOW : (rdEn ? `READ0 : `IDLE);
            `WRITE_LOW :    ns = `WRITE_HIGH;
            `WRITE_HIGH :   ns = `STALL;
            `STALL :        ns = co ? `READY : `STALL;
            `READ0 :        ns = `READ1;
            `READ1 :        ns = `READ2;
            `READ2 :        ns = `READ3;
            `READ3 :        ns = `READY;
            `READY :        ns = `IDLE;
        endcase
    end

    always @(posedge clk) begin
        if(rst)
            ps <= `IDLE;
        else
            ps <= ns;
    end

    always @(ps, wrEn, rdEn) begin
        ready = 1'b0; 
        cntEn = 1'b1;
        cntLd = 1'b0;
        SRAM_ADDR = 18'b0;
        SRAM_WE_N = 1'b1;
        case(ps) 
            `IDLE :         begin ready=~(wrEn|rdEn); cntEn=1'b0; cntLd=1'b1; SRAM_ADDR={sramAddress>>1, 2'b00}; end
            `WRITE_LOW :    begin SRAM_WE_N=1'b0; SRAM_ADDR={sramAddress, 1'b0}; end
            `WRITE_HIGH :   begin SRAM_WE_N=1'b0; SRAM_ADDR={sramAddress, 1'b1}; end
            `READ0 :        begin data0=SRAM_DQ; SRAM_ADDR={sramAddress>>1, 2'b01}; end 
            `READ1 :        begin data1=SRAM_DQ; SRAM_ADDR={sramAddress>>1, 2'b10}; end
            `READ2 :        begin data2=SRAM_DQ; SRAM_ADDR={sramAddress>>1, 2'b11}; end
            `READ3 :        begin data3=SRAM_DQ; end
            `READY :        begin ready=1'b1; end
        endcase
    end

    assign SRAM_DQ = (ps==`WRITE_LOW) ? writeData[15:0] : ((ps==`WRITE_HIGH) ? writeData[31:16] : 16'bz);
    assign readData = {data3, data2, data1, data0};

endmodule

