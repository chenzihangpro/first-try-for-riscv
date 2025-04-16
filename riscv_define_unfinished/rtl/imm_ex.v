`include "define.v"

module immgen(
    input [31:0] instruct,       // 32位的输入指令
    output reg [31:0] immediate  // 32位的立即数输出
);

always @(*) begin
    // I-type指令 (如 addi, ori, slli, srli)
    if (instruct[6:0] == 7'b0010011)  // opcode为0010011
        immediate = {20'b0, instruct[31:20]};  // 立即数位于31:20

    // I-type指令 (如 lw, lb)
    else if ((instruct[6:0] == 7'b0000011) && 
             ((instruct[14:12] == 3'b010) || (instruct[14:12] == 3'b000))) 
        immediate = {20'b0, instruct[31:20]};  // 立即数位于31:20

    // S-type指令 (如 sw, sb)
    else if ((instruct[6:0] == 7'b0100011) && 
             ((instruct[14:12] == 3'b010) || (instruct[14:12] == 3'b000))) 
        immediate = {20'b0, instruct[31:25], instruct[11:7]};  // 立即数由31:25和11:7拼接组成

    // B-type指令 (如 beq, bne)
    else if (instruct[6:0] == 7'b1100011) begin
        if (instruct[31] == 1'b1)
            immediate = {instruct[31], 19'b1, instruct[7], instruct[30:25], instruct[11:8], 1'b0};  // 符号扩展
        else
            immediate = {instruct[31], 19'b0, instruct[7], instruct[30:25], instruct[11:8], 1'b0};  // 正常扩展
    end

    // J-type指令 (如 jal)
    else if (instruct[6:0] == 7'b1101111) begin
        if (instruct[31] == 1'b1)
            immediate = {instruct[31], 11'b1, instruct[19:12], instruct[20], instruct[30:21], 1'b0};  // 符号扩展
        else
            immediate = {instruct[31], 11'b0, instruct[19:12], instruct[20], instruct[30:21], 1'b0};  // 正常扩展
    end

    // 默认情况下，立即数为零
    else 
        immediate = `ZeroNum;
end

endmodule
// //改进:借鉴tinyriscv的方法，设置case，比如：
// wire[6:0] opcode = instruct[6:0];
// wire[2:0] funct3 = instruct[14:12];
// wire[6:0] funct7 = Instruct[31:25];
// //imm_case
// case(opcode)
// `INST_TYPE_R_M:begin

// `INST_TYPE_I:begin

// `INST_TYPE_S:begin

// `INST_TYPE_B:begin

// endcase    	
