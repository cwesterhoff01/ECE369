`timescale 1ns / 1ps
module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, ReadData1, ReadData2, Clk,Rst);

	/* Please fill in the implementation here... */
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input [31:0] WriteData;
	input RegWrite, Clk,Rst;
	output reg [31:0] ReadData1, ReadData2;

	reg [31:0] registers [0:31];
	initial begin
        registers[5'b00000] <= 0;
        registers[5'b00001] <= 0;
        registers[5'b00010] <= 0;
        registers[5'b00011] <= 0;
        registers[5'b00100] <= 0;
        registers[5'b00101] <= 0;
        registers[5'b00110] <= 0;
        registers[5'b00111] <= 0;
        registers[5'b01000] <= 0;
        registers[5'b01001] <= 0;
        registers[5'b01010] <= 0;
        registers[5'b01011] <= 0;
        registers[5'b01100] <= 0;
        registers[5'b01101] <= 0;
        registers[5'b01110] <= 0;
        registers[5'b01111] <= 0;
        registers[5'b10000] <= 0;
        registers[5'b10001] <= 0;
        registers[5'b10010] <= 0;
        registers[5'b10011] <= 0;
        registers[5'b10100] <= 0;
        registers[5'b10101] <= 0;
        registers[5'b10110] <= 0;
        registers[5'b10111] <= 0;
        registers[5'b11000] <= 0;
        registers[5'b11001] <= 0;
        registers[5'b11010] <= 0;
        registers[5'b11011] <= 0;
        registers[5'b11100] <= 0;
        registers[5'b11101] <= 0;
        registers[5'b11110] <= 0;
        registers[5'b11111] <= 0;
	end
	always @ (negedge Clk) begin
		ReadData1 <= registers[ReadRegister1];
		ReadData2 <= registers[ReadRegister2];
	end
	always @ (posedge Clk or posedge Rst) begin
        if(Rst==1) begin
            registers[5'b00000] <= 0;
            registers[5'b00001] <= 0;
            registers[5'b00010] <= 0;
            registers[5'b00011] <= 0;
            registers[5'b00100] <= 0;
            registers[5'b00101] <= 0;
            registers[5'b00110] <= 0;
            registers[5'b00111] <= 0;
            registers[5'b01000] <= 0;
            registers[5'b01001] <= 0;
            registers[5'b01010] <= 0;
            registers[5'b01011] <= 0;
            registers[5'b01100] <= 0;
            registers[5'b01101] <= 0;
            registers[5'b01110] <= 0;
            registers[5'b01111] <= 0;
            registers[5'b10000] <= 0;
            registers[5'b10001] <= 0;
            registers[5'b10010] <= 0;
            registers[5'b10011] <= 0;
            registers[5'b10100] <= 0;
            registers[5'b10101] <= 0;
            registers[5'b10110] <= 0;
            registers[5'b10111] <= 0;
            registers[5'b11000] <= 0;
            registers[5'b11001] <= 0;
            registers[5'b11010] <= 0;
            registers[5'b11011] <= 0;
            registers[5'b11100] <= 0;
            registers[5'b11101] <= 0;
            registers[5'b11110] <= 0;
            registers[5'b11111] <= 0;
        end
        else if(RegWrite) begin
            registers[WriteRegister] <= WriteData;
        end
    end
endmodule
