`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:16:13 07/04/2018 
// Design Name: 
// Module Name:    WalkRegister 
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
module WalkRegister(clk, reset, WR_Sync, WR_Reset, WR);
	input clk, reset, WR_Reset, WR_Sync;
	output WR;
	reg WR;

	always @ ( posedge clk )
	begin
		WR <= (WR_Reset || reset) ? 0 :
			WR ? WR : WR_Sync;
	end
endmodule
