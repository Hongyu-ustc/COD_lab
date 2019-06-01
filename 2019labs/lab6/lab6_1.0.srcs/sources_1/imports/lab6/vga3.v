`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/15 20:20:17
// Design Name: 
// Module Name: vga3
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
									input clk25,
									input rst,
									input lianxu,
									output [11:0]vrgb,
									output hs,
									output vs
								);
								wire [15 : 0] dp;
								wire [11 : 0] data;	
								wire [15 : 0] pwi;
							    //wire clk25;
								/*clk_wiz_0 U5 (
									.clk(clk),
									.clk25(clk25));*/
								dist_mem_gen_0 U1 (
										.a(pwi),        // input wire [15 : 0] a
										.d(rgb),        // input wire [11 : 0] d
										.dpra(dp),  // input wire [15 : 0] dpra
										.clk(clk25),    // input wire clk
										.we(we),      // input wire we
										.dpo(data)    // output wire [11 : 0] dpo
									);
									DCU U2 (
										.vdata(data),
										.vaddr(dp),
										.vrgb(vrgb),
										.hs(hs),
										.vs(vs),
										.clk(clk25),
										.rst(rst),
										.pw(pwi)
									);
									dir_con0 U3(
									.dir(dir),
							        .clk(clk25),
							        .rst(rst),
						            .pw(pwi),
									.lianxu(lianxu)
						            );
						            
						endmodule
							
						module DCU(
									input [11:0]vdata,
									output reg [15:0]vaddr,
									output reg [11:0]vrgb,
									output hs,
									output vs,
									input clk,
									input rst,
									input [15:0] pw
								);
								wire draw;
								wire active;
								wire x;
								
								parameter       
										C_H_SYNC_PULSE      =   96  , 
										C_H_BACK_PORCH      =   48  ,
										C_H_ACTIVE_TIME     =   640 ,
										C_H_FRONT_PORCH     =   16  ,
										C_H_LINE_PERIOD     =   800 ;
								
								parameter       
										C_V_SYNC_PULSE      =   2   , 
										C_V_BACK_PORCH      =   33  ,
										C_V_ACTIVE_TIME     =   480 ,
										C_V_FRONT_PORCH     =   10  ,
										C_V_FRAME_PERIOD    =   525 ;
								parameter UP_BOUND = C_V_SYNC_PULSE + C_V_BACK_PORCH ;
								parameter DOWN_BOUND = C_V_FRAME_PERIOD - C_V_FRONT_PORCH;
								parameter LEFT_BOUND = C_H_SYNC_PULSE + C_H_BACK_PORCH;
								parameter RIGHT_BOUND = C_H_LINE_PERIOD - C_H_FRONT_PORCH;
								parameter UP = 100;
								parameter DOWN = 356;
								parameter LEFT = 300;
								parameter RIGHT = 556;

									wire pclk;
									assign pclk=clk;
									reg [12:0] hcount, vcount;
			                        assign draw=(vcount>=UP && vcount<DOWN && hcount>=LEFT && hcount<RIGHT)?1:0;
								    assign active=(vcount>=UP_BOUND && vcount<DOWN_BOUND&& hcount>=LEFT_BOUND && hcount<RIGHT_BOUND)?1:0;
								    assign x=(pw==vaddr || pw-255==vaddr || pw-257==vaddr || pw+255==vaddr || pw+257==vaddr)?1:0;
									assign vs = (vcount < C_V_SYNC_PULSE )? 0 : 1;
									assign hs = (hcount < C_H_SYNC_PULSE )? 0 : 1;
									always @ (posedge pclk or posedge rst)
									begin
										if (rst)
										begin
											vcount <= 0;
											vaddr <= 0;
										end
										else if (hcount == C_H_LINE_PERIOD -1) 
										begin
											hcount <= 0;
											if (vcount == C_V_FRAME_PERIOD -1)
												begin
											         vcount <= 0;
											         vaddr <= 0;
										        end
											else
												vcount <= vcount+1;
										end
										else
										begin
											hcount <= hcount+1;
											vcount <= vcount;
											if(draw)
											vaddr<=vaddr+1;
										end
									end
									
									always @ (*)
									begin
										if(active)
										begin
										if(draw)
										     if(x)
										         vrgb<=0;
										     else
											    vrgb<=vdata;
										else vrgb<=0;
										end
										else vrgb<=0;
									end
				endmodule
									
									
				module dir_con0(
							input [3:0]dir,
							input clk,
							input rst,
							output  [15:0]pw,
							input lianxu
						);
							reg [2:0] up;
							reg [2:0] down;
							reg [2:0] left;
							reg [2:0] right;
							wire [3:0]pos_dir;
							reg clk1hz;
							reg [24:0] count;
							reg [15:0]pw1;
							reg [15:0]pw2;
							always@(posedge clk)
							begin			
								//if(count==25'd24999999)
								if(count==25'd99999)
								//if(count==25'd2499999)
								    begin
									count<=0;
									clk1hz<=~clk1hz;
									end				
								else count<=count+1;			
							end
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
							
							
						//always@(posedge clk or posedge rst)
						always@(posedge clk or posedge rst) 
						begin
								if(rst)
								begin
									pw1<=16'd32895;
								end
								else
								case(pos_dir)
								//case (dir)
								4'b0001:
								if(pw>=16'd256)//up
									pw1<=pw-16'd256;
								4'b0010:
								if(pw<(16'd65280))//down
									pw1<=pw+16'd256;
								4'b0100:
								if(pw%16'd256!=0)//left
									pw1<=pw-16'd1;
								4'b1000:
								if(pw%16'd256!=16'd255)//right
									pw1<=pw+16'd1;
								default: pw1<=pw;
								endcase
						end
						
						always@(posedge clk1hz or posedge rst) 
						//always@(posedge clk1hz)
						begin
								if(rst)
									pw2<=16'd32895;//32768+127
								else
								//case(pos_dir)
								case (dir)
								4'b0001:
								if(pw>=16'd256)//up
									pw2<=pw-16'd256;
								4'b0010:
								if(pw<(16'd65280))//down
									pw2<=pw+16'd256;
								4'b0100:
								if(pw%16'd256!=0)//left
									pw2<=pw-16'd1;
								4'b1000:
								if(pw%16'd256!=16'd255)//right
									pw2<=pw+16'd1;
								default: pw2<=pw;
								endcase
						end
						wire [15:0]pw11;
						assign pw11=pw1;
						wire [15:0]pw22;
						assign pw22=pw2;
						assign pw=(lianxu)?pw22:pw11;
						/*always@(posedge clk or posedge rst)
						begin
						if(rst)
						  pw<=32768+127;
						else
						 case(lianxu)
						 1:pw<=pw2;
						 0:pw<=pw1;
						 default:pw<=pw;
						 endcase
						end*/
						endmodule
