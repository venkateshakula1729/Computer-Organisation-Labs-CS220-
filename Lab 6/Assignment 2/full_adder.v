`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:29 02/24/2024 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder(a, b, cin, sign, sum, cout
);
input a;
input b;
input cin;
input sign;
output sum;
wire sum;
output cout;
wire cout;
assign sum = a^(b^sign)^cin;
assign cout = (a & (b^sign)) | ((b^sign) & cin) | (cin & a);
endmodule
