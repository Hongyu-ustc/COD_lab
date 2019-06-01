module Reg_File(
	input clk,rst_n,
	input [4:0] rAddr1,rAddr2,
	output reg [31:0] rDout1,rDout2,
	input [4:0] wAddr,
	input [31:0] wDin,
	input wEna
   );
	reg [31:0]reg_file[0:31];
	integer i;

	always@(posedge clk,negedge rst_n)
	begin
		if(~rst_n)
			for(i=0;i<32;i=i+1)
				reg_file[i]<=0;
		else
			if(wEna)
				reg_file[wAddr]<=wDin;
	end
	
	always@(rAddr1,rAddr2)
	begin
			rDout1=reg_file[rAddr1];
			rDout2=reg_file[rAddr2];
	end

endmodule



