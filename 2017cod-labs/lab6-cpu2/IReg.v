module IReg(
	input clk,rst_n,en,
	input [31:0]mem_out,
	output reg [31:0]Instr
   );

	always@(*)
	begin
		if(~rst_n) Instr = 32'bx;
		else if(en) Instr = mem_out;
		else Instr = Instr;
	end

endmodule
