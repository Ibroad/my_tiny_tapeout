`include "defines.v"

module pc
(
	input clk,
	input rstn,
	input jump_en_i_ctrl_pc,
	input [31:0] jump_to_addr_i_ctrl_pc,
	output reg [($clog2(`ROM_DEPTH)-1):0] instr_addr_o_pc_ifu // pc reg: 32 bit
);

	always @(posedge clk)
	  begin
		if (!rstn)
			instr_addr_o_pc_ifu <= 0;
		else if(jump_en_i_ctrl_pc)
			instr_addr_o_pc_ifu <= jump_to_addr_i_ctrl_pc;
		else
			instr_addr_o_pc_ifu <= instr_addr_o_pc_ifu + 3'd4;
	  end

endmodule