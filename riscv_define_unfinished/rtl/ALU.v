`include "define.v"

module ALU(
    input ALU_src,               // ALU源，决定第二操作数是立即数还是寄存器数据
    input [3:0] control_signal,  // ALU操作控制信号
    input [`RegBus] read_data1,     // 第一个操作数
    input [`RegBus] read_data2,     // 第二个操作数（根据 ALU_src 选择）
    input [`ImmBus] immediate,      // 立即数
    output reg [`ALU_Result_Bus] ALU_result,// ALU的计算结果
    output reg ALU_zero          // 判断ALU结果是否为零
);

reg [`RegWidth-1:0] ALU_data2; // 第二操作数（根据 ALU_src 选择）

// 选择 ALU 的第二操作数
always @(*) begin
    if (ALU_src)
        ALU_data2 = immediate;    // 如果 ALU_src 为1，选择立即数
    else
        ALU_data2 = read_data2;  // 否则，选择寄存器数据
end

// ALU 操作执行
always @(read_data1 or ALU_data2 or control_signal) begin
    case (control_signal)
        `ALU_OP_ADD:    ALU_result <= read_data1 + ALU_data2;  // add, addi, lw, lb, sw, sb
        `ALU_OP_SUB:    ALU_result <= read_data1 - ALU_data2;  // sub
        `ALU_OP_AND:    ALU_result <= read_data1 & ALU_data2;  // and
        `ALU_OP_OR:     ALU_result <= read_data1 | ALU_data2;  // ori, or
        `ALU_OP_SLL:    ALU_result <= read_data1 << ALU_data2; // sll, slli
        `ALU_OP_SRL:    ALU_result <= read_data1 >> ALU_data2; // srl, srli
        `ALU_OP_SLTU:   ALU_result <= (read_data1 < ALU_data2) ? 32'd1 : 32'd0; // sltu
        default:        ALU_result <= 32'dz; // 默认情况下，ALU结果是未知
    endcase
end

// 设置 ALU_zero 标志
always @(*) begin
    case (control_signal)
        `ALU_OP_BEQ: ALU_zero = (read_data1 == ALU_data2) ? 1'b1 : 1'b0;  // BEQ 判断
        `ALU_OP_JAL: ALU_zero = 1'b1;  // JAL 设置 ALU_zero 为 1
        default:     ALU_zero = 1'b0;  // 其他情况下 ALU_zero 为 0
    endcase
end

endmodule
