`timescale 1ns / 1ps
module ProgramCounter(WritePC,NewPC,PC,Clk,Rst);
    input [31:0] NewPC;
    input WritePC,Clk,Rst;
    output reg [31:0] PC;
    initial begin
        PC <= 0;
    end
    always @(posedge Clk or posedge Rst) begin
        if(Rst==1)
            PC <= 32'b0;
        else if(WritePC==1)
            PC <= NewPC;
        else
            PC <= PC;
    end
endmodule