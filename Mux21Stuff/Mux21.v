`timescale 1ns / 1ps

module Mux21 ( out , in , sel ) ;
  input [ 1 : 0 ] in ;
  input sel ;
  output out ;
  
  
  wire notSel, x, y;
  not n1(notSel, sel);
  and a1(x, notSel, in[0]);
  and a2(y, sel, in[1]);
  or  o1(out, x, y);

endmodule
