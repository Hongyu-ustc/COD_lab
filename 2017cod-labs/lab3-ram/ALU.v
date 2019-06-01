module ALU(
           input signed [31:0] alu_a,
           input signed [31:0] alu_b,
           input [4:0]         alu_op,
           output [31:0]   alu_out
           );

   parameter A_NOP = 5'h00;
   parameter A_ADD = 5'h01;
   parameter A_SUB = 5'h02;
   parameter A_AND = 5'h03;
   parameter A_OR = 5'h04;
   parameter A_XOR = 5'h05;
   parameter A_NOR = 5'h06;

	wire [31:0] my_alu_out[6:0];

	assign my_alu_out[A_NOP] = 0;
	assign my_alu_out[A_ADD] = alu_a + alu_b;
	assign my_alu_out[A_SUB] = alu_a - alu_b;
	assign my_alu_out[A_AND] = alu_a & alu_b;
	assign my_alu_out[A_OR] = alu_a | alu_b;
	assign my_alu_out[A_XOR] = alu_a ^ alu_b;
	assign my_alu_out[A_NOR] = ~(alu_a | alu_b);

	assign alu_out = my_alu_out[alu_op];

endmodule // ALU
