module RAM(
    input wire clk,
    input wire wea,
    input wire [9:0] addra,
    input wire [31:0]  dina,
    input wire [9:0] addrb,
    output wire [31:0] doutb);

    reg [31:0] mem [0:1023];  // 32-bit memory with 128 entries

    integer i;

    initial
        begin
            mem[0] <=32'h2;
            mem[1] <= 32'h2;
            for (i = 2; i < 1024; i = i + 1)
                begin
                    //mem[i] <= 0;
                end
            $display("mem init success!");
        end

	always @(posedge clk) begin
		if (wea) begin
			mem[addra] <= dina;
            $display("%5d:写入mem[%h] <= %h",$time, addra, dina);
		end
	end

	assign doutb = mem[addrb][31:0];

endmodule