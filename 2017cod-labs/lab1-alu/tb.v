module tb;
   reg [31:0] a, b;
   reg [4:0]  op;
   reg       clk, rst_n;
   wire [31:0] out;
   wire [31:0] fib;

   alu myalu(a, b, op, out);

   wire fib_finish;
   integer alu_finish;
   integer init_finish = 0;

   integer state;
   integer clk_start;

   initial
     begin
        // initializing wave files
        $dumpfile("tb.vcd");
        $dumpvars;
        // initializing alu
        alu_finish = 0;
        a = 32'h3;
        b = 32'h2;
        op = 5'h0;
        state = 0;
        // initializing clk
        clk = 0;
        clk_start = 0;
        // initializing fib
        rst_n = 1;
        #5;
        rst_n = 0;
        #5;
        rst_n = 1;
        #5;
        // initialization finished
        init_finish = 1;
     end // initial begin

   always@(*)
     begin
        if (init_finish)
          begin
             if (fib_finish & alu_finish)
               begin
                  $finish;
               end
             else
               begin
                  clk_start = 1;
               end
          end // if (init_finish)
     end // always@ (*)

   always #10 if(clk_start) clk = ~clk;

   always@(posedge clk)
     begin
        if (op != 5'h7)
          begin
             if (state == 0)
               begin
                  state = 1;
               end
             else
               begin
                  op = op + 1;
                  state = 0;
               end
          end // if (op != 5'h7)
        else
          begin
             alu_finish = 1;
          end // else: !if(op != 5'h7)
     end // always@ (posedge clk)

   fib myfib(a, clk, rst_n, fib, fib_finish);

endmodule // tb

