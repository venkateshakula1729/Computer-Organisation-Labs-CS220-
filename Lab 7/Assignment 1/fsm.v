`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:08:27 03/03/2024 
// Design Name: 
// Module Name:    fsm 
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
module fsm(clk,curr,Y,next);

input clk;
input [3:0]curr;
input [1:0]Y;
output reg [3:0]next;

reg [3:0]mcode[0:12];
reg [3:0]drom1[0:3];
reg [3:0]drom2[0:3];

initial begin
	mcode[0] <= 0;
	mcode[1] <= 0;
	mcode[2] <= 0;
	mcode[3] <= 1;
	mcode[4] <= 2;
	mcode[5] <= 2;
	mcode[6] <= 2;
	mcode[7] <= 0;
	mcode[8] <= 0;
	mcode[9] <= 0;
	mcode[10] <= 3;
	mcode[11] <= 4;
	mcode[12] <= 4;
end

initial begin
	drom1[0] <= 4;
	drom1[1] <= 5;
	drom1[2] <= 6;
	drom1[3] <= 6;
	
	drom2[0] <= 11;
	drom2[1] <= 12;
	drom2[2] <= 12;
	drom2[3] <= 12;
end

//reg [3:0] temp;
always @(posedge clk) begin
	if(mcode[curr] == 0) begin
		next <= curr + 1;
	end
	else if(mcode[curr] == 1) begin
		next <= drom1[Y];
	end
	else if(mcode[curr] == 2) begin
		next <= 7;
	end
	else if(mcode[curr] == 3) begin
		next <= drom2[Y];
	end
	else if(mcode[curr] == 4) begin
		next <= 0;
	end
end

//assign next = temp;



endmodule
