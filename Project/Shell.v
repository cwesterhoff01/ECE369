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


module Shell(Clk, Reset, out7, en_out);
input Clk, Reset;
output [6:0] out7;
output [7:0] en_out;
wire [31:0] PC,WriteData,s6,s7;//,HI,LO;
wire OutClock;
ClkDiv CD(Clk, Reset, OutClock);
TopLevel TL(OutClock, Reset, PC, WriteData,s6,s7);//, HI, LO);
Two4DigitDisplay disp(Clk, s6[15:0], s7[15:0], out7, en_out);
endmodule
