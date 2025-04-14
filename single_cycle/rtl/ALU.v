`timescale 1ns / 1ps
module ALU(
    input wire ALU_src,
    input wire [3:0] control_signal,
    input wire [31:0] read_data1,
    input wire [31:0] read_data2,
    input wire [31:0] immediate,
    output reg [31:0] ALU_result,
    output reg [31:0] mem_adr,
    output reg ALU_zero
);

    reg [31:0] ALU_data2;

//    always @(*) begin
//        $display("ALU_src ", ALU_src);
//    end

//    always @(*) begin
//        $display("control ", control_signal);
//        $display("read_data1 ", read_data1);
//        $display("ALU_data2 ", ALU_data2);
//        $display("ALU_result ", ALU_result);
//    end    

    always @(*) begin
        if (ALU_src)
            ALU_data2 = immediate;
        else
            ALU_data2 = read_data2;
    end

    always @(read_data1 or ALU_data2 or control_signal) begin
        case (control_signal)
            4'b0000:  ALU_result <= read_data1 + ALU_data2;    // add, addi
            4'b0001:  ALU_result <= read_data1 - ALU_data2;    // sub
            4'b0011:  ALU_result <= read_data1 | ALU_data2;   // ori or
            4'b0110:  ALU_result <= (read_data1 < ALU_data2)? 32'd1 : 32'd0; // slt slti
            4'b0010: begin  // 针对lw和sw指令，计算访存地址并存入mem_adr
                mem_adr <= read_data1 + ALU_data2;    
                ALU_result <= read_data1 + ALU_data2;  // 可以根据需求决定是否同时更新ALU_result，这里假设同时更新
            end
            default:begin
                ALU_result = 32'd0;
                mem_adr = 32'b0;
            end
        endcase
    end

    always @(*) begin
        case (control_signal)
            4'b1000:
                ALU_zero = (read_data1 == ALU_data2)? 1'b1 : 1'b0;    // beq
            default:ALU_zero = 1'b0;
        endcase
    end

endmodule
