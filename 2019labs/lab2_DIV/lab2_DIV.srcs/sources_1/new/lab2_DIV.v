`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/27 20:25:14
// Design Name: 
// Module Name: lab2_DIV
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


module DIV(
input [3:0]x,
input [3:0]y,
input  rst,
input  clk,
output reg [3:0]q,
output reg [3:0]r,
output reg error,
output reg done
);
reg [3:0] x1;
reg [3:0] y1;
reg [3:0] t;
reg [3:0] state; 

parameter IN=4'b0000;
parameter WO=4'b0001;
parameter ERR=4'b0010;
parameter OUT=4'b0011;

always@(posedge clk)
begin
if(rst==1) 
begin
state<=OUT;
end
else
case(state)
IN:
	begin
	t<=4'b0000;
	q<=4'b0000;
	r<=4'b0000;
	done<=0;
	error<=0;
	if(y==4'b0000)
		state<=ERR;
	else
	if(x>=y)
	begin
		state<=WO;
		x1<=x;
	    y1<=y;
	end
	else
	begin
	   x1<=x;
	   state<=OUT;
	end
	end
ERR:
	begin
	q<=4'b0000;
	r<=4'b0000;
	error<=1;
	state<=IN;
	end
WO:
	begin
	//x1=x1-y1;
	//t=t+4'b0001;
	wo(x1,y1,t);
	if(x1>=y1)
		state<=WO;
	else 
		state<=OUT;
	end
OUT:
	begin
	q<=t;
	r<=x1;
	done<=1;
	state<=IN;
	end
default:state<=ERR;
endcase
end

task wo;
inout [3:0]a;
inout [3:0]b;
inout [3:0]c;
reg [3:0] temp;
begin
	temp=a-b;
	a=temp;
	c=c+4'b0001;
end
endtask
endmodule
