`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:17:37 07/04/2018
// Design Name:   TimeParameters
// Module Name:   D:/Semester 7/Hardware Discription Language/0/Traffic_Light/TestTimeParameter.v
// Project Name:  Traffic_Light
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TimeParameters
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestTimeParameter;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] selector;
	reg [3:0] in_Value;
	reg sync_Reprogram;
	reg [1:0] interval;

	// Outputs
	wire [3:0] out_Value;

	// Instantiate the Unit Under Test (UUT)
	TimeParameters uut (
		.clk(clk), 
		.reset(reset), 
		.selector(selector), 
		.in_Value(in_Value), 
		.sync_Reprogram(sync_Reprogram), 
		.interval(interval), 
		.out_Value(out_Value)
	);

	initial begin
		forever 
			#10 clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		selector = 0;
		in_Value = 0;
		interval = 0;
		sync_Reprogram = 0;
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		reset = 1;
		interval = 2'b00;
		
		#60
		reset = 0;
		
		#60
		interval = 2'b01;
		
		#60
		interval = 2'b10;
		
		#60
		selector = 2'b01;
		in_Value = 4'b1010;
		
		#60
		sync_Reprogram = 1;
		
		#20
		sync_Reprogram = 0;
		
		#60
		interval = 2'b01;
		
		#60
		reset = 1;
		interval = 2'b00;
		
		#60
		reset = 0;
		
		#60
		interval = 2'b01;		
		
	end
      
endmodule

