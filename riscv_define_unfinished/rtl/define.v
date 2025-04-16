/*************************Some Common Defines***************************************/
`define WriteEnable 1'b1
`define ReadEnable 1'b1
`define RstEnable 1'b0
`define RstDisable 1'b1

/*****************************Reset Signal*****************************************/
`define ZeroWord 32'h0
`define ZeroReg 5'h0
`define ZeroAddr 10'd0
`define ZeroNum 32'b0

/**************************Different Define Parts*****************************************/
//common_regs
`define RegAddrBus 4:0
`define RegBus 31:0
`define RegWidth 32
`define RegNum 32

//inst_mem
`define InstMemWidth 8
`define InstMemDepth 128        
`define InstBus 31:0            //ָ��λ��
`define InstAddrBus 9:0         //ָ��洢����ַλ��

//pc_reg
`define ImmWidth 6'd32
`define ImmBus 31:0


//data_mem



// //imm_ex
// // R and M type inst
// `define INST_TYPE_R_M 7'b0110011
// // R type inst
// `define INST_ADD_SUB 3'b000
// `define INST_SLL    3'b001
// `define INST_SLT    3'b010
// `define INST_SLTU   3'b011
// `define INST_XOR    3'b100
// `define INST_SR     3'b101
// `define INST_OR     3'b110
// `define INST_AND    3'b111
// // M type inst
// `define INST_MUL    3'b000
// `define INST_MULH   3'b001
// `define INST_MULHSU 3'b010
// `define INST_MULHU  3'b011
// `define INST_DIV    3'b100
// `define INST_DIVU   3'b101
// `define INST_REM    3'b110
// `define INST_REMU   3'b111

// // I type inst
// `define INST_TYPE_I 7'b0010011
// `define INST_ADDI   3'b000
// `define INST_SLTI   3'b010
// `define INST_SLTIU  3'b011
// `define INST_XORI   3'b100
// `define INST_ORI    3'b110
// `define INST_ANDI   3'b111
// `define INST_SLLI   3'b001
// `define INST_SRI    3'b101

// // S type inst
// `define INST_TYPE_S 7'b0100011
// `define INST_SB     3'b000
// `define INST_SH     3'b001
// `define INST_SW     3'b010

// // J type B_and_other inst

// // J type_B inst
// `define INST_TYPE_B 7'b1100011
// `define INST_BEQ    3'b000
// `define INST_BNE    3'b001
// `define INST_BLT    3'b100
// `define INST_BGE    3'b101
// `define INST_BLTU   3'b110
// `define INST_BGEU   3'b111

// //other inst
// `define INST_JAL    7'b1101111
// `define INST_JALR   7'b1100111

// `define INST_LUI    7'b0110111
// `define INST_AUIPC  7'b0010111
// `define INST_NOP    32'h00000001
// `define INST_NOP_OP 7'b0000001
// `define INST_MRET   32'h30200073
// `define INST_RET    32'h00008067

// `define INST_FENCE  7'b0001111
// `define INST_ECALL  32'h73
// `define INST_EBREAK 32'h00100073

// // L type inst
// `define INST_TYPE_L 7'b0000011
// `define INST_LB     3'b000
// `define INST_LH     3'b001
// `define INST_LW     3'b010
// `define INST_LBU    3'b100
// `define INST_LHU    3'b101

//control
`define OpcodeWidth 3'b111
`define MemToRegWidth 2'b10
`define ALUopWidth 2'b10
    // �����źŵĺ궨��
`define NoBranch  1'bz   // ��֧�źŲ���Ч
`define DoBranch   1'b1   // ��֧�ź���Ч
`define NoMemRead   1'bz   // �����ȡ�ڴ�
`define DoMemRead   1'b1   // ��Ҫ��ȡ�ڴ�
`define NoMemWrite  1'bz   // ����д���ڴ�
`define DoMemWrite  1'b1   // ��Ҫд���ڴ�
`define NoALUSrc    1'b0   // ALUԴ������������
`define DoALUSrc    1'b1   // ALUԴ����������
`define NoRegWrite  1'bz   // ��д�Ĵ���
`define DoRegWrite  1'b1   // д�Ĵ���
`define NotJAL      1'bz   // ����ת
`define DoJAL       1'b1   // ��ת
`define MemToRegDefault 2'b00 // Ĭ������ALU����
`define MemToRegLoad   2'b01 // �����ڴ�ļ�������
`define MemToRegLUI    2'b11 // ����LUIָ��
    // ALUop�궨��                                                      ***TODO***
//`define ALU_ADD    3'b000  // ALU ִ�мӷ�����
//`define ALU_SUB    3'b001  // ALU ִ�м�������
//`define ALU_NAND   3'b011  // ALU ִ�� NAND ����
//`define ALU_OR     3'b010  // ALU ִ�� OR ����
//`define ALU_SHIFT  3'b100  // ALU ִ����λ����
//ALUcontrol
    // ALU �����ź�
`define JAL_CONTROL_SIGNAL  4'b1001  // jal ָ��� ALU �����ź�
`define BEQ_CONTROL_SIGNAL  4'b1000  // beq ָ��� ALU �����ź�
`define LW_SW_CONTROL_SIGNAL 4'b0000 // lw �� sw ָ��� ALU �����ź�
`define ADDI_LB_SB_CONTROL_SIGNAL 4'b0000 // addi, lb, sb ָ��� ALU �����ź�
`define ORI_CONTROL_SIGNAL  4'b0011  // ori ָ��� ALU �����ź�
`define SLLI_CONTROL_SIGNAL 4'b0100  // slli ָ��� ALU �����ź�
`define SRLI_CONTROL_SIGNAL 4'b0101  // srli ָ��� ALU �����ź�
`define ADD_CONTROL_SIGNAL  4'b0000  // add ָ��� ALU �����ź�
`define SUB_CONTROL_SIGNAL  4'b0001  // sub ָ��� ALU �����ź�
`define AND_CONTROL_SIGNAL  4'b0010  // and ָ��� ALU �����ź�
`define OR_CONTROL_SIGNAL   4'b0011  // or ָ��� ALU �����ź�
`define SLL_CONTROL_SIGNAL  4'b0100  // sll ָ��� ALU �����ź�
`define SRL_CONTROL_SIGNAL  4'b0101  // srl ָ��� ALU �����ź�
`define SLTU_CONTROL_SIGNAL 4'b0110  // sltu ָ��� ALU �����ź�

//ALUcontrol
`define ControlSignalWidth 3'b100


//ALU
`define ALU_OP_ADD    4'b0000  // �ӷ�����
`define ALU_OP_SUB    4'b0001  // ��������
`define ALU_OP_AND    4'b0010  // �����
`define ALU_OP_OR     4'b0011  // �����
`define ALU_OP_SLL    4'b0100  // ���Ʋ���
`define ALU_OP_SRL    4'b0101  // ���Ʋ���
`define ALU_OP_SLTU   4'b0110  // �޷���С�ڲ���
`define ALU_OP_BEQ    4'b1000  // BEQ �����ж�
`define ALU_OP_JAL    4'b1001  // JAL ָ��

`define ALU_Result_Bus 31:0
`define ALU_Result_Width 6'd31
