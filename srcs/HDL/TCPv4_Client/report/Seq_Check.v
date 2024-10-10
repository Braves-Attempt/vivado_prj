`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/22 16:33:20
// Design Name: 
// Module Name: Seq_Check
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



module Seq_Check#(
    parameter   TYPE="INC"          ,
    parameter   DW  =64             ,
    parameter   SUMW=48             
    )
    (
    input   wire    sys_clk                 ,
    input   wire    sys_rst                 ,
    
    input   wire                data_en     ,
    input   wire    [DW-1:00]   data_value  ,
    output  reg     [SUMW-1:00] err_cnt     ='d0,
    output  reg     [SUMW-1:00] recv_cnt    ='d0,
    output  reg                 err_bit     ='d0
    );
reg                r1_data_en       ='d0;
reg    [DW-1:00]   r1_data_value    ='d0;
reg    [DW-1:00]   r2_data_value    ='d0;

reg                 check_flag      ='d0;

always@(posedge sys_clk)
begin
    if(sys_rst)
    begin
        r1_data_en     <='d0;
        r1_data_value  <='d0;
    end
    else
    begin
        r1_data_en     <=   data_en     ;
        r1_data_value  <=   data_value  ;
        if(r1_data_en)
        begin
            r2_data_value   <=  r1_data_value   ;
        end
    end
end
    
always@(posedge sys_clk)
begin
    if(sys_rst)
    begin
        check_flag  <=  1'b0    ;
        err_bit     <=  1'b0    ;
        err_cnt     <=  'h0   ;
        recv_cnt    <=  'h0   ;
    end
    else
    begin
        if(r1_data_en)
        begin
            check_flag  <=  1'b1    ;
        end
        if(TYPE=="INC")begin
            if((r1_data_en&check_flag&(r2_data_value+1'b1!=r1_data_value)))
            begin
                err_bit <=  1'b1    ;
            end
            else
            begin
                err_bit <=  1'b0    ;
            end
        end
        else begin
            if((r1_data_en&check_flag&(r2_data_value-1'b1!=r1_data_value)))
            begin
                err_bit <=  1'b1    ;
            end
            else
            begin
                err_bit <=  1'b0    ;
            end
        end
        
        err_cnt <=  err_cnt     +   err_bit     ;
        recv_cnt<=  recv_cnt    +   r1_data_en  ;
    end
end

endmodule

