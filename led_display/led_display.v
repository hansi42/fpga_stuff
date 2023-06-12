`include "../lib/led_driver.v"

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
	output lcol4
	);


        reg [1:0] states = 2'b0;

        reg [7:0] l1;
        reg [7:0] l2;
        reg [7:0] l3;
        reg [7:0] l4;

        reg [7:0] line_leds;
        reg [3:0] column_leds;
        reg signal;
        reg [6:0] counter;


       assign {led8, led7, led6, led5, led4, led3, led2, led1} = line_leds; 
       assign {lcol4, lcol3, lcol2, lcol1} = column_leds;

       led_driver led_driver (.clk12MHz(clk12MHz), .l1(l1), .l2(l2), .l3(l3), .l4(l4), .line_leds(line_leds), .column_leds(column_leds));

       always @ (posedge clk12MHz) begin
          l1 = 8'b11110111;
          l2 = 8'b00001111;
          l3 = 8'b10101010;
          l4 = 8'b01010101;

                 end
          endmodule






