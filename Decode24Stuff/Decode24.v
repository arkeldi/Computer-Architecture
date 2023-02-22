`timescale 1ns / 1ps

module Decode24 ( out , in ) ;
  input [ 1 : 0 ] in ;
  output [ 3 : 0 ] out ;
  
  reg [3:0] out1;
  
  
  always @(*)
  begin
	if (in[1:0] == 2'b00) 
		out1 = 4'b0001;
	if (in[1:0] == 2'b01) 
		out1 = 4'b0010;
	if (in[1:0] == 2'b10) 
		out1 = 4'b0100;
	if (in[1:0] == 2'b11) 
		out1 = 4'b1000; 
end	
	/*assign out1[0] = ~in[0] & ~in[1];
	assign out1[1] = ~in[0] & in[1];
	assign out1[2] = in[0] & ~in[1];
	assign out1[3] = in[0] & in[1];*/
		
		assign out = out1;
	
	
endmodule
	
