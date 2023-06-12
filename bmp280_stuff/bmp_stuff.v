`include "spi_msg.v"
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
	output lcol4,
        output sck,
        input sdi,
        output sdo,
        output csb
	);

        reg [31:0] counter = 32'b0;

        wire [7:0] line_leds;
        wire [3:0] column_leds;


        reg go;
//        reg [15:0] tmp = 16'b0000000011111111;
        wire [15:0] tmp;
        //
 
        //led_driver stuff:
        reg [7:0] l1 = 8'hFF;
        reg [7:0] l2 = 8'hFF;
        reg [7:0] l3 = 8'hFF;
        reg [7:0] l4 = 8'hFF;

        assign {led8, led7, led6, led5, led4, led3, led2, led1} = line_leds; 
       assign {lcol4, lcol3, lcol2, lcol1} = column_leds[3:0];

       spi_msg spi (.go(go), .clk12MHz(clk12MHz), .sdi(sdi), .sdo(sdo), .csb(csb), .recv_message(tmp), .sck(sck));
       led_driver led_driver (.clk12MHz(clk12MHz), .l1(l1), .l2(l2), .l3(l3), .l4(l4), .line_leds(line_leds), .column_leds(column_leds));


       always @ (posedge clk12MHz) begin
  //       counter <= counter + 1;
    //     if (counter == 20000000) begin
      //   end
         
         go <= sck;
         l1 <= tmp[7:0];
         l2 <= tmp[15:8];
         l3[0] <= ~sck;
         l3[1] <= ~sck;
         l3[2] <= csb;
         l3[3] <= sdi;
         l3[4] <= ~sdo;
         //l1 = 8'b1; 
         //l2 = 8'b1;
         //l3 = 8'b1;
         //l4 = 8'b1;


       end


       endmodule


