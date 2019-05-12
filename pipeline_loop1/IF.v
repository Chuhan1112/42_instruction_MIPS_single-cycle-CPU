`include "ctrl_encode_def.v"
module PC( clk, rst, NPC, fPC );
                
   input         clk; //represent for clock
   input         rst; //represent for reset
   input  [31:0] NPC; //the next PC value
   output [31:0] fPC; // PC
   
   reg [31:0] PC;
   reg [31:0] fPC;
               
   always @(posedge clk or posedge rst) begin
      if ( rst ) 
         fPC <= 32'h0000_0000;  //the reset location
      else 
         fPC <= {20'h0_0000, NPC[11:0]};
   end // end always
   
   always @(*) begin
         PC <= {20'h0_0003, fPC[11:0]};
  end         
endmodule

module NPC( clk, rst, instal, PC, NPCOp, compare, IMM, RD1, NPC, IFflush);
    
   input compare;
   input [1:0] instal; //阻塞
   input  [31:0] PC;
   input  [1:0]  NPCOp;
   input  [31:0] IMM, RD1;
   input clk, rst;
   
   output IFflush;
   output [31:0] NPC;
   
   reg IFflush;
   reg [31:0] NPC;
   
 always @(*) begin
     if(rst)
       begin
       NPC <= 0;
       IFflush <= 0;
     end
     else begin
       if(instal!=0) begin
         NPC<=PC;  end
       else begin
        case(NPCOp)
         `NPC_JUMP: begin 
            NPC <= {PC[31:28], IMM[25:0], 2'b00}; IFflush <= 1; end
         `NPC_JR: begin 
            NPC <= RD1; IFflush <= 1; end
         `NPC_BRANCH:  begin 
           
         if(compare) begin
            NPC = {PC + {IMM, 2'b00}}; IFflush<=1; end
         else begin
            NPC <= PC + 4;  
            IFflush <= 0; end
         end
        default: begin 
          NPC <= PC + 4;  
          IFflush <= 0; end
         endcase
       end
      end
   end // end always
   
endmodule



module im_4k( rst, addr, dout );
    
    input [31:0] addr;
    input rst;
    output [31:0] dout;
    
    reg [31:0] dout;
    reg [31:0] addfuck;
    
    reg [31:0] imem[1023:0];
    
   always @(*) begin
     if(rst)
       dout<=0;
     else
     addfuck = {20'h0_0000, addr[13:2]};
     dout = imem[addfuck];
  end
    
endmodule 

module IR(clk, rst, IRWr, im_dout, instr);
               
   input         clk;
   input         rst;
   input         IRWr; 
   input  [31:0] im_dout;
   output [31:0] instr;
   
   reg [31:0] instr;
               
   always @(*) begin
      if ( rst ) 
         instr = 0;
      else 
         instr = im_dout;
   end // end always
      
endmodule