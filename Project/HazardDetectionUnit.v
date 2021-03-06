`timescale 1ns / 1ps
module HazardDetectionUnit(IFIDRegDst,IFIDMemWrite,IDEXRegWrite,IDEXMemRead,EXMEMMemRead,MEMWBRegWrite,MEMWBMemToReg,branch,IFIDRs,IFIDRt,IFIDRs2,IFIDRt2,IDEXRt2,IDEXRd,EXMEMRd2,MEMWBRd,MEMWBRd2,PCWrite,IFIDWrite,ControlWrite);
    input [4:0] IFIDRs,IFIDRt,IFIDRs2,IFIDRt2,IDEXRt2,IDEXRd,EXMEMRd2,MEMWBRd,MEMWBRd2;
    input IFIDRegDst,IFIDMemWrite,IDEXRegWrite,IDEXMemRead,EXMEMMemRead,MEMWBRegWrite,MEMWBMemToReg,branch;
    output reg PCWrite,IFIDWrite,ControlWrite;
    always @(*) begin
        if(IDEXMemRead==1 && IDEXRt2!=0 && (IDEXRt2==IFIDRs || (IDEXRt2==IFIDRt && IFIDRegDst==1) || IDEXRt2==IFIDRs2 || (IDEXRt2==IFIDRt2 && IFIDMemWrite==1))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(branch && EXMEMMemRead==1 && EXMEMRd2!=0 && (EXMEMRd2==IFIDRs || (EXMEMRd2==IFIDRt && IFIDRegDst==1))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(branch && IDEXRegWrite==1 && IDEXRd!=0 && (IDEXRd==IFIDRs || (IDEXRd==IFIDRt && IFIDRegDst==1))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && (MEMWBRd==IFIDRs2 || (MEMWBRd==IFIDRt2 && IFIDMemWrite==1))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && (MEMWBRd==IFIDRs || (MEMWBRd==IFIDRt && IFIDRegDst==1))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(MEMWBMemToReg==1 && MEMWBRd2!=0 && (MEMWBRd2==IFIDRs || (MEMWBRd2==IFIDRt && IFIDRegDst==1))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(MEMWBMemToReg==1 && MEMWBRd2!=0 && (MEMWBRd2==IFIDRs2 || (MEMWBRd2==IFIDRt2 && IFIDMemWrite==1))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else begin
            PCWrite = 1;
            IFIDWrite = 1;
            ControlWrite = 1;
        end
    end
endmodule