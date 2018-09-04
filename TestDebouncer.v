`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:43:27 07/11/2018
// Design Name:   Debouncer
// Module Name:   /home/imesh/Semester 7/HDL/0/Traffic_Light/TestDebouncer.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Debouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestDebouncer;

	// Inputs
	reg reset;
	reg clk;
	reg noisy;

	// Outputs
	wire clean;

	// Instantiate the Unit Under Test (UUT)
	Debouncer uut (
		.reset(reset), 
		.clk(clk), 
		.noisy(noisy), 
		.clean(clean)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 0;
		noisy = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 0;
		#150;
		noisy = 1;
		#150;
		noisy = 0;
		#80;
		noisy = 1;
		#80;
		noisy = 0;

	end
	
	initial begin
		forever #10 clk = ~clk;	
	end
      
endmodule

