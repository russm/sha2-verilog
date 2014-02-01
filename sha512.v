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
