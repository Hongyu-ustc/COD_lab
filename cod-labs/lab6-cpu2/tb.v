module Top_test;

	// Inputs
	reg clk;
	reg rst_n;

	// Outputs
	wire [31:0]out;

	integer i;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.clk(clk), 
		.rst_n(rst_n), 
		.out(out)
	);

	initial begin
		clk = 0;
		forever
			#5 clk = ~clk;
	end
	
	initial begin
		rst_n = 1;
		#10; rst_n = 0;
		#10; rst_n = 1;
		$display("%5d: reset complete.", $time);
      	$readmemh(`IM_DATA_FILE, uut.M2.M1.mem, 0, `NUM_IM_DATA-1);	
      	for (i = 0; i < `NUM_IM_DATA; i = i + 1)
        $display("%h", uut.M2.M1.mem[i]);
      	$display("%5d: memory initialization finished.", $time);
      	#`SIM_TIME;
      	$display("%5d: simulation finished!", $time);
      	$finish;
	end
      
endmodule

