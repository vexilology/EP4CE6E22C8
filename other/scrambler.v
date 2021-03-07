module scrambler #(parameter N=3) (output reg [N-1:0]Y,
                                   output reg E,
                                   input [2**N-1:0]X);

  always @(*)
  begin
    integer i, j;
    E = 0;
    if (!X)
    begin
      E = 1'd1;
    end
    else
    begin: E_
      for (i=0; i<2**N; i=i+1)
      begin
        if (X[i])
        begin
          for (j=i+1; j<2**N; j=j+1)
          begin
            if (X[j])
            begin
              E = 1'd1;
              disable E_;
            end
          end
        end
      end
    end
  end

  reg [2**N-1:0]Temp;
  always @(*)
  begin
    integer i;
    Temp = X;
    Y = 0;
    for (i=0; Temp[2**N-1:1]; i=i)
    begin
      Temp = Temp >> 1;
      Y = Y + 1'd1;
    end
  end

endmodule
