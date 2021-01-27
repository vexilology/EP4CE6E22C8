module test_cycle(output reg [3:0]Q,
                  input [3:0]D,
                  input L,
                  input C,
                  input aR);

  always @(posedge C or posedge aR)
  begin
    integer i;
    if (aR)
    begin
      Q <= 0;
    end
    else
    begin
      if (L)
      begin
        // Q <= D;
        for (i=0; i<4; i=i+1)
        begin
          Q[i] <= D[i];
        end
      end
    end
  end

endmodule
