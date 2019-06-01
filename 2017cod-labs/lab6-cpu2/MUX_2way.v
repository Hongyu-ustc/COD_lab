module MUX_2way(
   input [0:0]select,
	input [31:0]din0,din1,
	output reg [31:0]dout
   );

	always@(*)
	begin
		case(select)
			1'b0: dout = din0;
			1'b1: dout = din1;
			default: dout = 32'bx;
		endcase
	end

endmodule
