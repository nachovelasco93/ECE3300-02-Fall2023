`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:31:30 AM
// Design Name: 
// Module Name: clk_divider2
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

module clk_divider2(
                    input clk,
                    input [1:0] divide_value_sel,
                    output reg divided_clk=0
                    );

integer Divide_Value=0;
integer counter_value=0;
                    
always@(posedge clk)
begin
    case(divide_value_sel)
        2'b00:
            Divide_Value=4999;
        2'b01:
            Divide_Value=49999;
        2'b10:
            Divide_Value=499999;
        2'b11:
            Divide_Value=4999999;


        default:
            Divide_Value=49999;
    endcase
    
    if(counter_value==Divide_Value)
    begin
        counter_value<=0;
        divided_clk<=~divided_clk;
    end
    else
    begin
        counter_value<=counter_value+1;
        divided_clk<=divided_clk;
    end
end                    

endmodule