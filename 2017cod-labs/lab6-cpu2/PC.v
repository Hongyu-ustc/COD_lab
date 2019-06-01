module PC(
	input clk,rst_n,en,
	input [31:0]PCin,
	output reg [31:0]PCout
    );

	always@(posedge clk,negedge rst_n)
	begin
		if(~rst_n) PCout <= 0;
		else if(en) PCout <= PCin;
		else PCout <= PCout;
	end

endmodule
