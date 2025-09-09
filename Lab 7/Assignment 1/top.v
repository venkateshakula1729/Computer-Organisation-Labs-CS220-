`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:20:10 03/03/2024 
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
`define CYCLE 100000000
module top(clk, inp, ROT_A, ROT_B, next);

input clk, ROT_A, ROT_B;
input [1:0]inp;
output wire [3:0]next;

reg prev_rot_event;
wire rot_event;
reg [1:0]Y;
reg [27:0]counter=0;
reg [3:0]curr;

initial prev_rot_event = 0;
initial curr = 0;

rotary uut1(clk, ROT_A, ROT_B, rot_event);

fsm uut2(clk,curr,Y,next);

always @(posedge clk) begin
	counter <= counter + 1;
	prev_rot_event <= rot_event;
	if(prev_rot_event == 0 && rot_event == 1) begin
		Y[1:0] <= inp[1:0];
		curr <= next;
		counter <= 0;
	end
	else if(counter == `CYCLE) begin
		curr <= next;
		counter <= 0;
	end
end

endmodule
