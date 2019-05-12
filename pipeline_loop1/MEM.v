module dm_4k( C, din, be, DMWr, rst, dout );
   
   input  [63:0] C;  //C
   input  [31:0] din;  //RD2
   input  [1:0]  be;		//BSel
   input         DMWr;
   input         rst;
   output [31:0] dout;
   
   reg [9:0] addr;
   reg [31:0] dmem[1023:0];
   reg [31:0] dout;
   
   always @(*) begin
     if(rst) begin
       addr<=0;dout<=0; end
     else begin
    addr = C[11: 2];
      if (DMWr) begin
		  case (be)
			 // sw
			 2'b10: dmem[addr] <= din;
			 // sh
			 2'b01: dmem[addr][15:0]  <= din[15:0];
			 // sb	
			 2'b00: dmem[addr][7:0]   <= din[7:0];
			 default: ;
		  endcase
	  end
	  dout <= dmem[addr];
	  end
   end // end always

endmodule 
															//根据(aluout和op)扩展和精确din，并将其存储在dout中
`include "ctrl_encode_def.v"  //extend and exact din accordingto (aluout and op),store it in dout
module MemExtender(C, op, din, dout);
    
	input  [63:0] C;
	input  [2:0] op; //MSel
	input  [31:0] din;
	output [31:0] dout;
	
	reg [1:0] ALUOut;
	reg [31:0] dout;
	
	always @(*) begin
	  ALUOut = C[1:0];
	    case (op)
		    `ME_LW : dout <= din;
			  `ME_LH : if(ALUOut[1] == 1'b1)
						        dout <= { { 16{ din[31] } } , din[31:16] };
				       	 else 
					          dout <= { { 16{ din[15] } } , din[15:0] };
						
	    	`ME_LHU: if(ALUOut[1] == 1'b1)
				          		dout <= {16'b0, din[31:16]};
					       else 
						        dout <= {16'b0, din[15:0]};
						
    	 	`ME_LB : if(ALUOut == 2'b00)
		            				dout <= { {24{din[7]} } , din[7:0]};
					      else if(ALUOut == 2'b01)
					          dout <= { {24{din[15]} }, din[15:8]};
					      else if(ALUOut == 2'b10)
					          dout <= { {24{din[23]} }, din[23:16]};
					      else if(ALUOut == 2'b11)
					          dout <= { {24{din[31]} }, din[31:24]};
						
		  	`ME_LBU: if(ALUOut == 2'b00)
				          		dout <= { 24'b0, din[7:0]};
					     else if(ALUOut == 2'b01)
					          dout <= { 24'b0, din[15:8]};
					     else if(ALUOut == 2'b10)
					          dout <= { 24'b0, din[23:16]};
				     	 else if(ALUOut == 2'b11)
					          dout <= { 24'b0, din[31:24]};
	    	endcase
	end
	
endmodule   