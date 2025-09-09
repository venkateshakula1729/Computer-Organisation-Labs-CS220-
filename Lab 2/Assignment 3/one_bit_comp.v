`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:19:59 01/21/2024 
// Design Name: 
// Module Name:    one_bit_comp 
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
module one_bit_comp(a,b,lin ,ein ,gin, lout,eout,gout);
input a;
input b;
input lin;
input gin;
input ein;
output lout;
output eout;
output gout;
wire lout , eout , gout;
assign lout=(lin|(ein &(~a & b)));
assign gout=(gin |(ein &(a & ~b)));
assign eout=(ein & ((a & b)|(~a & ~b)));
endmodule
