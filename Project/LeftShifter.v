`timescale 1ns / 1ps
module LeftShifter(A,result);
    input [31:0] A;
    output reg [31:0] result;
    always @(*) begin
        result = A << 2;
    end
endmodule