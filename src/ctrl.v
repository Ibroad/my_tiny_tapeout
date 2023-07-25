module ctrl(
    input [31:0] jump_to_addr_i_exu_ctrl,
    input        jump_en_i_exu_ctrl,
    input        hold_flag_i_exu_ctrl,

    output reg [31:0] jump_to_addr_o_ctrl,
    output reg jump_en_o_ctrl,
    output reg hold_flag_o_ctrl
);

    always @(*) begin
        jump_to_addr_o_ctrl = jump_en_i_exu_ctrl;
        jump_en_o_ctrl = jump_en_i_exu_ctrl;
        
        if (jump_to_addr_i_exu_ctrl || hold_flag_i_exu_ctrl) begin
            hold_flag_o_ctrl = 1'b1;
        end else begin
            hold_flag_o_ctrl = 1'b0;
        end
    end


 


endmodule