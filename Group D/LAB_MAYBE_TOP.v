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


module LAB_MAYBE_TOP(
  input clk,       // Clock input
  input rst_n,     // Active-low reset input
  output [7:0] data, // 8-bit data output
  output rs,        // Register select output
  output rw,        // Read/write select output
  output en         // Enable signal output
);
wire new_clk;

wire [7:0] LCD_input1, LCD_input2;
reg [7:0] LCD_input3;
assign LCD_input1 = 8'hea;
assign LCD_input2 = "!";

always @(posedge new_clk)
begin
    LCD_input3 <= LCD_input3 + 1;
end

CLOCKWIZ newClock
 (
  .clk_12MHz(new_clk),
  .clk_50MHz(),
  .clk_in1(clk)
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

//// State machine states
//parameter IDLE = 2'b00;
//parameter SEND_CMD = 2'b01;
//parameter SEND_DATA = 2'b10;

//// Internal signals
//reg [1:0] state;

//// Hello, World! message
////reg [7:0] hello_world [0:11] = "Hello, World!";
//reg [95:0] hello_world = "Hello,World!";


//// Counter for iterating through the message
//reg [3:0] counter;
//assign rs = 1;
//assign rw = 1;
//assign en = 1;
//lcd_2(clk, rs, rw, en, data[0], data[1], data[2], data[3]);

//// Finite state machine
//always @(posedge clk or negedge rst_n) begin
//  if (~rst_n) begin
//    state <= IDLE;
//    counter <= 4'b0000;
//    rs <= 1'b0;
//    rw <= 1'b0;
//    en <= 1'b0;
//  end else begin
//    case (state)
//      IDLE: begin
//        state <= SEND_CMD;
//        rs <= 1'b0; // Command mode
//        rw <= 1'b0; // Write mode
//        en <= 1'b1; // Enable pulse
//        data <= 8'b00111000; // Function set: 8-bit, 2-line, 5x8 font
//      end
//      SEND_CMD: begin
//        state <= SEND_DATA;
//        rs <= 1'b0; // Command mode
//        rw <= 1'b0; // Write mode
//        en <= 1'b1; // Enable pulse
//        data <= 8'b00001100; // Display on, cursor off, blink off
//      end
//      SEND_DATA: begin
//        if (counter < 12) begin
//          state <= SEND_DATA;
//          rs <= 1'b1; // Data mode
//          rw <= 1'b0; // Write mode
//          en <= 1'b1; // Enable pulse
//          data <= hello_world[counter];
//          counter <= counter + 1;
//        end else begin
//          state <= IDLE;
//        end
//      end
//      default: state <= IDLE;
//    endcase
//  end
//end

endmodule
