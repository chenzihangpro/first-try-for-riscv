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
`define InstBus 31:0            //指令位宽
`define InstAddrBus 9:0         //指令存储器地址位宽

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
    // 控制信号的宏定义
`define NoBranch  1'bz   // 分支信号不生效
`define DoBranch   1'b1   // 分支信号生效
`define NoMemRead   1'bz   // 无需读取内存
`define DoMemRead   1'b1   // 需要读取内存
`define NoMemWrite  1'bz   // 无需写入内存
`define DoMemWrite  1'b1   // 需要写入内存
`define NoALUSrc    1'b0   // ALU源不来自立即数
`define DoALUSrc    1'b1   // ALU源来自立即数
`define NoRegWrite  1'bz   // 不写寄存器
`define DoRegWrite  1'b1   // 写寄存器
`define NotJAL      1'bz   // 不跳转
`define DoJAL       1'b1   // 跳转
`define MemToRegDefault 2'b00 // 默认来自ALU操作
`define MemToRegLoad   2'b01 // 来自内存的加载数据
`define MemToRegLUI    2'b11 // 来自LUI指令
    // ALUop宏定义                                                      ***TODO***
//`define ALU_ADD    3'b000  // ALU 执行加法运算
//`define ALU_SUB    3'b001  // ALU 执行减法运算
//`define ALU_NAND   3'b011  // ALU 执行 NAND 运算
//`define ALU_OR     3'b010  // ALU 执行 OR 运算
//`define ALU_SHIFT  3'b100  // ALU 执行移位运算
//ALUcontrol
    // ALU 控制信号
`define JAL_CONTROL_SIGNAL  4'b1001  // jal 指令的 ALU 控制信号
`define BEQ_CONTROL_SIGNAL  4'b1000  // beq 指令的 ALU 控制信号
`define LW_SW_CONTROL_SIGNAL 4'b0000 // lw 和 sw 指令的 ALU 控制信号
`define ADDI_LB_SB_CONTROL_SIGNAL 4'b0000 // addi, lb, sb 指令的 ALU 控制信号
`define ORI_CONTROL_SIGNAL  4'b0011  // ori 指令的 ALU 控制信号
`define SLLI_CONTROL_SIGNAL 4'b0100  // slli 指令的 ALU 控制信号
`define SRLI_CONTROL_SIGNAL 4'b0101  // srli 指令的 ALU 控制信号
`define ADD_CONTROL_SIGNAL  4'b0000  // add 指令的 ALU 控制信号
`define SUB_CONTROL_SIGNAL  4'b0001  // sub 指令的 ALU 控制信号
`define AND_CONTROL_SIGNAL  4'b0010  // and 指令的 ALU 控制信号
`define OR_CONTROL_SIGNAL   4'b0011  // or 指令的 ALU 控制信号
`define SLL_CONTROL_SIGNAL  4'b0100  // sll 指令的 ALU 控制信号
`define SRL_CONTROL_SIGNAL  4'b0101  // srl 指令的 ALU 控制信号
`define SLTU_CONTROL_SIGNAL 4'b0110  // sltu 指令的 ALU 控制信号

//ALUcontrol
`define ControlSignalWidth 3'b100


//ALU
`define ALU_OP_ADD    4'b0000  // 加法操作
`define ALU_OP_SUB    4'b0001  // 减法操作
`define ALU_OP_AND    4'b0010  // 与操作
`define ALU_OP_OR     4'b0011  // 或操作
`define ALU_OP_SLL    4'b0100  // 左移操作
`define ALU_OP_SRL    4'b0101  // 右移操作
`define ALU_OP_SLTU   4'b0110  // 无符号小于操作
`define ALU_OP_BEQ    4'b1000  // BEQ 条件判断
`define ALU_OP_JAL    4'b1001  // JAL 指令

`define ALU_Result_Bus 31:0
`define ALU_Result_Width 6'd31
