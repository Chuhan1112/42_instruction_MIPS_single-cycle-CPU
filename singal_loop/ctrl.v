// `include "ctrl_encode_def.v"


module ctrl(Op, Funct, Zero, 
            RegWrite, MemWrite,
            EXTOp, ALUOp, NPCOp, 
            ALUSrc, GPRSel, WDSel
            );
            
   input  [5:0] Op;       // opcode
   input  [5:0] Funct;    // funct
   input        Zero;
   
   output       RegWrite; // control signal for register write
   output       MemWrite; // control signal for memory write
   output       EXTOp;    // control signal to signed extension
   output [5:0] ALUOp;    // ALU opertion
   output [1:0] NPCOp;    // next pc operation
   output       ALUSrc;   // ALU source for A

   output [1:0] GPRSel;   // general purpose register selection
   output [1:0] WDSel;    // (register) write data selection
   
  // r format 0~ 1space
   wire rtype  = ~|Op;
   wire i_add  = rtype& Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&~Funct[0]; // add
   wire i_sub  = rtype& Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]& Funct[1]&~Funct[0]; // sub
   wire i_and  = rtype& Funct[5]&~Funct[4]&~Funct[3]& Funct[2]&~Funct[1]&~Funct[0]; // and
   wire i_or   = rtype& Funct[5]&~Funct[4]&~Funct[3]& Funct[2]&~Funct[1]& Funct[0]; // or
   wire i_slt  = rtype& Funct[5]&~Funct[4]& Funct[3]&~Funct[2]& Funct[1]&~Funct[0]; // slt
   wire i_sltu = rtype& Funct[5]&~Funct[4]& Funct[3]&~Funct[2]& Funct[1]& Funct[0]; // sltu
   wire i_addu = rtype& Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]& Funct[0]; // addu
   wire i_subu = rtype& Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]& Funct[1]& Funct[0]; // subu
   wire i_xor  = rtype& Funct[5]&~Funct[4]&~Funct[3]& Funct[2]& Funct[1]&~Funct[0]; // xor
   wire i_nor  = rtype& Funct[5]&~Funct[4]&~Funct[3]& Funct[2]& Funct[1]& Funct[0]; // nor
   wire i_sll  = rtype&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&~Funct[0]; // sll
   wire i_srl  = rtype&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]& Funct[1]&~Funct[0]; // srl
   wire i_sra  = rtype&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]& Funct[1]& Funct[0]; // sra
   wire i_sllv = rtype&~Funct[5]&~Funct[4]&~Funct[3]& Funct[2]&~Funct[1]&~Funct[0]; // sllv
   wire i_srlv = rtype&~Funct[5]&~Funct[4]&~Funct[3]& Funct[2]& Funct[1]&~Funct[0]; // srlv
   wire i_srav = rtype&~Funct[5]&~Funct[4]&~Funct[3]& Funct[2]& Funct[1]& Funct[0]; // srav

  // i format
   wire i_addi = ~Op[5]&~Op[4]& Op[3]&~Op[2]&~Op[1]&~Op[0]; // addi
   wire i_addiu= ~Op[5]&~Op[4]& Op[3]&~Op[2]&~Op[1]& Op[0]; // addiu
   wire i_andi = ~Op[5]&~Op[4]& Op[3]& Op[2]&~Op[1]&~Op[0]; // andi
   wire i_ori  = ~Op[5]&~Op[4]& Op[3]& Op[2]&~Op[1]& Op[0]; // ori
   wire i_xori = ~Op[5]&~Op[4]& Op[3]& Op[2]& Op[1]&~Op[0]; // xori
   wire i_lui  = ~Op[5]&~Op[4]& Op[3]& Op[2]& Op[1]& Op[0]; // lui 
   wire i_slti = ~Op[5]&~Op[4]& Op[3]&~Op[2]& Op[1]&~Op[0]; // slti
   wire i_sltiu= ~Op[5]&~Op[4]& Op[3]&~Op[2]& Op[1]&~Op[0]; // sltiu

   wire i_lw   =  Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0]; // lw
   wire i_lb   =  Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]&~Op[0]; // lb
   wire i_lbu  =  Op[5]&~Op[4]&~Op[3]& Op[2]&~Op[1]&~Op[0]; // lbu
   wire i_lh   =  Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]& Op[0]; // lh
   wire i_lhu  =  Op[5]&~Op[4]&~Op[3]& Op[2]&~Op[1]& Op[0]; // lhu
   wire i_sw   =  Op[5]&~Op[4]& Op[3]&~Op[2]& Op[1]& Op[0]; // sw
   wire i_sb   =  Op[5]&~Op[4]& Op[3]&~Op[2]&~Op[1]&~Op[0]; // sb
   wire i_sh   =  Op[5]&~Op[4]& Op[3]&~Op[2]&~Op[1]& Op[0]; // sh

   wire i_beq  = ~Op[5]&~Op[4]&~Op[3]& Op[2]&~Op[1]&~Op[0]; // beq
   wire i_bne  = ~Op[5]&~Op[4]&~Op[3]& Op[2]&~Op[1]& Op[0]; // bne
   wire i_bgez = ~Op[5]&~Op[4]&~Op[3]&~Op[2]&~Op[1]& Op[0]; // bgez bltz
   wire i_bgtz = ~Op[5]&~Op[4]&~Op[3]& Op[2]& Op[1]& Op[0]; // bgtz 
   wire i_blez = ~Op[5]&~Op[4]&~Op[3]& Op[2]& Op[1]&~Op[0]; // blez 
   //wire i_bltz =

  // j format
   wire i_j    = ~Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]&~Op[0];  // j
   wire i_jal  = ~Op[5]&~Op[4]&~Op[3]&~Op[2]& Op[1]& Op[0];  // jal
   wire i_jr   = rtype&~Funct[5]&~Funct[4]& Funct[3]&~Funct[2]&~Funct[1]&~Funct[0];  // jr opcode=0
   wire i_jalr = rtype&~Funct[5]&~Funct[4]& Funct[3]&~Funct[2]&~Funct[1]& Funct[0];  // jalr opcode=0

  // generate control signals
  assign RegWrite   = rtype | i_lw | i_lb | i_lbu | i_lh | i_lhu | i_addi | i_ori | i_xori | i_jal | i_sll | i_srl | i_sra | i_addiu | i_andi | i_lui | i_slti | i_sltiu | i_jalr; // register write
  
  assign MemWrite   = i_sw | i_sb | i_sh;                           // memory write
  //alusrc有效时表示第二个alu操作数为指令低16位的符号扩展
  assign ALUSrc     = i_lw | i_lb | i_lbu | i_lh | i_lhu | i_sw | i_sb | i_sh | i_addi | i_ori | i_xori | i_sll | i_srl | i_sra | i_addiu | i_andi | i_lui | i_slti | i_sltiu;   // ALU A is from instruction immediate
  // EXT control signal
//  EXT_ZERO    2'b00
//  EXT_SIGNED  2'b01
//  EXT_HIGHPOS 2'b10
//  EXT_J       2'b11
  assign EXTOp   = i_addi | i_lw | i_lb | i_lbu | i_lh | i_lhu | i_sw | i_sb | i_sh | i_addiu | i_andi | i_slti | i_sltiu;           // signed extension  lui:10

  //往哪个寄存器写
  // GPRSel_RD   2'b00
  // GPRSel_RT   2'b01
  // GPRSel_31   2'b10
  assign GPRSel[0] = i_lw | i_lb | i_lbu | i_lh | i_lhu | i_addi | i_ori | i_xori | i_addiu | i_andi | i_lui | i_slti | i_sltiu;
  assign GPRSel[1] = i_jal | i_jalr;
  
  // WDSel_FromALU 2'b00
  // WDSel_FromMEM 2'b01
  // WDSel_FromPC  2'b10 
  assign WDSel[0] = i_lw | i_lb | i_lbu | i_lh | i_lhu;
  assign WDSel[1] = i_jal;

  // NPC_PLUS4   2'b00
  // NPC_BRANCH  2'b01
  // NPC_JUMP    2'b10
  // NPC_JR      2'b11
  assign NPCOp[0] = i_beq & Zero | i_bne &~Zero | i_bgez &~Zero | i_bgtz &~Zero | i_blez & Zero | i_jr | i_jalr;
  assign NPCOp[1] = i_j | i_jal | i_jr | i_jalr;
  
  // ALU_NOP   6'b000000
  // ALU_ADD   6'b000001
  // ALU_SUB   6'b000010
  // ALU_AND   6'b000011
  // ALU_OR    6'b000100
  // ALU_SLT   6'b000101
  // ALU_SLTU  6'b000110
  // ALU_XOR   6'b000111
  // ALU_NOR   6'b001000
  // ALU_SLL   6'b001001
  // ALU_SRL   6'b001010
  // ALU_SLLV  6'b001011
  // ALU_SRLV  6'b001100
  // ALU_SRAV  6'b001101
  // ALU_LUI   6'b001110
  // ALU_BGEZ  6'b001111
  // ALU_BGTZ  6'b010000 i_blez
  // ALU_SRA   6'b010001
  
  assign ALUOp[0] = i_add | i_lw | i_lb | i_lbu | i_lh | i_lhu | i_sw | i_sb | i_sh | i_addi | i_addiu | i_and | i_andi | i_slt | i_slti | i_addu | i_xor | i_xori | i_sll | i_sllv | i_srav | i_bgez;
  assign ALUOp[1] = i_sub | i_beq | i_bne | i_and | i_andi | i_sltu | i_subu | i_xor | i_xori | i_srl | i_sllv | i_lui | i_bgez;
  assign ALUOp[2] = i_or | i_ori | i_slt | i_sltu | i_xor | i_xori | i_srlv | i_srav | i_lui | i_slti | i_bgez;
  assign ALUOp[3] = i_nor | i_sll | i_srl | i_sllv | i_srlv | i_srav | i_lui | i_bgez;
  assign ALUOp[4] = i_bgtz | i_blez;
  assign ALUOp[5] = 0;
endmodule
