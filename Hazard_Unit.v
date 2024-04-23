module Hazard_Unit(
    input [3:0] src1, src2,
    input twoSrc,
    input wbEn_EXE, wbEn_MEM,
    input [3:0] wbDst_EXE, wbDst_MEM,
    output freeze
);
    assign freeze = ((wbEn_EXE && (src1==wbDst_EXE || (twoSrc && src2==wbDst_EXE))) || (wbEn_MEM && (src1==wbDst_MEM || (twoSrc && src2==wbDst_MEM))));

endmodule