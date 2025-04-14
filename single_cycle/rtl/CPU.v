`timescale 1ns / 1ps
module CPU(
    input wire clk,
    input wire reset,
    output wire [31:0] PC,
    output wire [31:0] instruction,
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data,
    output wire [31:0] imm_extended,
    output wire [31:0] ALU_result,
    output wire [31:0] mem_adr,
    //  内存值和寄存器值查看(由于测试用例都是单字节数据，因此简化观察，用8位来输出)
    output wire [7:0] DM_4,
    output wire [7:0] DM_12,
    output wire [7:0] X0,
    output wire [7:0] X1,
    output wire [7:0] X2,
    output wire [7:0] X3,
    output wire [7:0] X4,
    output wire [7:0] X5,
    output wire [7:0] X6,
    output wire [7:0] X7,
    output wire [7:0] X8
);

//    wire [31:0] PC;
//    wire [31:0] instruction;
//    wire [31:0] rs1_data;
//    wire [31:0] rs2_data;
//    wire [31:0] imm_extended;
//    wire [31:0] ALU_result;
    wire [31:0] rd;
    wire ALU_zero;
    wire branch;
    wire memread;
    wire memtoreg;
    wire [1:0] ALUop;
    wire [3:0 ]  control_signal ;
    wire memwrite;
    wire ALUsrc;
    wire regwrite;

//    always @(*) begin
//        $display("ALU_src ", ALUsrc);
//    end
    
    // 实例化各个模块
    PC_module pc_module(
       .clk(clk),
       .reset(reset),
       .branch_offset(imm_extended),  // 根据指令情况传递合适的偏移量，这里假设是立即数扩展后的结果用于分支偏移
       .beq_taken(branch & ALU_zero),  // beq指令执行条件为branch信号有效且ALU结果为零
       .PC(PC)
    );

    PM_module pm_module(
        .PC(PC),
        .instruction(instruction)
    );

    Register_file register_file(
        .clk(clk),
        .reset(reset),
        .rs1_addr(instruction[19:15]),
        .rs2_addr(instruction[24:20]),
        .rd_addr(instruction[11:7]),
        .wr_data(ALU_result), 
        .mem_data(rd),
        .reg_write_enable(regwrite),
        .mem_to_reg(memtoreg),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
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

    ImmExtend imm_extend(
        .instruction(instruction),
        .imm_extended(imm_extended)
    );

    control ctrl(
        .instruction(instruction),
        .branch(branch),
        .memread(memread),
        .memtoreg(memtoreg),
        .ALUop(ALUop),
        .memwrite(memwrite),
        .ALUsrc(ALUsrc),
        .regwrite(regwrite)
    );

    ALU_control alu_ctrl(
        .ALUop(ALUop),
        .instruction(instruction),
        .control_signal(control_signal)
    );

    ALU alu(
        .ALU_src(ALUsrc),
        .control_signal(control_signal),  // 此处control_signal需要来自ALUcontrol模块
        .read_data1(rs1_data),
        .read_data2(rs2_data),
        .immediate(imm_extended),
        .ALU_result(ALU_result),
        .ALU_zero(ALU_zero),
        .mem_adr(mem_adr)
    );

    DM_module dm_module(
        .clk(clk),
        .address(mem_adr),
        .write_data(rs2_data),
        .mem_write_enable(memwrite),
        .mem_read_enable(memread),
        .read_data(rd),
        .DM_4(DM_4),
        .DM_12(DM_12)
    );
    
endmodule
