module Instruction_Memory(
    input[`InstAddrBus] ReadAddress,
    output[`InstBus] Instruction
);
  
reg[`InstBus] Instruction;
wire[`InstMemWidth-1:0] InstMem[`InstMemDepth-1:0];//8x128 = 2^10
 
//small store for 17 pieces of instruction
assign InstMem[0] = 8'bz,       //0000000_00000_00000_000_00000_0110011 //ADD $0 $0 $0
       InstMem[1] = 8'bz,
       InstMem[2] = 8'bz,
       InstMem[3] = 8'bz;
        
assign InstMem[4] = 8'b1_0110011,       //0000000_00010_00001_000_00011_0110011 //ADD $3 $1 $2
       InstMem[5] = 8'b1_000_0001,
       InstMem[6] = 8'b0010_0000,
       InstMem[7] = 8'b0000000_0;
       
assign InstMem[8] = 8'b0_0110011,       //0100000_00101_00100_000_00110_0110011  //SUB $6 $4 $5       
       InstMem[9] = 8'b0_000_0011,
       InstMem[10] = 8'b0101_0010,
       InstMem[11] = 8'b0100000_0;
       
assign InstMem[12] = 8'b1_0110011,       //0000000_01000_00111_001_01001_0110011 //SLL $9 $7 $8
       InstMem[13] = 8'b1_001_0100,
       InstMem[14] = 8'b1000_0011,
       InstMem[15] = 8'b0000000_0;
        
assign InstMem[16] = 8'b0_0110011,       //0000000_01011_01010_011_01100_0110011 //SLTU $12 $10 $11
       InstMem[17] = 8'b0_011_0110,
       InstMem[18] = 8'b1011_0101,
       InstMem[19] = 8'b0000000_0;
       
assign InstMem[20] = 8'b1_0110011,       //0000000_01110_01101_101_01111_0110011 //SRL $15 $13 $14
       InstMem[21] = 8'b1_101_0111,
       InstMem[22] = 8'b1110_0110,
       InstMem[23] = 8'b0000000_0;  
                 
assign InstMem[24] = 8'b0_0110011,       //0000000_10001_10000_111_10010_0110011 //AND $18 $16 $17
       InstMem[25] = 8'b0_111_1001,
       InstMem[26] = 8'b0001_1000,
       InstMem[27] = 8'b0000000_1; 
       
assign InstMem[28] = 8'b1_0110011 ,       //0000000_10100_10011_110_10101_0110011 //OR $21 $19 $20
       InstMem[29] = 8'b1_110_1010,
       InstMem[30] = 8'b0100_1001,
       InstMem[31] = 8'b0000000_1;
                  
assign InstMem[32] = 8'b1_0000011,       //000000000001_10110_010_10111_0000011 //LW $23 1($22)
       InstMem[33] = 8'b0_010_1011,
       InstMem[34] = 8'b0001_1011,
       InstMem[35] = 8'b00000000; 
          
assign InstMem[36] = 8'b1_0010011,       //000000000001_11000_000_11001_0010011 //ADDI $25 $24 32'h00000001
       InstMem[37] = 8'b0_000_1100,
       InstMem[38] = 8'b0001_1100,
       InstMem[39] = 8'b0000000_0;
       
assign InstMem[40] = 8'b1_0010011,       //000000000011_11010_110_11011_0010011 //ORI $27 $26 32'h00000003
       InstMem[41] = 8'b0_110_1101,
       InstMem[42] = 8'b0011_1101,
       InstMem[43] = 8'b00000000;   
       
assign InstMem[44] = 8'b1_0010011,       //000000000010_11100_001_11101_0010011 //SLLI $29 $28 32'h00000002
       InstMem[45] = 8'b0_001_1110,
       InstMem[46] = 8'b0010_1110,
       InstMem[47] = 8'b00000000;
             
assign InstMem[48] = 8'b1_0010011,       //000000000010_11110_101_11111_0010011 //SRLI $31 $30 32'h00000002
       InstMem[49] = 8'b0_101_1111,
       InstMem[50] = 8'b010_1111,
       InstMem[51] = 8'b00000000; 
         
assign InstMem[52] = 8'b0_0100011,       //0000000_00010_00001_010_01000_0100011 //SW MEM($1+32'h00000008) $2
       InstMem[53] = 8'b1_010_0100,
       InstMem[54] = 8'b0010_0000,
       InstMem[55] = 8'b0000000_0;
              
assign InstMem[56] = 8'b0_1100111,       //0000000_00100_00011_000_00010_1100111 //BEQ $4 $3 32'00000001
       InstMem[57] = 8'b1_000_0001,     
       InstMem[58] = 8'b0100_0001,
       InstMem[59] = 8'b0000000_0; 
       
assign InstMem[60] = 8'b1_0110111,       //00000000000000000110_01101_0110111  //LUI $5 32'h00000000000000000110_000000000000
       InstMem[61] = 8'b0110_0110,
       InstMem[62] = 8'b00000000,
       InstMem[63] = 8'b00000000;  
         
assign InstMem[64] = 8'b0_1101111,       //00000000010000000000，00110，1101111//JAL $6,32'h00000008
       InstMem[65] = 8'b0000_0011,       
       InstMem[66] = 8'b1000_0000,
       InstMem[67] = 8'b00000000;

//more instruction:      
//assign InstMem[68] = 8'b0_1100011,       //0000000_11111_00011_000_10010_1100011 //IF $3==$31 then JUMP to PC+32'd36 (BEQ)
//       InstMem[69] = 8'b1_000_1001,
//       InstMem[70] = 8'b1111_0001,
//       InstMem[71] = 8'b0000000_1; 
//assign InstMem[104] = 8'b0_1101111,      //00000000011000000000_11110_1101111 //JUMP to PC+32'h12, SAVE PC+4 to $30
//       InstMem[105] = 8'b0000_1111,
//       InstMem[106] = 8'b01100000,
//       InstMem[107] = 8'b00000000; 


//get an instruction                                                                                                        
always@(ReadAddress) 
  Instruction = {InstMem[ReadAddress+32'd3],InstMem[ReadAddress+32'd2],
                 InstMem[ReadAddress+32'd1],InstMem[ReadAddress]};
                   
endmodule
