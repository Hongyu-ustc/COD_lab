module regfile_fib_testbench;
   reg clk = 0;
   reg rst_n;
   wire rReady;
   reg [5:0] rAddr;
   wire [63:0] rDout;

   top mytop(clk, rst_n, rReady, rAddr, rDout);

   integer cycle;

   always@(posedge rReady)
     begin
        for (cycle = 0; cycle < 100; cycle = cycle + 1)
          begin
             #1;
             clk = ~clk;
          end
     end

   initial
     begin
        $dumpfile("testbench.vcd");
        $dumpvars;
        rst_n = 0;
        #100;
        rst_n = 1;
        while(~rReady)
          begin
             #1;
             clk = ~clk;
          end
        if (rReady)
          begin
             #10;
             rAddr = 0;
             #10;
             rAddr = 1;
             #10;
             rAddr = 2;
             #10;
             rAddr = 63;
          end // if (rReady)
     end // initial begin
endmodule // regfile_fib_testbench
