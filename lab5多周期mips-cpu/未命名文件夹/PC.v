module PC(
	input clk,
	input rst,
	input we,
	input [31:0] pc_in,
	output reg[31:0] pc_out
);
always@(posedge clk or posedge rst)
begin
if(rst)
	pc_out<=0;
else
	if(we)
		pc_out<=pc_in;
	else
		pc_out<=pc_out;
end

endmodule