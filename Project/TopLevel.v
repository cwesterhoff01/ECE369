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
[37:32] - Funct
[42:38] - Shamt
[47:43] - Rd
[52:48] - Rt
[57:53] - Rs
[63:58] - OpCode
[57:32] - Jump Address Component
[47:32] - Immediate

IDEX
[0] - RegWrite
[1] - MemToReg
[2] - MemRead
[3] - MemWrite
[05:04] - AddressType
[6] - RegDst
[11:07] - ALUOp
[12] - ALUSrc
[44:13] - RegData1
[76:45] - RegData2
[108:77] - Immediate
[113:109] - Rs
[118:114] - Rt
[123:119] - Rd
[128:124] - Shamt

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
    wire [162:0] IDEXOut;
    wire [108:0] EXMEMOut;
    wire [104:0] MEMWBOut;
    wire [63:0] IFIDOut;
    wire [31:0] CompMux1Output,CompMux2Output,JALMux1Output,HIOutput, LOOutput, PCAddResult,BranchAddress,BranchMuxResult, RegData1, RegData2, PCInput, PCOutput, Instruction, Immediate, DataMuxOutput, ALUResult, ALUMux1Output, ALUMux2Output, ALUMux3Output, DataOutput, BranchOffset;
    wire [12:0] ControlBits,ControlMuxOutput;
    wire [4:0] RdMuxOutput,JALMux2Output;
    wire [1:0] Jump, ForwardA, ForwardB, ForwardC, ForwardD;
    wire PCSrc, WritePC, WriteIFID, WriteControl, equalVal, gtZero, ltZero, eqZero, beqz,branch;
    
    
    Mux32Bit2To1 branchMux(PCAddResult,BranchAddress,PCSrc,BranchMuxResult);
    Mux32Bit4To1 jumpMux(BranchMuxResult,{PCOutput[31:28],IFIDOut[57:32],2'b00},RegData1,{PCOutput[31:28],IFIDOut[57:32],2'b00},Jump,PCInput);
    ProgramCounter PC(WritePC,PCInput,PCOutput,Clk,Rst);
    Adder PCAdd(PCOutput,32'd4,PCAddResult);
    //Change instruction memory to output two instructions
    InstructionMemory IM(PCOutput,Instruction,Rst);
    //change pipeline registers
    RegisterIFID IFID(WriteIFID,branch,{Instruction,PCAddResult},IFIDOut,Clk,Rst);
  //HazardDetectionUnit HDU(IFIDRs,        IFIDRt,       EXRd,        EXMEMRd,        IFIDRegDst,    IDEXRegWrite,EXMEMRegWrite,MEMWBRd,    MEMWBRegWrite,PCWrite,IFIDWrite,ControlWrite);
    HazardDetectionUnit HDU(IFIDOut[57:53],IFIDOut[52:48],RdMuxOutput,EXMEMOut[74:70],ControlBits[6],IDEXOut[0],EXMEMOut[0],MEMWBOut[70:66],MEMWBOut[0],WritePC,WriteIFID,WriteControl);
    Controller control(IFIDOut[63:32],equalVal,gtZero,ltZero,beqz,ControlBits,Jump,PCSrc, branch);
    Comparator comp(RegData1,RegData2,equalVal,gtZero,ltZero,beqz);
    //add sign extender
    SignExtender SE(IFIDOut[47:32],Immediate);
    //change regFil
    RegisterFile RegFile(IFIDOut[57:53],IFIDOut[52:48],JALMux2Output,DataMuxOutput,MEMWBOut[0],RegData1,RegData2,Clk,Rst);
    Mux13Bit2To1 controlMux(13'b0,ControlBits,WriteControl,ControlMuxOutput);
    LeftShifter LS(Immediate,BranchOffset);
    Adder adder(BranchOffset,IFIDOut[31:0],BranchAddress);
    //change pipeline register
    RegisterIDEX IDEX(1'b1,{IFIDOut[31:0],Jump,IFIDOut[42:38],IFIDOut[47:43],IFIDOut[52:48],IFIDOut[57:53],Immediate,RegData2,RegData1,ControlMuxOutput},IDEXOut,Clk,Rst);
    Mux5Bit2To1 RdMux(IDEXOut[118:114],IDEXOut[123:119],IDEXOut[6],RdMuxOutput);
    Mux32Bit2To1 ALUMux3(IDEXOut[76:45],IDEXOut[108:77],IDEXOut[12],ALUMux3Output);
    //add new ALU & change ALU outputs
    ALU alu(IDEXOut[44:13],ALUMux3Output,IDEXOut[11:7],IDEXOut[128:124],HIOutput,LOOutput,ALUResult,Zero,Clk,Rst);
    //Change pipeline register
    RegisterEXMEM EXMEM(1'b1,{IDEXOut[162:131],IDEXOut[130:129],RdMuxOutput,IDEXOut[76:45],ALUResult,IDEXOut[5:0]},EXMEMOut,Clk,Rst);
    //Change datamemory inputs
    DataMemory DM(EXMEMOut[3],EXMEMOut[37:6],EXMEMOut[69:38],EXMEMOut[2],EXMEMOut[5:4],DataOutput,Clk,Rst);
    RegisterMEMWB MEMWB(1'b1,{EXMEMOut[108:77],EXMEMOut[76:75],EXMEMOut[74:70],EXMEMOut[37:6],DataOutput,EXMEMOut[1:0]},MEMWBOut,Clk,Rst);
    Mux32Bit2To1 JALMux1(MEMWBOut[65:34],MEMWBOut[104:73],MEMWBOut[72]&MEMWBOut[71],JALMux1Output);
    Mux5Bit2To1 JALMux2(MEMWBOut[70:66],5'd31,MEMWBOut[72]&MEMWBOut[71],JALMux2Output);
    Mux32Bit2To1 DataMux(JALMux1Output,MEMWBOut[33:2],MEMWBOut[1],DataMuxOutput);
    always @(*) begin
        PCCheck = PCOutput;
        WriteDataCheck = DataMuxOutput;
        HICheck = HIOutput;
        LOCheck = LOOutput;
    end
endmodule
