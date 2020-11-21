module multiplexer((* chip_pin = "72" *)output Y,
                   (* chip_pin = "24" *)input X0,
                   (* chip_pin = "25" *)input X1,
                   (* chip_pin = "49" *)input A,
                   (* chip_pin = "65" *)output mxNot1Y,
                   (* chip_pin = "88" *)input mx1X0,
                   (* chip_pin = "89" *)input mx1X1,
                   (* chip_pin = "91" *)input mx1A),
                   (* chip_pin = "64" *)input V);

  wire Not1Y, And1Y, And2Y;
  wire Or1Y, mx1Y, mxQ;
  not  (Not1Y, A);
  and  (And1Y, X0, Not1Y);
  and  (And2Y, X1, A);
  or   (Or1Y, And2Y, And1Y);
  not  (Y, Or1Y);

  mx mx1(mx1Y, mx1A, mx1X0, mx1X1);
  DFF DFF(.q(mxQ),
          .d(mx1Y),
          .clk(V),
          .clrn(1'd1),
          .prn(1'd1));
  not  (mxNot1Y, mxQ);

endmodule

/*
module secondmux(output Y, input X0, X1, A);

  wire Not1Y, And1Y, And2Y;
  not (Not1Y, A);
  and (And1Y, X0, Not1Y),
      (And2Y, X1, A);
  or (Y, And2Y, And1Y);

endmodule
*/

// A  X0  X1  : Y
primitive mx(output Y,
             input A, X0, X1);

  table
    0  0  ?  : 0;
    0  1  ?  : 1;
    1  ?  0  : 0;
    1  ?  1  : 1;
  endtable

endprimitive
