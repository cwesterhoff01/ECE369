`timescale 1ns / 1ps
module DataMemory(MemWrite, Address, WriteData, MemRead, AddressType, ReadData, Clk, Rst); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input [1:0] AddressType; // 00 is word address, 01 is half word, 10 is byte address
    input Clk, Rst;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 

    output reg[31:0] ReadData; // Contents of memory location at Address

    /* Please fill in the implementation here */

	reg[31:0] memory[0:16383];
    initial begin
        $readmemh("data_memory.mem",memory);
    end
	always @ (posedge Clk) begin
        if(MemWrite) begin
            if(AddressType==2'b00)
                memory[Address[15:2]] <= WriteData;
            else if(AddressType==2'b01)
                case(Address[1:0])
                2'b00:
                    memory[Address[15:2]] <= {WriteData[15:0],memory[Address[15:2]][15:0]};
                //2'b01:
                //    memory[Address[15:2]] <= {memory[Address[15:2]][31:24],WriteData[15:0],memory[Address[15:2]][7:0]};
                2'b10:
                    memory[Address[15:2]] <= {memory[Address[15:2]][31:16],WriteData[15:0]};
                //2'b11: //begin
                    //memory[Address[15:2]] <= {memory[Address[15:2]][31:8],WriteData[15:8]};
                    //memory[Address[15:2]+1] <= {WriteData[7:0],memory[Address[15:2]+1][23:0]};
                    //end
                //default:
                //    memory[Address[15:2]] <= {WriteData[15:0],memory[Address[15:2]][15:0]};
                endcase
            else if(AddressType==2'b10)
                case(Address[1:0])
                    2'b00:
                        memory[Address[15:2]] <= {WriteData[7:0],memory[Address[15:2]][23:0]};
                    2'b01:
                        memory[Address[15:2]] <= {memory[Address[15:2]][31:24],WriteData[7:0],memory[Address[15:2]][15:0]};
                    2'b10:
                        memory[Address[15:2]] <= {memory[Address[15:2]][31:16],WriteData[7:0],memory[Address[15:2]][7:0]};
                    2'b11:
                        memory[Address[15:2]] <= {memory[Address[15:2]][31:8],WriteData[7:0]};
                    //default:
                    //    memory[Address[15:2]] <= {WriteData[7:0],memory[Address[15:2]][23:0]};
                endcase
            else
                memory[Address[15:2]] <= WriteData;
		end
	end
	always @ (*) begin
        if(Rst==1) begin
            $readmemh("data_memory.mem",memory);
            ReadData = 32'b0;
        end
		else if(MemRead) begin
            if(AddressType==2'b00)
                ReadData = memory[Address[15:2]];
            else if(AddressType==2'b01)
                case(Address[1])
                1'b0:
                    if(memory[Address[15:2]][31]==1)
                        ReadData = {16'b1111111111111111,memory[Address[15:2]][31:16]};
                    else
                        ReadData = {16'b0,memory[Address[15:2]][31:16]};
                1'b1:
                    if(memory[Address[15:2]][15]==1)
                        ReadData = {16'b1111111111111111,memory[Address[15:2]][15:0]};
                    else
                        ReadData = {16'b0,memory[Address[15:2]][15:0]};
                endcase
            else if(AddressType==2'b10)
                case(Address[1:0])
                    2'b00:
                        if(memory[Address[15:2]][31]==1)
                            ReadData = {24'b111111111111111111111111,memory[Address[15:2]][31:24]};
                        else
                            ReadData = {24'b0,memory[Address[15:2]][31:24]};
                    2'b01:
                        if(memory[Address[15:2]][23]==1)
                            ReadData = {24'b111111111111111111111111,memory[Address[15:2]][23:16]};
                        else
                            ReadData = {24'b0,memory[Address[15:2]][23:16]};
                    2'b10:
                        if(memory[Address[15:2]][15]==1)
                            ReadData = {24'b111111111111111111111111,memory[Address[15:2]][15:8]};
                        else
                            ReadData = {24'b0,memory[Address[15:2]][15:8]};
                    2'b11:
                        if(memory[Address[15:2]][7]==1)
                            ReadData = {24'b111111111111111111111111,memory[Address[15:2]][7:0]};
                        else
                            ReadData = {24'b0,memory[Address[15:2]][7:0]};
                endcase
            else begin
                ReadData = memory[Address[15:2]];
            end
		end
		else
			ReadData = 32'b0;
		end

endmodule