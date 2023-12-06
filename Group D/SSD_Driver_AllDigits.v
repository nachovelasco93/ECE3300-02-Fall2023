`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 03:50:19 AM
// Design Name: 
// Module Name: SSD_Driver_AllDigits
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


module SSD_Driver_AllDigits
    #(parameter DISP_SPEED = 99_999)
    (
        input clk, reset,
        input [3:0] ssd_driver_port_inp_first,
        input [3:0] ssd_driver_port_inp_second,
        input [3:0] ssd_driver_port_inp_third,
        input [3:0] ssd_driver_port_inp_fourth,
        input [3:0] ssd_driver_port_inp_fifth,
        input [3:0] ssd_driver_port_inp_sixth,
        input [3:0] ssd_driver_port_inp_seventh,
        input [3:0] ssd_driver_port_inp_eighth,
        input ssd_driver_port_idp,
        output [6:0] ssd_driver_port_cc,
        output ssd_driver_port_odp,
        output reg [7:0] digit
    );
    
    parameter ZERO = 7'b1000000;
    parameter ONE = 7'b1111001;
    parameter TWO = 7'b0100100;
    parameter THREE = 7'b0110000;
    parameter FOUR = 7'b0011001;
    parameter FIVE = 7'b0010010;
    parameter SIX = 7'b0000010;
    parameter SEVEN = 7'b1111000;
    parameter EIGHT = 7'b0000000;
    parameter NINE = 7'b0010000;
    parameter A = 7'b0001000;//0001000
    parameter B = 7'b0000011;//0000011
    parameter C = 7'b1000110;//1000110
    parameter D = 7'b0100001;//0100001
    parameter E = 7'b0000110;//0000110
    parameter F = 7'b0001110;//0001110
    
//    wire [19:0] RTL_TB;
//    wire RTL_TB_SEL = 0;
    reg [2:0] digit_select;
    reg [16:0] digit_timer;
    reg [6:0] ssd_driver_tmp_cc; 
    wire [7:0] ssd_driver_digit; 
    assign ssd_driver_port_odp = ssd_driver_port_idp;
    
    wire [7:0] ssd_driver_digit_first; 
    wire [7:0] ssd_driver_digit_second; 
    wire [7:0] ssd_driver_digit_third; 
    wire [7:0] ssd_driver_digit_fourth; 
    wire [7:0] ssd_driver_digit_fifth; 
    wire [7:0] ssd_driver_digit_sixth; 
    wire [7:0] ssd_driver_digit_seventh; 
    wire [7:0] ssd_driver_digit_eighth; 
    assign ssd_driver_digit_first = ssd_driver_port_inp_first;
    assign ssd_driver_digit_second = ssd_driver_port_inp_second;
    assign ssd_driver_digit_third = ssd_driver_port_inp_third;
    assign ssd_driver_digit_fourth = ssd_driver_port_inp_fourth;
    assign ssd_driver_digit_fifth = ssd_driver_port_inp_fifth;
    assign ssd_driver_digit_sixth = ssd_driver_port_inp_sixth;
    assign ssd_driver_digit_seventh = ssd_driver_port_inp_seventh;
    assign ssd_driver_digit_eighth = ssd_driver_port_inp_eighth;
    
    
		always@(posedge clk or posedge reset)
		begin
            if(reset)
            begin
              digit_select <= 0;
              digit_timer <=0;
            end
            
            else if (digit_timer == DISP_SPEED)//99_999)
            begin
               digit_select <= digit_select + 1;
               digit_timer <=0;
            end
            else
               digit_timer <= digit_timer + 1;
	    end
	    always @(*)
	    begin
	       case(digit_select)
	       3'b000 : digit = 8'b11111110;
	       3'b001 : digit = 8'b11111101;
	       3'b010 : digit = 8'b11111011;
	       3'b011 : digit = 8'b11110111;
	       3'b100 : digit = 8'b11101111;
	       3'b101 : digit = 8'b11011111;
	       3'b110 : digit = 8'b10111111;
	       3'b111 : digit = 8'b01111111;
	       default: digit = 8'b11111111;
	       endcase
	    end
	    
	
        always@(*)
		begin
		  
			case(digit_select)
			    3'b000:
			    begin
			        case(ssd_driver_port_inp_first)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
	           end
	           3'b001:
	           begin
			        case(ssd_driver_port_inp_second)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
                end
                3'b010:
	           begin
			        case(ssd_driver_port_inp_third)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
                end
                3'b011:
	           begin
			        case(ssd_driver_port_inp_fourth)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
                end
                3'b100:
	           begin
			        case(ssd_driver_port_inp_fifth)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
//                    case(ssd_driver_port_inp_fifth)
//                        0:  ssd_driver_tmp_cc = ZERO;
//                        1:  ssd_driver_tmp_cc = ONE;
                        
//                        default: ssd_driver_tmp_cc = 7'h00;	
//	               endcase
                end
                3'b101:
	           begin
			        case(ssd_driver_port_inp_sixth)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
                end
                3'b110:
	           begin
			        case(ssd_driver_port_inp_seventh)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
                end
                3'b111:
	           begin
			        case(ssd_driver_port_inp_eighth)
                        4'h0:  ssd_driver_tmp_cc = ZERO;
                        4'h1:  ssd_driver_tmp_cc = ONE;
                        4'h2:  ssd_driver_tmp_cc = TWO;
                        4'h3:  ssd_driver_tmp_cc = THREE;
                        4'h4:  ssd_driver_tmp_cc = FOUR;
                        4'h5:  ssd_driver_tmp_cc = FIVE;
                        4'h6:  ssd_driver_tmp_cc = SIX;
                        4'h7:  ssd_driver_tmp_cc = SEVEN;
                        4'h8:  ssd_driver_tmp_cc = EIGHT;
                        4'h9:  ssd_driver_tmp_cc = NINE;
                        4'hA:  ssd_driver_tmp_cc = A;
                        4'hB:  ssd_driver_tmp_cc = B;
                        4'hC:  ssd_driver_tmp_cc = C;
                        4'hD:  ssd_driver_tmp_cc = D;
                        4'hE:  ssd_driver_tmp_cc = E;
                        4'hF:  ssd_driver_tmp_cc = F;
                        default: ssd_driver_tmp_cc = 7'hZZ;	
	               endcase
                end
            endcase
            
        end
        
            

		assign 	ssd_driver_port_cc = ssd_driver_tmp_cc;

endmodule
