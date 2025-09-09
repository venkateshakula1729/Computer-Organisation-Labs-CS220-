`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:45 03/11/2024 
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
module top(clk, inp, PB1, PB2, ROT_A, ROT_B, LCD_E,LCD_RS, LCD_W, val);

input clk, ROT_A, ROT_B, PB1, PB2;
input [3:0] inp;

output wire LCD_E, LCD_RS, LCD_W;
output [3:0] val;

reg [2:0] cmd;
reg [3:0] count;
reg prev_rot_event;
wire rot_event;

reg [4:0] read_addr1;
reg [4:0] read_addr2;
reg [4:0] write_addr;

reg [15:0] write_data;
wire [15:0] write_data_bus;
wire [15:0] bus1;
wire [15:0] bus2;

reg [15:0] reg_file [0:31];
reg [7:0] deci[0:9];
reg [0:127] first_line;
reg [0:127] second_line;
reg display_start;
wire display_end;
reg input_done;
wire [15:0] add;
wire [15:0] sub;
wire [15:0] shift;
reg [3:0] bit_shift;
reg flag=1;

initial begin
	prev_rot_event = 0;
	count=0;
	display_start=0;
	//input_done=0;
	//display_end=0;
	deci[0] = 8'd48;
	deci[1] = 8'd49;
	deci[2] = 8'd50;
	deci[3] = 8'd51;
	deci[4] = 8'd52;
	deci[5] = 8'd53;
	deci[6] = 8'd54;
	deci[7] = 8'd55;
	deci[8] = 8'd56;
	deci[9] = 8'd57;
end

initial begin
	reg_file[0] = 16'd0;
	reg_file[1] = 16'd0;
	reg_file[2] = 16'd0;
	reg_file[3] = 16'd0;
	reg_file[4] = 16'd0;
	reg_file[5] = 16'd0;
	reg_file[6] = 16'd0;
	reg_file[7] = 16'd0;
	reg_file[8] = 16'd0;
	reg_file[9] = 16'd0;
	reg_file[10] = 16'd0;
	reg_file[11] = 16'd0;
	reg_file[12] = 16'd0;
	reg_file[13] = 16'd0;
	reg_file[14] = 16'd0;
	reg_file[15] = 16'd0;
	reg_file[16] = 16'd0;
	reg_file[17] = 16'd0;
	reg_file[18] = 16'd0;
	reg_file[19] = 16'd0;
	reg_file[20] = 16'd0;
	reg_file[21] = 16'd0;
	reg_file[22] = 16'd0;
	reg_file[23] = 16'd0;
	reg_file[24] = 16'd0;
	reg_file[25] = 16'd0;
	reg_file[26] = 16'd0;
	reg_file[27] = 16'd0;
	reg_file[28] = 16'd0;
	reg_file[29] = 16'd0;
	reg_file[30] = 16'd0;
	reg_file[31] = 16'd0;
end

assign bus1[15:0] = reg_file[read_addr1];
assign bus2[15:0] = reg_file[read_addr2];
assign write_data_bus = write_data;

assign add = reg_file[read_addr2] + reg_file[read_addr1];
assign sub = reg_file[read_addr2] - reg_file[read_addr1];
assign shift = reg_file[read_addr1] << bit_shift;

rotary uut1(clk, ROT_A, ROT_B, rot_event);
display uut2(first_line , second_line , display_start, clk , LCD_RS , LCD_W , LCD_E , val[0], val[1], val[2], val[3], display_end);

always @(posedge PB1) begin
	cmd[2:0]=inp[2:0];
end

always@(posedge PB2) begin
	//input_done = 0;
	flag=~flag;
	//count = 0;
end

always @(posedge clk) begin
	prev_rot_event <= rot_event;
	if (display_end == 1) begin
			count = 0;
			// input_done = 0;
			display_start = 0;
	end
	if(flag==0) begin
		count=0;
	end
	if(prev_rot_event == 0 && rot_event == 1 && flag==1) begin
		if(cmd==0) begin
			if(count==0) begin        //write_addr address of register
				//write_addr[4:1]<=inp[3:0];
				count=1;
			end
			else if(count==1) begin        //write_addr address of register
				write_addr[4:1]<=inp[3:0];
				count=2;
			end

			else if(count==2) begin
				write_addr[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin      //write_addr data
				write_data[15:12]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin      //write_addr data
				write_data[11:8]<=inp[3:0];
				count=5;
			end
			else if(count==5) begin      //write_addr data
				write_data[7:4]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin      //write_addr data
				write_data[3:0]<=inp[3:0];
				input_done = 1;
				count=7;
			end
			else if(count==7) begin
				reg_file[write_addr]<=write_data;
				count=8;
			end
			else if (count==8) begin
				first_line <= {deci[write_addr[4]], deci[write_addr[3]], deci[write_addr[2]], deci[write_addr[1]], deci[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {deci[write_data[15]], deci[write_data[14]], deci[write_data[13]],deci[write_data[12]], deci[write_data[11]], deci[write_data[10]], deci[write_data[9]], deci[write_data[8]],deci[write_data[7]], deci[write_data[6]], deci[write_data[5]], deci[write_data[4]], deci[write_data[3]], deci[write_data[2]], deci[write_data[1]], deci[write_data[0]]};
				//input_done = 0;
				display_start=1;
				//count=0;
			end
			// count<=count+1;
		end
		
		else if(cmd==1) begin
			if(count==0) begin        
				//read_addr1[4:1]<=inp[3:0];
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end

			else if(count==2) begin        //read address of register
				read_addr1[0]<=inp[0];
				input_done = 1;
				count=3;
			end
			else if(count==3 && input_done==1) begin
				first_line <= {deci[read_addr1[4]], deci[read_addr1[3]], deci[read_addr1[2]], deci[read_addr1[1]], deci[read_addr1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				/*second_line <= {deci[reg_file[read_addr1][15]], deci[reg_file[read_addr1][14]], deci[reg_file[read_addr1][13]],deci[reg_file[read_addr1][12]], deci[reg_file[read_addr1][11]], deci[reg_file[read_addr1][10]], deci[reg_file[read_addr1][9]], deci[reg_file[read_addr1][8]], 
									deci[reg_file[read_addr1][7]], deci[reg_file[read_addr1][6]], deci[reg_file[read_addr1][5]], deci[reg_file[read_addr1][4]], deci[reg_file[read_addr1][3]], deci[reg_file[read_addr1][2]], deci[reg_file[read_addr1][1]], deci[reg_file[read_addr1][0]]};*/
				second_line <= {deci[bus1[15]], deci[bus1[14]], deci[bus1[13]],deci[bus1[12]], deci[bus1[11]], deci[bus1[10]], deci[bus1[9]], deci[bus1[8]], 
									deci[bus1[7]], deci[bus1[6]], deci[bus1[5]], deci[bus1[4]], deci[bus1[3]], deci[bus1[2]], deci[bus1[1]], deci[bus1[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
		end
		
		else if(cmd==2) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin         //read address of register
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin           //read address of register
				read_addr2[0]<=inp[0];
				input_done = 1;
				count=5;
			end
			else if(count==5 && input_done==1) begin
				first_line <= {deci[bus1[15]], deci[bus1[14]], deci[bus1[13]],deci[bus1[12]], deci[bus1[11]], deci[bus1[10]], deci[bus1[9]], deci[bus1[8]], 
									deci[bus1[7]], deci[bus1[6]], deci[bus1[5]], deci[bus1[4]], deci[bus1[3]], deci[bus1[2]], deci[bus1[1]], deci[bus1[0]]};
				second_line <= {deci[bus2[15]], deci[bus2[14]], deci[bus2[13]],deci[bus2[12]], deci[bus2[11]], deci[bus2[10]], deci[bus2[9]], deci[bus2[8]], 
									deci[bus2[7]], deci[bus2[6]], deci[bus2[5]], deci[bus2[4]], deci[bus2[3]], deci[bus2[2]], deci[bus2[1]], deci[bus2[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
		end
		
		else if(cmd==3) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin           //read address of register
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end

			else if(count==2) begin
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				write_addr[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				write_addr[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin      //write_addr data
				write_data[15:12]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin      //write_addr data
				write_data[11:8]<=inp[3:0];
				count=7;
			end
			else if(count==7) begin      //write_addr data
				write_data[7:4]<=inp[3:0];
				count=8;
			end
			else if(count==8) begin      //write_addr data
				write_data[3:0]<=inp[3:0];
				input_done = 1;
				count=9;
			end
			else if(count==9 && input_done==1) begin
				reg_file[write_addr]<=write_data_bus;
				
				count=10;
			end
			else if (count==10 && input_done==1) begin
				first_line <= {deci[read_addr1[4]], deci[read_addr1[3]], deci[read_addr1[2]], deci[read_addr1[1]], deci[read_addr1[0]],  8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {deci[bus1[15]], deci[bus1[14]], deci[bus1[13]],deci[bus1[12]], deci[bus1[11]], deci[bus1[10]], deci[bus1[9]], deci[bus1[8]], 
									deci[bus1[7]], deci[bus1[6]], deci[bus1[5]], deci[bus1[4]], deci[bus1[3]], deci[bus1[2]], deci[bus1[1]], deci[bus1[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			
			end
			//count<=count+1;
		end
		else if(cmd==4) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				read_addr2[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin        //read address of register
				write_addr[4:1]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=inp[0];
				count=7;
			end
			else if(count==7) begin      //write_addr data
				write_data[15:12]<=inp[3:0];
				count=8;
			end
			else if(count==8) begin      //write_addr data
				write_data[11:8]<=inp[3:0];
				count=9;
			end
			else if(count==9) begin      //write_addr data
				write_data[7:4]<=inp[3:0];
				count=10;
			end
			else if(count==10) begin      //write_addr data
				write_data[3:0]<=inp[3:0];
				input_done = 1;
				count=11;
			end

			else if(count==11 && input_done==1) begin
				reg_file[write_addr]<=write_data_bus;
				count=12;
			end
			else if (count==12 && input_done==1) begin
				first_line <= {deci[bus1[15]], deci[bus1[14]], deci[bus1[13]],deci[bus1[12]], deci[bus1[11]], deci[bus1[10]], deci[bus1[9]], deci[bus1[8]], 
									deci[bus1[7]], deci[bus1[6]], deci[bus1[5]], deci[bus1[4]], deci[bus1[3]], deci[bus1[2]], deci[bus1[1]], deci[bus1[0]]};
				second_line <= {deci[bus2[15]], deci[bus2[14]], deci[bus2[13]],deci[bus2[12]], deci[bus2[11]], deci[bus2[10]], deci[bus2[9]], deci[bus2[8]], 
									deci[bus2[7]], deci[bus2[6]], deci[bus2[5]], deci[bus2[4]], deci[bus2[3]], deci[bus2[2]], deci[bus2[1]], deci[bus2[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			
			end
			//count<=count+1;
		end
		else if(cmd==5) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				read_addr2[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin        //read address of register
				write_addr[4:1]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=inp[0];
				input_done = 1;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				reg_file[write_addr]<=add;
				count=8;
			end
			else if(count==8 && input_done==1) begin
				first_line <= {deci[write_addr[4]], deci[write_addr[3]], deci[write_addr[2]], deci[write_addr[1]], deci[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {deci[add[15]], deci[add[14]], deci[add[13]],deci[add[12]], deci[add[11]], deci[add[10]], deci[add[9]], deci[add[8]],deci[add[7]], deci[add[6]], deci[add[5]], deci[add[4]], deci[add[3]], deci[add[2]], deci[add[1]], deci[add[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
			//count<=count+1;
		end
		else if(cmd==6) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				read_addr2[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				read_addr2[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin        //read address of register
				write_addr[4:1]<=inp[3:0];
				count=6;
			end
			else if(count==6) begin
				write_addr[0]<=inp[0];
				input_done = 1;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				reg_file[write_addr]<=sub;
				count=8;
			end
			else if(count==8 && input_done==1) begin
				first_line <= {deci[write_addr[4]], deci[write_addr[3]], deci[write_addr[2]], deci[write_addr[1]], deci[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {deci[sub[15]], deci[sub[14]], deci[sub[13]],deci[sub[12]], deci[sub[11]], deci[sub[10]], deci[sub[9]], deci[sub[8]],deci[sub[7]], deci[sub[6]], deci[sub[5]], deci[sub[4]], deci[sub[3]], deci[sub[2]], deci[sub[1]], deci[sub[0]]};
				input_done = 0;
				display_start=1;
				//count=0;
			end
			//count<=count+1;
		
		end
		else if(cmd==7) begin
			if(count==0) begin        
				count=1;
			end
			else if(count==1) begin        //read address of register
				read_addr1[4:1]<=inp[3:0];
				count=2;
			end
			else if(count==2) begin            //read address of register
				read_addr1[0]<=inp[0];
				count=3;
			end
			else if(count==3) begin        //read address of register
				write_addr[4:1]<=inp[3:0];
				count=4;
			end
			else if(count==4) begin
				write_addr[0]<=inp[0];
				count=5;
			end
			else if(count==5) begin      //write_addr data
				bit_shift[3:0]<=inp[3:0];
				input_done = 1;
				count=6;
			end
			else if(count==6 && input_done==1) begin
				reg_file[write_addr]<=shift;
				count=7;
			end
			else if(count==7 && input_done==1) begin
				first_line <= {deci[write_addr[4]], deci[write_addr[3]], deci[write_addr[2]], deci[write_addr[1]], deci[write_addr[0]], 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32, 8'd32};
				second_line <= {deci[shift[15]], deci[shift[14]], deci[shift[13]],deci[shift[12]], deci[shift[11]], deci[shift[10]], deci[shift[9]], deci[shift[8]],deci[shift[7]], deci[shift[6]], deci[shift[5]], deci[shift[4]], deci[shift[3]], deci[shift[2]], deci[shift[1]], deci[shift[0]]};
				input_done = 0;
				display_start=1;				
				//count=0;
			end
			// count<=count+1;
		end
	end
	
end


endmodule
