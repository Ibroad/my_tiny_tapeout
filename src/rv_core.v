`include "defines.v"

module rv_core (
	input clk,
	input rstn,
	input [(`DATA_WIDTH-1):0] instr_i,
	output [($clog2(`ROM_DEPTH)-1):0] instr_addr_o

);
	//pc - ifu
	wire [($clog2(`ROM_DEPTH)-1):0] instr_addr_pc_ifu;
    
	//ifu - ifu2idu
    wire [(`DATA_WIDTH-1):0] instr_ifu_ifu2idu;
    wire [($clog2(`ROM_DEPTH)-1):0] instr_addr_ifu_ifu2idu;

	//ifu2idu - idu
	wire [(`DATA_WIDTH-1):0] instr_ifu2idu_idu;
	wire [($clog2(`ROM_DEPTH)-1):0] instr_addr_ifu2idu_idu;

	//idu - ram
	wire [4:0] rs1_addr_idu_ram;
	wire [4:0] rs2_addr_idu_ram;
	wire [(`DATA_WIDTH-1):0] rs1_data_ram_idu;
	wire [(`DATA_WIDTH-1):0] rs2_data_ram_idu;

	//idu - idu2exu
	wire [(`DATA_WIDTH-1):0] instr_idu_idu2exu;
	wire [($clog2(`ROM_DEPTH)-1):0] instr_addr_idu_idu2exu;
	wire [(`DATA_WIDTH-1):0] op1_data_idu_idu2exu;
	wire [(`DATA_WIDTH-1):0] op2_data_idu_idu2exu;
	wire [4:0] rd_addr_idu_idu2exu;
	wire wen_ram_idu_idu2exu;
	
	//idu2exu - exu
	wire [(`DATA_WIDTH-1):0] instr_idu2exu_exu;
	wire [($clog2(`ROM_DEPTH)-1):0] instr_addr_idu2exu_exu;
	wire [(`DATA_WIDTH-1):0] op1_data_idu2exu_exu;
	wire [(`DATA_WIDTH-1):0] op2_data_idu2exu_exu;
	wire [4:0] rd_addr_idu2exu_exu;
	wire wen_ram_idu2exu_exu;

	//exu - ram
	wire [(`DATA_WIDTH-1):0] rd_data_exu_ram;
	wire [4:0] rd_addr_exu_ram;
	wire wen_ram_exu_ram;

	//exu - ctrl
	wire [31:0] jump_to_addr_exu_ctrl;
	wire jump_en_exu_ctrl;
	wire hold_flag_exu_ctrl;

	//ctrl - idu2exu / ifu2idu
	wire hold_flag_ctrl;

	//ctrl - pc

	wire [31:0] jump_to_addr_ctrl_pc;
	wire jump_en_ctrl_pc;



    pc u_pc (
        .clk(clk),
        .rstn(rstn),
		.jump_en_i_ctrl_pc(jump_en_ctrl_pc),
		.jump_to_addr_i_ctrl_pc(jump_to_addr_ctrl_pc),
        .instr_addr_o_pc_ifu(instr_addr_pc_ifu)
    );
	
	ifu u_ifu (
		.instr_addr_i_pc_ifu(instr_addr_pc_ifu),
		.instr_i_rom_ifu(instr_i),
		.instr_addr_o_ifu_rom(instr_addr_o),
		.instr_o_ifu_ifu2idu(instr_ifu_ifu2idu),
		.instr_addr_o_ifu_ifu2idu(instr_addr_ifu_ifu2idu)
	);
	

	ifu2idu u_ifu2idu (
		.clk(clk),
		.rstn(rstn),
		.instr_i_ifu_ifu2idu(instr_ifu_ifu2idu),
		.instr_addr_i_ifu_ifu2idu(instr_addr_ifu_ifu2idu),
		.instr_o_ifu2idu_idu(instr_ifu2idu_idu),
		.instr_addr_o_ifu2idu_idu(instr_addr_ifu2idu_idu),
		.hold_flag_i_ctrl_ifu2idu(hold_flag_ctrl)
	);


	idu u_idu (
		.instr_i_ifu2idu_idu(instr_ifu2idu_idu),
		.instr_addr_i_ifu2idu_idu(instr_addr_ifu2idu_idu),
		.rs1_addr_o_idu_ram(rs1_addr_idu_ram),
		.rs2_addr_o_idu_ram(rs2_addr_idu_ram),
		.rs1_data_i_ram_idu(rs1_data_ram_idu),
		.rs2_data_i_ram_idu(rs2_data_ram_idu),
		.instr_o_ifu2idu_exu(instr_idu_idu2exu),
		.instr_addr_o_ifu2idu_exu(instr_addr_idu_idu2exu),
		.op1_data_o_idu_exu(op1_data_idu_idu2exu),
		.op2_data_o_idu_exu(op2_data_idu_idu2exu),
		.rd_addr_o_idu_exu(rd_addr_idu_idu2exu),
		.wen_ram_o_idu_exu(wen_ram_idu_idu2exu)
	);

	idu2exu u_idu2exu (
		.clk(clk),
		.rstn(rstn),
		.instr_i_idu_idu2exu(instr_idu_idu2exu),
		.instr_addr_i_idu_idu2exu(instr_addr_idu_idu2exu),
		.op1_data_i_idu_idu2exu(op1_data_idu_idu2exu),
		.op2_data_i_idu_idu2exu(op2_data_idu_idu2exu),
		.rd_addr_i_idu_idu2exu(rd_addr_idu_idu2exu),
		.wen_ram_i_idu_idu2exu(wen_ram_idu_idu2exu),
		.instr_o_idu2exu_exu(instr_idu2exu_exu),
		.instr_addr_o_idu2exu_exu(instr_addr_idu2exu_exu),
		.op1_data_o_idu2exu_exu(op1_data_idu2exu_exu),
		.op2_data_o_idu2exu_exu(op2_data_idu2exu_exu),
		.rd_addr_o_idu2exu_exu(rd_addr_idu2exu_exu),
		.wen_ram_o_idu2exu_exu(wen_ram_idu2exu_exu),
		.hold_flag_i_ctrl_idu2exu(hold_flag_ctrl)
	);

	exu u_exu (
		.instr_i_idu2exu_exu(instr_idu2exu_exu),
		.instr_addr_i_idu2exu_exu(instr_addr_idu2exu_exu),
		.op1_data_i_idu2exu_exu(op1_data_idu2exu_exu),
		.op2_data_i_idu2exu_exu(op2_data_idu2exu_exu),
		.rd_addr_i_idu2exu_exu(rd_addr_idu2exu_exu),
		.wen_ram_i_idu2exu_exu(wen_ram_idu2exu_exu),
		.rd_addr_o_exu_ram(rd_addr_exu_ram),
		.rd_data_o_exu_ram(rd_data_exu_ram),
		.wen_ram_o_exu_ram(wen_ram_exu_ram)
	);

	
	ram u_ram (
		.clk(clk),
		.rstn(rstn),
		.rs1_addr_i_idu_ram(rs1_addr_idu_ram),
		.rs2_addr_i_idu_ram(rs2_addr_idu_ram),
		.rs1_data_o_ram_idu(rs1_data_ram_idu),
		.rs2_data_o_ram_idu(rs2_data_ram_idu),
		.rd_addr_i_exu_ram(rd_addr_exu_ram),
		.rd_data_i_exu_ram(rd_data_exu_ram),
		.wen_ram_i_exu_ram(wen_ram_exu_ram)
	);

	ctrl u_ctrl (
		.jump_to_addr_i_exu_ctrl(jump_to_addr_exu_ctrl),
		.jump_en_i_exu_ctrl(jump_en_exu_ctrl),
		.hold_flag_i_exu_ctrl(hold_flag_exu_ctrl),

		.jump_to_addr_o_ctrl(jump_to_addr_ctrl_pc),
		.jump_en_o_ctrl(jump_en_ctrl_pc),
		.hold_flag_o_ctrl(hold_flag_ctrl)

	);

endmodule
	
