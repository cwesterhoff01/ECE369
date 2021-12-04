`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Participation:
// Chris Westerhoff - 33%
// Caiyue Lai - 33%
// Jackson Wood - 34%
// 
//////////////////////////////////////////////////////////////////////////////////
// 
//
//
//

/*
ControlBits
[0] - RegWrite
[1] - RegDst
[5:2] - ALUOp
[6] - ALUSrc

ControlBits2
[0] - MemToReg
[1] - MemRead
[2] - MemWrite
[4:3] - AddressType

ControlMuxOutput
[0] - RegWrite
[1] - MemToReg
[2] - MemRead
[3] - MemWrite
[5:4] - AddressType
[6] - RegDst
[10:7] - ALUOp
[11] - ALUSrc

IFID
[31:00] - PC+4
[63:32] - Instruction2
[95:64] - Instruction1
[37:32] - Funct2
[42:38] - Shamt2
[47:43] - Rd2
[52:48] - Rt2
[57:53] - Rs2
[63:58] - OpCode2
[57:32] - Jump Address Component2
[47:32] - Immediate2
[69:64] - Funct1
[74:70] - Shamt1
[79:75] - Rd1
[84:80] - Rt1
[89:85] - Rs1
[95:90] - OpCode1
[89:64] - Jump Address Component1
[79:64] - Immediate1
IDEX
[0] - RegWrite
[1] - MemToReg
[2] - MemRead
[3] - MemWrite
[05:04] - AddressType
[6] - RegDst
[11:07] - ALUOp
[12] - ALUSrc
[12:0] - Control Bits
[44:13] - PC+4
[76:45] - ReadData1
[110:77] - ReadData2
[140:109] - ReadData3
[172:141] - ReadData4
[204:173] - Immediate1
[236:205] - Immediate2
[238:237] - Jump
[243:239] - Shamt1
[248:244] - Rs1
[253:249] - Rt1
[258:254] - Rd1
[263:259] - Rs2
[268:264] - Rt2
EXMEM
[0] - RegWrite
[1] - MemToReg
[2] - MemRead
[3] - MemWrite
[05:04] - AddressType
[37:06] - ALUResult1
[69:38] - ReadData3
[101:70] - ALUResult2
[106:102] - Rd1
[111:107] - Rd2
[113:112] - Jump
[145:114] - PC+4
MEMWB
[0] - RegWrite
[1] - MemToReg
[33:2] - ALUResult1
[65:34] - DataMemoryOutput
[70:66] - Rd1
[75:71] - Rd2
[77:76] - Jump
[109:78] - PC+4
*/

module TopLevel(Clk,Rst,PCCheck,WriteDataCheck,HICheck,LOCheck);
    input Clk,Rst;
    output reg [31:0] PCCheck,WriteDataCheck,HICheck,LOCheck;
	wire [31:0] BranchAddress, PCAddResult, PCInput, branchMuxOutput, PCOutput, Instruction1, Instruction2,JALMux1Output,ReadData1,ReadData2,ReadData3,ReadData4;
	wire [31:0] Immediate1,Immediate2,BranchOffset,ALU1Mux1Output,ALU1Mux2Output,ALU1Mux3Output,ALU2MuxOutput,HIOutput,LOOutput,HIOutput2,LOOutput2,ALUResult1,ALUResult2,DataOutput;
	wire [31:0] compMux1Output,compMux2Output;
	wire [4:0] JALMux2Output,DestMuxOutput;
	wire branch, WritePC, WriteIFID, WriteControl,equalVal, gtZero, ltZero,beqz,PCSrc,Zero1,Zero2,either,lt;
	wire [12:0] ControlMuxOutput;
	wire [7:0] ControlBits;
	wire [4:0] ControlBits2;
	wire [1:0] Jump,ForwardA,ForwardB,ForwardC,ForwardD,ForwardE;
	wire [95:0] IFIDOut;
	wire [268:0] IDEXOut;
	wire [145:0] EXMEMOut;
	wire [109:0] MEMWBOut;
    Mux32Bit2To1 branchMux(BranchAddress,PCAddResult,branch,branchMuxOutput);
    Mux32Bit4To1 jumpMux(branchMuxOutput,{PCOutput[31:28],IFIDOut[89:64],2'b00},ReadData1,{PCOutput[31:28],IFIDOut[89:64],2'b00},Jump,PCInput);
	ProgramCounter PC(WritePC,PCInput,PCOutput,Clk,Rst);
	Adder PCAdder(PCOutput,32'd8,PCAddResult);
	InstructionMemory IM(PCOutput,Instruction1,Instruction2,Rst);
	RegisterIFID IFID(WriteIFID,branch,{Instruction1,Instruction2,PCAddResult},IFIDOut,Clk,Rst);
	RegisterFile RegFile(IFIDOut[89:85],IFIDOut[84:80],JALMux2Output,JALMux1Output,MEMWBOut[0],IFIDOut[57:53],IFIDOut[52:48],MEMWBOut[75:71],MEMWBOut[65:34],MEMWBOut[1],ReadData1,ReadData2,ReadData3,ReadData4,Clk,Rst);
	SignExtender SE1(IFIDOut[79:64],Immediate1);
	SignExtender SE2(IFIDOut[47:32],Immediate2);
	
	HazardDetectionUnit HDU(ControlBits[1],ControlBits2[2],IDEXOut[0],IDEXOut[2],EXMEMOut[2],branch,IFIDOut[89:85],IFIDOut[84:80],IFIDOut[57:53],IFIDOut[52:48],IDEXOut[268:264],IDEXOut[258:254],EXMEMOut[111:107],WritePC,WriteIFID,WriteControl);
    Controller control(IFIDOut[95:64],IFIDOut[63:32],equalVal,gtZero,ltZero,beqz,either,lt,ControlBits,ControlBits2,Jump,PCSrc, branch);
    Mux32Bit4To1 compMux1(ReadData1,MEMWBOut[33:2],EXMEMOut[37:6],MEMWBOut[65:34],ForwardD,compMux1Output);
    Mux32Bit4To1 compMux2(ReadData2,MEMWBOut[33:2],EXMEMOut[37:6],MEMWBOut[65:34],ForwardE,compMux2Output);
    Comparator comp(compMux1Output,compMux2Output,equalVal,gtZero,ltZero,beqz,either,lt);
	Mux13Bit2To1 controlMux(13'b0,{ControlBits[7:1],ControlBits2,ControlBits[0]},WriteControl,ControlMuxOutput);
    LeftShifter LS(Immediate1,BranchOffset);
	Adder BranchAdder(BranchOffset,IFIDOut[31:0],BranchAddress);
	
  //RegisterIDEX IDEX(1'b1,{Rt2,Rs2,Rd1,Rt1,Rs1,Shamt1,Jump,Immediate2,Immediate1,ReadData4,ReadData3,ReadData2,ReadData1,PC+4,ControlMuxOutput},IDEXOut,Clk,Rst);
	RegisterIDEX IDEX(1'b1,{IFIDOut[52:48],IFIDOut[57:53],IFIDOut[79:75],IFIDOut[84:80],IFIDOut[89:85],IFIDOut[74:70],Jump,Immediate2,Immediate1,ReadData4,ReadData3,ReadData2,ReadData1,IFIDOut[31:0],ControlMuxOutput},IDEXOut,Clk,Rst);
	
	Mux32Bit2To1 ALU1Mux1(IDEXOut[253:249],IDEXOut[204:173],IDEXOut[12],ALU1Mux1Output);
	Mux32Bit4To1 ALU1Mux2(IDEXOut[76:45],MEMWBOut[33:2],EXMEMOut[37:6],MEMWBOut[65:34],FORWARDA,ALU1Mux2Output);
	Mux32Bit4To1 ALU1Mux3(ALU1Mux1Output,MEMWBOut[33:2],EXMEMOut[37:6],MEMWBOut[65:34],FORWARDB,ALU1Mux3Output);
	Mux32Bit4To1 ALU2Mux(ReadData4,EXMEMOut[37:6],MEMWBOut[33:2],MEMWBOut[65:34],FORWARDC,ALU2MuxOutput);
	Mux5Bit2To1 DestMux(IDEXOut[253:249],IDEXOut[258:254],IDEXOut[6],DestMuxOutput);
	
	ALU alu1(ALU1Mux2Output,ALU1Mux3Output,IDEXOut[11:7],IDEXOut[243:239],HIOutput,LOOutput,ALUResult1,Zero1,Clk,Rst);
	ALU alu2(ALU2MuxOutput,IDEXOut[236:205],5'b00001,5'b0,HIOutput2,LOOutput2,ALUResult2,Zero2,Clk,Rst);
  //ForwardingUnit(EXMEMRegWrite, MEMWBRegWrite, MEMWBMemToReg, branch, IFIDRs, IFIDRt,       IDEXRs,           IDEXRt,          IDEXRs2,        EXMEMRd,          MEMWBRd,        MEMWBRd2,       ForwardA,ForwardB,ForwardC,ForwardD,ForwardE)
	ForwardingUnit FU(EXMEMOut[0],MEMWBOut[0],MEMWBOut[1],branch,IFIDOut[89:85],IFIDOut[84:80],IDEXOut[248:244],IDEXOut[253:249],IDEXOut[263:259],EXMEMOut[106:102],MEMWBOut[70:66],MEMWBOut[75:71],ForwardA,ForwardB,ForwardC,ForwardD,ForwardE);
	
	RegisterEXMEM EXMEM(1'b1,{IDEXOut[44:13],IDEXOut[238:237],IDEXOut[268:264],DestMuxOutput,ALUResult2,IDEXOut[140:109],ALUResult1,IDEXOut[5:0]},EXMEMOut,Clk,Rst);
  //DataMemory(MemWrite,      Address,       WriteData,       MemRead,    AddressType,  ReadData, Clk, Rst)
	DataMemory DM(EXMEMOut[3],EXMEMOut[101:70],EXMEMOut[69:38],EXMEMOut[2],EXMEMOut[5:4],DataOutput,Clk,Rst);
	RegisterMEMWB MEMWB(1'b1,{EXMEMOut[145:114],EXMEMOut[113:112],EXMEMOut[111:107],EXMEMOut[106:102],DataOutput,EXMEMOut[37:6],EXMEMOut[1:0]},MEMWBOut,Clk,Rst);
	Mux32Bit2To1 JALMux1(MEMWBOut[33:2],MEMWBOut[109:78],MEMWBOut[77]&MEMWBOut[76],JALMux1Output);
    Mux5Bit2To1 JALMux2(MEMWBOut[70:66],5'd31,MEMWBOut[77]&MEMWBOut[76],JALMux2Output);
    always @(*) begin
        PCCheck = PCOutput;
        WriteDataCheck = JALMux1Output;
        HICheck = HIOutput;
        LOCheck = LOOutput;
    end
endmodule