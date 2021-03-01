module test_cyclev4 #(parameter N=8) (output reg [N-1:0]Q,
                                      input L,
                                      input [N-1:0]D,
                                      input C);

  always @(posedge C)
  begin
    integer i;
    i = 0;
    if (L)
    begin: w
      forever
      begin
        Q[i] <= D[i];
        i = i + 1;
        if (i == N)
        begin
          disable w;
        end
      end
    end
  end

endmodule
