`include "instruction_def.v"
`define DEBUG 0 //if its define then debug

module RegisterFile( clk, rst, Instr, WDst, WData, MDIV, RFWr, RD1, RD2 );

   input         rst;
   input         clk;    
   input  [31:0] Instr;
   input  [63:0] WData;
   input  [4:0]  WDst;
   input         MDIV;//?
   input         RFWr;//(WE)

   output [31:0] RD1, RD2;
   
   reg [31:0] rf[33:0]; //rf[31:0] refer to 32 registers each with 32bit
   reg [4:0] A1,A2;
   reg [31:0] RD1, RD2;
   
   always @(*) begin 
  	    A2 <= Instr[20:16];
       A1 <= Instr[25:21]; 
   end   
   
   integer i;
   initial begin  //initialize every register of 0
       for (i=0; i<34; i=i+1)
          rf[i] <= 0;
   end
   
   always @(*) begin
      if(RFWr) 
      begin
        if(MDIV) 
        begin
          rf[33] <= WData[63:32];
          rf[32] <= WData[31: 0];
        end
      else
        if( WDst!=0 )
         rf[WDst] <= WData[31: 0];  //if RFWr is valid, write the data--WD(WriteData)
      `ifdef DEBUG  //if debug is defined, out put the data of all registers
         $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", 0, rf[1], rf[2], rf[3], rf[4], rf[5], rf[6], rf[7]);
         $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[8], rf[9], rf[10], rf[11], rf[12], rf[13], rf[14], rf[15]);
         $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[16], rf[17], rf[18], rf[19], rf[20], rf[21], rf[22], rf[23]);
         $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[24], rf[25], rf[26], rf[27], rf[28], rf[29], rf[30], rf[31]);
         $display("R[32-33]=%8X, %8X", rf[32], rf[33]);
      `endif
    end
   end // end always
   
   always @(*) begin
     
   assign RD2 = (A2 == 0) ? 32'd0 : rf[A2];
   if((Instr[31:26]==`INSTR_RTYPE_OP) && (Instr[5:0]==`INSTR_MFHI_FUNCT ))
     RD1 <= rf[33];
   else begin
      if((Instr[31:26]==`INSTR_RTYPE_OP) && (Instr[5:0]==`INSTR_MFHO_FUNCT ))
         RD1 <= rf[32];
      else begin
        if((Instr[31:26]==`INSTR_RTYPE_OP)&&((Instr[5:0]==`INSTR_SLL_FUNCT)||
        (Instr[5:0]==`INSTR_SRL_FUNCT)||(Instr[5:0]==`INSTR_SRA_FUNCT)))
        RD1 <= Instr[10:6];
      else
         RD1 <= (A1 == 0) ? 32'd0 : rf[A1]; 
       end
    end
  end// end always
  
endmodule

`include "ctrl_encode_def.v"
module EXT( rst, Instr, EXTOp, Imm );
    
   input rst; 
   input  [31:0] Instr;
   input  [1:0]  EXTOp;
   output [31:0] Imm;
   
   reg [31:0] Imm;
    
   always @(*) begin
     if(rst)
       Imm<=0;
     else
      case (EXTOp)
         `EXT_ZERO:    Imm <= {16'd0, Instr[15:0]};
         `EXT_SIGNED:  Imm <= {{16{Instr[15]}}, Instr[15:0]};
         `EXT_HIGHPOS: Imm <= {Instr[15:0], 16'd0};
         `EXT_J: Imm <= Instr;
      endcase
   end 
    
endmodule