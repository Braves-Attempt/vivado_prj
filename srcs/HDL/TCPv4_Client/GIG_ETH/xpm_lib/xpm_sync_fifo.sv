`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/29 08:43:21
// Design Name: 
// Module Name: xpm_sync_fifo
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


module xpm_sync_fifo#(
    parameter               FIFO_MEMORY_TYPE    =   "auto"  ,   //String auto, block, distributed
    parameter   integer     WRITE_DATA_WIDTH    =   32      ,
    parameter   integer     FIFO_WRITE_DEPTH    =   2048    ,
    parameter   integer     PROG_FULL_THRESH    =   2000    ,
    parameter   integer     READ_DATA_WIDTH     =   32      ,
    parameter   integer     PROG_EMPTY_THRESH   =   32      ,
    parameter   integer     WDATA_COUNT_WIDTH   =   $clog2(FIFO_WRITE_DEPTH)+1      ,   //clog2(FIFO_WRITE_DEPTH)+1
    parameter   integer     RDATA_COUNT_WIDTH   =   $clog2(WRITE_DATA_WIDTH*FIFO_WRITE_DEPTH/READ_DATA_WIDTH)+1      ,   //clog2(FIFO_WRITE_DEPTH)+1
    parameter               READ_MODE           =   "fwft"      //"fwft" or "std"
    )(
    input   wire                            sleep           ,
    input   wire                            rst             ,
    
    input   wire                            clk             ,

    input   wire                            wr_en           ,
    input   wire    [WRITE_DATA_WIDTH-1:00] din             ,
    output  wire                            full            ,

    input   wire                            rd_en           ,
    output  wire    [READ_DATA_WIDTH-1:00]  dout            ,
    output  wire                            empty           ,
    
    output  wire                            overflow        ,
    output  wire                            underflow       ,
    output  wire                            prog_empty      ,
    output  wire                            prog_full       ,
    
    output  wire                            almost_empty    ,
    output  wire                            almost_full     ,
    output  wire    [WDATA_COUNT_WIDTH-1:00]wr_data_count   ,
    output  wire    [RDATA_COUNT_WIDTH-1:00]rd_data_count   ,

    output  wire                            wr_rst_busy     ,
    output  wire                            rd_rst_busy     
    );
    
wire            data_valid  ;
wire            wr_ack      ;

xpm_fifo_sync #(
    .DOUT_RESET_VALUE       ("0"                    ),    // String
    .ECC_MODE               ("no_ecc"               ),       // String
    .FIFO_MEMORY_TYPE       (FIFO_MEMORY_TYPE       ), // String
    .FIFO_READ_LATENCY      (1                      ),     // DECIMAL
    .FIFO_WRITE_DEPTH       (FIFO_WRITE_DEPTH       ),   // DECIMAL
    .PROG_EMPTY_THRESH      (PROG_EMPTY_THRESH      ),      // DECIMAL
    .PROG_FULL_THRESH       (PROG_FULL_THRESH       ),      // DECIMAL
    .FULL_RESET_VALUE       (1                      ),
    .RD_DATA_COUNT_WIDTH    (RDATA_COUNT_WIDTH      ),   // DECIMAL
    .READ_DATA_WIDTH        (READ_DATA_WIDTH        ),      // DECIMAL
    .READ_MODE              (READ_MODE              ),         // String
    .USE_ADV_FEATURES       ("0707"                 ), // String
    .WAKEUP_TIME            (0                      ),           // DECIMAL
    .WRITE_DATA_WIDTH       (WRITE_DATA_WIDTH       ),     // DECIMAL
    .WR_DATA_COUNT_WIDTH    (WDATA_COUNT_WIDTH      )    // DECIMAL
   )xpm_fifo_sync_inst (
    .almost_empty(almost_empty),    // 1-bit output: Almost Empty : When asserted, this signal indicates that
                                    // only one more read can be performed before the FIFO goes to empty.
    
    .almost_full(almost_full),      // 1-bit output: Almost Full: When asserted, this signal indicates that
                                    // only one more write can be performed before the FIFO is full.
    
    .data_valid(),                  // 1-bit output: Read Data Valid: When asserted, this signal indicates
                                    // that valid data is available on the output bus (dout).
    
    .dbiterr(),                     // 1-bit output: Double Bit Error: Indicates that the ECC decoder detected
                                    // a double-bit error and data in the FIFO core is corrupted.
    
    .dout(dout),                   // READ_DATA_WIDTH-bit output: Read Data: The output data bus is driven
                                    // when reading the FIFO.
    
    .empty(empty),                 // 1-bit output: Empty Flag: When asserted, this signal indicates that the
                                    // FIFO is empty. Read requests are ignored when the FIFO is empty,
                                    // initiating a read while empty is not destructive to the FIFO.
    
    .full(full),                    // 1-bit output: Full Flag: When asserted, this signal indicates that the
                                    // FIFO is full. Write requests are ignored when the FIFO is full,
                                    // initiating a write when the FIFO is full is not destructive to the
                                    // contents of the FIFO.
    
    .overflow(overflow),            // 1-bit output: Overflow: This signal indicates that a write request
                                    // (wren) during the prior clock cycle was rejected, because the FIFO is
                                    // full. Overflowing the FIFO is not destructive to the contents of the
                                    // FIFO.
    
    .prog_empty(prog_empty),       // 1-bit output: Programmable Empty: This signal is asserted when the
                                    // number of words in the FIFO is less than or equal to the programmable
                                    // empty threshold value. It is de-asserted when the number of words in
                                    // the FIFO exceeds the programmable empty threshold value.
    
    .prog_full(prog_full),         // 1-bit output: Programmable Full: This signal is asserted when the
                                    // number of words in the FIFO is greater than or equal to the
                                    // programmable full threshold value. It is de-asserted when the number of
                                    // words in the FIFO is less than the programmable full threshold value.
    
    .rd_data_count(rd_data_count), // RD_DATA_COUNT_WIDTH-bit output: Read Data Count: This bus indicates the
                                    // number of words read from the FIFO.
    
    .rd_rst_busy(rd_rst_busy),     // 1-bit output: Read Reset Busy: Active-High indicator that the FIFO read
                                    // domain is currently in a reset state.
    
    .sbiterr(),                     // 1-bit output: Single Bit Error: Indicates that the ECC decoder detected
                                    // and fixed a single-bit error.
    
    .underflow(underflow),         // 1-bit output: Underflow: Indicates that the read request (rd_en) during
                                    // the previous clock cycle was rejected because the FIFO is empty. Under
                                    // flowing the FIFO is not destructive to the FIFO.
    
    .wr_ack(wr_ack),               // 1-bit output: Write Acknowledge: This signal indicates that a write
                                    // request (wr_en) during the prior clock cycle is succeeded.
    
    .wr_data_count(wr_data_count),  // WR_DATA_COUNT_WIDTH-bit output: Write Data Count: This bus indicates
                                    // the number of words written into the FIFO.
    
    .wr_rst_busy(wr_rst_busy),     // 1-bit output: Write Reset Busy: Active-High indicator that the FIFO
                                    // write domain is currently in a reset state.
    
    .din(din),                     // WRITE_DATA_WIDTH-bit input: Write Data: The input data bus used when
                                    // writing the FIFO.
    
    .injectdbiterr(1'b0),          // 1-bit input: Double Bit Error Injection: Injects a double bit error if
                                    // the ECC feature is used on block RAMs or UltraRAM macros.
    
    .injectsbiterr(1'b0),          // 1-bit input: Single Bit Error Injection: Injects a single bit error if
                                    // the ECC feature is used on block RAMs or UltraRAM macros.
    
    .rd_en(rd_en),                  // 1-bit input: Read Enable: If the FIFO is not empty, asserting this
                                    // signal causes data (on dout) to be read from the FIFO. Must be held
                                    // active-low when rd_rst_busy is active high.
    
    .rst(rst),                      // 1-bit input: Reset: Must be synchronous to wr_clk. The clock(s) can be
                                    // unstable at the time of applying reset, but reset must be released only
                                    // after the clock(s) is/are stable.
    
    .sleep(sleep),                 // 1-bit input: Dynamic power saving- If sleep is High, the memory/fifo
                                    // block is in power saving mode.
    
    .wr_clk(clk),                   // 1-bit input: Write clock: Used for write operation. wr_clk must be a
                                    // free running clock.
    
    .wr_en(wr_en)                  // 1-bit input: Write Enable: If the FIFO is not full, asserting this
                                    // signal causes data (on din) to be written to the FIFO Must be held
                                    // active-low when rst or wr_rst_busy or rd_rst_busy is active high
    
   );

endmodule
