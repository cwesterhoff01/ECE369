`timescale 1ns / 1ps
module Mux13Bit2To1(A,B,control,result);
input [12:0] A,B;
input control;
output reg [12:0] result;
always @(*) begin
    if(control==0)
        result = A;
    else
        result = B;
end
endmodule