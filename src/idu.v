`include "defines.v"

module idu

(
	//from ifu
	input [(`DATA_WIDTH-1):0] instr_i_ifu2idu_idu,
	input [($clog2(`ROM_DEPTH)-1):0] instr_addr_i_ifu2idu_idu,

	//to ram
	output reg [4:0] rs1_addr_o_idu_ram,
	output reg [4:0] rs2_addr_o_idu_ram,

	//from ram
	input [(`DATA_WIDTH-1):0] rs1_data_i_ram_idu,
	input [(`DATA_WIDTH-1):0] rs2_data_i_ram_idu, 

	//to exu
	output [(`DATA_WIDTH-1):0] instr_o_ifu2idu_exu,
	output [($clog2(`ROM_DEPTH)-1):0] instr_addr_o_ifu2idu_exu,
	output reg [(`DATA_WIDTH-1):0] op1_data_o_idu_exu,
	output reg [(`DATA_WIDTH-1):0] op2_data_o_idu_exu,
	output reg [4:0] rd_addr_o_idu_exu,
	output reg wen_ram_o_idu_exu
);
	assign instr_o_ifu2idu_exu = instr_i_ifu2idu_idu;
	assign instr_addr_o_ifu2idu_exu = instr_addr_i_ifu2idu_idu;


	wire [6:0] 	opcode = instr_i_ifu2idu_idu[6:0];
	wire [2:0] 	funct3 = instr_i_ifu2idu_idu[14:12];
	wire [11:0] imm    = instr_i_ifu2idu_idu[31:20];
	wire [4:0] 	rs1    = instr_i_ifu2idu_idu[19:15];
	wire [4:0] 	rs2    = instr_i_ifu2idu_idu[24:20];
	wire [4:0] 	rd     = instr_i_ifu2idu_idu[11:7];
	wire [6:0] 	funct7 = instr_i_ifu2idu_idu[31:25];
	


	always @(*)
	  begin
		case(opcode)
			`INSTR_TYPE_I: 
			  begin
				case(funct3)
					//addi
				    `INSTR_ADDI:
					  begin
						rs1_addr_o_idu_ram = rs1;
						rs2_addr_o_idu_ram = 5'd0;
						op1_data_o_idu_exu = rs1_data_i_ram_idu;
						op2_data_o_idu_exu = {{20{imm[11]}},imm};
						rd_addr_o_idu_exu = rd;
						wen_ram_o_idu_exu = 1'b1;
					  end
					default:
					  begin
						rs1_addr_o_idu_ram = 5'd0;
						rs2_addr_o_idu_ram = 5'd0;
						op1_data_o_idu_exu = 32'd0;
						op2_data_o_idu_exu = 32'd0;
						rd_addr_o_idu_exu = 5'd0;
						wen_ram_o_idu_exu = 1'b0;
					  end
				endcase
			  end
			`INSTR_TYPE_R:
				case(funct3)
					`INSTR_ADD_SUB:
					  begin
						rs1_addr_o_idu_ram = rs1;
						rs2_addr_o_idu_ram = rs2;
						op1_data_o_idu_exu = rs1_data_i_ram_idu;
						op2_data_o_idu_exu = rs2_data_i_ram_idu;
						rd_addr_o_idu_exu  = rd;
						wen_ram_o_idu_exu = 1'b1;
					  end
					default:
					  begin
						rs1_addr_o_idu_ram = 5'd0;
                        rs2_addr_o_idu_ram = 5'd0;
                        op1_data_o_idu_exu = 32'd0;
                        op2_data_o_idu_exu = 32'd0;
                        rd_addr_o_idu_exu  = 5'd0;
                        wen_ram_o_idu_exu = 1'b0;
					  end
				endcase
			`INSTR_TYPE_B:
				case(funct3)
					`INSTR_BNE:
					  begin
						rs1_addr_o_idu_ram = rs1;
						rs2_addr_o_idu_ram = rs2;
						op1_data_o_idu_exu = rs1_data_i_ram_idu;
						op2_data_o_idu_exu = rs2_data_i_ram_idu;
						rd_addr_o_idu_exu  = 5'b00000;
						wen_ram_o_idu_exu = 1'b0;
					  end
					default:
					  begin
						rs1_addr_o_idu_ram = 5'd0;
                        rs2_addr_o_idu_ram = 5'd0;
                        op1_data_o_idu_exu = 32'd0;
                        op2_data_o_idu_exu = 32'd0;
                        rd_addr_o_idu_exu  = 5'd0;
                        wen_ram_o_idu_exu = 1'b0;
					  end
				endcase
			`INSTR_JAL: begin
				rs1_addr_o_idu_ram = 5'b00000;
				rs2_addr_o_idu_ram = 5'b00000;
				op1_data_o_idu_exu = 32'd0;
				op2_data_o_idu_exu = 32'd0;
				rd_addr_o_idu_exu  = rd;
				wen_ram_o_idu_exu = 1'b1;
			end
			`INSTR_LUI: begin
				rs1_addr_o_idu_ram = 5'b00000;
				rs2_addr_o_idu_ram = 5'b00000;
				op1_data_o_idu_exu = 32'd0;
				op2_data_o_idu_exu = 32'd0;
				rd_addr_o_idu_exu  = rd;
				wen_ram_o_idu_exu = 1'b1;
			end
			default:
			  begin
				rs1_addr_o_idu_ram = 5'd0;
				rs2_addr_o_idu_ram = 5'd0;
				op1_data_o_idu_exu = 32'd0;
				op2_data_o_idu_exu = 32'd0;
				rd_addr_o_idu_exu = rd;
				wen_ram_o_idu_exu = 1'b1;
			  end
		endcase

	  end		
	
	




endmodule
