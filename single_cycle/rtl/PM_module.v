`timescale 1ns / 1ps
module PM_module(
    input wire [31:0] PC,
    output wire [31:0] instruction
);
    
    reg [7:0] PM [127:0];
    assign instruction = {PM[PC[6:0]+3],PM[PC[6:0]+2],PM[PC[6:0]+1],PM[PC[6:0]]};//ͨ��PC�ĵ���λ�����������ĸ�PCֵ����һ��ָ���Ҳ��ΪʲôPCҪ+4
    
endmodule