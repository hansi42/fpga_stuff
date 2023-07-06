`include "../lib/led_driver.v"
`include "spi_getID.v"

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
        output sck,
        output cs,
        output sdo,
        input sdi
	);


        wire [7:0] line_leds;
        wire [3:0] column_leds;
        reg [7:0] l1 = 8'hFF;
        reg [7:0] l2 = 8'hFF;
        reg [7:0] l3 = 8'hFF;
        reg [7:0] l4 = 8'hFF;
        
        wire [2:0] states;

        wire [7:0] recv_msg;
        wire rst;
        wire [3:0] debug_states;

        assign {led8, led7, led6, led5, led4, led3, led2, led1} = line_leds; 
       assign {lcol4, lcol3, lcol2, lcol1} = column_leds[3:0];
       assign rst = key1;

       led_driver led_driver (.clk12MHz(clk12MHz), .l1(l1), .l2(l2), .l3(l3), .l4(l4), .line_leds(line_leds), .column_leds(column_leds));
       spi_getID spi_getID (.clk12MHz(clk12MHz), .sdi(sdi), .sdo(sdo), .cs(cs), .sck(sck), .recv_msg(recv_msg), .rst(rst), .debug_states(debug_states));


       always @ (*) begin

         l1 <= recv_msg;
         //l1 <= 8'h00;
         l2[0] <= ~sck;
         l3[0] <= ~cs;
         l4[0] <= ~sdo;
         l4[1] <= ~sdi;

       end



       endmodule


