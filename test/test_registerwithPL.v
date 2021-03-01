module test_registerwithPL #(parameter N=4)(output reg [N-1:0]Q,
                                            input [N-1:0]D, W,
                                            input R, L, INC, DEC, SHL, SHR,
                                            input C);

  initial
  begin
    Q <= 10;
  end

  always @(posedge C)
  begin
    if (R)
    begin
      Q <= 0;
    end
    else
    begin
      if (L)
      begin
        Q <= D;
      end
      else
      begin
        if (INC)
        begin
          if (Q >= W)
          begin
            Q <= 0;
          end
          else
          begin
            Q <= Q + 1'd1;
          end
        end
        else
        begin
          if (DEC)
          begin
            if (Q <= W)
            begin
              // 4'd15
              Q <= {N{1'd1}};
            end
            else
            begin
              Q <= Q - 1'd1;
            end
          end
        end
        else
        begin
          if (SHL)
          begin
            Q[N-1:1] <= Q[N-2:0];
            Q[0] <= D[0];
          end
          else
          begin
            if (SHR)
            begin
              Q[N-1] <= D[N-1];
              Q[N-2:0] <= Q[N-1:1];
            end
          end
        end
      end
    end
  end

  /* 
  SHL diagram
  Q3 Q2 Q1 Q0
  Q2 Q1 Q0 D[0]

  SHR diagram
  Q3   Q2 Q1 Q0
  D[3] Q3 Q2 Q1
  */

endmodule
