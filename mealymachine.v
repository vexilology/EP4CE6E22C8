module mealymachine(output [1:0]StateQ,
                    output reg R, Y,
                    input S, D,
                    input C, aR);

  assign StateQ = aQ;

  reg [1:0]aY;
  reg [1:0]aQ;

  parameter a0 = 0, a1 = 1, a2 = 2, a3 = 3;

  always @*
  begin
    case (aQ)
      a0:
      begin
        if (!S)
        begin
          aY = a0;
          R = 0;
          Y = 1'dx;
        end
        else
        begin
          if (!D)
          begin
            aY = a1;
            R = 0;
            Y = 1'dx;
          end
          else
          begin
            aY = a2;
            R = 0;
            Y = 1'dx;
          end
        end
      end
      a1:
      begin
        case({S, D})
          2'b10:
          begin
            aY = a1;
            R = 0;
            Y = 1'dx;
          end
          2'b11:
          begin
            aY = a2;
            R = 0;
            Y = 1'dx;
          end
          2'b00:
          begin
            aY = a0;
            R = 1'd1;
            Y = 0;
          end
          2'b01:
          begin
            aY = a0;
            R = 1'd1;
            Y = 1'd1;
          end
        endcase
      end
      a2:
      begin
        if (!S)
        begin
          aY = a3;
          R = 0;
          Y = 1'dx;
        end
        else
        begin
          if (!D)
          begin
            aY = a1;
            R = 0;
            Y = 1'dx;
          end
          else
          begin
            aY = a2;
            R = 0;
            Y = 1'dx;
          end
        end
      end
      a3:
      begin
        case({S, D})
          2'b10:
          begin
            aY = a1;
            R = 0;
            Y = 1'dx;
          end
          2'b11:
          begin
            aY = a2;
            R = 0;
            Y = 1'dx;
          end
          2'b00:
          begin
            aY = a0;
            R = 1'd1;
            Y = 0;
          end
          2'b01:
          begin
            aY = a0;
            R = 1'd1;
            Y = 1'd1;
          end
        endcase
      end
    endcase
  end

  always @(posedge C, posedge aR)
  begin
    if (aR)
    begin
      aQ <= Q;
    end
    else
    begin
      aQ <= aY;
    end
  end

endmodule
