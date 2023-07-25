`include "defines.v"

module exu
(
	input [(`DATA_WIDTH-1):0] instr_i_idu2exu_exu,
	input [($clog2(`ROM_DEPTH)-1):0] instr_addr_i_idu2exu_exu,
	input [(`DATA_WIDTH-1):0] op1_data_i_idu2exu_exu,
	input [(`DATA_WIDTH-1):0] op2_data_i_idu2exu_exu,
	input [4:0] rd_addr_i_idu2exu_exu,
	input wen_ram_i_idu2exu_exu,

	//to ram
	output reg [4:0] rd_addr_o_exu_ram,
	output reg [(`DATA_WIDTH-1):0] rd_data_o_exu_ram,
	output reg wen_ram_o_exu_ram,

	// to ctrl
	output reg [31:0] jump_to_addr_o_exu_ctrl,
	output reg jump_en_o_exu_ctrl,
	output reg hold_flag_o_exu_ctrl
	);

    wire [6:0] 	opcode = instr_i_idu2exu_exu[6:0];
    wire [2:0] 	funct3 = instr_i_idu2exu_exu[14:12];
    wire [11:0] imm    = instr_i_idu2exu_exu[31:20];
    wire [4:0] 	rs1    = instr_i_idu2exu_exu[19:15];
    wire [4:0] 	rs2    = instr_i_idu2exu_exu[24:20];
    wire [4:0] 	rd     = instr_i_idu2exu_exu[11:7];
    wire [6:0] 	funct7 = instr_i_idu2exu_exu[31:25];


	// branch decode
	wire [31:0] branch_imm = {{19{instr_i_idu2exu_exu[31]}}, instr_i_idu2exu_exu[31], instr_i_idu2exu_exu[7], instr_i_idu2exu_exu[30:25], instr_i_idu2exu_exu[11:8], 1'b0};
	wire op1_not_equal_op2 = (op1_data_i_idu2exu_exu == op2_data_i_idu2exu_exu) ? 1'b0 : 1'b1;

	// jal decode
	wire [31:0] jal_imm = {{12{instr_i_idu2exu_exu[31]}}, instr_i_idu2exu_exu[19:12], instr_i_idu2exu_exu[20], instr_i_idu2exu_exu[30:21], 1'b0};

	// lui decode
	wire [31:0] lui_imm = {instr_i_idu2exu_exu, 12'd0};

    always @(*)
      begin
        case(opcode)
            `INSTR_TYPE_I:
              begin
				jump_to_addr_o_exu_ctrl = 0;
				jump_en_o_exu_ctrl = 0;
				hold_flag_o_exu_ctrl = 0;
                case(funct3)
                    //addi
                    `INSTR_ADDI: 
					  begin
						rd_addr_o_exu_ram = rd_addr_i_idu2exu_exu;
						rd_data_o_exu_ram = op1_data_i_idu2exu_exu + op2_data_i_idu2exu_exu;
						wen_ram_o_exu_ram = wen_ram_i_idu2exu_exu;
                      end
                    default:
                      begin
						rd_addr_o_exu_ram = 5'd0;
						rd_data_o_exu_ram = 32'd0;
						wen_ram_o_exu_ram = 1'b0;
                      end
                endcase
              end
			`INSTR_TYPE_R:
			  begin
				jump_to_addr_o_exu_ctrl = 0;
				jump_en_o_exu_ctrl = 0;
				hold_flag_o_exu_ctrl = 0;
				case(funct3)
					//add & sub
					`INSTR_ADD_SUB:
						case(funct7)
							`INSTR_ADD:
							  begin
								rd_addr_o_exu_ram = rd_addr_i_idu2exu_exu;
								rd_data_o_exu_ram = op1_data_i_idu2exu_exu + op2_data_i_idu2exu_exu;
								wen_ram_o_exu_ram = wen_ram_i_idu2exu_exu;
							  end
							`INSTR_SUB:
							  begin
                                rd_addr_o_exu_ram = rd_addr_i_idu2exu_exu;
                                rd_data_o_exu_ram = op1_data_i_idu2exu_exu - op2_data_i_idu2exu_exu;
                                wen_ram_o_exu_ram = wen_ram_i_idu2exu_exu;
                              end
							default: 
							  begin
								rd_addr_o_exu_ram = 5'd0;
                                rd_data_o_exu_ram = 32'd0;
                                wen_ram_o_exu_ram = 1'b0;
							  end
						endcase
					default: 
					  begin
						rd_addr_o_exu_ram = 5'd0;
                    	rd_data_o_exu_ram = 32'd0;
                        wen_ram_o_exu_ram = 1'b0;
                      end
				endcase
			  end
			`INSTR_TYPE_B:
			  begin
				rd_addr_o_exu_ram = 5'd0;
				rd_data_o_exu_ram = 32'd0;
				wen_ram_o_exu_ram = 1'b0;
				case (funct3)
					`INSTR_BNE:
					  begin
						jump_to_addr_o_exu_ctrl = instr_addr_i_idu2exu_exu + branch_imm;
						jump_en_o_exu_ctrl = op1_not_equal_op2;
						hold_flag_o_exu_ctrl = 1'b0;
					  end
					default:
					  begin
						jump_to_addr_o_exu_ctrl = 32'd0;
						jump_en_o_exu_ctrl = 32'b0;
						hold_flag_o_exu_ctrl = 1'b0;
					  end
				endcase
			  end
			`INSTR_JAL:
			  begin
				rd_addr_o_exu_ram = rd;
				rd_data_o_exu_ram = instr_addr_i_idu2exu_exu + 32'd4;
				wen_ram_o_exu_ram = 1'b1;
				jump_to_addr_o_exu_ctrl = instr_addr_i_idu2exu_exu + jal_imm;
				jump_en_o_exu_ctrl = 1'b1;
				hold_flag_o_exu_ctrl = 1'b0;
			  end
			`INSTR_LUI:
			  begin
				rd_addr_o_exu_ram = rd;
				rd_data_o_exu_ram = lui_imm;
				wen_ram_o_exu_ram = 1'b1;
				jump_to_addr_o_exu_ctrl = 32'd0;
				jump_en_o_exu_ctrl = 1'b0;
				hold_flag_o_exu_ctrl = 1'b0;
			  end
            default:
              begin
				jump_to_addr_o_exu_ctrl = 32'b0;
				jump_en_o_exu_ctrl = 1'b0;
				hold_flag_o_exu_ctrl = 1'b0;
				rd_addr_o_exu_ram = 5'd0;
				rd_data_o_exu_ram = 32'd0;
				wen_ram_o_exu_ram = 1'b0;
              end
        endcase

      end


endmodule
