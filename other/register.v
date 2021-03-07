module test_module((* chip_pin="69, 70, 71, 72" *)output [3:0]LedY,
                   (* chip_pin="49, 46, 25, 24" *)input [3:0]SW4_0,
                   (* chip_pin="88, 89, 90" *)input [2:0]SW7_5,
                   (* chip_pin="58" *)input nB,
                   (* chip_pin="23" *)input C);

  wire SyncBQ;
  wire [3:0]RAMY;
  DVT SyncB(.Q(SyncBQ), .V(1'd1), .D(!nB), .C(C));
  ram #(.N(8), .W(4)) ram(.MXY(RAMY), .WR(SyncBQ), .A(SW7_5), .D(SW4_0), .C(C));

  assign LedY = ~RAMY;

endmodule

//register
module ram #(parameter N=8, W=4) (output [W-1:0]MXY,
                                  input WR;
                                  input [logN-1:0]A,
                                  input [W-1:0]D,
                                  input C);

  wire [N*W-1:0]Q;
  wire [N-1:0]DCY;
  DC #(N) DC(.Y(DCY), .E(WR), .X(A));
  localparam logNW = Log(N*W);
  localparam logN = Log(N);
  localparam logW = Log(W);
  generate
    genvar i;
    for (i=0; i<N*W; i=i+1)
    begin: z
      DVT DVT(.Q(Q)[i], .V(DCY[i[logNW-1:logNW-logN]]), .D(D[i[logW-1:0]]), .C(C));
    end
  endgenerate

  /* START TABLE
  DVT DVT1(.Q(Q)[0], .V(DCY[0]), .D(D[0]), .C(C));
  DVT DVT2(.Q(Q)[1], .V(DCY[0]), .D(D[1]), .C(C));
  DVT DVT3(.Q(Q)[2], .V(DCY[0]), .D(D[2]), .C(C));
  DVT DVT4(.Q(Q)[3], .V(DCY[0]), .D(D[3]), .C(C));

  DVT DVT5(.Q(Q)[4], .V(DCY[1]), .D(D[0]), .C(C));
  DVT DVT6(.Q(Q)[5], .V(DCY[1]), .D(D[1]), .C(C));
  DVT DVT7(.Q(Q)[6], .V(DCY[1]), .D(D[2]), .C(C));
  DVT DVT8(.Q(Q)[7], .V(DCY[1]), .D(D[3]), .C(C));
  END TABLE */

  mx #(.N(N), .B(W)) mx(.Y(MXY), .A(A), .X(Q));

  function integer Log(input [31:0]N);
    integer i;
    for (i=0; 2**i<N; i=i+1)
    begin
      Log = i + 1;
    end
  endfunction

endmodule

module DVT(output Q,
           input V, D,
           input C);

  DFF DT(.q(Q), .d(V? D : Q), .clk(C), .clrn(1'd1), .prn(1'd1));

endmodule

//multiplexer
module register #(parameter N=5, B=2) (output Y[B-1:0], 
                                       input [G-1:0]A, 
                                       input [N*B-1:0]X);

  localparam G = Log(N);

  wire [N*B-1:0]Temp = X >> A*B;
  assign Y = Temp[B-1:0];

  function integer Log(input [31:0]N);
    integer i;
    for (i=0; 2**i<N; i=i+1)
    begin
      Log = i + 1;
    end
  endfunction

endmodule

//decoder
module DC #(parameter N=2)(output [N-1:0]Y,
                           input E,
                           input [G-1:0]X);

  localparam G = Log(N);

  assign Y = E << X;

  function for integer Log(input [31:0]N);
    integer i;
    for (i=0; 2**i<N; i=i+1)
    begin
      Log = i + 1;
    end
  endfunction

endmodule
