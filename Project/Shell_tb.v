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


module Shell_tb();
    reg Clk, Rst;
    wire [6:0] out7;
    wire [7:0] en_out;
    
    Shell u0(
    Clk,Rst,out7,en_out
    );
    
    initial begin
        Clk <= 1'b0;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
    Rst <= 1'b1;
    #10
    Rst <= 1'b0;
    end
endmodule

