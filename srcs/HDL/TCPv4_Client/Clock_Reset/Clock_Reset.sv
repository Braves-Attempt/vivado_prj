`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/07 00:12:17
// Design Name: 
// Module Name: Clock_Reset
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


module Clock_Reset(
    input   logic           clk    ,
    output  logic           clk_200m    ,
    output  logic           rst_200m    ,
    output  logic           clk_125m    ,
    output  logic           rst_125m    
    );
logic           mmcm_locked ;


wire    [03:00] debug_fsm_curr              ;
wire            debug_delay_rst             ;
wire    [31:00] debug_pu_rst_release_cnt    ;


clk_wiz_200 clk_wiz_200
    (
    // Clock out ports
    .clk_out1(clk_200m),     // output clk_out1
    .clk_out2(clk_125m),     // output clk_out2
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(mmcm_locked),       // output locked
   // Clock in ports
    .clk_in1(clk)      // input clk_in1
);


(* keep_hierarchy="yes" *)Sys_Rst#(
    .CLOCK_FREQ_HZ          (200000000          ),
    .PU_RST_RELEASE_US      (1                  ),//首次收到非复位信号的延时
    .PU_DELAY_US            (1                  ),
    .RSTDY_US               (200000             ),
    .RECV_RST_US            (200000             )
    )Sys_Rst(   
    .sys_clk                (clk_200m           ),
    .board_rst_n            (1'b1               ),
    .clock_locked           (mmcm_locked        ),
    .sys_rst_out            (sys_rst_out        ),
    .debug_fsm_curr         (debug_fsm_curr     ),
    .debug_delay_rst        (debug_delay_rst    ),
    .debug_pu_rst_release_cnt(debug_pu_rst_release_cnt)
    );

xpm_cdc_async_rst #(
    .DEST_SYNC_FF(4),    // DECIMAL; range: 2-10
    .INIT_SYNC_FF(0),    // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
    .RST_ACTIVE_HIGH(1)  // DECIMAL; 0=active low reset, 1=active high reset
    )xpm_cdc_async_rst_200M (
    .dest_arst(rst_200m), // 1-bit output: src_arst asynchronous reset signal synchronized to destination
    .dest_clk(clk_200m),   // 1-bit input: Destination clock.
    .src_arst(sys_rst_out)    // 1-bit input: Source asynchronous reset signal.
    );

xpm_cdc_async_rst #(
    .DEST_SYNC_FF(4),    // DECIMAL; range: 2-10
    .INIT_SYNC_FF(0),    // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
    .RST_ACTIVE_HIGH(1)  // DECIMAL; 0=active low reset, 1=active high reset
    )xpm_cdc_async_rst_125M (
    .dest_arst(rst_125m), // 1-bit output: src_arst asynchronous reset signal synchronized to destination
    .dest_clk(clk_125m),   // 1-bit input: Destination clock.
    .src_arst(sys_rst_out)    // 1-bit input: Source asynchronous reset signal.
    );






endmodule
