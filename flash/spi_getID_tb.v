`include "spi_getID.v"
`timescale 1 ns/10 ps

module spi_getID_tb;

reg rst, clk12MHz;
reg sdi;
integer i;
wire sdo, cs, sck, debug_sck_halfs;
wire [3:0] debug_states;
wire [7:0] recv_msg;
localparam period = 20;
       spi_getID spi_getID (.clk12MHz(clk12MHz), .sdi(sdi), .sdo(sdo), .cs(cs), .sck(sck), .recv_msg(recv_msg), .rst(rst), .debug_states(debug_states), .debug_sck_halfs(debug_sck_halfs));


initial begin
  
rst <= 0;
for (i=0; i<128; i=i+1)
        begin
  clk12MHz <= 0;
  sdi <= ~clk12MHz;
  #period;
  clk12MHz <= 1;
  sdi <= ~clk12MHz;
  #period;


        end



      end
endmodule


