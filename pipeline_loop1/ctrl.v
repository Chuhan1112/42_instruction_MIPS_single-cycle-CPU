`include "ctrl_encode_def.v"
`include "instruction_def.v"
module ctrl(clk,	rst, Instr, ALUSrc, EXTOp, ALUOp, NPCOp, 
            BSel, MSel, DMWr, WDSel, RFWr, RDst, MDIV, MR);
    
   input 		     clk, rst;       
   input  [31:0] Instr;

   output [1:0] EXTOp;

   output       ALUSrc;
   output [4:0] ALUOp;
   output [1:0] NPCOp;
   
   output [1:0] BSel; 
   output [2:0] MSel;
   output       DMWr;
   
   output [1:0] WDSel;
   output       RFWr;
   output [4:0] RDst;
   output       MDIV;
   
   output       MR;
   
   reg [5:0] Op;
   reg [6:0] Funct;
   
   always @(*) begin 
     if(rst)
       begin
       ALUSrc<=0; EXTOp<=0; ALUOp<=0; NPCOp<=0; 
            BSel<=0; MSel<=0; DMWr<=0; WDSel<=0; RFWr<=0; RDst<=0; MDIV<=0;MR<=0;
          end
        else
       Op = Instr[31:26];
       Funct = Instr[5:0];
   end

   reg          RFWr;
   reg          DMWr;
   reg    [4:0] RDst;
   reg          ALUSrc;
   reg    [1:0] EXTOp;
   reg    [4:0] ALUOp;
   reg    [1:0] NPCOp;
   reg    [1:0] WDSel;
   reg    [1:0] BSel; 
   reg    [2:0] MSel;
   reg          MDIV;
   reg          MR;
   
	/*************************************************/
	/******         Control Signal              ******/
	
	always @( * ) begin
	  if(rst) begin
	    ALUSrc<=0; EXTOp<=0; ALUOp<=0; NPCOp<=0; 
            BSel<=0; MSel<=0; DMWr<=0; WDSel<=0; RFWr<=0; RDst<=0; MDIV<=0;MR<=0;
  end
  else
	  	if((Instr[31:26]==`INSTR_LB_OP) || (Instr[31:26]==`INSTR_LBU_OP )||
	   (Instr[31:26]==`INSTR_LHU_OP )|| (Instr[31:26]==`INSTR_LW_OP))
	     MR <= 1;
	   else
	     MR <= 0;
	   if(((Instr[31:26]==`INSTR_RTYPE_OP) && (Instr[5:0]==`INSTR_MULTU_FUNCT ))||
	   ((Instr[31:26]==`INSTR_RTYPE_OP) && (Instr[5:0]==`INSTR_DIVU_FUNCT )))
	     MDIV <= 1;
	   else
	     MDIV <= 0; 
	     if((Op==`INSTR_RTYPE_OP)&&(Funct ==`INSTR_JR_FUNCT)) //jr
		    begin  
         EXTOp <= 0;
         ALUSrc <= 0;
         ALUOp <= 0;
         NPCOp <= `NPC_JR;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= 0;
         RFWr <= 0;
         RDst <= 0;
       end
     else begin
	   case ( Op ) 
		   `INSTR_RTYPE_OP: begin
         EXTOp <= `EXT_ZERO;
         ALUSrc <= 0;
         case( Funct )
           `INSTR_ADD_FUNCT: ALUOp <= `ALUOp_ADD;
           `INSTR_ADDU_FUNCT: ALUOp <= `ALUOp_ADDU;
           `INSTR_SUB_FUNCT: ALUOp <= `ALUOp_SUB;
           `INSTR_SUBU_FUNCT: ALUOp <= `ALUOp_SUBU;
           `INSTR_AND_FUNCT: ALUOp <= `ALUOp_AND;
           `INSTR_OR_FUNCT: ALUOp <= `ALUOp_OR;
           `INSTR_NOR_FUNCT: ALUOp <= `ALUOp_NOR;
           `INSTR_SLT_FUNCT: ALUOp <= `ALUOp_SLT;
           `INSTR_SLTU_FUNCT: ALUOp <= `ALUOp_SLTU;
           `INSTR_SLL_FUNCT: ALUOp <= `ALUOp_SLL;
           `INSTR_SRLV_FUNCT: ALUOp <= `ALUOp_SRL;
           `INSTR_SLLV_FUNCT: ALUOp <= `ALUOp_SLL;
           `INSTR_SRL_FUNCT: ALUOp <= `ALUOp_SRL;
           `INSTR_SRA_FUNCT: ALUOp <= `ALUOp_SRA;
           `INSTR_MULTU_FUNCT: ALUOp <= `ALUOp_MULTU;
           `INSTR_DIVU_FUNCT: ALUOp <= `ALUOp_DIVU;
        //`INSTR_MFFUNCT: ALUOp <= `ALUOp_ADDU;
           `INSTR_MFHO_FUNCT: ALUOp <= `ALUOp_ADDU;
         //`INSTR_JR_FUNCT: ALUOp <= `ALUOp_JR;
         default;
         endcase
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromALU;
         RFWr <= 1;
         RDst <= Instr[15:11];
          end
		   `INSTR_ADDI_OP: begin
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromALU;
         RFWr <= 1;
         RDst <= Instr[20:16]; 
       end
		   `INSTR_ADDIU_OP: begin
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromALU;
         RFWr <= 1;
         RDst <= Instr[20:16]; 
       end
		   `INSTR_ANDI_OP: begin
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_AND;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromALU;
         RFWr <= 1;
         RDst <= Instr[20:16]; 
       end
		   `INSTR_ORI_OP: begin
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_OR;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromALU;
         RFWr <= 1;
         RDst <= Instr[20:16]; 
       end		    
		   `INSTR_LUI_OP: begin
		     EXTOp <= `EXT_HIGHPOS;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_OR;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromALU;
         RFWr <= 1;
         RDst <= Instr[20:16]; 
       end
		   `INSTR_SLTI_OP: begin
		     EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_SLT;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromALU;
         RFWr <= 1;
         RDst <= Instr[20:16]; 
       end
		   `INSTR_SB_OP: begin
		     EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= `BE_SB; 
         MSel <= 0;
         DMWr <= 1;
         WDSel <= 0;
         RFWr <= 0;
         RDst <= 0;
       end
       `INSTR_SH_OP: begin
  	      EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= `BE_SH; 
         MSel <= 0;
         DMWr <= 1;
         WDSel <= 0;
         RFWr <= 0;
         RDst <= 0;
       end
       `INSTR_SW_OP: begin
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= `BE_SW; 
         MSel <= 0;
         DMWr <= 1;
         WDSel <= 0;
         RFWr <= 0;
         RDst <= 0;
       end
       `INSTR_LB_OP: begin  
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= `ME_LB;
         DMWr <= 0;
         WDSel <= `WDSel_FromMEM;
         RFWr <= 1;
         RDst <= Instr[20:16];
       end        
        `INSTR_LBU_OP: begin  
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= `ME_LBU;
         DMWr <= 0;
         WDSel <= `WDSel_FromMEM;
         RFWr <= 1;
         RDst <= Instr[20:16];
       end   
        `INSTR_LHU_OP: begin  
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= `ME_LHU;
         DMWr <= 0;
         WDSel <= `WDSel_FromMEM;
         RFWr <= 1;
         RDst <= Instr[20:16];
       end
        `INSTR_LW_OP: begin  
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 1;
         ALUOp <= `ALUOp_ADD;
         NPCOp <= `NPC_PLUS4;
         BSel <= 0; 
         MSel <= `ME_LW;
         DMWr <= 0;
         WDSel <= `WDSel_FromMEM;
         RFWr <= 1;
         RDst <= Instr[20:16]; 
       end
        `INSTR_BEQ_OP: begin  
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 0;
         ALUOp <= `ALUOp_EQL;
         NPCOp <= `NPC_BRANCH;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= 0;
         RFWr <= 0;
         RDst <= 0;
       end
        `INSTR_BNE_OP: begin  
         EXTOp <= `EXT_SIGNED;
         ALUSrc <= 0;
         ALUOp <= `ALUOp_BNE;
         NPCOp <= `NPC_BRANCH;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= 0;
         RFWr <= 0;
         RDst <= 0;
       end
        `INSTR_J_OP: begin  
         EXTOp <= `EXT_J;
         ALUSrc <= 0;
         ALUOp <= 0;
         NPCOp <= `NPC_JUMP;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= 0;
         RFWr <= 0;
         RDst <= 0;
       end
        `INSTR_JAL_OP: begin  
         EXTOp <= `EXT_J;
         ALUSrc <= 0;
         ALUOp <= 0;
         NPCOp <= `NPC_JUMP;
         BSel <= 0; 
         MSel <= 0;
         DMWr <= 0;
         WDSel <= `WDSel_FromPC;
         RFWr <= 1;
         RDst <= 31;
       end
	   endcase
	  end
   end // end always
endmodule

module fctrl( rst, NPCOp, Instr, RDst, RDst2, RDst3, RFWr, RFWr2, RFWr3, MR, MR2, MR3,
             DD1, DD2, ALUReslt, ALUReslt2, MemReslt, fRD1, fRD2, instal);
  
  input [63:0] ALUReslt, ALUReslt2;
  input [4:0]  RDst, RDst2, RDst3;
  input rst, RFWr, RFWr2, RFWr3, MR, MR2, MR3;
  input [31:0] Instr, DD1, DD2, MemReslt;
  input [1:0] NPCOp;
  output [1:0] instal;
  output [31:0] fRD1, fRD2;
  
  reg [1:0] instal=0;
  reg [31:0] fRD1, fRD2;
  reg [4:0] rs, rt;
  reg [2:0] sFC, tFC;

  integer i;
  
  always @( * ) begin
   
    rs=Instr[25:21]; rt=Instr[19:16];
    
    if(rst) begin
      sFC=0; tFC=0; fRD1=0; fRD2=0;end
    else begin
      instal=0;  sFC = `FC_NOP; tFC = `FC_NOP; 
       if( RFWr2 && !MR2 && (RDst2!=0) && (RDst2==rs))
        sFC = `FC_EMtoRs;
      if( RFWr2 && !MR2 && (RDst2!=0) && (RDst2==rt))
        tFC = `FC_EMtoRt;
      if( MR2 && (RDst2!=0) && (RDst2==rs)) 
        instal=1;
      if( MR2 && (RDst2!=0) && (RDst2==rt)) 
        instal=1;
      if( MR3 && (RDst3!=0) && (RDst3==rs))
        sFC = `FC_MWtoRs;
      if( MR3 && (RDst3!=0) && (RDst3==rt))
        tFC = `FC_MWtoRt;
      if( RFWr3 && !MR3 && (RDst3!=0) && (RDst3==rs) && (RDst2!=rs)) 
        sFC = `FC_AMWtoRs;
      if( RFWr3 && !MR3 && (RDst3!=0) && (RDst3==rt) && (RDst2!=rt)) 
        tFC = `FC_AMWtoRt;
      end
  
       case(sFC)
          `FC_NOP: begin
              fRD1=DD1; end
          `FC_EMtoRs: begin
              fRD1=ALUReslt[31:0];end
          `FC_MWtoRs: begin
              fRD1=MemReslt;end
          `FC_AMWtoRs: begin
              fRD1=ALUReslt2[31:0];end
          default: begin
           fRD1=DD1; end
      endcase
           case(tFC)
          `FC_NOP: begin
              fRD2=DD2; end
          `FC_EMtoRt: begin
              fRD2=ALUReslt[31:0];end
          `FC_MWtoRt: begin
              fRD2=MemReslt;end
          `FC_AMWtoRt: begin
              fRD2=ALUReslt2[31:0];end
          default: begin
           fRD2=DD2; end
    endcase
end // end always
endmodule
