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
[37:06] - ALUResult
[69:38] - RegData2
[74:70] - RD

MEMWB
[0] - RegWrite
[1] - MemToReg
[33:02] - MemData
[65:34] - ALUResult
[70:66] - RD
*/

module TopLevel(Clk,Rst,PCCheck,WriteDataCheck,HICheck,LOCheck);
    input Clk,Rst;
    output reg [31:0] PCCheck,WriteDataCheck,HICheck,LOCheck;
	wire [31:0] BranchAddress,PCAddResult,PCInput,PCOutput,Instruction1,Instruction2;
	wire branch, WritePC;
    Mux32Bit4To1 branchMux(BranchAddress,32'h80000180,PCAddResult,32'b0,branch,PCInput);
	ProgramCounter PC(WritePC,PCInput,PCOutput,Clk,Rst);
	Adder PCAdder(PCOutput,32'd4,PCAddResult);
	InstructionMemory IM(PCOutput,Instruction1,Instruction2,Rst);
	RegisterIFID IFID(WriteIFID,branch,{Instruction1,Instruction2,PCAddResult},IFIDOut,Clk,Rst);
	RegisterFile RegFile(IFIDOut[89:85],IFIDOut[84:80],JALMux2Output,DataMuxOutput,MEMWBOut[0],IFIDOut[57:53],IFIDOut[52:48],WriteAddress2,WriteData2,RegWrite2,RegData1,RegData2,RegData3,RegData4,Clk,Rst);
	SignExtender SE1(IFIDOut[79:64],Immediate1);
	SignExtender SE2(IFIDOut[47:32],Immediate2);
	
	//HazardDetectionUnit HDU(IFIDOut[57:53],IFIDOut[52:48],RdMuxOutput,EXMEMOut[74:70],ControlBits[6],IDEXOut[0],EXMEMOut[0],MEMWBOut[70:66],MEMWBOut[0],WritePC,WriteIFID,WriteControl);
    Controller control(IFIDOut[95:64],IFIDOut[63:32],equalVal,gtZero,ltZero,beqz,ControlBits,Jump,PCSrc, branch);
    Comparator comp(RegData1,RegData2,equalVal,gtZero,ltZero,beqz);
	Mux13Bit2To1 controlMux(13'b0,ControlBits,WriteControl,ControlMuxOutput);
    LeftShifter LS(Immediate1,BranchOffset);
	Adder BranchAdder(BranchOffset,IFIDOut[31:0],BranchAddress);
	
  //RegisterIDEX IDEX(1'b1,{Rt2,Rs2,Rd1,Rt1,Rs1,Shamt1,Jump,Immediate2,Immediate1,ReadData4,ReadData3,ReadData2,ReadData1,PC+4,ControlMuxOutput},IDEXOut,Clk,Rst);
	RegisterIDEX IDEX(1'b1,{IFIDOut[52:48],IFIDOut[57:53],IFIDOut[79:75],IFIDOut[84:80],IFIDOut[89:85],IFIDOut[74:70],Jump,Immediate2,Immediate1,ReadData4,ReadData3,ReadData2,ReadData1,IFIDOut[31:0],ControlMuxOutput},IDEXOut,Clk,Rst);
	
	Mux32Bit2To1 ALU1Mux1(IDEXOut[253:249],IDEXOut[204:173],IDEXOut[12],ALU1Mux1Output);
	Mux32Bit4To1 ALU1Mux2(ReadData1,ForwardI1Mem,ForwardI1WB,ForwardI2WB,FORWARDA,ALU1Mux2Output);
	Mux32Bit4To1 ALU1Mux3(ALU1Mux1Output,ForwardI1Mem,ForwardI1WB,ForwardI2WB,FORWARDB,ALU1Mux3Output);
	Mux32Bit4To1 ALU2Mux(ReadData4,ForwardI1Mem,ForwardI1WB,ForwardI2WB,FORWARDC,ALU2MuxOutput);
	Mux5Bit2To1 DestMux(IDEXOut[253:249],IDEXOut[258:254],IDEXOut[6],DestMuxOutput);
	
	ALU alu1(ALU1Mux2Output,ALU1Mux3Output,IDEXOut[11:7],IDEXOut[243:239],HIOutput,LOOutput,ALUResult1,Zero1,Clk,Rst);
	ALU alu2(ALU2MuxOutput,IDEXOut[236:205],5'b00001,5'b0,HIOutput2,LOOutput2,ALUResult2,Zero2,Clk,Rst);
	
	//ForwardingUnit FU();
	
	RegisterEXMEM EXMEM();
	DataMemory DM();
	RegisterMEMWB MEMWB();
	Mux32Bit4To1 DataMux();
	
endmodule
