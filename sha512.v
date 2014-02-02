// round compression function
module sha512_round (
	input [63:0] Kj, Wj,
	input [63:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
	output [63:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
	);

wire [63:0] Ch_e_f_g, Maj_a_b_c, S0_a, S1_e;

Ch #(.WORDSIZE(64)) Ch (
	.x(e_in), .y(f_in), .z(g_in), .Ch(Ch_e_f_g)
);

Maj #(.WORDSIZE(64)) Maj (
	.x(a_in), .y(b_in), .z(c_in), .Maj(Maj_a_b_c)
);

sha512_S0 S0 (
	.x(a_in), .S0(S0_a)
);

sha512_S1 S1 (
	.x(e_in), .S1(S1_e)
);

sha2_round #(.WORDSIZE(64)) sha256_round_inner (
	.Kj(Kj), .Wj(Wj),
	.a_in(a_in), .b_in(b_in), .c_in(c_in), .d_in(d_in),
	.e_in(e_in), .f_in(f_in), .g_in(g_in), .h_in(h_in),
	.Ch_e_f_g(Ch_e_f_g), .Maj_a_b_c(Maj_a_b_c), .S0_a(S0_a), .S1_e(S1_e),
	.a_out(a_out), .b_out(b_out), .c_out(c_out), .d_out(d_out),
	.e_out(e_out), .f_out(f_out), .g_out(g_out), .h_out(h_out)
);

endmodule


// Σ₀(x)
module sha512_S0 (
	input wire [63:0] x,
	output wire [63:0] S0
	);

assign S0 = ({x[27:0], x[63:28]} ^ {x[33:0], x[63:34]} ^ {x[38:0], x[63:39]});

endmodule


// Σ₁(x)
module sha512_S1 (
	input wire [63:0] x,
	output wire [63:0] S1
	);

assign S1 = ({x[13:0], x[63:14]} ^ {x[17:0], x[63:18]} ^ {x[40:0], x[63:41]});

endmodule


// σ₀(x)
module sha512_s0 (
	input wire [63:0] x,
	output wire [63:0] s0
	);

assign s0 = ({x[0:0], x[63:1]} ^ {x[7:0], x[63:8]} ^ {x[6:0], x[63:7]});

endmodule


// σ₁(x)
module sha512_s1 (
	input wire [63:0] x,
	output wire [63:0] s1
	);

assign s1 = ({x[18:0], x[63:19]} ^ {x[60:0], x[63:61]} ^ {x[5:0], x[63:6]});

endmodule


// round constants
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


// initial hash values
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
