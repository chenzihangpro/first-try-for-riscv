`include "define.v"

module PC_reg(
    input       clk      ,
    input       rst_n    ,
 
    input [`ImmWidth-1:0]imm,        //分支偏移量
    input branch,
    input ALU_zero,                 //ALU零信号
 
    output reg [`InstAddrBus]PCout   
);
 
reg [`InstAddrBus]PC;
 
always@(posedge clk or negedge rst_n)begin
    if(rst_n == `RstEnable)
        PC <= `ZeroAddr;//rst
    else if(branch & ALU_zero)
        PC <= PC + imm;//branch
    else 
        PC <= PC + 10'd4;//pc+4
end

always@(*)begin
    PCout <= PC;//mantain the PC address
end

endmodule