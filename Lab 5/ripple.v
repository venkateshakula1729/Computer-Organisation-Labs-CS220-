`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:13:14 02/10/2024 
// Design Name: 
// Module Name:    ripple 
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
module ripple(clk, rot_event, rot_dir, led);
input clk, rot_event, rot_dir;
output reg [7:0] led;
reg prev_rot_event;
initial led=1;
initial prev_rot_event = 1;
always @(posedge clk) begin
	prev_rot_event<=rot_event;
	if(prev_rot_event==0 && rot_event==1) begin 
		if(rot_dir==1) begin
			led[0] <= led[7];
			led[1] <= led[0];
			led[2] <= led[1];
			led[3] <= led[2];
			led[4] <= led[3];
			led[5] <= led[4];
			led[6] <= led[5];
			led[7] <= led[6];
		end
		else if(rot_dir==0) begin
			led[0] <= led[1];
			led[1] <= led[2];
			led[2] <= led[3];
			led[3] <= led[4];
			led[4] <= led[5];
			led[5] <= led[6];
			led[6] <= led[7];
			led[7] <= led[0];
		end
	end
end


endmodule
