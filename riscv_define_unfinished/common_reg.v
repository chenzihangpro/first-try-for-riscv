//TODO ³åÍ»

module register(
	input		clk,
	input 		rst_n,
	input 		regwrite,

	input[`RegAddrBus]	 write_register,
    input[`RegAddrBus]	read_register1,
    input[`RegAddrBus]  read_register2,
	input[`RegBus]	write_data,

     	 
	output  [`RegBus] read_data1,
	output  [`RegBus]  read_data2
);
	reg[`RegBus]  register[0:`RegNum-1];//32x32 
 
/***********************************************************************************************************************/
always @ (negedge clk or negedge rst_n) begin
    if (rst_n == RstDisable) begin : reset_all_registers
        integer i;
        for (i = 0; i < RegNum; i = i + 1)
            register[i] <= ZeroWord; // registers_reset
    end
    else begin
        if ((regwrite == WriteEnable) && (write_register != ZeroReg)) begin
            register[write_register] <= write_data; // write
        end
    end
end

/****************************************************************************************************************************************/
 assign read_data1 = (read_register1 == `ZeroReg) ? `ZeroWord : register[read_register1];
/****************************************************************************************************************************************/  
 assign read_data2 = (read_register2 == `ZeroReg) ? `ZeroWord : register[read_register2];//read
endmodule