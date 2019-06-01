```
module Control(
	input clk,rst_n,
	input [5:0]op,funct,
	output reg PCWrite,Branch,
	output reg [1:0]PCSrc,
	output reg IorD,MemWrite,IRWrite,
	output reg MemtoReg,RegDst,RegWrite,
	output reg ALUSrcA,
	output reg [1:0]ALUSrcB,
	output reg [4:0]ALUControl
   );
	reg [3:0]NS,CS;
	
parameter addi = 6'b001000;
parameter add = 6'b000000;
parameter lw = 6'b100011;
parameter sw = 6'b101011;
parameter bgtz = 6'b000111;
parameter j = 6'b000010;

parameter Idle = 4'd12;       
parameter Fetch = 4'd0;
parameter Decode = 4'd1;
parameter MemAdr = 4'd2;
parameter MemRead = 4'd3;
parameter MemWriteback = 4'd4;
parameter MemWriteS = 4'd5;
parameter Execute = 4'd6;
parameter Writeback = 4'd7;
parameter BranchS = 4'd8;
parameter ADDIExecute = 4'd9;
parameter ADDIWriteback = 4'd10;
parameter Jump = 4'd11;
parameter Ready = 4'd13;

always@(posedge clk,negedge rst_n)
begin
	if(~rst_n)
		CS <= Idle;
	else
		CS <= NS;
end

always@(rst_n,CS)
begin
	NS = 4'dx;
	case(CS)
		Idle:
			NS = Fetch;
		Fetch:
			NS = Ready;
		Ready:
			NS = Decode;
		Decode:
			case(op)
				lw: NS = MemAdr;
				sw: NS = MemAdr;
				add: NS = Execute;
				bgtz: NS = BranchS;
				addi: NS = ADDIExecute;
				j: NS = Jump;
				default: NS = Fetch;
			endcase
		MemAdr:
			case(op)
				lw: NS = MemRead;
				sw: NS = MemWriteS;
			endcase
		MemRead:
			NS = MemWriteback;
		MemWriteback:
			NS = Fetch;
		MemWriteS:
			NS = Fetch;
		Execute:
			NS = Writeback;
		Writeback:
			NS = Fetch;
		BranchS:
			NS = Fetch;
		ADDIExecute:
			NS = ADDIWriteback;
		ADDIWriteback:
			NS = Fetch;
		Jump:
			NS = Fetch;
	endcase
end

always@(posedge clk,negedge rst_n)
begin
	if(~rst_n)
	begin
		PCWrite <= 0;
		Branch <= 0;
		PCSrc <= 0;
		IorD <= 0;
		MemWrite <= 0;
		IRWrite <= 0;
		MemtoReg <= 0;
		RegDst <= 0;
		RegWrite <= 0;
		ALUSrcA <= 0;
		ALUSrcB <= 0;
		ALUControl <= 0;
	end
	else
	begin
		case(NS)
			Idle:        
			begin
				PCWrite <= 0;
				Branch <= 0;
				PCSrc <= 0;
				IorD <= 0;
				MemWrite <= 0;
				IRWrite <= 0;
				MemtoReg <= 0;
				RegDst <= 0;
				RegWrite <= 0;
				ALUSrcA <= 0;
				ALUSrcB <= 0;
				ALUControl <= 0;
			end
			Fetch:
			begin
				PCWrite <= 1;
				Branch <= 0;
				PCSrc <= 0;
				IorD <= 0;
				MemWrite <= 0;
				IRWrite <= 0;
				MemtoReg <= 0;
				RegDst <= 0;
				RegWrite <= 0;
				ALUSrcA <= 0;
				ALUSrcB <= 1;
				ALUControl <= 1;
			end
			Ready:
			begin
				PCWrite <= 0;
				IRWrite <= 1;
			end
			Decode:
			begin
				IRWrite <= 0;
				ALUSrcA <= 0;
				ALUSrcB <= 3;
				ALUControl <= 1;
			end
			MemAdr:
			begin
				ALUSrcA <= 1;
				ALUSrcB <= 2;
				ALUControl <= 1;
			end
			MemRead:
			begin
				IorD <= 1;
			end
			MemWriteback:
			begin
				RegDst <= 0;
				MemtoReg <= 1;
				RegWrite <= 1;
			end
			MemWriteS:
			begin
				IorD <= 1;
				MemWrite <= 1;
			end
			Execute:
			begin
				ALUSrcA <= 1;
				ALUSrcB <= 0;
				ALUControl <= 1;
			end
			Writeback:
			begin
				MemtoReg <= 0;
				RegDst <= 1;
				RegWrite <= 1;
			end
			BranchS:
			begin
				Branch <= 1;
				PCSrc <= 1;
				ALUSrcA <= 1;
				ALUSrcB <= 0;
				ALUControl <= 2;
			end
			ADDIExecute:
			begin
				ALUSrcA <= 1;
				ALUSrcB <= 2;
				ALUControl <= 1;
			end
			ADDIWriteback:
			begin
				MemtoReg <= 0;
				RegDst <= 0;
				RegWrite <= 1;
			end
			Jump:
			begin
				PCWrite <= 1;
				PCSrc <= 2;
			end
		endcase
	end
end

endmodule


```

