`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/18 14:01:46
// Design Name: 
// Module Name: arbiter
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


module arbiter#(
    parameter   integer PATH_NUM    =   8       
    )(
    input   logic           clk                 ,
    input   logic           rst                 ,
    input   logic           ce                  ,
    input   logic   [PATH_NUM-1:00] app_req     ,
    output  logic   [PATH_NUM-1:00] app_grand   ,
    input   logic   [PATH_NUM-1:00] app_busy    
    );
logic   [PATH_NUM-1:00] sel_reg     ;
logic   [PATH_NUM-1:00] next_sel    ;
logic   [PATH_NUM-1:00] sel_reg_next;

typedef enum bit[02:00]{
    FSM_IDLE    =   3'b001  ,
    FSM_BUSY    =   3'b010  ,
    FSM_OVER    =   3'b100  
    }STATE_ABT_E    ;

STATE_ABT_E     fsm_curr    =   FSM_IDLE    ;
STATE_ABT_E     fsm_next    ;

always_ff@(posedge clk)begin
    if(rst==1'b1)begin
        sel_reg         <=  {{(PATH_NUM-1){1'b0}},1'b1};
        sel_reg_next    <=  {{(PATH_NUM-1){1'b0}},1'b1};
    end
    else if(ce==1'b1) begin
        if(((fsm_curr==FSM_IDLE)||((fsm_curr==FSM_OVER)&&(!(|(sel_reg&app_busy)))))&&(|(sel_reg_next&app_req)))begin
            sel_reg <=  sel_reg_next    ;
        end
        sel_reg_next    <=  next_sel    ;
    end
end

arbiter_next_sel#(
    .CH_NUM         (PATH_NUM       ) 
    )arbiter_next_sel(
    .curr_sel       (sel_reg        ),
    .curr_req       (app_req        ),
    .next_sel       (next_sel       )
    );

always_ff@(posedge clk)begin
    if(rst==1'b1)begin
        fsm_curr    <=  FSM_IDLE    ;
    end
    else if(ce==1'b1) begin
        fsm_curr    <=  fsm_next    ;
    end
end

always_comb begin
    case(fsm_curr)
        FSM_IDLE:begin
            if(|(sel_reg_next&app_req))begin
                fsm_next    =   FSM_BUSY;
            end
            else begin
                fsm_next    =   FSM_IDLE;
            end
        end
        FSM_BUSY:begin
            if(|(sel_reg&app_busy))begin
                fsm_next    =   FSM_OVER;
            end
            else begin
                fsm_next    =   FSM_BUSY;
            end
        end
        FSM_OVER:begin
            if(!(|(sel_reg&app_busy)))begin
                if(|(sel_reg_next&app_req))begin
                    fsm_next    =   FSM_BUSY;
                end
                else begin
                    fsm_next    =   FSM_IDLE;
                end
            end
            else begin
                fsm_next    =   FSM_OVER;
            end
        end
        default: begin
            fsm_next    =   FSM_IDLE;
        end
    endcase
end


assign      app_grand=(ce&((fsm_curr==FSM_IDLE)||((fsm_curr==FSM_OVER)&&(!(|(sel_reg&app_busy))))))?(sel_reg_next&app_req):{PATH_NUM{1'b0}}    ;


endmodule

