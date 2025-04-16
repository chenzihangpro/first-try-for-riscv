`include "define.v"

module ALU(
    input ALU_src,               // ALUԴ�������ڶ������������������ǼĴ�������
    input [3:0] control_signal,  // ALU���������ź�
    input [`RegBus] read_data1,     // ��һ��������
    input [`RegBus] read_data2,     // �ڶ��������������� ALU_src ѡ��
    input [`ImmBus] immediate,      // ������
    output reg [`ALU_Result_Bus] ALU_result,// ALU�ļ�����
    output reg ALU_zero          // �ж�ALU����Ƿ�Ϊ��
);

reg [`RegWidth-1:0] ALU_data2; // �ڶ������������� ALU_src ѡ��

// ѡ�� ALU �ĵڶ�������
always @(*) begin
    if (ALU_src)
        ALU_data2 = immediate;    // ��� ALU_src Ϊ1��ѡ��������
    else
        ALU_data2 = read_data2;  // ����ѡ��Ĵ�������
end

// ALU ����ִ��
always @(read_data1 or ALU_data2 or control_signal) begin
    case (control_signal)
        `ALU_OP_ADD:    ALU_result <= read_data1 + ALU_data2;  // add, addi, lw, lb, sw, sb
        `ALU_OP_SUB:    ALU_result <= read_data1 - ALU_data2;  // sub
        `ALU_OP_AND:    ALU_result <= read_data1 & ALU_data2;  // and
        `ALU_OP_OR:     ALU_result <= read_data1 | ALU_data2;  // ori, or
        `ALU_OP_SLL:    ALU_result <= read_data1 << ALU_data2; // sll, slli
        `ALU_OP_SRL:    ALU_result <= read_data1 >> ALU_data2; // srl, srli
        `ALU_OP_SLTU:   ALU_result <= (read_data1 < ALU_data2) ? 32'd1 : 32'd0; // sltu
        default:        ALU_result <= 32'dz; // Ĭ������£�ALU�����δ֪
    endcase
end

// ���� ALU_zero ��־
always @(*) begin
    case (control_signal)
        `ALU_OP_BEQ: ALU_zero = (read_data1 == ALU_data2) ? 1'b1 : 1'b0;  // BEQ �ж�
        `ALU_OP_JAL: ALU_zero = 1'b1;  // JAL ���� ALU_zero Ϊ 1
        default:     ALU_zero = 1'b0;  // ��������� ALU_zero Ϊ 0
    endcase
end

endmodule
