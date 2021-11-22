`timescale 1ns / 1ps
module Mux32Bit4To1(A,B,C,D,control,result);
input [31:0] A,B,C,D;
input [1:0] control;
output reg [31:0] result;
always @(*) begin
    case(control)
        2'b0:
            result = A;
        2'b01:
            result = B;
        2'b10:
            result = C;
        2'b11:
            result = D;
    endcase
end
endmodule