module test_registerArray(output [7:0]D,
                          input [7:0]D,
                          input [1:0]A,
                          input WR,
                          input C);

  reg [7:0]REG[3:0];

  always @(posedge C)
  begin
    if (WR)
    begin
      REG[A] <= D;
    end
  end

  assign Y = REG[A];

endmodule
