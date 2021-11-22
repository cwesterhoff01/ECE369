`timescale 1ns / 1ps
module HazardDetectionUnit(IFIDRs,IFIDRt,EXRd,EXMEMRd,IFIDRegWrite,IFIDRegDst,IDEXRegWrite,EXMEMRegWrite,MEMWBRd,MEMWBRegWrite,PCWrite,IFIDWrite,ControlWrite);
    input [4:0] IFIDRs,IFIDRt,EXRd,EXMEMRd,MEMWBRd;
    input IFIDRegWrite,IDEXRegWrite,EXMEMRegWrite,MEMWBRegWrite,IFIDRegDst;
    output reg PCWrite,IFIDWrite,ControlWrite;
    always @(*) begin
        if(IDEXRegWrite==1 && EXRd!=0 && ((EXRd==IFIDRs) || ((IFIDRegDst==1 || IFIDRegWrite==0) && EXRd==IFIDRt))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(EXMEMRegWrite==1 && EXMEMRd!=0 && ((EXMEMRd==IFIDRs) || ((IFIDRegDst==1 || IFIDRegWrite==0) && EXMEMRd==IFIDRt))) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlWrite = 0;
        end
        else if(MEMWBRegWrite==1 && MEMWBRd!=0 && ((MEMWBRd==IFIDRs) || ((IFIDRegDst==1 || IFIDRegWrite==0) && MEMWBRd==IFIDRt))) begin
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