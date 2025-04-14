`timescale 1ns / 1ps
module CPU_tb;

    // 输入信号
    reg clk;
    reg reset;

    // 输出信号
    wire [31:0] PC;
    wire [31:0] instruction;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] imm_extended;
    wire [31:0] ALU_result;
    wire [31:0] mem_adr;

    // 样例寄存器和内存值
    wire [7:0] DM_4;
    wire [7:0] DM_12;
    wire [7:0] X0;
    wire [7:0] X1;
    wire [7:0] X2;
    wire [7:0] X3;
    wire [7:0] X4;
    wire [7:0] X5;
    wire [7:0] X6;
    wire [7:0] X7;
    wire [7:0] X8;
    
    // 数据存储器和指令存储器模块实例化
    reg [7:0] PM [0:127]; // 44条指令
    reg [7:0] DM [0:127]; // 16个数据存储单元

    // CPU模块实例
    CPU cpu (
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .instruction(instruction),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .imm_extended(imm_extended),
        .ALU_result(ALU_result),
        .mem_adr(mem_adr),
        .DM_4(DM_4),
        .DM_12(DM_12),
        .X0(X0),
        .X1(X1),
        .X2(X2),
        .X3(X3),
        .X4(X4),
        .X5(X5),
        .X6(X6),
        .X7(X7),
        .X8(X8)
    );

    // 时钟生成
    always begin
        #5 clk = ~clk;  // 时钟周期为10ns
    end

    // 初始化过程
    initial begin
        // 初始化时钟和复位
        clk = 1;
        reset = 1;

        // 初始化指令存储器（PM） - 按照小端格式初始化
        PM[0] = 8'h93; PM[1] = 8'h00; PM[2] = 8'h80; PM[3] = 8'h00; // 0x93008000
        PM[4] = 8'h03; PM[5] = 8'hA1; PM[6] = 8'h40; PM[7] = 8'h00; // 0x03A14000
        PM[8] = 8'hB3; PM[9] = 8'h81; PM[10] = 8'h20; PM[11] = 8'h00; // 0xB3182000
        PM[12] = 8'h33; PM[13] = 8'h82; PM[14] = 8'h11; PM[15] = 8'h40; // 0x33211840
        PM[16] = 8'hB3; PM[17] = 8'hE2; PM[18] = 8'h40; PM[19] = 8'h00; // 0xB23E4000
        PM[20] = 8'h13; PM[21] = 8'hE3; PM[22] = 8'h12; PM[23] = 8'h00; // 0x13E31200
        PM[24] = 8'h23; PM[25] = 8'h20; PM[26] = 8'h61; PM[27] = 8'h00; // 0x23012000
        PM[28] = 8'hB3; PM[29] = 8'h23; PM[30] = 8'h41; PM[31] = 8'h00; // 0x3B234100
        PM[32] = 8'h13; PM[33] = 8'h24; PM[34] = 8'h81; PM[35] = 8'h00; // 0x13248100
        PM[36] = 8'hE3; PM[37] = 8'h8A; PM[38] = 8'h51; PM[39] = 8'hFE; // 0xE38A51FE
        PM[40] = 8'h00; PM[41] = 8'h00; PM[42] = 8'h00; PM[43] = 8'h00; // 0x00000000 (No-op)

        // 初始化数据存储器（DM） - 小端排序数据
        DM[0] = 8'h00;
        DM[1] = 8'h01;
        DM[2] = 8'h02;
        DM[3] = 8'h03;
        DM[4] = 8'h04;
        DM[5] = 8'h05;
        DM[6] = 8'h06;
        DM[7] = 8'h07;
        DM[8] = 8'h08;
        DM[9] = 8'h00;
        DM[10] = 8'h00;
        DM[11] = 8'h00;
        DM[12] = 8'h04;
        DM[13] = 8'h00;
        DM[14] = 8'h00;
        DM[15] = 8'h00;

        // 将指令存储器和数据存储器初始化值传递给CPU模块
        cpu.pm_module.PM[0] = PM[0];
        cpu.pm_module.PM[1] = PM[1];
        cpu.pm_module.PM[2] = PM[2];
        cpu.pm_module.PM[3] = PM[3];
        cpu.pm_module.PM[4] = PM[4];
        cpu.pm_module.PM[5] = PM[5];
        cpu.pm_module.PM[6] = PM[6];
        cpu.pm_module.PM[7] = PM[7];
        cpu.pm_module.PM[8] = PM[8];
        cpu.pm_module.PM[9] = PM[9];
        cpu.pm_module.PM[10] = PM[10];
        cpu.pm_module.PM[11] = PM[11];
        cpu.pm_module.PM[12] = PM[12];
        cpu.pm_module.PM[13] = PM[13];
        cpu.pm_module.PM[14] = PM[14];
        cpu.pm_module.PM[15] = PM[15];
        cpu.pm_module.PM[16] = PM[16];
        cpu.pm_module.PM[17] = PM[17];
        cpu.pm_module.PM[18] = PM[18];
        cpu.pm_module.PM[19] = PM[19];
        cpu.pm_module.PM[20] = PM[20];
        cpu.pm_module.PM[21] = PM[21];
        cpu.pm_module.PM[22] = PM[22];
        cpu.pm_module.PM[23] = PM[23];
        cpu.pm_module.PM[24] = PM[24];
        cpu.pm_module.PM[25] = PM[25];
        cpu.pm_module.PM[26] = PM[26];
        cpu.pm_module.PM[27] = PM[27];
        cpu.pm_module.PM[28] = PM[28];
        cpu.pm_module.PM[29] = PM[29];
        cpu.pm_module.PM[30] = PM[30];
        cpu.pm_module.PM[31] = PM[31];
        cpu.pm_module.PM[32] = PM[32];
        cpu.pm_module.PM[33] = PM[33];
        cpu.pm_module.PM[34] = PM[34];
        cpu.pm_module.PM[35] = PM[35];
        cpu.pm_module.PM[36] = PM[36];
        cpu.pm_module.PM[37] = PM[37];
        cpu.pm_module.PM[38] = PM[38];
        cpu.pm_module.PM[39] = PM[39];
        cpu.pm_module.PM[40] = PM[40];
        cpu.pm_module.PM[41] = PM[41];
        cpu.pm_module.PM[42] = PM[42];
        cpu.pm_module.PM[43] = PM[43];

        cpu.dm_module.DM[0] = DM[0];
        cpu.dm_module.DM[1] = DM[1];
        cpu.dm_module.DM[2] = DM[2];
        cpu.dm_module.DM[3] = DM[3];
        cpu.dm_module.DM[4] = DM[4];
        cpu.dm_module.DM[5] = DM[5];
        cpu.dm_module.DM[6] = DM[6];
        cpu.dm_module.DM[7] = DM[7];
        cpu.dm_module.DM[8] = DM[8];
        cpu.dm_module.DM[9] = DM[9];
        cpu.dm_module.DM[10] = DM[10];
        cpu.dm_module.DM[11] = DM[11];
        cpu.dm_module.DM[12] = DM[12];
        cpu.dm_module.DM[13] = DM[13];
        cpu.dm_module.DM[14] = DM[14];
        cpu.dm_module.DM[15] = DM[15];

        // 激活复位信号
        #5 reset = 0;

        // 仿真运行几个时钟周期
        #100;  // 运行200ns，足够执行指令

        // 结束仿真
        #20;
        $finish;
    end

endmodule

