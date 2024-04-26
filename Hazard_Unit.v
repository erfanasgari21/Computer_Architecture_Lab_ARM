module Hazard_Unit(
    input [3:0] src1, src2,
    input twoSrc,
    input wbEn_EXE, wbEn_MEM,
    input [3:0] wbDst_EXE, wbDst_MEM,
    output freeze
);
    wire cond1;
    wire cond2;
    wire cond3;
    wire cond4;

    assign cond1 = wbEn_EXE && (src1==wbDst_EXE);
    assign cond2=  wbEn_EXE && twoSrc && (src2==wbDst_EXE);
    assign cond3 = wbEn_MEM && (src1==wbDst_MEM);
    assign cond4 = wbEn_MEM && twoSrc && (src2==wbDst_MEM);
    assign freeze = cond1 || cond2 || cond3 || cond4;

    // assign freeze = ((wbEn_EXE && (src1==wbDst_EXE || (twoSrc && src2==wbDst_EXE))) || (wbEn_MEM && (src1==wbDst_MEM || (twoSrc && src2==wbDst_MEM))));

endmodule