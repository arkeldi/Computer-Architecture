`timescale 1ns / 1ps

module HalfAdd ( Cout , Sum , A, B ) ;
  input A, B ;
  output Cout , Sum ; // in and out ports
  


	wire x,y,z; //internal nets

	nand n1(x, A, B); // nand half adder logic
	nand n2(y, A, x);
	nand n3(z, x, B);
	nand n4(Sum, y, z);
	nand n5(Cout, x, x);


endmodule
