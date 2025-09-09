`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:47 02/24/2024 
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
module top(clk,ROT_A,ROT_B,y,sum,ovf);
input clk,ROT_A,ROT_B;
input [3:0]y;
wire rot_dir,rot_event;
output wire [6:0]sum;
output wire ovf;

rotary uut1(.clk(clk),
				.ROT_A(ROT_A),
				.ROT_B(ROT_B),
				.rot_event(rot_event),
				.rot_dir(rot_dir)
);

seven_bit_adder uut2(y,clk,rot_event,rot_dir,sum,ovf);

	
				
					

endmodule
