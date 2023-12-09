`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 05:47:36 PM
// Design Name: 
// Module Name: digit_to_LCD
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


module digit_to_LCD(
                    input [3:0] HEX,
                    output [7:0] LCD
                    );
reg [7:0] LCD_tmp;

always@(HEX)
begin
    case(HEX)
        4'h0:
            LCD_tmp=8'b00110000;
        4'h1:
            LCD_tmp=8'b00110001;
        4'h2:
            LCD_tmp=8'b00110010;
        4'h3:
            LCD_tmp=8'b00110011;
        4'h4:
            LCD_tmp=8'b00110100;
        4'h5:
            LCD_tmp=8'b00110101;
        4'h6:
            LCD_tmp=8'b00110110;
        4'h7:
            LCD_tmp=8'b00110111;
        4'h8:
            LCD_tmp=8'b00111000;
        4'h9:
            LCD_tmp=8'b00111001;
        4'hA:
            LCD_tmp=8'b01000001;
        4'hB:
            LCD_tmp=8'b01000010;
        4'hC:
            LCD_tmp=8'b01000011;
        4'hD:
            LCD_tmp=8'b01000100;
        4'hE:
            LCD_tmp=8'b01000101;
        4'hF:
            LCD_tmp=8'b01000110;
        default:
            LCD_tmp=7'b00110000;
    endcase    
end
assign LCD=LCD_tmp;
endmodule
