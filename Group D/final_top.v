`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2023 04:26:54 AM
// Design Name: 
// Module Name: LAB_MAYBE_TOP
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


module   final_top(
                  input clk,       // Clock input
                  input rst_n,     // Active-low reset input
                  input mode,
                  input setup,
                  input load,
                  input [3:0] digit1,
                  input [3:0] digit2,
                  input [3:0] digit3,
                  output PASS,
                  output [7:0] anode,
                  output [6:0] cathode,
                  output odp,
                  output o_audio,
                  output clk_6MHz_out,
                  output [7:0] data, // 8-bit data output
                  output rs,        // Register select output
                  output rw,        // Read/write select output
                  output en,         // Enable signal output
                  output [2:0] LED
                  );
wire new_clk;

wire [7:0] LCD_input1, LCD_input2, LCD_input3;

encrypt PASSWORD(
                .clk(clk),
                .mode(mode),
                .setup(setup),
                .load(load),
                .digit1(digit1),
                .digit2(digit2),
                .digit3(digit3),
                .PASS(PASS),
                .anode(anode),
                .cathode(cathode),
                .odp(odp),
                .LCD_digit1(LCD_input1),
                .LCD_digit2(LCD_input2),
                .LCD_digit3(LCD_input3)
                );

liangzhu_player    MUSIC(
                        .clk(clk),
                        .i_button_n(~PASS),
                        .o_audio(o_audio),
                        .clk_6MHz_out(clk_6MHz_out)
                        );

clk_divider LCD_CLK(
                   .sys_clk(clk),
                   .sys_rst(0),
                   .speed_selector(5'b00001),
                   .block_clk(new_clk)
                   );

LCD_DRIVER display
(
    .clk(new_clk), //50M
	.rst_n(rst_n),
	.lcd_p(),     //Backlight Source+
	.lcd_n(),     //Backlight Source-
	.lcd_rs(rs),    //0:write order;1:write data
	.lcd_rw(rw),		//0:write data;1:read data
	.lcd_en(en),		//negedge
	.lcd_data(data),
	.digit1(LCD_input1),
	.digit2(LCD_input2),
	.digit3(LCD_input3)
    );

assign LED=3'b111;

endmodule