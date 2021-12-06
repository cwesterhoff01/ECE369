`timescale 1ns / 1ps
module ALU(A,B,ALUControl,Shamt,ALUResult,Clk,Rst);//ALU(A, B, ALUControl, Shamt, HI, LO, ALUResult, Zero,Clk,Rst);

	input [4:0] ALUControl, Shamt; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed
	input [31:0] A, B;	    // inputs
    input Clk,Rst;
	output reg [31:0] ALUResult;	// answer
//	output reg Zero;	    // Zero=1 if ALUResult == 0
	
//	output reg [31:0] HI;
//	output reg [31:0] LO;
	
//	reg [31:0] highOutput;
//	reg [31:0] lowOutput;
	
	reg [63:0] temp;
	
//	reg trigger;
	initial begin
//	   trigger = 0;
//	   HI =  0;
//	   LO = 0;
//	   highOutput = 0;
//	   lowOutput = 0;
	   temp = 0;
	   ALUResult = 0;
	end
    /* Please fill in the implementation here... */
    always @(*) begin
    case(ALUControl)
    5'b00000: begin //sub then absolute value
            if($signed(A)-$signed(B)<0)
                ALUResult = $signed(B)-$signed(A);
            else
                ALUResult = $signed(A)-$signed(B);
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end
    5'b00001: begin //add signed
            ALUResult = $signed(A) + $signed(B);  
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end        
            		 
	5'b00010: begin   //add unsigned
            ALUResult = A + B; 
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end         
		 
	5'b00011: begin	//sub  ?????????
            //A - B
            ALUResult = $signed(A) - $signed(B);
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end
            
//    5'b00100:  	begin //mul
//            ALUResult = $signed(A) * $signed(B);
//            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
//    end
    
//	5'b00101:   begin //mult ?????????????
//            temp = $signed(A) * $signed(B);
//            highOutput = temp[63:32];
//            lowOutput = temp[31:0];
//            trigger = 1;
//            ALUResult = 0;
//         end

//	5'b00110:  begin  //multu ?????????
//            temp = A * B;   
//             highOutput = temp[63:32];
//             lowOutput = temp[31:0];
//             trigger = 1;
//             ALUResult = 0;
//         end
		 
	
//	5'b00111:  begin  //madd !!!!!!!!!!!!!!!
//            temp = ({HI, LO}) + (A * B);   
//             highOutput = temp[63:32];
//             lowOutput = temp[31:0];
//             ALUResult = 0;
//             trigger = 1;
//         end
	
//	5'b01000:  begin  //msub
//            temp = ({HI, LO}) - (A * B);   
//             highOutput = temp[63:32];
//             lowOutput = temp[31:0];
//             ALUResult = 0;
//             trigger = 1;
//         end
    5'b01001: begin//lui
        ALUResult = B<<16;
        temp = 0;
//        highOutput = 0;
//        lowOutput = 0;
//	trigger = 0;
	end
	
//	5'b01010:  begin	//mthi ????????????
//             highOutput =  A;
//             temp = 0;
//            lowOutput = LO;
//            trigger = 1;
//            ALUResult = 0;
//	end
//	5'b01011: begin	//mtlo ????????????
//             lowOutput =  A;
//             temp = 0;
//            highOutput = HI;
//            trigger = 1;
//            ALUResult = 0;
//    end
         
//    5'b01100: 	begin//mfhi ????????????
//             ALUResult =  HI;
//             temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
//    end       
//    5'b01101:  begin	//mflo ????????????
//             ALUResult =  LO;
//             temp = 0;
//             trigger = 0;
//            highOutput = 0;
//            lowOutput = 0;
//	end
		 
	5'b01110:	begin//bgtz
            ALUResult = A>0;
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
	end
	
	5'b01111: begin	//sra
        if(B[31]==0) begin
            ALUResult = B >> Shamt;
            temp = 0;
        end
        else begin
            temp = 64'b1111111111111111111111111111111111111111111111111111111111111111;
            temp = temp << 32-Shamt;
            ALUResult = (B >> Shamt) | temp[31:0];
        end
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
	end
	//logical
	5'b10000: begin //and  ?????????????
            ALUResult = A & B;
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
	end  
	5'b10001: begin//or  ??????????????
            ALUResult = A | B;
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
	end
	
	5'b10010: begin//nor   ??????????????
            ALUResult = ~(A | B);
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end
    
	5'b10011: begin // xor   ???????????/
            ALUResult = (A & ~B) | (~A & B);
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end
            
	5'b10100: begin//sll ?????????????
            ALUResult = B << Shamt;
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
	end
	
	5'b10101:  begin//srl ??????????????
            ALUResult =  B >> Shamt;
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
	end
		  
	5'b10110: begin//slt  ??????????????
            ALUResult =  $signed (A) < $signed(B);
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end
    
	5'b10111: begin//movn  ??????????????
            ALUResult = A;
            temp = 0;
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end        
	5'b11000:   begin //rotrv  ?????????!!!!!!!!!!!!!
          temp = {B,32'b0};
          temp = temp >> A[4:0];
          ALUResult = temp[31:0] | temp[63:32];
//          highOutput = 0;
//          lowOutput = 0;
//          trigger = 0;
    end

	5'b11001: begin //srav ?????????????
        if(B[31]==0) begin
            ALUResult = B >> A[4:0];
            temp = 0;
        end
        else begin
            temp = 64'b1111111111111111111111111111111111111111111111111111111111111111;
            temp = temp << 32-A[4:0];
            ALUResult = (B >> A[4:0]) | temp[31:0];
        end
//            highOutput = 0;
//            lowOutput = 0;
//            trigger = 0;
    end
	
	5'b11010:   begin //seb  !!!!!!!!!!
        if(B[7]==0)
            ALUResult = {24'b0,B[7:0]};
        else
            ALUResult = {24'b111111111111111111111111,B[7:0]};
        temp = 0;
//        highOutput = 0;
//        lowOutput = 0;
//        trigger = 0;
    end
	
	5'b11011: begin//sltiu
	   ALUResult = A < B;
	   temp = 0;
//       highOutput = 0;
//       lowOutput = 0;
//       trigger = 0;
	end
	5'b11100: begin//seh
	   if(B[15]==0)
	       ALUResult = {16'b0,B[15:0]};
	   else
	       ALUResult = {16'b1111111111111111,B[15:0]};
	   temp = 0;
//	   highOutput = 0;
//	   lowOutput = 0;
//	   trigger = 0;
	end
	5'b11101: begin //sllv
	   ALUResult = B << A[4:0];
       temp = 0;
//       highOutput = 0;
//       lowOutput = 0;
//       trigger = 0;
	end
	5'b11110: begin //srlv
	   ALUResult = B >> A[4:0];
       temp = 0;
//       highOutput = 0;
//       lowOutput = 0;
//       trigger = 0;
	end
	5'b11111: begin //rotr
	   temp = {B,32'b0};
       temp = temp >> Shamt;
       ALUResult = temp[31:0] | temp[63:32];
//       highOutput = 0;
//       lowOutput = 0;
//       trigger = 0;
	end
	default: begin
	   temp = 0;
//       highOutput = 0;
//       lowOutput = 0;
//       trigger = 0;
       ALUResult = 0;
	end
endcase
end
//        always @(*) begin
//            if(ALUResult == 0) begin
//                Zero = 1;
//            end
//            else begin
//                Zero = 0;
//            end
//        end
        
//    always @(posedge Clk or posedge Rst) begin
//        if(Rst == 1) begin
//                HI <= 32'b0;
//                LO <= 32'b0;
//        end
//        else if(trigger == 1) begin
//            HI <= highOutput;
//            LO <= lowOutput;
//        end
//        else begin
//            HI <= HI;
//            LO <= LO;
//        end
//    end


endmodule