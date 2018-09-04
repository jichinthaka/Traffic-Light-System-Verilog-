`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:20:25 07/04/2018 
// Design Name: 
// Module Name:    Debouncer 
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
module Debouncer(reset, clk, noisy, clean);
   parameter DELAY = 3;   // .01 sec with a 27Mhz clock
   input reset, clk, noisy;
   output clean;

   reg [18:0] count;
   reg new, clean;

   always @(posedge clk)
     if (reset)
       begin
		  count <= 0;
		  new <= noisy;
		  clean <= noisy;
       end
     else if (noisy != new)
       begin
			new <= noisy;
			count <= 0;
       end
     else if (count == DELAY)
       clean <= new;
     else
       count <= count+1;
      
endmodule
