`timescale 1ns / 1ps
module Controller(Instruction,Instruction2,equalVal,gtZero,ltZero,beqz,either,lt,even,ControlBits,ControlBits2,Jump,PCSrc, branch);

input [31:0] Instruction,Instruction2;
input equalVal, gtZero, ltZero, beqz, either, lt,even;
output reg [7:0] ControlBits; //{ALUSrc,ALUOp[4:0],RegDst,RegWrite}
output reg [4:0] ControlBits2; //AddressType[1:0],MemWrite,MemRead,MemToReg
output reg [1:0] Jump;
output reg PCSrc, branch;

initial begin
/*
	RegDst  = 0;
	MemRead  = 0;
	MemToReg  = 0;
	MemWrite  = 0;
	ALUSrc  = 0;
	RegWrite  = 0;
	ALUOp = 5'b00000;
	AddressType = 2'b0;
*/
    Jump = 2'b00;
    PCSrc = 0;
    branch = 0;
    ControlBits = {1'b0,5'b0,1'b0,1'b0};
    ControlBits2 = {2'b0,1'b0,1'b0,1'b0};
end

always @(*) begin
    case(Instruction2[31:26])
        6'b000000: begin // nop
             ControlBits2 = {2'b0,1'b0,1'b0,1'b0};
        end
        6'b100011: begin // lw
             ControlBits2 = {2'b0,1'b0,1'b1,1'b1};
        end
        6'b101011: begin //sw
             ControlBits2 = {2'b0,1'b1,1'b0,1'b0};
        end
        6'b101000: begin //sb
             ControlBits2 = {2'b10,1'b1,1'b0,1'b0};
        end
        6'b100000: begin //lb
             ControlBits2 = {2'b10,1'b0,1'b1,1'b1};
        end
        6'b100001: begin //lh
             ControlBits2 = {2'b01,1'b0,1'b1,1'b1};
        end
        6'b101001: begin //sh
             ControlBits2 = {2'b01,1'b1,1'b0,1'b0};
        end
        default: begin
            ControlBits2 = {2'b00,1'b0,1'b1,1'b1};
        end
    endcase
	case(Instruction[31:26])
		6'b000000: begin
			case(Instruction[5:0])
				6'b100000: begin //add
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Jump  = 0;
					ALUOp = 5'b00001;*/
					Jump = 2'b00;
                    PCSrc = 0;
                    branch = 0;
                    ControlBits = {1'b0,5'b00001,1'b1,1'b1};
				end
				6'b100001: begin //addu
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b00010;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00010,1'b1,1'b1};
				end
				6'b100010: begin //sub
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b00011;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00011,1'b1,1'b1};
				end
				6'b011000: begin //mult
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b00101;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00101,1'b1,1'b1};
				end
				6'b011001: begin //multu
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b00110;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00110,1'b1,1'b1};
				end
				 6'b100101: begin //or
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10001;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b10001,1'b1,1'b1};
				end
				6'b001000: begin //jr
					/*RegDst  = 0;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 0;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 1;
					ALUOp = 5'b00001;//add*/
					Jump = 2'b10;
                    PCSrc = 0; branch = 1;
                    ControlBits = {1'b0,5'b00001,1'b0,1'b0};
				end
				6'b100100: begin //and
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10000;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b10000,1'b1,1'b1};
				end
				6'b100111: begin //nor
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10010;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b10010,1'b1,1'b1};
				end
				6'b100110: begin //xor
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10011;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b10011,1'b1,1'b1};
				end
				6'b000000: begin //sll
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10100;//sll*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    if(Instruction==32'b0)
				        ControlBits = {1'b0,5'b00000,1'b0,1'b0};
				    else
				        ControlBits = {1'b0,5'b10100,1'b1,1'b1};
				end
				6'b000010: begin 
				    case(Instruction[21])
                        1'b0: begin //srl
                        /*RegDst  = 1;
                        ALUSrc  = 0;
                        MemToReg  = 0;
                        RegWrite  = 1;
                        MemRead  = 0;
                        MemWrite  = 0;
                        Branch  = 0;
                        Jump  = 0;
                        ALUOp = 5'b10101;//srl*/
                        Jump = 2'b00;
                        PCSrc = 0; branch = 0;
                        ControlBits = {1'b0,5'b10101,1'b1,1'b1};
				        end
				      1'b1: begin //rotr
                        /*RegDst  = 1;
                        ALUSrc  = 0;
                        MemToReg  = 0;
                        RegWrite  = 1;
                        MemRead  = 0;
                        MemWrite  = 0;
                        Branch  = 0;
                        Jump  = 0;
                        ALUOp = 5'b11000;//rotrv*/
                        Jump = 2'b00;
                        PCSrc = 0; branch = 0;
                        ControlBits = {1'b0,5'b11111,1'b1,1'b1};
				        end
				        default: begin
                            /*RegDst  = 1;
                            ALUSrc  = 0;
                            MemToReg  = 0;
                            RegWrite  = 0;
                            MemRead  = 0;
                            MemWrite  = 0;
                            Branch  = 0;
                            Jump  = 0;
                            ALUOp = 5'b00000;*/
                            Jump = 2'b00;
                            PCSrc = 0; branch = 0;
                            ControlBits = {1'b0,5'b00000,1'b0,1'b0};
                        end
				     endcase
				 end
				6'b000100: begin //sllv
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10100;//sll*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b11101,1'b1,1'b1};
				end
				6'b000110: begin 
				 case(Instruction[6])
				    1'b0: begin //srlv
                        /*RegDst  = 1;
                        ALUSrc  = 0;
                        MemToReg  = 0;
                        RegWrite  = 1;
                        MemRead  = 0;
                        MemWrite  = 0;
                        Branch  = 0;
                        Jump  = 0;
                        ALUOp = 5'b10101;//srl*/
                        Jump = 2'b00;
                        PCSrc = 0; branch = 0;
                        ControlBits = {1'b0,5'b11110,1'b1,1'b1};
					end
                    1'b1: begin //rotrv
                        /*RegDst  = 1;
                        ALUSrc  = 0;
                        MemToReg  = 0;
                        RegWrite  = 1;
                        MemRead  = 0;
                        MemWrite  = 0;
                        Branch  = 0;
                        Jump  = 0;
                        ALUOp = 5'b11000;//rotrv*/
                        Jump = 2'b00;
                        PCSrc = 0; branch = 0;
                        ControlBits = {1'b0,5'b11000,1'b1,1'b1};
				    end
				    default: begin
                        /*RegDst  = 1;
                        ALUSrc  = 0;
                        MemToReg  = 0;
                        RegWrite  = 0;
                        MemRead  = 0;
                        MemWrite  = 0;
                        Branch  = 0;
                        Jump  = 0;
                        ALUOp = 5'b00000;*/
                        Jump = 2'b00;
                        PCSrc = 0; branch = 0;
                        ControlBits = {1'b0,5'b00000,1'b0,1'b0};
                    end
				  endcase
				end
				6'b101010: begin //slt
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10110;//slt*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b10110,1'b1,1'b1};
				end
				6'b001011: begin //movn
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10111;//movn*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b10111,1'b1,~beqz};
				end
				6'b001010: begin //movz
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b10111;//movn*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b10111,1'b1,beqz};
				end
				
				6'b101011: begin //sltu
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b11011;//sltiu*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b11011,1'b1,1'b1};
				end
				
				6'b000011: begin //sra
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b11001;//srav*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b01111,1'b1,1'b1};
				end
				6'b000111: begin //srav
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b11001;//srav*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b11001,1'b1,1'b1};
				end
				6'b010001: begin //mthi
					/*RegDst  = 0;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 0;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b01010;//mthi*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b01010,1'b0,1'b0};
				end
				6'b010011: begin //mtlo
					/*RegDst  = 0;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 0;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b01011;//mtlo*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b01011,1'b0,1'b0};
				end
				6'b010000: begin //mfhi
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b01100;//mfhi*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b01100,1'b1,1'b1};
				end
				6'b010010: begin //mflo
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b01101;//mflo*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b01101,1'b1,1'b1};
				end
				6'b111111: begin //subAbs
				    Jump = 2'b00;
				    PCSrc = 0; branch = 0;
				    ControlBits = {1'b0,5'b00000,1'b1,1'b1};
				end
				default: begin
                    /*RegDst  = 1;
                    ALUSrc  = 0;
                    MemToReg  = 0;
                    RegWrite  = 0;
                    MemRead  = 0;
                    MemWrite  = 0;
                    Branch  = 0;
                    Jump  = 0;
                    ALUOp = 5'b00000;*/
                    Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00000,1'b0,1'b0};
                end
			endcase
		end
		6'b001001: begin //addiu
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00010;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00010,1'b0,1'b1};
		end
		6'b001000: begin //addi
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00001,1'b0,1'b1};
		end
		6'b011100: begin
			case(Instruction[5:0])
				6'b000010: begin //mul
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b00100;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00100,1'b1,1'b1};
				end
				6'b000100: begin //msub
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b01000;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b01000,1'b1,1'b1};
				end
				6'b000000: begin //madd
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b00111;*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00111,1'b1,1'b1};
				end
				default: begin
                    /*RegDst  = 1;
                    ALUSrc  = 0;
                    MemToReg  = 0;
                    RegWrite  = 0;
                    MemRead  = 0;
                    MemWrite  = 0;
                    Branch  = 0;
                    Jump  = 0;
                    ALUOp = 5'b00000;*/
                    Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00000,1'b0,1'b0};
                end
			endcase
		end
		
		6'b100011: begin //lw
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 1;
			RegWrite  = 1;
			MemRead  = 1;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00001,1'b0,1'b1};
		end
		6'b101011: begin //sw
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 1;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00001,1'b0,1'b0};
		end
		6'b101000: begin //sb
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 1;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00001,1'b0,1'b0};
		end
		6'b100001: begin //lh
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 1;
			RegWrite  = 1;
			MemRead  = 1;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00001,1'b0,1'b1};
		end
		6'b100000: begin //lb
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 1;
			RegWrite  = 1;
			MemRead  = 1;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00001,1'b0,1'b1};
		end
		6'b101001: begin //sh
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 1;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b00001,1'b0,1'b0};
		end
		6'b001111: begin //lui
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b01001;*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b01001,1'b0,1'b1};
			end
		6'b000001: begin//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			case(Instruction[20:16])
				5'b00001: begin //bgez
					/*RegDst  = 0;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 0;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 1;
					Jump  = 0;
					ALUOp = 5'b01110; //bgtz*/
					Jump = 2'b00;
					if(ltZero==0) begin
                        PCSrc = 1;
                        branch = 1;
                    end
                    else begin
                        PCSrc = 0;
                        branch = 1;
                    end
                    ControlBits = {1'b0,5'b00000,1'b0,1'b0};
				end
				5'b00000: begin //bltz
					/*RegDst  = 0;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 0;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 1;
					Jump  = 0;
					ALUOp = 5'b01111; //bltz*/
					Jump = 2'b00;
					if(ltZero==1) begin
                        PCSrc = 1;
                        branch = 1;
                    end
                    else begin
                        PCSrc  = 0;
                        branch = 1;
                    end
                    ControlBits = {1'b0,5'b00000,1'b0,1'b0};
				end
				default: begin
                    /*RegDst  = 1;
                    ALUSrc  = 0;
                    MemToReg  = 0;
                    RegWrite  = 0;
                    MemRead  = 0;
                    MemWrite  = 0;
                    Branch  = 0;
                    Jump  = 0;
                    ALUOp = 5'b00000;*/
                    Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00000,1'b0,1'b0};
                end
			endcase
		end
		6'b000100: begin //beq
			/*RegDst  = 0;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 1;
			Jump  = 0;
			ALUOp = 5'b00011;//substract*/
			Jump = 2'b00;
			if(equalVal==1) begin
                PCSrc = 1;
                branch = 1;
            end
            else begin
                PCSrc = 0;
                branch = 1;
            end
            ControlBits = {1'b0,5'b00000,1'b0,1'b0};
		end
		6'b000101: begin //bne
			/*RegDst  = 0;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 1;
			Jump  = 0;
			ALUOp = 5'b00011; //substract*/
			Jump = 2'b00;
			if(equalVal==0) begin
                PCSrc = 1;
                branch = 1;
            end
            else begin
                PCSrc = 0;
                branch = 1;
            end
            ControlBits = {1'b0,5'b00000,1'b0,1'b0};
		end
		6'b000111: begin //bgtz
			/*RegDst  = 0;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 1;
			Jump  = 0;
			ALUOp = 5'b01110;*/
			Jump = 2'b00;
			if(gtZero==1) begin
                PCSrc = 1;
                branch = 1;
            end
            else begin
                PCSrc = 0;
                branch = 1;
            end
            ControlBits = {1'b0,5'b00000,1'b0,1'b0};
		end
		6'b000110: begin //blez
			/*RegDst  = 0;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 1;
			Jump  = 0;
			ALUOp = 5'b01111;//bltz*/
			Jump = 2'b00;
			if(gtZero==0) begin
                PCSrc = 1;
                branch = 1;
            end
			else begin
                PCSrc = 0;
                branch = 1;
            end
            ControlBits = {1'b0,5'b00000,1'b0,1'b0};
		end
		6'b000010: begin //j 
			/*RegDst  = 0;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 1;
			ALUOp = 5'b00001;//add*/
			Jump = 2'b01;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b0,5'b00000,1'b0,1'b0};
		end
		6'b000011: begin //jal
			/*RegDst  = 0;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 1;
			ALUOp = 5'b00001;//add*/
			Jump = 2'b11;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b0,5'b00000,1'b0,1'b1};
		end////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		6'b001100: begin //andi
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b10000;//and*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b10000,1'b0,1'b1};
		end
		6'b001101: begin //ori
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b10001;//or*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b10001,1'b0,1'b1};
		end
		6'b001110: begin //xori
			/*RegDst  = 0;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b10011;//xori*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b10011,1'b0,1'b1};
		end
		6'b001010: begin //slti
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b10110;//slt*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b10110,1'b0,1'b1};
		end
		6'b001011: begin //sltiu
			/*RegDst  = 0;
			ALUSrc  = 1;
			MemToReg  = 0;
			RegWrite  = 1;
			MemRead  = 1;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b11011;//sltiu*/
			Jump = 2'b00;
            PCSrc = 0; branch = 0;
            ControlBits = {1'b1,5'b11011,1'b0,1'b1};
		end
		6'b011111: begin
			case(Instruction[10:6])
				5'b11000: begin //seh
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b11100;//seh*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b11100,1'b1,1'b1};
				end
				5'b10000: begin //seb
					/*RegDst  = 1;
					ALUSrc  = 0;
					MemToReg  = 0;
					RegWrite  = 1;
					MemRead  = 0;
					MemWrite  = 0;
					Branch  = 0;
					Jump  = 0;
					ALUOp = 5'b11010;//seb*/
					Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b11010,1'b1,1'b1};
				end
				default: begin
                    /*RegDst  = 1;
                    ALUSrc  = 0;
                    MemToReg  = 0;
                    RegWrite  = 0;
                    MemRead  = 0;
                    MemWrite  = 0;
                    Branch  = 0;
                    Jump  = 0;
                    ALUOp = 5'b00000;*/
                    Jump = 2'b00;
                    PCSrc = 0; branch = 0;
                    ControlBits = {1'b0,5'b00000,1'b0,1'b0};
                end
			endcase
		end
		6'b010000: begin //blt
		    Jump = 2'b00;
		    branch = 1;
		    if(lt==1)
		      PCSrc = 1;
		    else
		      PCSrc = 0;
		    ControlBits = {1'b0,5'b00000,1'b1,1'b0};
		end
		6'b010001: begin //bge
		    Jump = 2'b00;
		    branch = 1;
		    if(lt==0)
		      PCSrc = 1;
		    else
		      PCSrc = 0;
		    ControlBits = {1'b0,5'b00000,1'b1,1'b0};
		end
		6'b010010: begin //bnr
		    Jump = 2'b00;
		    branch = 1;
		    if(either==0)
		      PCSrc = 1;
		    else
		      PCSrc = 0;
		    ControlBits = {1'b0,5'b00000,1'b1,1'b0};
		end
		6'b010011: begin //beven
		    Jump = 2'b00;
		    branch = 1;
		    if(even==1)
		      PCSrc = 1;
		    else
		      PCSrc = 0;
		    ControlBits = {1'b0,5'b00000,1'b0,1'b0};
		end
		default: begin
			/*RegDst  = 1;
			ALUSrc  = 0;
			MemToReg  = 0;
			RegWrite  = 0;
			MemRead  = 0;
			MemWrite  = 0;
			Branch  = 0;
			Jump  = 0;
			ALUOp = 5'b00000;*/
			Jump = 2'b00;
            PCSrc = 0;
            branch = 0;
            ControlBits = {1'b0,5'b00000,1'b0,1'b0};
		end
	endcase
	end
endmodule