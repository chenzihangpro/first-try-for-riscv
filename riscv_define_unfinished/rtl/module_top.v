`include "define.v"

module top(
    input        rst_n,
    input        clk,
    output [`InstBus]instruct,
 
    output [`InstAddrBus] address,
    output [`ALU_Result_Bus]  ALU_result,
    output [`RegAddrBus] rd_address
 
);

wire branch  ;
wire memread ;
wire [1:0]memtoreg;
wire memwrite;
wire ALUsrc  ;  
wire regwrite;
//wire [9:0]address;
//wire [31:0]instruct;
wire jal     ;
 
/****************************************************************/
wire [`ALUopWidth-1:0]  ALUop          ;
wire [`RegWidth-1:0]  write_data     ;
wire [`RegWidth-1:0]  read_data1     ;
wire [`RegWidth-1:0]  read_data2     ;
wire [`ImmWidth-1:0]  immediate      ;
wire [`ControlSignalWidth-1:0]  control_signal ;
wire [`ALU_Result_Width-1:0]  ALU_result     ;
wire         ALU_zero       ;
wire [`RegWidth-1:0]  q1             ;
wire [4:0]   rd             ;               //’‚ «…∂–≈∫≈£ø
/****************************************************************/
/*********************************************************************/
/*********************************************************************/
PC_reg u_PC_reg
   (
    .clk     (clk      ),
	.rst_n   (rst_n    ),
	.PCout   (address  ),
	.imm     (immediate),
	.branch  (branch   ),
	.ALU_zero(ALU_zero )
    );
 
 
	 
Instruction_Memory u_instruction
   (
	.ReadAddress       (address      ),
	.Instruction      (instruct     )
	);
	
register u_register    
      (
        .clk           (clk            ),
		.rst_n         (rst_n          ),
		.read_register1(instruct[19:15]),
		.read_register2(instruct[24:20]),
		.write_register(instruct[11:7] ),
		.write_data    (ALU_result    ),
		.read_data1    (read_data1     ),
		.read_data2    (read_data2     ),
		.regwrite      (regwrite       )
    );
 
	 
	 
ALU u_ALU   
   (
   .control_signal(control_signal),
   .read_data1    (read_data1    ),
   .read_data2    (read_data2    ),
   .immediate     (immediate     ),
   .ALU_src       (ALUsrc        ),
   .ALU_result    (ALU_result    ),
   .ALU_zero      (ALU_zero      )
    );
	 
control u_control      
    (
     .instruction  (instruct[6:0]     ),
	 .branch  (branch            ),
	 .memread (memread           ),
	 .memtoreg(memtoreg          ),
	 .ALUop   (ALUop             ),
	 .memwrite(memwrite          ),
	 .ALUsrc  (ALUsrc            ),
	 .regwrite(regwrite          ),
	 .jal     (jal               )
    );	 
	
ALUcontrol u_ALUcontrol
   (
   .ALUop        (ALUop         ),
	.instruction   (instruct      ),
	.control_signal(control_signal)
    );	
	
immgen u_immgen
   (
   .instruct (instruct ),
	.immediate(immediate)
   );	
	
memory u_memory(
    .CLK       (clk            ),
	.addr      (ALU_result     ),
	.DIN      (read_data2     ),
	.DOUT       (q1             ),
	.WRn      (memwrite       ),
	.RDn      (memread        )    
);	
 
mux2 u_mux2(
  .memtoreg (memtoreg  ),
  .jal      (jal       ),
  .out1       (q1        ),   //memory output data
  .out2       (ALU_result),
  .out3        (address   ), 
   .instruct (instruct ),  
  .writedata(write_data)
);
assign rd_address=instruct[11:7];
/*********************************************************************/
/*********************************************************************/
 
endmodule