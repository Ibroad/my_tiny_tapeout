import cocotb
import cocotb
import typing

from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

from cocotb.binary import BinaryValue




def read_hex_values_from_file(file_path):
    hex_array = []
    with open(file_path, "r") as fp:
        hex_str_array = fp.read().split("\n")
    for hex_str in hex_str_array:
        try:
            hex_int = int(hex_str, 16)
            hex_array.append(hex_int)
        except ValueError:
            pass
    return hex_array

hex_array = read_hex_values_from_file("rv32ui-p-add.txt")

@cocotb.test()
async def test_my_design(dut):
    # print(dir(dut.u_rv_soc.u_rom))
    
    dut.u_rv_soc.u_rom.rom_mem.value = hex_array + [0] * (4096 - len(hex_array))

    x3 = dut.u_rv_soc.u_rv_core.u_ram.ram_regs[3]
    x26 = dut.u_rv_soc.u_rv_core.u_ram.ram_regs[26]
    x27 = dut.u_rv_soc.u_rv_core.u_ram.ram_regs[27]



    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="ns")



    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("reset")
    dut.rst_n.value =    0
    await Timer(15, units="ns")
    dut.rst_n.value = 1


    while x26.value.binstr != BinaryValue(value=1, n_bits=32, bigEndian=False).binstr:
        dut._log.info("in loop")
        dut._log.info(x26.value.binstr)
        await RisingEdge(dut.clk)
    await Timer(1, units='ns')  # Optional delay after the trigger

    # Wait for 200ns to elapse5
    await Timer(200, units='ns')

    if x27.value.binstr == BinaryValue(value=1, n_bits=32, bigEndian=False).binstr:
        cocotb.log.info("########  pass  !!!#########")
 
    else:
        cocotb.log.info("########  fail  !!!#########")
        cocotb.log.info("fail testnum = " + str(x27.value.integer))







