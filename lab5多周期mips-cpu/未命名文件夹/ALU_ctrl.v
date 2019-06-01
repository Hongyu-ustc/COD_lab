module ALU_ctrl(

​	input clk,

​	input [5:0]i5_0,

​	input [2:0]ALUOp,

​	output reg [3:0]out

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

​		case(ALUOp)

​		3'b000: out <= 4'b0000;  

​		3'b001: out <= 4'b0001;      

​		3'b010: 

​			case(i5_0)

​			iadd: out <= 4'b0000;       

​			iand: out <= 4'b0010; 

​			inor: out <= 4'b0101; 

​			ior : out <= 4'b0011; 	

​			islt: out <= 4'b0110; 

​			isub: out <= 4'b0001; 

​			ixor: out <= 4'b0100; 

​			default: out <= 4'b0000;

​			endcase

​		3'b011: out <= 4'b0010; 

​		3'b100: out <= 4'b0011; 

​		3'b101: out <= 4'b0110; 

​		3'b110: out <= 4'b0100; 

​		default: out <= 4'b0000;

​		endcase

end

endmodule