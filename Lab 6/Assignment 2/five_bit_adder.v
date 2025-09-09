`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:54 02/24/2024 
// Design Name: 
// Module Name:    five_bit_adder 
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
module five_bit_adder(temp, xin, yin, xsum, ysum);

input [3:0] xin;
input [3:0] yin;
input [3:0] temp;
output wire [4:0] xsum;
output wire [4:0] ysum;

wire [4:0] xcarry;
wire [4:0] ycarry;
wire sign;
wire [1:0] xadd;
wire [1:0] yadd;

assign sign=temp[0];
assign xadd[1]=temp[3]&(~temp[1]);
assign xadd[0]=temp[2]&(~temp[1]);
assign yadd[1]=temp[3]&temp[1];
assign yadd[0]=temp[2]&temp[1];

full_adder FA0(xin[0],xadd[0],sign,sign,xsum[0],xcarry[0]);
full_adder FA1(xin[1],xadd[1],xcarry[0],sign,xsum[1],xcarry[1]);
full_adder FA2(xin[2],0,xcarry[1],sign,xsum[2],xcarry[2]);
full_adder FA3(xin[3],0,xcarry[2],sign,xsum[3],xcarry[3]);
full_adder FA4(0,0,xcarry[3],sign,xsum[4],xcarry[4]);

full_adder FA5(yin[0],yadd[0],sign,sign,ysum[0],ycarry[0]);
full_adder FA6(yin[1],yadd[1],ycarry[0],sign,ysum[1],ycarry[1]);
full_adder FA7(yin[2],0,ycarry[1],sign,ysum[2],ycarry[2]);
full_adder FA8(yin[3],0,ycarry[2],sign,ysum[3],ycarry[3]);
full_adder FA9(0,0,ycarry[3],sign,ysum[4],ycarry[4]);

endmodule