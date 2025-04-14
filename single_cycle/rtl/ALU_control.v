`timescale 1ns / 1ps
module ALU_control(
    input wire [1:0] ALUop,
    input wire [31:0] instruction,
    output reg [3:0] control_signal
);

    always @(ALUop or instruction) begin
        case (ALUop)
            2'b00:
                control_signal = 4'b0000; 
            2'b01:
                control_signal = 4'b1000;  // beq
            2'b10:
                case (instruction[14:12])  // funct3 
                    3'b010:
                        if (instruction[4] == 0)
                            control_signal = 4'b0010;  // lw, sw
                        else
                            control_signal = 4'b0110;  // slti
                    3'b000:
                        control_signal = 4'b0000;  // addi
                    3'b110:
                        control_signal = 4'b0011;  // ori
                    default:
                        control_signal = 4'b1111;  // 默认合理值
                endcase
            2'b11:
                case (instruction[14:12])  // funct3 
                    3'b000:
                        if (instruction[30] == 0)
                            control_signal = 4'b0000;  // add
                        else
                            control_signal = 4'b0001;  // sub
                    3'b110:
                        control_signal = 4'b0011;  // or
                    3'b011:
                        control_signal = 4'b0110;  // slt
                    default:
                        control_signal = 4'b1111;  // 默认合理值
                endcase
        endcase
    end

//    always @(*) begin
//        $display("At time %t", $time);
//        $display("control_signal", control_signal);
//    end
    
endmodule
