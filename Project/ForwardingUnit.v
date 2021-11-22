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


module ForwardingUnit(IFIDRs,IFIDRt,IDEXRs,IDEXRt,EXMEMRd,MEMWBRd,EXMEMRegWrite,MEMWBRegWrite,branch,ForwardA,ForwardB,ForwardC,ForwardD);
    input [4:0] IFIDRs,IFIDRt,IDEXRs,IDEXRt,EXMEMRd,MEMWBRd;
    input EXMEMRegWrite,MEMWBRegWrite,branch;
    output reg [1:0] ForwardA,ForwardB,ForwardC,ForwardD;
    always @(*) begin
        if(EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IDEXRs)
            ForwardA = 2'b10;
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IDEXRs)
            ForwardA = 2'b01;
        else
            ForwardA = 2'b00;
        if(EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IDEXRt)
            ForwardB = 2'b10;
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IDEXRt)
            ForwardB = 2'b01;
        else
            ForwardB = 2'b00;
        if(branch==1 && EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IFIDRs)
            ForwardC = 2'b10;
        else if(branch==1 && MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IFIDRs)
            ForwardC = 2'b01;
        else
            ForwardC = 2'b00;
        if(branch==1 && EXMEMRegWrite==1 && EXMEMRd!=0 && EXMEMRd==IFIDRt)
            ForwardD = 2'b10;
        else if(branch==1 && MEMWBRegWrite==1 && MEMWBRd!=0 && MEMWBRd==IFIDRt)
            ForwardD = 2'b01;
        else
            ForwardD = 2'b00;
    end
endmodule
