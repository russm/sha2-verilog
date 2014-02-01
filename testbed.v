module testbed;

wire [31:0] K256;
wire [63:0] K512;

sha256_Krom sha256_Krom (
	.clk(clk),
	.round(ticks[5:0]),
	.K(K256)
);

sha512_Krom sha512_Krom (
	.clk(clk),
	.round(ticks[6:0]),
	.K(K512)
);

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
  $display("ticks=%h K256=%h K512=%h", ticks, K256, K512);
end
endtask

endmodule
