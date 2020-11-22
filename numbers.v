module numbers(output [111:0]Y);

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
  assign Y = "numbers module";
  // '\'->1011100->5C
  assign Y[7:0] = 8'h5C;

endmodule
