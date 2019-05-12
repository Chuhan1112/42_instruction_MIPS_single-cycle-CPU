`include "ctrl_encode_def.v"

module alu(A, B, ALUOp, C, Zero, Shamt);

    input signed [31:0]     A, B; 
    input        [5:0]      ALUOp; 
    input         [4:0]     Shamt;

    output signed [31:0]    C; 
    output Zero;

    reg [31:0] C;
    integer    i;

    /*初始化
    initial
    begin
        Zero = 0;
        C = 0;
    end*/

    always @(*) begin
        case (ALUOp)
            `ALU_AND: C = A & B;
            `ALU_OR: 	C = A | B;
            `ALU_SLT:  C = (A < B) ? 32'd1 : 32'd0;    // SLT/SLTI
            `ALU_SLTU: C = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0;           
            `ALU_ADD: C = A + B;
            `ALU_SUB: C = A - B;
            `ALU_XOR:  C = A ^ B;                      // XOR
            `ALU_NOR:  C = ~(A | B);                      // NOR
            `ALU_SLL: C = B << Shamt;
            `ALU_SRL: C = B >> Shamt;
            `ALU_SRA: C = B >>> Shamt; 
            `ALU_SLLV:C = B << A;
            `ALU_SRLV:C = B >> A;  
            `ALU_SRAV:C = B >>>A;
            `ALU_LUI: C = {B[15:0],16'd0};         
            `ALU_BGEZ:C = ( B == 5'b00001 ) ? ((A >= 0)? 32'd1 : 32'd0) : ((A <  0)? 32'd1 : 32'd0); //bgez bltz
            `ALU_BGTZ:C = (A >  0)? 32'd1 : 32'd0;
            default:  C = A;  // Undefined
        endcase
    end //end always

    assign Zero = (C == 32'b0);


endmodule // 
