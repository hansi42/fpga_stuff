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

        wire [7:0] line_leds;
        wire [3:0] column_leds;

        assign {led8, led7, led6, led5, led4, led3, led2, led1} = line_leds[7:0];
       assign {lcol4, lcol3, lcol2, lcol1} = column_leds[3:0];
       assign sck = clk12MHz;

       always @ (posedge clk12MHz) begin
         line_leds <= ~8'd23;
         column_leds <= 4'b1110;

       end
       endmodule


