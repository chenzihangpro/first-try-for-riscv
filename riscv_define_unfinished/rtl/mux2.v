`include "define.v"

module mux2(
    input [1:0] memtoreg,       // 控制信号，用于选择数据源
    input jal,                   // 用于JAL跳转时选择
    input [`InstBus] instruct,       // 输入的指令
    input [`RegBus] out1,           // 来自datamem的32位数据输入1
    input [`RegBus] out2,           // ALU运算结果的32位数据输入2
    input [`InstAddrBus] out3,            // 10位宽的PC输出地址3
    output reg [`RegBus] writedata  // 选择后的32位数据输出
);

always @(*) begin
    if (jal == 1'b1) begin
        // JAL指令时，选择目标地址并拼接为32位
        writedata = {22'b0, out3};
    end else if (memtoreg == 2'b01) begin
        // 从数据存储器读取数据时，选择out1
        writedata = out1;
    end else if (memtoreg == 2'b11) begin
        // LUI指令时，将指令的高20位与12个0拼接
        writedata = {instruct[31:12], 12'b0};
    end else begin
        // 默认选择out2
        writedata = out2;
    end
end

endmodule
