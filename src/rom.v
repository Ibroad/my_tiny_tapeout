`include "defines.v"

module rom
(
	input 	[($clog2(`ROM_DEPTH)-1):0] instr_addr_i,
	output	[(`DATA_WIDTH-1):0] 	instr_o
);

	reg [(`DATA_WIDTH-1):0] rom_mem [0:(`ROM_DEPTH-1)];

	assign instr_o = rom_mem[instr_addr_i >> 2];
	
endmodule
