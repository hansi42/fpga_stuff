module saw_8bit( input clk12MHz,
  input wire [15:0] freq,
  output reg [7:0] bit8_word);

reg [32:0] counter;

always @ (posedge clk12MHz) begin
  counter <= counter + 1;
  case (freq)
    16'd440: begin
      if (counter[7:0] == 8'b01101011) begin
            bit8_word <= bit8_word + 1;
            counter <= 8'h00;
      end 
    end
    default begin // one second counting up in the default case
      if (counter[23:0] == 24'b101101110001101100000000) begin
              bit8_word <= bit8_word + 1;
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



