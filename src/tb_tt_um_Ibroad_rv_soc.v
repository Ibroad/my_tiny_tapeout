`default_nettype none
`timescale 1ns/1ps

module tb_tt_um_Ibroad_rv_soc;

    // iverilog
    initial begin
        $dumpfile ("wave.vcd");
        $dumpvars (0, tb_tt_um_Ibroad_rv_soc);
    end

    reg clk;
    reg rst_n;

    tt_um_Ibroad_rv_soc u_rv_soc (
        .clk(clk),
        .rst_n(rst_n)
    );

    // // clk
    // initial begin
    //     clk = 1'b0;
    //     forever #10 clk = ~clk;
    // end

    // initial begin
    //     rstn = 1;
    //     #5;
    //     rstn = 0;
    //     #10;
    //     rstn  = 1;
    // end

    // wire x3 = tb_tt_um_Ibroad_rv_soc.u_rv_soc.u_rv_core.u_ram.ram_regs[3];
	// wire x26 = tb_tt_um_Ibroad_rv_soc.u_rv_soc.u_rv_core.u_ram.ram_regs[26];
	// wire x27 = tb_tt_um_Ibroad_rv_soc.u_rv_soc.u_rv_core.u_ram.ram_regs[27];

    // initial begin
    //     $readmemh("rv32ui-p-add.txt",tb_tt_um_Ibroad_rv_soc.u_rv_soc.u_rv_core.u_rom.rom_mem);
    // end

    // initial begin

    //     wait(x26 == 32'b1);
		
	// 	#200;
	// 	if(x27 == 32'b1) begin
	// 		$display("############################");
	// 		$display("########  pass  !!!#########");
	// 		$display("############################");
	// 	end
	// 	else begin
	// 		$display("############################");
	// 		$display("########  fail  !!!#########");
	// 		$display("############################");
	// 		$display("fail testnum = %2d", x3);
    //     end

    // end



endmodule