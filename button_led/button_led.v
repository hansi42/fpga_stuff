`include "sound.v"
`include "blinking_stuff.v"
`include "basic_sound.v"

module top(input clk12MHz,
  input key1,
	output led1, 
	output led2, 
	output led3, 
	output led4, 
	output led5, 
	output led6, 
	output led7, 
	output led8, 
	output lcol1, 
	output lcol2, 
	output lcol3, 
	output lcol4,
        output p1,
        output p2
	);




       wire [7:0] line_leds;
        wire [3:0] column_leds;
       wire startPlaying;
       wire note;

       assign {led7, led6, led5, led4, led3, led2, led1} = line_leds[6:0] ^ 7'h00;
       assign led8 = note;
       assign {lcol4, lcol3, lcol2, lcol1} = column_leds[3:0];
       assign p1 = note;
       assign p2 = !note;

        Sound sound(
          .clk12MHz(clk12MHz),
          .key1(key1),
          .startPlaying(startPlaying),
          .note(note));

/*
       basic_sound bs(
         .clk12MHz(clk12MHz),
         .note(note));
*/

        BlinkingStuff blinkingstuff(
          .clk12MHz(clk12MHz),
          .key1(key1),
          .column_leds(column_leds),
          .line_leds(line_leds)

        );
          
               
        endmodule


