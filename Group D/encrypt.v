`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 12:48:43 AM
// Design Name: 
// Module Name: test
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


module   encrypt(
                input clk,
                input mode,
                input setup,
                input load,
                input [3:0] digit1,
                input [3:0] digit2,
                input [3:0] digit3,
                output PASS,
                output [7:0] anode,
                output [6:0] cathode,
                output odp,
                output [7:0] LCD_digit1,
                output [7:0] LCD_digit2,
                output [7:0] LCD_digit3
                );

wire en;
wire counter_clk;
wire [2:0] BS_clk;
wire SSD_digit_selector_clk;
wire [2:0] refreshcounter;

wire [3:0] BS1_input;
wire [3:0] BS2_input;
wire [3:0] BS3_input;

wire [3:0] BS1_output;
wire [3:0] BS2_output;
wire [3:0] BS3_output;

wire [2:0] BS1;
wire [2:0] BS2;
wire [2:0] BS3;

wire [3:0] BS_counter1_output;
wire [3:0] BS_counter2_output;
wire [3:0] BS_counter3_output;

wire [3:0] up_counter1_output;
wire [3:0] up_counter2_output;
wire [3:0] up_counter3_output;

wire [3:0] comparator_input1;
wire [3:0] comparator_input2;
wire [3:0] comparator_input3;

wire [4:0] ONE_DIGIT1;
wire [4:0] ONE_DIGIT2;
wire [4:0] ONE_DIGIT;

wire [2:0] no_pass;
wire [3:0] pass;

assign pass[3]=0;

clk_divider  COUNTER_clk(
                        .sys_clk(clk),
                        .sys_rst(0),
                        .speed_selector(5'b11000),
                        .block_clk(counter_clk)
                        );

clk_divider      BS_CLK1(
                        .sys_clk(clk),
                        .sys_rst(0),
                        .speed_selector(5'b10101),
                        .block_clk(BS_clk[0])
                        );

clk_divider      BS_CLK2(
                        .sys_clk(clk),
                        .sys_rst(0),
                        .speed_selector(5'b10110),
                        .block_clk(BS_clk[1])
                        );

clk_divider      BS_CLK3(
                        .sys_clk(clk),
                        .sys_rst(0),
                        .speed_selector(5'b10111),
                        .block_clk(BS_clk[2])
                        );

clk_divider2     SSD_CLK(
                        .clk(clk),
                        .divide_value_sel(2'b01),
                        .divided_clk(SSD_digit_selector_clk)
                        );

refresh_counter  REFRESH(
                        .refresh_clock(SSD_digit_selector_clk),
                        .refreshcounter(refreshcounter)
                        );

SSD_anode  ANODE(
                .refreshcounter(refreshcounter),
                .anode(anode)
                );

assign en= mode && setup;

up_counter   BS_COUNTER1(
                        .clk(BS_clk[0]),
                        .rst(0),
                        .en(1),
                        .load(0),
                        .in(4'b0000),
                        .out(BS_counter1_output)
                        );

up_counter   BS_COUNTER2(
                        .clk(BS_clk[1]),
                        .rst(0),
                        .en(1),
                        .load(0),
                        .in(4'b0000),
                        .out(BS_counter2_output)
                        );

up_counter   BS_COUNTER3(
                        .clk(BS_clk[2]),
                        .rst(0),
                        .en(1),
                        .load(0),
                        .in(4'b0000),
                        .out(BS_counter3_output)
                        );

assign BS1=BS_counter1_output;
assign BS2=BS_counter2_output;
assign BS3=BS_counter3_output;

barrel_shifter SCRAMBLE1(
                        .shift_rotate_sel(BS1[2]),
                        .a(BS1_input),
                        .amt({BS1[1],BS1[0]}),
                        .y(BS1_output)
                        );

barrel_shifter SCRAMBLE2(
                        .shift_rotate_sel(BS2[2]),
                        .a(BS2_input),
                        .amt({BS2[1],BS2[0]}),
                        .y(BS2_output)
                        );

barrel_shifter SCRAMBLE3(
                        .shift_rotate_sel(BS3[2]),
                        .a(BS3_input),
                        .amt({BS3[1],BS3[0]}),
                        .y(BS3_output)
                        );

up_counter  COUNTER1(
                    .clk(clk),
                    .rst(0),
                    .en(en),
                    .load(1),
                    .in(BS1_output),
                    .out(up_counter1_output)
                    );

up_counter  COUNTER2(
                    .clk(clk),
                    .rst(0),
                    .en(en),
                    .load(1),
                    .in(BS2_output),
                    .out(up_counter2_output)
                    );

up_counter  COUNTER3(
                    .clk(clk),
                    .rst(0),
                    .en(en),
                    .load(1),
                    .in(BS3_output),
                    .out(up_counter3_output)
                    );

genvar i,j,k,l;
for(i=0;i<4;i=i+1)
    begin
        DEMUX_1x2  MODE1(
                        .In(digit1[i]),
                        .Sel(mode),
                        .Out_0(comparator_input1[i]),
                        .Out_1(BS1_input[i])
                        );
    end
                  
for(j=0;j<4;j=j+1)
    begin
        DEMUX_1x2  MODE2(
                        .In(digit2[j]),
                        .Sel(mode),
                        .Out_0(comparator_input2[j]),
                        .Out_1(BS2_input[j])
                        );
    end

for(k=0;k<4;k=k+1)
    begin
        DEMUX_1x2  MODE3(
                        .In(digit3[k]),
                        .Sel(mode),
                        .Out_0(comparator_input3[k]),
                        .Out_1(BS3_input[k])
                        );
    end

comparator_4bit PASS1(
                    .clk(clk),
                    .digit1(up_counter1_output),
                    .digit2(comparator_input1),
                    .larger(no_pass[0]),
                    .smaller(no_pass[0]),
                    .equal(pass[0])
                    );

comparator_4bit PASS2(
                    .clk(clk),
                    .digit1(up_counter2_output),
                    .digit2(comparator_input2),
                    .larger(no_pass[1]),
                    .smaller(no_pass[1]),
                    .equal(pass[1])
                    );

comparator_4bit PASS3(
                    .clk(clk),
                    .digit1(up_counter3_output),
                    .digit2(comparator_input3),
                    .larger(no_pass[2]),
                    .smaller(no_pass[2]),
                    .equal(pass[2])
                    );
                                                            
SSD_digit_selector    DIGIT1(
                            .digit1({1,up_counter1_output}),
                            .digit2({1,up_counter2_output}),
                            .digit3({1,up_counter3_output}),
                            .digit4(5'h1D),
                            .digit5({0,comparator_input1}),
                            .digit6({0,comparator_input2}),
                            .digit7({0,comparator_input3}),
                            .digit8(mode),
                            .refreshcounter(refreshcounter),
                            .ONE_DIGIT(ONE_DIGIT1)
                            );

SSD_digit_selector    DIGIT2(
                            .digit1({1,up_counter1_output}),
                            .digit2({1,up_counter2_output}),
                            .digit3({1,up_counter3_output}),
                            .digit4(5'h1D),
                            .digit5(5'h07),
                            .digit6(5'h0E),
                            .digit7(5'h05),
                            .digit8(mode),
                            .refreshcounter(refreshcounter),
                            .ONE_DIGIT(ONE_DIGIT2)
                            );

for(l=0;l<5;l=l+1)
    begin
        MUX_2x1    DIGIT(
                        .I_0(ONE_DIGIT1[l]),
                        .I_1(ONE_DIGIT2[l]),
                        .Sel(mode),
                        .P(ONE_DIGIT[l])
                        );
    end
    
SSD_cathode  DISPLAY(
                    .idp(0),
                    .digit(ONE_DIGIT),
                    .cathode(cathode),
                    .odp(odp)
                    );

digit_to_LCD  LCD_DIGIT1(
                        .HEX(up_counter1_output),
                        .LCD(LCD_digit1)
                        );
                        
digit_to_LCD  LCD_DIGIT2(
                        .HEX(up_counter2_output),
                        .LCD(LCD_digit2)
                        );

digit_to_LCD  LCD_DIGIT3(
                        .HEX(up_counter3_output),
                        .LCD(LCD_digit3)
                        );

assign PASS = pass[0] && pass[1] && pass[2];

endmodule