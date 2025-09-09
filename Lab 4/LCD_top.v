

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:26:38 02/03/2024
// Design Name:   LCD_driver
// Module Name:   /users/btech/dhruv22/Desktop/CS220/Lab4_1/LCD/LCD_driver_top.v
// Project Name:  LCD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LCD_driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module LCD_top(clk,LCD_E,LCD_RS, LCD_W, data);
	input clk;
	output LCD_E,LCD_RS, LCD_W;
	output [3:0]data;

	// Inputs
	wire [127:0] line1;
	wire [127:0] line2;
	// Outputs
	wire LCD_RS;
	wire LCD_W;
	wire LCD_E;
	wire [3:0] data;

assign line1[127:0] = "WELCOME TO CSE, ";
assign line2[127:0] = "IIT KANPUR      ";

	// Instantiate the Unit Under Test (UUT)
	LCD_driver2 uut (
		.line1(line1), 
		.line2(line2), 
		.clk(clk), 
		.LCD_RS(LCD_RS), 
		.LCD_W(LCD_W), 
		.LCD_E(LCD_E), 
		.data(data)
	);
	/*
	initial begin
		// Initialize Inputs
		
		
		line1[0:7] = 8'h57;
		line1[8:15] = 8'h45;
		line1[16:23] = 8'h4C;
		line1[24:31] = 8'h43;
		line1[32:39] = 8'h4F;
		line1[40:47] = 8'h4D;
		line1[48:55] = 8'h45;
		line1[56:63] = 8'h20;
		line1[64:71] = 8'h54;
		line1[72:79] = 8'h4F;
		line1[80:87] = 8'h20;
		line1[88:95] = 8'h43;
		line1[96:103] = 8'h53;
		line1[104:111] = 8'h45;
		line1[112:119] = 8'h2C;
		line1[120:127] = 8'h20;
		
		line2[0:7] = 8'h49;
		line2[8:15] = 8'h49;
		line2[16:23] = 8'h54;
		line2[24:31] = 8'h20;
		line2[32:39] = 8'h4B;
		line2[40:47] = 8'h41;
		line2[48:55] = 8'h4E;
		line2[56:63] = 8'h50;
		line2[64:71] = 8'h55;
		line2[72:79] = 8'h52;
		line2[80:87] = 8'h20;
		line2[88:95] = 8'h20;
		line2[96:103] = 8'h20;
		line2[104:111] = 8'h20;
		line2[112:119] = 8'h20;
		line2[120:127] = 8'h20;
		
		// Add stimulus here

	end 
	*/     
endmodule
