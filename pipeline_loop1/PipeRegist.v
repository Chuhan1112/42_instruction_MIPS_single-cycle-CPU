`include "ctrl_encode_def.v"

module IFID(clk, rst, IFflush, install, instri1, PC4i1, instro1, PC4o1);
  
  input [31:0] instri1, PC4i1;
  input clk,rst, IFflush;
  input [1:0] install;
  output [31:0] instro1, PC4o1;
  reg  [31:0] instro1, PC4o1;

  always @(posedge clk or posedge rst) begin 
  if ( rst || IFflush ) begin
    instro1<=0; PC4o1<=0; 
  end 
  else begin 
  if(install!=0) begin
    instro1<=instro1; PC4o1<=PC4o1+4;
  end
  else begin
    instro1<=instri1; PC4o1<=PC4i1+4; 
  end
  end
  end
endmodule

module IDEX(clk, rst, instal, PC4i2, RD1i2, RD2i2, IMMi2, ALUSrci2, ALUOpi2, 
            NPCOpi2, BSeli2, MSeli2, DMWri2, WDSeli2, RFWri2, RDsti2, MDIVi2, MRi2,
            PC4o2, RD1o2, RD2o2, IMMo2, ALUSrco2, ALUOpo2, NPCOpo2, BSelo2, MSelo2,
            DMWro2, WDSelo2, RFWro2, RDsto2, MDIVo2, MRo2);

  input [31:0] RD1i2, RD2i2, IMMi2, PC4i2;
  input [4:0] RDsti2, ALUOpi2;
  input [2:0] MSeli2;
  input [1:0] NPCOpi2, WDSeli2, BSeli2, instal;
  input RFWri2, DMWri2,  MDIVi2, MRi2, ALUSrci2;
  input clk, rst;
  
  output [31:0] RD1o2, RD2o2, IMMo2, PC4o2;
  output [4:0] RDsto2, ALUOpo2;
  output [2:0] MSelo2;
  output [1:0] NPCOpo2, WDSelo2, BSelo2;
  output RFWro2, DMWro2, MDIVo2, MRo2, ALUSrco2;
  
  reg [31:0] RD1o2, RD2o2, IMMo2, PC4o2;
  reg [4:0] RDsto2, ALUOpo2;
  reg [2:0] MSelo2;
  reg [1:0] NPCOpo2, WDSelo2, BSelo2;
  reg RFWro2, DMWro2, MDIVo2, MRo2, ALUSrco2;
  
  always @(posedge clk or posedge rst) begin 
      if ( rst || (instal!=0)) begin
        RD1o2<=0; RD2o2<=0; 
        IMMo2<=0; PC4o2<=0; 
        ALUOpo2<=0; RDsto2<=0;
        MSelo2<=0; 
        NPCOpo2<=0; 
        WDSelo2<=0; BSelo2<=0; MRo2<=0;
        RFWro2<=0; DMWro2<=0; MDIVo2<=0;
        ALUSrco2<=0;
   end else begin
        RD1o2<=RD1i2; RD2o2<=RD2i2;
        IMMo2<=IMMi2; PC4o2<=PC4i2; 
        ALUOpo2<=ALUOpi2; RDsto2<=RDsti2;
        MSelo2<=MSeli2; 
        NPCOpo2<=NPCOpi2;
        WDSelo2<=WDSeli2; BSelo2<=BSeli2; MRo2<=MRi2;
        RFWro2<= RFWri2; DMWro2<=DMWri2; MDIVo2<=MDIVi2;
        ALUSrco2<=ALUSrci2;

   end
   end
endmodule

module EXMEM(clk, rst, PC4i3, ALUReslti3, RD2i3, BSeli3, MSeli3,
            DMWri3, WDSeli3, RFWri3, RDsti3, MDIVi3, MRi3,
            PC4o3, ALUReslto3, RD2o3, BSelo3, MSelo3,
            DMWro3, WDSelo3, RFWro3, RDsto3, MDIVo3, MRo3);

  input [63:0] ALUReslti3;
  input [31:0] PC4i3, RD2i3;
  input [4:0] RDsti3;
  input [2:0] MSeli3;
  input [1:0] BSeli3, WDSeli3;
  input RFWri3, DMWri3, MDIVi3, MRi3;
  input clk,rst;
  
  output [63:0] ALUReslto3;
  output [31:0] PC4o3, RD2o3;
  output [4:0] RDsto3;
  output [2:0] MSelo3;
  output [1:0] BSelo3,  WDSelo3;
  output RFWro3, DMWro3, MDIVo3, MRo3;
  
  reg [63:0] ALUReslto3;
  reg [31:0] PC4o3, RD2o3;
  reg [4:0] RDsto3;
  reg [2:0] MSelo3;
  reg [1:0] BSelo3,  WDSelo3;
  reg RFWro3, DMWro3, MDIVo3, MRo3;
  
  always @(posedge clk or posedge rst) begin 
      if ( rst ) begin
      ALUReslto3<=0; PC4o3<=0; 
      RDsto3<=0; ALUReslto3<=0; MRo3<=0;
      MSelo3<=0; WDSelo3<=0;
      BSelo3<=0; RFWro3<=0; DMWro3<=0; MDIVo3<=0;RD2o3<=0;
   end else begin
      ALUReslto3<=ALUReslti3;  PC4o3<=PC4i3; MRo3<=MRi3;
      RDsto3<=RDsti3; ALUReslto3<=ALUReslti3; 
      MSelo3<=MSeli3; WDSelo3<=WDSeli3;RD2o3<=RD2i3;
      BSelo3<=BSeli3; RFWro3<=RFWri3; DMWro3<=DMWri3; MDIVo3<=MDIVi3;
   end
   end
endmodule

module MEMWB(clk, rst, PC4i4, MemReslti4, ALUReslti4, WDSeli4, RFWri4, RDsti4, MDIVi4, MRi4,
           PC4o4, MemReslto4, ALUReslto4, WDSelo4, RFWro4, RDsto4, MDIVo4, MRo4);

  input [63:0] ALUReslti4;
  input [31:0] MemReslti4, PC4i4;
  input [4:0] RDsti4;
  input [1:0] WDSeli4;
  input RFWri4, MDIVi4, MRi4;
  input clk,rst;
  
  output [63:0] ALUReslto4;
  output [31:0] MemReslto4, PC4o4;
  output [4:0] RDsto4;
  output [1:0] WDSelo4;
  output RFWro4, MDIVo4, MRo4;
  
  reg [63:0] ALUReslto4;
  reg [31:0] MemReslto4, PC4o4;
  reg [4:0] RDsto4;
  reg [1:0] WDSelo4;
  reg RFWro4, MDIVo4, MRo4;
  
  always @(posedge clk or posedge rst) begin 
      if ( rst ) begin
      RDsto4<=0; MemReslto4<=0; PC4o4<=0; MRo4<=0;
      ALUReslto4<=0; WDSelo4<=0; RFWro4<=0; MDIVo4<=0;
   end else begin
      RDsto4<=RDsti4; MDIVo4<=MDIVi4; MemReslto4<=MemReslti4; PC4o4<=PC4i4;
      ALUReslto4<=ALUReslti4; WDSelo4<=WDSeli4; RFWro4<=RFWri4; 
      MRo4<=MRi4;
         end
   end
endmodule