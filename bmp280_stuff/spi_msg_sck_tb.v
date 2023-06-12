`include "spi_msg.v"

`timescale 1 ns/10 ps
module spi_msg_sck_tb;

reg sdi, go, clk12MHz;
wire [15:0] tmp;
wire sdo, csb, sck;

localparam period = 20;

spi_msg spi (.sck(sck), .clk12MHz(clk12MHz), .sdi(sdi), .sdo(sdo), .csb(csb), .recv_message(tmp), .go(go));


initial begin


clk12MHz = 1'b0;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, sck %b", clk12MHz, csb, sdo, sck);
clk12MHz = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, sck %b", clk12MHz, csb, sdo, sck);
clk12MHz = 1'b0;
  #period;
  clk12MHz= 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, sck %b", clk12MHz, csb, sdo, sck);
clk12MHz = 1'b0;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, sck %b", clk12MHz, csb, sdo, sck);
clk12MHz = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, sck %b", clk12MHz, csb, sdo, sck);
clk12MHz = 1'b0;
  #period;
  clk12MHz= 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, sck %b", clk12MHz, csb, sdo, sck);

end
endmodule
