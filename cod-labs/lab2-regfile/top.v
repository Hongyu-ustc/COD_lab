module top(
           input         clk,
           input         rst_n,
           output reg    rReady,
           input [5:0]   rAddr,
           output reg [63:0] rDout
);
   reg [31:0]    alu_in_a;
   reg [31:0]    alu_in_b;
   wire [31:0]   alu_out;

   // register file inputs and outputs configuration
   reg [5:0]     reg_rAddr;
   reg [5:0]     reg_wAddr;
   wire [63:0]   reg_rDout;
   //reg [63:0]   reg_rDout;
   reg [63:0] reg_wDin;
   reg        reg_wEna = 0;
   // config end

   // alu operator
   parameter op = 5'h1;

   // temp reg
   reg [63:0] r1;
   reg [63:0] r2;
   reg [63:0] r3;

   alu myalu(alu_in_a, alu_in_b, op, alu_out);
   reg_file myregfile(clk, rst_n, reg_rAddr, reg_rDout, reg_wAddr, reg_wDin, reg_wEna);

   integer i = 0;
   integer calc_index = 0;
   integer cycle = 0;

   always@(posedge clk or negedge rst_n)
     begin
        if(~rst_n)
          begin
             rReady <= 0;
             calc_index <= 0;
             reg_rAddr <= 0;
             reg_wAddr <= 2;
             cycle <= 0;
          end // if (~rst_n)
        else
          begin
             if (calc_index <= 61)
               begin
                  case(cycle)
                    0:begin
                       alu_in_a <= reg_rDout;
                       reg_rAddr <= reg_rAddr + 1;
                       cycle <= 1;
                      end
                    1:begin
                       alu_in_b <= reg_rDout;
                       cycle <= 2;
                      end
                    2:begin
                       reg_wDin <= alu_out;
                       cycle <= 3;
                    end
                    3:begin
                       reg_wEna <= 1;
                       cycle <= 4;
                    end
                    4:begin
                       reg_wEna <= 0;
                       reg_wAddr <= reg_wAddr + 1;
                       cycle <= 0;
                       calc_index <= calc_index + 1;
                    end
                  endcase // case (cycle)
               end // if (calc_index <= 61)
             else
               begin
                  rReady = 1;
                  reg_rAddr = rAddr;
                  rDout = reg_rDout;
               end // else: !if(calc_index <= 61)
          end // else: !if(~rst_n)
     end // always@ (posedge clk or negedge rst_n)
endmodule // top
