`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:03:43 07/04/2018
// Design Name:   LEDs
// Module Name:   D:/Semester 7/Hardware Discription Language/0/Traffic_Light/TestLEDs.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LEDs
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestLEDs;

	// Inputs
	reg [6:0] signal;

	// Outputs
	wire r_m;
	wire y_m;
	wire g_m;
	wire r_s;
	wire y_s;
	wire g_s;
	wire walk;

	// Instantiate the Unit Under Test (UUT)
	LEDs uut (
		.signal(signal), 
		.r_m(r_m), 
		.y_m(y_m), 
		.g_m(g_m), 
		.r_s(r_s), 
		.y_s(y_s), 
		.g_s(g_s), 
		.walk(walk)
	);


	
	initial begin
		signal = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		$display("....Starting test of LEDs ...");
		
		signal = 7'b0000001;
		#100;
		signal = 7'b0000011;
		#100;
		signal = 7'b0000111;
		#100;
		signal = 7'b0001111;
		#100;
		signal = 7'b0011111;
		#100;
		signal = 7'b0111111;
		#100;


		
	end
      
endmodule

