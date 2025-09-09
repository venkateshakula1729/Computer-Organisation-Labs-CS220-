`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:22:11 02/10/2024 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top(clk, ROT_A, ROT_B, led);
input clk, ROT_A, ROT_B;
wire rot_event, rot_dir;
output wire [7:0] led;
	rotary uut1(.clk(clk),
					.ROT_A(ROT_A),
					.ROT_B(ROT_B),
					.rot_event(rot_event),
					.rot_dir(rot_dir));
	ripple uut2(.clk(clk),
					.rot_event(rot_event),
					.rot_dir(rot_dir),
					.led(led));
endmodule
