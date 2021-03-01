module test_task(output reg [3:0]Q,
                 input INC,
                 input C);

always @(posedge C)
begin
  CT(Q, INC);
end

task CT(inout [3:0]Q, input INC);
  if (INC)
  begin
    Q <= Q + 1'd1;
  end
endtask

endmodule
