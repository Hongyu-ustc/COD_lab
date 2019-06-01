`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/05 10:35:52
// Design Name: 
// Module Name: Regfile_test
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


module regfile_test();

parameter m = 4;
parameter n = 4;

reg clk;
reg rst;
reg we;

reg [m-1:0]ra0;
reg [m-1:0]ra1;
reg [m-1:0]wa;
reg [n-1:0]wd;
wire [n-1:0]rd0;
wire [n-1:0]rd1;

Regfile A1 (
	.clk(clk),
	.rst(rst),
	.we(we),
	.ra0(ra0),
	.ra1(ra1),
	.wa(wa),
	.wd(wd),
	.rd0(rd0),
	.rd1(rd1)
);
initial clk=0;
initial 
begin
rst=1;
#200 rst=0;
end
always #50 clk=~clk;
initial 
begin
we=1;
wa=4'b0101;
wd=4'b1101;
#100
we=0;
ra1=4'b0111;
#100
we=1;
wa=4'b0111;
wd=4'b1111;
#100
we=0;
ra0=4'b0111;
#100
we=1;
wa=4'b0101;
wd=4'b0000;
#100
we=0;
ra1=4'b0101;
#100
we=1;
wa=4'b0110;
wd=4'b1000;
#100
we=0;
ra0=4'b0110;
end

endmodule