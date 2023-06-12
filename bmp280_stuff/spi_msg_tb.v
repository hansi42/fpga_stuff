`include "spi_msg.v"

`timescale 1 ns/10 ps
module spi_msg_tb;

reg sdi, go, sck;
wire [15:0] tmp;
wire sdo, csb, internal_sck;

localparam period = 20;



spi_msg spi (.sck(internal_sck), .clk12MHz(sck), .sdi(sdi), .sdo(sdo), .csb(csb), .recv_message(tmp), .go(go));

initial begin

sck = 1'b0;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, internal_sck %b", sck, csb, sdo, internal_sck);
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, internal_sck %b", sck, csb, sdo, internal_sck);
sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, internal_sck %b", sck, csb, sdo, internal_sck);
$display("go signal ab hetzt");
go = 1'b1;
sck = 1'b0;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, internal_sck %b", sck, csb, sdo, internal_sck);
  sck = 1'b1;
  #period;
  
$display("Clock: %b, csb: %b, sdo: %b, internal_sck %b", sck, csb, sdo, internal_sck);
sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, internal_sck %b", sck, csb, sdo, internal_sck);

    sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b, internal_sck %b", sck, csb, sdo, internal_sck);


    sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);


    sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);

sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);

sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);

sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);

sck = 1'b0;
  #period;
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);


// receiving should start here
//
//
sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;

sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;

sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;

sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 0;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 0;
  #period;
  sck = 1'b1;
  #period;

sck = 1'b0;
sdi = 0;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;


sck = 1'b0;
sdi = 0;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 0;
  #period;
  sck = 1'b1;
  #period;

sck = 1'b0;
sdi = 0;
  #period;
  sck = 1'b1;
  #period;
sck = 1'b0;
sdi = 1;
  #period;
  sck = 1'b1;
  #period;


$display("recv: %b%b%b%b%b%b%b%b%b%b%b%b%b%b%b%b", tmp[15],tmp[14],tmp[13],tmp[12],tmp[11],tmp[10],tmp[9],tmp[8],tmp[7],tmp[6],tmp[5],tmp[4],tmp[3],tmp[2],tmp[1],tmp[0]);

sck = 1'b0;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);    

sck = 1'b0;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);    
sck = 1'b0;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);
  sck = 1'b1;
  #period;
$display("Clock: %b, csb: %b, sdo: %b", sck, csb, sdo);    

end



endmodule


