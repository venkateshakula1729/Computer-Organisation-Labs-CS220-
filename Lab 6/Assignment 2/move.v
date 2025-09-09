`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:04:39 02/24/2024 
// Design Name: 
// Module Name:    move 
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
module move(inp, clk, ROT_A, ROT_B, xout, yout);

input [3:0] inp;
input clk, ROT_A, ROT_B;
output reg [3:0] xout;
output reg [3:0] yout;

wire rot_event;
rotary uut1(clk, ROT_A, ROT_B, rot_event);
reg prev_rot_event;
initial prev_rot_event = 1;

reg [3:0] temp;
wire [4:0] xsum;
wire [4:0] ysum;

five_bit_adder uut2(temp, xout, yout, xsum, ysum);
reg ch = 0;
always @(posedge clk) begin
	prev_rot_event<=rot_event;
	if(prev_rot_event==0 && rot_event==1) begin 
		temp[3:0]<=inp[3:0];
		ch<=1;
	end
	if(ch == 1) begin
		//temp[3:0]<=inp[3:0];
		//if(rot_dir==1) begin
			//temp[3:0]=inp[3:0];
			//East
			if(temp[1]==0 && temp[0]==0) begin
				if(xsum[4]==1) begin
					xout[3:0]<=4'd15;
				end
				else begin
					xout[3:0]<=xsum[3:0];
				end
			end
			//West
			if(temp[1]==0 && temp[0]==1) begin
				if(xsum[4]==1) begin
					xout[3:0]<=4'd0;
				end
				else begin
					xout[3:0]<=xsum[3:0];
				end
			end
			//North
			if(temp[1]==1 && temp[0]==0) begin
				if(ysum[4]==1) begin
					yout[3:0]<=4'd15;
				end
				else begin
					yout[3:0]<=ysum[3:0];
				end
			end
			//South
			if(temp[1]==1 && temp[0]==1) begin
				if(ysum[4]==1) begin
					yout[3:0]<=4'd0;
				end
				else begin
					yout[3:0]<=ysum[3:0];
				end
			end
			ch<=0;
		//end
	end
end
endmodule
