SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/tb_tt_um_Ibroad_rv_soc.v 

VERILOG_SOURCES += $(PWD)/defines.v $(PWD)/ctrl.v $(PWD)/dff_set.v $(PWD)/exu.v $(PWD)/idu.v $(PWD)/idu2exu.v $(PWD)/ifu.v $(PWD)/ifu2idu.v $(PWD)/pc.v $(PWD)/ram.v $(PWD)/rom.v $(PWD)/rv_core.v $(PWD)/tt_um_Ibroad_rv_soc.v 


TOPLEVEL = tb_tt_um_Ibroad_rv_soc

MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim
