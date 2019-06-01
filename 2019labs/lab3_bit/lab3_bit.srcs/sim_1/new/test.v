`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/05 21:07:59
// Design Name: 
// Module Name: test
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


module FIFO_test();
reg en_out;
reg en_in;
reg [3:0] in;
reg rst;
reg clk;
wire [3:0] out;
wire empty;
wire full;
wire [6:0]seg;
wire dp;
wire [7:0] an;  

FIFO A2 (
	.en_out(en_out),
	.en_in(en_in),
	.in(in),
	.rst(rst),
	.clk(clk),
	.out(out),
	.empty(empty),
	.full(full),
	.seg(seg),
	.dp(dp),
	.an(an)
);

initial clk=0;
initial en_in=0;
initial en_out=0;
always #45 clk=~clk;
initial 
begin
rst=1;
#200 rst=0;
end
initial
begin
#100
en_in=1;
in=4'h2;
#100
en_in=0;
#200
en_in=1;
in=4'h3;
#100
en_in=0;
#200
en_in=1;
in=4'h5;
#100
en_in=0;
#200
en_out=1;
#100
en_out=0;
#200
en_in=1;
in=4'h1;
#100
en_in=0;
#200
en_in=1;
in=4'h2;
#100
en_in=0;
#200
en_in=1;
in=4'h3;
#100
en_in=0;
#200
en_in=1;
in=4'h4;
#100
en_in=0;
#200
en_in=1;
in=4'h8;
#100
en_in=0;
#200
en_in=1;
in=4'h9;
#100
en_in=0;
#200
en_in=1;
in=4'h6;
#100
en_in=0;
#200
en_in=1;
in=4'h2;
#100
en_in=0;
#200
en_out=1;
#100
en_out=0;
en_in=1;
#100
en_in=0;
#200
en_out=1;
#100
en_out=0;
end
endmodule
