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


module TopLevel_tb();
    reg Clk, Rst;
    wire [31:0] PCCheck,DataCheck,HICheck,LOCheck;
    
    TopLevel u0(
    Clk,Rst,PCCheck,DataCheck,HICheck,LOCheck
    );
    
    initial begin
        Clk <= 1'b1;
        forever #10 Clk <= ~Clk;
    end
    
    initial begin
    Rst <= 1'b1;
    #20
    Rst <= 1'b0;
    end
endmodule
