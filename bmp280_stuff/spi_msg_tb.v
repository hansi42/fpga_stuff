`include "spi_msg.v"

`timescale 1 ns/10 ps
module spi_msg_tb;

reg sdi, go, clk12MHz;
wire [15:0] recv_message;
wire sdo, csb, sck;
wire [3:0] debug_states;

localparam period = 20;

integer i;

spi_msg spi ( .clk12MHz(clk12MHz), .sdi(sdi), .sdo(sdo), .csb(csb), .recv_message(recv_message), .go(go), .sck(sck), .debug_states(debug_states));

initial begin
  for (i=0; i<200; i=i+1)
        begin
  clk12MHz <= 0;
  #period;
  clk12MHz <= 1;
  #period;


        end

    end



endmodule


