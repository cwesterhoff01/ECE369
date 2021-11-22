`timescale 1ns / 1ps
module RegisterIFID(WriteReg,flush,NewData,Data,Clk,Rst);
    input WriteReg,Clk,Rst,flush;
    input [63:0] NewData;
    output reg [63:0] Data;
    always @(posedge Clk or posedge Rst) begin
        if(Rst==1)
            Data <= 64'b0;
        else if(WriteReg==1 && flush==1)
            Data <= 64'b0;
        else if(WriteReg==1)
            Data <= NewData;
        else
            Data <= Data;
    end
endmodule