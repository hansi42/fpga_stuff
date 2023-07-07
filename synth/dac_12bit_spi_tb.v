`include "dac_12bit_spi.v"
`timescale 1 ns/10 ps

module dac_12bit_spi_tb;

reg rst, clk12MHz;
reg [11:0] digital_12bit_value;
integer i;
wire sdo, cs, sck, debug_sck_halfs;
wire [3:0] debug_states;
localparam period = 20;
       dac_12bit_spi dac_12bit_spi(.rst(rst), .clk12MHz(clk12MHz), .digital_12bit_value(digital_12bit_value), .sdo(sdo), .cs(cs), .sck(sck), .debug_states(debug_states), .debug_sck_halfs(debug_sck_halfs));



initial begin
  
rst <= 0;
digital_12bit_value <= 0;
for (i=0; i<128; i=i+1)
        begin
  clk12MHz <= 0;
  #period;
  clk12MHz <= 1;
  #period;


        end



      end
endmodule

