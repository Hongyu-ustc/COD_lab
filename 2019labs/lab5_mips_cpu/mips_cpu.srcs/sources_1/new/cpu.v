`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/10 09:38:47
// Design Name: 
// Module Name: cpu
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
	input rst
	//input run,
	//input [31:0]addr,
	//output [31:0]pc,
	//output [31:0]mem_data,
	//output [31:0]reg_data
);





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
wire [7:0]a;
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
assign test=8'b00000010;
wire [31:0]testout;
assign pcctrl=PCWrite||(PCWriteCond&&zero1);
assign zero1=(i31_26[0])?(~zero):zero;
assign a=address[9:2];
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
endmodule



module PC(
	input clk,
	input rst,
	input we,
	input  [31:0] pc_in,
	output reg [31:0] pc_out
);
always@(posedge clk or posedge rst )
//always@ (negedge clk or posedge rst)
begin
if(rst)
	pc_out<=0;
else
	if(we)
		pc_out<=pc_in;
	else
		pc_out<=pc_out;
end

endmodule




module IF(              //instruction fetch
	input clk,
	input rst,
	input IRWrite,
	input [31:0] memdata,
	output reg[5:0] i31_26,
	output reg[4:0] i25_21,
	output reg[4:0] i20_16,
	output reg[15:0] i15_0
);

//always@*
always@(posedge clk or posedge rst)
begin
if(rst)
	begin
	i31_26<=6'bx;
	i25_21<=5'bx;
	i20_16<=5'bx;
	i15_0<=16'bx;
	end
else
	if(IRWrite)
	begin
		i31_26<= memdata[31:26];
		i25_21<= memdata[25:21];
		i20_16<= memdata[20:16];
		i15_0<= memdata[15:0];
		end
	else
	begin
		i31_26<=i31_26;
		i25_21<=i25_21;
		i20_16<=i20_16;
		i15_0<=i15_0;
		end
end
endmodule

module MDR(               //memory data register
	input clk,
	input rst,
	input [31:0] memdata,
	output reg[31:0] out
);
always@(posedge clk or posedge rst)
begin
if(rst)
	out<=32'bx;
else
	out<=memdata;
end
endmodule




module Mux_1(
	input clk,
	input lorD,
	input [31:0] in0,//pc_out ,
	input [31:0] in1,//alu_out,
	output wire[31:0] out//address
);
assign out=(lorD)?in1:in0;
endmodule



module Mux_2(
	input clk,
	input RegDst,
	input [4:0] in0,//i20_16,
	input [4:0] in1,//i15_11,
	output wire[4:0] out
);
assign out = RegDst ? in1 : in0;
endmodule

module Mux_3(
	input clk,
	input MemtoReg,
	input [31:0] in0,//alu_out,
	input [31:0] in1,//memdata,
	output wire[31:0] out//mux_out
);
assign out = MemtoReg ? in1 : in0;
endmodule

module Mux_4(
	input clk,
	input ALUSrcA,
	input [31:0]in0,//PC
	input [31:0]in1,//A
	output wire[31:0]out
);
assign out = ALUSrcA? in1 : in0;
endmodule

module Mux_5(
	input clk,
	input [1:0]ALUSrcB,
	input [31:0]in0,
	input [31:0]in2,
	input [31:0]in3, 
	output wire[31:0]out
);

 assign out = ALUSrcB[1] ? (ALUSrcB[0] ? in3 : in2) : (ALUSrcB[0] ? 32'd4 : in0);
endmodule


module Mux_6(
    input clk,
    input rst,
	input [1:0]PcSource,
	input [31:0]in0,//ALUresult
	input [31:0]in1,//ALUout
	input [31:0]in2, //addr[31:0]
	output wire[31:0]out//PC_in
);
 assign out = PcSource[1] ? (PcSource[0] ? 0 : in2) : (PcSource[0] ? in1 : in0);
endmodule




module Regfile( clk, rst, we, ra0,ra1,ra2,wa,wd,rd0,rd1,rd2);
	
parameter m = 5;
parameter n = 32;
parameter regnum = 1<<m;

input clk;
input rst;
input we;            //RegWrite
input [m-1:0]ra0;
input [m-1:0]ra1;
input [m-1:0]ra2;
input [m-1:0]wa;
input [n-1:0]wd;
output wire [n-1:0]rd0;
output wire [n-1:0]rd1;
output wire [n-1:0]rd2;
reg [n-1:0] regf [regnum-1:0];
integer i;
initial 
	for(i=0;i<regnum;i=i+1)
		regf[i]<=0;
always@(posedge clk or posedge rst) 
begin
    regf[0]=0;
	if(rst)
		for(i=0;i<regnum;i=i+1)
				regf[i]<=0;
	else
		if(we)
			regf[wa]<=wd;
end
assign rd0 = regf[ra0];
assign rd1 = regf[ra1];
assign rd2 = regf[ra2];
endmodule






module SE(       //sign extend
	input [15:0] i15_0,
	output [31:0] out
);
assign out=(i15_0[15])?{16'b1111_1111,i15_0}:{16'b0000_0000,i15_0};
endmodule





module SL_1(   //shift left 2
	input [31:0] in,
	output [31:0] out
);
assign out=in<<2;
endmodule


module SL_2(   //shift left 2
	input [25:0] in,
	output [27:0] out
);
assign out={in,2'b00};
endmodule

module ALU(
	input rst,
	input [3:0]ALUcontrol,
	input [31:0]alu_a,
	input [31:0]alu_b,
	output zero,
	output reg[31:0]alu_out
);
 always@(*)
 begin
	case(ALUcontrol)
		4'b0000: alu_out<=alu_a+alu_b;      //add
		4'b0001: alu_out<=alu_a-alu_b;      //sub
		4'b0010: alu_out<=alu_a&alu_b;      //and
		4'b0011: alu_out<=alu_a|alu_b;      //or
		4'b0100: alu_out<=alu_a^alu_b;      //xor
		4'b0101: alu_out<=~(alu_a|alu_b);   //nor
		4'b0110: if(alu_a<alu_b) alu_out<=1; else alu_out<=0;//slt		
		default: alu_out<=alu_out;
	endcase
end
assign zero=(alu_out)?0:1;
endmodule



module ALU_ctrl(
	input clk,
	input [5:0]i5_0,
	input [2:0]ALUOp,
	output reg [3:0]out
);
parameter iadd =6'b100000;
parameter isub =6'b100010;
parameter iand =6'b100100;
parameter ior  =6'b100101;
parameter islt =6'b101010;
parameter ixor =6'b100110;
parameter inor =6'b100111;
 always@(*)
 begin
		case(ALUOp)
		3'b000: out <= 4'b0000;  
		3'b001: out <= 4'b0001;      
		3'b010: 
			case(i5_0)
			iadd: out <= 4'b0000;       
			iand: out <= 4'b0010; 
			inor: out <= 4'b0101; 
			ior : out <= 4'b0011; 	
			islt: out <= 4'b0110; 
			isub: out <= 4'b0001; 
			ixor: out <= 4'b0100; 
			default: out <= 4'b0000;
			endcase
		3'b011: out <= 4'b0010; 
		3'b100: out <= 4'b0011; 
		3'b101: out <= 4'b0110; 
		3'b110: out <= 4'b0100; 
		default: out <= 4'b0000;
		endcase
end
endmodule

module CU(//control unit
	input clk,
	input rst,
	input [5:0] op,
	output reg PCWriteCond,
	output reg PCWrite,
	output reg lorD,
	output reg MemRead,
	output reg MemWrite,
	output reg MemtoReg,
	output reg IRWrite,
	output reg [1:0]PcSource,
	output reg [2:0]ALUOp,
	output reg [1:0]ALUSrcB,
	output reg ALUSrcA,
	output reg RegWrite,
	output reg RegDst
);
//ops
parameter Rtype= 6'b000000;//add and nor or slt sub xor
parameter addi = 6'b001000;
parameter andi = 6'b001100;
parameter ori  = 6'b001101;
parameter slti = 6'b001010;
parameter xori = 6'b001110;
parameter sw   = 6'b101011;
parameter lw   = 6'b100011;
parameter beq  = 6'b000100;
parameter bne  = 6'b000101;
parameter j    = 6'b000010;


//aluop
parameter iadd =3'd0;
parameter isub =3'd1;
parameter ioth =3'd2;
parameter iand =3'd3;
parameter ior  =3'd4;
parameter islt =3'd5;
parameter ixor =3'd6;
//parameter nor =3'd7;
//states
//parameter Idle 	  = 4'd12;       
parameter Fetch 	  = 4'd0;
parameter Decode    = 4'd1;
parameter IExe      = 4'd2;
parameter Itype     = 4'd3;
parameter MemAdr    = 4'd4;
parameter MemRead1  = 4'd5;
parameter MemRead2  = 4'd6;
parameter Memwrite  = 4'd7;
parameter Execute   = 4'd8;
parameter Writeback = 4'd9;
parameter Branch 	 = 4'd10;
parameter Jump 	= 4'd11;
//parameter Ready 	= 4'd13;

reg [3:0] state;
reg [3:0] curr_state;

always @(posedge clk or posedge rst)
begin
if(rst)
	curr_state <= Fetch;
else 
	curr_state <= state;
end
//always@(posedge clk or posedge rst)
always@*
begin
	case(curr_state)
		Fetch:
			state = Decode;
		Decode:
			    case(op)
				lw  : state = MemAdr;
				sw  : state = MemAdr;
				addi: state = IExe;
				andi: state = IExe;
				ori : state = IExe;
				slti: state = IExe;
				xori: state = IExe;
				Rtype:state = Execute;
				beq : state = Branch;
				bne : state = Branch;
				j   : state = Jump;
				//default: state = Fetch;
			    endcase
			
		IExe:
			state = Itype;
		Itype:
			state = Fetch;
		MemAdr:
			case(op)
				lw: state = MemRead1;
				sw: state = Memwrite;
			endcase
		MemRead1:
			state = MemRead2;
		MemRead2:
			state = Fetch;
		Memwrite:
			state = Fetch;
		Execute:
			state = Writeback;
		Writeback:
			state = Fetch;
		Branch:
			state = Fetch;
		Jump:
			state = Fetch;
		default state = Fetch;
	endcase
end

//always@(posedge clk,posedge rst)
always@*
begin
	if(rst)
	begin
		PCWriteCond <= 0;
		PCWrite <= 0;
		lorD <= 0;
		MemRead <= 0;
		MemWrite <= 0;
		MemtoReg <= 0;
		IRWrite <= 0;
		PcSource <= 0;
		ALUOp <= 0;
		ALUSrcB <= 0;
		ALUSrcA <= 0;
		RegWrite <= 0;
		RegDst <= 0;
	end
	else
	begin
		case(curr_state)
			Fetch:
			begin
				PCWrite <= 1;
				IRWrite <= 1;
				lorD <= 0;
				MemRead <= 1;
				PcSource <= 0;
				ALUOp <= 0;
				ALUSrcB <= 01;
				ALUSrcA <= 0;
				PCWriteCond <= 0;
				lorD <= 0;
				MemWrite <= 0;
				RegWrite <= 0;
				RegDst <= 0;
			end
			Decode:
			begin
			    MemRead <= 0;
			    PCWrite <=0;
				IRWrite <=0;
				ALUOp <= 0;
				ALUSrcB <= 2'b11;
				ALUSrcA <= 0;
			end
			IExe:
			begin
				PCWrite <= 0;
				IRWrite <= 0;
				ALUSrcA <= 1;
				ALUSrcB <= 2'b10;
				case(op)
				addi: ALUOp<=iadd;
				andi: ALUOp<=iand;
				ori: ALUOp<=ior;
				xori: ALUOp<=ixor;
				slti: ALUOp<=islt;
				default: ALUOp<=iadd;
				endcase
			end
			Itype:
			begin
				PCWrite <= 0;
				IRWrite <= 0;
				RegDst <= 0;
				RegWrite <= 1;
				MemtoReg <= 0;
			end
			MemAdr:
			begin
				PCWrite <= 0;
				IRWrite <= 0;
				ALUSrcA <= 1;
				ALUSrcB <= 2'b10;
				ALUOp <= 0;
			end
			MemRead1:
			begin
				lorD <= 1;
				MemRead <= 1;
			end
			MemRead2:
			begin
			     MemRead <= 0;
				RegDst <= 0;
				RegWrite <= 1;
				MemtoReg <= 1;
			end
			Memwrite:
			begin
				MemWrite <= 1;
				lorD <= 1;
			end
			Execute:
			begin
				PCWrite <= 0;
				IRWrite <= 0;
				ALUSrcA <= 1;
				ALUSrcB <= 0;
				ALUOp <= 2'b10;
			end
			Writeback:
			begin
				MemtoReg <= 0;
				RegDst <= 1;
				RegWrite <= 1;
			end
			Branch:
			begin
				PCWriteCond <= 1;
				PcSource <= 1;
				ALUSrcA <= 1;
				ALUSrcB <= 0;
				ALUOp <= 2'b01;
			end
			Jump:
			begin
				PCWrite <= 1;
				IRWrite <= 0;
				PcSource <= 2'b10;
			end
		endcase
	end
end
endmodule

module reg_self(     //A,B,ALUOut
	input [31:0]in,
	input clk,
	output reg [31:0]out	
);
always@(posedge clk)
begin
	out<=in;
end
endmodule




