module MEM_Part(
	input clk,rst_n,
	input [31:0]PC,DAddr,wDin,
	output [31:0]Instr,Data,
	input [0:0]IorD,MemWrite,IRWrite
   );
	wire [31:0]rDout;
	wire [31:0]Addr;
	
	MEM M1(
		.clk(clk),
		.wea(MemWrite),
		.addra(Addr[9:2]),
		.dina(wDin),
		.addrb(Addr[9:2]),
		.doutb(rDout)
	);
	MUX_2way M2(
		.din0(PC),.din1(DAddr),
		.dout(Addr),.select(IorD)
	);
	IReg M3(
		.clk(clk),.rst_n(rst_n),.en(IRWrite),
		.mem_out(rDout),.Instr(Instr)
   );
	DReg M4(
		.clk(clk),.rst_n(rst_n),
		.mem_out(rDout),.Data(Data)
   );

endmodule
