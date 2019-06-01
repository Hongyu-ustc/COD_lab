module CU(//control unit

​	input clk,

​	input rst,

​	input [5:0] op,

​	output reg PCWriteCond,

​	output reg PCWrite,

​	output reg lorD,

​	output reg MemRead,

​	output reg MemWrite,

​	output reg MemtoReg,

​	output reg IRWrite,

​	output reg [1:0]PcSource,

​	output reg [2:0]ALUOp,

​	output reg [1:0]ALUSrcB,

​	output reg ALUSrcA,

​	output reg RegWrite,

​	output reg RegDst

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

parameter Idle 	 	= 4'd12;       

parameter Fetch 	= 4'd0;

parameter Decode    = 4'd1;

parameter IExe      = 4'd2;

parameter Itype     = 4'd3;

parameter MemAdr    = 4'd4;

parameter MemRead1  = 4'd5;

parameter MemRead2  = 4'd6;

parameter Memwrite  = 4'd7;

parameter Execute   = 4'd8;

parameter Writeback = 4'd9;

parameter Branch 	= 4'd10;

parameter Jump 		= 4'd11;



reg [3:0] state;



always@(posedge clk , posedge rst)

begin

​	if(rst)

​		state <= Idle;

​	else

​	case(state)

​		Idle:

​			state <= Fetch;

​		Fetch:

​			state <= Decode;

​		Decode:

​			case(op)

​				lw  : state <= MemAdr;

​				sw  : state <= MemAdr;

​				addi: state <= IExe;

​				andi: state <= IExe;

​				ori : state <= IExe;

​				slti: state <= IExe;

​				xori: state <= IExe;

​				Rtype:state <= Execute;

​				beq : state <= Branch;

​				bne : state <= Branch;

​				j: 	  state <= Jump;

​				default: state <= Fetch;

​			endcase

​			

​		IExe:

​			state <= Itype;

​		Itype:

​			state <= Fetch;

​		MemAdr:

​			case(op)

​				lw: state <= MemRead1;

​				sw: state <= Memwrite;

​			endcase

​		MemRead1:

​			state <= MemRead2;

​		MemRead2:

​			state <= Fetch;

​		Memwrite:

​			state <= Fetch;

​		Execute:

​			state <= Writeback;

​		Writeback:

​			state <= Fetch;

​		Branch:

​			state <= Fetch;

​		Jump:

​			state <= Fetch;

​		default state <= Idle;

​	endcase

end



always@(posedge clk,posedge rst)

begin

​	if(rst)

​	begin

​		PCWriteCond <= 0;

​		PCWrite <= 0;

​		lorD <= 0;

​		MemRead <= 0;

​		MemWrite <= 0;

​		MemtoReg <= 0;

​		IRWrite <= 0;

​		PcSource <= 0;

​		ALUOp <= 0;

​		ALUSrcB <= 0;

​		ALUSrcA <= 0;

​		RegWrite <= 0;

​		RegDst <= 0;

​	end

​	else

​	begin

​		case(state)

​			Idle:        

​			begin

​				PCWriteCond <= 0;

​				PCWrite <= 0;

​				lorD <= 0;

​				MemRead <= 0;

​				MemWrite <= 0;

​				MemtoReg <= 0;

​				IRWrite <= 0;

​				PcSource <= 0;

​				ALUOp <= 0;

​				ALUSrcB <= 0;

​				ALUSrcA <= 0;

​				RegWrite <= 0;

​				RegDst <= 0;

​			end

​			Fetch:

​			begin

​				PCWrite <= 1;

​				lorD <= 0;

​				MemRead <= 1;

​				IRWrite <= 1;

​				PcSource <= 0;

​				ALUOp <= 0;

​				ALUSrcB <= 01;

​				ALUSrcA <= 0;

​			end

​			Decode:

​			begin

​				ALUOp <= 0;

​				ALUSrcB <= 2'b11;

​				ALUSrcA <= 0;

​			end

​			IExe:

​			begin

​				ALUSrcA <= 1;

​				ALUSrcB <= 2'b10;

​				case(op)

​				addi: ALUOp<=iadd;

​				andi: ALUOp<=iand;

​				ori: ALUOp<=ior;

​				xori: ALUOp<=ixor;

​				slti: ALUOp<=islt;

​				default: ALUOp<=iadd;

​				endcase

​			end

​			Itype:

​			begin

​				RegDst <= 0;

​				RegWrite <= 1;

​				MemtoReg <= 0;

​			end

​			MemAdr:

​			begin

​				ALUSrcA <= 1;

​				ALUSrcB <= 2'b10;

​				ALUOp <= 0;

​			end

​			MemRead1:

​			begin

​				lorD <= 1;

​				MemRead <= 1;

​			end

​			MemRead2:

​			begin

​				RegDst <= 1;

​				RegWrite <= 1;

​				MemtoReg <= 0;

​			end

​			MemWrite:

​			begin

​				MemWrite <= 1;

​				lorD <= 1;

​			end

​			Execute:

​			begin

​				ALUSrcA <= 1;

​				ALUSrcB <= 0;

​				ALUOp <= 2'b10;

​			end

​			Writeback:

​			begin

​				MemtoReg <= 0;

​				RegDst <= 1;

​				RegWrite <= 1;

​			end

​			Branch:

​			begin

​				PCWriteCond <= 1;

​				PcSource <= 1;

​				ALUSrcA <= 1;

​				ALUSrcB <= 0;

​				ALUOp <= 2'b01;

​			end

​			Jump:

​			begin

​				PCWrite <= 1;

​				PcSource <= 2;

​			end

​		endcase

​	end

end

endmodule