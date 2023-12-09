`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:21:00 AM
// Design Name: 
// Module Name: up_counter
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

module up_counter
    (
    input clk,
    input rst,
    input en,
    input load,
    input [3:0] in,
    output [3:0] out
    );

reg [3:0] tmp;
    
always@(posedge clk)
begin
    if(rst)
        tmp<=0;    
    else
        begin
            if(en)
                begin
                    if(load)
                        tmp<=in;
                    else
                        tmp<=tmp+1;
                end
        end       
end

assign out=tmp;

endmodule
