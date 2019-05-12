`include "ctrl_encode_def.v"

module RegWrData( clk, rst, ALURslt, MemRslt, PC, WDSel, RWD, RDstp, RDst, RFWrp, RFWr, MDIVp, MDIV);

  input signed [63:0] ALURslt;
  input [31:0] MemRslt, PC;
  input [4:0] RDstp;
  input [1:0] WDSel;
  input clk, RFWrp, MDIVp, rst;
  
  output [63:0] RWD;
  output [4:0] RDst;  
  output RFWr, MDIV;
  
  reg [63:0] RWD;
  reg [4:0] RDst;
  reg RFWr, MDIV;
  
  always @( *) begin begin
    if(rst)
      begin
        RDst <= 0;
    RFWr <= 0;
    MDIV <= 0;
    RWD <=0;
  end
  else
    RDst <= RDstp;
    RFWr <= RFWrp;
    MDIV <= MDIVp;
  if( WDSel[1:0] == `WDSel_FromALU )
    RWD <= ALURslt;
  else if( WDSel[1:0] == `WDSel_FromMEM )
         RWD <= {32'b0, MemRslt};
       else if( WDSel[1:0] == `WDSel_FromPC  )
              begin 
              RWD <= {32'b0, 20'h0_0003, PC[11:0]}; RDst <= 31;
  end
  end
  end

endmodule