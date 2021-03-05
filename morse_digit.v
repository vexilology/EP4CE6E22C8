/*
* Author: Jack0v, with minor changes.
* Morse code decoder, digits only.
*/
module morse_digit((*chip_pin="133, 80, 83, 85, 86, 87"*) output reg [6:0]nABCDEFGY,
                   (*chip_pin="52, 51, 73, 74, 75. 76, 77"*) output [6:0]nABCDEFGIY,
                   (*altera_attribute="-name VIRTUAL_PIN ON"*) output [1:0]StatusY,
                   (*chip_pin="11"*) input aM,
                   (*chip_pin="23"*) input C);

  // "-" .= 4T;
  // "." <= 3T;
  // time between elements < 7T;
  // time between codes >= 7T;

  wire [23:0]CTStrobQ;
  wire StrobY = CTStrobQ == 24'd12_500_000;
  CT #(24) CTStrob(.Q(CTStrobQ), .INC(1'd1), .R(StrobY), .C(C));

  wire KQ;
  Chatter Chatter(.Q(KQ), .aX(aM), .C(C));

  wire TDelayQ;
  TD TDelay(.Q(TDelayQ), .D(KQ), .C(C));
  wire FFrontY = !KQ & TDelayQ;

  wire [2:0]CTLongQ;
  wire CTLongEq4Y = CTLongQ == 3'd4;
  CT #(3) CTLong(.Q(CTLongQ), .INC(KQ & !CTLongEq4Y & StrobY), .R(FFrontY), .C(C));

  wire [2:0]CTIntervalQ;
  wire CTIntervalEq7Y = CTIntervalQ == 3'd7;
  CT #(3) CTInterval(.Q(CTIntervalQ), .INC(!KQ & !CTIntervalEq7Y & StrobY), .R(KQ), .C(C));

  wire RFrontY = KQ * !TDelayQ;

  wire [2:0]CTBitQ;
  wire INC_CTBit = FFrontY & (CTBitQ != 3'd5);
  CT #(3) CTBit(.Q(CTBitQ), .INC(INC_CTBit), .R(FFrontY & CTIntervalEq7Y), .C(C));

  wire [4:0]REGBitQ;
  REGSH REGBit(.Q(REGBitQ), .SH(INC_CTBit), .D(CTLongEq4Y), .C(C));
  // _____
  //|  a  |
  //|f    |b
  //|     |
  //|_____|
  //|  g  |
  //|e    |c
  //|     |
  //|_____|
  //   d
  reg ErrorY;
  always @(*)
  begin
    if (CTBitQ == 3'd5)
    begin
      case (REGBitQ)
        5'b11111:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1111110; // 0
        end
        5'b01111:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b0110000; // 1
        end
        5'b00111:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1101101; // 2
        end
        5'b00011:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1111001; // 3
        end
        5'b00001:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b0110011; // 4
        end
        5'b00000:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1011011; // 5
        end
        5'b10000:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1011111; // 6
        end
        5'b11000:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1110000; // 7
        end
        5'b11100:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1111111; // 8
        end
        5'b11110:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1111011; // 9
        end
        default:
        begin
          ErrorY = 0;
          nABCDEFGY = ~7'b1001111; // error
        end
      endcase
    end else
    begin
      ErrorY = 0;
      nABCDEFGY = ~7'd0;
    end
  end

  assign nABCDEFGIY = ~(KQ? (CTLongEq4Y? 7'b0110000 : 7'b1111110) : (CTIntervalEq7Y? 7'b0000000 : 7'b0000001));

  // StatusY:
  // 00 - during;
  // 01 - idle time;
  // 10 - result;
  // 11 - error;

  assign StatusY = {CTBitQ == 3'd5, (CTBitQ == 3'd5)? ErrorY : CTIntervalEq7Y};

endmodule

module Chatter(output reg Q,
               input aX,
               input C);

  reg X;
  reg [15:0]CTQ;
  always @(posedge C)
  begin
    X <= aX;
    if (X & ~&CTQ) begin CTQ <= CTQ + 1'd1; end
    else
    begin
      if (!X & !CTQ) begin CTQ <= CTQ - 1'd1; end
    end
    if (&CTQ) begin Q <= 1'd1; end
    else
    begin
      if (~|CTQ) begin Q <= 0; end
    end
  end

endmodule

module TD (output reg Q,
           input D,
           input C);

  always @(posedge C) begin Q <= D; end

endmodule

module CT #(parameter N=3) (output reg [N-1:0]Q,
                            input INC,
                            input R,
                            input C);

  always @(posedge C)
  begin
    if (R) begin Q <= 0; end
    else
    begin
      if (INC) begin Q <= Q + 1'd1; end
    end
  end

endmodule

module REGSH(output reg [4:0]Q,
             input SH, D,
             input C);

  always @(posedge C)
  begin
    if (SH) begin Q <= {Q[3:0], D}; end
  end

endmodule
