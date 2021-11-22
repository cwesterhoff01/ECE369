`timescale 1ns / 1ps
module Mux5Bit2To1(A,B,control,result);
input [4:0] A,B;
input control;
output reg [4:0] result;
always @(*) begin
    if(control==0)
        result = A;
    else
        result = B;
end
endmodule