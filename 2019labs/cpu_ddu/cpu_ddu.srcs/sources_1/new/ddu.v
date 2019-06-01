module ddu(
    input clk,
	input rst,
	input inc,
	input dec,
	output run,
	output reg [7:0] addr
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

module top(
    input clk,
    input rst,
    input mem,
    input inc,
    input dec,
    output wire [15:0]led,
    output reg [7:0]an,
    output reg [6:0]seg
);
    wire clk0;
    wire clk1;
    assign clk0=clk;
    assign clk1=clk;
	wire [31:0]data;
	wire [7:0] addr;
	wire [7:0]pc;
	assign led[7:0]=pc;
	assign led[15:8]=addr;
	reg [2:0]j;
	wire clk25;
	reg clk_out1;
	reg clk1hz;
	wire f50hz;
	reg [24:0] count;
	reg [3:0]count1;
	always@(posedge clk25)
		begin			
								//if(count==25'd24999999)
								//if(count==25'd499999)
								if(count==25'd2499999)
								    begin
									count<=0;
									clk1hz<=~clk1hz;
									end				
								else count<=count+1;			
		end
	clk_wiz_0 U4 (
					.clk_in1(clk0),
					.clk_out1(clk25),
					.reset(rst)
					);		
   /* clk_wiz_1 U5(
    .clk_in1(clk1),
    .clk_out1(clk_out1),
    .reset(rst)
    );	*/		
    		always@(posedge clk25)
		begin			
								if(count1==4'd5)
								//if(count==25'd499999)
								//if(count==25'd2499999)
								    begin
									count1<=0;
									clk_out1<=~clk_out1;
									end				
								else count1<=count1+1;			
		end			
	cpu U1(
	.clk(clk1hz),
	.rst(rst),
	.mem(mem),
	.addr(addr),
	.pc_ddu(pc),
	.data(data)
	);
	ddu U2(  
	 .clk(clk1hz),
	.rst(rst),
	.inc(inc),
	.dec(dec),
	.run(),
	.addr(addr)	
	);
	
	div A5 (.clk_out1(clk_out1),  .f50hz(f50hz));   

wire [6:0] segf [8:0];

seg_ctrl A6(data[3:0],segf[0]);
seg_ctrl A7(data[7:4],segf[1]);	
seg_ctrl A16(data[11:8],segf[2]);		
seg_ctrl A26(data[15:12],segf[3]);	
seg_ctrl A36(data[19:16],segf[4]);	
seg_ctrl A46(data[23:20],segf[5]);	
seg_ctrl A56(data[27:24],segf[6]);	
seg_ctrl A76(data[31:28],segf[7]);
always@(posedge f50hz)
if(rst)
    j<=0;
else
	j<=(j+1)%8;   
//always@(posedge f50hz)
always@*
begin  
case(j)
3'h7:an=8'b01111111;
3'h6:an=8'b10111111;
3'h5:an=8'b11011111;
3'h4:an=8'b11101111;
3'h3:an=8'b11110111;
3'h2:an=8'b11111011;
3'h1:an=8'b11111101;
3'h0:an=8'b11111110;
default: an=8'b00000000;
endcase
seg<=segf[j];
end
endmodule
module div(
    input clk_out1,
    output reg f50hz
    );
	reg [12:0]j;
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
always@*
case(x)
4'h0:seg=7'b0000001;
4'h1:seg=7'b1001111;
4'h2:seg=7'b0010010;
4'h3:seg=7'b0000110;
4'h4:seg=7'b1001100;
4'h5:seg=7'b0100100;
4'h6:seg=7'b0100000;
4'h7:seg=7'b0001111;
4'h8:seg=7'b0000000;
4'h9:seg=7'b0000100;
4'ha:seg=7'b0001000;
4'hb:seg=7'b1100000;
4'hc:seg=7'b1110010;
4'hd:seg=7'b1000010;
4'he:seg=7'b0110000;
4'hf:seg=7'b0111000;
default: seg<=7'b0000001;
endcase
endmodule