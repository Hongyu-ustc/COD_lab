`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/27 17:32:57
// Design Name: 
// Module Name: SRT
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


module SRT(
	input [3:0] x0,
	input [3:0] x1,
	input [3:0]	x2,
	input [3:0] x3,
	input rst,
	input clk,
	output reg [3:0] s0,
	output reg [3:0] s1,
	output reg [3:0] s2,
	output reg [3:0] s3,
	output reg done
);
/*reg [3:0] t0;
reg [3:0] t1;
reg [3:0] t2;
reg [3:0] t3;*/
reg [3:0] state; 
parameter READY=4'h00;
parameter IN=4'h01;
parameter CMP1=4'h02;
parameter CMP2=4'h03;
parameter CMP3=4'h04;
parameter CMP4=4'h05;
parameter CMP5=4'h06;
parameter CMP6=4'h07; 


always@(posedge clk)
begin
if(rst==1)
    begin
	state<=4'b0;
	done<=0;
	end
else 
case(state)
IN:
	begin
	s0<=x0;
	s1<=x1;
	s2<=x2;
	s3<=x3;
	state<=CMP1;
	end
CMP1:
	begin
	sort(s0,s1);
	state<=CMP2;
	end
CMP2:
	begin
	sort(s1,s2);
	state<=CMP3;
	end
CMP3:
	begin
	sort(s2,s3);
	state<=CMP4;
	end
CMP4:
	begin
	sort(s0,s1);
	state<=CMP5;
	end
CMP5:
	begin
	sort(s1,s2);
	state<=CMP6;
	end
CMP6:
	begin
	sort(s0,s1);
	state<=READY;
	done<=1;
	end
READY:
	begin
	s0<=4'b0;
	s1<=4'b0;
	s2<=4'b0;
	s3<=4'b0;
	state<=IN;
	done<=0;
	end
default:
	state<=READY;
endcase
end

task sort;
 inout  [3:0]a;
 inout  [3:0]b;
 reg [3:0]temp;
if(a>b)
begin
temp=a;
a=b;
b=temp;
end
endtask

endmodule



