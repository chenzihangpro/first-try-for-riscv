`include "define.v"

module mux2(
    input [1:0] memtoreg,       // �����źţ�����ѡ������Դ
    input jal,                   // ����JAL��תʱѡ��
    input [`InstBus] instruct,       // �����ָ��
    input [`RegBus] out1,           // ����datamem��32λ��������1
    input [`RegBus] out2,           // ALU��������32λ��������2
    input [`InstAddrBus] out3,            // 10λ���PC�����ַ3
    output reg [`RegBus] writedata  // ѡ����32λ�������
);

always @(*) begin
    if (jal == 1'b1) begin
        // JALָ��ʱ��ѡ��Ŀ���ַ��ƴ��Ϊ32λ
        writedata = {22'b0, out3};
    end else if (memtoreg == 2'b01) begin
        // �����ݴ洢����ȡ����ʱ��ѡ��out1
        writedata = out1;
    end else if (memtoreg == 2'b11) begin
        // LUIָ��ʱ����ָ��ĸ�20λ��12��0ƴ��
        writedata = {instruct[31:12], 12'b0};
    end else begin
        // Ĭ��ѡ��out2
        writedata = out2;
    end
end

endmodule
