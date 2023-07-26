`default_nettype none

`include "defines.v"

module tt_um_Ibroad_rv_soc (
	input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n 


);

	wire [(`DATA_WIDTH-1):0]	instr_rom_core;
	wire [($clog2(`ROM_DEPTH)-1):0]	instr_addr_core_rom;


	rv_core u_rv_core 
	(
		.clk			(clk),
		.rstn			(rst_n),
		.instr_i		(instr_rom_core),
		.instr_addr_o	(instr_addr_core_rom)
	);

	rom u_rom
	(
		.instr_addr_i	(instr_addr_core_rom),
		.instr_o		(instr_rom_core)
	);
	
	

endmodule
	
