`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2021 06:30:31 AM
// Design Name: 
// Module Name: ForwardingUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ForwardingUnit(EXMEMRegWrite, MEMWBRegWrite, MEMWBMemToReg, branch, IFIDRs, IFIDRt, IDEXRs, IDEXRt, IDEXRs2, EXMEMRd, MEMWBRd, MEMWBRd2, ForwardA,ForwardB,ForwardC,ForwardD,ForwardE);
    input [4:0] IFIDRs, IFIDRt, IDEXRs, IDEXRt, IDEXRs2, EXMEMRd, MEMWBRd, MEMWBRd2;
    input EXMEMRegWrite, MEMWBRegWrite, MEMWBMemToReg, branch;
    output reg [1:0] ForwardA,ForwardB,ForwardC,ForwardD,ForwardE;
    always @(*) begin
        if(EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IDEXRs)
            ForwardA = 2'b10;
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IDEXRs)
            ForwardA = 2'b01;
        else if(MEMWBMemToReg==1 && MEMWBRd2!=0 && MEMWBRd2==IDEXRs)
            ForwardA = 2'b11;
        else
            ForwardA = 2'b00;

        if(EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IDEXRt)
            ForwardB = 2'b10;
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IDEXRt)
            ForwardB = 2'b01;
        else if(MEMWBMemToReg==1 && MEMWBRd2!=0 && MEMWBRd2==IDEXRt)
            ForwardB = 2'b11;
        else
            ForwardB = 2'b00;

        if(EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IDEXRs2)
            ForwardC = 2'b10;
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IDEXRs2)
            ForwardC = 2'b01;
        else if(MEMWBMemToReg==1 && MEMWBRd2!=0 && MEMWBRd2==IDEXRs2)
            ForwardC = 2'b11;
        else
            ForwardC = 2'b00; 

        if(branch==1 && EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IFIDRs)
            ForwardD = 2'b10;
        else if(branch==1 && MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IFIDRs)
            ForwardD = 2'b01;
        else if(branch==1 && MEMWBMemToReg==1 && MEMWBRd2!=0 && MEMWBRd2==IFIDRs)
            ForwardD = 2'b11;
        else
            ForwardD = 2'b00;
        
        if(branch==1 && EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IFIDRt)
            ForwardE = 2'b10;
        else if(branch==1 && MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IFIDRt)
            ForwardE = 2'b01;
        else if(branch==1 && MEMWBMemToReg==1 && MEMWBRd2!=0 && MEMWBRd2==IFIDRt)
            ForwardE = 2'b11;
        else
            ForwardE = 2'b00;
    end
endmodule
