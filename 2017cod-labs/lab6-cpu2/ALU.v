module ALU(
    input signed [31:0]alu_a,
	 input signed [31:0]alu_b,
    input [4:0]alu_op,
    output reg signed [31:0]alu_out
    );
	 
	 parameter A_NOP = 5'h00;
	 parameter A_ADD = 5'h01;
	 parameter A_SUB = 5'h02;
	 parameter A_AND = 5'h03;
	 parameter A_OR  = 5'h04;
	 parameter A_XOR = 5'h05;
	 parameter A_NOR = 5'h06;
	 
	 always@(*)
	 begin
		case(alu_op)
			A_NOP: alu_out=alu_out;          //nop
			A_ADD: alu_out=alu_a+alu_b;      //add
			A_SUB: alu_out=alu_a-alu_b;      //sub
			A_AND: alu_out=alu_a&alu_b;      //and
			A_OR : alu_out=alu_a|alu_b;      //or
			A_XOR: alu_out=alu_a^alu_b;      //xor
			A_NOR: alu_out=~(alu_a|alu_b);   //nor
			default: alu_out=0;
		endcase
	end

endmodule