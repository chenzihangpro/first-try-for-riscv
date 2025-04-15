module immgen(
    instruct,
	immediate
);
 
//原本写法 
input      [31:0]  instruct ;
output reg [31:0]  immediate;
 
always@(*)
  if(instruct[6:0] == 7'b0010011)     //addi,ori,slli,srli
   immediate = {20'b0,instruct[31:20]};
	
  else if( (instruct[6:0] == 7'b0000011) && ( (instruct[14:12] == 3'b010) || (instruct[14:12] == 3'b000) ) )  //lw,lb
   immediate = {20'b0,instruct[31:20]};
	
  else if( (instruct[6:0] == 7'b0100011) && ( (instruct[14:12] == 3'b010) || (instruct[14:12] == 3'b000) ) )  //sw,sb
   immediate = {20'b0,instruct[31:25],instruct[11:7]};		
	
  else if(instruct[6:0] == 7'b1100011)begin                              //B-type
     if(instruct[31] == 1'b1)
       immediate = {instruct[31],19'b1,instruct[7],instruct[30:25],instruct[11:8],1'b0};	
	  else 
	    immediate = {instruct[31],19'b0,instruct[7],instruct[30:25],instruct[11:8],1'b0};  
   end	
  
  else if(instruct[6:0] == 7'b1101111)begin                              //J-type
     if(instruct[31] == 1'b1)
       immediate = {instruct[31],11'b1,instruct[19:12],instruct[20],instruct[30:21],1'b0};	
	  else 
	    immediate = {instruct[31],11'b0,instruct[19:12],instruct[20],instruct[30:21],1'b0}; 
		end		
 
  
  else 
		immediate = `ZeroNum;

// //改进:借鉴tinyriscv的方法，设置case，比如：
// wire[6:0] opcode = instruct[6:0];
// wire[2:0] funct3 = instruct[14:12];
// wire[6:0] funct7 = Instruct[31:25];
// //imm_case
// case(opcode)
// `INST_TYPE_R_M:begin

// `INST_TYPE_I:begin

// `INST_TYPE_S:begin

// `INST_TYPE_B:begin

// endcase    	
endmodule