```verilog
module FIFO(en_out, en_in, in, rst, clk, out, empty, full, seg, dp, an);
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
	reg [2:0]j;
	wire clk_out1;
	wire f50hz;


    clk_wiz_0 A3 (.clk_out1(clk_out1), .clk_in1(clk));
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
					regf[i]<=4'hF;
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
				//pr<=(pr+1)%8;
				regf[pr]<=4'hF;
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

div A5 (.clk_out1(clk_out1),  .f50hz(f50hz));   
	   
	output reg [6:0] seg;
	output reg dp;
	output reg [7:0] an;  
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
     add(j,j);

   
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
if(j==pr)
    dp<=0;
   else
   dp<=1;
end	
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
default: seg<=7'b1111111;
endcase
endmodule
```
