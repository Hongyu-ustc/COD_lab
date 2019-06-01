module FIFO_test();
reg en_out;
reg en_in;
reg [3:0] in;
reg rst;
reg clk;
wire [3:0] out;
wire empty;
wire full;

FIFO A2 (
	.en_out(en_out),
	.en_in(en_in),
	.in(in),
	.rst(rst),
	.clk(clk),
	.out(out),
	.empty(empty),
	.full(full)
);

initial clk=0;
initial en_in=0;
initial en_out=0;
always #50 clk=~clk;
initial 
begin
rst=1;
#200 rst=0;
end
initial
begin
#200
en_in=1;
in=4'h2;
#200
en_in=1;
in=4'h3;
#200
en_in=1;
in=4'h5;
#200
en_in=0;
en_out=1;
#200
en_out=0;
en_in=1;
in=4'h1;
#200
en_in=1;
in=4'h2;
#200
en_in=1;
in=4'h3;
#200
en_in=1;
in=4'h4;
#200
en_in=1;
in=4'h8;
#200
en_in=1;
in=4'h9;
#200
en_in=1;
in=4'h2;
#200
en_out=1;
en_in=0;
end
endmodule
