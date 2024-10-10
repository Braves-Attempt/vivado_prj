`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: verycv@outlook.com
// 
// Create Date: 2020/12/22 10:03:01
// Design Name: 
// Module Name: Encoder
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


module Encoder#(
    parameter   DW      =   8   
    )(
    input   wire    [DW-1:00]   Din     ,
    output  reg     [(($clog2(DW)<1)?1:$clog2(DW))-1:00]   Dout    
    );

generate 
if(DW==1) begin:DW1_GEN
always_comb begin
    casex(Din)
        1'b1        :   Dout    =   1'b0;
        default     :   Dout    =   1'b0;
    endcase
end

end
else if(DW==2) begin:DW2_GEN
always_comb begin
    casex(Din)
        2'bX1       :   Dout    =   1'd0    ;
        2'b10       :   Dout    =   1'd1    ;
        default     :   Dout    =   1'd0    ;
    endcase
end

end
else if(DW==3) begin:DW3_GEN
always_comb begin
    casex(Din)
        3'bXX1      :   Dout    =   2'd0    ;
        3'bX10      :   Dout    =   2'd1    ;
        3'b100      :   Dout    =   2'd2    ;
        default     :   Dout    =   2'd0    ;
    endcase
end

end

else if(DW==4) begin:DW4_GEN
always_comb begin
    casex(Din)
        4'bXXX1     :   Dout    =   2'd0    ;
        4'bXX10     :   Dout    =   2'd1    ;
        4'bX100     :   Dout    =   2'd2    ;
        4'b1000     :   Dout    =   2'd3    ;
        default     :   Dout    =   2'd0    ;
    endcase
end

end

else if(DW==5) begin:DW5_GEN
always_comb begin
    casex(Din)
        5'bXXXX1    :   Dout    =   3'd0    ;
        5'bXXX10    :   Dout    =   3'd1    ;
        5'bXX100    :   Dout    =   3'd2    ;
        5'bX1000    :   Dout    =   3'd3    ;
        5'b10000    :   Dout    =   3'd4    ;
        default     :   Dout    =   3'd0    ;
    endcase
end

end

else if(DW==6) begin:DW6_GEN
always_comb begin
    casex(Din)
        6'bXXXXX1   :   Dout    =   3'd0    ;
        6'bXXXX10   :   Dout    =   3'd1    ;
        6'bXXX100   :   Dout    =   3'd2    ;
        6'bXX1000   :   Dout    =   3'd3    ;
        6'bX10000   :   Dout    =   3'd4    ;
        6'b100000   :   Dout    =   3'd5    ;
        default     :   Dout    =   3'd0    ;
    endcase
end

end

else if(DW==7) begin:DW7_GEN
always_comb begin
    casex(Din)
        7'bXXXXXX1  :   Dout    =   3'd0    ;
        7'bXXXXX10  :   Dout    =   3'd1    ;
        7'bXXXX100  :   Dout    =   3'd2    ;
        7'bXXX1000  :   Dout    =   3'd3    ;
        7'bXX10000  :   Dout    =   3'd4    ;
        7'bX100000  :   Dout    =   3'd5    ;
        7'b1000000  :   Dout    =   3'd6    ;
        default     :   Dout    =   3'd0    ;
    endcase
end

end

else if(DW==8) begin:DW8_GEN
always_comb begin
    casex(Din)
        8'bXXXXXXX1 :   Dout    =   3'd0    ;
        8'bXXXXXX10 :   Dout    =   3'd1    ;
        8'bXXXXX100 :   Dout    =   3'd2    ;
        8'bXXXX1000 :   Dout    =   3'd3    ;
        8'bXXX10000 :   Dout    =   3'd4    ;
        8'bXX100000 :   Dout    =   3'd5    ;
        8'bX1000000 :   Dout    =   3'd6    ;
        8'b10000000 :   Dout    =   3'd7    ;
        default     :   Dout    =   3'd0    ;
    endcase
end

end

else if(DW==9) begin:DW9_GEN
always_comb begin
    casex(Din)
        9'bXXXXXXXX1    :   Dout    =   4'd0    ;
        9'bXXXXXXX10    :   Dout    =   4'd1    ;
        9'bXXXXXX100    :   Dout    =   4'd2    ;
        9'bXXXXX1000    :   Dout    =   4'd3    ;
        9'bXXXX10000    :   Dout    =   4'd4    ;
        9'bXXX100000    :   Dout    =   4'd5    ;
        9'bXX1000000    :   Dout    =   4'd6    ;
        9'bX10000000    :   Dout    =   4'd7    ;
        9'b100000000    :   Dout    =   4'd8    ;
        default         :   Dout    =   4'd0    ;
    endcase
end

end

else if(DW==10) begin:DW10_GEN
always_comb begin
    casex(Din)
        10'bXXXXXXXXX1  :   Dout    =   4'd0    ;
        10'bXXXXXXXX10  :   Dout    =   4'd1    ;
        10'bXXXXXXX100  :   Dout    =   4'd2    ;
        10'bXXXXXX1000  :   Dout    =   4'd3    ;
        10'bXXXXX10000  :   Dout    =   4'd4    ;
        10'bXXXX100000  :   Dout    =   4'd5    ;
        10'bXXX1000000  :   Dout    =   4'd6    ;
        10'bXX10000000  :   Dout    =   4'd7    ;
        10'bX100000000  :   Dout    =   4'd8    ;
        10'b1000000000  :   Dout    =   4'd9    ;
        default         :   Dout    =   4'd0    ;
    endcase
end

end

else if(DW==11) begin:DW11_GEN
always_comb begin
    casex(Din)
        11'bXXXXXXXXXX1 :   Dout    =   4'd0    ;
        11'bXXXXXXXXX10 :   Dout    =   4'd1    ;
        11'bXXXXXXXX100 :   Dout    =   4'd2    ;
        11'bXXXXXXX1000 :   Dout    =   4'd3    ;
        11'bXXXXXX10000 :   Dout    =   4'd4    ;
        11'bXXXXX100000 :   Dout    =   4'd5    ;
        11'bXXXX1000000 :   Dout    =   4'd6    ;
        11'bXXX10000000 :   Dout    =   4'd7    ;
        11'bXX100000000 :   Dout    =   4'd8    ;
        11'bX1000000000 :   Dout    =   4'd9    ;
        11'b10000000000 :   Dout    =   4'd10   ;
        default         :   Dout    =   4'd0    ;
    endcase
end

end

else if(DW==12) begin:DW12_GEN
always_comb begin
    casex(Din)
        12'bXXXXXXXXXXX1    :   Dout    =   4'd0    ;
        12'bXXXXXXXXXX10    :   Dout    =   4'd1    ;
        12'bXXXXXXXXX100    :   Dout    =   4'd2    ;
        12'bXXXXXXXX1000    :   Dout    =   4'd3    ;
        12'bXXXXXXX10000    :   Dout    =   4'd4    ;
        12'bXXXXXX100000    :   Dout    =   4'd5    ;
        12'bXXXXX1000000    :   Dout    =   4'd6    ;
        12'bXXXX10000000    :   Dout    =   4'd7    ;
        12'bXXX100000000    :   Dout    =   4'd8    ;
        12'bXX1000000000    :   Dout    =   4'd9    ;
        12'bX10000000000    :   Dout    =   4'd10   ;
        12'b100000000000    :   Dout    =   4'd11   ;
        default             :   Dout    =   4'd0    ;
    endcase
end

end

else if(DW==13) begin:DW13_GEN
always_comb begin
    casex(Din)
        13'bXXXXXXXXXXXX1   :   Dout    =   4'd0    ;
        13'bXXXXXXXXXXX10   :   Dout    =   4'd1    ;
        13'bXXXXXXXXXX100   :   Dout    =   4'd2    ;
        13'bXXXXXXXXX1000   :   Dout    =   4'd3    ;
        13'bXXXXXXXX10000   :   Dout    =   4'd4    ;
        13'bXXXXXXX100000   :   Dout    =   4'd5    ;
        13'bXXXXXX1000000   :   Dout    =   4'd6    ;
        13'bXXXXX10000000   :   Dout    =   4'd7    ;
        13'bXXXX100000000   :   Dout    =   4'd8    ;
        13'bXXX1000000000   :   Dout    =   4'd9    ;
        13'bXX10000000000   :   Dout    =   4'd10   ;
        13'bX100000000000   :   Dout    =   4'd11   ;
        13'b1000000000000   :   Dout    =   4'd12   ;
        default             :   Dout    =   4'd0    ;
    endcase
end

end

else if(DW==14) begin:DW14_GEN
always_comb begin
    casex(Din)
        14'bXXXXXXXXXXXXX1  :   Dout    =   4'd0    ;
        14'bXXXXXXXXXXXX10  :   Dout    =   4'd1    ;
        14'bXXXXXXXXXXX100  :   Dout    =   4'd2    ;
        14'bXXXXXXXXXX1000  :   Dout    =   4'd3    ;
        14'bXXXXXXXXX10000  :   Dout    =   4'd4    ;
        14'bXXXXXXXX100000  :   Dout    =   4'd5    ;
        14'bXXXXXXX1000000  :   Dout    =   4'd6    ;
        14'bXXXXXX10000000  :   Dout    =   4'd7    ;
        14'bXXXXX100000000  :   Dout    =   4'd8    ;
        14'bXXXX1000000000  :   Dout    =   4'd9    ;
        14'bXXX10000000000  :   Dout    =   4'd10   ;
        14'bXX100000000000  :   Dout    =   4'd11   ;
        14'bX1000000000000  :   Dout    =   4'd12   ;
        14'b10000000000000  :   Dout    =   4'd13   ;
        default             :   Dout    =   4'd0    ;
    endcase
end

end

else if(DW==15) begin:DW15_GEN
always_comb begin
    casex(Din)
        15'bXXXXXXXXXXXXXX1 :   Dout    =   4'd0    ;
        15'bXXXXXXXXXXXXX10 :   Dout    =   4'd1    ;
        15'bXXXXXXXXXXXX100 :   Dout    =   4'd2    ;
        15'bXXXXXXXXXXX1000 :   Dout    =   4'd3    ;
        15'bXXXXXXXXXX10000 :   Dout    =   4'd4    ;
        15'bXXXXXXXXX100000 :   Dout    =   4'd5    ;
        15'bXXXXXXXX1000000 :   Dout    =   4'd6    ;
        15'bXXXXXXX10000000 :   Dout    =   4'd7    ;
        15'bXXXXXX100000000 :   Dout    =   4'd8    ;
        15'bXXXXX1000000000 :   Dout    =   4'd9    ;
        15'bXXXX10000000000 :   Dout    =   4'd10   ;
        15'bXXX100000000000 :   Dout    =   4'd11   ;
        15'bXX1000000000000 :   Dout    =   4'd12   ;
        15'bX10000000000000 :   Dout    =   4'd13   ;
        15'b100000000000000 :   Dout    =   4'd14   ;
        default             :   Dout    =   4'd0    ;
    endcase
end

end

else if(DW==16) begin:DW16_GEN
always_comb begin
    casex(Din)
        16'bXXXXXXXXXXXXXXX1:   Dout    =   4'd0    ;
        16'bXXXXXXXXXXXXXX10:   Dout    =   4'd1    ;
        16'bXXXXXXXXXXXXX100:   Dout    =   4'd2    ;
        16'bXXXXXXXXXXXX1000:   Dout    =   4'd3    ;
        16'bXXXXXXXXXXX10000:   Dout    =   4'd4    ;
        16'bXXXXXXXXXX100000:   Dout    =   4'd5    ;
        16'bXXXXXXXXX1000000:   Dout    =   4'd6    ;
        16'bXXXXXXXX10000000:   Dout    =   4'd7    ;
        16'bXXXXXXX100000000:   Dout    =   4'd8    ;
        16'bXXXXXX1000000000:   Dout    =   4'd9    ;
        16'bXXXXX10000000000:   Dout    =   4'd10   ;
        16'bXXXX100000000000:   Dout    =   4'd11   ;
        16'bXXX1000000000000:   Dout    =   4'd12   ;
        16'bXX10000000000000:   Dout    =   4'd13   ;
        16'bX100000000000000:   Dout    =   4'd14   ;
        16'b1000000000000000:   Dout    =   4'd15   ;
        default             :   Dout    =   4'd0    ;
    endcase
end

end

endgenerate

endmodule

