module counter((* chip_pin = "72" *)output LedQ,
               (* chip_pin = "58" *)input nT,
               (* chip_pin = "64" *)input nR,
               (* chip_pin = "23" *)input C);

  wire [23:0] Q;
  wire TQ, RQ;
  DT Sync[1:0](.Q({TQ, RQ}), .D({!nT, !nR}), .C(C));

  wire [23:0]Y = {24{!RQ}} & (({24{TQ}} & (Q + 24'd1)) | (!{24{!TQ}} & Q));
  DT DT[23:0](.Q(Q), .D(Y), .C({24{C}}));
  assign LedQ = !Q[23];

endmodule

module DT(output Q,
          input D,
          input C);

  DFF DT(.q(Q), .d(D), .clk(C), .clrn(1'd1'), .prn(1'd1'));

endmodule
