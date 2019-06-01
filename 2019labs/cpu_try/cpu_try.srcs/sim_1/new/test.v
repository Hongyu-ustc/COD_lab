`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/12 19:19:42
// Design Name: 
// Module Name: cpu_test
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


module cpu_test();
    reg clk;
    reg rst;
	/*wire run;
	wire [31:0]addr;
	wire [31:0]pc;
    wire [31:0]mem_data;
    wire [31:0]reg_data;*/




wire PCWriteCond;
wire PCWrite;
wire lorD;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire IRWrite;
wire [1:0]PcSource;
wire [2:0]ALUOp;
wire [1:0]ALUSrcB;
wire ALUSrcA;
wire RegWrite;
wire RegDst;


wire pcctrl;
wire [5:0]i31_26;
wire [31:0]memdata;

wire [31:0]memdata1;/*
always@*
if(MemRead)
    memdata<=memdata1;
    else memdata<=memdata;*/
assign memdata=(MemRead)?memdata1:memdata;

wire [31:0]pc_out;
wire [31:0]pc_in;
wire [31:0]address;
wire [31:0]wd;
wire [4:0]wa;
wire [31:0]A_in;
wire [31:0]B_in;
wire [31:0]A_out;
wire [31:0]B_out;
wire [25:0]i25_0;
wire [4:0]i25_21;
wire [4:0]i20_16;
wire [15:0]i15_0;
wire [4:0]i15_11;
wire [5:0]i5_0;
wire [31:0]se_out;
wire [31:0]sl0_out;
wire [27:0]sl1_out;
wire [31:0]j_addr;
wire [31:0]alu_a;
wire [31:0]alu_b;
wire zero;
wire zero1;
wire [31:0]ALUOut_in;
wire [31:0]ALUOut_out;
wire [3:0]ALUcontrol;
//wire [31:0]memdata_in;
wire [31:0]memdata_out;
wire [7:0]test;
assign test=9'd267;
wire [31:0]testout;
assign pcctrl=PCWrite||(PCWriteCond&&zero1);
assign zero1=(i31_26[0])?(~zero):zero;
wire [8:0]a;
assign a=address[10:2];
assign i25_0={i25_21,i20_16,i15_0};
assign i15_11=i15_0[15:11];
assign i5_0=i15_0[5:0];
assign j_addr={pc_out[31:28],sl1_out};
dist_mem_gen_0 Mem(
	.a(a),
	.d(B_out),
	.dpra(test),
	.clk(clk),
	.we(MemWrite),
	.spo(memdata1),
	.dpo(testout)
);
PC PC(
	.clk(clk),
	.rst(rst),
	.we(pcctrl),
	.pc_in(pc_in),
	.pc_out(pc_out)
);

IF IF(  
	.clk(clk),
	.rst(rst),
	.IRWrite(IRWrite),
	.memdata(memdata),
	.i31_26(i31_26),
	.i25_21(i25_21),
	.i20_16(i20_16),
	.i15_0(i15_0)
	);

MDR MDR(              
		.clk(clk),
		.rst(rst),
		.memdata(memdata),
		.out(memdata_out)
	);
Mux_1 Mux1(
		.clk(clk),
		.lorD(lorD),
		.in0(pc_out),//pc_out ,
		.in1(ALUOut_out),//alu_out,
		.out(address)//address
	);

Mux_2 Mux2(
		.clk(clk),
		.RegDst(RegDst),
		.in0(i20_16),//i20_16,
		.in1(i15_11),//i15_11,
		.out(wa)
	);

Mux_3 Mux3(
		.clk(clk),
		.MemtoReg(MemtoReg),
		.in0(ALUOut_out),//alu_out,
		.in1(memdata_out),//memdata,
		.out(wd)//mux_out
	);
Mux_4 Mux4(
		.clk(clk),
		.ALUSrcA(ALUSrcA),
		.in0(pc_out),//PC
		.in1(A_out),//A
		.out(alu_a)
	);

Mux_5 Mux5(
		.clk(clk),
		.ALUSrcB(ALUSrcB),
		.in0(B_out),//B
		.in2(se_out),
		.in3(sl0_out), 
		.out(alu_b)
	);

Mux_6 Mux6(
	    .clk(clk),
	    .rst(rst),
		.PcSource(PcSource),
		.in0(ALUOut_in),//ALUresult
		.in1(ALUOut_out),//ALUout
		.in2(j_addr), //j_addr[31:0]
		.out(pc_in)//PC_in
	);
Regfile RF( 
		.clk(clk), 
		.rst(rst), 
		.we(RegWrite),
		.ra0(i25_21),
		.ra1(i20_16),
		.ra2(),
		.wa(wa),
		.wd(wd),
		.rd0(A_in),
		.rd1(B_in),
		.rd2()
	);

SE SE(       //sign extend
		.i15_0(i15_0),
		.out(se_out)
	);
SL_1 SL0(   //shift left 2 32:32
		.in(se_out),
		.out(sl0_out)
	);


SL_2 SL1(   //shift left 2 26:28
		.in(i25_0),
		.out(sl1_out)
	);

ALU ALU(
		.rst(rst),
		.ALUcontrol(ALUcontrol),
		.alu_a(alu_a),
		.alu_b(alu_b),
		.zero(zero),
		.alu_out(ALUOut_in)
	);
ALU_ctrl ALUctrl(
		.clk(clk),
		.i5_0(i5_0),
		.ALUOp(ALUOp),
		.out(ALUcontrol)
	);
CU CU(//control unit
		.clk(clk),
		.rst(rst),
		.op(i31_26),
		.PCWriteCond(PCWriteCond),
		.PCWrite(PCWrite),
		.lorD(lorD),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.IRWrite(IRWrite),
		.PcSource(PcSource),
		.ALUOp(ALUOp),
		.ALUSrcB(ALUSrcB),
		.ALUSrcA(ALUSrcA),
		.RegWrite(RegWrite),
		.RegDst(RegDst)
	);
reg_self A(
	.in(A_in),
	.clk(clk),
	.out(A_out)
);	
reg_self B(
	.in(B_in),
	.clk(clk),
	.out(B_out)
);
reg_self ALUOut(
	.in(ALUOut_in),
	.clk(clk),
	.out(ALUOut_out)
);	
initial clk=0;
initial rst=1;
always #5 clk=~clk;
initial 
begin
#30 rst=0;
end
endmodule
