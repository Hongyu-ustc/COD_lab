module SL_1(   //shift left 2

​	input [31:0] in,

​	output [31:0] out

);

assign out=in<<2;

endmodule





module SL_2(   //shift left 2

​	input [25:0] in,

​	output [27:0] out

);

assign out={in,2'b00};

endmodule