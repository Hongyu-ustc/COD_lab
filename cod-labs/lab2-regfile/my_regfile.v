module reg_file(
                input         clk,
                input         rst_n,
                input [5:0]   rAddr,
                output [63:0] rDout,
                input [5:0]   wAddr,
                input [63:0]  wDin,
                input         wEna
                );

   reg [31:0]                 regs [0:63];

   assign rDout = regs[rAddr];

   integer                 index;

   always@(posedge clk or negedge rst_n)
     begin
        if(~rst_n)
          begin
             for (index = 0; index < 64; index = index + 1)
               begin
                  regs[index] <= 0;
               end
             regs[0] <= 2;
             regs[1] <= 2;
          end
        else
          begin
             regs[wAddr] <= wEna ? wDin : regs[wAddr];
          end
     end // always@ (posedge clk or negedge rst_n)
endmodule // reg_file
