`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:32:44 07/04/2018
// Design Name:   Divider
// Module Name:   D:/Semester 7/Hardware Discription Language/0/Traffic_Light/TestDivider.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Divider
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestDivider;

	// Inputs
	reg clk;
	reg reset;
	//reg startTimer;

	// Outputs
	wire enable;

	// Instantiate the Unit Under Test (UUT)
	Divider uut (
		.clk(clk), 
		.reset(reset), 
		//.startTimer(startTimer), 
		.enable(enable)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		//startTimer = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		forever #5 clk = ~clk;

	end
	
	initial begin
		$display("....Starting test of Divider ...");
		
		#150
		
		//startTimer = 1;
		#10
		//startTimer = 0;
		
		#150
		
		reset = 1;
		#10
		reset = 0;

		
	end
      
endmodule

