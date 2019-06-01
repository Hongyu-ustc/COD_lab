module DDU(
    input clk,
	input rst,
	input cont,
	input step,
	input  wire mem,
	input inc,
	input dec,
	//input [7:0]pc,
	//input [31:0] mem_data,
	//input [31:0] reg_data,
	output run,
	output reg [7:0] addr,
	output [15;0]led,//pc + addr
	output [7:0]an,//reg_data/mem_data
	output [6:0]seg
);

	wire [31:0]data;
	wire [7:0] addr_in,
	wire [7:0]pc;
	assign addr_in=addr;
	cpu U1(
	.clk(clk),
	.rst(rst),
	.run(),
	.mem(mem),
	.addr(addr_in),
	.pc_ddu(pc),
	.data(data)
	);
	always@(posedge clk or posedge rst)
	if(rst) addr<=0;
	else begin
		if(inc)
			addr=addr+1;
		else if(dec)
			addr<=addr-1;
		end


endmodule


div A5 (.clk_out1(clk_out1),  .f50hz(f50hz));   

wire [6:0] segf [8:0];

seg_ctrl A6(regf[0],segf[0]);
seg_ctrl A7(regf[1],segf[1]);	
seg_ctrl A8(regf[2],segf[2]);	
seg_ctrl A16(regf[3],segf[3]);		
seg_ctrl A26(regf[4],segf[4]);	
seg_ctrl A36(regf[5],segf[5]);	
seg_ctrl A46(regf[6],segf[6]);	
seg_ctrl A56(regf[7],segf[7]);	
always@(posedge f50hz)
if(rst)
    j<=0;
else
	j<=(j+1)%8;

   
always@(posedge f50hz)
begin  
case(j)
3'h0:an<=8'b01111111;
3'h1:an<=8'b10111111;
3'h2:an<=8'b11011111;
3'h3:an<=8'b11101111;
3'h4:an<=8'b11110111;
3'h5:an<=8'b11111011;
3'h6:an<=8'b11111101;
3'h7:an<=8'b11111110;
default: an<=8'b00000000;
endcase
seg<=segf[j];

endmodule

module div(clk_out1,f50hz);
    input clk_out1;
	output reg f50hz;
	reg [12:0] j;
	always@(posedge clk_out1)
     begin
	   if(j==999)
	       begin
	       j<=0;
	       f50hz<=~f50hz;
	       end
	  else
	       j<=j+1;
	 end	
endmodule

module seg_ctrl(x,seg);
input [3:0]x;
output reg [6:0]seg;
always@(x)
case(x)
4'h0:seg<=7'b0000001;
4'h1:seg<=7'b1001111;
4'h2:seg<=7'b0010010;
4'h3:seg<=7'b0000110;
4'h4:seg<=7'b1001100;
4'h5:seg<=7'b0100100;
4'h6:seg<=7'b0100000;
4'h7:seg<=7'b0001111;
4'h8:seg<=7'b0000000;
4'h9:seg<=7'b0000100;
//default: seg<=7'b1100011;
default: seg<=7'b1111111;
endcase
endmodule