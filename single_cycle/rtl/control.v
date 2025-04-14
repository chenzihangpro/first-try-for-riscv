`timescale 1ns / 1ps
module control(
    input wire [6:0] instruction,  // �����ָ�ȡ���7λ�����ж�ָ������
    output reg branch,  // �����Ƿ���з�֧�������ź�
    output reg memread,  // �����Ƿ���д洢�����������ź�
    output reg [1:0] ALUop,  // ���ݸ�ALU���Ƶ�Ԫ�Ĳ����룬���ھ���ALUִ�к�������
    output reg memtoreg,  //�����Ƿ�����ڴ�ֵд��Ĵ���
    output reg memwrite,  // �����Ƿ���д洢��д�������ź�
    output reg ALUsrc,  // ����ALU�Ĳ�������Դ���ǼĴ���������������
    output reg regwrite  // �����Ƿ񽫽��д�ؼĴ����ѵ��ź�
);

    always @(*) begin
        case (instruction[6:0])
            7'b0110011: begin  // ����ָ�� add��sub��or��slt
                               // TODO sll,sltu,xor,srl,sra,and
                branch <= 1'b0;  // �����з�֧����
                memread <= 1'b0;  // �����д洢��������
                memtoreg <= 1'b0;  // ���ض���ʽ���˴�������������ƾ�����д�ؼĴ�����
                ALUop <= 2'b11;  // ����ALU�����룬ָʾALUִ�ж�Ӧ����
                memwrite <= 1'b0;  // �����д洢��д����
                ALUsrc <= 1'b0;  // ALU��������Դѡ�������ǴӼĴ�����ȡ��
                regwrite <= 1'b1;  // ��������д�ؼĴ�����
            end
            7'b0010011: begin  // ���������ָ�� addi��ori��slti
                branch <= 1'b0;
                memread <= 1'b0;
                memtoreg <= 1'b0;
                ALUop <= 2'b10;
                memwrite <= 1'b0;
                ALUsrc <= 1'b1;  // ALU��������Դѡ��������
                regwrite <= 1'b1;
            end
            7'b0000011: begin  // lw
                branch <= 1'b0;
                memread <= 1'b1;  // ��Ҫ���д洢��������
                memtoreg <= 1'b1;  // ����Ӧ��ʽд�ؼĴ�����
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
                memwrite <= 1'b1;  // ��Ҫ���д洢��д����
                ALUsrc <= 1'b1;
                regwrite <= 1'b0;  // ����Ҫд�ؼĴ����ѣ���Ϊ�Ǵ洢������
            end
            7'b1100011: begin  // beq
                branch <= 1'b1;  // ���з�֧����
                memread <= 1'b0;
                memtoreg <= 1'b0;
                ALUop <= 2'b01;
                memwrite <= 1'b0;
                ALUsrc <= 1'b0;
                regwrite <= 1'b0;
            end
            default: begin  // ��������δ��ȷƥ���ָ������
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
