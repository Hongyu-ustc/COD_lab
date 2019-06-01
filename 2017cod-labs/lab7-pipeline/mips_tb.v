//`timescale 10 ns / 1 ns

module testbench;
    
    reg clk;
    reg rst;
    
    integer i;

    initial begin
        $readmemh(`IM_DATA_FILE, mips.IM.im_128k, 0, `NUM_IM_DATA);
        $display("Instruction Memory:"); 
        for (i=0; i< `NUM_IM_DATA; i=i+1) begin
                $display("im[%d] = %h", i, mips.IM.im_128k[i]);
        end  
        $readmemh(`DM_DATA_FILE, mips.DM.dm_4k, 0, `NUM_DM_DATA);
        clk = 0;
        forever #10 clk = !clk;
    end

    initial begin
            rst = 1;
        #20 rst = 0;
        $display("初始化完成，开始运行");
        #2500 begin
            $display("Data Memory:"); 
            for (i=0; i<'h80; i=i+4) begin
                 $display("dm[%d] = %h%h%h%h",i / 4,mips.DM.dm_4k[i+3],mips.DM.dm_4k[i+2],mips.DM.dm_4k[i+1],mips.DM.dm_4k[i+0]);
            end          
        end
        #10 $finish;   
    end  
    mips mips(clk, rst);

endmodule
