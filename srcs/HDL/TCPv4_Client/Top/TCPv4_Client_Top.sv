`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/07/17 18:26:25
// Design Name: 
// Module Name: TCPv4_Server_Top
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
`include "GIG_IPv4_Types.svh"

module TCPv4_Client_Top(
    input   logic           delay_clk   ,
    input   logic           delay_rst   ,
    
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


assign PHY_RSTN = 1'b1;


logic   [47:00]     Local_Mac_Addr      ;
logic   [31:00]     Local_IPv4_Addr     ;
logic               IPv4_Gatway_Valid   ;
logic   [31:00]     IPv4_Gatway_IP      ;
logic   [31:00]     IPv4_NetMask        ;

logic               clk                 ;
(* max_fanout=32 *)logic               rst                 ;
logic               rst_i               ;

logic               ce                  ;

AXIS8               mac_tx          ()  ;
AXIS8               mac_rx          ()  ;
UDPv4_TX_HDR        udpv4_tx_hdr[00:00]    ()  ;
AXIS8               udpv4_tx_pld[00:00]    ()  ;
UDPv4_HDR           udpv4_rx_hdr    ()  ;
AXIS8               udpv4_rx_pld    ()  ;
TCPv4_TX_HDR        tcpv4_tx_hdr[00:00]    ()  ;
AXIS8               tcpv4_tx_pld[00:00]    ()  ;
TCPv4_HDR           tcpv4_rx_hdr    ()  ;
AXIS8               tcpv4_rx_opt    ()  ;
AXIS8               tcpv4_rx_pld    ()  ;

logic               mac_rx_tvalid       ;
logic   [07:00]     mac_rx_tdata        ;
logic               mac_rx_tready       ;
logic               mac_rx_tlast        ;
logic               mac_tx_tvalid       ;
logic   [07:00]     mac_tx_tdata        ;
logic               mac_tx_tready       ;
logic               mac_tx_tlast        ;
logic               GMII_TX_CLK         ;
logic               GMII_TX_EN          ;
logic               GMII_TX_ER          ;
logic   [07:00]     GMII_TXD            ;
logic               GMII_RX_CLK         ;
logic               GMII_RX_DV          ;
logic               GMII_RX_ER          ;
logic   [07:00]     GMII_RXD            ;

logic               PHY_RXCLK_delay     ;
logic               PHY_RCTL_delay      ;
logic   [03:00]     PHY_RXD_delay       ;

logic               usr_tcpv4_rx_tvalid ;     
logic   [07:00]     usr_tcpv4_rx_tdata  ;
logic               usr_tcpv4_rx_pfull  ;
logic               usr_tcpv4_tx_tvalid ;
logic   [07:00]     usr_tcpv4_tx_tdata  ;
logic               usr_tcpv4_tx_tlast  ;
logic               usr_tcpv4_tx_tready ;

logic               tcp_established     ;
logic               process_rst         ;

logic   [31:00]     tcpv4_server_ip     ;
logic   [15:00]     tcpv4_server_port   ;
logic   [15:00]     tcpv4_client_port   ;

logic               tcpv4_link_tvalid   ;
logic               tcpv4_link_tdata    ;
logic               tcpv4_link_tready   ;

logic   [47:00]     tcp_tx_cnt          ;

logic   [47:00]     tick                ;

parameter   integer     ENABLE_DELAY    =   1               ;
parameter   integer     IODELAY_CTRL    =   1               ;
parameter               IODELAY_GROUP   =   "RGMII_DELAY"   ;
    
parameter   ENABLE_ILAS             =   0               ;
parameter   BIND_PORT               =   16'd22333       ;
parameter   Local_MSS               =   16'd1460        ;
parameter   MAX_WIN                 =   16'd1460*44     ;
parameter   RX_BUF_AW               =   16              ;
parameter   TX_BUF_AW               =   16              ;
parameter   integer     RQLW        =   44              ;
parameter   integer     RQAW        =   $clog2(RQLW)    ;
parameter   integer     TQLW        =   44              ;
parameter   integer     TQAW        =   $clog2(TQLW)    ; 



assign      Local_Mac_Addr      =48'h20_1E_C8_E9_BC_78  ;
assign      Local_IPv4_Addr     =32'hC0A86408      ;
assign      IPv4_Gatway_Valid   =1'b0               ;
assign      IPv4_Gatway_IP      =32'hC0A86401       ;
assign      IPv4_NetMask        =32'hFFFFFF00       ;
assign      ce                  =1'b1               ;


generate if(ENABLE_DELAY==1)begin
RGMII_DELAY #(
    .IODELAY_CTRL       (IODELAY_CTRL           ),
    .IODELAY_GROUP      (IODELAY_GROUP          )
)u_RGMII_DELAY(
    .delay_clk          (delay_clk              ),
    .delay_rst          (delay_rst              ),
    .RGMII_RXCLK        (PHY_RXC                ), 
    .RGMII_RCTL         (PHY_RXCTL              ), 
    .RGMII_RXD          (PHY_RXD                ), 
    .RGMII_RXCLK_delay  (PHY_RXCLK_delay        ),
    .RGMII_RCTL_delay   (PHY_RCTL_delay         ),
    .RGMII_RXD_delay    (PHY_RXD_delay          )
);
end
else begin
assign      PHY_RXCLK_delay     =   PHY_RXC    ;
assign      PHY_RCTL_delay      =   PHY_RXCTL  ;
assign      PHY_RXD_delay       =   PHY_RXD    ;
end
endgenerate


always_ff@(posedge clk)begin
    if(rst_i)begin
        rst <=  1'b1    ;
    end
    else begin
        rst <=  1'b0    ;
    end
end

RGMII_IO    u_RGMII_IO(
    .ASYNC_RST          (delay_rst              ),
    .SYNC_RST           (rst_i                  ),

    .RGMII_TXCLK        (PHY_TXC               ),    
    .RGMII_TCTL         (PHY_TXCTL             ),   
    .RGMII_TXD          (PHY_TXD               ),    
    .RGMII_RXCLK        (PHY_RXCLK_delay        ),
    .RGMII_RCTL         (PHY_RCTL_delay         ),  
    .RGMII_RXD          (PHY_RXD_delay          ),    

    .GMII_TX_CLK        (GMII_TX_CLK            ),
    .GMII_TX_EN         (GMII_TX_EN             ),
    .GMII_TX_ER         (GMII_TX_ER             ),
    .GMII_TXD           (GMII_TXD               ),

    .GMII_RX_CLK        (GMII_RX_CLK            ),
    .GMII_RX_DV         (GMII_RX_DV             ),
    .GMII_RX_ER         (GMII_RX_ER             ),
    .GMII_RXD           (GMII_RXD               )
    );

GMII_2_AXIS u_GMII_2_AXIS(
    .GMII_TX_CLK        (GMII_TX_CLK            ),
    .GMII_TX_EN         (GMII_TX_EN             ),
    .GMII_TX_ER         (GMII_TX_ER             ),
    .GMII_TXD           (GMII_TXD               ),

    .GMII_RX_CLK        (GMII_RX_CLK            ),
    .GMII_RX_DV         (GMII_RX_DV             ),
    .GMII_RX_ER         (GMII_RX_ER             ),
    .GMII_RXD           (GMII_RXD               ),

    .clk                (clk                    ),
    .rst                (rst                    ),
    .mac_rx_tvalid      (mac_rx_tvalid          ),
    .mac_rx_tdata       (mac_rx_tdata           ),
    .mac_rx_tlast       (mac_rx_tlast           ),

    .mac_tx_tvalid      (mac_tx_tvalid          ),
    .mac_tx_tdata       (mac_tx_tdata           ),
    .mac_tx_tlast       (mac_tx_tlast           )
    );

assign  mac_tx_tvalid   =   mac_tx.tvalid   ;
assign  mac_tx_tdata    =   mac_tx.tdata    ;
assign  mac_tx_tlast    =   mac_tx.tlast    ;
assign  mac_tx.tready   =   1'b1            ;

assign  mac_rx.tvalid   =   mac_rx_tvalid   ;
assign  mac_rx.tdata    =   mac_rx_tdata    ;
assign  mac_rx.tlast    =   mac_rx_tlast    ;


UDP_TCP_IPv4_Block#(
    .UDPv4_TX_CH            (1                  ),
    .TCPv4_TX_CH            (1                  ),
    .RX_CHECKSUM_EN         (1                  ),
    .FCS_CHK_EN             (1                  ),
    .LUT_ADDR_W             (9                  ),
    .IP_ARP_CH              (3                  )
    )UDP_TCP_IPv4_Block(
    .clk                    (clk                 ),
    .rst                    (rst                 ),
    .ce                     (ce                  ),
    .Local_Mac_Addr         (Local_Mac_Addr      ),
    .Local_IPv4_Addr        (Local_IPv4_Addr     ),
    .IPv4_Gatway_Valid      (IPv4_Gatway_Valid   ),
    .IPv4_Gatway_IP         (IPv4_Gatway_IP      ),//网关IP
    .IPv4_NetMask           (IPv4_NetMask        ),
    .mac_tx                 (mac_tx              ),
    .mac_rx                 (mac_rx              ),
    .udpv4_tx_hdr           (udpv4_tx_hdr        ),
    .udpv4_tx_pld           (udpv4_tx_pld        ),
    .udpv4_rx_hdr           (udpv4_rx_hdr        ),
    .udpv4_rx_pld           (udpv4_rx_pld        ),
    .tcpv4_tx_hdr           (tcpv4_tx_hdr        ),
    .tcpv4_tx_pld           (tcpv4_tx_pld        ),
    .tcpv4_rx_hdr           (tcpv4_rx_hdr        ),
    .tcpv4_rx_opt           (tcpv4_rx_opt        ),
    .tcpv4_rx_pld           (tcpv4_rx_pld        )
    );

assign  udpv4_tx_hdr[0].tvalid  =   1'b0    ;
assign  udpv4_tx_pld[0].tvalid  =   1'b0    ;
assign  udpv4_rx_hdr.tready     =   1'b1    ;
assign  udpv4_rx_pld.tready     =   1'b1    ;

/*
TCPv4_Server_1460#(
    .ENABLE_ILAS            (0                      ),
    .BIND_PORT              (BIND_PORT              ),
    .Local_MSS              (Local_MSS              ),
    .MAX_WIN                (MAX_WIN                )
    )S0_TCPv4_Server_1460(
    .clk                    (clk                    ),
    .rst                    (rst                    ),
    .ce                     (ce                     ),

    .Local_IPv4_Addr        (Local_IPv4_Addr        ),
    .tcpv4_tx_hdr           (tcpv4_tx_hdr[0]        ),
    .tcpv4_tx_pld           (tcpv4_tx_pld[0]        ),
    .tcpv4_rx_hdr           (tcpv4_rx_hdr_0         ),
    .tcpv4_rx_pld           (tcpv4_rx_pld_0         ),
    
    .usr_tcpv4_rx_tvalid    (usr_tcpv4_rx_tvalid    ),
    .usr_tcpv4_rx_tdata     (usr_tcpv4_rx_tdata     ),
    .usr_tcpv4_rx_pfull     (usr_tcpv4_rx_pfull     ),
    .usr_tcpv4_tx_tvalid    (usr_tcpv4_tx_tvalid    ),
    .usr_tcpv4_tx_tdata     (usr_tcpv4_tx_tdata     ),
    .usr_tcpv4_tx_tlast     (usr_tcpv4_tx_tlast     ),
    .usr_tcpv4_tx_tready    (usr_tcpv4_tx_tready    )
    );
*/
TCPv4_Client#(
    .ENABLE_ILAS            (ENABLE_ILAS            ),
//    .BIND_PORT              (BIND_PORT              ),
    .Local_MSS              (Local_MSS              ),
    .MAX_WIN                (MAX_WIN                ),
    .RX_BUF_AW              (RX_BUF_AW              ),
    .TX_BUF_AW              (TX_BUF_AW              ),
    .RQLW                   (RQLW                   ),
    .RQAW                   (RQAW                   ),
    .TQLW                   (TQLW                   ),
    .TQAW                   (TQAW                   )  
    )TCPv4_Client(
    .clk                    (clk                    ),
    .rst                    (rst                    ),
    .ce                     (ce                     ),
    .Local_IPv4_Addr        (Local_IPv4_Addr        ),
    .tcp_established        (tcp_established        ),
    .process_rst            (process_rst            ),
    .tcpv4_tx_hdr           (tcpv4_tx_hdr[0]        ),
    .tcpv4_tx_pld           (tcpv4_tx_pld[0]        ),
    .tcpv4_rx_hdr           (tcpv4_rx_hdr           ),
    .tcpv4_rx_pld           (tcpv4_rx_pld           ),

    .tcpv4_server_ip        (tcpv4_server_ip        ),
    .tcpv4_server_port      (tcpv4_server_port      ),
    .tcpv4_client_port      (tcpv4_client_port      ),
    .tcpv4_link_tvalid      (tcpv4_link_tvalid      ),
    .tcpv4_link_tdata       (tcpv4_link_tdata       ), //1 connect, 0 disconnect
    .tcpv4_link_tready      (tcpv4_link_tready      ),

    .usr_tcpv4_rx_tvalid    (usr_tcpv4_rx_tvalid    ),
    .usr_tcpv4_rx_tdata     (usr_tcpv4_rx_tdata     ),
    .usr_tcpv4_rx_pfull     (usr_tcpv4_rx_pfull     ),
                                
    .usr_tcpv4_tx_tvalid    (usr_tcpv4_tx_tvalid    ),
    .usr_tcpv4_tx_tdata     (usr_tcpv4_tx_tdata     ),
    .usr_tcpv4_tx_tlast     (usr_tcpv4_tx_tlast     ),
    .usr_tcpv4_tx_tready    (usr_tcpv4_tx_tready    )
    );

always_ff@(posedge clk)begin
    if(rst==1'b1)begin
        tick    <=  48'h0   ;
    end
    else if(ce==1'b1)begin
        tick    <=  tick    +   48'd1   ;
    end
end

/*
ila_mac ila_mac (
	.clk                    (clk                ), // input wire clk
	.probe0                 (mac_tx_tvalid      ), // input wire [0:0]  probe0  
	.probe1                 (mac_tx_tdata       ), // input wire [7:0]  probe1 
	.probe2                 (mac_tx_tlast       ), // input wire [0:0]  probe2 
	.probe3                 (mac_rx_tvalid      ), // input wire [0:0]  probe3 
	.probe4                 (mac_rx_tdata       ), // input wire [7:0]  probe4 
	.probe5                 (mac_rx_tlast       ), // input wire [0:0]  probe5
	.probe6                 (tick               ) // input wire [0:0]  probe5
);
*/
assign  usr_tcpv4_rx_pfull  =   1'b0    ;


ila_tcpv4_test ila_tcpv4_test (
	.clk        (clk                    ), // input wire clk
	.probe0     (usr_tcpv4_rx_tvalid    ), // input wire [0:0]  probe0  
	.probe1     (usr_tcpv4_rx_tdata     ), // input wire [0:0]  probe1 
	.probe2     (usr_tcpv4_rx_pfull     ), // input wire [0:0]  probe2 
	.probe3     (usr_tcpv4_tx_tvalid    ), // input wire [0:0]  probe3 
	.probe4     (usr_tcpv4_tx_tdata     ), // input wire [0:0]  probe4 
	.probe5     (usr_tcpv4_tx_tlast     ), // input wire [0:0]  probe5 
	.probe6     (usr_tcpv4_tx_tready    ) // input wire [0:0]  probe6 
);

logic   [47:00] tx_sts_BPS              ;
logic   [47:00] tx_sts_MBPS             ;
logic   [47:00] rx_sts_BPS              ;
logic   [47:00] rx_sts_MBPS             ;
logic   [47:00] tcp_rx_err_cnt          ;
logic   [47:00] tcp_rx_recv_cnt         ;
logic           tcp_rx_err_bit          ;

speed_cal#(
    .NBytes     (1                      ),
    .STS_W      (48                     ),
    .FREQ_HZ    (125000000              )
    )speed_cal_tx(
    .sys_clk    (clk                    ),
    .sys_rst    (rst                    ),
    .data_en    (usr_tcpv4_tx_tvalid&usr_tcpv4_tx_tready   ),
    .sts_BPS    (tx_sts_BPS             ),
    .sts_MBPS   (tx_sts_MBPS            )
    );

speed_cal#(
    .NBytes     (1                      ),
    .STS_W      (48                     ),
    .FREQ_HZ    (125000000              )
    )speed_cal_rx(
    .sys_clk    (clk                    ),
    .sys_rst    (rst                    ),
    .data_en    (usr_tcpv4_rx_tvalid    ),
    .sts_BPS    (rx_sts_BPS             ),
    .sts_MBPS   (rx_sts_MBPS            )
    );

Seq_Check#(
    .TYPE       ("INC"                  ),
    .DW         (8                      ),
    .SUMW       (48                     )
    )TCP_Seq_Check(
    .sys_clk    (clk                    ),
    .sys_rst    (rst                    ),
    .data_en    (usr_tcpv4_rx_tvalid    ),
    .data_value (usr_tcpv4_rx_tdata     ),
    .err_cnt    (tcp_rx_err_cnt         ),
    .recv_cnt   (tcp_rx_recv_cnt        ),
    .err_bit    (tcp_rx_err_bit         )
);

//assign  usr_tcpv4_tx_tlast  =   1'b0    ;

always@(posedge clk)begin
    if(rst==1'b1)begin
        usr_tcpv4_tx_tdata  <=  8'h0    ;
        tcp_tx_cnt          <=  48'h0   ;
    end
    else if(ce==1'b1)begin
        if(usr_tcpv4_tx_tvalid&usr_tcpv4_tx_tready)begin
            usr_tcpv4_tx_tdata  <=  usr_tcpv4_tx_tdata  +   8'd1    ;
            tcp_tx_cnt          <=  tcp_tx_cnt          +   48'd1   ;
        end
    end
end

always@(posedge clk)begin
    if(rst==1'b1)begin
        usr_tcpv4_tx_tvalid <=  1'b0    ;
        usr_tcpv4_tx_tlast  <=  1'b0    ;
    end
    else if(ce==1'b1)begin
        if(vio_usr_tcpv4_tx_tvalid)begin
            usr_tcpv4_tx_tvalid <=  1'b1    ;
            usr_tcpv4_tx_tlast  <=  1'b0    ;
        end
        else if(usr_tcpv4_tx_tvalid&(~vio_usr_tcpv4_tx_tvalid)&(~usr_tcpv4_tx_tlast))begin
            usr_tcpv4_tx_tvalid <=  1'b1    ;
            usr_tcpv4_tx_tlast  <=  1'b1    ;
        end
        else begin
            usr_tcpv4_tx_tvalid <=  1'b0    ;
            usr_tcpv4_tx_tlast  <=  1'b0    ;
        end
    end
end


//assign  usr_tcpv4_tx_tvalid =   (vio_usr_tcpv4_tx_tvalid)&(~rst)    ;

logic           vio_tcpv4_link_tvalid   ;
logic           r_tcpv4_link_tvalid     ;

//assign          tcpv4_link_tready   =   ~process_rst    ;

vio_tcp_test vio_tcp_test (
    .clk                (clk                        ),  // input wire clk
    .probe_in0          (tcp_established            ),   // output wire [0 : 0] probe_out0
    .probe_in1          (tx_sts_BPS                 ),   // output wire [0 : 0] probe_out0
    .probe_in2          (tx_sts_MBPS                ),   // output wire [0 : 0] probe_out0
    .probe_in3          (rx_sts_BPS                 ),   // output wire [0 : 0] probe_out0
    .probe_in4          (rx_sts_MBPS                ),   // output wire [0 : 0] probe_out0
    .probe_in5          (tcp_rx_err_cnt             ),   // output wire [0 : 0] probe_out0
    .probe_in6          (tcp_rx_recv_cnt            ),   // output wire [0 : 0] probe_out0
    .probe_in7          (tcp_tx_cnt                 ),   // output wire [0 : 0] probe_out0
    .probe_in8          (tcpv4_link_tready          ),   // output wire [0 : 0] probe_out0
    .probe_out0         (vio_usr_tcpv4_tx_tvalid    ),   // output wire [0 : 0] probe_out0
    .probe_out1         (tcpv4_server_ip            ),   // output wire [0 : 0] probe_out0
    .probe_out2         (tcpv4_server_port          ),   // output wire [0 : 0] probe_out0
    .probe_out3         (tcpv4_client_port          ),   // output wire [0 : 0] probe_out0
    .probe_out4         (tcpv4_link_tdata           ),   // output wire [0 : 0] probe_out0
    .probe_out5         (vio_tcpv4_link_tvalid      )   // output wire [0 : 0] probe_out0
);

always@(posedge clk)begin
    if(rst==1'b1)begin
        r_tcpv4_link_tvalid <=  1'b0    ;
    end
    else if(ce==1'b1) begin
        r_tcpv4_link_tvalid <=  vio_tcpv4_link_tvalid   ;
        if(vio_tcpv4_link_tvalid&(~r_tcpv4_link_tvalid))begin
            tcpv4_link_tvalid   <=  1'b1    ;
        end
        else if(tcpv4_link_tvalid&tcpv4_link_tready) begin
            tcpv4_link_tvalid   <=  1'b0    ;
        end
    end
end



endmodule
