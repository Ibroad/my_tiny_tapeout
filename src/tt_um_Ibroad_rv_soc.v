`default_nettype none

`include "defines.v"

module tt_um_Ibroad_rv_soc (
	input clk,
	input ena,
	input rstn

);

	wire [(`DATA_WIDTH-1):0]	instr_rom_core;
	wire [($clog2(`ROM_DEPTH)-1):0]	instr_addr_core_rom;


	rv_core u_rv_core 
	(
		.clk			(clk),
		.rstn			(rstn),
		.instr_i		(instr_rom_core),
		.instr_addr_o	(instr_addr_core_rom)
	);

	rom u_rom
	(
		.instr_addr_i	(instr_addr_core_rom),
		.instr_o		(instr_rom_core)
	);
	
	

endmodule
	
