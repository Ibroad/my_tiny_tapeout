`include "defines.v"

// 32 general registers with x0 always equal to zero. The lenth of a register for RV64 = 64; The lenth of a register for RV32 = 32

module ram

(
	input clk,
	input rstn,


	//from idu
	input [4:0] rs1_addr_i_idu_ram,
	input [4:0] rs2_addr_i_idu_ram,

	//to idu
	output reg [(`DATA_WIDTH-1):0] rs1_data_o_ram_idu,
	output reg [(`DATA_WIDTH-1):0] rs2_data_o_ram_idu,
	
	//from exu
	input [4:0] rd_addr_i_exu_ram,
	input [(`DATA_WIDTH-1):0] rd_data_i_exu_ram,
	input wen_ram_i_exu_ram
);

	reg [(`DATA_WIDTH-1):0] ram_regs [0:(`DATA_WIDTH-1)];

	always @(*)
	  begin
		if (!rstn)
			rs1_data_o_ram_idu = 32'd0;
		else
		  begin
			if (rs1_addr_i_idu_ram == 5'b00000)
				rs1_data_o_ram_idu = 32'd0;
			else if (wen_ram_i_exu_ram && (rs1_addr_i_idu_ram == rd_addr_i_exu_ram))
				rs1_data_o_ram_idu = rd_data_i_exu_ram;
			else
				rs1_data_o_ram_idu = ram_regs[rs1_addr_i_idu_ram];
		  end
	  end		

	always @(*)
	  begin
		if (!rstn)
			rs2_data_o_ram_idu = 32'd0;
		else
		  begin
			if (rs2_addr_i_idu_ram == 5'b00000)
				rs2_data_o_ram_idu = 32'd0;
			else if (wen_ram_i_exu_ram && (rs2_addr_i_idu_ram == rd_addr_i_exu_ram))
				rs2_data_o_ram_idu = rd_data_i_exu_ram;
			else 
				rs2_data_o_ram_idu = ram_regs[rs2_addr_i_idu_ram];
		  end
	  end	

	integer i;
		
	always @(posedge clk)
	  begin
		if (!rstn)
			for(i=0;i<32;i=i+1)
				ram_regs[i] <= 0;
		else
		  begin
			if (wen_ram_i_exu_ram && (rd_addr_i_exu_ram != 5'd0))
				ram_regs[rd_addr_i_exu_ram] <= rd_data_i_exu_ram;
		  end
	  end


endmodule
