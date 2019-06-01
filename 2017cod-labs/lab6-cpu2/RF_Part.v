module RF_Part(
	input clk,rst_n,
	input [4:0] rs,rt,rd,
	input [31:0] alu_out,mem_out,
	output [31:0] reg_A,reg_B,
	input RegWrite,RegDst,MemtoReg
   );
	wire [31:0]wAddr;
	wire [31:0]wDin;
	wire [31:0]reg_out1,reg_out2;

	Reg_File M1(
		.clk(clk),.rst_n(rst_n),
		.rAddr1(rs),.rAddr2(rt),
		.rDout1(reg_out1),.rDout2(reg_out2),
		.wAddr(wAddr[4:0]),.wDin(wDin),
		.wEna(RegWrite)
	);
	MUX_2way M2(
		.select(RegDst),.dout(wAddr),
		.din0({27'b0,rt}),.din1({27'b0,rd})
	);
	MUX_2way M3(
		.select(MemtoReg),.dout(wDin),
		.din0(alu_out),.din1(mem_out)
	);
	ABReg M4(
		.clk(clk),.rst_n(rst_n),
		.reg_out1(reg_out1),.reg_out2(reg_out2),
		.reg_A(reg_A),.reg_B(reg_B)
	);
		

endmodule
