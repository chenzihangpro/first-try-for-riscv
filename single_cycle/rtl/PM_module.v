`timescale 1ns / 1ps
module PM_module(
    input wire [31:0] PC,
    output wire [31:0] instruction
);
    
    reg [7:0] PM [127:0];
    assign instruction = {PM[PC[6:0]+3],PM[PC[6:0]+2],PM[PC[6:0]+1],PM[PC[6:0]]};//通过PC的低七位索引，连续四个PC值读出一条指令，这也是为什么PC要+4
    
endmodule