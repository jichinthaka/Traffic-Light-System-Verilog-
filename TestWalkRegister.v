`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:25:42 07/04/2018
// Design Name:   WalkRegister
// Module Name:   D:/Semester 7/Hardware Discription Language/0/Traffic_Light/TestWalkRegister.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: WalkRegister
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestWalkRegister;

	// Inputs
	reg clk;
	reg reset;
	reg WR_Sync;
	reg WR_Reset;

	// Outputs
	wire WR;

	// Instantiate the Unit Under Test (UUT)
	WalkRegister uut (
		.clk(clk), 
		.reset(reset), 
		.WR_Sync(WR_Sync), 
		.WR_Reset(WR_Reset), 
		.WR(WR)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		WR_Sync = 0;
		WR_Reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		forever #50 clk = ~clk;

	end
	
	initial begin
		$display("Starting test of WalkRegister ...");

		WR_Reset = 1;
		#100

		WR_Sync = 1;
		#100

		WR_Reset = 0;
		WR_Sync = 1;
		#100

		WR_Sync = 0;
		#100;

		WR_Reset = 1;
		#100;
	end
      
endmodule

