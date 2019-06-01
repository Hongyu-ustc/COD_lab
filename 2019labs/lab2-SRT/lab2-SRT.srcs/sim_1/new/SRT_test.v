`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/27 18:37:08
// Design Name: 
// Module Name: SRT_test
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


module SRT_test();
	reg [3:0] x0,x1,x2,x3;
	reg rst;
	reg clk;
    wire [3:0] s0,s1,s2,s3;
    wire done;
	SRT LU (
		.x0(x0),
		.x1(x1),
		.x2(x2),
		.x3(x3),
		.rst(rst),
		.clk(clk),
		.s0(s0),
		.s1(s1),
		.s2(s2),
		.s3(s3),
		.done(done)
	);
	initial clk=0;
	initial rst=1;
	always #100 clk=~clk;
	initial 
	begin
	x0=4'b0101;
	x1=4'b1101;
	x2=4'b1110;
	x3=4'b0100;
	end
	initial
	begin
	#150 rst=0;
	#1000 rst=1;
	#300 rst=0;
	end
	endmodule
