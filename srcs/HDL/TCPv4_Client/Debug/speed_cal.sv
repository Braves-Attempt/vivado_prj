`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 15:11:18
// Design Name: 
// Module Name: speed_cal
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module speed_cal#(
    parameter   integer NBytes  =4  ,
    parameter   integer STS_W   =48 ,
    parameter   integer FREQ_HZ =100000000
    )(
    input   logic           sys_clk         ,
    input   logic           sys_rst         ,
    input   logic           data_en         ,
    output  logic   [STS_W-1:0] sts_BPS     ={STS_W{1'b0}},
    output  logic   [STS_W-1:0] sts_MBPS    ={STS_W{1'b0}}
    );
reg     [STS_W-1:0] data_cnt=   {STS_W{1'b0}};
reg     [31:00] tick    =   32'h0;

function integer ilog2;
    input    integer value;
    begin
    for(ilog2=0;value>0;ilog2=ilog2+1)
        value=value>>1;
    end
endfunction

always@(posedge sys_clk)begin
    if(sys_rst==1'b1)begin
        tick    <=  32'h0   ;
    end
    else begin
        if(tick==FREQ_HZ-32'd1)begin
            tick    <=  32'h0   ;
        end
        else begin
            tick    <=  tick    +   32'd1   ;
        end
    end
end

always@(posedge sys_clk)begin
    if(sys_rst==1'b1)begin
        data_cnt    <=  {STS_W{1'b0}};
        sts_BPS     <=  {STS_W{1'b0}};
        sts_MBPS    <=  {STS_W{1'b0}};
    end
    else begin
        if(tick==FREQ_HZ-32'd1)begin
            if(data_en)begin
                data_cnt    <=  {{(STS_W-ilog2(NBytes)){1'b0}},NBytes} ; //@todo 48bit 这种呢？
            end
            else begin
                data_cnt    <=  {STS_W{1'b0}}   ;
            end
            sts_BPS     <=  data_cnt    ;//(STS_W-NBytes>32)?{{(STS_W-NBytes-32){1'b0}},data_cnt,{NBytes{1'b0}}}:{data_cnt[STS_W-NBytes-1:00],{NBytes{1'b0}}};
            sts_MBPS    <= {{(STS_W-20){1'b0}},data_cnt[STS_W-1:20]}    ;
        end
        else if(data_en) begin
            data_cnt    <=  data_cnt    +   NBytes   ;
        end
    end
end

endmodule
