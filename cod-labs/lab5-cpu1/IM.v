module IM(A,IR);
    input  [15:0] A ;    // address bus [11:2]
    output [31:0] IR;     // 32-bit memory output
    reg[31:0] mem[0:32767];  // 1024  * 32bit =    4KB
    // 32768 * 32bit =  128KB 
    
    assign IR = mem[A]; // 左移两位
    
endmodule