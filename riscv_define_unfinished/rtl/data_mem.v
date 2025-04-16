//temporarily save the data 
`include "define.v"
module memory(
    input CLK,
    input WRn,      //дʹ���źţ�����Ч
    input RDn,      //��ʹ���źţ�����Ч
 
    
 
    input      [`RegAddrBus]    addr,
    input      [`RegBus]        DIN,
    output reg [`RegBus]        DOUT
 
);
    reg [`RegBus]memory_unit[0:`RegNum-1];
 
 
/************************************************************************************************/
always @( posedge   CLK)begin
    begin 
        if (WRn == `WriteEnable)   memory_unit[addr]<= DIN;
    end
end
/************************************************************************************************/
always @( * )begin
    begin 
        if (RDn == `ReadEnable)   DOUT<= memory_unit[addr];
    end
end
/***********************************************************************************************/
endmodule
