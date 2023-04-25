`include "key.v"

module top(input key1, input clk12MHz, 
  output led1,
output lcol1);

wire led;

assign led1 = led;
assign lcol1 =1'b0;
Key key(
  .clk12MHz(clk12MHz),
  .key1(key1),
  .led(led));
endmodule
