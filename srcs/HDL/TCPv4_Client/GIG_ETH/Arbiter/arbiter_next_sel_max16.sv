`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/18 15:12:28
// Design Name: 
// Module Name: arbiter_next_sel_i
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


module arbiter_next_sel#(
    parameter   CH_NUM  =   8   
    )(
    input   logic   [CH_NUM-1:00]   curr_sel    ,
    input   logic   [CH_NUM-1:00]   curr_req    ,
    output  logic   [CH_NUM-1:00]   next_sel      
    );

logic   [CH_NUM-1:00]   next_sel_i  ;


generate 
if(CH_NUM==1)begin:SEL1 

assign  next_sel    =   1'b1    ;

end
else if(CH_NUM==2)begin:SEL2

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        2'b01:begin
            casex(curr_req)
                2'b01   :   next_sel_i  =2'b01      ;
                default :   next_sel_i  =2'b10      ;
            endcase
        end
        2'b10:begin
            casex(curr_req)
                2'b10   :   next_sel_i  =2'b10      ;
                default :   next_sel_i  =2'b01      ;
            endcase
        end
        default:    next_sel_i  =   2'b01   ;
    endcase
end

end

else if(CH_NUM==3)begin:SEL3

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        3'b001:begin
            casex(curr_req)
                3'b001  :   next_sel_i  =3'b001 ;
                3'bX1X  :   next_sel_i  =3'b010 ;
                3'b10X  :   next_sel_i  =3'b100 ;
                default :   next_sel_i  =3'b010 ;
            endcase
        end
        3'b010:begin
            casex(curr_req)
                3'b010  :   next_sel_i  =3'b010 ;
                3'b1XX  :   next_sel_i  =3'b100 ;
                3'b0X1  :   next_sel_i  =3'b001 ;
                default :   next_sel_i  =3'b100 ;
            endcase
        end
        3'b100:begin
            casex(curr_req)
                3'b100  :   next_sel_i  =3'b100 ;
                3'bXX1  :   next_sel_i  =3'b001 ;
                3'bX10  :   next_sel_i  =3'b010 ;
                default :   next_sel_i  =3'b001 ;
            endcase
        end
        default:next_sel_i  =3'b001 ;
    endcase
end

end

else if(CH_NUM==4)begin:SEL4

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        4'b0001:begin
            casex(curr_req)
                4'b0001 :   next_sel_i  =4'b0001    ;
                4'bXX1X :   next_sel_i  =4'b0010    ;
                4'bX10X :   next_sel_i  =4'b0100    ;
                4'b100X :   next_sel_i  =4'b1000    ;
                default :   next_sel_i  =4'b0010    ;
            endcase
        end
        4'b0010:begin
            casex(curr_req)
                4'b0010 :   next_sel_i  =4'b0010    ;
                4'bX1XX :   next_sel_i  =4'b0100    ;
                4'b10XX :   next_sel_i  =4'b1000    ;
                4'b00X1 :   next_sel_i  =4'b0001    ;
                default :   next_sel_i  =4'b0100    ;
            endcase
        end
        4'b0100:begin
            casex(curr_req)
                4'b0100 :   next_sel_i  =4'b0100    ;
                4'b1XXX :   next_sel_i  =4'b1000    ;
                4'b0XX1 :   next_sel_i  =4'b0001    ;
                4'b0X10 :   next_sel_i  =4'b0010    ;
                default :   next_sel_i  =4'b1000    ;
            endcase
        end
        4'b1000:begin
            casex(curr_req)
                4'b1000 :   next_sel_i  =4'b1000    ;
                4'bXXX1 :   next_sel_i  =4'b0001    ;
                4'bXX10 :   next_sel_i  =4'b0010    ;
                4'bX100 :   next_sel_i  =4'b0100    ;
                default :   next_sel_i  =4'b0001    ;
            endcase
        end
        default:    next_sel_i  =4'b0001    ;
    endcase
end

end

else if(CH_NUM==5)begin:SEL5

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        5'b00001:begin
            casex(curr_req)
                5'b00001:   next_sel_i    =5'b00001 ;
                5'bXXX1X:   next_sel_i    =5'b00010 ;
                5'bXX10X:   next_sel_i    =5'b00100 ;
                5'bX100X:   next_sel_i    =5'b01000 ;
                5'b1000X:   next_sel_i    =5'b10000 ;
                default:    next_sel_i    =5'b00010 ;
            endcase
        end
        5'b00010:begin
            casex(curr_req)
                5'b00010:   next_sel_i    =5'b00010 ;
                5'bXX1XX:   next_sel_i    =5'b00100 ;
                5'bX10XX:   next_sel_i    =5'b01000 ;
                5'b100XX:   next_sel_i    =5'b10000 ;
                5'b000X1:   next_sel_i    =5'b00001 ;
                default:    next_sel_i    =5'b00100 ;
            endcase
        end
        5'b00100:begin
            casex(curr_req)
                5'b00100:   next_sel_i    =5'b00100 ;
                5'bX1XXX:   next_sel_i    =5'b01000 ;
                5'b10XXX:   next_sel_i    =5'b10000 ;
                5'b00XX1:   next_sel_i    =5'b00001 ;
                5'b00X10:   next_sel_i    =5'b00010 ;
                default:    next_sel_i    =5'b01000 ;
            endcase
        end
        5'b01000:begin
            casex(curr_req)
                5'b01000:   next_sel_i    =5'b01000 ;
                5'b1XXXX:   next_sel_i    =5'b10000 ;
                5'b0XXX1:   next_sel_i    =5'b00001 ;
                5'b0XX10:   next_sel_i    =5'b00010 ;
                5'b0X100:   next_sel_i    =5'b00100 ;
                default:    next_sel_i    =5'b10000 ;
            endcase
        end
        5'b10000:begin
            casex(curr_req)
                5'b10000:   next_sel_i    =5'b10000 ;
                5'bXXXX1:   next_sel_i    =5'b00001 ;
                5'bXXX10:   next_sel_i    =5'b00010 ;
                5'bXX100:   next_sel_i    =5'b00100 ;
                5'bX1000:   next_sel_i    =5'b01000 ;
                default:    next_sel_i    =5'b00001 ;
            endcase
        end
        default:    next_sel_i  =5'b00001   ;
    endcase
end

end

else if(CH_NUM==6)begin:SEL6

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        6'b000001:begin
            casex(curr_req)
                6'b000001   :next_sel_i   =6'b000001    ;
                6'bXXXX1X   :next_sel_i   =6'b000010    ;
                6'bXXX10X   :next_sel_i   =6'b000100    ;
                6'bXX100X   :next_sel_i   =6'b001000    ;
                6'bX1000X   :next_sel_i   =6'b010000    ;
                6'b10000X   :next_sel_i   =6'b100000    ;
                default     :next_sel_i   =6'b000010    ;
            endcase
        end
        6'b000010:begin
            casex(curr_req)
                6'b000010   :next_sel_i   =6'b000010    ;
                6'bXXX1XX   :next_sel_i   =6'b000100    ;
                6'bXX10XX   :next_sel_i   =6'b001000    ;
                6'bX100XX   :next_sel_i   =6'b010000    ;
                6'b1000XX   :next_sel_i   =6'b100000    ;
                6'b0000X1   :next_sel_i   =6'b000001    ;
                default     :next_sel_i   =6'b000100    ;
            endcase
        end
        6'b000100:begin
            casex(curr_req)
                6'b000100   :next_sel_i   =6'b000100    ;
                6'bXX1XXX   :next_sel_i   =6'b001000    ;
                6'bX10XXX   :next_sel_i   =6'b010000    ;
                6'b100XXX   :next_sel_i   =6'b100000    ;
                6'b000XX1   :next_sel_i   =6'b000001    ;
                6'b000X10   :next_sel_i   =6'b000010    ;
                default     :next_sel_i   =6'b001000    ;
            endcase
        end
        6'b001000:begin
            casex(curr_req)
                6'b001000   :next_sel_i   =6'b001000    ;
                6'bX1XXXX   :next_sel_i   =6'b010000    ;
                6'b10XXXX   :next_sel_i   =6'b100000    ;
                6'b00XXX1   :next_sel_i   =6'b000001    ;
                6'b00XX10   :next_sel_i   =6'b000010    ;
                6'b00X100   :next_sel_i   =6'b000100    ;
                default     :next_sel_i   =6'b010000    ;
            endcase
        end
        6'b010000:begin
            casex(curr_req)
                6'b010000   :next_sel_i   =6'b010000    ;
                6'b1XXXXX   :next_sel_i   =6'b100000    ;
                6'b0XXXX1   :next_sel_i   =6'b000001    ;
                6'b0XXX10   :next_sel_i   =6'b000010    ;
                6'b0XX100   :next_sel_i   =6'b000100    ;
                6'b0X1000   :next_sel_i   =6'b001000    ;
                default     :next_sel_i   =6'b100000    ;
            endcase
        end
        6'b100000:begin
            casex(curr_req)
                6'b100000   :next_sel_i   =6'b100000    ;
                6'bXXXXX1   :next_sel_i   =6'b000001    ;
                6'bXXXX10   :next_sel_i   =6'b000010    ;
                6'bXXX100   :next_sel_i   =6'b000100    ;
                6'bXX1000   :next_sel_i   =6'b001000    ;
                6'bX10000   :next_sel_i   =6'b010000    ;
                default     :next_sel_i   =6'b000001    ;
            endcase
        end
        default:next_sel_i  =6'b000001  ;
    endcase
end

end

else if(CH_NUM==7)begin:SEL7

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        7'b0000001:begin
            casex(curr_req)
                7'b0000001  :next_sel_i   =7'b0000001   ;
                7'bXXXXX1X  :next_sel_i   =7'b0000010   ;
                7'bXXXX10X  :next_sel_i   =7'b0000100   ;
                7'bXXX100X  :next_sel_i   =7'b0001000   ;
                7'bXX1000X  :next_sel_i   =7'b0010000   ;
                7'bX10000X  :next_sel_i   =7'b0100000   ;
                7'b100000X  :next_sel_i   =7'b1000000   ;
                default     :next_sel_i   =7'b0000010   ;
            endcase
        end
        7'b0000010:begin
            casex(curr_req)
                7'b0000010  :next_sel_i   =7'b0000010   ;
                7'bXXXX1XX  :next_sel_i   =7'b0000100   ;
                7'bXXX10XX  :next_sel_i   =7'b0001000   ;
                7'bXX100XX  :next_sel_i   =7'b0010000   ;
                7'bX1000XX  :next_sel_i   =7'b0100000   ;
                7'b10000XX  :next_sel_i   =7'b1000000   ;
                7'b00000X1  :next_sel_i   =7'b0000001   ;
                default     :next_sel_i   =7'b0000100   ;
            endcase
        end
        7'b0000100:begin
            casex(curr_req)
                7'b0000100  :next_sel_i   =7'b0000100   ;
                7'bXXX1XXX  :next_sel_i   =7'b0001000   ;
                7'bXX10XXX  :next_sel_i   =7'b0010000   ;
                7'bX100XXX  :next_sel_i   =7'b0100000   ;
                7'b1000XXX  :next_sel_i   =7'b1000000   ;
                7'b0000XX1  :next_sel_i   =7'b0000001   ;
                7'b0000X10  :next_sel_i   =7'b0000010   ;
                default     :next_sel_i   =7'b0001000   ;
            endcase
        end
        7'b0001000:begin
            casex(curr_req)
                7'b0001000  :next_sel_i   =7'b0001000   ;
                7'bXX1XXXX  :next_sel_i   =7'b0010000   ;
                7'bX10XXXX  :next_sel_i   =7'b0100000   ;
                7'b100XXXX  :next_sel_i   =7'b1000000   ;
                7'b000XXX1  :next_sel_i   =7'b0000001   ;
                7'b000XX10  :next_sel_i   =7'b0000010   ;
                7'b000X100  :next_sel_i   =7'b0000100   ;
                default     :next_sel_i   =7'b0010000   ;
            endcase
        end
        7'b0010000:begin
            casex(curr_req)
                7'b0010000  :next_sel_i   =7'b0010000   ;
                7'bX1XXXXX  :next_sel_i   =7'b0100000   ;
                7'b10XXXXX  :next_sel_i   =7'b1000000   ;
                7'b00XXXX1  :next_sel_i   =7'b0000001   ;
                7'b00XXX10  :next_sel_i   =7'b0000010   ;
                7'b00XX100  :next_sel_i   =7'b0000100   ;
                7'b00X1000  :next_sel_i   =7'b0001000   ;
                default     :next_sel_i   =7'b0100000   ;
            endcase
        end
        7'b0100000:begin
            casex(curr_req)
                7'b0100000  :next_sel_i   =7'b0100000   ;
                7'b1XXXXXX  :next_sel_i   =7'b1000000   ;
                7'b0XXXXX1  :next_sel_i   =7'b0000001   ;
                7'b0XXXX10  :next_sel_i   =7'b0000010   ;
                7'b0XXX100  :next_sel_i   =7'b0000100   ;
                7'b0XX1000  :next_sel_i   =7'b0001000   ;
                7'b0X10000  :next_sel_i   =7'b0010000   ;
                default     :next_sel_i   =7'b1000000   ;
            endcase
        end
        7'b1000000:begin
            casex(curr_req)
                7'b1000000  :next_sel_i   =7'b1000000;
                7'bXXXXXX1  :next_sel_i   =7'b0000001;
                7'bXXXXX10  :next_sel_i   =7'b0000010;
                7'bXXXX100  :next_sel_i   =7'b0000100;
                7'bXXX1000  :next_sel_i   =7'b0001000;
                7'bXX10000  :next_sel_i   =7'b0010000;
                7'bX100000  :next_sel_i   =7'b0100000;
                default     :next_sel_i   =7'b0000001;
            endcase
        end
        default:next_sel_i=7'b0000001;
    endcase
end

end

else if(CH_NUM==8)begin:SEL8

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        8'b00000001:begin
            casex(curr_req)
                8'b00000001 :next_sel_i   =8'b00000001;
                8'bXXXXXX1X :next_sel_i   =8'b00000010;
                8'bXXXXX10X :next_sel_i   =8'b00000100;
                8'bXXXX100X :next_sel_i   =8'b00001000;
                8'bXXX1000X :next_sel_i   =8'b00010000;
                8'bXX10000X :next_sel_i   =8'b00100000;
                8'bX100000X :next_sel_i   =8'b01000000;
                8'b1000000X :next_sel_i   =8'b10000000;
                default     :next_sel_i   =8'b00000010;
            endcase
        end
        8'b00000010:begin
            casex(curr_req)
                8'b00000010 :next_sel_i   =8'b00000010;
                8'bXXXXX1XX :next_sel_i   =8'b00000100;
                8'bXXXX10XX :next_sel_i   =8'b00001000;
                8'bXXX100XX :next_sel_i   =8'b00010000;
                8'bXX1000XX :next_sel_i   =8'b00100000;
                8'bX10000XX :next_sel_i   =8'b01000000;
                8'b100000XX :next_sel_i   =8'b10000000;
                8'b000000X1 :next_sel_i   =8'b00000001;
                default     :next_sel_i   =8'b00000100;
            endcase
        end
        8'b00000100:begin
            casex(curr_req)
                8'b00000100 :next_sel_i   =8'b00000100;
                8'bXXXX1XXX :next_sel_i   =8'b00001000;
                8'bXXX10XXX :next_sel_i   =8'b00010000;
                8'bXX100XXX :next_sel_i   =8'b00100000;
                8'bX1000XXX :next_sel_i   =8'b01000000;
                8'b10000XXX :next_sel_i   =8'b10000000;
                8'b00000XX1 :next_sel_i   =8'b00000001;
                8'b00000X10 :next_sel_i   =8'b00000010;
                default     :next_sel_i   =8'b00001000;
            endcase
        end
        8'b00001000:begin
            casex(curr_req)
                8'b00001000 :next_sel_i   =8'b00001000;
                8'bXXX1XXXX :next_sel_i   =8'b00010000;
                8'bXX10XXXX :next_sel_i   =8'b00100000;
                8'bX100XXXX :next_sel_i   =8'b01000000;
                8'b1000XXXX :next_sel_i   =8'b10000000;
                8'b0000XXX1 :next_sel_i   =8'b00000001;
                8'b0000XX10 :next_sel_i   =8'b00000010;
                8'b0000X100 :next_sel_i   =8'b00000100;
                default     :next_sel_i   =8'b00010000;
            endcase
        end
        8'b00010000:begin
            casex(curr_req)
                8'b00010000 :next_sel_i   =8'b00010000;
                8'bXX1XXXXX :next_sel_i   =8'b00100000;
                8'bX10XXXXX :next_sel_i   =8'b01000000;
                8'b100XXXXX :next_sel_i   =8'b10000000;
                8'b000XXXX1 :next_sel_i   =8'b00000001;
                8'b000XXX10 :next_sel_i   =8'b00000010;
                8'b000XX100 :next_sel_i   =8'b00000100;
                8'b000X1000 :next_sel_i   =8'b00001000;
                default     :next_sel_i   =8'b00100000;
            endcase
        end
        8'b00100000:begin
            casex(curr_req)
                8'b00100000 :next_sel_i   =8'b00100000;
                8'bX1XXXXXX :next_sel_i   =8'b01000000;
                8'b10XXXXXX :next_sel_i   =8'b10000000;
                8'b00XXXXX1 :next_sel_i   =8'b00000001;
                8'b00XXXX10 :next_sel_i   =8'b00000010;
                8'b00XXX100 :next_sel_i   =8'b00000100;
                8'b00XX1000 :next_sel_i   =8'b00001000;
                8'b00X10000 :next_sel_i   =8'b00010000;
                default     :next_sel_i   =8'b01000000;
            endcase
        end
        8'b01000000:begin
            casex(curr_req)
                8'b01000000 :next_sel_i   =8'b01000000;
                8'b1XXXXXXX :next_sel_i   =8'b10000000;
                8'b0XXXXXX1 :next_sel_i   =8'b00000001;
                8'b0XXXXX10 :next_sel_i   =8'b00000010;
                8'b0XXXX100 :next_sel_i   =8'b00000100;
                8'b0XXX1000 :next_sel_i   =8'b00001000;
                8'b0XX10000 :next_sel_i   =8'b00010000;
                8'b0X100000 :next_sel_i   =8'b00100000;
                default     :next_sel_i   =8'b10000000;
            endcase
        end
        8'b10000000:begin
            casex(curr_req)
                8'b10000000 :next_sel_i   =8'b10000000;
                8'bXXXXXXX1 :next_sel_i   =8'b00000001;
                8'bXXXXXX10 :next_sel_i   =8'b00000010;
                8'bXXXXX100 :next_sel_i   =8'b00000100;
                8'bXXXX1000 :next_sel_i   =8'b00001000;
                8'bXXX10000 :next_sel_i   =8'b00010000;
                8'bXX100000 :next_sel_i   =8'b00100000;
                8'bX1000000 :next_sel_i   =8'b01000000;
                default     :next_sel_i   =8'b00000001;
            endcase
        end
        default:next_sel_i=8'b00000001;
    endcase
end

end

else if(CH_NUM==9)begin:SEL9

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        9'b000000001:begin
            casex(curr_req)
                9'b000000001    :next_sel_i   =9'b000000001;
                9'bXXXXXXX1X    :next_sel_i   =9'b000000010;
                9'bXXXXXX10X    :next_sel_i   =9'b000000100;
                9'bXXXXX100X    :next_sel_i   =9'b000001000;
                9'bXXXX1000X    :next_sel_i   =9'b000010000;
                9'bXXX10000X    :next_sel_i   =9'b000100000;
                9'bXX100000X    :next_sel_i   =9'b001000000;
                9'bX1000000X    :next_sel_i   =9'b010000000;
                9'b10000000X    :next_sel_i   =9'b100000000;
                default         :next_sel_i   =9'b000000010;
            endcase
        end
        9'b000000010:begin
            casex(curr_req)
                9'b000000010    :next_sel_i   =9'b000000010;
                9'bXXXXXX1XX    :next_sel_i   =9'b000000100;
                9'bXXXXX10XX    :next_sel_i   =9'b000001000;
                9'bXXXX100XX    :next_sel_i   =9'b000010000;
                9'bXXX1000XX    :next_sel_i   =9'b000100000;
                9'bXX10000XX    :next_sel_i   =9'b001000000;
                9'bX100000XX    :next_sel_i   =9'b010000000;
                9'b1000000XX    :next_sel_i   =9'b100000000;
                9'b0000000X1    :next_sel_i   =9'b000000001;
                default         :next_sel_i   =9'b000000100;
            endcase
        end
        9'b000000100:begin
            casex(curr_req)
                9'b000000100    :next_sel_i   =9'b000000100;
                9'bXXXXX1XXX    :next_sel_i   =9'b000001000;
                9'bXXXX10XXX    :next_sel_i   =9'b000010000;
                9'bXXX100XXX    :next_sel_i   =9'b000100000;
                9'bXX1000XXX    :next_sel_i   =9'b001000000;
                9'bX10000XXX    :next_sel_i   =9'b010000000;
                9'b100000XXX    :next_sel_i   =9'b100000000;
                9'b000000XX1    :next_sel_i   =9'b000000001;
                9'b000000X10    :next_sel_i   =9'b000000010;
                default         :next_sel_i   =9'b000001000;
            endcase
        end
        9'b000001000:begin
            casex(curr_req)
                9'b000001000    :next_sel_i   =9'b000001000;
                9'bXXXX1XXXX    :next_sel_i   =9'b000010000;
                9'bXXX10XXXX    :next_sel_i   =9'b000100000;
                9'bXX100XXXX    :next_sel_i   =9'b001000000;
                9'bX1000XXXX    :next_sel_i   =9'b010000000;
                9'b10000XXXX    :next_sel_i   =9'b100000000;
                9'b00000XXX1    :next_sel_i   =9'b000000001;
                9'b00000XX10    :next_sel_i   =9'b000000010;
                9'b00000X100    :next_sel_i   =9'b000000100;
                default         :next_sel_i   =9'b000010000;
            endcase
        end
        9'b000010000:begin
            casex(curr_req)
                9'b000010000    :next_sel_i   =9'b000010000;
                9'bXXX1XXXXX    :next_sel_i   =9'b000100000;
                9'bXX10XXXXX    :next_sel_i   =9'b001000000;
                9'bX100XXXXX    :next_sel_i   =9'b010000000;
                9'b1000XXXXX    :next_sel_i   =9'b100000000;
                9'b0000XXXX1    :next_sel_i   =9'b000000001;
                9'b0000XXX10    :next_sel_i   =9'b000000010;
                9'b0000XX100    :next_sel_i   =9'b000000100;
                9'b0000X1000    :next_sel_i   =9'b000001000;
                default         :next_sel_i   =9'b000100000;
            endcase
        end
        9'b000100000:begin
            casex(curr_req)
                9'b000100000    :next_sel_i   =9'b000100000;
                9'bXX1XXXXXX    :next_sel_i   =9'b001000000;
                9'bX10XXXXXX    :next_sel_i   =9'b010000000;
                9'b100XXXXXX    :next_sel_i   =9'b100000000;
                9'b000XXXXX1    :next_sel_i   =9'b000000001;
                9'b000XXXX10    :next_sel_i   =9'b000000010;
                9'b000XXX100    :next_sel_i   =9'b000000100;
                9'b000XX1000    :next_sel_i   =9'b000001000;
                9'b000X10000    :next_sel_i   =9'b000010000;
                default         :next_sel_i   =9'b001000000;
            endcase
        end
        9'b001000000:begin
            casex(curr_req)
                9'b001000000    :next_sel_i   =9'b001000000;
                9'bX1XXXXXXX    :next_sel_i   =9'b010000000;
                9'b10XXXXXXX    :next_sel_i   =9'b100000000;
                9'b00XXXXXX1    :next_sel_i   =9'b000000001;
                9'b00XXXXX10    :next_sel_i   =9'b000000010;
                9'b00XXXX100    :next_sel_i   =9'b000000100;
                9'b00XXX1000    :next_sel_i   =9'b000001000;
                9'b00XX10000    :next_sel_i   =9'b000010000;
                9'b00X100000    :next_sel_i   =9'b000100000;
                default         :next_sel_i   =9'b010000000;
            endcase
        end
        9'b010000000:begin
            casex(curr_req)
                9'b010000000    :next_sel_i   =9'b010000000;
                9'b1XXXXXXXX    :next_sel_i   =9'b100000000;
                9'b0XXXXXXX1    :next_sel_i   =9'b000000001;
                9'b0XXXXXX10    :next_sel_i   =9'b000000010;
                9'b0XXXXX100    :next_sel_i   =9'b000000100;
                9'b0XXXX1000    :next_sel_i   =9'b000001000;
                9'b0XXX10000    :next_sel_i   =9'b000010000;
                9'b0XX100000    :next_sel_i   =9'b000100000;
                9'b0X1000000    :next_sel_i   =9'b001000000;
                default         :next_sel_i   =9'b100000000;
            endcase
        end
        9'b100000000:begin
            casex(curr_req)
                9'b100000000    :next_sel_i   =9'b100000000;
                9'bXXXXXXXX1    :next_sel_i   =9'b000000001;
                9'bXXXXXXX10    :next_sel_i   =9'b000000010;
                9'bXXXXXX100    :next_sel_i   =9'b000000100;
                9'bXXXXX1000    :next_sel_i   =9'b000001000;
                9'bXXXX10000    :next_sel_i   =9'b000010000;
                9'bXXX100000    :next_sel_i   =9'b000100000;
                9'bXX1000000    :next_sel_i   =9'b001000000;
                9'bX10000000    :next_sel_i   =9'b010000000;
                default         :next_sel_i   =9'b000000001;
            endcase
        end
        default:next_sel_i=9'b000000001;
    endcase
end

end

else if(CH_NUM==10)begin:SEL10

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        10'b0000000001:begin
            casex(curr_req)
                10'b0000000001  :next_sel_i   =10'b0000000001;
                10'bXXXXXXXX1X  :next_sel_i   =10'b0000000010;
                10'bXXXXXXX10X  :next_sel_i   =10'b0000000100;
                10'bXXXXXX100X  :next_sel_i   =10'b0000001000;
                10'bXXXXX1000X  :next_sel_i   =10'b0000010000;
                10'bXXXX10000X  :next_sel_i   =10'b0000100000;
                10'bXXX100000X  :next_sel_i   =10'b0001000000;
                10'bXX1000000X  :next_sel_i   =10'b0010000000;
                10'bX10000000X  :next_sel_i   =10'b0100000000;
                10'b100000000X  :next_sel_i   =10'b1000000000;
                default         :next_sel_i   =10'b0000000010;
            endcase
        end
        10'b0000000010:begin
            casex(curr_req)
                10'b0000000010  :next_sel_i   =10'b0000000010;
                10'bXXXXXXX1XX  :next_sel_i   =10'b0000000100;
                10'bXXXXXX10XX  :next_sel_i   =10'b0000001000;
                10'bXXXXX100XX  :next_sel_i   =10'b0000010000;
                10'bXXXX1000XX  :next_sel_i   =10'b0000100000;
                10'bXXX10000XX  :next_sel_i   =10'b0001000000;
                10'bXX100000XX  :next_sel_i   =10'b0010000000;
                10'bX1000000XX  :next_sel_i   =10'b0100000000;
                10'b10000000XX  :next_sel_i   =10'b1000000000;
                10'b00000000X1  :next_sel_i   =10'b0000000001;
                default         :next_sel_i   =10'b0000000100;
            endcase
        end
        10'b0000000100:begin
            casex(curr_req)
                10'b0000000100  :next_sel_i   =10'b0000000100;
                10'bXXXXXX1XXX  :next_sel_i   =10'b0000001000;
                10'bXXXXX10XXX  :next_sel_i   =10'b0000010000;
                10'bXXXX100XXX  :next_sel_i   =10'b0000100000;
                10'bXXX1000XXX  :next_sel_i   =10'b0001000000;
                10'bXX10000XXX  :next_sel_i   =10'b0010000000;
                10'bX100000XXX  :next_sel_i   =10'b0100000000;
                10'b1000000XXX  :next_sel_i   =10'b1000000000;
                10'b0000000XX1  :next_sel_i   =10'b0000000001;
                10'b0000000X10  :next_sel_i   =10'b0000000010;
                default         :next_sel_i   =10'b0000001000;
            endcase
        end
        10'b0000001000:begin
            casex(curr_req)
                10'b0000001000  :next_sel_i   =10'b0000001000;
                10'bXXXXX1XXXX  :next_sel_i   =10'b0000010000;
                10'bXXXX10XXXX  :next_sel_i   =10'b0000100000;
                10'bXXX100XXXX  :next_sel_i   =10'b0001000000;
                10'bXX1000XXXX  :next_sel_i   =10'b0010000000;
                10'bX10000XXXX  :next_sel_i   =10'b0100000000;
                10'b100000XXXX  :next_sel_i   =10'b1000000000;
                10'b000000XXX1  :next_sel_i   =10'b0000000001;
                10'b000000XX10  :next_sel_i   =10'b0000000010;
                10'b000000X100  :next_sel_i   =10'b0000000100;
                default         :next_sel_i   =10'b0000010000;
            endcase
        end
        10'b0000010000:begin
            casex(curr_req)
                10'b0000010000  :next_sel_i   =10'b0000010000;
                10'bXXXX1XXXXX  :next_sel_i   =10'b0000100000;
                10'bXXX10XXXXX  :next_sel_i   =10'b0001000000;
                10'bXX100XXXXX  :next_sel_i   =10'b0010000000;
                10'bX1000XXXXX  :next_sel_i   =10'b0100000000;
                10'b10000XXXXX  :next_sel_i   =10'b1000000000;
                10'b00000XXXX1  :next_sel_i   =10'b0000000001;
                10'b00000XXX10  :next_sel_i   =10'b0000000010;
                10'b00000XX100  :next_sel_i   =10'b0000000100;
                10'b00000X1000  :next_sel_i   =10'b0000001000;
                default         :next_sel_i   =10'b0000100000;
            endcase
        end
        10'b0000100000:begin
            casex(curr_req)
                10'b0000100000  :next_sel_i   =10'b0000100000;
                10'bXXX1XXXXXX  :next_sel_i   =10'b0001000000;
                10'bXX10XXXXXX  :next_sel_i   =10'b0010000000;
                10'bX100XXXXXX  :next_sel_i   =10'b0100000000;
                10'b1000XXXXXX  :next_sel_i   =10'b1000000000;
                10'b0000XXXXX1  :next_sel_i   =10'b0000000001;
                10'b0000XXXX10  :next_sel_i   =10'b0000000010;
                10'b0000XXX100  :next_sel_i   =10'b0000000100;
                10'b0000XX1000  :next_sel_i   =10'b0000001000;
                10'b0000X10000  :next_sel_i   =10'b0000010000;
                default         :next_sel_i   =10'b0001000000;
            endcase
        end
        10'b0001000000:begin
            casex(curr_req)
                10'b0001000000  :next_sel_i   =10'b0001000000;
                10'bXX1XXXXXXX  :next_sel_i   =10'b0010000000;
                10'bX10XXXXXXX  :next_sel_i   =10'b0100000000;
                10'b100XXXXXXX  :next_sel_i   =10'b1000000000;
                10'b000XXXXXX1  :next_sel_i   =10'b0000000001;
                10'b000XXXXX10  :next_sel_i   =10'b0000000010;
                10'b000XXXX100  :next_sel_i   =10'b0000000100;
                10'b000XXX1000  :next_sel_i   =10'b0000001000;
                10'b000XX10000  :next_sel_i   =10'b0000010000;
                10'b000X100000  :next_sel_i   =10'b0000100000;
                default         :next_sel_i   =10'b0010000000;
            endcase
        end
        10'b0010000000:begin
            casex(curr_req)
                10'b0010000000  :next_sel_i   =10'b0010000000;
                10'bX1XXXXXXXX  :next_sel_i   =10'b0100000000;
                10'b10XXXXXXXX  :next_sel_i   =10'b1000000000;
                10'b00XXXXXXX1  :next_sel_i   =10'b0000000001;
                10'b00XXXXXX10  :next_sel_i   =10'b0000000010;
                10'b00XXXXX100  :next_sel_i   =10'b0000000100;
                10'b00XXXX1000  :next_sel_i   =10'b0000001000;
                10'b00XXX10000  :next_sel_i   =10'b0000010000;
                10'b00XX100000  :next_sel_i   =10'b0000100000;
                10'b00X1000000  :next_sel_i   =10'b0001000000;
                default         :next_sel_i   =10'b0100000000;
            endcase
        end
        10'b0100000000:begin
            casex(curr_req)
                10'b0100000000  :next_sel_i   =10'b0100000000;
                10'b1XXXXXXXXX  :next_sel_i   =10'b1000000000;
                10'b0XXXXXXXX1  :next_sel_i   =10'b0000000001;
                10'b0XXXXXXX10  :next_sel_i   =10'b0000000010;
                10'b0XXXXXX100  :next_sel_i   =10'b0000000100;
                10'b0XXXXX1000  :next_sel_i   =10'b0000001000;
                10'b0XXXX10000  :next_sel_i   =10'b0000010000;
                10'b0XXX100000  :next_sel_i   =10'b0000100000;
                10'b0XX1000000  :next_sel_i   =10'b0001000000;
                10'b0X10000000  :next_sel_i   =10'b0010000000;
                default         :next_sel_i   =10'b1000000000;
            endcase
        end
        10'b1000000000:begin
            casex(curr_req)
                10'b1000000000  :next_sel_i   =10'b1000000000;
                10'bXXXXXXXXX1  :next_sel_i   =10'b0000000001;
                10'bXXXXXXXX10  :next_sel_i   =10'b0000000010;
                10'bXXXXXXX100  :next_sel_i   =10'b0000000100;
                10'bXXXXXX1000  :next_sel_i   =10'b0000001000;
                10'bXXXXX10000  :next_sel_i   =10'b0000010000;
                10'bXXXX100000  :next_sel_i   =10'b0000100000;
                10'bXXX1000000  :next_sel_i   =10'b0001000000;
                10'bXX10000000  :next_sel_i   =10'b0010000000;
                10'bX100000000  :next_sel_i   =10'b0100000000;
                default         :next_sel_i   =10'b0000000001;
            endcase
        end
        default:next_sel_i=10'b0000000001;
    endcase
end

end

else if(CH_NUM==11)begin:SEL11

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        11'b00000000001:begin
            casex(curr_req)
                11'b00000000001  :next_sel_i   =11'b00000000001;
                11'bXXXXXXXXX1X  :next_sel_i   =11'b00000000010;
                11'bXXXXXXXX10X  :next_sel_i   =11'b00000000100;
                11'bXXXXXXX100X  :next_sel_i   =11'b00000001000;
                11'bXXXXXX1000X  :next_sel_i   =11'b00000010000;
                11'bXXXXX10000X  :next_sel_i   =11'b00000100000;
                11'bXXXX100000X  :next_sel_i   =11'b00001000000;
                11'bXXX1000000X  :next_sel_i   =11'b00010000000;
                11'bXX10000000X  :next_sel_i   =11'b00100000000;
                11'bX100000000X  :next_sel_i   =11'b01000000000;
                11'b1000000000X  :next_sel_i   =11'b10000000000;
                default          :next_sel_i   =11'b00000000010;
            endcase
        end
        11'b00000000010:begin
            casex(curr_req)
                11'b00000000010  :next_sel_i   =11'b00000000010;
                11'bXXXXXXXX1XX  :next_sel_i   =11'b00000000100;
                11'bXXXXXXX10XX  :next_sel_i   =11'b00000001000;
                11'bXXXXXX100XX  :next_sel_i   =11'b00000010000;
                11'bXXXXX1000XX  :next_sel_i   =11'b00000100000;
                11'bXXXX10000XX  :next_sel_i   =11'b00001000000;
                11'bXXX100000XX  :next_sel_i   =11'b00010000000;
                11'bXX1000000XX  :next_sel_i   =11'b00100000000;
                11'bX10000000XX  :next_sel_i   =11'b01000000000;
                11'b100000000XX  :next_sel_i   =11'b10000000000;
                11'b000000000X1  :next_sel_i   =11'b00000000001;
                default          :next_sel_i   =11'b00000000100;
            endcase
        end
        11'b00000000100:begin
            casex(curr_req)
                11'b00000000100  :next_sel_i   =11'b00000000100;
                11'bXXXXXXX1XXX  :next_sel_i   =11'b00000001000;
                11'bXXXXXX10XXX  :next_sel_i   =11'b00000010000;
                11'bXXXXX100XXX  :next_sel_i   =11'b00000100000;
                11'bXXXX1000XXX  :next_sel_i   =11'b00001000000;
                11'bXXX10000XXX  :next_sel_i   =11'b00010000000;
                11'bXX100000XXX  :next_sel_i   =11'b00100000000;
                11'bX1000000XXX  :next_sel_i   =11'b01000000000;
                11'b10000000XXX  :next_sel_i   =11'b10000000000;
                11'b00000000XX1  :next_sel_i   =11'b00000000001;
                11'b00000000X10  :next_sel_i   =11'b00000000010;
                default          :next_sel_i   =11'b00000001000;
            endcase
        end
        11'b00000001000:begin
            casex(curr_req)
                11'b00000001000  :next_sel_i   =11'b00000001000;
                11'bXXXXXX1XXXX  :next_sel_i   =11'b00000010000;
                11'bXXXXX10XXXX  :next_sel_i   =11'b00000100000;
                11'bXXXX100XXXX  :next_sel_i   =11'b00001000000;
                11'bXXX1000XXXX  :next_sel_i   =11'b00010000000;
                11'bXX10000XXXX  :next_sel_i   =11'b00100000000;
                11'bX100000XXXX  :next_sel_i   =11'b01000000000;
                11'b1000000XXXX  :next_sel_i   =11'b10000000000;
                11'b0000000XXX1  :next_sel_i   =11'b00000000001;
                11'b0000000XX10  :next_sel_i   =11'b00000000010;
                11'b0000000X100  :next_sel_i   =11'b00000000100;
                default          :next_sel_i   =11'b00000010000;
            endcase
        end
        11'b00000010000:begin
            casex(curr_req)
                11'b00000010000  :next_sel_i   =11'b00000010000;
                11'bXXXXX1XXXXX  :next_sel_i   =11'b00000100000;
                11'bXXXX10XXXXX  :next_sel_i   =11'b00001000000;
                11'bXXX100XXXXX  :next_sel_i   =11'b00010000000;
                11'bXX1000XXXXX  :next_sel_i   =11'b00100000000;
                11'bX10000XXXXX  :next_sel_i   =11'b01000000000;
                11'b100000XXXXX  :next_sel_i   =11'b10000000000;
                11'b000000XXXX1  :next_sel_i   =11'b00000000001;
                11'b000000XXX10  :next_sel_i   =11'b00000000010;
                11'b000000XX100  :next_sel_i   =11'b00000000100;
                11'b000000X1000  :next_sel_i   =11'b00000001000;
                default          :next_sel_i   =11'b00000100000;
            endcase
        end
        11'b00000100000:begin
            casex(curr_req)
                11'b00000100000  :next_sel_i   =11'b00000100000;
                11'bXXXX1XXXXXX  :next_sel_i   =11'b00001000000;
                11'bXXX10XXXXXX  :next_sel_i   =11'b00010000000;
                11'bXX100XXXXXX  :next_sel_i   =11'b00100000000;
                11'bX1000XXXXXX  :next_sel_i   =11'b01000000000;
                11'b10000XXXXXX  :next_sel_i   =11'b10000000000;
                11'b00000XXXXX1  :next_sel_i   =11'b00000000001;
                11'b00000XXXX10  :next_sel_i   =11'b00000000010;
                11'b00000XXX100  :next_sel_i   =11'b00000000100;
                11'b00000XX1000  :next_sel_i   =11'b00000001000;
                11'b00000X10000  :next_sel_i   =11'b00000010000;
                default          :next_sel_i   =11'b00001000000;
            endcase
        end
        11'b00001000000:begin
            casex(curr_req)
                11'b00001000000  :next_sel_i   =11'b00001000000;
                11'bXXX1XXXXXXX  :next_sel_i   =11'b00010000000;
                11'bXX10XXXXXXX  :next_sel_i   =11'b00100000000;
                11'bX100XXXXXXX  :next_sel_i   =11'b01000000000;
                11'b1000XXXXXXX  :next_sel_i   =11'b10000000000;
                11'b0000XXXXXX1  :next_sel_i   =11'b00000000001;
                11'b0000XXXXX10  :next_sel_i   =11'b00000000010;
                11'b0000XXXX100  :next_sel_i   =11'b00000000100;
                11'b0000XXX1000  :next_sel_i   =11'b00000001000;
                11'b0000XX10000  :next_sel_i   =11'b00000010000;
                11'b0000X100000  :next_sel_i   =11'b00000100000;
                default          :next_sel_i   =11'b00010000000;
            endcase
        end
        11'b00010000000:begin
            casex(curr_req)
                11'b00010000000  :next_sel_i   =11'b00010000000;
                11'bXX1XXXXXXXX  :next_sel_i   =11'b00100000000;
                11'bX10XXXXXXXX  :next_sel_i   =11'b01000000000;
                11'b100XXXXXXXX  :next_sel_i   =11'b10000000000;
                11'b000XXXXXXX1  :next_sel_i   =11'b00000000001;
                11'b000XXXXXX10  :next_sel_i   =11'b00000000010;
                11'b000XXXXX100  :next_sel_i   =11'b00000000100;
                11'b000XXXX1000  :next_sel_i   =11'b00000001000;
                11'b000XXX10000  :next_sel_i   =11'b00000010000;
                11'b000XX100000  :next_sel_i   =11'b00000100000;
                11'b000X1000000  :next_sel_i   =11'b00001000000;
                default          :next_sel_i   =11'b00100000000;
            endcase
        end
        11'b00100000000:begin
            casex(curr_req)
                11'b00100000000  :next_sel_i   =11'b00100000000;
                11'bX1XXXXXXXXX  :next_sel_i   =11'b01000000000;
                11'b10XXXXXXXXX  :next_sel_i   =11'b10000000000;
                11'b00XXXXXXXX1  :next_sel_i   =11'b00000000001;
                11'b00XXXXXXX10  :next_sel_i   =11'b00000000010;
                11'b00XXXXXX100  :next_sel_i   =11'b00000000100;
                11'b00XXXXX1000  :next_sel_i   =11'b00000001000;
                11'b00XXXX10000  :next_sel_i   =11'b00000010000;
                11'b00XXX100000  :next_sel_i   =11'b00000100000;
                11'b00XX1000000  :next_sel_i   =11'b00001000000;
                11'b00X10000000  :next_sel_i   =11'b00010000000;
                default          :next_sel_i   =11'b01000000000;
            endcase
        end
        11'b01000000000:begin
            casex(curr_req)
                11'b01000000000  :next_sel_i   =11'b01000000000;
                11'b1XXXXXXXXXX  :next_sel_i   =11'b10000000000;
                11'b0XXXXXXXXX1  :next_sel_i   =11'b00000000001;
                11'b0XXXXXXXX10  :next_sel_i   =11'b00000000010;
                11'b0XXXXXXX100  :next_sel_i   =11'b00000000100;
                11'b0XXXXXX1000  :next_sel_i   =11'b00000001000;
                11'b0XXXXX10000  :next_sel_i   =11'b00000010000;
                11'b0XXXX100000  :next_sel_i   =11'b00000100000;
                11'b0XXX1000000  :next_sel_i   =11'b00001000000;
                11'b0XX10000000  :next_sel_i   =11'b00010000000;
                11'b0X100000000  :next_sel_i   =11'b00100000000;
                default          :next_sel_i   =11'b10000000000;
            endcase
        end
        11'b10000000000:begin
            casex(curr_req)
                11'b10000000000  :next_sel_i   =11'b10000000000;
                11'bXXXXXXXXXX1  :next_sel_i   =11'b00000000001;
                11'bXXXXXXXXX10  :next_sel_i   =11'b00000000010;
                11'bXXXXXXXX100  :next_sel_i   =11'b00000000100;
                11'bXXXXXXX1000  :next_sel_i   =11'b00000001000;
                11'bXXXXXX10000  :next_sel_i   =11'b00000010000;
                11'bXXXXX100000  :next_sel_i   =11'b00000100000;
                11'bXXXX1000000  :next_sel_i   =11'b00001000000;
                11'bXXX10000000  :next_sel_i   =11'b00010000000;
                11'bXX100000000  :next_sel_i   =11'b00100000000;
                11'bX1000000000  :next_sel_i   =11'b01000000000;
                default          :next_sel_i   =11'b00000000001;
            endcase
        end
        default:next_sel_i=11'b00000000001;
    endcase
end

end

else if(CH_NUM==12)begin:SEL12

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        12'b000000000001:begin
            casex(curr_req)
                12'b000000000001  :next_sel_i   =12'b000000000001;
                12'bXXXXXXXXXX1X  :next_sel_i   =12'b000000000010;
                12'bXXXXXXXXX10X  :next_sel_i   =12'b000000000100;
                12'bXXXXXXXX100X  :next_sel_i   =12'b000000001000;
                12'bXXXXXXX1000X  :next_sel_i   =12'b000000010000;
                12'bXXXXXX10000X  :next_sel_i   =12'b000000100000;
                12'bXXXXX100000X  :next_sel_i   =12'b000001000000;
                12'bXXXX1000000X  :next_sel_i   =12'b000010000000;
                12'bXXX10000000X  :next_sel_i   =12'b000100000000;
                12'bXX100000000X  :next_sel_i   =12'b001000000000;
                12'bX1000000000X  :next_sel_i   =12'b010000000000;
                12'b10000000000X  :next_sel_i   =12'b100000000000;
                default          :next_sel_i    =12'b000000000010;
            endcase
        end
        12'b000000000010:begin
            casex(curr_req)
                12'b000000000010  :next_sel_i   =12'b000000000010;
                12'bXXXXXXXXX1XX  :next_sel_i   =12'b000000000100;
                12'bXXXXXXXX10XX  :next_sel_i   =12'b000000001000;
                12'bXXXXXXX100XX  :next_sel_i   =12'b000000010000;
                12'bXXXXXX1000XX  :next_sel_i   =12'b000000100000;
                12'bXXXXX10000XX  :next_sel_i   =12'b000001000000;
                12'bXXXX100000XX  :next_sel_i   =12'b000010000000;
                12'bXXX1000000XX  :next_sel_i   =12'b000100000000;
                12'bXX10000000XX  :next_sel_i   =12'b001000000000;
                12'bX100000000XX  :next_sel_i   =12'b010000000000;
                12'b1000000000XX  :next_sel_i   =12'b100000000000;
                12'b0000000000X1  :next_sel_i   =12'b000000000001;
                default          :next_sel_i    =12'b000000000100;
            endcase
        end
        12'b000000000100:begin
            casex(curr_req)
                12'b000000000100  :next_sel_i   =12'b000000000100;
                12'bXXXXXXXX1XXX  :next_sel_i   =12'b000000001000;
                12'bXXXXXXX10XXX  :next_sel_i   =12'b000000010000;
                12'bXXXXXX100XXX  :next_sel_i   =12'b000000100000;
                12'bXXXXX1000XXX  :next_sel_i   =12'b000001000000;
                12'bXXXX10000XXX  :next_sel_i   =12'b000010000000;
                12'bXXX100000XXX  :next_sel_i   =12'b000100000000;
                12'bXX1000000XXX  :next_sel_i   =12'b001000000000;
                12'bX10000000XXX  :next_sel_i   =12'b010000000000;
                12'b100000000XXX  :next_sel_i   =12'b100000000000;
                12'b000000000XX1  :next_sel_i   =12'b000000000001;
                12'b000000000X10  :next_sel_i   =12'b000000000010;
                default          :next_sel_i    =12'b000000001000;
            endcase
        end
        12'b000000001000:begin
            casex(curr_req)
                12'b000000001000  :next_sel_i   =12'b000000001000;
                12'bXXXXXXX1XXXX  :next_sel_i   =12'b000000010000;
                12'bXXXXXX10XXXX  :next_sel_i   =12'b000000100000;
                12'bXXXXX100XXXX  :next_sel_i   =12'b000001000000;
                12'bXXXX1000XXXX  :next_sel_i   =12'b000010000000;
                12'bXXX10000XXXX  :next_sel_i   =12'b000100000000;
                12'bXX100000XXXX  :next_sel_i   =12'b001000000000;
                12'bX1000000XXXX  :next_sel_i   =12'b010000000000;
                12'b10000000XXXX  :next_sel_i   =12'b100000000000;
                12'b00000000XXX1  :next_sel_i   =12'b000000000001;
                12'b00000000XX10  :next_sel_i   =12'b000000000010;
                12'b00000000X100  :next_sel_i   =12'b000000000100;
                default          :next_sel_i    =12'b000000010000;
            endcase
        end
        12'b000000010000:begin
            casex(curr_req)
                12'b000000010000  :next_sel_i   =12'b000000010000;
                12'bXXXXXX1XXXXX  :next_sel_i   =12'b000000100000;
                12'bXXXXX10XXXXX  :next_sel_i   =12'b000001000000;
                12'bXXXX100XXXXX  :next_sel_i   =12'b000010000000;
                12'bXXX1000XXXXX  :next_sel_i   =12'b000100000000;
                12'bXX10000XXXXX  :next_sel_i   =12'b001000000000;
                12'bX100000XXXXX  :next_sel_i   =12'b010000000000;
                12'b1000000XXXXX  :next_sel_i   =12'b100000000000;
                12'b0000000XXXX1  :next_sel_i   =12'b000000000001;
                12'b0000000XXX10  :next_sel_i   =12'b000000000010;
                12'b0000000XX100  :next_sel_i   =12'b000000000100;
                12'b0000000X1000  :next_sel_i   =12'b000000001000;
                default          :next_sel_i    =12'b000000100000;
            endcase
        end
        12'b000000100000:begin
            casex(curr_req)
                12'b000000100000  :next_sel_i   =12'b000000100000;
                12'bXXXXX1XXXXXX  :next_sel_i   =12'b000001000000;
                12'bXXXX10XXXXXX  :next_sel_i   =12'b000010000000;
                12'bXXX100XXXXXX  :next_sel_i   =12'b000100000000;
                12'bXX1000XXXXXX  :next_sel_i   =12'b001000000000;
                12'bX10000XXXXXX  :next_sel_i   =12'b010000000000;
                12'b100000XXXXXX  :next_sel_i   =12'b100000000000;
                12'b000000XXXXX1  :next_sel_i   =12'b000000000001;
                12'b000000XXXX10  :next_sel_i   =12'b000000000010;
                12'b000000XXX100  :next_sel_i   =12'b000000000100;
                12'b000000XX1000  :next_sel_i   =12'b000000001000;
                12'b000000X10000  :next_sel_i   =12'b000000010000;
                default          :next_sel_i    =12'b000001000000;
            endcase
        end
        12'b000001000000:begin
            casex(curr_req)
                12'b000001000000  :next_sel_i   =12'b000001000000;
                12'bXXXX1XXXXXXX  :next_sel_i   =12'b000010000000;
                12'bXXX10XXXXXXX  :next_sel_i   =12'b000100000000;
                12'bXX100XXXXXXX  :next_sel_i   =12'b001000000000;
                12'bX1000XXXXXXX  :next_sel_i   =12'b010000000000;
                12'b10000XXXXXXX  :next_sel_i   =12'b100000000000;
                12'b00000XXXXXX1  :next_sel_i   =12'b000000000001;
                12'b00000XXXXX10  :next_sel_i   =12'b000000000010;
                12'b00000XXXX100  :next_sel_i   =12'b000000000100;
                12'b00000XXX1000  :next_sel_i   =12'b000000001000;
                12'b00000XX10000  :next_sel_i   =12'b000000010000;
                12'b00000X100000  :next_sel_i   =12'b000000100000;
                default          :next_sel_i    =12'b000010000000;
            endcase
        end
        12'b000010000000:begin
            casex(curr_req)
                12'b000010000000  :next_sel_i   =12'b000010000000;
                12'bXXX1XXXXXXXX  :next_sel_i   =12'b000100000000;
                12'bXX10XXXXXXXX  :next_sel_i   =12'b001000000000;
                12'bX100XXXXXXXX  :next_sel_i   =12'b010000000000;
                12'b1000XXXXXXXX  :next_sel_i   =12'b100000000000;
                12'b0000XXXXXXX1  :next_sel_i   =12'b000000000001;
                12'b0000XXXXXX10  :next_sel_i   =12'b000000000010;
                12'b0000XXXXX100  :next_sel_i   =12'b000000000100;
                12'b0000XXXX1000  :next_sel_i   =12'b000000001000;
                12'b0000XXX10000  :next_sel_i   =12'b000000010000;
                12'b0000XX100000  :next_sel_i   =12'b000000100000;
                12'b0000X1000000  :next_sel_i   =12'b000001000000;
                default          :next_sel_i    =12'b000100000000;
            endcase
        end
        12'b000100000000:begin
            casex(curr_req)
                12'b000100000000  :next_sel_i   =12'b000100000000;
                12'bXX1XXXXXXXXX  :next_sel_i   =12'b001000000000;
                12'bX10XXXXXXXXX  :next_sel_i   =12'b010000000000;
                12'b100XXXXXXXXX  :next_sel_i   =12'b100000000000;
                12'b000XXXXXXXX1  :next_sel_i   =12'b000000000001;
                12'b000XXXXXXX10  :next_sel_i   =12'b000000000010;
                12'b000XXXXXX100  :next_sel_i   =12'b000000000100;
                12'b000XXXXX1000  :next_sel_i   =12'b000000001000;
                12'b000XXXX10000  :next_sel_i   =12'b000000010000;
                12'b000XXX100000  :next_sel_i   =12'b000000100000;
                12'b000XX1000000  :next_sel_i   =12'b000001000000;
                12'b000X10000000  :next_sel_i   =12'b000010000000;
                default          :next_sel_i    =12'b001000000000;
            endcase
        end
        12'b001000000000:begin
            casex(curr_req)
                12'b001000000000  :next_sel_i   =12'b001000000000;
                12'bX1XXXXXXXXXX  :next_sel_i   =12'b010000000000;
                12'b10XXXXXXXXXX  :next_sel_i   =12'b100000000000;
                12'b00XXXXXXXXX1  :next_sel_i   =12'b000000000001;
                12'b00XXXXXXXX10  :next_sel_i   =12'b000000000010;
                12'b00XXXXXXX100  :next_sel_i   =12'b000000000100;
                12'b00XXXXXX1000  :next_sel_i   =12'b000000001000;
                12'b00XXXXX10000  :next_sel_i   =12'b000000010000;
                12'b00XXXX100000  :next_sel_i   =12'b000000100000;
                12'b00XXX1000000  :next_sel_i   =12'b000001000000;
                12'b00XX10000000  :next_sel_i   =12'b000010000000;
                12'b00X100000000  :next_sel_i   =12'b000100000000;
                default          :next_sel_i    =12'b010000000000;
            endcase
        end
        12'b010000000000:begin
            casex(curr_req)
                12'b010000000000  :next_sel_i   =12'b010000000000;
                12'b1XXXXXXXXXXX  :next_sel_i   =12'b100000000000;
                12'b0XXXXXXXXXX1  :next_sel_i   =12'b000000000001;
                12'b0XXXXXXXXX10  :next_sel_i   =12'b000000000010;
                12'b0XXXXXXXX100  :next_sel_i   =12'b000000000100;
                12'b0XXXXXXX1000  :next_sel_i   =12'b000000001000;
                12'b0XXXXXX10000  :next_sel_i   =12'b000000010000;
                12'b0XXXXX100000  :next_sel_i   =12'b000000100000;
                12'b0XXXX1000000  :next_sel_i   =12'b000001000000;
                12'b0XXX10000000  :next_sel_i   =12'b000010000000;
                12'b0XX100000000  :next_sel_i   =12'b000100000000;
                12'b0X1000000000  :next_sel_i   =12'b001000000000;
                default          :next_sel_i    =12'b100000000000;
            endcase
        end
        12'b100000000000:begin
            casex(curr_req)
                12'b100000000000  :next_sel_i   =12'b100000000000;
                12'bXXXXXXXXXXX1  :next_sel_i   =12'b000000000001;
                12'bXXXXXXXXXX10  :next_sel_i   =12'b000000000010;
                12'bXXXXXXXXX100  :next_sel_i   =12'b000000000100;
                12'bXXXXXXXX1000  :next_sel_i   =12'b000000001000;
                12'bXXXXXXX10000  :next_sel_i   =12'b000000010000;
                12'bXXXXXX100000  :next_sel_i   =12'b000000100000;
                12'bXXXXX1000000  :next_sel_i   =12'b000001000000;
                12'bXXXX10000000  :next_sel_i   =12'b000010000000;
                12'bXXX100000000  :next_sel_i   =12'b000100000000;
                12'bXX1000000000  :next_sel_i   =12'b001000000000;
                12'bX10000000000  :next_sel_i   =12'b010000000000;
                default          :next_sel_i    =12'b000000000001;
            endcase
        end
        default:next_sel_i=12'b000000000001;
    endcase
end

end

else if(CH_NUM==13)begin:SEL13

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        13'b0000000000001:begin
            casex(curr_req)
                13'b0000000000001   :next_sel_i   =13'b0000000000001;
                13'bXXXXXXXXXXX1X   :next_sel_i   =13'b0000000000010;
                13'bXXXXXXXXXX10X   :next_sel_i   =13'b0000000000100;
                13'bXXXXXXXXX100X   :next_sel_i   =13'b0000000001000;
                13'bXXXXXXXX1000X   :next_sel_i   =13'b0000000010000;
                13'bXXXXXXX10000X   :next_sel_i   =13'b0000000100000;
                13'bXXXXXX100000X   :next_sel_i   =13'b0000001000000;
                13'bXXXXX1000000X   :next_sel_i   =13'b0000010000000;
                13'bXXXX10000000X   :next_sel_i   =13'b0000100000000;
                13'bXXX100000000X   :next_sel_i   =13'b0001000000000;
                13'bXX1000000000X   :next_sel_i   =13'b0010000000000;
                13'bX10000000000X   :next_sel_i   =13'b0100000000000;
                13'b100000000000X   :next_sel_i   =13'b1000000000000;
                default             :next_sel_i   =13'b0000000000010;
            endcase
        end
        13'b0000000000010:begin
            casex(curr_req)
                13'b0000000000010   :next_sel_i   =13'b0000000000010;
                13'bXXXXXXXXXX1XX   :next_sel_i   =13'b0000000000100;
                13'bXXXXXXXXX10XX   :next_sel_i   =13'b0000000001000;
                13'bXXXXXXXX100XX   :next_sel_i   =13'b0000000010000;
                13'bXXXXXXX1000XX   :next_sel_i   =13'b0000000100000;
                13'bXXXXXX10000XX   :next_sel_i   =13'b0000001000000;
                13'bXXXXX100000XX   :next_sel_i   =13'b0000010000000;
                13'bXXXX1000000XX   :next_sel_i   =13'b0000100000000;
                13'bXXX10000000XX   :next_sel_i   =13'b0001000000000;
                13'bXX100000000XX   :next_sel_i   =13'b0010000000000;
                13'bX1000000000XX   :next_sel_i   =13'b0100000000000;
                13'b10000000000XX   :next_sel_i   =13'b1000000000000;
                13'b00000000000X1   :next_sel_i   =13'b0000000000001;
                default             :next_sel_i   =13'b0000000000100;
            endcase
        end
        13'b0000000000100:begin
            casex(curr_req)
                13'b0000000000100   :next_sel_i   =13'b0000000000100;
                13'bXXXXXXXXX1XXX   :next_sel_i   =13'b0000000001000;
                13'bXXXXXXXX10XXX   :next_sel_i   =13'b0000000010000;
                13'bXXXXXXX100XXX   :next_sel_i   =13'b0000000100000;
                13'bXXXXXX1000XXX   :next_sel_i   =13'b0000001000000;
                13'bXXXXX10000XXX   :next_sel_i   =13'b0000010000000;
                13'bXXXX100000XXX   :next_sel_i   =13'b0000100000000;
                13'bXXX1000000XXX   :next_sel_i   =13'b0001000000000;
                13'bXX10000000XXX   :next_sel_i   =13'b0010000000000;
                13'bX100000000XXX   :next_sel_i   =13'b0100000000000;
                13'b1000000000XXX   :next_sel_i   =13'b1000000000000;
                13'b0000000000XX1   :next_sel_i   =13'b0000000000001;
                13'b0000000000X10   :next_sel_i   =13'b0000000000010;
                default             :next_sel_i   =13'b0000000001000;
            endcase
        end
        13'b0000000001000:begin
            casex(curr_req)
                13'b0000000001000   :next_sel_i   =13'b0000000001000;
                13'bXXXXXXXX1XXXX   :next_sel_i   =13'b0000000010000;
                13'bXXXXXXX10XXXX   :next_sel_i   =13'b0000000100000;
                13'bXXXXXX100XXXX   :next_sel_i   =13'b0000001000000;
                13'bXXXXX1000XXXX   :next_sel_i   =13'b0000010000000;
                13'bXXXX10000XXXX   :next_sel_i   =13'b0000100000000;
                13'bXXX100000XXXX   :next_sel_i   =13'b0001000000000;
                13'bXX1000000XXXX   :next_sel_i   =13'b0010000000000;
                13'bX10000000XXXX   :next_sel_i   =13'b0100000000000;
                13'b100000000XXXX   :next_sel_i   =13'b1000000000000;
                13'b000000000XXX1   :next_sel_i   =13'b0000000000001;
                13'b000000000XX10   :next_sel_i   =13'b0000000000010;
                13'b000000000X100   :next_sel_i   =13'b0000000000100;
                default             :next_sel_i   =13'b0000000010000;
            endcase
        end
        13'b0000000010000:begin
            casex(curr_req)
                13'b0000000010000   :next_sel_i   =13'b0000000010000;
                13'bXXXXXXX1XXXXX   :next_sel_i   =13'b0000000100000;
                13'bXXXXXX10XXXXX   :next_sel_i   =13'b0000001000000;
                13'bXXXXX100XXXXX   :next_sel_i   =13'b0000010000000;
                13'bXXXX1000XXXXX   :next_sel_i   =13'b0000100000000;
                13'bXXX10000XXXXX   :next_sel_i   =13'b0001000000000;
                13'bXX100000XXXXX   :next_sel_i   =13'b0010000000000;
                13'bX1000000XXXXX   :next_sel_i   =13'b0100000000000;
                13'b10000000XXXXX   :next_sel_i   =13'b1000000000000;
                13'b00000000XXXX1   :next_sel_i   =13'b0000000000001;
                13'b00000000XXX10   :next_sel_i   =13'b0000000000010;
                13'b00000000XX100   :next_sel_i   =13'b0000000000100;
                13'b00000000X1000   :next_sel_i   =13'b0000000001000;
                default             :next_sel_i   =13'b0000000100000;
            endcase
        end
        13'b0000000100000:begin
            casex(curr_req)
                13'b0000000100000   :next_sel_i   =13'b0000000100000;
                13'bXXXXXX1XXXXXX   :next_sel_i   =13'b0000001000000;
                13'bXXXXX10XXXXXX   :next_sel_i   =13'b0000010000000;
                13'bXXXX100XXXXXX   :next_sel_i   =13'b0000100000000;
                13'bXXX1000XXXXXX   :next_sel_i   =13'b0001000000000;
                13'bXX10000XXXXXX   :next_sel_i   =13'b0010000000000;
                13'bX100000XXXXXX   :next_sel_i   =13'b0100000000000;
                13'b1000000XXXXXX   :next_sel_i   =13'b1000000000000;
                13'b0000000XXXXX1   :next_sel_i   =13'b0000000000001;
                13'b0000000XXXX10   :next_sel_i   =13'b0000000000010;
                13'b0000000XXX100   :next_sel_i   =13'b0000000000100;
                13'b0000000XX1000   :next_sel_i   =13'b0000000001000;
                13'b0000000X10000   :next_sel_i   =13'b0000000010000;
                default             :next_sel_i   =13'b0000001000000;
            endcase
        end
        13'b0000001000000:begin
            casex(curr_req)
                13'b0000001000000   :next_sel_i   =13'b0000001000000;
                13'bXXXXX1XXXXXXX   :next_sel_i   =13'b0000010000000;
                13'bXXXX10XXXXXXX   :next_sel_i   =13'b0000100000000;
                13'bXXX100XXXXXXX   :next_sel_i   =13'b0001000000000;
                13'bXX1000XXXXXXX   :next_sel_i   =13'b0010000000000;
                13'bX10000XXXXXXX   :next_sel_i   =13'b0100000000000;
                13'b100000XXXXXXX   :next_sel_i   =13'b1000000000000;
                13'b000000XXXXXX1   :next_sel_i   =13'b0000000000001;
                13'b000000XXXXX10   :next_sel_i   =13'b0000000000010;
                13'b000000XXXX100   :next_sel_i   =13'b0000000000100;
                13'b000000XXX1000   :next_sel_i   =13'b0000000001000;
                13'b000000XX10000   :next_sel_i   =13'b0000000010000;
                13'b000000X100000   :next_sel_i   =13'b0000000100000;
                default             :next_sel_i   =13'b0000010000000;
            endcase
        end
        13'b0000010000000:begin
            casex(curr_req)
                13'b0000010000000   :next_sel_i   =13'b0000010000000;
                13'bXXXX1XXXXXXXX   :next_sel_i   =13'b0000100000000;
                13'bXXX10XXXXXXXX   :next_sel_i   =13'b0001000000000;
                13'bXX100XXXXXXXX   :next_sel_i   =13'b0010000000000;
                13'bX1000XXXXXXXX   :next_sel_i   =13'b0100000000000;
                13'b10000XXXXXXXX   :next_sel_i   =13'b1000000000000;
                13'b00000XXXXXXX1   :next_sel_i   =13'b0000000000001;
                13'b00000XXXXXX10   :next_sel_i   =13'b0000000000010;
                13'b00000XXXXX100   :next_sel_i   =13'b0000000000100;
                13'b00000XXXX1000   :next_sel_i   =13'b0000000001000;
                13'b00000XXX10000   :next_sel_i   =13'b0000000010000;
                13'b00000XX100000   :next_sel_i   =13'b0000000100000;
                13'b00000X1000000   :next_sel_i   =13'b0000001000000;
                default             :next_sel_i   =13'b0000100000000;
            endcase
        end
        13'b0000100000000:begin
            casex(curr_req)
                13'b0000100000000   :next_sel_i   =13'b0000100000000;
                13'bXXX1XXXXXXXXX   :next_sel_i   =13'b0001000000000;
                13'bXX10XXXXXXXXX   :next_sel_i   =13'b0010000000000;
                13'bX100XXXXXXXXX   :next_sel_i   =13'b0100000000000;
                13'b1000XXXXXXXXX   :next_sel_i   =13'b1000000000000;
                13'b0000XXXXXXXX1   :next_sel_i   =13'b0000000000001;
                13'b0000XXXXXXX10   :next_sel_i   =13'b0000000000010;
                13'b0000XXXXXX100   :next_sel_i   =13'b0000000000100;
                13'b0000XXXXX1000   :next_sel_i   =13'b0000000001000;
                13'b0000XXXX10000   :next_sel_i   =13'b0000000010000;
                13'b0000XXX100000   :next_sel_i   =13'b0000000100000;
                13'b0000XX1000000   :next_sel_i   =13'b0000001000000;
                13'b0000X10000000   :next_sel_i   =13'b0000010000000;
                default             :next_sel_i   =13'b0001000000000;
            endcase
        end
        13'b0001000000000:begin
            casex(curr_req)
                13'b0001000000000   :next_sel_i   =13'b0001000000000;
                13'bXX1XXXXXXXXXX   :next_sel_i   =13'b0010000000000;
                13'bX10XXXXXXXXXX   :next_sel_i   =13'b0100000000000;
                13'b100XXXXXXXXXX   :next_sel_i   =13'b1000000000000;
                13'b000XXXXXXXXX1   :next_sel_i   =13'b0000000000001;
                13'b000XXXXXXXX10   :next_sel_i   =13'b0000000000010;
                13'b000XXXXXXX100   :next_sel_i   =13'b0000000000100;
                13'b000XXXXXX1000   :next_sel_i   =13'b0000000001000;
                13'b000XXXXX10000   :next_sel_i   =13'b0000000010000;
                13'b000XXXX100000   :next_sel_i   =13'b0000000100000;
                13'b000XXX1000000   :next_sel_i   =13'b0000001000000;
                13'b000XX10000000   :next_sel_i   =13'b0000010000000;
                13'b000X100000000   :next_sel_i   =13'b0000100000000;
                default             :next_sel_i   =13'b0010000000000;
            endcase
        end
        13'b0010000000000:begin
            casex(curr_req)
                13'b0010000000000   :next_sel_i   =13'b0010000000000;
                13'bX1XXXXXXXXXXX   :next_sel_i   =13'b0100000000000;
                13'b10XXXXXXXXXXX   :next_sel_i   =13'b1000000000000;
                13'b00XXXXXXXXXX1   :next_sel_i   =13'b0000000000001;
                13'b00XXXXXXXXX10   :next_sel_i   =13'b0000000000010;
                13'b00XXXXXXXX100   :next_sel_i   =13'b0000000000100;
                13'b00XXXXXXX1000   :next_sel_i   =13'b0000000001000;
                13'b00XXXXXX10000   :next_sel_i   =13'b0000000010000;
                13'b00XXXXX100000   :next_sel_i   =13'b0000000100000;
                13'b00XXXX1000000   :next_sel_i   =13'b0000001000000;
                13'b00XXX10000000   :next_sel_i   =13'b0000010000000;
                13'b00XX100000000   :next_sel_i   =13'b0000100000000;
                13'b00X1000000000   :next_sel_i   =13'b0001000000000;
                default             :next_sel_i   =13'b0100000000000;
            endcase
        end
        13'b0100000000000:begin
            casex(curr_req)
                13'b0100000000000   :next_sel_i   =13'b0100000000000;
                13'b1XXXXXXXXXXXX   :next_sel_i   =13'b1000000000000;
                13'b0XXXXXXXXXXX1   :next_sel_i   =13'b0000000000001;
                13'b0XXXXXXXXXX10   :next_sel_i   =13'b0000000000010;
                13'b0XXXXXXXXX100   :next_sel_i   =13'b0000000000100;
                13'b0XXXXXXXX1000   :next_sel_i   =13'b0000000001000;
                13'b0XXXXXXX10000   :next_sel_i   =13'b0000000010000;
                13'b0XXXXXX100000   :next_sel_i   =13'b0000000100000;
                13'b0XXXXX1000000   :next_sel_i   =13'b0000001000000;
                13'b0XXXX10000000   :next_sel_i   =13'b0000010000000;
                13'b0XXX100000000   :next_sel_i   =13'b0000100000000;
                13'b0XX1000000000   :next_sel_i   =13'b0001000000000;
                13'b0X10000000000   :next_sel_i   =13'b0010000000000;
                default             :next_sel_i   =13'b1000000000000;
            endcase
        end
        13'b1000000000000:begin
            casex(curr_req)
                13'b1000000000000   :next_sel_i   =13'b1000000000000;
                13'bXXXXXXXXXXXX1   :next_sel_i   =13'b0000000000001;
                13'bXXXXXXXXXXX10   :next_sel_i   =13'b0000000000010;
                13'bXXXXXXXXXX100   :next_sel_i   =13'b0000000000100;
                13'bXXXXXXXXX1000   :next_sel_i   =13'b0000000001000;
                13'bXXXXXXXX10000   :next_sel_i   =13'b0000000010000;
                13'bXXXXXXX100000   :next_sel_i   =13'b0000000100000;
                13'bXXXXXX1000000   :next_sel_i   =13'b0000001000000;
                13'bXXXXX10000000   :next_sel_i   =13'b0000010000000;
                13'bXXXX100000000   :next_sel_i   =13'b0000100000000;
                13'bXXX1000000000   :next_sel_i   =13'b0001000000000;
                13'bXX10000000000   :next_sel_i   =13'b0010000000000;
                13'bX100000000000   :next_sel_i   =13'b0100000000000;
                default             :next_sel_i   =13'b0000000000001;
            endcase
        end
        default:next_sel_i=13'b0000000000001;
    endcase
end

end

else if(CH_NUM==14)begin:SEL14

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        14'b00000000000001:begin
            casex(curr_req)
                14'b00000000000001  :next_sel_i   =14'b00000000000001;
                14'bXXXXXXXXXXXX1X  :next_sel_i   =14'b00000000000010;
                14'bXXXXXXXXXXX10X  :next_sel_i   =14'b00000000000100;
                14'bXXXXXXXXXX100X  :next_sel_i   =14'b00000000001000;
                14'bXXXXXXXXX1000X  :next_sel_i   =14'b00000000010000;
                14'bXXXXXXXX10000X  :next_sel_i   =14'b00000000100000;
                14'bXXXXXXX100000X  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX1000000X  :next_sel_i   =14'b00000010000000;
                14'bXXXXX10000000X  :next_sel_i   =14'b00000100000000;
                14'bXXXX100000000X  :next_sel_i   =14'b00001000000000;
                14'bXXX1000000000X  :next_sel_i   =14'b00010000000000;
                14'bXX10000000000X  :next_sel_i   =14'b00100000000000;
                14'bX100000000000X  :next_sel_i   =14'b01000000000000;
                14'b1000000000000X  :next_sel_i   =14'b10000000000000;
                default             :next_sel_i   =14'b00000000000010;
            endcase
        end
        14'b00000000000010:begin
            casex(curr_req)
                14'b00000000000010  :next_sel_i   =14'b00000000000010;
                14'bXXXXXXXXXXX1XX  :next_sel_i   =14'b00000000000100;
                14'bXXXXXXXXXX10XX  :next_sel_i   =14'b00000000001000;
                14'bXXXXXXXXX100XX  :next_sel_i   =14'b00000000010000;
                14'bXXXXXXXX1000XX  :next_sel_i   =14'b00000000100000;
                14'bXXXXXXX10000XX  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX100000XX  :next_sel_i   =14'b00000010000000;
                14'bXXXXX1000000XX  :next_sel_i   =14'b00000100000000;
                14'bXXXX10000000XX  :next_sel_i   =14'b00001000000000;
                14'bXXX100000000XX  :next_sel_i   =14'b00010000000000;
                14'bXX1000000000XX  :next_sel_i   =14'b00100000000000;
                14'bX10000000000XX  :next_sel_i   =14'b01000000000000;
                14'b100000000000XX  :next_sel_i   =14'b10000000000000;
                14'b000000000000X1  :next_sel_i   =14'b00000000000001;
                default             :next_sel_i   =14'b00000000000100;
            endcase
        end
        14'b00000000000100:begin
            casex(curr_req)
                14'b00000000000100  :next_sel_i   =14'b00000000000100;
                14'bXXXXXXXXXX1XXX  :next_sel_i   =14'b00000000001000;
                14'bXXXXXXXXX10XXX  :next_sel_i   =14'b00000000010000;
                14'bXXXXXXXX100XXX  :next_sel_i   =14'b00000000100000;
                14'bXXXXXXX1000XXX  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX10000XXX  :next_sel_i   =14'b00000010000000;
                14'bXXXXX100000XXX  :next_sel_i   =14'b00000100000000;
                14'bXXXX1000000XXX  :next_sel_i   =14'b00001000000000;
                14'bXXX10000000XXX  :next_sel_i   =14'b00010000000000;
                14'bXX100000000XXX  :next_sel_i   =14'b00100000000000;
                14'bX1000000000XXX  :next_sel_i   =14'b01000000000000;
                14'b10000000000XXX  :next_sel_i   =14'b10000000000000;
                14'b00000000000XX1  :next_sel_i   =14'b00000000000001;
                14'b00000000000X10  :next_sel_i   =14'b00000000000010;
                default             :next_sel_i   =14'b00000000001000;
            endcase
        end
        14'b00000000001000:begin
            casex(curr_req)
                14'b00000000001000  :next_sel_i   =14'b00000000001000;
                14'bXXXXXXXXX1XXXX  :next_sel_i   =14'b00000000010000;
                14'bXXXXXXXX10XXXX  :next_sel_i   =14'b00000000100000;
                14'bXXXXXXX100XXXX  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX1000XXXX  :next_sel_i   =14'b00000010000000;
                14'bXXXXX10000XXXX  :next_sel_i   =14'b00000100000000;
                14'bXXXX100000XXXX  :next_sel_i   =14'b00001000000000;
                14'bXXX1000000XXXX  :next_sel_i   =14'b00010000000000;
                14'bXX10000000XXXX  :next_sel_i   =14'b00100000000000;
                14'bX100000000XXXX  :next_sel_i   =14'b01000000000000;
                14'b1000000000XXXX  :next_sel_i   =14'b10000000000000;
                14'b0000000000XXX1  :next_sel_i   =14'b00000000000001;
                14'b0000000000XX10  :next_sel_i   =14'b00000000000010;
                14'b0000000000X100  :next_sel_i   =14'b00000000000100;
                default             :next_sel_i   =14'b00000000010000;
            endcase
        end
        14'b00000000010000:begin
            casex(curr_req)
                14'b00000000010000  :next_sel_i   =14'b00000000010000;
                14'bXXXXXXXX1XXXXX  :next_sel_i   =14'b00000000100000;
                14'bXXXXXXX10XXXXX  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX100XXXXX  :next_sel_i   =14'b00000010000000;
                14'bXXXXX1000XXXXX  :next_sel_i   =14'b00000100000000;
                14'bXXXX10000XXXXX  :next_sel_i   =14'b00001000000000;
                14'bXXX100000XXXXX  :next_sel_i   =14'b00010000000000;
                14'bXX1000000XXXXX  :next_sel_i   =14'b00100000000000;
                14'bX10000000XXXXX  :next_sel_i   =14'b01000000000000;
                14'b100000000XXXXX  :next_sel_i   =14'b10000000000000;
                14'b000000000XXXX1  :next_sel_i   =14'b00000000000001;
                14'b000000000XXX10  :next_sel_i   =14'b00000000000010;
                14'b000000000XX100  :next_sel_i   =14'b00000000000100;
                14'b000000000X1000  :next_sel_i   =14'b00000000001000;
                default             :next_sel_i   =14'b00000000100000;
            endcase
        end
        14'b00000000100000:begin
            casex(curr_req)
                14'b00000000100000  :next_sel_i   =14'b00000000100000;
                14'bXXXXXXX1XXXXXX  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX10XXXXXX  :next_sel_i   =14'b00000010000000;
                14'bXXXXX100XXXXXX  :next_sel_i   =14'b00000100000000;
                14'bXXXX1000XXXXXX  :next_sel_i   =14'b00001000000000;
                14'bXXX10000XXXXXX  :next_sel_i   =14'b00010000000000;
                14'bXX100000XXXXXX  :next_sel_i   =14'b00100000000000;
                14'bX1000000XXXXXX  :next_sel_i   =14'b01000000000000;
                14'b10000000XXXXXX  :next_sel_i   =14'b10000000000000;
                14'b00000000XXXXX1  :next_sel_i   =14'b00000000000001;
                14'b00000000XXXX10  :next_sel_i   =14'b00000000000010;
                14'b00000000XXX100  :next_sel_i   =14'b00000000000100;
                14'b00000000XX1000  :next_sel_i   =14'b00000000001000;
                14'b00000000X10000  :next_sel_i   =14'b00000000010000;
                default             :next_sel_i   =14'b00000001000000;
            endcase
        end
        14'b00000001000000:begin
            casex(curr_req)
                14'b00000001000000  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX1XXXXXXX  :next_sel_i   =14'b00000010000000;
                14'bXXXXX10XXXXXXX  :next_sel_i   =14'b00000100000000;
                14'bXXXX100XXXXXXX  :next_sel_i   =14'b00001000000000;
                14'bXXX1000XXXXXXX  :next_sel_i   =14'b00010000000000;
                14'bXX10000XXXXXXX  :next_sel_i   =14'b00100000000000;
                14'bX100000XXXXXXX  :next_sel_i   =14'b01000000000000;
                14'b1000000XXXXXXX  :next_sel_i   =14'b10000000000000;
                14'b0000000XXXXXX1  :next_sel_i   =14'b00000000000001;
                14'b0000000XXXXX10  :next_sel_i   =14'b00000000000010;
                14'b0000000XXXX100  :next_sel_i   =14'b00000000000100;
                14'b0000000XXX1000  :next_sel_i   =14'b00000000001000;
                14'b0000000XX10000  :next_sel_i   =14'b00000000010000;
                14'b0000000X100000  :next_sel_i   =14'b00000000100000;
                default             :next_sel_i   =14'b00000010000000;
            endcase
        end
        14'b00000010000000:begin
            casex(curr_req)
                14'b00000010000000  :next_sel_i   =14'b00000010000000;
                14'bXXXXX1XXXXXXXX  :next_sel_i   =14'b00000100000000;
                14'bXXXX10XXXXXXXX  :next_sel_i   =14'b00001000000000;
                14'bXXX100XXXXXXXX  :next_sel_i   =14'b00010000000000;
                14'bXX1000XXXXXXXX  :next_sel_i   =14'b00100000000000;
                14'bX10000XXXXXXXX  :next_sel_i   =14'b01000000000000;
                14'b100000XXXXXXXX  :next_sel_i   =14'b10000000000000;
                14'b000000XXXXXXX1  :next_sel_i   =14'b00000000000001;
                14'b000000XXXXXX10  :next_sel_i   =14'b00000000000010;
                14'b000000XXXXX100  :next_sel_i   =14'b00000000000100;
                14'b000000XXXX1000  :next_sel_i   =14'b00000000001000;
                14'b000000XXX10000  :next_sel_i   =14'b00000000010000;
                14'b000000XX100000  :next_sel_i   =14'b00000000100000;
                14'b000000X1000000  :next_sel_i   =14'b00000001000000;
                default             :next_sel_i   =14'b00000100000000;
            endcase
        end
        14'b00000100000000:begin
            casex(curr_req)
                14'b00000100000000  :next_sel_i   =14'b00000100000000;
                14'bXXXX1XXXXXXXXX  :next_sel_i   =14'b00001000000000;
                14'bXXX10XXXXXXXXX  :next_sel_i   =14'b00010000000000;
                14'bXX100XXXXXXXXX  :next_sel_i   =14'b00100000000000;
                14'bX1000XXXXXXXXX  :next_sel_i   =14'b01000000000000;
                14'b10000XXXXXXXXX  :next_sel_i   =14'b10000000000000;
                14'b00000XXXXXXXX1  :next_sel_i   =14'b00000000000001;
                14'b00000XXXXXXX10  :next_sel_i   =14'b00000000000010;
                14'b00000XXXXXX100  :next_sel_i   =14'b00000000000100;
                14'b00000XXXXX1000  :next_sel_i   =14'b00000000001000;
                14'b00000XXXX10000  :next_sel_i   =14'b00000000010000;
                14'b00000XXX100000  :next_sel_i   =14'b00000000100000;
                14'b00000XX1000000  :next_sel_i   =14'b00000001000000;
                14'b00000X10000000  :next_sel_i   =14'b00000010000000;
                default             :next_sel_i   =14'b00001000000000;
            endcase
        end
        14'b00001000000000:begin
            casex(curr_req)
                14'b00001000000000  :next_sel_i   =14'b00001000000000;
                14'bXXX1XXXXXXXXXX  :next_sel_i   =14'b00010000000000;
                14'bXX10XXXXXXXXXX  :next_sel_i   =14'b00100000000000;
                14'bX100XXXXXXXXXX  :next_sel_i   =14'b01000000000000;
                14'b1000XXXXXXXXXX  :next_sel_i   =14'b10000000000000;
                14'b0000XXXXXXXXX1  :next_sel_i   =14'b00000000000001;
                14'b0000XXXXXXXX10  :next_sel_i   =14'b00000000000010;
                14'b0000XXXXXXX100  :next_sel_i   =14'b00000000000100;
                14'b0000XXXXXX1000  :next_sel_i   =14'b00000000001000;
                14'b0000XXXXX10000  :next_sel_i   =14'b00000000010000;
                14'b0000XXXX100000  :next_sel_i   =14'b00000000100000;
                14'b0000XXX1000000  :next_sel_i   =14'b00000001000000;
                14'b0000XX10000000  :next_sel_i   =14'b00000010000000;
                14'b0000X100000000  :next_sel_i   =14'b00000100000000;
                default             :next_sel_i   =14'b00010000000000;
            endcase
        end
        14'b00010000000000:begin
            casex(curr_req)
                14'b00010000000000  :next_sel_i   =14'b00010000000000;
                14'bXX1XXXXXXXXXXX  :next_sel_i   =14'b00100000000000;
                14'bX10XXXXXXXXXXX  :next_sel_i   =14'b01000000000000;
                14'b100XXXXXXXXXXX  :next_sel_i   =14'b10000000000000;
                14'b000XXXXXXXXXX1  :next_sel_i   =14'b00000000000001;
                14'b000XXXXXXXXX10  :next_sel_i   =14'b00000000000010;
                14'b000XXXXXXXX100  :next_sel_i   =14'b00000000000100;
                14'b000XXXXXXX1000  :next_sel_i   =14'b00000000001000;
                14'b000XXXXXX10000  :next_sel_i   =14'b00000000010000;
                14'b000XXXXX100000  :next_sel_i   =14'b00000000100000;
                14'b000XXXX1000000  :next_sel_i   =14'b00000001000000;
                14'b000XXX10000000  :next_sel_i   =14'b00000010000000;
                14'b000XX100000000  :next_sel_i   =14'b00000100000000;
                14'b000X1000000000  :next_sel_i   =14'b00001000000000;
                default             :next_sel_i   =14'b00100000000000;
            endcase
        end
        14'b00100000000000:begin
            casex(curr_req)
                14'b00100000000000  :next_sel_i   =14'b00100000000000;
                14'bX1XXXXXXXXXXXX  :next_sel_i   =14'b01000000000000;
                14'b10XXXXXXXXXXXX  :next_sel_i   =14'b10000000000000;
                14'b00XXXXXXXXXXX1  :next_sel_i   =14'b00000000000001;
                14'b00XXXXXXXXXX10  :next_sel_i   =14'b00000000000010;
                14'b00XXXXXXXXX100  :next_sel_i   =14'b00000000000100;
                14'b00XXXXXXXX1000  :next_sel_i   =14'b00000000001000;
                14'b00XXXXXXX10000  :next_sel_i   =14'b00000000010000;
                14'b00XXXXXX100000  :next_sel_i   =14'b00000000100000;
                14'b00XXXXX1000000  :next_sel_i   =14'b00000001000000;
                14'b00XXXX10000000  :next_sel_i   =14'b00000010000000;
                14'b00XXX100000000  :next_sel_i   =14'b00000100000000;
                14'b00XX1000000000  :next_sel_i   =14'b00001000000000;
                14'b00X10000000000  :next_sel_i   =14'b00010000000000;
                default             :next_sel_i   =14'b01000000000000;
            endcase
        end
        14'b01000000000000:begin
            casex(curr_req)
                14'b01000000000000  :next_sel_i   =14'b01000000000000;
                14'b1XXXXXXXXXXXXX  :next_sel_i   =14'b10000000000000;
                14'b0XXXXXXXXXXXX1  :next_sel_i   =14'b00000000000001;
                14'b0XXXXXXXXXXX10  :next_sel_i   =14'b00000000000010;
                14'b0XXXXXXXXXX100  :next_sel_i   =14'b00000000000100;
                14'b0XXXXXXXXX1000  :next_sel_i   =14'b00000000001000;
                14'b0XXXXXXXX10000  :next_sel_i   =14'b00000000010000;
                14'b0XXXXXXX100000  :next_sel_i   =14'b00000000100000;
                14'b0XXXXXX1000000  :next_sel_i   =14'b00000001000000;
                14'b0XXXXX10000000  :next_sel_i   =14'b00000010000000;
                14'b0XXXX100000000  :next_sel_i   =14'b00000100000000;
                14'b0XXX1000000000  :next_sel_i   =14'b00001000000000;
                14'b0XX10000000000  :next_sel_i   =14'b00010000000000;
                14'b0X100000000000  :next_sel_i   =14'b00100000000000;
                default             :next_sel_i   =14'b10000000000000;
            endcase
        end
        14'b10000000000000:begin
            casex(curr_req)
                14'b10000000000000  :next_sel_i   =14'b10000000000000;
                14'bXXXXXXXXXXXXX1  :next_sel_i   =14'b00000000000001;
                14'bXXXXXXXXXXXX10  :next_sel_i   =14'b00000000000010;
                14'bXXXXXXXXXXX100  :next_sel_i   =14'b00000000000100;
                14'bXXXXXXXXXX1000  :next_sel_i   =14'b00000000001000;
                14'bXXXXXXXXX10000  :next_sel_i   =14'b00000000010000;
                14'bXXXXXXXX100000  :next_sel_i   =14'b00000000100000;
                14'bXXXXXXX1000000  :next_sel_i   =14'b00000001000000;
                14'bXXXXXX10000000  :next_sel_i   =14'b00000010000000;
                14'bXXXXX100000000  :next_sel_i   =14'b00000100000000;
                14'bXXXX1000000000  :next_sel_i   =14'b00001000000000;
                14'bXXX10000000000  :next_sel_i   =14'b00010000000000;
                14'bXX100000000000  :next_sel_i   =14'b00100000000000;
                14'bX1000000000000  :next_sel_i   =14'b01000000000000;
                default             :next_sel_i   =14'b00000000000001;
            endcase
        end
        default:next_sel_i=14'b00000000000001;
    endcase
end

end

else if(CH_NUM==15)begin:SEL15

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        15'b000000000000001:begin
            casex(curr_req)
                15'b000000000000001 :next_sel_i   =15'b000000000000001;
                15'bXXXXXXXXXXXXX1X :next_sel_i   =15'b000000000000010;
                15'bXXXXXXXXXXXX10X :next_sel_i   =15'b000000000000100;
                15'bXXXXXXXXXXX100X :next_sel_i   =15'b000000000001000;
                15'bXXXXXXXXXX1000X :next_sel_i   =15'b000000000010000;
                15'bXXXXXXXXX10000X :next_sel_i   =15'b000000000100000;
                15'bXXXXXXXX100000X :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX1000000X :next_sel_i   =15'b000000010000000;
                15'bXXXXXX10000000X :next_sel_i   =15'b000000100000000;
                15'bXXXXX100000000X :next_sel_i   =15'b000001000000000;
                15'bXXXX1000000000X :next_sel_i   =15'b000010000000000;
                15'bXXX10000000000X :next_sel_i   =15'b000100000000000;
                15'bXX100000000000X :next_sel_i   =15'b001000000000000;
                15'bX1000000000000X :next_sel_i   =15'b010000000000000;
                15'b10000000000000X :next_sel_i   =15'b100000000000000;
                default             :next_sel_i   =15'b000000000000010;
            endcase
        end
        15'b000000000000010:begin
            casex(curr_req)
                15'b000000000000010 :next_sel_i   =15'b000000000000010;
                15'bXXXXXXXXXXXX1XX :next_sel_i   =15'b000000000000100;
                15'bXXXXXXXXXXX10XX :next_sel_i   =15'b000000000001000;
                15'bXXXXXXXXXX100XX :next_sel_i   =15'b000000000010000;
                15'bXXXXXXXXX1000XX :next_sel_i   =15'b000000000100000;
                15'bXXXXXXXX10000XX :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX100000XX :next_sel_i   =15'b000000010000000;
                15'bXXXXXX1000000XX :next_sel_i   =15'b000000100000000;
                15'bXXXXX10000000XX :next_sel_i   =15'b000001000000000;
                15'bXXXX100000000XX :next_sel_i   =15'b000010000000000;
                15'bXXX1000000000XX :next_sel_i   =15'b000100000000000;
                15'bXX10000000000XX :next_sel_i   =15'b001000000000000;
                15'bX100000000000XX :next_sel_i   =15'b010000000000000;
                15'b1000000000000XX :next_sel_i   =15'b100000000000000;
                15'b0000000000000X1 :next_sel_i   =15'b000000000000001;
                default             :next_sel_i   =15'b000000000000100;
            endcase
        end
        15'b000000000000100:begin
            casex(curr_req)
                15'b000000000000100 :next_sel_i   =15'b000000000000100;
                15'bXXXXXXXXXXX1XXX :next_sel_i   =15'b000000000001000;
                15'bXXXXXXXXXX10XXX :next_sel_i   =15'b000000000010000;
                15'bXXXXXXXXX100XXX :next_sel_i   =15'b000000000100000;
                15'bXXXXXXXX1000XXX :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX10000XXX :next_sel_i   =15'b000000010000000;
                15'bXXXXXX100000XXX :next_sel_i   =15'b000000100000000;
                15'bXXXXX1000000XXX :next_sel_i   =15'b000001000000000;
                15'bXXXX10000000XXX :next_sel_i   =15'b000010000000000;
                15'bXXX100000000XXX :next_sel_i   =15'b000100000000000;
                15'bXX1000000000XXX :next_sel_i   =15'b001000000000000;
                15'bX10000000000XXX :next_sel_i   =15'b010000000000000;
                15'b100000000000XXX :next_sel_i   =15'b100000000000000;
                15'b000000000000XX1 :next_sel_i   =15'b000000000000001;
                15'b000000000000X10 :next_sel_i   =15'b000000000000010;
                default             :next_sel_i   =15'b000000000001000;
            endcase
        end
        15'b000000000001000:begin
            casex(curr_req)
                15'b000000000001000 :next_sel_i   =15'b000000000001000;
                15'bXXXXXXXXXX1XXXX :next_sel_i   =15'b000000000010000;
                15'bXXXXXXXXX10XXXX :next_sel_i   =15'b000000000100000;
                15'bXXXXXXXX100XXXX :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX1000XXXX :next_sel_i   =15'b000000010000000;
                15'bXXXXXX10000XXXX :next_sel_i   =15'b000000100000000;
                15'bXXXXX100000XXXX :next_sel_i   =15'b000001000000000;
                15'bXXXX1000000XXXX :next_sel_i   =15'b000010000000000;
                15'bXXX10000000XXXX :next_sel_i   =15'b000100000000000;
                15'bXX100000000XXXX :next_sel_i   =15'b001000000000000;
                15'bX1000000000XXXX :next_sel_i   =15'b010000000000000;
                15'b10000000000XXXX :next_sel_i   =15'b100000000000000;
                15'b00000000000XXX1 :next_sel_i   =15'b000000000000001;
                15'b00000000000XX10 :next_sel_i   =15'b000000000000010;
                15'b00000000000X100 :next_sel_i   =15'b000000000000100;
                default             :next_sel_i   =15'b000000000010000;
            endcase
        end
        15'b000000000010000:begin
            casex(curr_req)
                15'b000000000010000 :next_sel_i   =15'b000000000010000;
                15'bXXXXXXXXX1XXXXX :next_sel_i   =15'b000000000100000;
                15'bXXXXXXXX10XXXXX :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX100XXXXX :next_sel_i   =15'b000000010000000;
                15'bXXXXXX1000XXXXX :next_sel_i   =15'b000000100000000;
                15'bXXXXX10000XXXXX :next_sel_i   =15'b000001000000000;
                15'bXXXX100000XXXXX :next_sel_i   =15'b000010000000000;
                15'bXXX1000000XXXXX :next_sel_i   =15'b000100000000000;
                15'bXX10000000XXXXX :next_sel_i   =15'b001000000000000;
                15'bX100000000XXXXX :next_sel_i   =15'b010000000000000;
                15'b1000000000XXXXX :next_sel_i   =15'b100000000000000;
                15'b0000000000XXXX1 :next_sel_i   =15'b000000000000001;
                15'b0000000000XXX10 :next_sel_i   =15'b000000000000010;
                15'b0000000000XX100 :next_sel_i   =15'b000000000000100;
                15'b0000000000X1000 :next_sel_i   =15'b000000000001000;
                default             :next_sel_i   =15'b000000000100000;
            endcase
        end
        15'b000000000100000:begin
            casex(curr_req)
                15'b000000000100000 :next_sel_i   =15'b000000000100000;
                15'bXXXXXXXX1XXXXXX :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX10XXXXXX :next_sel_i   =15'b000000010000000;
                15'bXXXXXX100XXXXXX :next_sel_i   =15'b000000100000000;
                15'bXXXXX1000XXXXXX :next_sel_i   =15'b000001000000000;
                15'bXXXX10000XXXXXX :next_sel_i   =15'b000010000000000;
                15'bXXX100000XXXXXX :next_sel_i   =15'b000100000000000;
                15'bXX1000000XXXXXX :next_sel_i   =15'b001000000000000;
                15'bX10000000XXXXXX :next_sel_i   =15'b010000000000000;
                15'b100000000XXXXXX :next_sel_i   =15'b100000000000000;
                15'b000000000XXXXX1 :next_sel_i   =15'b000000000000001;
                15'b000000000XXXX10 :next_sel_i   =15'b000000000000010;
                15'b000000000XXX100 :next_sel_i   =15'b000000000000100;
                15'b000000000XX1000 :next_sel_i   =15'b000000000001000;
                15'b000000000X10000 :next_sel_i   =15'b000000000010000;
                default             :next_sel_i   =15'b000000001000000;
            endcase
        end
        15'b000000001000000:begin
            casex(curr_req)
                15'b000000001000000 :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX1XXXXXXX :next_sel_i   =15'b000000010000000;
                15'bXXXXXX10XXXXXXX :next_sel_i   =15'b000000100000000;
                15'bXXXXX100XXXXXXX :next_sel_i   =15'b000001000000000;
                15'bXXXX1000XXXXXXX :next_sel_i   =15'b000010000000000;
                15'bXXX10000XXXXXXX :next_sel_i   =15'b000100000000000;
                15'bXX100000XXXXXXX :next_sel_i   =15'b001000000000000;
                15'bX1000000XXXXXXX :next_sel_i   =15'b010000000000000;
                15'b10000000XXXXXXX :next_sel_i   =15'b100000000000000;
                15'b00000000XXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b00000000XXXXX10 :next_sel_i   =15'b000000000000010;
                15'b00000000XXXX100 :next_sel_i   =15'b000000000000100;
                15'b00000000XXX1000 :next_sel_i   =15'b000000000001000;
                15'b00000000XX10000 :next_sel_i   =15'b000000000010000;
                15'b00000000X100000 :next_sel_i   =15'b000000000100000;
                default             :next_sel_i   =15'b000000010000000;
            endcase
        end
        15'b000000010000000:begin
            casex(curr_req)
                15'b000000010000000 :next_sel_i   =15'b000000010000000;
                15'bXXXXXX1XXXXXXXX :next_sel_i   =15'b000000100000000;
                15'bXXXXX10XXXXXXXX :next_sel_i   =15'b000001000000000;
                15'bXXXX100XXXXXXXX :next_sel_i   =15'b000010000000000;
                15'bXXX1000XXXXXXXX :next_sel_i   =15'b000100000000000;
                15'bXX10000XXXXXXXX :next_sel_i   =15'b001000000000000;
                15'bX100000XXXXXXXX :next_sel_i   =15'b010000000000000;
                15'b1000000XXXXXXXX :next_sel_i   =15'b100000000000000;
                15'b0000000XXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b0000000XXXXXX10 :next_sel_i   =15'b000000000000010;
                15'b0000000XXXXX100 :next_sel_i   =15'b000000000000100;
                15'b0000000XXXX1000 :next_sel_i   =15'b000000000001000;
                15'b0000000XXX10000 :next_sel_i   =15'b000000000010000;
                15'b0000000XX100000 :next_sel_i   =15'b000000000100000;
                15'b0000000X1000000 :next_sel_i   =15'b000000001000000;
                default             :next_sel_i   =15'b000000100000000;
            endcase
        end
        15'b000000100000000:begin
            casex(curr_req)
                15'b000000100000000 :next_sel_i   =15'b000000100000000;
                15'bXXXXX1XXXXXXXXX :next_sel_i   =15'b000001000000000;
                15'bXXXX10XXXXXXXXX :next_sel_i   =15'b000010000000000;
                15'bXXX100XXXXXXXXX :next_sel_i   =15'b000100000000000;
                15'bXX1000XXXXXXXXX :next_sel_i   =15'b001000000000000;
                15'bX10000XXXXXXXXX :next_sel_i   =15'b010000000000000;
                15'b100000XXXXXXXXX :next_sel_i   =15'b100000000000000;
                15'b000000XXXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b000000XXXXXXX10 :next_sel_i   =15'b000000000000010;
                15'b000000XXXXXX100 :next_sel_i   =15'b000000000000100;
                15'b000000XXXXX1000 :next_sel_i   =15'b000000000001000;
                15'b000000XXXX10000 :next_sel_i   =15'b000000000010000;
                15'b000000XXX100000 :next_sel_i   =15'b000000000100000;
                15'b000000XX1000000 :next_sel_i   =15'b000000001000000;
                15'b000000X10000000 :next_sel_i   =15'b000000010000000;
                default             :next_sel_i   =15'b000001000000000;
            endcase
        end
        15'b000001000000000:begin
            casex(curr_req)
                15'b000001000000000 :next_sel_i   =15'b000001000000000;
                15'bXXXX1XXXXXXXXXX :next_sel_i   =15'b000010000000000;
                15'bXXX10XXXXXXXXXX :next_sel_i   =15'b000100000000000;
                15'bXX100XXXXXXXXXX :next_sel_i   =15'b001000000000000;
                15'bX1000XXXXXXXXXX :next_sel_i   =15'b010000000000000;
                15'b10000XXXXXXXXXX :next_sel_i   =15'b100000000000000;
                15'b00000XXXXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b00000XXXXXXXX10 :next_sel_i   =15'b000000000000010;
                15'b00000XXXXXXX100 :next_sel_i   =15'b000000000000100;
                15'b00000XXXXXX1000 :next_sel_i   =15'b000000000001000;
                15'b00000XXXXX10000 :next_sel_i   =15'b000000000010000;
                15'b00000XXXX100000 :next_sel_i   =15'b000000000100000;
                15'b00000XXX1000000 :next_sel_i   =15'b000000001000000;
                15'b00000XX10000000 :next_sel_i   =15'b000000010000000;
                15'b00000X100000000 :next_sel_i   =15'b000000100000000;
                default             :next_sel_i   =15'b000010000000000;
            endcase
        end
        15'b000010000000000:begin
            casex(curr_req)
                15'b000010000000000 :next_sel_i   =15'b000010000000000;
                15'bXXX1XXXXXXXXXXX :next_sel_i   =15'b000100000000000;
                15'bXX10XXXXXXXXXXX :next_sel_i   =15'b001000000000000;
                15'bX100XXXXXXXXXXX :next_sel_i   =15'b010000000000000;
                15'b1000XXXXXXXXXXX :next_sel_i   =15'b100000000000000;
                15'b0000XXXXXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b0000XXXXXXXXX10 :next_sel_i   =15'b000000000000010;
                15'b0000XXXXXXXX100 :next_sel_i   =15'b000000000000100;
                15'b0000XXXXXXX1000 :next_sel_i   =15'b000000000001000;
                15'b0000XXXXXX10000 :next_sel_i   =15'b000000000010000;
                15'b0000XXXXX100000 :next_sel_i   =15'b000000000100000;
                15'b0000XXXX1000000 :next_sel_i   =15'b000000001000000;
                15'b0000XXX10000000 :next_sel_i   =15'b000000010000000;
                15'b0000XX100000000 :next_sel_i   =15'b000000100000000;
                15'b0000X1000000000 :next_sel_i   =15'b000001000000000;
                default             :next_sel_i   =15'b000100000000000;
            endcase
        end
        15'b000100000000000:begin
            casex(curr_req)
                15'b000100000000000 :next_sel_i   =15'b000100000000000;
                15'bXX1XXXXXXXXXXXX :next_sel_i   =15'b001000000000000;
                15'bX10XXXXXXXXXXXX :next_sel_i   =15'b010000000000000;
                15'b100XXXXXXXXXXXX :next_sel_i   =15'b100000000000000;
                15'b000XXXXXXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b000XXXXXXXXXX10 :next_sel_i   =15'b000000000000010;
                15'b000XXXXXXXXX100 :next_sel_i   =15'b000000000000100;
                15'b000XXXXXXXX1000 :next_sel_i   =15'b000000000001000;
                15'b000XXXXXXX10000 :next_sel_i   =15'b000000000010000;
                15'b000XXXXXX100000 :next_sel_i   =15'b000000000100000;
                15'b000XXXXX1000000 :next_sel_i   =15'b000000001000000;
                15'b000XXXX10000000 :next_sel_i   =15'b000000010000000;
                15'b000XXX100000000 :next_sel_i   =15'b000000100000000;
                15'b000XX1000000000 :next_sel_i   =15'b000001000000000;
                15'b000X10000000000 :next_sel_i   =15'b000010000000000;
                default             :next_sel_i   =15'b001000000000000;
            endcase
        end
        15'b001000000000000:begin
            casex(curr_req)
                15'b001000000000000 :next_sel_i   =15'b001000000000000;
                15'bX1XXXXXXXXXXXXX :next_sel_i   =15'b010000000000000;
                15'b10XXXXXXXXXXXXX :next_sel_i   =15'b100000000000000;
                15'b00XXXXXXXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b00XXXXXXXXXXX10 :next_sel_i   =15'b000000000000010;
                15'b00XXXXXXXXXX100 :next_sel_i   =15'b000000000000100;
                15'b00XXXXXXXXX1000 :next_sel_i   =15'b000000000001000;
                15'b00XXXXXXXX10000 :next_sel_i   =15'b000000000010000;
                15'b00XXXXXXX100000 :next_sel_i   =15'b000000000100000;
                15'b00XXXXXX1000000 :next_sel_i   =15'b000000001000000;
                15'b00XXXXX10000000 :next_sel_i   =15'b000000010000000;
                15'b00XXXX100000000 :next_sel_i   =15'b000000100000000;
                15'b00XXX1000000000 :next_sel_i   =15'b000001000000000;
                15'b00XX10000000000 :next_sel_i   =15'b000010000000000;
                15'b00X100000000000 :next_sel_i   =15'b000100000000000;
                default             :next_sel_i   =15'b010000000000000;
            endcase
        end
        15'b010000000000000:begin
            casex(curr_req)
                15'b010000000000000 :next_sel_i   =15'b010000000000000;
                15'b1XXXXXXXXXXXXXX :next_sel_i   =15'b100000000000000;
                15'b0XXXXXXXXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'b0XXXXXXXXXXXX10 :next_sel_i   =15'b000000000000010;
                15'b0XXXXXXXXXXX100 :next_sel_i   =15'b000000000000100;
                15'b0XXXXXXXXXX1000 :next_sel_i   =15'b000000000001000;
                15'b0XXXXXXXXX10000 :next_sel_i   =15'b000000000010000;
                15'b0XXXXXXXX100000 :next_sel_i   =15'b000000000100000;
                15'b0XXXXXXX1000000 :next_sel_i   =15'b000000001000000;
                15'b0XXXXXX10000000 :next_sel_i   =15'b000000010000000;
                15'b0XXXXX100000000 :next_sel_i   =15'b000000100000000;
                15'b0XXXX1000000000 :next_sel_i   =15'b000001000000000;
                15'b0XXX10000000000 :next_sel_i   =15'b000010000000000;
                15'b0XX100000000000 :next_sel_i   =15'b000100000000000;
                15'b0X1000000000000 :next_sel_i   =15'b001000000000000;
                default             :next_sel_i   =15'b100000000000000;
            endcase
        end
        15'b100000000000000:begin
            casex(curr_req)
                15'b100000000000000 :next_sel_i   =15'b100000000000000;
                15'bXXXXXXXXXXXXXX1 :next_sel_i   =15'b000000000000001;
                15'bXXXXXXXXXXXXX10 :next_sel_i   =15'b000000000000010;
                15'bXXXXXXXXXXXX100 :next_sel_i   =15'b000000000000100;
                15'bXXXXXXXXXXX1000 :next_sel_i   =15'b000000000001000;
                15'bXXXXXXXXXX10000 :next_sel_i   =15'b000000000010000;
                15'bXXXXXXXXX100000 :next_sel_i   =15'b000000000100000;
                15'bXXXXXXXX1000000 :next_sel_i   =15'b000000001000000;
                15'bXXXXXXX10000000 :next_sel_i   =15'b000000010000000;
                15'bXXXXXX100000000 :next_sel_i   =15'b000000100000000;
                15'bXXXXX1000000000 :next_sel_i   =15'b000001000000000;
                15'bXXXX10000000000 :next_sel_i   =15'b000010000000000;
                15'bXXX100000000000 :next_sel_i   =15'b000100000000000;
                15'bXX1000000000000 :next_sel_i   =15'b001000000000000;
                15'bX10000000000000 :next_sel_i   =15'b010000000000000;
                default             :next_sel_i   =15'b000000000000001;
            endcase
        end
        default:next_sel_i=15'b000000000000001;
    endcase
end

end

else if(CH_NUM==16)begin:SEL16

assign  next_sel    =   next_sel_i  ;

always_comb begin
    case(curr_sel)
        16'b000000000000001:begin
            casex(curr_req)
                16'b0000000000000001:next_sel_i   =16'b0000000000000001;
                16'bXXXXXXXXXXXXXX1X:next_sel_i   =16'b0000000000000010;
                16'bXXXXXXXXXXXXX10X:next_sel_i   =16'b0000000000000100;
                16'bXXXXXXXXXXXX100X:next_sel_i   =16'b0000000000001000;
                16'bXXXXXXXXXXX1000X:next_sel_i   =16'b0000000000010000;
                16'bXXXXXXXXXX10000X:next_sel_i   =16'b0000000000100000;
                16'bXXXXXXXXX100000X:next_sel_i   =16'b0000000001000000;
                16'bXXXXXXXX1000000X:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX10000000X:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX100000000X:next_sel_i   =16'b0000001000000000;
                16'bXXXXX1000000000X:next_sel_i   =16'b0000010000000000;
                16'bXXXX10000000000X:next_sel_i   =16'b0000100000000000;
                16'bXXX100000000000X:next_sel_i   =16'b0001000000000000;
                16'bXX1000000000000X:next_sel_i   =16'b0010000000000000;
                16'bX10000000000000X:next_sel_i   =16'b0100000000000000;
                16'b100000000000000X:next_sel_i   =16'b1000000000000000;
                default             :next_sel_i   =16'b0000000000000010;
            endcase
        end
        16'b000000000000010:begin
            casex(curr_req)
                16'b0000000000000010:next_sel_i   =16'b0000000000000010;
                16'bXXXXXXXXXXXXX1XX:next_sel_i   =16'b0000000000000100;
                16'bXXXXXXXXXXXX10XX:next_sel_i   =16'b0000000000001000;
                16'bXXXXXXXXXXX100XX:next_sel_i   =16'b0000000000010000;
                16'bXXXXXXXXXX1000XX:next_sel_i   =16'b0000000000100000;
                16'bXXXXXXXXX10000XX:next_sel_i   =16'b0000000001000000;
                16'bXXXXXXXX100000XX:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX1000000XX:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX10000000XX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX100000000XX:next_sel_i   =16'b0000010000000000;
                16'bXXXX1000000000XX:next_sel_i   =16'b0000100000000000;
                16'bXXX10000000000XX:next_sel_i   =16'b0001000000000000;
                16'bXX100000000000XX:next_sel_i   =16'b0010000000000000;
                16'bX1000000000000XX:next_sel_i   =16'b0100000000000000;
                16'b10000000000000XX:next_sel_i   =16'b1000000000000000;
                16'b00000000000000X1:next_sel_i   =16'b0000000000000001;
                default             :next_sel_i   =16'b0000000000000100;
            endcase
        end
        16'b000000000000100:begin
            casex(curr_req)
                16'b0000000000000100:next_sel_i   =16'b0000000000000100;
                16'bXXXXXXXXXXXX1XXX:next_sel_i   =16'b0000000000001000;
                16'bXXXXXXXXXXX10XXX:next_sel_i   =16'b0000000000010000;
                16'bXXXXXXXXXX100XXX:next_sel_i   =16'b0000000000100000;
                16'bXXXXXXXXX1000XXX:next_sel_i   =16'b0000000001000000;
                16'bXXXXXXXX10000XXX:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX100000XXX:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX1000000XXX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX10000000XXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX100000000XXX:next_sel_i   =16'b0000100000000000;
                16'bXXX1000000000XXX:next_sel_i   =16'b0001000000000000;
                16'bXX10000000000XXX:next_sel_i   =16'b0010000000000000;
                16'bX100000000000XXX:next_sel_i   =16'b0100000000000000;
                16'b1000000000000XXX:next_sel_i   =16'b1000000000000000;
                16'b0000000000000XX1:next_sel_i   =16'b0000000000000001;
                16'b0000000000000X10:next_sel_i   =16'b0000000000000010;
                default             :next_sel_i   =16'b0000000000001000;
            endcase
        end
        16'b000000000001000:begin
            casex(curr_req)
                16'b0000000000001000:next_sel_i   =16'b0000000000001000;
                16'bXXXXXXXXXXX1XXXX:next_sel_i   =16'b0000000000010000;
                16'bXXXXXXXXXX10XXXX:next_sel_i   =16'b0000000000100000;
                16'bXXXXXXXXX100XXXX:next_sel_i   =16'b0000000001000000;
                16'bXXXXXXXX1000XXXX:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX10000XXXX:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX100000XXXX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX1000000XXXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX10000000XXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX100000000XXXX:next_sel_i   =16'b0001000000000000;
                16'bXX1000000000XXXX:next_sel_i   =16'b0010000000000000;
                16'bX10000000000XXXX:next_sel_i   =16'b0100000000000000;
                16'b100000000000XXXX:next_sel_i   =16'b1000000000000000;
                16'b000000000000XXX1:next_sel_i   =16'b0000000000000001;
                16'b000000000000XX10:next_sel_i   =16'b0000000000000010;
                16'b000000000000X100:next_sel_i   =16'b0000000000000100;
                default             :next_sel_i   =16'b0000000000010000;
            endcase
        end
        16'b000000000010000:begin
            casex(curr_req)
                16'b0000000000010000:next_sel_i   =16'b0000000000010000;
                16'bXXXXXXXXXX1XXXXX:next_sel_i   =16'b0000000000100000;
                16'bXXXXXXXXX10XXXXX:next_sel_i   =16'b0000000001000000;
                16'bXXXXXXXX100XXXXX:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX1000XXXXX:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX10000XXXXX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX100000XXXXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX1000000XXXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX10000000XXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX100000000XXXXX:next_sel_i   =16'b0010000000000000;
                16'bX1000000000XXXXX:next_sel_i   =16'b0100000000000000;
                16'b10000000000XXXXX:next_sel_i   =16'b1000000000000000;
                16'b00000000000XXXX1:next_sel_i   =16'b0000000000000001;
                16'b00000000000XXX10:next_sel_i   =16'b0000000000000010;
                16'b00000000000XX100:next_sel_i   =16'b0000000000000100;
                16'b00000000000X1000:next_sel_i   =16'b0000000000001000;
                default             :next_sel_i   =16'b0000000000100000;
            endcase
        end
        16'b000000000100000:begin
            casex(curr_req)
                16'b0000000000100000:next_sel_i   =16'b0000000000100000;
                16'bXXXXXXXXX1XXXXXX:next_sel_i   =16'b0000000001000000;
                16'bXXXXXXXX10XXXXXX:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX100XXXXXX:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX1000XXXXXX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX10000XXXXXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX100000XXXXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX1000000XXXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX10000000XXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX100000000XXXXXX:next_sel_i   =16'b0100000000000000;
                16'b1000000000XXXXXX:next_sel_i   =16'b1000000000000000;
                16'b0000000000XXXXX1:next_sel_i   =16'b0000000000000001;
                16'b0000000000XXXX10:next_sel_i   =16'b0000000000000010;
                16'b0000000000XXX100:next_sel_i   =16'b0000000000000100;
                16'b0000000000XX1000:next_sel_i   =16'b0000000000001000;
                16'b0000000000X10000:next_sel_i   =16'b0000000000010000;
                default             :next_sel_i   =16'b0000000001000000;
            endcase
        end
        16'b000000001000000:begin
            casex(curr_req)
                16'b0000000001000000:next_sel_i   =16'b0000000001000000;
                16'bXXXXXXXX1XXXXXXX:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX10XXXXXXX:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX100XXXXXXX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX1000XXXXXXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX10000XXXXXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX100000XXXXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX1000000XXXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX10000000XXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b100000000XXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b000000000XXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b000000000XXXXX10:next_sel_i   =16'b0000000000000010;
                16'b000000000XXXX100:next_sel_i   =16'b0000000000000100;
                16'b000000000XXX1000:next_sel_i   =16'b0000000000001000;
                16'b000000000XX10000:next_sel_i   =16'b0000000000010000;
                16'b000000000X100000:next_sel_i   =16'b0000000000100000;
                default             :next_sel_i   =16'b0000000010000000;
            endcase
        end
        16'b000000010000000:begin
            casex(curr_req)
                16'b0000000010000000:next_sel_i   =16'b0000000010000000;
                16'bXXXXXXX1XXXXXXXX:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX10XXXXXXXX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX100XXXXXXXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX1000XXXXXXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX10000XXXXXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX100000XXXXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX1000000XXXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b10000000XXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b00000000XXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b00000000XXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b00000000XXXXX100:next_sel_i   =16'b0000000000000100;
                16'b00000000XXXX1000:next_sel_i   =16'b0000000000001000;
                16'b00000000XXX10000:next_sel_i   =16'b0000000000010000;
                16'b00000000XX100000:next_sel_i   =16'b0000000000100000;
                16'b00000000X1000000:next_sel_i   =16'b0000000001000000;
                default             :next_sel_i   =16'b0000000100000000;
            endcase
        end
        16'b000000100000000:begin
            casex(curr_req)
                16'b0000000100000000:next_sel_i   =16'b0000000100000000;
                16'bXXXXXX1XXXXXXXXX:next_sel_i   =16'b0000001000000000;
                16'bXXXXX10XXXXXXXXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX100XXXXXXXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX1000XXXXXXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX10000XXXXXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX100000XXXXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b1000000XXXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b0000000XXXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b0000000XXXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b0000000XXXXXX100:next_sel_i   =16'b0000000000000100;
                16'b0000000XXXXX1000:next_sel_i   =16'b0000000000001000;
                16'b0000000XXXX10000:next_sel_i   =16'b0000000000010000;
                16'b0000000XXX100000:next_sel_i   =16'b0000000000100000;
                16'b0000000XX1000000:next_sel_i   =16'b0000000001000000;
                16'b0000000X10000000:next_sel_i   =16'b0000000010000000;
                default             :next_sel_i   =16'b0000001000000000;
            endcase
        end
        16'b000001000000000:begin
            casex(curr_req)
                16'b0000001000000000:next_sel_i   =16'b0000001000000000;
                16'bXXXXX1XXXXXXXXXX:next_sel_i   =16'b0000010000000000;
                16'bXXXX10XXXXXXXXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX100XXXXXXXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX1000XXXXXXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX10000XXXXXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b100000XXXXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b000000XXXXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b000000XXXXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b000000XXXXXXX100:next_sel_i   =16'b0000000000000100;
                16'b000000XXXXXX1000:next_sel_i   =16'b0000000000001000;
                16'b000000XXXXX10000:next_sel_i   =16'b0000000000010000;
                16'b000000XXXX100000:next_sel_i   =16'b0000000000100000;
                16'b000000XXX1000000:next_sel_i   =16'b0000000001000000;
                16'b000000XX10000000:next_sel_i   =16'b0000000010000000;
                16'b000000X100000000:next_sel_i   =16'b0000000100000000;
                default             :next_sel_i   =16'b0000010000000000;
            endcase
        end
        16'b000010000000000:begin
            casex(curr_req)
                16'b0000010000000000:next_sel_i   =16'b0000010000000000;
                16'bXXXX1XXXXXXXXXXX:next_sel_i   =16'b0000100000000000;
                16'bXXX10XXXXXXXXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX100XXXXXXXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX1000XXXXXXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b10000XXXXXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b00000XXXXXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b00000XXXXXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b00000XXXXXXXX100:next_sel_i   =16'b0000000000000100;
                16'b00000XXXXXXX1000:next_sel_i   =16'b0000000000001000;
                16'b00000XXXXXX10000:next_sel_i   =16'b0000000000010000;
                16'b00000XXXXX100000:next_sel_i   =16'b0000000000100000;
                16'b00000XXXX1000000:next_sel_i   =16'b0000000001000000;
                16'b00000XXX10000000:next_sel_i   =16'b0000000010000000;
                16'b00000XX100000000:next_sel_i   =16'b0000000100000000;
                16'b00000X1000000000:next_sel_i   =16'b0000001000000000;
                default             :next_sel_i   =16'b0000100000000000;
            endcase
        end
        16'b000100000000000:begin
            casex(curr_req)
                16'b0000100000000000:next_sel_i   =16'b0000100000000000;
                16'bXXX1XXXXXXXXXXXX:next_sel_i   =16'b0001000000000000;
                16'bXX10XXXXXXXXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX100XXXXXXXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b1000XXXXXXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b0000XXXXXXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b0000XXXXXXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b0000XXXXXXXXX100:next_sel_i   =16'b0000000000000100;
                16'b0000XXXXXXXX1000:next_sel_i   =16'b0000000000001000;
                16'b0000XXXXXXX10000:next_sel_i   =16'b0000000000010000;
                16'b0000XXXXXX100000:next_sel_i   =16'b0000000000100000;
                16'b0000XXXXX1000000:next_sel_i   =16'b0000000001000000;
                16'b0000XXXX10000000:next_sel_i   =16'b0000000010000000;
                16'b0000XXX100000000:next_sel_i   =16'b0000000100000000;
                16'b0000XX1000000000:next_sel_i   =16'b0000001000000000;
                16'b0000X10000000000:next_sel_i   =16'b0000010000000000;
                default             :next_sel_i   =16'b0001000000000000;
            endcase
        end
        16'b001000000000000:begin
            casex(curr_req)
                16'b0001000000000000:next_sel_i   =16'b0001000000000000;
                16'bXX1XXXXXXXXXXXXX:next_sel_i   =16'b0010000000000000;
                16'bX10XXXXXXXXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b100XXXXXXXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b000XXXXXXXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b000XXXXXXXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b000XXXXXXXXXX100:next_sel_i   =16'b0000000000000100;
                16'b000XXXXXXXXX1000:next_sel_i   =16'b0000000000001000;
                16'b000XXXXXXXX10000:next_sel_i   =16'b0000000000010000;
                16'b000XXXXXXX100000:next_sel_i   =16'b0000000000100000;
                16'b000XXXXXX1000000:next_sel_i   =16'b0000000001000000;
                16'b000XXXXX10000000:next_sel_i   =16'b0000000010000000;
                16'b000XXXX100000000:next_sel_i   =16'b0000000100000000;
                16'b000XXX1000000000:next_sel_i   =16'b0000001000000000;
                16'b000XX10000000000:next_sel_i   =16'b0000010000000000;
                16'b000X100000000000:next_sel_i   =16'b0000100000000000;
                default             :next_sel_i   =16'b0010000000000000;
            endcase
        end
        16'b010000000000000:begin
            casex(curr_req)
                16'b0010000000000000:next_sel_i   =16'b0010000000000000;
                16'bX1XXXXXXXXXXXXXX:next_sel_i   =16'b0100000000000000;
                16'b10XXXXXXXXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b00XXXXXXXXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b00XXXXXXXXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b00XXXXXXXXXXX100:next_sel_i   =16'b0000000000000100;
                16'b00XXXXXXXXXX1000:next_sel_i   =16'b0000000000001000;
                16'b00XXXXXXXXX10000:next_sel_i   =16'b0000000000010000;
                16'b00XXXXXXXX100000:next_sel_i   =16'b0000000000100000;
                16'b00XXXXXXX1000000:next_sel_i   =16'b0000000001000000;
                16'b00XXXXXX10000000:next_sel_i   =16'b0000000010000000;
                16'b00XXXXX100000000:next_sel_i   =16'b0000000100000000;
                16'b00XXXX1000000000:next_sel_i   =16'b0000001000000000;
                16'b00XXX10000000000:next_sel_i   =16'b0000010000000000;
                16'b00XX100000000000:next_sel_i   =16'b0000100000000000;
                16'b00X1000000000000:next_sel_i   =16'b0001000000000000;
                default             :next_sel_i   =16'b0100000000000000;
            endcase
        end
        16'b100000000000000:begin
            casex(curr_req)
                16'b0100000000000000:next_sel_i   =16'b0100000000000000;
                16'b1XXXXXXXXXXXXXXX:next_sel_i   =16'b1000000000000000;
                16'b0XXXXXXXXXXXXXX1:next_sel_i   =16'b0000000000000001;
                16'b0XXXXXXXXXXXXX10:next_sel_i   =16'b0000000000000010;
                16'b0XXXXXXXXXXXX100:next_sel_i   =16'b0000000000000100;
                16'b0XXXXXXXXXXX1000:next_sel_i   =16'b0000000000001000;
                16'b0XXXXXXXXXX10000:next_sel_i   =16'b0000000000010000;
                16'b0XXXXXXXXX100000:next_sel_i   =16'b0000000000100000;
                16'b0XXXXXXXX1000000:next_sel_i   =16'b0000000001000000;
                16'b0XXXXXXX10000000:next_sel_i   =16'b0000000010000000;
                16'b0XXXXXX100000000:next_sel_i   =16'b0000000100000000;
                16'b0XXXXX1000000000:next_sel_i   =16'b0000001000000000;
                16'b0XXXX10000000000:next_sel_i   =16'b0000010000000000;
                16'b0XXX100000000000:next_sel_i   =16'b0000100000000000;
                16'b0XX1000000000000:next_sel_i   =16'b0001000000000000;
                16'b0X10000000000000:next_sel_i   =16'b0010000000000000;
                default             :next_sel_i   =16'b1000000000000000;
            endcase
        end
        default:next_sel_i=16'b0000000000000001;
    endcase
end

end

endgenerate

endmodule
