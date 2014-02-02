// round compression function
module sha256_round (
	input [31:0] Kj, Wj,
	input [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
	output [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
	);

wire [31:0] Ch_e_f_g, Maj_a_b_c, S0_a, S1_e;

Ch #(.WORDSIZE(32)) Ch (
	.x(e_in), .y(f_in), .z(g_in), .Ch(Ch_e_f_g)
);

Maj #(.WORDSIZE(32)) Maj (
	.x(a_in), .y(b_in), .z(c_in), .Maj(Maj_a_b_c)
);

sha256_S0 S0 (
	.x(a_in), .S0(S0_a)
);

sha256_S1 S1 (
	.x(e_in), .S1(S1_e)
);

sha2_round #(.WORDSIZE(32)) sha256_round_inner (
	.Kj(Kj), .Wj(Wj),
	.a_in(a_in), .b_in(b_in), .c_in(c_in), .d_in(d_in),
	.e_in(e_in), .f_in(f_in), .g_in(g_in), .h_in(h_in),
	.Ch_e_f_g(Ch_e_f_g), .Maj_a_b_c(Maj_a_b_c), .S0_a(S0_a), .S1_e(S1_e),
	.a_out(a_out), .b_out(b_out), .c_out(c_out), .d_out(d_out),
	.e_out(e_out), .f_out(f_out), .g_out(g_out), .h_out(h_out)
);

endmodule


// Σ₀(x)
module sha256_S0 (
	input wire [31:0] x,
	output wire [31:0] S0
	);

assign S0 = ({x[1:0], x[31:2]} ^ {x[12:0], x[31:13]} ^ {x[21:0], x[31:22]});

endmodule


// Σ₁(x)
module sha256_S1 (
	input wire [31:0] x,
	output wire [31:0] S1
	);

assign S1 = ({x[5:0], x[31:6]} ^ {x[10:0], x[31:11]} ^ {x[24:0], x[31:25]});

endmodule


// σ₀(x)
module sha256_s0 (
	input wire [31:0] x,
	output wire [31:0] s0
	);

assign s0 = ({x[6:0], x[31:7]} ^ {x[17:0], x[31:18]} ^ {x[2:0], x[31:3]});

endmodule


// σ₁(x)
module sha256_s1 (
	input wire [31:0] x,
	output wire [31:0] s1
	);

assign s1 = ({x[16:0], x[31:17]} ^ {x[18:0], x[31:19]} ^ {x[9:0], x[31:10]});

endmodule


// round constants
module sha256_Krom (
	input clk,
	input [5:0] round,
	output reg [31:0] K
	);

reg [31:0] rom [63:0];

initial $readmemh("sha256_K.rom", rom);

always @(posedge clk)
begin
  K <= rom[round];
end

endmodule


// initial hash values
module sha256_H_0(
    output [255:0] H_0
    );

assign H_0 = {
    32'h6A09E667, 32'hBB67AE85, 32'h3C6EF372, 32'hA54FF53A,
    32'h510E527F, 32'h9B05688C, 32'h1F83D9AB, 32'h5BE0CD19
}

endmodule
