`timescale 1ns / 1ps
module PC_module(
    input wire clk,
    input wire reset,
    input wire [31:0] branch_offset,
    input wire beq_taken,
    output reg [31:0] PC
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'b0;
        else if (beq_taken)
            PC <= PC + branch_offset;
        else
            PC <= PC + 4;
    end

endmodule

    

    