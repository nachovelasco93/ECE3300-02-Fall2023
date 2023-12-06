`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2023 10:44:51 AM
// Design Name: 
// Module Name: uart
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


module uart
#(parameter DBIT = 8, SB_TICK = 16)
(
    input clk, reset_n,
    
    //receiver port
    output [DBIT-1:0] r_data, 
    input rd_uart,
    output rx_empty,
    input rx,
    
    //transmitter port
    input [DBIT-1:0] w_data,
    input wr_uart,
    output tx_full,
    output tx,
    
    //baud rate generator
    input [10:0] TIMER_FINAL_VALUE
    
);

//timer as baud rate generator
wire tick;
timer_input 
#(.BITS(11)) baud_rate_generator
(
    .clk(clk),
    .reset_n(reset_n),
    .enable(1'b1),
    .FINAL_VALUE(TIMER_FINAL_VALUE),
    .done(tick)
);

//Receiver
wire rx_done_tick;
wire [DBIT-1:0] rx_dout;
uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) receiver
(
    .clk(clk),
    .reset_n(reset_n),
    .rx(rx),
    .s_tick(tick),
    .rx_done_tick(rx_done_tick),
    .rx_dout(rx_dout)
);

fifo_generator_0 rx_FIFO
(
    .clk(clk),
    .srst(~reset_n),
    .din(rx_dout),
    .wr_en(rx_done_tick),
    .rd_en(rd_uart),
    .dout(r_data),
    .full(),
    .empty(rx_empty)
);

//Transmitter
wire tx_fifo_empty, tx_done_tick;
wire [DBIT-1:0] tx_din;
uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) transmitter
(
    .clk(clk),
    .reset_n(reset_n),
    .tx_start(~tx_fifo_empty),
    .tx(tx),
    .s_tick(tick),
    .tx_done_tick(tx_done_tick),
    .tx_din(tx_din)
);

fifo_generator_0 tx_FIFO
(
    .clk(clk),
    .srst(~reset_n),
    .din(w_data),
    .wr_en(wr_uart),
    .rd_en(tx_done_tick),
    .dout(tx_din),
    .full(tx_full),
    .empty(tx_fifo_empty)
);
endmodule
