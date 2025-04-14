`timescale 1ns / 1ps
module control(
    input wire [6:0] instruction,  // 输入的指令，取其低7位用于判断指令类型
    output reg branch,  // 控制是否进行分支操作的信号
    output reg memread,  // 控制是否进行存储器读操作的信号
    output reg [1:0] ALUop,  // 传递给ALU控制单元的操作码，用于决定ALU执行何种运算
    output reg memtoreg,  //控制是否加载内存值写入寄存器
    output reg memwrite,  // 控制是否进行存储器写操作的信号
    output reg ALUsrc,  // 控制ALU的操作数来源（是寄存器还是立即数）
    output reg regwrite  // 控制是否将结果写回寄存器堆的信号
);

    always @(*) begin
        case (instruction[6:0])
            7'b0110011: begin  // 常规指令 add，sub，or，slt
                               // TODO sll,sltu,xor,srl,sra,and
                branch <= 1'b0;  // 不进行分支操作
                memread <= 1'b0;  // 不进行存储器读操作
                memtoreg <= 1'b0;  // 按特定方式（此处具体由整体设计决定）写回寄存器堆
                ALUop <= 2'b11;  // 设置ALU操作码，指示ALU执行对应操作
                memwrite <= 1'b0;  // 不进行存储器写操作
                ALUsrc <= 1'b0;  // ALU操作数来源选择（这里是从寄存器获取）
                regwrite <= 1'b1;  // 将运算结果写回寄存器堆
            end
            7'b0010011: begin  // 立即数相关指令 addi，ori，slti
                branch <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                ALUop <= 2'b10;
                memwrite <= 1'b0;
                ALUsrc <= 1'b1;  // ALU操作数来源选择立即数
                regwrite <= 1'b1;
            end
            7'b0000011: begin  // lw
                branch <= 1'b0;
                memread <= 1'b1;  // 需要进行存储器读操作
                memtoreg <= 1'b1;  // 按对应方式写回寄存器堆
                ALUop <= 2'b10;
                memwrite <= 1'b0;
                ALUsrc <= 1'b1;
                regwrite <= 1'b1;
            end
            7'b0100011: begin  // sw
                branch <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                ALUop <= 2'b10;
                memwrite <= 1'b1;  // 需要进行存储器写操作
                ALUsrc <= 1'b1;
                regwrite <= 1'b0;  // 不需要写回寄存器堆（因为是存储操作）
            end
            7'b1100011: begin  // beq
                branch <= 1'b1;  // 进行分支操作
                memread <= 1'b0;
                memtoreg <= 1'b0;
                ALUop <= 2'b01;
                memwrite <= 1'b0;
                ALUsrc <= 1'b0;
                regwrite <= 1'b0;
            end
            default: begin  // 对于其他未明确匹配的指令类型
                branch <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                ALUop <= 2'b00;
                memwrite <= 1'b0;
                ALUsrc <= 1'b0;
                regwrite <= 1'b0;
            end
        endcase
    end
    
//    always @(*) begin
//        $display("ALU_src ", ALUsrc);
//    end
endmodule
