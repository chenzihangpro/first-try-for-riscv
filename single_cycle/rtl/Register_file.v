`timescale 1ns / 1ps
module Register_file(
    input wire clk,
    input wire reset, 
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] rd_addr,
    input wire [31:0] wr_data,
    input wire [31:0] mem_data,
    input wire reg_write_enable,
    input wire mem_to_reg,
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data,
    //查看样例寄存器值
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

    reg [31:0] register_file[31:0];

    // 组合逻辑读取寄存器数据
    assign rs1_data = (rs1_addr == 5'b0)? 32'b0 : register_file[rs1_addr];
    assign rs2_data = (rs2_addr == 5'b0)? 32'b0 : register_file[rs2_addr];

    // 时序逻辑写寄存器数据
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // 复位时将所有寄存器清零
            for (i = 0; i < 32; i = i + 1)
                register_file[i] <= 32'b0;
        end else if (reg_write_enable && rd_addr!= 5'b0) begin
                if (mem_to_reg) begin  // 根据mem_to_reg信号判断是从内存读数据写回还是其他情况（如ALU结果写回）
                register_file[rd_addr] <= mem_data;
//                $display("Writing data from memory %h to register %d", mem_data, rd_addr);  // 添加显示语句查看写回情况
            end else begin
                register_file[rd_addr] <= wr_data;
//                $display("Writing data from ALU %h to register %d", wr_data, rd_addr);  // 添加显示语句查看写回情况
            end
        end
    end
    
    assign X0 = register_file[0][7:0];
    assign X1 = register_file[1][7:0];
    assign X2 = register_file[2][7:0];
    assign X3 = register_file[3][7:0];
    assign X4 = register_file[4][7:0];
    assign X5 = register_file[5][7:0];
    assign X6 = register_file[6][7:0];
    assign X7 = register_file[7][7:0];
    assign X8 = register_file[8][7:0];
    
endmodule