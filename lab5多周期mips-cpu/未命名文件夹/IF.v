module IF(              //instruction fetch
	input clk,
	input rst,
	input IRWrite,
	input [31:0] memdata,
	output reg[5:0] i31_26,
	output reg[4:0] i25_21,
	output reg[4:0] i20_16,
	output reg[15:0] i15_0
);
always@(posedge clk or posedge rst)
begin
if(rst)
	begin
	i31_26<=6'bx;
	i25_21<=5'bx;
	i20_16<=5'bx;
	i15_0<=16'bx;
	end
else
	if(IRWrite)
	begin
		i31_26<= memdata[31:26];
		i25_21<= memdata[25:21];
		i20_16<= memdata[20:16];
		i15_0<= memdata[15:0];
		end
	else
	begin
		i31_26<=i31_26;
		i25_21<=i25_21;
		i20_16<=i20_16;
		i15_0<=i15_0;
		end
end
endmodule