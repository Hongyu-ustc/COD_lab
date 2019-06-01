`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 15:53:39
// Design Name: 
// Module Name: vga
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


module vga(
	input [11:0]rgb,
	input [3:0]dir,
	input draw,
	input clk,
	input rst,
	output [11:0]vrgb,
	output hs,
	output vs
);
reg [15:0]pw;

reg[2:0] up;
reg[2:0] down;
reg[2:0] left;
reg[2:0] right;

	
	
	/*VRAM U1 (
		.a(a),        // input wire [15 : 0] a
		.d(d),        // input wire [11 : 0] d
		.dpra(dpra),  // input wire [15 : 0] dpra
		.clk(clk),    // input wire clk
		.we(we),      // input wire we
		.dpo(dpo)    // output wire [11 : 0] dpo
	);	*/
	
	
	VRAM U1 (
		.a(pw),        // input wire [15 : 0] a
		.d(rgb),        // input wire [11 : 0] d
		.dpra(dpra),  // input wire [15 : 0] dpra
		.clk(clk),    // input wire clk
		.we(draw),      // input wire we
		.dpo(dpo)    // output wire [11 : 0] dpo
	);
	DCU U2 (
		.vdata(dpo),
		.vaddr(dpra),
		.vrgb(vrgb),
		.hs(hs),
		.vs(vs),
		.clk(clk),
		.rst(rst)
	);
	//up
	always @ ( posedge clk  )
	up <= { up[1:0], dir[0]} ;
	wire pos_up = up[1] && ( ~up[2] );  
	 //down  
	always @ ( posedge clk  )
	down <= { down[1:0], dir[1]} ;
	wire pos_down = down[1] && ( ~down[2] );  
	//left
	always @ ( posedge clk  )
	left <= { left[1:0], dir[2]} ;
	wire pos_left = left[1] && ( ~left[2] );  
	//right
	always @ ( posedge clk  )
	right <= { right[1:0], dir[3]} ;
	wire pos_right = right[1] && ( ~right[2] ); 
	
	//assign out=(pos_enout)?regf[pr]:0; 	


always@(posedge clk or posedge rst) 
	begin
		if(rst)
		begin
			pw=128*256+127;
		end
		else
		begin
			if( pos_up)
				if(pw>=256)//up
					pw=pw-256;
			if(pos_down)
				if(pw<(65536-256))//down
					pw=pw+256;
			if(pos_left)
				if(pw%256!=0)//left
					pw=pw-1;
			if(pos_right)
				if(pw%256!=255)//right
					pw=pw+1;
		end
	end
	
endmodule


module DCU(
	input [11:0]vdata,
	output [15:0]vaddr,
	output reg [11:0]vrgb,
	output hs,
	output vs,
	input  clk,
	input rst
);

parameter UP_BOUND = 29;
parameter DOWN_BOUND = 629;
parameter LEFT_BOUND = 184;
parameter RIGHT_BOUND = 984;

    wire pclk;
	reg [1:0] count;
	reg [9:0] hcount, vcount;
	
	assign pclk = count[1];
	always @ (posedge clk or posedge rst)
	begin
		if (rst)
			count <= 0;
		else
			count <= count+1;
	end
	
	// 列计数与行同步
	assign hs = (hcount < 120) ? 0 : 1;
	always @ (posedge pclk or posedge rst)
	begin
		if (rst)
			hcount <= 0;
		else if (hcount == 1039)
			hcount <= 0;
		else
			hcount <= hcount+1;
	end
	
	// 行计数与场同步
	assign vs = (vcount < 6) ? 0 : 1;
	always @ (posedge pclk or posedge rst)
	begin
		if (rst)
			vcount <= 0;
		else if (hcount == 1039) 
		begin
			if (vcount == 665)
				vcount <= 0;
			else
				vcount <= vcount+1;
		end
		else
			vcount <= vcount;
	end
	
	// 设置显示信号值
		always @ (posedge pclk or posedge rst)
		begin
			if (rst) 
			begin
				vrgb<=0;

			end
			else if (vcount>=UP_BOUND && vcount<=DOWN_BOUND&& hcount>=LEFT_BOUND && hcount<=RIGHT_BOUND)
			begin
				vrgb<=vdata;
			end
			else 
			begin
				vrgb<=0;

			end
		end

	endmodule

