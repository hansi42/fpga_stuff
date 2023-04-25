module Key(input key1, input clk12MHz, output led);

always @ (negedge key1) begin
  led <= !led;
end

endmodule
