module Hazard_Unit(
    input forwardingEn,
    input [3:0] src1, src2,
    input twoSrc,
    input wbEn_EXE, wbEn_MEM, memReadEn_EXE,
    input [3:0] wbDst_EXE, wbDst_MEM,
    output freeze
);
    wire cond1;
    wire cond2;
    wire cond3;
    wire cond4;
    wire cond5;
    wire cond6;

    assign cond1 = wbEn_EXE && (src1==wbDst_EXE);
    assign cond2 = wbEn_EXE && twoSrc && (src2==wbDst_EXE);
    assign cond3 = wbEn_MEM && (src1==wbDst_MEM);
    assign cond4 = wbEn_MEM && twoSrc && (src2==wbDst_MEM);

    assign cond5 = memReadEn_EXE && (src1==wbDst_EXE);
    assign cond6 = memReadEn_EXE && twoSrc && (src2==wbDst_EXE);

    assign freeze = forwardingEn ? (cond5 || cond6) : (cond1 || cond2 || cond3 || cond4);

    // assign freeze = ((wbEn_EXE && (src1==wbDst_EXE || (twoSrc && src2==wbDst_EXE))) || (wbEn_MEM && (src1==wbDst_MEM || (twoSrc && src2==wbDst_MEM))));

endmodule