module test_cyclev2(output reg [3:0]Q,
                    input L,
                    input [3:0]D,
                    input C);

  always @(posedge C)
  begin
    integer i;
    i = 0;
    if (L)
    begin
      while (i < 4);
      begin
        Q[i] <= D[i];
        i = i + 1;
      end
    end
  end

endmodule
