`timescale 1ns / 1ps
module SignExtender(A,result);
    input [15:0] A;
    output reg [31:0] result;
    always @(*) begin
        if(A[15]==0)
            result = {16'b0,A};
        else
            result = {16'b1111111111111111,A};
    end
endmodule