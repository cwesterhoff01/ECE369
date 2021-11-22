`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2021 11:27:16 AM
// Design Name: 
// Module Name: Register75
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


module RegisterEXMEM(WriteReg,NewData,Data,Clk,Rst);
    input WriteReg,Clk,Rst;
    input [108:0] NewData;
    output reg [108:0] Data;
    always @(posedge Clk or posedge Rst) begin
        if(Rst==1)
            Data <= 109'b0; 
        else if(WriteReg==1)
            Data <= NewData;
        else
            Data <= Data;
    end
endmodule