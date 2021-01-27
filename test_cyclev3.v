module test_cyclev3 #(parameter N=8) (output reg [N-1:0]Q,
                                      input L,
                                      input [N-1:0]D,
                                      input C);

  always @(posedge C)
  begin
    integer i;
    i = 0;
    if (L)
    begin
      repeat (N)
      begin
        Q[i] <= D[i];
        i = i + 1;
      end
    end
  end

endmodule
