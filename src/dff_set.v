////////////////////////////////////////////////
/* 

dff_set u_dff_set # (32)
(
	.clk(),
	.rstn(),
	.data_in(),
	.data_set(),
	.data_out()
)

*/
////////////////////////////////////////////////

module dff_set #
(
	parameter DATA_WIDTH = 32
)
(
	input clk,
	input rstn,

	input [DATA_WIDTH-1:0] data_in,
	input [DATA_WIDTH-1:0] data_set,
	output reg [DATA_WIDTH-1:0] data_out
);
	// reg [DATA_WIDTH-1:0] data_out_reg;

	always @(posedge clk)
	  begin
		if (!rstn)
			data_out <= data_set;
		else
			data_out <= data_in;
	  end
	
	// assign data_out = data_out_reg;

endmodule
