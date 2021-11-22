`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2021 06:55:25 PM
// Design Name: 
// Module Name: Comparator
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


module Comparator(A,B,eq,gtz,ltz,beqz);
    input signed [31:0] A,B;
    output reg eq,gtz,ltz,beqz;
    always @(*) begin
        eq = A==B;
        gtz = A>0;
        ltz = A<0;
        beqz = B==0;
    end
endmodule
