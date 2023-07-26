`include "defines.v"

module idu2exu
(
	input clk,
	input rstn,

	input [(`DATA_WIDTH-1):0] instr_i_idu_idu2exu,
	input [($clog2(`ROM_DEPTH)-1):0] instr_addr_i_idu_idu2exu,


	input [(`DATA_WIDTH-1):0] op1_data_i_idu_idu2exu,
	input [(`DATA_WIDTH-1):0] op2_data_i_idu_idu2exu,
	input [4:0] rd_addr_i_idu_idu2exu,
	input wen_ram_i_idu_idu2exu,

	input hold_flag_i_ctrl_idu2exu,


	output [(`DATA_WIDTH-1):0] instr_o_idu2exu_exu,
	output [($clog2(`ROM_DEPTH)-1):0] instr_addr_o_idu2exu_exu,

	output [(`DATA_WIDTH-1):0] op1_data_o_idu2exu_exu,
	output [(`DATA_WIDTH-1):0] op2_data_o_idu2exu_exu,
	output [4:0] rd_addr_o_idu2exu_exu,
	output wen_ram_o_idu2exu_exu


);
	wire rst_n;

	assign rst_n = (rstn == 1'b0 || hold_flag_i_ctrl_idu2exu == 1'b1) ? 1'b0 : 1'b1;

	dff_set dff_set_instr
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(instr_i_idu_idu2exu),
		.data_set(`INSTR_NOP),
		.data_out(instr_o_idu2exu_exu)
	);

	dff_set #($clog2(`ROM_DEPTH)) dff_set_instr_addr
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(instr_addr_i_idu_idu2exu),
		.data_set(12'd0),
		.data_out(instr_addr_o_idu2exu_exu)
	);
	dff_set dff_set_op1
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(op1_data_i_idu_idu2exu),
		.data_set(32'd0),
		.data_out(op1_data_o_idu2exu_exu)
	);
	dff_set dff_set_op2
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(op2_data_i_idu_idu2exu),
		.data_set(32'd0),
		.data_out(op2_data_o_idu2exu_exu)
	);

	dff_set #(5) dff_set_rd_addr
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(rd_addr_i_idu_idu2exu),
		.data_set(5'd0),
		.data_out(rd_addr_o_idu2exu_exu)
	);

	dff_set #(1) dff_set_wen
	(
		.clk(clk),
		.rstn(rst_n),
		.data_in(wen_ram_i_idu_idu2exu),
		.data_set(1'b0),
		.data_out(wen_ram_o_idu2exu_exu)
	);




	

endmodule
