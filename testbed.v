module testbed;


// driver

reg [31:0] ticks = 0;
reg clk = 1'b0;
reg rst = 1'b0;

initial begin
  $display("starting");
  repeat (256) begin
    tick;
  end
  $display("done");
  $finish;
end

task tick;
begin
  #1;
  ticks = ticks + 1;
  clk = 1;
  #1;
  clk = 0;
  dumpstate;
end
endtask

task dumpstate;
begin
  $display("ticks=%h", ticks);
end
endtask

endmodule
