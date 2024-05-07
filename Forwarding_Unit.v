module Forwarding_Unit(
    input forwardingEn,
    input [3:0] src1, src2,
    input [3:0] wbDst_MEM, wbDst_WB,
    input wbEn_MEM, wbEn_WB,
    output selSrc1, selSrc2
);
    assign selSrc1 = forwardingEn ? ((wbEn_MEM && src1 == wbDst_MEM) ? 2'd1 : (wbEn_WB && src1 == wbDst_WB) ? 2'd2 : 2'd0) : 2'd0; 
    assign selSrc2 = forwardingEn ? ((wbEn_MEM && src2 == wbDst_MEM) ? 2'd1 : (wbEn_WB && src2 == wbDst_WB) ? 2'd2 : 2'd0) : 2'd0; 
endmodule