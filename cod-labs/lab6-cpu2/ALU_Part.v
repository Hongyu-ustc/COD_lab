module ALU_Part(
	input clk,rst_n,
	input [31:0]reg_A,reg_B,
	input [31:0]PC,
	input signed [31:0]Imm,
	output [31:0]alu_result,alu_out,
	input [4:0]ALUControl,
	input [0:0]ALUSrcA,
	input [1:0]ALUSrcB,
	output Zero
   );
	wire [31:0]alu_a,alu_b;
	wire [31:0]four;
	wire [31:0]ImmBranch;
	
	assign four = 4;
	assign ImmBranch = Imm<<2;
	assign Zero = alu_a>0 ? 1 : 0;

	ALU M1(
		.alu_a(alu_a),.alu_b(alu_b),
		.alu_op(ALUControl),.alu_out(alu_result)
	);
	MUX_2way M2(
		.select(ALUSrcA),.dout(alu_a),
		.din0(PC),.din1(reg_A)
	);
	MUX_4way M3(
		.select(ALUSrcB),.dout(alu_b),
		.din0(reg_B),.din1(four),
		.din2(Imm),.din3(ImmBranch)
	);
	ALUOut M4(
		.clk(clk),.rst_n(rst_n),
		.alu_result(alu_result),
		.alu_out(alu_out)
   );

endmodule
