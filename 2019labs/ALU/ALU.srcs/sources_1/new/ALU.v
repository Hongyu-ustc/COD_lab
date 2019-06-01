`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/21 18:31:57
// Design Name: 
// Module Name: ALU
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


module ALU(
  input  	   [5:0]	a,
  input  	   [5:0]	b,
  input	        [2:0]	s,
  output     reg [5:0]	y,
  output     reg [2:0] f
);


parameter	A_NOP = 3'h00;	
parameter	A_ADD = 3'h01;
parameter	A_SUB = 3'h02;
parameter	A_AND = 3'h03;
parameter	A_OR  = 3'h04;
parameter	A_XOR = 3'h05;
parameter	A_NOR = 3'h06;
parameter  A_LAT = 3'h07;

always@(*)
begin
case (s)
	A_NOP: 
	begin y = 6'b0;f = 0; end
	A_ADD:
	begin
	y = a + b;
	if ((a[5]==0&&b[5]==0&a[4]==1&b[4]==1)//两正数相加溢出
	|(a[5]==1&&b[5]==1&a[4]==1&b[4]==1))// 两fu数相加溢出
	f=1;
	else f=0;
	end
	A_SUB:
	begin
	y = a - b;
	if ((a[5]==1&&b[5]==0&a[4]==1&b[4]==1)//不同符号数相减溢出
	|(a[5]==0&&b[5]==1&a[4]==1&b[4]==1))
	f=1;
	else f=0;
	end
	A_AND: begin y = a & b; f=0;end
	A_OR : begin y = a | b; f=0;end
	A_XOR: begin y = a ^ b; f=0;end
	A_NOR: begin y = a ~^ b; f=0;end
	A_LAT: 
	begin
	if (a > b) 
	begin y=1; f=0; end
	else if (a < b)
	begin y=0; f=0; end
	else 
	begin y=0; f=1; end//when equal f=1
	end
endcase
end
endmodule
