`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/27 20:49:25
// Design Name: 
// Module Name: DIV_test
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


module DIV_test();
reg [3:0]x;
reg [3:0]y;
reg rst;
reg clk;
wire [3:0]q;
wire [3:0]r;
wire error;
wire done;
DIV LO (
	.x(x),
	.y(y),
	.rst(rst),
	.clk(clk),
	.q(q),
	.r(r),
	.error(error),
	.done(done)
);
initial clk=0;
initial rst=0;
initial begin
rst=1;
#100 rst=0;
x=4'h0e;
y=4'h06;/*
#600
rst=1;
#100 rst=0;
x=4'h0d;
y=4'h06;
#600
rst=1;
#100 rst=0;
x=4'h08;
y=4'h03;*/
end
always #50 clk=~clk;
endmodule
