module Mux_1(
	input clk,
	input lorD,
	input [31:0] in0,//pc_out ,
	input [31:0] in1,//alu_out,
	output reg[31:0] out//address
);
//assign out=(lord)?in1:in0;
always@(*)
begin
	case(lorD)
		0: out <= in0;
		1: out <= in1;
		default: out = 32'bx;
	endcase
end
endmodule



module Mux_2(
	input clk,
	input RegDst,
	input [4:0] in0,//i20_16,
	input [4:0] in1,//i15_11,
	output reg[4:0] out
);
always@(*)
begin
	case(RegDst)
		0: out = in0;
		1: out = in1;
		default: out = 32'bx;
	endcase
end
endmodule

module Mux_3(
	input clk,
	input MemtoReg,
	input [31:0] in0,//alu_out,
	input [31:0] in1,//memdata,
	output reg[31:0] out//mux_out
);
always@(*)
begin
	case(MemtoReg)
		0: out = in0;
		1: out = in1;
		default: out = 32'bx;
	endcase
end
endmodule

module Mux_4(
	input clk,
	input ALUSrcA,
	input [31:0]in0,//PC
	input [31:0]in1,//A
	output reg[31:0]out
);
always@(*)
begin
	case(ALUSrcA)
		0: out = in0;
		1: out = in1;
		default: out = 32'bx;
	endcase
end
endmodule

module Mux_5(
	input clk,
	input ALUSrcB,
	input [31:0]in0,
	input [31:0]in2,
	input [31:0]in3, 
	output reg[31:0]out
);
always@(*)
begin
	case(ALUSrcB)
		2'b00: out <= in0;
		2'b01: out <= 32'd4;
		2'b10: out <= in2;
		2'b11: out <= in3;
		default: out <= 32'bx;
	endcase
end
endmodule


module Mux_6(
    input clk,
	input PcSource,
	input [31:0]in0,//ALUresult
	input [31:0]in1,//ALUout
	input [31:0]in2, //addr[31:0]
	output reg[31:0]out//PC_in
);
always@(*)
begin
	case(PcSource)
		2'b00: out = in0;
		2'b01: out = in1;
		2'b10: out = in2;
		default: out = 32'bx;
	endcase
end
endmodule