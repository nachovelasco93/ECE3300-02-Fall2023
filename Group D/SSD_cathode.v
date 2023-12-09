`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:41:37 AM
// Design Name: 
// Module Name: SSD_cathode
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

module SSD_cathode(
input idp,
input [4:0] digit,
output reg [6:0] cathode=0,
output odp
);

always@(digit)
begin
    case(digit)
        5'h00:
            cathode=7'b1000000;
        5'h01:
            cathode=7'b1111001;
        5'h02:
            cathode=7'b0100100;
        5'h03:
            cathode=7'b0110000;
        5'h04:
            cathode=7'b0011001;
        5'h05:
            cathode=7'b0010010;
        5'h06:
            cathode=7'b0000010;
        5'h07:
            cathode=7'b1111000;
        5'h08:
            cathode=7'b0000000;
        5'h09:
            cathode=7'b0010000;
        5'h0A:
            cathode=7'b0001000;
        5'h0B:
            cathode=7'b0000011;
        5'h0C:
            cathode=7'b0100111;
        5'h0D:
            cathode=7'b0100001;
        5'h0E:
            cathode=7'b0000110;
        5'h0F:
            cathode=7'b0001110;
        5'h10:
            cathode=7'b1011011;
        5'h11:
            cathode=7'b0011111;
        5'h12:
            cathode=7'b1110101;
        5'h13:
            cathode=7'b1111010;
        5'h14:
            cathode=7'b1101101;
        5'h15:
            cathode=7'b1110110;
        5'h16:
            cathode=7'b0111101;
        5'h17:
            cathode=7'b1101011;
        5'h18:
            cathode=7'b1101110;
        5'h19:
            cathode=7'b1111100;
        5'h1A:
            cathode=7'b0111110;
        5'h1B:
            cathode=7'b1011110;
        5'h1C:
            cathode=7'b1011101;
        5'h1D:
            cathode=7'b0110111;
        5'h1E:
            cathode=7'b0101111;
        5'h1F:
            cathode=7'b1010111;
        default:
            cathode=7'b1111111;
    endcase
end
assign odp=~idp;

endmodule