`include "define.v"

module ALUcontrol(
	input [`InstBus]instruction,
	input [`ALUopWidth-1:0] ALUop,
	output [`ControlSignalWidth-1:0] control_signal
);
    reg [3:0] control_signal;
    always@(ALUop or instruction)
        case(ALUop)
            2'b00: control_signal = `JAL_CONTROL_SIGNAL;  // jal÷∏¡Ó
            2'b01: control_signal = `BEQ_CONTROL_SIGNAL;  // beq÷∏¡Ó
            2'b10: case(instruction[14:12])  // funct3
                    3'b010: control_signal = `LW_SW_CONTROL_SIGNAL; // lw, sw
                    3'b000: control_signal = `ADDI_LB_SB_CONTROL_SIGNAL; // addi, lb, sb
                    3'b110: control_signal = `ORI_CONTROL_SIGNAL; // ori
                    3'b001: control_signal = `SLLI_CONTROL_SIGNAL; // slli
                    3'b101: control_signal = `SRLI_CONTROL_SIGNAL; // srli
                    default: control_signal = 4'bxxxx;
                  endcase    
            2'b11: case(instruction[14:12])  // funct3
                    3'b000:
                        begin 
                            if(instruction[30] == 0) control_signal = `ADD_CONTROL_SIGNAL; // add
                            else control_signal = `SUB_CONTROL_SIGNAL; // sub
                        end
                    3'b111: control_signal = `AND_CONTROL_SIGNAL; // and
                    3'b110: control_signal = `OR_CONTROL_SIGNAL; // or
                    3'b001: control_signal = `SLL_CONTROL_SIGNAL; // sll
                    3'b101: control_signal = `SRL_CONTROL_SIGNAL; // srl
                    3'b011: control_signal = `SLTU_CONTROL_SIGNAL; // sltu
                    default: control_signal = 4'bxxxx;
                  endcase
        endcase
endmodule