module RAM(
    input wire clk,
    input wire wea,
    input wire [31:0] addra,
    input wire [31:0]  dina,
    input wire [31:0] addrb,
    output wire [31:0] doutb);

reg [31:0] mem [0:32767];  // 32-bit memory with 128 entries

	always @(posedge clk) begin
		if (wea) begin
			mem[addra] <= dina;
            $display("%5d:写dm[%h] <= %h",$time, addra, dina);
		end
	end

	assign doutb = wea ? dina : mem[addrb][31:0];
	// During a write, avoid the one cycle delay 

endmodule