module sha256_S0 (
	input wire [31:0] x,
	output wire [31:0] S0
	);

assign S0 = ({x[1:0], x[31:2]} ^ {x[12:0], x[31:13]} ^ {x[21:0], x[31:22]});

endmodule

module sha256_S1 (
	input wire [31:0] x,
	output wire [31:0] S1
	);

assign S1 = ({x[5:0], x[31:6]} ^ {x[10:0], x[31:11]} ^ {x[24:0], x[31:25]});

endmodule

module sha256_s0 (
	input wire [31:0] x,
	output wire [31:0] s0
	);

assign s0 = ({x[6:0], x[31:7]} ^ {x[17:0], x[31:18]} ^ {x[2:0], x[31:3]});

endmodule

module sha256_s1 (
	input wire [31:0] x,
	output wire [31:0] s1
	);

assign s1 = ({x[16:0], x[31:17]} ^ {x[18:0], x[31:19]} ^ {x[9:0], x[31:10]});

endmodule

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

module sha256_H_0(
	output [31:0] H1_0, H2_0, H3_0, H4_0, H5_0, H6_0, H7_0, H8_0
	);

assign H1_0 = 32'h6A09E667;
assign H2_0 = 32'hBB67AE85;
assign H3_0 = 32'h3C6EF372;
assign H4_0 = 32'hA54FF53A;
assign H5_0 = 32'h510E527F;
assign H6_0 = 32'h9B05688C;
assign H7_0 = 32'h1F83D9AB;
assign H8_0 = 32'h5BE0CD19;

endmodule
