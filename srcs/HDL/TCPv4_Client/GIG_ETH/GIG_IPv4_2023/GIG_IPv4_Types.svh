`ifndef _GIG_IPv4_TYPES_SVH_
`define _GIG_IPv4_TYPES_SVH_

parameter   IPv4_MTU_LEN        =   16'd1500    ;

parameter   MAC_HEAD_LEN        =   8'd14       ;
parameter   IPv4_HEAD_LEN       =   8'd20       ;
parameter   UDPv4_HEAD_LEN      =   8'd8        ;
parameter   ARP_HEAD_LEN        =   8'd28       ;
parameter   SYNC_LEN            =   8'd8        ;
parameter   UDPv4_MIN_LEN       =   16'd64-16'd18   -   IPv4_HEAD_LEN   -   UDPv4_HEAD_LEN  ;//64- (MAC_HEAD_LEN+FCS=14+4=18)-20-8 =
parameter   UDPv4_MAX_LEN       =   IPv4_MTU_LEN    -   IPv4_HEAD_LEN   -   UDPv4_HEAD_LEN  ;
parameter   ICMPv4_HEAD_LEN     =   8'd8        ;
parameter   TCPv4_HEAD_LEN      =   8'd20       ;
parameter   TCPv4_HEAD_MAX_LEN  =   8'd32       ;
parameter   TCPv4_MIN_LEN       =   16'd64-16'd18   -   IPv4_HEAD_LEN   -   TCPv4_HEAD_LEN  ;
parameter   TCPv4_MAX_LEN       =   IPv4_MTU_LEN    -   IPv4_HEAD_LEN   -   TCPv4_HEAD_LEN  ;
parameter   TCP_OPTION_SIZE     =   40          ;

parameter   IPv4_TYPE           =   16'h0800    ;
parameter   ARP_TYPE            =   16'h0806    ;
parameter   PAUSE_TYPE          =   16'h8808    ;
parameter   IPv6_TYPE           =   16'h86dd    ;

parameter   UDPv4_TYPE          =   8'h11       ;
parameter   TCPv4_TYPE          =   8'h06       ;
parameter   ICMPv4_TYPE         =   8'h01       ;
parameter   IGMPv4_TYPE         =   8'h02       ;

parameter   ARP_WAIT_CYCLE      =   125000*8    ; //1250000*8=
parameter   ARP_PRE_WAIT_CYCLE  =   6250000     ; //62500000 
parameter   IP_ARP_TRY_NUM      =   125         ;

parameter   ARP_TABLE_SIZE      =   16          ;

parameter   MAC_DELAY           =   16'd24      ;
parameter   ARP_WAIT_TICK       =   32'd12500000;

parameter   MAX_TB_AW           =   16          ;

parameter   KEEP_ALIVE_EN       =   1           ;
parameter   KEEP_ALIVE_TICK     =   32'd62500000;
parameter   integer     INIT_RTO            =   1460*10     ;
parameter   integer     TCP_WAIT_TIMEOUT    =   125000000   ;

typedef struct packed{
    logic   [47:00] Src_Mac_Addr    ;//48
    logic   [47:00] Dest_Mac_Addr   ;//48
    logic   [15:00] Type            ;//16
    }MAC_HDR_S; //48+48+16=112
    
interface MAC_HDR;
    logic       tvalid      ;
    logic       tready      ;
    MAC_HDR_S   tdata       ;
    modport M(
    output      tvalid      ,
    input       tready      , 
    output      tdata   
    );
    modport S(
    input       tvalid      ,
    output      tready      ,
    input       tdata   
    );
endinterface

typedef struct packed{
    logic   [47:00] Dest_Mac_Addr   ;//48
    logic   [15:00] Type            ;//16
    }MAC_Tx_HDR_S; //48+48+16=112

interface MAC_Tx_HDR;
    logic           tvalid      ;
    logic           tready      ;
    MAC_Tx_HDR_S    tdata       ;
    modport M(
    output      tvalid      ,
    input       tready      , 
    output      tdata   
    );
    modport S(
    input       tvalid      ,
    output      tready      ,
    input       tdata   
    );
endinterface

typedef struct  packed{
    MAC_HDR_S       Mac             ;//112
    logic   [03:00] Version         ;//4
    logic   [03:00] Head_Len        ;//4
    logic   [07:00] DSEC            ;//8
    logic   [15:00] Total_Len       ;//16
    logic   [15:00] ID              ;//16
    logic   [15:00] Flag            ;//16
    logic   [07:00] TTL             ;//8
    logic   [07:00] Protocol        ;//8
    logic   [15:00] Head_CheckSum   ;//16
    logic   [31:00] Src_IP_Addr     ;//32
    logic   [31:00] Dest_IP_Addr    ;//32
    logic   [15:00] BGHead_CheckSum ;
    }IPv4_HDR_S;//14 Bytes + 20Bytes =112+4+4+8+16+16+16+8+8+16+32+32 + 16 =272bit+16it=288bit

interface IPv4_HDR;
    logic           tvalid      ;
    logic           tready      ;
    IPv4_HDR_S      tdata       ;
    modport M(
    output      tvalid      ,
    input       tready      , 
    output      tdata       
    );
    modport S(
    input       tvalid      ,
    output      tready      ,
    input       tdata       
    );
endinterface

typedef enum bit[01:00]{
    UniCast     =   2'b00   ,
    MultiCast   =   2'b01   ,
    BroadCast   =   2'b10   
    }UDPv4_Cast;
    
typedef struct  packed{
    logic   [03:00] Head_Len        ;//4
    logic   [15:00] Total_Len       ;//16
    logic   [07:00] Protocol        ;//8
//    logic   [15:00] Head_CheckSum   ;//16
    logic   [31:00] Src_IP_Addr     ;//32
    logic   [31:00] Dest_IP_Addr    ;//32
//    logic   [15:00] BGHead_CheckSum ;//16
    UDPv4_Cast      UDPv4Cast       ;//2
    }IPv4_Tx_HDR_S;//4+4+8+16+8+8+16+32+32 +16+2= 32+16+16+32+32 +18=32*4+16=128+18=146

typedef struct  packed{
    logic   [47:00] Dest_Mac_Addr   ;
    logic   [03:00] Head_Len        ;//4
    logic   [15:00] Total_Len       ;//16
    logic   [07:00] Protocol        ;//8
    logic   [31:00] Src_IP_Addr     ;//32
    logic   [31:00] Dest_IP_Addr    ;//32
    }IPv4_Post_HDR_S;//4+4+8+16+8+8+16+32+32 +16+2= 32+16+16+32+32 +18=32*4+16=128+18=146


interface IPv4_Tx_HDR;
    logic           tvalid      ;
    logic           tready      ;
    IPv4_Tx_HDR_S   tdata       ;
    modport M(
    output      tvalid      ,
    input       tready      , 
    output      tdata       
    );
    modport S(
    input       tvalid      ,
    output      tready      ,
    input       tdata       
    );
endinterface

interface IPv4_Post_HDR;
    logic           tvalid      ;
    logic           tready      ;
    IPv4_Post_HDR_S tdata       ;
    modport M(
    output      tvalid      ,
    input       tready      , 
    output      tdata       
    );
    modport S(
    input       tvalid      ,
    output      tready      ,
    input       tdata       
    );
endinterface

typedef struct packed{
    logic           tvalid          ;
    logic           tlast           ;
    logic   [07:00] tdata           ;//16
    logic           tuser           ;
    }MAC_PLD_NB_S ;
    
typedef struct packed{
    logic           tvalid          ;
    logic           tlast           ;
    logic   [07:00] tdata           ;//16
    }AXIS8_PLD_NB_S ;
    
typedef struct packed{
    logic           tlast           ;
    logic   [07:00] tdata           ;//16
    }AXIS8_PLD_S;

interface AXIS8;
    logic           tvalid      ;
    logic           tready      ;
    logic   [07:00] tdata       ;
    logic           tlast       ;
    modport M(
    output      tvalid      ,
    input       tready      , 
    output      tdata       ,
    output      tlast       
    );
    modport S(
    input       tvalid      ,
    output      tready      ,
    input       tdata       ,
    input       tlast       
    );
endinterface

typedef struct  packed{
    MAC_HDR_S       Mac             ;
    logic   [15:00] Hard_Type       ;
    logic   [15:00] Protocol        ;
    logic   [07:00] Hardware_Size   ;
    logic   [07:00] Protocol_Size   ;
    logic   [15:00] Opcode          ;
    logic   [47:00] Sender_Mac_Addr ;
    logic   [31:00] Sender_IP_Addr  ;
    logic   [47:00] Target_Mac_Addr ;
    logic   [31:00] Target_IP_Addr  ;
    }ARP_HDR_S;//20 Byte


typedef struct  packed{
    logic   [47:00] Dest_Mac_Addr   ;
    logic   [15:00] Hard_Type       ;
    logic   [15:00] Protocol        ;
    logic   [07:00] Hardware_Size   ;
    logic   [07:00] Protocol_Size   ;
    logic   [15:00] Opcode          ;
    logic   [47:00] Sender_Mac_Addr ;
    logic   [31:00] Sender_IP_Addr  ;
    logic   [47:00] Target_Mac_Addr ;
    logic   [31:00] Target_IP_Addr  ;
    }ARP_Tx_HDR_S;//20 Byte

interface ARP_Tx_HDR;
    logic           tvalid      ;
    ARP_Tx_HDR_S    tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    input           tready      , 
    output          tdata       
    );
    modport S(
    input           tvalid      ,
    output          tready      ,
    input           tdata       
    );
endinterface

typedef struct  packed{
    IPv4_HDR_S      IP          ;
    logic   [15:00] Src_Port    ;
    logic   [15:00] Dest_Port   ;
    logic   [15:00] Length      ;
    logic   [15:00] CheckSum    ;
    }UDPv4_HDR_S    ;

interface UDPv4_HDR;
    logic           tvalid      ;
    UDPv4_HDR_S     tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    input           tready      , 
    output          tdata       
    );
    modport S(
    input           tvalid      ,
    output          tready      ,
    input           tdata       
    );
endinterface

typedef struct  packed{
    logic   [31:00] Dest_IP_Addr; //32
    logic   [31:00] Src_IP_Addr ; //32
    logic   [15:00] Dest_Port   ; //16
    logic   [15:00] Src_Port    ; //16
    logic   [15:00] Length      ; //16
    UDPv4_Cast      Cast        ; //2
    }UDPv4_TX_HDR_S ; //32*2+16*3+2= 64+48+2 =114

typedef struct  packed{
    logic   [31:00] Dest_IP_Addr    ; //32
    logic   [31:00] Src_IP_Addr     ; //32
    logic   [15:00] Length          ; //16
    UDPv4_Cast      Cast            ; //2
    }UDPv4_IPv4_HDR_S ; //32*2+16*3+2= 64+48+2 =114
    
interface UDPv4_TX_HDR;
    logic           tvalid      ;
    UDPv4_TX_HDR_S  tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

typedef struct  packed{
    logic   [31:00] Dest_IP_Addr; //32
    logic   [31:00] Src_IP_Addr ; //32
    logic   [15:00] Dest_Port   ; //16
    logic   [15:00] Src_Port    ; //16
    logic   [15:00] Length      ; //16
    logic   [15:00] CheckSum    ;
    UDPv4_Cast      Cast        ; //2
    }UDPv4_INT_HDR_S ; //32*2+16*3+2= 64+48+2 =114

interface UDPv4_INT_HDR;
    logic           tvalid      ;
    UDPv4_INT_HDR_S tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

/*
interface TCPv4_HDR_Option;
    logic           tvalid      ;
    logic   [07:00] 
endinterface

*/

typedef enum bit[11:00]{
    Flag_Fin        =   12'b0000_0000_0001  ,
    Flag_Syn        =   12'b0000_0000_0010  ,
    Flag_Reset      =   12'b0000_0000_0100  ,
    Flag_Push       =   12'b0000_0000_1000  ,
    Flag_Ack        =   12'b0000_0001_0000  ,
    Flag_Urgent     =   12'b0000_0010_0000  ,
    Flag_ECN_Echo   =   12'b0000_0100_0000  ,
    Flag_CWR        =   12'b0000_1000_0000  ,
    Flag_Accu_Ecn   =   12'b0001_0000_0000  
    }TCP_Flags_E;

typedef struct  packed {
    logic   [02:00] Rsv     ;
    logic           Accu_Ecn;
    logic           CWR     ;
    logic           ECN_Echo;
    logic           Urgent  ;
    logic           Ack     ;
    logic           Push    ;
    logic           Reset   ;
    logic           Syn     ;
    logic           Fin     ;
    }TCP_Flags;

typedef struct  packed{
    logic   [31:00] Dest_IP_Addr    ; //32
    logic   [31:00] Src_IP_Addr     ; //32
    logic   [15:00] Length          ; //16
    }TCPv4_IPv4_HDR_S ; //32*2+16*3+2= 64+48+2 =114
    
typedef struct  packed{
    IPv4_HDR_S      IP              ;//
    logic   [15:00] Src_Port        ;//16
    logic   [15:00] Dest_Port       ;//16
    logic   [31:00] Seq_Num         ;//32
    logic   [31:00] Ack_Num         ;//32
    logic   [03:00] Head_Len        ;//6
    TCP_Flags       Flags           ;//10
    logic   [15:00] Window_Size     ;//Window Size Value 16
    logic   [15:00] CheckSum        ;//16
    logic   [15:00] Urgent_Point    ;//16
    logic   [03:00] Option_Len      ;//6
//    logic   [15:00] Head_CheckSum   ;//16
    logic   [15:00] Length          ;//Addition 16
    logic           MSS_Valid       ;
    logic   [15:00] MSS_Value       ;
    logic           WinScale_Valid  ;
    logic   [07:00] WinScale_Value  ;
    logic           SACK_PERM       ;
    logic           SACK_Valid      ;
    logic   [31:00] SACK_SLE        ;
    logic   [31:00] SACK_SRE        ;
    logic           TS_Valid        ;
    logic   [31:00] TS_Value        ;
    logic   [31:00] TS_EchoR        ;
    }TCPv4_HDR_S;//


typedef struct  packed{
    logic   [31:00] Dest_IP_Addr    ;//32
    logic   [31:00] Src_IP_Addr     ;//32
    logic   [15:00] Dest_Port       ;
    logic   [15:00] Src_Port        ;
    logic   [15:00] Length          ;
    logic   [31:00] Seq_Num         ;//32
    logic   [31:00] Ack_Num         ;//32
    logic   [03:00] Opt_Len         ;//6
    TCP_Flags       Flags           ;//10
    logic   [15:00] Window_Size     ;//Window Size Value 16
    logic   [15:00] Urgent_Point    ;//16
    logic   [319:0] Options         ;
    }TCPv4_TX_HDR_S; //32*4+16*6=32*7=224

typedef struct  packed{
    logic   [31:00] Dest_IP_Addr    ;//32
    logic   [31:00] Src_IP_Addr     ;//32
    logic   [15:00] Dest_Port       ;
    logic   [15:00] Src_Port        ;
    logic   [15:00] Length          ;
    logic   [31:00] Seq_Num         ;//32
    logic   [31:00] Ack_Num         ;//32
    logic   [03:00] Head_Len        ;//6
    TCP_Flags       Flags           ;//10
    logic   [15:00] Window_Size     ;//Window Size Value 16
    logic   [15:00] Urgent_Point    ;//16
    logic   [15:00] CheckSum        ;
    }TCPv4_INT_HDR_S; //32*4+16*7=32*7=224

typedef struct  packed{
    IPv4_HDR_S      IP          ;
    logic   [07:00] Type        ;
    logic   [07:00] Code        ;
    logic   [15:00] CheckSum    ;
    logic   [15:00] IDBE        ;
    logic   [15:00] IDLE        ;
    logic   [15:00] SNBE        ;
    logic   [15:00] SNLE        ;
    }ICMPv4_HDR_S;

interface TCPv4_HDR;
    logic           tvalid      ;
    TCPv4_HDR_S     tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

interface TCPv4_TX_HDR;
    logic           tvalid      ;
    TCPv4_TX_HDR_S  tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

interface TCPv4_INT_HDR;
    logic           tvalid      ;
    TCPv4_INT_HDR_S tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

interface ICMPv4_HDR;
    logic           tvalid      ;
    ICMPv4_HDR_S    tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

typedef struct  packed{
    logic   [31:00] Dest_IP_Addr; //32
    logic   [31:00] Src_IP_Addr ; //32
    logic   [15:00] Length      ;
    logic   [07:00] Type        ;
    logic   [07:00] Code        ;
    logic   [15:00] CheckSum    ;
    logic   [15:00] IDBE        ;
    logic   [15:00] SNBE        ;
    }ICMPv4_Tx_HDR_S;

typedef struct  packed{
    logic   [31:00] Dest_IP_Addr    ; //32
    logic   [31:00] Src_IP_Addr     ; //32
    logic   [15:00] Length          ; //16
    }ICMPv4_IPv4_HDR_S ; //32*2+16*3+2= 64+48+2 =114
    
interface ICMPv4_Tx_HDR;
    logic           tvalid      ;
    ICMPv4_Tx_HDR_S tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface


typedef struct packed{
    logic   [31:00] IP_Addr     ;//16
    }IPv4_ARP_REQ_S;
    
interface IPv4_ARP_REQ;
    logic           tvalid      ;
    IPv4_ARP_REQ_S  tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    input           tready      , 
    output          tdata       
    );
    modport S(
    input           tvalid      ,
    output          tready      ,
    input           tdata       
    );
endinterface


typedef struct  packed{
    logic   [31:00] IP_Addr     ;
    logic   [47:00] Mac_Addr    ;
    logic           Mac_IP_Valid;
    }ARP_IPv4_MAP_S;
    
interface IPv4_ARP_GRAND    ;
    logic           tvalid      ;
    ARP_IPv4_MAP_S  tdata       ;
    modport M(
    output          tvalid      ,
    output          tdata       
    );
    modport S(
    input           tvalid      ,
    input           tdata       
    );
endinterface

interface ARP_IPv4_LUT_IN;
    logic           tvalid      ;
    ARP_IPv4_MAP_S  tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface


interface ARP_HDR;
    logic           tvalid      ;
    ARP_HDR_S       tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

typedef struct  packed{
    logic   [31:00] Seq_Num     ;
    logic   [15:00] Length      ;
    logic   [MAX_TB_AW-1:00] Addr        ;
    }TCP_TRAN_CMD_S;

interface TCP_TRAN_CMD;
    logic           tvalid      ;
    TCP_TRAN_CMD_S  tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface


typedef struct  packed{
    logic           cmd_type        ; //1 sack cmd
    logic   [31:00] left_edge_ack   ;
    logic   [31:00] right_edge      ;
    }TCP_SACK_CMD_S;

interface TCP_SACK_CMD;
    logic           tvalid      ;
    TCP_SACK_CMD_S  tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

interface TCP_LINK_CMD;
    logic           tvalid      ;
    logic   [01:00] tdata       ;
    logic           tready      ;
    modport M(
    output          tvalid      ,
    output          tdata       ,
    input           tready      
    );
    modport S(
    input           tvalid      ,
    input           tdata       ,
    output          tready      
    );
endinterface

function [03:00]    LOG2_LUT16(input    [15:00] Din);
    casex(Din)
        16'bXXXXXXXXXXXXXXX1:   return 4'd0    ;
        16'bXXXXXXXXXXXXXX10:   return 4'd1    ;
        16'bXXXXXXXXXXXXX100:   return 4'd2    ;
        16'bXXXXXXXXXXXX1000:   return 4'd3    ;
        16'bXXXXXXXXXXX10000:   return 4'd4    ;
        16'bXXXXXXXXXX100000:   return 4'd5    ;
        16'bXXXXXXXXX1000000:   return 4'd6    ;
        16'bXXXXXXXX10000000:   return 4'd7    ;
        16'bXXXXXXX100000000:   return 4'd8    ;
        16'bXXXXXX1000000000:   return 4'd9    ;
        16'bXXXXX10000000000:   return 4'd10   ;
        16'bXXXX100000000000:   return 4'd11   ;
        16'bXXX1000000000000:   return 4'd12   ;
        16'bXX10000000000000:   return 4'd13   ;
        16'bX100000000000000:   return 4'd14   ;
        16'b1000000000000000:   return 4'd15   ;
        default: return 4'd0    ;
    endcase
endfunction

`endif
