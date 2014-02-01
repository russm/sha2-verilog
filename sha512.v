module sha512_S0 (
	input wire [63:0] x,
	output wire [63:0] S0
	);

assign S0 = ({x[27:0], x[63:28]} ^ {x[33:0], x[63:34]} ^ {x[38:0], x[63:39]});

endmodule

module sha512_S1 (
	input wire [63:0] x,
	output wire [63:0] S1
	);

assign S1 = ({x[13:0], x[63:14]} ^ {x[17:0], x[63:18]} ^ {x[40:0], x[63:41]});

endmodule

module sha512_s0 (
	input wire [63:0] x,
	output wire [63:0] s0
	);

assign s0 = ({x[0:0], x[63:1]} ^ {x[7:0], x[63:8]} ^ {x[6:0], x[63:7]});

endmodule

module sha512_s1 (
	input wire [63:0] x,
	output wire [63:0] s1
	);

assign s1 = ({x[18:0], x[63:19]} ^ {x[60:0], x[63:61]} ^ {x[5:0], x[63:6]});

endmodule

module sha512_Krom (
	input clk,
	input [6:0] round,
	output reg [63:0] K
	);

reg [63:0] rom [79:0];

initial $readmemh("sha512_K.rom", rom);

always @(posedge clk)
begin
  K <= rom[round];
end

endmodule

module sha512_H_0(
	output [31:0] H1_0, H2_0, H3_0, H4_0, H5_0, H6_0, H7_0, H8_0
	);

assign H1_0 = 64'h6A09E667F3BCC908;
assign H2_0 = 64'hBB67AE8584CAA73B;
assign H3_0 = 64'h3C6EF372FE94F82B;
assign H4_0 = 64'hA54FF53A5F1D36F1;
assign H5_0 = 64'h510E527FADE682D1;
assign H6_0 = 64'h9B05688C2B3E6C1F;
assign H7_0 = 64'h1F83D9ABFB41BD6B;
assign H8_0 = 64'h5BE0CD19137E2179;

endmodule
