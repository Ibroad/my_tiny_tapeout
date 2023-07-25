`define DATA_WIDTH 32
`define ROM_DEPTH 4096


`define INSTR_NOP 32'b0000_0000_0000_0000_0000_0000_0001_0011

// I type instr
// opcode
`define INSTR_TYPE_I 7'b0010011 
//funct3
`define INSTR_ADDI 3'b000


// R type instr
// opcode
`define INSTR_TYPE_R 7'b0110011
//funct3
`define INSTR_ADD_SUB 3'b000

//funct7
`define INSTR_ADD 7'b0000000
`define INSTR_SUB 7'b0100000

// B type instr
// opcode
`define INSTR_TYPE_B 7'b1100011
// funct3
`define INSTR_BNE 3'b001

// JAL
`define INSTR_JAL 7'b1101111

// U type instr
`define INSTR_LUI 7'b0110111
