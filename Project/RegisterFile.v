`timescale 1ns / 1ps
module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, ReadRegister3, ReadRegister4, WriteRegister2, WriteData2, RegWrite2, ReadData1, ReadData2, ReadData3, ReadData4, Clk,Rst,s6,s7);

	/* Please fill in the implementation here... */
	input [4:0] ReadRegister1, ReadRegister2, ReadRegister3, ReadRegister4, WriteRegister, WriteRegister2;
	input [31:0] WriteData, WriteData2;
	input RegWrite, RegWrite2, Clk,Rst;
	output reg [31:0] ReadData1, ReadData2, ReadData3, ReadData4,s6,s7;

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
        registers[5'b11101] <= 32'd16000;
        registers[5'b11110] <= 0;
        registers[5'b11111] <= 0;
	end
	always @ (*) begin
		ReadData1 <= registers[ReadRegister1];
		ReadData2 <= registers[ReadRegister2];
		ReadData3 <= registers[ReadRegister3];
		ReadData4 <= registers[ReadRegister4];
		s6 <= registers[5'b10110];
		s7 <= registers[5'b10111];
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
            registers[5'b11101] <= 32'd16000;
            registers[5'b11110] <= 0;
            registers[5'b11111] <= 0;
        end
        else begin
            if(RegWrite)
                registers[WriteRegister] <= WriteData;
            if(RegWrite2)
                registers[WriteRegister2] <= WriteData2;
        end
    end
endmodule
