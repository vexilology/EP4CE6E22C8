module numbers(output [9:0]Y,
               input [39:0]X,
               input [1:0]A);

  // 8'd255;
  // 8'hFF;
  // 8'o37;
  // 8'b10101010;
  // -8'b0000_0001;
  // 8'b0000_0001;
  // -8'b0000_000x;
  // 8'b0000_000x;
  // -8'b0000_000z;
  // 8'b0000_000z;

  // '\n'->1010->A, 'one tab or \t'->1001->9
  // 14*8=112->output=111
  // assign Y = "numbers module";
  // '\'->1011100->5C
  // assign Y[7:0] = 8'h5C;
  
  /*
  assign Y = A + B;
  assign Y = A - B;
  assign Y = A * B;
  assign Y = A ** 2'd3;
  assign Y = A / B;
  assign Y = A % B;

  assign Y = C? A : B;
  assign Y = C? A : 8'bZ1;
  assign Y = A & B;
  assign Y = ~(A & B);
  assign Y = A ^ B;
  assign Y = A ~^ B;
  assign Y = A << 2;
  assign Y = A << B;
  assign Y = A >> 1;
  assign Y = A >>> 1;
  assign Y = A >>> B;
  */

  wire [39:0]TempY;
  assign TempY = X >> A*10;
  assign Y = TempY[9:0];

endmodule
