`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/05/12 09:46:14
// Design Name: 
// Module Name: pin_fix_delay
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


module pin_fix_delay#(
    parameter   DATA_CLK_SEL    =   "DATA"          ,
    parameter   IDELAY_VALUE    =   5'd0            ,
    parameter   IODELAY_GROUP   =   "RGMII_DELAY"
    )(
    delay_clk       ,
    delay_rst       ,
    delay_set_in    ,
    delay_set_out   ,
    pin             ,
    pin_delay   
    );
input           delay_clk       ;
input           delay_rst       ;
input   [04:00] delay_set_in    ;
output  [04:00] delay_set_out   ;
input           pin             ;
output          pin_delay       ;


generate if(DATA_CLK_SEL=="DATA")begin
(* IODELAY_GROUP = IODELAY_GROUP *)
IDELAYE2
  # (
    .CINVCTRL_SEL           ("FALSE"),   
    .DELAY_SRC              ("IDATAIN"), 
    .HIGH_PERFORMANCE_MODE  ("FALSE"),   
    .IDELAY_TYPE            ("VAR_LOAD"),
    .IDELAY_VALUE           (IDELAY_VALUE),         
    .REFCLK_FREQUENCY       (200.0),
    .PIPE_SEL               ("FALSE"),
    .SIGNAL_PATTERN         ("DATA")          )    
  u_idelaye2_bus
    (
    .DATAOUT                (pin_delay                      ),
    .DATAIN                 (1'b0                           ), 
    .C                      (delay_clk                      ),
    .CE                     (1'b1                           ), 
    .INC                    (1'b0                           ), 
    .IDATAIN                (pin                            ), 
    .LD                     (1'b1                           ),
    .REGRST                 (1'b0                           ),
    .LDPIPEEN               (1'b0                           ),
    .CNTVALUEIN             (delay_set_in                   ),
    .CNTVALUEOUT            (delay_set_out                  ),
    .CINVCTRL               (1'b0                           )
    );

end
else begin
(* IODELAY_GROUP = IODELAY_GROUP *)
IDELAYE2 # (
    .CINVCTRL_SEL           ("FALSE"),            // TRUE, FALSE
    .DELAY_SRC              ("IDATAIN"),        // IDATAIN, DATAIN
    .HIGH_PERFORMANCE_MODE  ("FALSE"),             // TRUE, FALSE
    .IDELAY_TYPE            ("FIXED"),          // FIXED, VARIABLE, or VAR_LOADABLE
    .IDELAY_VALUE           (IDELAY_VALUE),                // 0 to 31
    .REFCLK_FREQUENCY       (200.0),
    .PIPE_SEL               ("FALSE"),
    .SIGNAL_PATTERN         ("CLOCK"))           // CLOCK, DATA
    idelaye2_clk
    (
        .DATAOUT            (pin_delay          ),  // Delayed clock
        .DATAIN             (1'b0               ),              // Data from FPGA logic
        .C                  (1'b0               ),
        .CE                 (1'b0               ),
        .INC                (1'b0               ),
        .IDATAIN            (pin                ),
        .LD                 (1'b0               ),
        .LDPIPEEN           (1'b0               ),
        .REGRST             (1'b0               ),
        .CNTVALUEIN         (5'b00000           ),
        .CNTVALUEOUT        (                   ),
        .CINVCTRL           (1'b0               )
    );
end

endgenerate

endmodule
