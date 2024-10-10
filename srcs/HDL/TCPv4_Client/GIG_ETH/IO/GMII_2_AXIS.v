`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/22 01:21:08
// Design Name: 
// Module Name: GMII_2_AXIS
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


module GMII_2_AXIS(
    input   wire            GMII_TX_CLK         ,
    output  reg             GMII_TX_EN          ,
    output  wire            GMII_TX_ER          ,
    output  reg     [07:00] GMII_TXD            ,

    input   wire            GMII_RX_CLK         ,
    input   wire            GMII_RX_DV          ,
    input   wire            GMII_RX_ER          ,
    input   wire   [07:00]  GMII_RXD            ,
    
    output  wire            clk                 ,
    input   wire            rst                 ,
    output  reg             mac_rx_tvalid       ,
    output  reg     [07:00] mac_rx_tdata        ,
    output  reg             mac_rx_tlast        ,
    
    input   wire            mac_tx_tvalid       ,
    input   wire    [07:00] mac_tx_tdata        ,
    input   wire            mac_tx_tlast        
    );
reg             R_GMII_RX_DV            ;
reg             R_GMII_RX_ER            ;
reg     [07:00] R_GMII_RXD              ;

assign          GMII_TX_ER  =   1'b0    ;

BUFG u_bufg(
    .O      (clk                    ),
    .I      (GMII_RX_CLK            )
    );

always@(posedge clk)begin
    R_GMII_RX_DV  <=    GMII_RX_DV  ;
    R_GMII_RX_ER  <=    GMII_RX_ER  ;
    R_GMII_RXD    <=    GMII_RXD    ;
    if(rst)begin
        mac_rx_tvalid   <=  1'b0    ;
        mac_rx_tdata    <=  8'h0    ;
        mac_rx_tlast    <=  1'b0    ;
    end
    else begin
        if((R_GMII_RX_DV==1'b1)&&((GMII_RX_DV==1'b0)||(R_GMII_RX_ER==1'b1)))begin
            mac_rx_tlast    <=  1'b1    ;
        end
        else begin
            mac_rx_tlast    <=  1'b0    ;
        end
        mac_rx_tvalid   <=  R_GMII_RX_DV    ;
        mac_rx_tdata    <=  R_GMII_RXD      ;
    end
end

always@(posedge clk)begin
    GMII_TX_EN  <=  mac_tx_tvalid   ;
    if(mac_tx_tvalid)begin
        GMII_TXD    <=  mac_tx_tdata    ;
    end
    else begin
        GMII_TXD    <=  8'hDD       ;
    end
end

endmodule
