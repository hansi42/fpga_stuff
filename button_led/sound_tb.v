`timescale 1s/1s  // time-unit = 1 ns, precision = 10 ps


module sound_tb();
reg clk12MHz;
reg key1;
reg startPlaying;
wire debug;
wire note;



Sound s(
  .clk12MHz(clk12MHz), .key1(key1), .startPlaying(startPlaying), .note(note), .debug(debug));
initial begin 
//  clk12MHz=1'b0;
//  repeat (240000001)begin
//  clk12MHz = ~clk12MHz;
 // c <= c + 1;
//$display("clk: %d note: %d", clk12MHz, note);

   // end
   
   #100;
   key1 <= 1'b1;
   #100;

   $display("debug: %b", debug);
#100;

   key1 <= 1'b0;
#100;

   $display("debug: %b", debug);
#100;

$display("time: %0t", $time);
#10000000000000000000;
$display("time: %0t", $time);




end


always @ (posedge note) begin
      end


endmodule 
