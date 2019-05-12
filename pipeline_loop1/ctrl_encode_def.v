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
`define ALUOp_NOP   5'b00000 
`define ALUOp_ADDU  5'b00001
`define ALUOp_ADD   5'b00010
`define ALUOp_SUBU  5'b00011
`define ALUOp_SUB   5'b00100 
`define ALUOp_AND   5'b00101
`define ALUOp_OR    5'b00110
`define ALUOp_NOR   5'b00111
`define ALUOp_XOR   5'b01000
`define ALUOp_SLT   5'b01001
`define ALUOp_SLTU  5'b01010 
`define ALUOp_EQL   5'b01011
`define ALUOp_BNE   5'b01100
`define ALUOp_GT0   5'b01101
`define ALUOp_GE0   5'b01110
`define ALUOp_LT0   5'b01111
`define ALUOp_LE0   5'b10000
`define ALUOp_SLL   5'b10001
`define ALUOp_SRL   5'b10010
`define ALUOp_SRA   5'b10011
`define ALUOp_MULTU 5'b10100
`define ALUOp_DIVU  5'b10101

//MemtoReg
`define WDSel_FromALU 2'b00     //RD
`define WDSel_FromMEM 2'b01     //RT
`define WDSel_FromPC  2'b10     //31

// Memory control signal
`define BE_SB  2'b00
`define BE_SH  2'b01
`define BE_SW  2'b10

`define ME_LB  3'b000
`define ME_LBU 3'b001
`define ME_LH  3'b010
`define ME_LHU 3'b011
`define ME_LW  3'b100

`define FC_NOP 3'b000
`define FC_EMtoRs 3'b001
`define FC_EMtoRt 3'b010
`define FC_MWtoRs 3'b011
`define FC_MWtoRt 3'b100
`define FC_AMWtoRs 3'b101
`define FC_AMWtoRt 3'b110