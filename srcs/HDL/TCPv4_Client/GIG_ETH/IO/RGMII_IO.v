`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/20 01:25:44
// Design Name: 
// Module Name: RGMII_IO
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


module RGMII_IO(
    input   wire            ASYNC_RST           ,
    output  wire            SYNC_RST            ,

    output  wire            RGMII_TXCLK         ,
    output  wire            RGMII_TCTL          ,
    output  wire    [03:00] RGMII_TXD           ,
    input   wire            RGMII_RXCLK         ,
    input   wire            RGMII_RCTL          ,
    input   wire    [03:00] RGMII_RXD           ,
    
    output  wire            GMII_TX_CLK         ,
    input   wire            GMII_TX_EN          ,
    input   wire            GMII_TX_ER          ,
    input   wire    [07:00] GMII_TXD            ,

    output  wire            GMII_RX_CLK         ,
(*ASYNC_REG="true"*)    output  reg             GMII_RX_DV          ,
(*ASYNC_REG="true"*)    output  reg             GMII_RX_ER          ,
(*ASYNC_REG="true"*)    output  reg    [07:00]  GMII_RXD            
    );
wire    [07:00] GMII_RXD_I          ;
wire            GMII_RX_DV_I        ;
wire            RGMII_RX_CTL_I      ;

(*ASYNC_REG="true"*)reg    [07:00] R1_GMII_RXD      ;
(*ASYNC_REG="true"*)reg            R1_GMII_RX_DV    ;
(*ASYNC_REG="true"*)reg            R1_RGMII_RX_CTL  ;
(*ASYNC_REG="true"*)reg    [07:00] R2_GMII_RXD      ;
(*ASYNC_REG="true"*)reg            R2_GMII_RX_DV    ;
(*ASYNC_REG="true"*)reg            R2_RGMII_RX_CTL  ;


reg             R1_GMII_TX_EN       ;
reg             R1_GMII_TX_ER       ;
reg     [07:00] R1_GMII_TXD         ;
reg             R2_GMII_TX_EN       ;
reg             R2_RGMII_TX_CTL     ;
reg     [07:00] R2_GMII_TXD         ;
    
assign      GMII_TX_CLK     =   GMII_RX_CLK ;


xpm_cdc_async_rst #(
    .DEST_SYNC_FF       (4                      ),      // DECIMAL; range: 2-10
    .INIT_SYNC_FF       (0                      ),      // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
    .RST_ACTIVE_HIGH    (0                      )       // DECIMAL; 0=active low reset, 1=active high reset
   )rst_xpm_cdc_async   (
    .dest_arst          (SYNC_RST               ),      // 1-bit output: src_arst asynchronous reset signal synchronized to destination
    .dest_clk           (GMII_RX_CLK            ),      // 1-bit input: Destination clock.
    .src_arst           (ASYNC_RST              )       // 1-bit input: Source asynchronous reset signal.
   );


always @(posedge GMII_RX_CLK)begin
    R1_GMII_RXD     <=  GMII_RXD_I      ;
    R1_GMII_RX_DV   <=  GMII_RX_DV_I    ;
    R1_RGMII_RX_CTL <=  RGMII_RX_CTL_I  ;
    
    R2_GMII_RXD     <=  R1_GMII_RXD     ;
    R2_GMII_RX_DV   <=  R1_GMII_RX_DV   ;
    R2_RGMII_RX_CTL <=  R1_RGMII_RX_CTL ;
    
    GMII_RXD        <=  R2_GMII_RXD                     ;
    GMII_RX_DV      <=  R2_GMII_RX_DV                   ;
    GMII_RX_ER      <=  R2_GMII_RX_DV^R2_RGMII_RX_CTL   ;
end

always @(posedge GMII_TX_CLK)begin
    R1_GMII_TX_EN   <=  GMII_TX_EN      ;
    R1_GMII_TX_ER   <=  GMII_TX_ER      ;
    R1_GMII_TXD     <=  GMII_TXD        ;

    R2_GMII_TX_EN   <=  R1_GMII_TX_EN   ;
    R2_GMII_TXD     <=  R1_GMII_TXD     ;
    R2_RGMII_TX_CTL <=  R1_GMII_TX_EN ^ R1_GMII_TX_ER ;
end


BUFR    u_RGMII_RXCLK_BUFR(
    .I      (RGMII_RXCLK    ),
    .O      (GMII_RX_CLK_i  )
    );

BUFG    u_RGMII_RXCLK_BUFG(
    .I      (GMII_RX_CLK_i  ),
    .O      (GMII_RX_CLK    )
    );


ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE")
  ) RGMII_TXCLK_ODDR (
    .Q              (RGMII_TXCLK    ),
    .C              (GMII_TX_CLK    ),
    .CE             (1'b1           ),
    .D1             (1'b1           ),
    .D2             (1'b0           ),
    .R              (SYNC_RST       ),
    .S              (1'b0           )
    );

IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
    ) RGMII_RCTL_IDDR (
    .Q1             (GMII_RX_DV_I       ),
    .Q2             (RGMII_RX_CTL_I     ),
    .C              (GMII_RX_CLK        ),
    .CE             (1'b1               ),
    .D              (RGMII_RCTL         ),
    .R              (1'b0               ),
    .S              (1'b0               )
    );

ODDR #(
    .DDR_CLK_EDGE("SAME_EDGE")
  ) rgmii_tx_ctl_out (
    .Q              (RGMII_TCTL         ),
    .C              (GMII_TX_CLK        ),
    .CE             (1'b1               ),
    .D1             (R2_GMII_TX_EN      ),
    .D2             (R2_RGMII_TX_CTL    ),
    .R              (SYNC_RST           ),
    .S              (1'b0               )
    );

genvar i;
generate
for (i = 0; i < 4; i = i + 1) begin : DATA_IN_OUT
ODDR #(
      .DDR_CLK_EDGE("SAME_EDGE")
    ) RGMII_TXD_ODDR (
    .Q              (RGMII_TXD[i]       ),
    .C              (GMII_TX_CLK        ),
    .CE             (1                  ),
    .D1             (R2_GMII_TXD[i]     ),
    .D2             (R2_GMII_TXD[i+4]   ),
    .R              (SYNC_RST           ),
    .S              (0                  )
    );

IDDR #(
  .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
) RGMII_RXD_IDDR (
    .Q1             (GMII_RXD_I[i]      ),
    .Q2             (GMII_RXD_I[i+4]    ),
    .C              (GMII_RX_CLK        ),
    .CE             (1'b1               ),
    .D              (RGMII_RXD[i]       ),
    .R              (1'b0               ),
    .S              (1'b0               )
    );
end
endgenerate

endmodule
