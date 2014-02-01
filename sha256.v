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
