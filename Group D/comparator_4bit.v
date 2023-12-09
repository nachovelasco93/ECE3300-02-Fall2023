`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:27:06 AM
// Design Name: 
// Module Name: comparator_4bit
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

module comparator_4bit
(
input clk,
input [3:0] digit1,
input [3:0] digit2,
output larger,
output smaller,
output equal
);

reg larger_tmp, smaller_tmp, equal_tmp;

always@(posedge clk)
begin
    if(digit1>digit2) larger_tmp=1;
    else larger_tmp=0;
    
    if(digit1<digit2) smaller_tmp=1;
    else smaller_tmp=0;
    
    if(digit1==digit2) equal_tmp=1;
    else equal_tmp=0;
end

assign larger=larger_tmp;
assign smaller=smaller_tmp;
assign equal=equal_tmp;
   
endmodule
