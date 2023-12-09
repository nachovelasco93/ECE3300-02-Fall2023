`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:23:38 AM
// Design Name: 
// Module Name: barrel_shifter
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

module barrel_shifter
#(parameter SIZE=4)
    (
        input shift_rotate_sel,
        input [SIZE-1:0] a,
        input [$clog2(SIZE)-1:0] amt,
        output [SIZE-1:0] y
    );
    
wire [SIZE-1:0] v;
wire [2:0] u;

            MUX_2x1 V0(
                    .I_0(a[0]),
                    .I_1(a[1]),
                    .Sel(amt[0]),
                    .P(v[0])
                    );
            MUX_2x1 V1(
                    .I_0(a[1]),
                    .I_1(a[2]),
                    .Sel(amt[0]),
                    .P(v[1])
                    );
            MUX_2x1 V2(
                    .I_0(a[2]),
                    .I_1(a[3]),
                    .Sel(amt[0]),
                    .P(v[2])
                    );
                    
            MUX_2x1 U0(
                    .I_0(0),
                    .I_1(a[0]),
                    .Sel(shift_rotate_sel),
                    .P(u[0])
                    );
                    
            MUX_2x1 V3(
                    .I_0(a[3]),
                    .I_1(u[0]),
                    .Sel(amt[0]),
                    .P(v[3])
                    );             
            MUX_2x1 Y0(
                    .I_0(v[0]),
                    .I_1(v[2]),
                    .Sel(amt[1]),
                    .P(y[0])
                    );
            MUX_2x1 Y1(
                    .I_0(v[1]),
                    .I_1(v[3]),
                    .Sel(amt[1]),
                    .P(y[1])
                    );
                    
             MUX_2x1 U1(
                    .I_0(0),
                    .I_1(v[0]),
                    .Sel(shift_rotate_sel),
                    .P(u[1])
                    );        
            
            MUX_2x1 U2(
                    .I_0(0),
                    .I_1(v[1]),
                    .Sel(shift_rotate_sel),
                    .P(u[2])
                    );   
                            
            MUX_2x1 Y2(
                    .I_0(v[2]),
                    .I_1(u[1]),
                    .Sel(amt[1]),
                    .P(y[2])
                    );
            MUX_2x1 Y3(
                    .I_0(v[3]),
                    .I_1(u[2]),
                    .Sel(amt[1]),
                    .P(y[3])
                    );
            
endmodule