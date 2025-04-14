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
    //�鿴�����Ĵ���ֵ
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

    // ����߼���ȡ�Ĵ�������
    assign rs1_data = (rs1_addr == 5'b0)? 32'b0 : register_file[rs1_addr];
    assign rs2_data = (rs2_addr == 5'b0)? 32'b0 : register_file[rs2_addr];

    // ʱ���߼�д�Ĵ�������
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // ��λʱ�����мĴ�������
            for (i = 0; i < 32; i = i + 1)
                register_file[i] <= 32'b0;
        end else if (reg_write_enable && rd_addr!= 5'b0) begin
                if (mem_to_reg) begin  // ����mem_to_reg�ź��ж��Ǵ��ڴ������д�ػ��������������ALU���д�أ�
                register_file[rd_addr] <= mem_data;
//                $display("Writing data from memory %h to register %d", mem_data, rd_addr);  // �����ʾ���鿴д�����
            end else begin
                register_file[rd_addr] <= wr_data;
//                $display("Writing data from ALU %h to register %d", wr_data, rd_addr);  // �����ʾ���鿴д�����
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