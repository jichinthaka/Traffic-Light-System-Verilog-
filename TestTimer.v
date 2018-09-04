`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:48:31 07/04/2018
// Design Name:   Timer
// Module Name:   D:/Semester 7/Hardware Discription Language/0/Traffic_Light/TestTimer.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Timer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestTimer;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] parm_Value;
	reg enable;
	reg startTimer;

	// Outputs
	wire expired;

	// Instantiate the Unit Under Test (UUT)
	Timer uut (
		.clk(clk), 
		.reset(reset), 
		.parm_Value(parm_Value), 
		.enable(enable), 
		.startTimer(startTimer), 
		.expired(expired)
	);

	initial begin
		#90
		forever #10 clk = ~clk;
	end
	
	initial begin
		#100
		forever begin
			#60 enable = ~enable;
			#20 enable = ~enable;
		end
	end
	
	initial begin
		#100;
		// Initialize Inputs
		parm_Value = 0;
		enable = 0;
		startTimer = 0;
		clk = 0;
		reset = 0;
		
		#50
		reset = 1;
		#20
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		parm_Value = 4'd2;
		startTimer = 1;
		
		#20
		startTimer = 0;
		
		#280
		parm_Value = 4'd4;
		startTimer = 1;

		#20
		startTimer = 0;
	end		
      
endmodule

