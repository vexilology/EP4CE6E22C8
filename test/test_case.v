moduel test_case(output reg [3:0]Y, zY, vY, Yz, vYz, zYz,
                 input [3:0]B);

  always @(*)
  begin
    // casex
    casex (B)
      4'b000x:
      begin
        Y = 0;
      end
      4'b00x1:
      begin
        Y = 2'd1;
      end
      4'b0x10:
      begin
        Y = 2'd2;
      end
      4'bx011:
      begin
        Y = 2'd3;
      end
      4'b0100:
      begin
        Y = 4'd4;
      end
      4'b0101:
      begin
        Y = 4'd5;
      end
      4'b0110:
      begin
        Y = 4'd6;
      end
      4'b0111:
      begin
        Y = 4'd7;
      end
      default:
      begin
        Y = 4'd15;
      end
    endcase
    // casex Z
    casex (B)
      4'b000z:
      begin
        zY = 0;
      end
      4'b00z1:
      begin
        zY = 2'd1;
      end
      4'b0z10:
      begin
        zY = 2'd2;
      end
      4'bz011:
      begin
        zY = 2'd3;
      end
      4'b0100:
      begin
        zY = 4'd4;
      end
      4'b0101:
      begin
        zY = 4'd5;
      end
      4'b0110:
      begin
        zY = 4'd6;
      end
      4'b0111:
      begin
        zY = 4'd7;
      end
      default:
      begin
        zY = 4'd15;
      end
    endcase
    // casex ? 
    casex (B)
      4'b000?:
      begin
        vY = 0;
      end
      4'b00?1:
      begin
        vY = 2'd1;
      end
      4'b0?10:
      begin
        vY = 2'd2;
      end
      4'b?011:
      begin
        vY = 2'd3;
      end
      4'b0100:
      begin
        vY = 4'd4;
      end
      4'b0101:
      begin
        vY = 4'd5;
      end
      4'b0110:
      begin
        vY = 4'd6;
      end
      4'b0111:
      begin
        vY = 4'd7;
      end
      default:
      begin
        vY = 4'd15;
      end
    endcase
    // casez 
    casez (B)
      4'b000x:
      begin
        Yz = 0;
      end
      4'b00x1:
      begin
        Yz = 2'd1;
      end
      4'b0x10:
      begin
        Yz = 2'd2;
      end
      4'bx011:
      begin
        Yz = 2'd3;
      end
      4'b0100:
      begin
        Yz = 4'd4;
      end
      4'b0101:
      begin
        Yz = 4'd5;
      end
      4'b0110:
      begin
        Yz = 4'd6;
      end
      4'b0111:
      begin
        Yz = 4'd7;
      end
      default:
      begin
        Yz = 4'd15;
      end
    endcase
    // casez Z 
    casez (B)
      4'b000z:
      begin
        zYz = 0;
      end
      4'b00z1:
      begin
        zYz = 2'd1;
      end
      4'b0z10:
      begin
        zYz = 2'd2;
      end
      4'bz011:
      begin
        zYz = 2'd3;
      end
      4'b0100:
      begin
        zYz = 4'd4;
      end
      4'b0101:
      begin
        zYz = 4'd5;
      end
      4'b0110:
      begin
        zYz = 4'd6;
      end
      4'b0111:
      begin
        zYz = 4'd7;
      end
      default:
      begin
        zYz = 4'd15;
      end
    endcase
    // casez ?
    casez (B)
      4'b000?:
      begin
        vYz = 0;
      end
      4'b00?1:
      begin
        vYz = 2'd1;
      end
      4'b0?10:
      begin
        vYz = 2'd2;
      end
      4'b?011:
      begin
        vYz = 2'd3;
      end
      4'b0100:
      begin
        vYz = 4'd4;
      end
      4'b0101:
      begin
        vYz = 4'd5;
      end
      4'b0110:
      begin
        vYz = 4'd6;
      end
      4'b0111:
      begin
        vYz = 4'd7;
      end
      default:
      begin
        vYz = 4'd15;
      end
    endcase
  end

endmodule
