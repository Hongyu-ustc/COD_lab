module PC_Part(
	input clk,rst_n,
	input [31:0]PCPlus4,PCBranch,PCJump,
	output [31:0]PC,
	input [0:0]PCWrite,Branch,Zero,
	input [1:0]PCSrc
   );
	wire [31:0]PCSel;
	wire [0:0]PCEn;

	assign PCEn = (Branch & Zero) | PCWrite;
	PC M1(
		.clk(clk),.rst_n(rst_n),.en(PCEn),
		.PCin(PCSel),.PCout(PC)
   );
	MUX_3way M2(
		.din0(PCPlus4),.din1(PCBranch),.din2(PCJump),
		.dout(PCSel),.select(PCSrc)
	);

endmodule
