`include "ctrl_encode_def.v"
module alu(rst, A, A2, IMM, ALUSrc, ALUOp, C, Compare);
           
   input  signed [31:0] A, A2, IMM;
   input  signed [4:0]  ALUOp;
   input ALUSrc;
   input rst;
   
   output signed [63:0] C;
   output 				Compare;
   
   reg [31:0] B;
   reg [63:0] C;
   reg Compare;
   integer    i;
       
   always @(*) begin
     if(rst) 
     begin
       Compare<=0; C<=0;
     end
     else
      if( ALUSrc )//输入1对应的指令[10-6]是移位运算的shamt
        B = IMM;
      else
        B = A2; //输入0对应的指令[25-21]是rs
      case ( ALUOp )
          `ALUOp_NOP:  C[31:0] = B;                        // NOP
		      `ALUOp_ADD:  C[31:0] = A + B;                    // ADD
          `ALUOp_ADDU: C[31:0] = A + B;                    // ADDU
	     	  `ALUOp_SUB:  C[31:0] = A - B;                    // SUB
          `ALUOp_SUBU: C[31:0] = A - B;                    // SUBU
          `ALUOp_AND:  C[31:0] = A & B;                    // AND/ANDI
          `ALUOp_OR:   C[31:0] = A | B;                    // OR/ORI
          `ALUOp_XOR:  C[31:0] = A ^ B;                    // XOR/XORI
	     	  `ALUOp_NOR:  C[31:0] = ~(A | B);                 // NOR
          `ALUOp_SLL:  C[31:0] = (B << A[4:0]);            // SLL/SLLV
          `ALUOp_SRL:  C[31:0] = (B >> A[4:0]);	           // SRL/SRLV
          `ALUOp_SLT:  C[31:0] = (((A[31]==1)&&(B[31]==0))
                               ||((A[31]==0)&&(B[31]==0)&&({1'b0, A} < {1'b0, B}))
                               ||((A[31]==1)&&(B[31]==1)&&({1'b0, A} > {1'b0, B})))? 32'd1 : 32'd0;  // SLT/SLTI
          `ALUOp_SLTU: C[31:0] = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0; // SLTU/SLTIU         
          `ALUOp_EQL:  C[31:0] = (A == B) ? 32'd1 : 32'd0; // EQUAL
          `ALUOp_BNE:  C[31:0] = (A != B) ? 32'd1 : 32'd0; // NOT EQUAL
          `ALUOp_GT0:  C[31:0] = (A >  0) ? 32'd1 : 32'd0; // Great than 0
          `ALUOp_GE0:  C[31:0] = (A >= 0) ? 32'd1 : 32'd0; // Great than & equal 0
          `ALUOp_LT0:  C[31:0] = (A <  0) ? 32'd1 : 32'd0; // Less than 0
          `ALUOp_LE0:  C[31:0] = (A <= 0) ? 32'd1 : 32'd0; // Less than & equal 0
          `ALUOp_SRA: begin                          // SRA/SRAV
		      for(i=1; i<=A[4:0]; i=i+1)
			     C[32-i] = B[31];
		   	  for(i=31-A[4:0]; i>=0; i=i-1)
			     C[i] = B[i+A[4:0]];
          end
          `ALUOp_MULTU: C = {1'b0, A} * {1'b0, B};        // MULTU
          `ALUOp_DIVU: begin
             C[63: 32] = {1'b0, A} % {1'b0, B};
             C[31:  0] = {1'b0, A} / {1'b0, B};                     //DIVU     
          end          
          default:   C = 32'd0;                	   // Undefined
      endcase
      Compare <= C[0];
   end // end always

endmodule
    
