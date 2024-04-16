module Branch_Adder(
    input [31:0] pc,
    input [23:0] signedImm24,

    output [31:0] branchAddress,
)

    assign branchAddress = pc + ({{8{signedImm24[23]}}, signedImm24} << 2);

endmodule
