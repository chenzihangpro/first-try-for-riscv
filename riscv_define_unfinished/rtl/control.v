`include "define.v"

module control(
    input [`OpcodeWidth-1:0] instruction,           //7λ������
    output reg branch,                              //�Ƿ��֧
    output reg memread,                             //�Ƿ���ڴ��ȡ����
    output reg [`MemToRegWidth-1:0] memtoreg,                      //�Ƿ��ڴ��ȡ����д��Ĵ�����
    output reg [`ALUopWidth-1:0] ALUop,                         //ALU�Ĳ�������
    output reg memwrite,                            //�Ƿ�����д���ڴ�
    output reg ALUsrc,                              //ALU��������Դ
    output reg regwrite,                            //�Ƿ���Ĵ����ļ�д����
    output reg jal                                  //�Ƿ���ת
);

always @(*) begin
    case (instruction[6:0])
        7'b0110011: begin // R-type: add, sub, etc.
            branch <= `NoBranch;
            memread <= `NoMemRead;
            memtoreg <= `MemToRegDefault;
            ALUop <= 2'b11;
            memwrite <= `NoMemWrite;
            ALUsrc <= `NoALUSrc;
            regwrite <= `DoRegWrite;
            jal <= `NotJAL;
        end
        
        7'b0010011: begin // I-type: addi, ori, slli, srli
            branch <= `NoBranch;
            memread <= `NoMemRead;
            memtoreg <= `MemToRegDefault;
            ALUop <= 2'b10;
            memwrite <= `NoMemWrite;
            ALUsrc <= `DoALUSrc;
            regwrite <= `DoRegWrite;
            jal <= `NotJAL;
        end
        
        7'b0000011: begin // Load: lw, lb, etc.
            branch <= `NoBranch;
            memread <= `DoMemRead;
            memtoreg <= `MemToRegLoad;
            ALUop <= 2'b10;
            memwrite <= `NoMemWrite;
            ALUsrc <= `DoALUSrc;
            regwrite <= `DoRegWrite;
            jal <= `NotJAL;
        end
        
        7'b0100011: begin // Store: sw, sb, etc.
            branch <= `NoBranch;
            memread <= `NoMemRead;
            memtoreg <= 2'bzz;  // Not used
            ALUop <= 2'b10;
            memwrite <= `DoMemWrite;
            ALUsrc <= `DoALUSrc;
            regwrite <= `NoRegWrite;
            jal <= `NotJAL;
        end
        
        7'b1100111: begin // Branch (B-type)
            branch <= `DoBranch;
            memread <= `NoMemRead;
            memtoreg <= 2'bzz;  // Not used
            ALUop <= 2'b01;
            memwrite <= `NoMemWrite;
            ALUsrc <= `NoALUSrc;
            regwrite <= `NoRegWrite;
            jal <= `NotJAL;
        end
        
        7'b0110111: begin // LUI
            branch <= `NoBranch;
            memread <= `NoMemRead;
            memtoreg <= 2'b11;
            ALUop <= 2'bzz;  // Not used
            memwrite <= `NoMemWrite;
            ALUsrc <= `NoALUSrc;
            regwrite <= `DoRegWrite;
            jal <= `NotJAL;
        end
        
        7'b1101111: begin // JAL
            branch <= `DoBranch;
            memread <= `NoMemRead;
            memtoreg <= 2'b10;
            ALUop <= 2'b00;
            memwrite <= `NoMemWrite;
            ALUsrc <= `NoALUSrc;
            regwrite <= `DoRegWrite;
            jal <= `DoJAL;
        end
        
        default: begin
            branch <= `NoBranch;
            memread <= `NoMemRead;
            memtoreg <= 2'bzz;  // Not used
            ALUop <= 2'bzz;  // Not used
            memwrite <= `NoMemWrite;
            ALUsrc <= `NoALUSrc;
            regwrite <= `NoRegWrite;
            jal <= `NotJAL;
        end
    endcase
end

endmodule
