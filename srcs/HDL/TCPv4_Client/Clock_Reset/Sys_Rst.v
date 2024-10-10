`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2019/12/05 14:08:20
// Design Name:
// Module Name: Sys_Rst
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


module Sys_Rst#(
    parameter   CLOCK_FREQ_HZ       =   25000000   ,
    parameter   PU_RST_RELEASE_US   =   1           ,//首次收到非复位信号的延时
    parameter   PU_DELAY_US         =   1           ,
    parameter   RSTDY_US            =   1         ,
    parameter   RECV_RST_US         =   1
    )(
    input   wire            sys_clk         ,
    input   wire            board_rst_n     ,
    input   wire            clock_locked    ,
    output  wire            sys_rst_out     ,
    output  reg     [03:00] debug_fsm_curr                ,
    output  reg             debug_delay_rst               ,
    output  reg     [31:00] debug_pu_rst_release_cnt      
    );

localparam  integer PU_RST_RELEASE_SIZE =(CLOCK_FREQ_HZ/1000000)*PU_RST_RELEASE_US  ;      //连续接收非复位信号个数
localparam  integer PU_DELAY_SIZE       =(CLOCK_FREQ_HZ/1000000)*PU_DELAY_US        ;      //复位释放后延时
localparam  integer RSTDY_SIZE          =(CLOCK_FREQ_HZ/1000000)*RSTDY_US           ;      //接收不到复位后，转到正常状态延时 ~163us
localparam  integer RECV_RST_SIZE       =(CLOCK_FREQ_HZ/1000000)*RECV_RST_US        ;      //连续接收256个复位，才认为复位有效 ~10us

reg                 sys_rst_out_i   =   1'b1    ;

(*ASYNC_REG="true"*)reg [03:00]     board_rst_n_srl = 4'b0000;
(*ASYNC_REG="true"*)reg     board_rst_n_srl_cmp     ;
reg     [31:00] pu_rst_release_cnt  =   32'h0;
reg     [31:00] pu_delay_cnt        =   32'h0;
reg     [31:00] rstdy_cnt           =   32'h0;
reg     [31:00] recv_rst_cnt        =   32'h0;

(*ASYNC_REG="true"*)reg     [03:00] delay_shift_rst     =   4'b1111;
reg             delay_rst           =   1'b1    ;

localparam      FSM_PUWT    =   4'b0001 ;
localparam      FSM_PUDY    =   4'b0010 ;
localparam      FSM_RSTDY   =   4'b0100 ;
localparam      FSM_RST_R   =   4'b1000 ;

 (* fsm_safe_state = "reset_state" *)reg     [03:00] fsm_curr    =   FSM_PUWT;
reg     [03:00] fsm_next    =   FSM_PUWT;

always@(posedge sys_clk)begin
    debug_fsm_curr              <=  fsm_curr;
    debug_delay_rst             <=  delay_rst;
    debug_pu_rst_release_cnt    <=  pu_rst_release_cnt ;
end




always@(posedge  sys_clk or negedge clock_locked)begin
    if(~clock_locked)begin
        delay_shift_rst <=  4'b1111;
    end
    else begin
        delay_shift_rst <=  {1'b0,delay_shift_rst[03:01]};
    end
end

always@(posedge  sys_clk)begin
    delay_rst   <=  delay_shift_rst[0]  ;
end

always@(posedge sys_clk)begin
    if(delay_rst)begin
        fsm_curr  <=  FSM_PUWT    ;
    end
    else begin
        fsm_curr  <=  fsm_next;
    end
end

always@(*)begin
    case(fsm_curr)
        FSM_PUWT:
        begin
            if(pu_rst_release_cnt>=PU_RST_RELEASE_SIZE)
            begin
                fsm_next  =   FSM_PUDY    ;
            end
            else
            begin
                fsm_next  =   FSM_PUWT    ;
            end
        end
        FSM_PUDY:
        begin
            if(pu_delay_cnt>=PU_DELAY_SIZE)
            begin
                fsm_next  =   FSM_RSTDY   ;
            end
            else
            begin
                fsm_next  =   FSM_PUDY    ;
            end
        end
        FSM_RSTDY:
        begin
            if(rstdy_cnt>=RSTDY_SIZE) //外部复位释放后的延时
            begin
                fsm_next  =   FSM_RST_R;
            end
            else
            begin
                fsm_next  =   FSM_RSTDY;
            end
        end
        FSM_RST_R:
        begin
            if(recv_rst_cnt>=RECV_RST_SIZE) //连续收到 多少个复位
            begin
                fsm_next  =   FSM_RSTDY;
            end
            else
            begin
                fsm_next  =   FSM_RST_R;
            end
        end
        default:
        begin
            fsm_next  =   FSM_PUWT    ;
        end
    endcase
end

always@(posedge sys_clk or negedge board_rst_n)begin
    if(~board_rst_n)
    begin
        board_rst_n_srl <=  4'b0000;
    end
    else
    begin
        board_rst_n_srl <=  {1'b1,board_rst_n_srl[03:01]};
    end
end

always@(posedge sys_clk)begin
    board_rst_n_srl_cmp <=  board_rst_n_srl[0]  ;
end

always@(posedge sys_clk)begin
    pu_rst_release_cnt  <=  ((fsm_curr==FSM_PUWT)&(board_rst_n_srl_cmp))?(pu_rst_release_cnt  +   1'b1):32'h0;
    pu_delay_cnt        <=  (fsm_curr==FSM_PUDY)?(pu_delay_cnt    +   1'b1):32'h0 ;
    rstdy_cnt           <=  ((fsm_curr==FSM_RSTDY)&(board_rst_n_srl_cmp))?(rstdy_cnt   +   1'b1    ):32'h0;
    recv_rst_cnt        <=  ((fsm_curr==FSM_RST_R)&(~board_rst_n_srl_cmp))?(recv_rst_cnt   +   1'b1):32'h0;
end

always@(posedge sys_clk)begin
    if(fsm_curr==FSM_RST_R)begin
        sys_rst_out_i   <=  1'b0    ;
    end
    else begin
        sys_rst_out_i   <=  1'b1    ;
    end
end


FDRE #(
      .INIT(1'b1) // Initial value of register (1'b0 or 1'b1)
   ) FDRE_RST(
    .Q  (sys_rst_out    ),      // 1-bit Data output
    .C  (sys_clk        ),      // 1-bit Clock input
    .CE (1'b1           ),    // 1-bit Clock enable input
    .R  (1'b0           ),      // 1-bit Synchronous reset input
    .D  (sys_rst_out_i  )       // 1-bit Data input
   );

endmodule
