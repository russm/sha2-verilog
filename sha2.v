// generalised round compression function
module sha2_round #(
    parameter WORDSIZE=0
) (
    input [WORDSIZE-1:0] Kj, Wj,
    input [WORDSIZE-1:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
    input [WORDSIZE-1:0] Ch_e_f_g, Maj_a_b_c, S0_a, S1_e,
    output [WORDSIZE-1:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out
    );

wire [WORDSIZE-1:0] T1 = h_in + S1_e + Ch_e_f_g + Kj + Wj;
wire [WORDSIZE-1:0] T2 = S0_a + Maj_a_b_c;

assign a_out = T1 + T2;
assign b_out = a_in;
assign c_out = b_in;
assign d_out = c_in;
assign e_out = d_in + T1;
assign f_out = e_in;
assign g_out = f_in;
assign h_out = g_in;

endmodule


// Ch(x,y,z)
module Ch #(parameter WORDSIZE=0) (
    input wire [WORDSIZE-1:0] x, y, z,
    output wire [WORDSIZE-1:0] Ch
    );

assign Ch = ((x & y) ^ (~x & z));

endmodule


// Maj(x,y,z)
module Maj #(parameter WORDSIZE=0) (
    input wire [WORDSIZE-1:0] x, y, z,
    output wire [WORDSIZE-1:0] Maj
    );

assign Maj = (x & y) ^ (x & z) ^ (y & z);

endmodule
