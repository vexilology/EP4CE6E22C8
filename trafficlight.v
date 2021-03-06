/*
* Author: Jack0v, with minor changes.
* State machine that implements the logic of the a trafficlights.
*/
module trafficlight((*chip_pin="70"*)output nRQ,
                    (*chip_pin="71"*)output nEQ,
                    (*chip_pin="72"*)output nGQ,
                    (*chip_pin="65"*)output nTY,
                    (*chip_pin="64"*)input anB,
                    (*chip_pin="23"*)input C);

  reg [23:0]CTCQ;
  reg C1_5HzQ;
  
  always @(posedge C)
  begin
    CTCQ <= CTCQ + 1'd1;
    if (&CTCQ[22:0]) begin C1_5HzQ <= !C1_5HzQ; end
  end

  wire R_GY, S_GY, R_EY, S_EY, R_RY, S_RY, R_CTY, INC_CTY, R_BY;
  CD CD(
    // control signals
    .R_GY(R_GY), .S_GY(S_GY),
    .R_EY(R_EY), .S_EY(S_EY),
    .R_RY(R_RY), .S_RY(S_RY),
    .R_CTY(R_CTY), .INC_CTY(INC_CTY),
    .R_BY(R_BY),
    // warning signals
    .B(TFrontBQ),
    .CTEq0(~|CTQ), .CTEq1(CTQ == 5'd1), .CTEq4(CTQ == 5'd4), .CTEq15(CTQ == 5'd15), .C(C1_5HzQ));

  reg B0Q, B1Q, TFrontBQ;
  reg [4:0]CTQ;
  reg GQ, EQ, RQ;

  always @(posedge C1_5HzQ)
  begin
    // memorizing the rising edge
    B0Q <= !anB;
    B1Q <= B0Q;
    if (R_BY) begin TFrontBQ <= 0; end
    else begin if (B0Q & !B1Q) begin TFrontBQ = 1'd1; end end
    // green
    if (R_GY) begin GQ <= 0; end
    else begin if (S_GY) begin GQ <= 1'd1; end end
    // yellow
    if (R_EY) begin EQ <= 0; end
    else begin if (S_EY) begin EQ <= 1'd1; end end
    // red
    if (R_RY) begin RQ <= 0; end
    else begin if (S_RY) begin RQ <= 1'd1; end end
    // counter
    if (R_CTY) begin CTQ <= 0; end
    else begin if (INC_CTY) begin CTQ <= CTQ + 1'd1; end end
  end

  assign {nGQ, nEQ, nRQ} = ~{GQ, EQ, RQ};
  assign nTY = ~|CTQ;

endmodule

module CD(
  // control signals
  output reg R_GY, S_GY,
  output reg R_EY, S_EY,
  output reg R_RY, S_RY,
  output reg R_CTY, INC_CTY,
  output reg R_BY,
  // warning signals
  input B,
  input CTEq0, CTEq1, CTEq4, CTEq15,
  input C);

  parameter a0 = 0, a1 = 1, a2 = 2, a3 = 3, a4 = 4, a5 = 5, a6 = 6, a7 = 7;

  reg [3:0]aY;
  reg [3:0]aQ;

  always @(posedge C) begin aQ <= aY; end
  
  always @*
  begin
    case (aQ)
      a0:
      begin
        aY      = a1;
        R_GY    = 0;
        S_GY    = 1'd1;
        R_EY    = 0;
        S_EY    = 0;
        R_RY    = 0;
        S_RY    = 0;
        R_CTY   = 0;
        INC_CTY = 1'd1;
        R_BY    = 0;
      end
      a1:
      begin
        if (!CTEq0)
        begin
          aY      = a1;
          R_GY    = 0;
          S_GY    = 0;
          R_EY    = 0;
          S_EY    = 0;
          R_RY    = 0;
          S_RY    = 0;
          R_CTY   = 0;
          INC_CTY = 1'd1;
          R_BY    = 0;
        end
        else
        begin
          if (CTEq0)
          begin
            aY      = a2;
            R_GY    = 0;
            S_GY    = 0;
            R_EY    = 0;
            S_EY    = 0;
            R_RY    = 0;
            S_RY    = 0;
            R_CTY   = 0;
            INC_CTY = 0;
            R_BY    = 0;
          end
          else
          begin
            aY      = a7;
            R_GY    = 0;
            S_GY    = 0;
            R_EY    = 0;
            S_EY    = 0;
            R_RY    = 0;
            S_RY    = 0;
            R_CTY   = 0;
            INC_CTY = 0;
            R_BY    = 0;
          end
        end
      end
      a2:
      begin
        if (!B)
        begin
          aY      = a2;
          R_GY    = 0;
          S_GY    = 0;
          R_EY    = 0;
          S_EY    = 0;
          R_RY    = 0;
          S_RY    = 0;
          R_CTY   = 0;
          INC_CTY = 0;
          R_BY    = 0;
        end
        else
        begin
          if (B & !CTEq4)
          begin
            aY      = a3;
            R_GY    = 1'd1;
            S_GY    = 0;
            R_EY    = 0;
            S_EY    = 0;
            R_RY    = 0;
            S_RY    = 0;
            R_CTY   = 0;
            INC_CTY = 1'd1;
            R_BY    = 0;
          end
          else
          begin
            if (B & CTEq4)
            begin
              aY      = a4;
              R_GY    = 1'd1;
              S_GY    = 0;
              R_EY    = 0;
              S_EY    = 1'd1;
              R_RY    = 0;
              S_RY    = 0;
              R_CTY   = 1'd1;
              INC_CTY = 0;
              R_BY    = 0;
            end
            else
            begin
              aY      = a7;
              R_GY    = 0;
              S_GY    = 0;
              R_EY    = 0;
              S_EY    = 0;
              R_RY    = 0;
              S_RY    = 0;
              R_CTY   = 0;
              INC_CTY = 0;
              R_BY    = 0;
            end
          end
        end
      end
      a3:
      begin
        aY      = a2;
        R_GY    = 0;
        S_GY    = 1'd1;
        R_EY    = 0;
        S_EY    = 0;
        R_RY    = 0;
        S_RY    = 0;
        R_CTY   = 0;
        INC_CTY = 0;
        R_BY    = 0;
      end
      a4:
      begin
        if (!CTEq1)
        begin
          aY      = a4;
          R_GY    = 0;
          S_GY    = 0;
          R_EY    = 0;
          S_EY    = 0;
          R_RY    = 0;
          S_RY    = 0;
          R_CTY   = 0;
          INC_CTY = 1'd1;
          R_BY    = 0;
        end
        else
        begin
          if (CTEq1)
          begin
            aY      = a5;
            R_GY    = 0;
            S_GY    = 0;
            R_EY    = 1'd1;
            S_EY    = 0;
            R_RY    = 0;
            S_RY    = 1'd1;
            R_CTY   = 1'd1;
            INC_CTY = 0;
            R_BY    = 0;
          end
          else
          begin
            aY      = a7;
            R_GY    = 0;
            S_GY    = 0;
            R_EY    = 0;
            S_EY    = 0;
            R_RY    = 0;
            S_RY    = 0;
            R_CTY   = 0;
            INC_CTY = 0;
            R_BY    = 0;
          end
        end
      end
      a5:
      begin
        if (!CTEq15)
        begin
          aY      = a5;
          R_GY    = 0;
          S_GY    = 0;
          R_EY    = 0;
          S_EY    = 0;
          R_RY    = 0;
          S_RY    = 0;
          R_CTY   = 0;
          INC_CTY = 1'd1;
          R_BY    = 0;
        end
        else
        begin
          if (CTEq15)
          begin
            aY      = a6;
            R_GY    = 0;
            S_GY    = 0;
            R_EY    = 0;
            S_EY    = 1'd1;
            R_RY    = 0;
            S_RY    = 0;
            R_CTY   = 1'd1;
            INC_CTY = 0;
            R_BY    = 0;
          end
          else
          begin
            aY      = a7;
            R_GY    = 0;
            S_GY    = 0;
            R_EY    = 0;
            S_EY    = 0;
            R_RY    = 0;
            S_RY    = 0;
            R_CTY   = 0;
            INC_CTY = 0;
            R_BY    = 0;
          end
        end
      end
      a6:
      begin
        aY      = a1;
        R_GY    = 0;
        S_GY    = 1'd1;
        R_EY    = 1'd1;
        S_EY    = 0;
        R_RY    = 1'd1;
        S_RY    = 0;
        R_CTY   = 0;
        INC_CTY = 1'd1;
        R_BY    = 1'd1;
      end
      default:
      begin
        aY      = a0;
        R_GY    = 0;
        S_GY    = 0;
        R_EY    = 0;
        S_EY    = 0;
        R_RY    = 0;
        S_RY    = 0;
        R_CTY   = 0;
        INC_CTY = 0;
        R_BY    = 0;
      end
    endcase
  end

endmodule
