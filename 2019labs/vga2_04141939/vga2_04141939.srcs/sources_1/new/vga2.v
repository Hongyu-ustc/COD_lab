`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 19:40:36
// Design Name: 
// Module Name: vga2
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
			input we,
			input clk,
			input rst,
			output [11:0]vrgb,
			output hs,
			output vs
		);
		wire [15 : 0] dp;
		wire [11 : 0] data;	
		wire [15:0] pwi;
		//wire [11:0]rgbi;
		//assign rgbi=rgb;	
			dist_mem_gen_0 U1 (
				.a(pwi),        // input wire [15 : 0] a
				.d(rgb),        // input wire [11 : 0] d
				.dpra(dp),  // input wire [15 : 0] dpra
				.clk(clk),    // input wire clk
				.we(we),      // input wire we
				.dpo(data)    // output wire [11 : 0] dpo
			);
			DCU U2 (
				.vdata(data),
				.vaddr(dp),
				.vrgb(vrgb),
				.hs(hs),
				.vs(vs),
				.clk(clk),
				.rst(rst),
				.pw(pwi)
			);
			dir_con U3(
			.dir(dir),
	        .clk(clk),
	        .rst(rst),
            .pw(pwi)
            );
			
endmodule
	
module DCU(
			input [11:0]vdata,
			output reg [15:0]vaddr,
			output wire [11:0]vrgb,
			output hs,
			output vs,
			input clk,
			input rst,
			input [15:0] pw
		);
		assign vrgb=(pw==vaddr)?1:vdata;
		parameter UP_BOUND = 500;
		parameter DOWN_BOUND = 755;
		parameter LEFT_BOUND = 900;
		parameter RIGHT_BOUND = 1155;

		    wire pclk;
		    wire clk130;
		    clk_wiz_0 U3 (
			.clk(clk),
			.clk130(clk130));
			assign pclk=clk130;
			//reg [2:0] count;
			reg [12:0] hcount, vcount;

			assign vs = (vcount < 4) ? 0 : 1;
			assign hs = (hcount < 12)? 1 : 0;
			always @ (posedge pclk or posedge rst)
			begin
				if (rst)
				begin
					vcount <= 0;
					vaddr<=0;
				end
				else if (hcount == 1919) 
				begin
					hcount <= 0;
					if (vcount == 1079)
						begin
					         vcount <= 0;
					         vaddr<=0;
				        end
					else
						vcount <= vcount+1;
				end
				else
				begin
					hcount <= hcount+1;
					vcount <= vcount;
					if(vcount>=UP_BOUND && vcount<=DOWN_BOUND&& hcount>=LEFT_BOUND && hcount<=RIGHT_BOUND)
					vaddr<=vaddr+1;
				end
			end

			endmodule
			
			
module dir_con(
	input [3:0]dir,
	input clk,
	input rst,
	output reg [15:0]pw
);
	reg [2:0] up;
	reg [2:0] down;
	reg [2:0] left;
	reg [2:0] right;
	wire [3:0]pos_dir;
	//up
	always @ ( posedge clk  )
	up <= { up[1:0], dir[0]} ;
	assign pos_dir[0] = up[1] && ( ~up[2] );  
	 //down  
	always @ ( posedge clk  )
	down <= { down[1:0], dir[1]} ;
	assign pos_dir[1] = down[1] && ( ~down[2] );  
	//left
	always @ ( posedge clk  )
	left <= { left[1:0], dir[2]} ;
	assign pos_dir[2] = left[1] && ( ~left[2] );  
	//right
	always @ ( posedge clk  )
	right <= { right[1:0], dir[3]} ;
	assign pos_dir[3] = right[1] && ( ~right[2] ); 
	
	
always@(posedge clk or posedge rst) 
begin
		if(rst)
			pw<=32768;
		else
		case(pos_dir)
		0001:
		if(pw>=256)//up
			pw<=pw-256;
		0010:
		if(pw<(65536-256))//down
			pw<=pw+256;
		0100:
		if(pw%256!=0)//left
			pw<=pw-1;
		1000:
		if(pw%256!=255)//right
			pw<=pw+1;
		default: pw<=pw;
		endcase

end
endmodule