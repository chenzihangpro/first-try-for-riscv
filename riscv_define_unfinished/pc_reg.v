module PC_reg(
    clk,
	rst_n,
	PCout,
	
	imm,
	branch,
	ALU_zero
    );
input       clk      ;
input       rst_n    ;
 
input [31:0]imm;
input branch;
input ALU_zero;
 
output reg [`InstAddrBus]PCout   ;
 
reg [`InstAddrBus]PC;
 
always@(posedge clk or negedge rst_n)
 if(rst_n == `RstEnable)
  PC <= `ZeroAddr;//rst
 else if(branch & ALU_zero)
  PC <= PC + imm;//branch
  else 
  PC <= PC + 10'd4;//pc+4
 
always@(*)
 PCout <= PC;//mantain the PC address
 
endmodule