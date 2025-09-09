`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:23:36 01/27/2024 
// Design Name: 
// Module Name:    BlinkingLED 
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

`define OFF_TIME 25000000
`define ON_TIME 50000000
module BlinkingLED(clk, led0);

input clk;
output led0;
reg led0;
reg [26:0] counter;
initial led0 = 1;
initial counter = 27'b0;
always @(posedge clk) begin
	counter <= counter+1;
	if(counter == `OFF_TIME) begin
		led0 <= 0;
	end
	if(counter == `ON_TIME) begin
		led0 <= 1;
		counter <= 0;
	end
end


endmodule
