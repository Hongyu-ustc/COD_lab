module MUX(
	input [0:0]select,
	input [31:0]din0,din1,
	output reg [31:0]dout
   );

	always@(*)
	begin
		if(select==0) dout=din0;
		else dout=din1;
	end

endmodule
