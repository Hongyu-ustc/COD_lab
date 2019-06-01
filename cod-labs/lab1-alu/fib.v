module fib(
           input [31:0]  a,
           input clk, rst_n,
           output [31:0] fib,
           output flag);
   wire [31:0]           w1, w2, w3;
   reg [31:0]            r1, r2, r3;
   reg                   flag;

   parameter n = 4;
   parameter op = 5'h1;
   integer count = 0;

   //alu myalu3(r1, r2, op, r3);
   alu myalu2(w1, w2, op, w3);
   assign w1 = r1;
   assign w2 = r2;
   assign fib = w3;

   always@(posedge clk or negedge rst_n)
     begin
        if(~rst_n)
          begin
             flag = 0;
             count = 0;
             r1 <= a;
             r2 <= a;
          end
        if (count < n)
          begin
             r3 = w3;
             r1 = r2;
             r2 = r3;
             count = count + 1;
          end
        else
          begin
             flag = 1;
          end
     end // always@ (posedge clk or negedge rst_n)
   
endmodule // fib
