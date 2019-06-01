module test();
    reg clk, rst_n;
    top top_inst(clk, rst_n);

    initial begin
      clk <= 0;
      rst_n <= 0;
      #100
      rst_n <= 1;
      $readmemh(`IM_DATA_FILE, top_inst.imem_inst.mem, 0, `NUM_IM_DATA-1);
      $readmemh(`DM_DATA_FILE, top_inst.dmem_inst.mem, 0, `NUM_DM_DATA-1);
      $display("%5d: initialization finished!", $time);
      #`SIM_TIME;
      $display("%5d: simulation finished!", $time);
      $finish;

    end

    always #10 clk = ~clk;
endmodule
