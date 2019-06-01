```verilog
module Top(
   input clk,rst_n,
	output [31:0]out
   );
	wire [31:0]PC,jump,Imm;
	wire [31:0]Instr,Data;
	wire [5:0]op,funct;
	wire [4:0]rs,rt,rd;
	wire [31:0]reg_A,reg_B;
	wire [31:0]alu_out,alu_result;
	wire PCWrite,Branch;
	wire [1:0]PCSrc;
	wire IorD,MemWrite,IRWrite;
	wire MemtoReg,RegDst,RegWrite;
	wire ALUSrcA,Zero;
	wire [1:0]ALUSrcB;
	wire [4:0]ALUControl;
	


assign out = Instr;
assign jump = {PC[31:28], Instr[25:0], 2'b00};
assign Imm = Instr[15] ?
		{16'hffff, Instr[15:0]} : {16'h0000, Instr[15:0]};
assign op = Instr[31:26];
assign rs = Instr[25:21];
assign rt = Instr[20:16];
assign rd = Instr[15:11];
assign funct = Instr[5:0];

PC_Part M1(
	.clk(clk),
  .rst_n(rst_n),
	.PC(PC),
  .PCPlus4(alu_result),
	.PCBranch(alu_out),
  .PCJump(jump),
	.PCWrite(PCWrite),
  .Branch(Branch),
	.Zero(Zero),
  .PCSrc(PCSrc)
);
MEM_Part M2(
	.clk(clk),
  .rst_n(rst_n),
	.PC(PC),
  .DAddr(alu_out),
  .wDin(reg_B),
	.Instr(Instr),
  .Data(Data),
	.IorD(IorD),
  .MemWrite(MemWrite),
  .IRWrite(IRWrite)
   );
	RF_Part M3(
		.clk(clk),
    .rst_n(rst_n),
		.rs(rs),
    .rt(rt),
    .rd(rd),
		.reg_A(reg_A),
    .reg_B(reg_B),
		.alu_out(alu_out),
    .mem_out(Data),
		.RegWrite(RegWrite),
    .RegDst(RegDst),
    .MemtoReg(MemtoReg)
   );
	ALU_Part M4(
		.clk(clk),
    .rst_n(rst_n),
		.reg_A(reg_A),
    .reg_B(reg_B),
    .PC(PC),
    .Imm(Imm),
		.alu_result(alu_result),
    .alu_out(alu_out),
		.ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
		.ALUControl(ALUControl),
    .Zero(Zero)
   );

Control M5(
	.clk(clk),
  .rst_n(rst_n),
  .op(op),
  .funct(funct),
	.PCWrite(PCWrite),
  .Branch(Branch),
  .PCSrc(PCSrc),
	.IorD(IorD),
  .MemWrite(MemWrite),
  .IRWrite(IRWrite),
	.MemtoReg(MemtoReg),
  .RegDst(RegDst),
  .RegWrite(RegWrite),
	.ALUSrcA(ALUSrcA),
  .ALUSrcB(ALUSrcB),
  .ALUControl(ALUControl)
   );

endmodule
```

