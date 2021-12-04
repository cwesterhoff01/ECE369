`timescale 1ns / 1ps
module InstructionMemory(Address, Instruction, Instruction2, rst); 

    input [31:0] Address; 
    input rst;
           // Input Address 
    reg [31:0] memory [0:2047];
    output reg [31:0] Instruction,Instruction2;    // Instruction at memory location Address
    /* Please fill in the implementation here */
    initial begin
        $readmemh("instruction_memory.mem",memory);
    end
        always @(*) begin
        Instruction = memory[Address[12:2]];
        Instruction2 = memory[Address[12:2]+4];
    end
    always @(posedge rst) begin
        if (rst == 1) begin
            $readmemh("instruction_memory.mem",memory);
        end
    end
endmodule