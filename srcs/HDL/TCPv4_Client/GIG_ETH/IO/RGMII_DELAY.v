`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/02 14:44:10
// Design Name: 
// Module Name: RGMII_DELAY
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


module RGMII_DELAY#(
    parameter   IODELAY_CTRL    =     1               ,
    parameter   IODELAY_GROUP   =     "RGMII_DELAY"
    )(
    input  wire                delay_clk        ,
    input  wire                delay_rst        ,
    input  wire                RGMII_RXCLK      ,
    input  wire                RGMII_RCTL       ,
    input  wire      [03:00]   RGMII_RXD        ,
    output wire                RGMII_RXCLK_delay,
    output wire                RGMII_RCTL_delay ,
    output wire      [03:00]   RGMII_RXD_delay  
    );
parameter C2_DELAI_VALUE={5'd0};

wire    [04:00] vio_clk_delay   ;
wire    [04:00] vio_dat_delay[00:03]        ;
wire    [04:00] vio_ctl_delay   ;
wire    [04:00] vio_clk_delay_out   ;
wire    [04:00] vio_dat_delay_out[00:03]   ;
wire    [04:00] vio_ctl_delay_out   ;
genvar i;
/*
vio_rgmii_delay_ctrl vio_delay_ctrl (
    .clk        (delay_clk              ),  
    .probe_in0  (vio_ctl_delay_out      ), 
    .probe_out0 (vio_ctl_delay          )
);  
*/
assign      vio_ctl_delay           =  8'd25            ;
assign      vio_clk_delay           =   5'd0            ;
assign      vio_dat_delay[0]        =   vio_ctl_delay   ;
assign      vio_dat_delay[1]        =   vio_ctl_delay   ;
assign      vio_dat_delay[2]        =   vio_ctl_delay   ;
assign      vio_dat_delay[3]        =   vio_ctl_delay   ;

generate for(i=0;i<=3;i=i+1)begin:DATA

pin_fix_delay   #(
    .DATA_CLK_SEL   ("DATA"                 ),
    .IDELAY_VALUE   (C2_DELAI_VALUE         ),
    .IODELAY_GROUP  (IODELAY_GROUP          )
    )RGMII_RXD_DELAY_INST(
    .delay_clk      (delay_clk              ),
    .delay_rst      (delay_rst              ),
    .delay_set_in   (vio_dat_delay[i]       ),
    .delay_set_out  (vio_dat_delay_out[i]   ),
    .pin            (RGMII_RXD[i]           ),
    .pin_delay      (RGMII_RXD_delay[i]     )
    );

end
endgenerate

pin_fix_delay   #(
    .DATA_CLK_SEL   ("DATA"                 ),
    .IDELAY_VALUE   (C2_DELAI_VALUE         ),
    .IODELAY_GROUP  (IODELAY_GROUP          )
    )RGMII_RCTL_DELAY_INST( 
    .delay_clk      (delay_clk              ),
    .delay_rst      (delay_rst              ),
    .delay_set_in   (vio_ctl_delay          ),
    .delay_set_out  (vio_ctl_delay_out      ),
    .pin            (RGMII_RCTL             ),
    .pin_delay      (RGMII_RCTL_delay       )
    );  

pin_fix_delay   #(
    .DATA_CLK_SEL   ("CLOCK"                ),
    .IDELAY_VALUE   (C2_DELAI_VALUE         ),
    .IODELAY_GROUP  (IODELAY_GROUP          )
    )RGMII_RXCLK_DELAY_INST(
    .delay_clk      (delay_clk              ),
    .delay_rst      (delay_rst              ),
    .delay_set_in   (vio_clk_delay          ),
    .delay_set_out  (vio_clk_delay_out      ),
    .pin            (RGMII_RXCLK            ),
    .pin_delay      (RGMII_RXCLK_delay      )
    );      
    
    
generate if(IODELAY_CTRL==1)begin:IODELAY_GROUP_GEN
(* IODELAY_GROUP = IODELAY_GROUP *)
IDELAYCTRL IDELAYCTRL_inst (
  .RDY(RDY),       // 1-bit output: Ready output
  .REFCLK(delay_clk), // 1-bit input: Reference clock input
  .RST(delay_rst)        // 1-bit input: Active high reset input
);
end
endgenerate

    
endmodule
