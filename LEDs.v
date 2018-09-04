`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:34 07/03/2018 
// Design Name: 
// Module Name:    LEDs 
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
module LEDs(signal , r_m , y_m , g_m, r_s , y_s , g_s, walk);
	input [6:0] signal;
	output r_m , y_m , g_m, r_s , y_s , g_s, walk;

	parameter RED_MAIN 		= 7'b0000001;
	parameter YELLOW_MAIN 	= 7'b0000010;
	parameter GREEN_MAIN 	= 7'b0000100;
	parameter RED_SIDE 		= 7'b0001000;
	parameter YELLOW_SIDE 	= 7'b0010000;
	parameter GREEN_SIDE 	= 7'b0100000;
	parameter WALK 			= 7'b1000000;

	parameter ON = 1;
	parameter OFF = 0;
	
	//reg r_m, y_m, g_m, r_s, y_s, g_s, walk;

	reg r_m = OFF;
	reg y_m = OFF;
	reg g_m = OFF;
	reg r_s = OFF;
	reg y_s = OFF;
	reg g_s = OFF;
	reg walk = OFF;
	
	always @ ( signal )
	begin
		if (signal & RED_MAIN)
			begin
				r_m <= ON;
			end
		else
			begin
				r_m <= OFF;
			end
			
		if (signal & YELLOW_MAIN)
			begin
				y_m <= ON;
			end
		else
			begin
				y_m <= OFF;
			end
			
		if (signal & GREEN_MAIN)
			begin
				g_m <= ON;
			end
		else
			begin
				g_m <= OFF;
			end
			
		if (signal & RED_SIDE)
			begin
				r_s <= ON;
			end
		else
			begin
				r_s <= OFF;
			end
		
		if (signal & YELLOW_SIDE)
			begin
				y_s <= ON;
			end
		else
			begin
				y_s <= OFF;
			end
		
		if (signal & GREEN_SIDE)
			begin
				g_s <= ON;
			end
		else
			begin
				g_s <= OFF;
			end
		
		if (signal & WALK)
			begin
				walk <= ON;
			end
		else
			begin
				walk <= OFF;
			end			
	end
endmodule
