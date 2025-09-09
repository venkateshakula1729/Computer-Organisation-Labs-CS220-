`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:45:59 01/27/2024 
// Design Name: 
// Module Name:    RipplinLED 
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
`define SHIFT_TIME 50000000
module RipplinLED(clk, led);
input clk;
output led;
reg [7:0] led;

reg[26:0] counter;
initial counter = 27'b0;
initial led = 1;
always @(posedge clk) begin
	counter <= counter + 1;
	if(counter == `SHIFT_TIME) begin
		led[0] <= led[7];
		led[1] <= led[0];
		led[2] <= led[1];
		led[3] <= led[2];
		led[4] <= led[3];
		led[5] <= led[4];
		led[6] <= led[5];
		led[7] <= led[6];
		counter <= 0;
	end
end

endmodule
