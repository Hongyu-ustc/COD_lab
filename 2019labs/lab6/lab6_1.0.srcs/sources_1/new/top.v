`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/28 12:19:04
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input rst,
    output wire [11:0]vrgb,
	output wire hs,
	output wire vs
    );
    wire [11:0]rgb;
    wire [3:0]dir;
    wire [31:0]memdata;
    wire we;



    wire clk25;
	reg clk1hz;
	reg [24:0] count;
	always@(posedge clk25)
		begin			
			//if(count==25'd24999999)
			if(count==25'd499999)
				begin
				count<=0;
				clk1hz<=~clk1hz;
				end				
			else count<=count+1;			
		end
	clk_wiz_0 U4 (
					.clk_in1(clk),
					.clk_out1(clk25),
					.reset(rst)
					);	
   cpu U1(
       .clk(clk1hz),
       .rst(rst),
       .data(memdata)
   );
   cha U2(
       .memdata(memdata),
       .dir(dir),
       .rgb(rgb),
       .we(we)
   );
   vga U3(
        .rgb(rgb),
	    .dir(dir),
		.we(we),
		.clk25(clk25),
		.rst(rst),
		.lianxu(1),
		.vrgb(vrgb),
		.hs(hs),
		.vs(vs)
   );
endmodule

module cha(
    input [31:0] memdata,
    output reg [3:0]dir,
    output reg [11:0]rgb,
    output reg we
);
always@*
begin
    if(memdata==0)
    begin
        dir<=0;
        rgb<=12'h0;
        we<=0;
    end
    else
    begin
        rgb<=memdata[11:0];
        we<=memdata[12];
        case(memdata[15:13])
        3'b111:dir<=4'b0001;//up
        3'b100:dir<=4'b0010;//down
        3'b010:dir<=4'b0100;//left
        3'b001:dir<=4'b1000;//rignt
        default:dir<=4'b0000;//stay
        endcase
    end
end
endmodule