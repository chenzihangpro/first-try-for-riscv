`timescale 1ns / 1ps
module DM_module(
    input wire clk,
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire mem_write_enable,
    input wire mem_read_enable,
    output reg [31:0] read_data,
    output wire [7:0] DM_4,  //�鿴��ַΪ4���ڴ�ֵ
    output wire [7:0] DM_12  //�鿴��ַΪ12���ڴ�ֵ
);

    reg [7:0] DM[127:0];

    // ������
    always @(*) begin
        if (mem_read_enable) begin
            read_data[7:0] <= DM[address[6:0]];
            read_data[15:8] <= DM[address[6:0] + 1];
            read_data[23:16] <= DM[address[6:0] + 2];
            read_data[31:24] <= DM[address[6:0] + 3];
//            $display("Reading data from memory at address %h, read_data = %h", address, read_data);  // �����ʾ�����ڵ��Բ鿴���������
        end 
    end
    
//    always @(*) begin
//        $display("adress ", address);
//        $display("DM[adr] ", DM[address]);
//        $display("read_data ", read_data);
//    end
    
    // д����
    always @(posedge clk) begin
//        $display("memwrt", mem_write_enable);
        if (mem_write_enable) begin
            DM[address[6:0]] <= write_data[7:0];
            DM[address[6:0]+1] <= write_data[15:8];
            DM[address[6:0]+2] <= write_data[23:16];
            DM[address[6:0]+3] <= write_data[31:24];
//            $display("Writing data %h to memory at address %h", write_data, address);  // �����ʾ�����ڵ��Բ鿴д�������
        end
    end
    
    assign DM_4 = DM[4];    
    assign DM_12 = DM[12];
    
endmodule
