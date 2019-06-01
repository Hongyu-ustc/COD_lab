module test_top();
    reg clk, rst_n;
    wire [31:0] data1, data2;

    integer i;

    top uut(
        .clk(clk),
        .rst_n(rst_n),
        .data1(data1),
        .data2(data2)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        #1 rst_n = 1;
        #10 rst_n = 0;
        #10 rst_n = 1;
        uut.ram1.mem[0] <= 2;
        uut.ram1.mem[1] <= 2;
        $display("ram 初始化结果:");
        for (i = 0; i < 10; i = i + 1)
            begin
                $display("mem[%h] = %h", i, uut.ram1.mem[i]);
            end
        #10000
        $display("ram 经过计算后的结果:");
        for (i = 0; i < 10; i = i + 1)
            begin
                $display("mem[%h] = %h", i, uut.ram1.mem[i]);
            end
        $finish;
    end

endmodule
