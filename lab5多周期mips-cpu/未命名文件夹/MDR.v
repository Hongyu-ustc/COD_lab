module MDR(               //memory data register
	input clk,
	input rst,
	input [31:0] memdata,
	output reg[31:0] out
);
always@(posedge clk or posedge rst)
begin
if(rst)
	out<=31'bx;
else
	out<=memdata;
end
endmodule