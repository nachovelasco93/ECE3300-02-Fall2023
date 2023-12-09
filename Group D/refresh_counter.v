`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:32:57 AM
// Design Name: 
// Module Name: refresh_counter
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

module refresh_counter(
input refresh_clock,
output reg [2:0] refreshcounter=0
);

always@(posedge refresh_clock) refreshcounter<=refreshcounter+1;
endmodule