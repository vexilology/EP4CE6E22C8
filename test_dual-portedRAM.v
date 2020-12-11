module test_dual-portedRAM #(parameter DW=8, AW=6)(output reg [DW-1:0]aQ,
                                                   input aWR,
                                                   input [AW-1:0]aA,
                                                   input [DW-1:0]aD,
                                                   input aC,
                                                   output reg [DW-1:0]bQ,
                                                   input bWR,
                                                   input [AW-1:0]bA,
                                                   input [DW-1:0]bD,
                                                   input bC);

  // Auto RAM Replacement - ON
  reg [DW-1:0]RAM[2**AW-1:0];

  // Port A
  always @(posedge aC)
  begin
    if (aWR)
    begin
      RAM[aA] <= aD;
      aQ <= aD;
    end
    else
    begin
      aQ <= RAM[aA];
    end
  end

  // Port B
  always @(posedge bC)
  begin
    if (bWR)
    begin
      RAM[bA] <= bD;
      bQ <= bD;
    end
    else
    begin
      bQ <= RAM[bA];
    end
  end

endmodule
