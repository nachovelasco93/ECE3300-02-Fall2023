`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2023 11:04:48 PM
// Design Name: 
// Module Name: DEMUX_1x2
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


module DEMUX_1x2(
                input In,
                input Sel,
                output Out_0,
                output Out_1
                );

assign Out_0 = In && ~Sel;
assign Out_1 = In && Sel;
                
endmodule
