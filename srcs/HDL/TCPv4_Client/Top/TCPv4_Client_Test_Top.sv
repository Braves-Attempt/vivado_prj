`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/17 18:17:14
// Design Name: 
// Module Name: TCPv4_Server_Test_Top
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


module TCPv4_Client_Test_Top(
//    input   wire            PL_CLK0_P   ,
//    input   wire            PL_CLK0_N   ,
    
    input   wire            SYS_CLK     ,

    output  wire            PHY_RSTN    ,
    inout   tri             PHY_MDC     ,
    inout   tri             PHY_MDIO    ,
    input   wire            PHY_RXC     ,
    input   wire            PHY_RXCTL   ,
    input   wire    [03:00] PHY_RXD     ,
    output  wire            PHY_TXC     ,
    output  wire            PHY_TXCTL   ,
    output  wire    [03:00] PHY_TXD     
    );

(* dont_touch="true" *)logic           clk_200m    ;
logic           rst_200m    ;


Clock_Reset Clock_Reset(
//    .REF_CLK_P          (PL_CLK0_P          ),
//    .REF_CLK_N          (PL_CLK0_N          ),
    
    .clk                (SYS_CLK            ),
    .clk_200m           (clk_200m           ),
    .rst_200m           (rst_200m           )
    );

TCPv4_Client_Top TCPv4_Client_Top(
    .delay_clk          (clk_200m           ),
    .delay_rst          (rst_200m           ),
    .PHY_RSTN           (PHY_RSTN           ),
    .PHY_MDC            (PHY_MDC            ),
    .PHY_MDIO           (PHY_MDIO           ),
    .PHY_RXC            (PHY_RXC            ),
    .PHY_RXCTL          (PHY_RXCTL          ),
    .PHY_RXD            (PHY_RXD            ),
    .PHY_TXC            (PHY_TXC            ),
    .PHY_TXCTL          (PHY_TXCTL          ),
    .PHY_TXD            (PHY_TXD            )
    );

endmodule
