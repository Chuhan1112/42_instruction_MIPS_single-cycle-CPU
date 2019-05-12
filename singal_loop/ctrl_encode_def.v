// NPC control signal
`define NPC_PLUS4   2'b00
`define NPC_BRANCH  2'b01
`define NPC_JUMP    2'b10
`define NPC_JR      2'b11
// EXT control signal
`define EXT_ZERO    2'b00
`define EXT_SIGNED  2'b01
`define EXT_HIGHPOS 2'b10
`define EXT_J       2'b11

// ALU control signal
`define ALU_NOP   6'b000000 
`define ALU_ADD   6'b000001
`define ALU_SUB   6'b000010 
`define ALU_AND   6'b000011
`define ALU_OR    6'b000100
`define ALU_SLT   6'b000101
`define ALU_SLTU  6'b000110
`define ALU_XOR   6'b000111
`define ALU_NOR   6'b001000
`define ALU_SLL   6'b001001
`define ALU_SRL   6'b001010
`define ALU_SLLV  6'b001011
`define ALU_SRLV  6'b001100
`define ALU_SRAV  6'b001101
`define ALU_LUI   6'b001110
`define ALU_BGEZ  6'b001111
`define ALU_BGTZ  6'b010000
`define ALU_SRA   6'b010001