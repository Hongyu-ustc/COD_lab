module IM(A,IR);
    input  [15:0] A ;    // address bus [11:2]
    output [31:0] IR;     // 32-bit memory output
    reg[31:0] im_128k[0:32767];  // 1024  * 32bit =    4KB
    // 32768 * 32bit =  128KB 
    
    assign IR = im_128k[A[15:2]]; // 右移两位

endmodule
