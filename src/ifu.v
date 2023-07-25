`include "defines.v"

module ifu 
(
	//from pc
	input [($clog2(`ROM_DEPTH)-1):0] instr_addr_i_pc_ifu,
	
	//from ROM
	input [(`DATA_WIDTH-1):0] instr_i_rom_ifu,
	
	//to ROM
	output [($clog2(`ROM_DEPTH)-1):0] instr_addr_o_ifu_rom,

	//to idu
	output [(`DATA_WIDTH-1):0] instr_o_ifu_ifu2idu,
	output [($clog2(`ROM_DEPTH)-1):0] instr_addr_o_ifu_ifu2idu
);

	assign instr_o_ifu_ifu2idu = instr_i_rom_ifu;
	assign instr_addr_o_ifu_rom = instr_addr_i_pc_ifu;
	assign instr_addr_o_ifu_ifu2idu = instr_addr_i_pc_ifu;


endmodule
