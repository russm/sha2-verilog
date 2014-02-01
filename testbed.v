module testbed;

wire [31:0] x = 32'hF000;
wire [31:0] y = 32'hFF00;
wire [31:0] z = 32'h00F0;

wire [31:0] ch, maj;

Ch #(.WORDSIZE(32)) Ch (
	.x(x),
	.y(y),
	.z(z),
	.Ch(ch)
);

Maj #(.WORDSIZE(32)) Maj (
	.x(x),
	.y(y),
	.z(z),
	.Maj(maj)
);

initial begin
  tick;
  $display("Ch=%h\nMaj=%h", ch, maj);
end

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
