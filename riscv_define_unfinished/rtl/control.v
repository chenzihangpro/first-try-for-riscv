`include "define.v"

module control(
    input [`OpcodeWidth-1:0] instruction,           //7位操作码
    output reg branch,                              //是否分支
    output reg memread,                             //是否从内存读取数据
    output reg [`MemToRegWidth-1:0] memtoreg,                      //是否将内存读取数据写入寄存器，
    output reg [`ALUopWidth-1:0] ALUop,                         //ALU的操作类型
    output reg memwrite,                            //是否将数据写入内存
    output reg ALUsrc,                              //ALU的数据来源
    output reg regwrite,                            //是否向寄存器文件写数据
    output reg jal                                  //是否跳转
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
