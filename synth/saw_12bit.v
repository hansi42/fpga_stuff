module saw_12bit( input clk12MHz,
  input wire [15:0] freq,
  output reg [11:0] bit12_word);

reg [32:0] counter;

always @ (posedge clk12MHz) begin
  counter <= counter + 1;
  case (freq)
    16'd440: begin
      if (counter[11:0] == 12'b01101011) begin
            bit12_word <= bit12_word + 1;
            counter <= 12'h000;
      end 
    end
    16'd1: begin
      if (counter[11:0] == 12'b101101110001) begin
        bit12_word <= bit12_word + 1;
        counter <= 12'h000;
      end
    end
    default begin // one second counting up in the default case
      if (counter[23:0] == 24'b101101110001101100000000) begin
              bit12_word <= bit12_word + 1;
              counter <= 0;
        end
    end



endcase
/*
if (counter[23:0] == 24'b101101110001101100000000) begin
        bit8_word <= bit8_word + 1;
        counter <= 0;
  end
*/
end





endmodule



