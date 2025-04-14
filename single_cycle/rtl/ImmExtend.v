`timescale 1ns / 1ps
module ImmExtend(
    input wire [31:0] instruction,
    output reg [31:0] imm_extended
);
    always@(*)begin
        case(instruction[6:0])
            7'b0010011:
                imm_extended = {{20{instruction[31]}},instruction[31:20]};
            7'b0000011:
                imm_extended = {{20{instruction[31]}},instruction[31:20]};
            7'b0100011:
                imm_extended = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
            7'b1100011:
                imm_extended = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0};
            default:
                imm_extended = 32'b0;
        endcase
    end
    
endmodule
    
    