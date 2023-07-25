`include "defines.v"

module ifu2idu

(
	input clk,
	input rstn,
	
	//from ifu
	input [(`DATA_WIDTH-1):0] instr_i_ifu_ifu2idu,
	input [($clog2(`ROM_DEPTH)-1):0]  instr_addr_i_ifu_ifu2idu,	

	//from ctrl
	input hold_flag_i_ctrl_ifu2idu,

	//to idu
	output [(`DATA_WIDTH-1):0] instr_o_ifu2idu_idu,
	output [($clog2(`ROM_DEPTH)-1):0] instr_addr_o_ifu2idu_idu

);
	assign rst_n = (rstn == 1'b0 || hold_flag_i_ctrl_ifu2idu == 1'b1) ? 1'b0 : 1'b1;

	dff_set dff_set_instr
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(instr_i_ifu_ifu2idu),
		.data_set(`INSTR_NOP),
		.data_out(instr_o_ifu2idu_idu)
	);

	dff_set #($clog2(`ROM_DEPTH)) dff_set_addr
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(instr_addr_i_ifu_ifu2idu),
		.data_set(12'd0),
		.data_out(instr_addr_o_ifu2idu_idu)
	);


endmodule
