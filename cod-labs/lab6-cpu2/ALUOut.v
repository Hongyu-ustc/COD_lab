module ALUOut(
	input clk,rst_n,
	input [31:0]alu_result,
	output reg [31:0]alu_out
   );

	always@(posedge clk, negedge rst_n)
	begin
		if(~rst_n) alu_out <= 32'bx;
		else alu_out <= alu_result;
	end

endmodule