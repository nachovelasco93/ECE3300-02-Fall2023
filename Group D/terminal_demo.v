`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2023 05:22:22 PM
// Design Name: 
// Module Name: terminal_demo
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


module terminal_demo
#(parameter DISP_SPEED = 99_999)
(
    input clk, reset_n,
    
    //Receiver Port
    input rd_uart,
    output rx_empty,
    input rx,
    
    //Transmitter Port
    input [7:0] w_data, 
    input wr_uart,
    output tx_full,
    output tx,
    
    //7Seg Signals
    output [6:0] sseg,
    output [7:0] AN,
    output DP
);

//Push Buttons (debouncer/synchronizers)
//button read_uart
//(
//    .clk(clk),
//    .reset_n(reset_n),
//    .noisy(rd_uart),
//    .debounced(),
//    .p_edge(rd_uart_pedge),
//    .n_edge(),
//    ._edge()
//);
//button write_uart
//(
//    .clk(clk),
//    .reset_n(reset_n),
//    .noisy(wr_uart),
//    .debounced(),
//    .p_edge(wr_uart_pedge),
//    .n_edge(),
//    ._edge()
//);

// UART Driver
wire [7:0] r_data;
uart
#(.DBIT(8), .SB_TICK(16)) uart_driver
(
    .clk(clk),
    .reset_n(reset_n),
    .r_data(r_data),
    .rd_uart(rd_uart),
    .rx_empty(rx_empty),
    .rx(rx),
    .w_data(w_data),
    .wr_uart(wr_uart),
    .tx_full(tx_full),
    .tx(tx),
    .TIMER_FINAL_VALUE(11'd650) // baud rate = 9600 bps, use formula in notes
    
);




SSD_Driver_AllDigits
    #(.DISP_SPEED(DISP_SPEED)) ssd_driver
    (
        .clk(clk), 
        .reset(~reset_n),
        .ssd_driver_port_inp_first({ 1'b1 , w_data[3:0] , 1'b0 }),
        .ssd_driver_port_inp_second({ 1'b1 , w_data[7:4] , 1'b0 }),
        .ssd_driver_port_inp_third(6'd0),
        .ssd_driver_port_inp_fourth(6'd0),
        .ssd_driver_port_inp_fifth(6'd0),
        .ssd_driver_port_inp_sixth(6'd0),
        .ssd_driver_port_inp_seventh({ ~rx_empty , r_data[3:0] , 1'b0 }),
        .ssd_driver_port_inp_eighth({ ~rx_empty , r_data[7:4] , 1'b0 }),
        .ssd_driver_port_idp(1),
        .ssd_driver_port_cc(sseg),
        .ssd_driver_port_odp(DP),
        .digit(AN)
    );
endmodule
