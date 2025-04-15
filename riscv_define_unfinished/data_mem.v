//temporarily save the data 
module memory(
    CLK    ,
	addr   ,
	DIN    ,
	DOUT   ,
	WRn    ,
	RDn    
);
input CLK;
input WRn;
input RDn;
 
    
 
input      [`RegAddrBus]     addr;
input      [`RegBus]     DIN      ;
output reg [`RegBus]     DOUT       ;
 
  
reg [`RegBus]memory_unit[0:`RegNum-1];
 
 
/************************************************************************************************/
always @( posedge   CLK)
  begin 
	  if (WRn == `WriteEnable)   memory_unit[addr]<= DIN;
  end 
/************************************************************************************************/
always @( * )
  begin 
	  if (RDn == `ReadEnable)   DOUT<= memory_unit[addr];
  end 
/***********************************************************************************************/
endmodule
