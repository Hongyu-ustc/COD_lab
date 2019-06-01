`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 20:15:18
// Design Name: 
// Module Name: REG-file
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


module REG_file(
input    wire  clk,
input    wire   rst,
input    wire        en,
input    wire [5:0]  in,
output   reg  [5:0]	 out
);
always @ (posedge clk or posedge rst)
if(rst ==1)
    out<=0;
else if(en==1)
   out<=in;
endmodule
