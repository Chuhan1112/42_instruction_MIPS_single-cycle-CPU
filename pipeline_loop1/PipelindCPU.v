
// testbench for simulation
module mips_tb();
    
   reg  clk, rstn;
   reg  [4:0] reg_sel;
   wire [31:0] reg_data;
    
// instantiation of sccomp    
   mips U_MIPS(
      .clk(clk), .rst(rstn), .reg_sel(reg_sel), .reg_data(reg_data) );

  	integer foutput;
  	integer counter = 0;
   
   initial begin
      $readmemh( "loop.txt" , U_MIPS.im.imem); // load instructions into instruction memory
//    $monitor("PC = 0x%8X, instr = 0x%8X", U_MIPS.pc.PC, U_MIPS.ir.instr); // used for debug
      foutput = $fopen("results.txt");
      clk = 1;
      rstn = 0;
      #5 ;
      rstn = 1;
      #20 ;
      rstn = 0;
      #1000 ;
      reg_sel = 7;
   end
   
  always begin
    #(50) clk = ~clk;
    if (clk == 1'b0) begin
        if ((U_MIPS.pc.PC == 32'hxxxxxxxx)|| (counter==1000000)) begin
        //if (U_MIPS.pc.PC == 32'h00003c47) begin
          counter = counter + 1;
          $fdisplay(foutput, "pc: %h", U_MIPS.pc.PC);
          $fdisplay(foutput, "instr: %h", U_MIPS.ir.instr);
          $fdisplay(foutput, "rf0-3: %h %h %h %h", U_MIPS.rf.rf[0], U_MIPS.rf.rf[1], U_MIPS.rf.rf[2], U_MIPS.rf.rf[3]);
          $fdisplay(foutput, "rf4-7: %h %h %h %h", U_MIPS.rf.rf[4], U_MIPS.rf.rf[5], U_MIPS.rf.rf[6], U_MIPS.rf.rf[7]);
          $fdisplay(foutput, "rf8-11: %h %h %h %h", U_MIPS.rf.rf[8], U_MIPS.rf.rf[9], U_MIPS.rf.rf[10], U_MIPS.rf.rf[11]);
          $fdisplay(foutput, "rf12-15: %h %h %h %h", U_MIPS.rf.rf[12], U_MIPS.rf.rf[13], U_MIPS.rf.rf[14], U_MIPS.rf.rf[15]);
          $fdisplay(foutput, "rf16-19: %h %h %h %h", U_MIPS.rf.rf[16], U_MIPS.rf.rf[17], U_MIPS.rf.rf[18], U_MIPS.rf.rf[19]);
          $fdisplay(foutput, "rf20-23: %h %h %h %h", U_MIPS.rf.rf[20], U_MIPS.rf.rf[21], U_MIPS.rf.rf[22], U_MIPS.rf.rf[23]);
          $fdisplay(foutput, "rf24-27: %h %h %h %h", U_MIPS.rf.rf[24], U_MIPS.rf.rf[25], U_MIPS.rf.rf[26], U_MIPS.rf.rf[27]);
          $fdisplay(foutput, "rf28-31: %h %h %h %h", U_MIPS.rf.rf[28], U_MIPS.rf.rf[29], U_MIPS.rf.rf[30], U_MIPS.rf.rf[31]);
          //$fdisplay(foutput, "hi lo: %h %h", U_MIPS.rf.rf.hi, U_MIPS.rf.rf.lo);
          $fclose(foutput);
          $stop;
        end
        else begin
          counter = counter + 1;
          $display("pc: %h", U_MIPS.pc.PC);
          $display("instr: %h", U_MIPS.ir.instr);
        end
    end
  end //end always
   
endmodule


module mips( clk, rst, reg_sel, reg_data);
  
   input   [4:0] reg_sel;
   input   [31:0] reg_data;
   input   clk;
   input   rst;   
   wire [63:0]  wALUReslto2, wALUReslto3, wALUReslto4, RegWrData, wALUReslto5;
   wire [31:0]  wPC, wNPC, wim_dout, wInstri, wInstro1, wPC4o1, wRD1o1, wRD2o1, wDD1o1, wDD2o1, 
   wPC4o2, wRD1o2, wRD2o2, wIMMo1, wIMMo2, wPC4o3, wPC4o4, wMemReslto4, wRD2o3, wMemReslto2, wMemReslto3; 
   wire [4:0]   wALUOpo1, wRDsto1,wALUOpo2, wRDsto2, wRDsto3, wRDsto4, wRDst;
   wire [2:0]   wMSelo1, wMSelo2, wMSelo3;
   wire [1:0]   wEXTOpo1, wBSelo1, wWDSelo1, wEXTOpo2, wBSelo2, wWDSelo2, 
   wBSelo3, wWDSelo3, wWDSelo4, wNPCOpo1, wNPCOpo2, winstal;
   wire wALUSrco1, wRFWro1, wDMWro1, wALUSrco2,
   wRFWro2,  wDMWro2, wRFWro3, wDMWro3, wRFWro4,
   wMDIVo1, wMDIVo2, wMDIVo3, wMDIVo4, wMRo1, wMRo2, wMRo3, wMRo4, wRFWr, wMDIV, wCompare, wCompare1, wIFflush, wIDflush, wEXEflush;
   
   PC pc( clk, rst, wNPC, wPC );
   NPC npc( clk, rst, winstal, wPC, wNPCOpo1, wCompare1, wIMMo1, wRD1o1, wNPC, wIFflush);
   im_4k im( rst, wPC, wim_dout );
   IR ir(clk, rst, IRWr, wim_dout, wInstri);
   IFID ifid(clk, rst, wIFflush, winstal, wInstri, wPC, wInstro1, wPC4o1);
   
   RegisterFile rf( clk,rst, wInstro1, wRDst, RegWrData, wMDIV, wRFWr, wDD1o1, wDD2o1 );
   ctrl ct(clk,	rst, wInstro1, wALUSrco1, wEXTOpo1, wALUOpo1, wNPCOpo1, 
            wBSelo1, wMSelo1, wDMWro1, wWDSelo1, wRFWro1, wRDsto1, wMDIVo1, wMRo1);
   EXT ext(rst, wInstro1, wEXTOpo1, wIMMo1 );
   fctrl fct( rst, wNPCOpo1, wInstro1, wRDsto1, wRDsto2, wRDsto3, wRFWro1, wRFWro2, wRFWro3, 
            wMRo1, wMRo2, wMRo3, wDD1o1, wDD2o1, wALUReslto2, 
             wALUReslto3, wMemReslto3, wRD1o1, wRD2o1, winstal);
   alu aluid(rst, wRD1o1, wRD2o1, wIMMo1, wALUSrco1, wALUOpo1, wALUReslto5, wCompare1);
   IDEX idex(clk, rst, winstal, wPC4o1, wRD1o1, wRD2o1, 
             wIMMo1, wALUSrco1, wALUOpo1, wNPCOpo1, wBSelo1, wMSelo1,
             wDMWro1, wWDSelo1, wRFWro1, wRDsto1, wMDIVo1, wMRo1,
             wPC4o2, wRD1o2, wRD2o2, wIMMo2, wALUSrco2, wALUOpo2, 
             wNPCOpo2, wBSelo2, wMSelo2, 
             wDMWro2, wWDSelo2, wRFWro2, wRDsto2, wMDIVo2, wMRo2);
   
   alu alu(rst, wRD1o2, wRD2o2, wIMMo2, wALUSrco2, wALUOpo2, wALUReslto2, wCompare);
   EXMEM exmem(clk, rst, wPC4o2, wALUReslto2, wRD2o2, wBSelo2, wMSelo2,
             wDMWro2, wWDSelo2, wRFWro2, wRDsto2,  wMDIVo2, wMRo2,
             wPC4o3, wALUReslto3, wRD2o3, wBSelo3, wMSelo3,
             wDMWro3, wWDSelo3, wRFWro3, wRDsto3, wMDIVo3, wMRo3);
             
   dm_4k DM( wALUReslto3, wRD2o3, wBSelo3, wDMWro3, rst, wMemReslto2 );
   MemExtender me(wALUReslto3, wMSelo3, wMemReslto2, wMemReslto3);
   MEMWB memwb(clk, rst, wPC4o3, wMemReslto3, wALUReslto3, wWDSelo3, wRFWro3, wRDsto3,  wMDIVo3, wMRo3
   ,wPC4o4, wMemReslto4, wALUReslto4, wWDSelo4, wRFWro4, wRDsto4, wMDIVo4, wMRo4);
   
   RegWrData rwd(.clk(clk),.rst(rst), .ALURslt(wALUReslto4), .MemRslt(wMemReslto4), .PC(wPC4o4), .WDSel(wWDSelo4), .RWD(RegWrData), 
   .RDstp(wRDsto4), .RDst(wRDst), .RFWrp(wRFWro4), .RFWr(wRFWr), .MDIVp(wMDIVo4), .MDIV(wMDIV) );
endmodule