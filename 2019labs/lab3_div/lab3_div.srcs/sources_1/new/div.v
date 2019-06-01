`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/05 22:10:17
// Design Name: 
// Module Name: div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module div(clk,f50hz,reset);
    input clk,reset;
	output  reg f50hz;
	wire clk_out1;
	reg [19:0] j;
	clk_wiz A3 (.clk_out1(clk_out1),.clk_in1(clk));
	always@(posedge clk_out1)
	if(!reset)
	begin
	f50hz<=0;
	j<=0;
	end
	else
     begin
	   if(j==99999)
	       begin
	       j<=0;
	       f50hz<=~f50hz;
	       end
	  else
	       j<=j+1;
	 end	
endmodule
