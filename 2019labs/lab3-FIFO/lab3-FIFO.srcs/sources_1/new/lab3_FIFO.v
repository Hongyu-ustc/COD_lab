`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/05 15:43:58
// Design Name: 
// Module Name: lab3_FIFO
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

module FIFO(en_out, en_in, in, rst, clk, out, empty, full);
	input en_out;
	input en_in;
	input [3:0] in;
	input rst;
	input clk;
	output wire [3:0] out;
	output reg empty;
	output reg full;
	
	reg [2:0]pw;
	reg [2:0]pr;
	reg [3:0] regf [7:0];
	integer i;



	reg[2:0] delay1;
	reg[2:0] delay2;
	always @ ( posedge clk  )
	delay1 <= { delay1[1:0], en_out} ;
	wire pos_enout = delay1[1] && ( ~delay1[2] );     
	always @ ( posedge clk  )
	delay2 <= { delay2[1:0], en_in} ;
	wire pos_enin = delay2[1] && ( ~delay2[2] );	
	
	
	always@(posedge clk or posedge rst) 
	begin
		if(rst)
		begin
			for(i=0;i<8;i=i+1)
					regf[i]<=0;
			full<=0;
			empty<=1;
			pw<=3'h0;
			pr<=3'h0;
		end
		else
		begin
			if( pos_enin)
				if(!full==1)
				begin
				regf[pw]<=in;
				//pw<=(pw+1)%8;
				add(pw,pw);
				if(pw==pr)
					full<=1;
				empty<=0;
				end
			 if(pos_enout)
				if(!empty==1)
				begin
				//out<=regf[pr];
				regf[pr]<=4'hF;
				//pr<=(pr+1)%8;
				add(pr,pr);
				if(pr==pw)
					empty<=1;
				full<=0;
				end
		end
	end
	assign out=(pos_enout)?regf[pr]:0;
	
	task add;
	input [2:0]a;
	output [2:0]b;
	reg [2:0]temp;
	begin
	temp=a+1;
	b=temp%8;
	end
	endtask
	
	endmodule
