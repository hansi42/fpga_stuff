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


        wire [7:0] line_leds;
        wire [3:0] column_leds;
        reg [7:0] l1 = 8'hFF;
        reg [7:0] l2 = 8'hFF;
        reg [7:0] l3 = 8'hFF;
        reg [7:0] l4 = 8'hFF;
        
        wire [2:0] states;


        assign {led8, led7, led6, led5, led4, led3, led2, led1} = line_leds; 
       assign {lcol4, lcol3, lcol2, lcol1} = column_leds[3:0];

       led_driver led_driver (.clk12MHz(clk12MHz), .l1(l1), .l2(l2), .l3(l3), .l4(l4), .line_leds(line_leds), .column_leds(column_leds));

       automat automat (.clk12MHz(clk12MHz), .key1(key1), .states(states), .sck(sck), .debug(debug));


       always @ (*) begin

         l1[2:0] <= ~states[2:0];
         l1[7] <= sck;
         l1[5] <= debug;
       end


       endmodule

module automat(input clk12MHz,
  input key1,
  output [2:0] states,
output reg sck,
output reg debug);

reg [31:0] sck_counter = 32'h00000000;

reg [2:0] internal_states = 3'b000;

reg go = 1'b0;
reg running = 1'b0;


assign states = internal_states[2:0];


always @ (posedge clk12MHz) begin
  sck_counter <=  sck_counter + 1;
  sck <= sck_counter[24];
  case (sck)
    1'b0: begin // aka posedge
        case(internal_states)
        3'b000: begin
          if(~key1) begin
          internal_states <= 3'b001;
          running <= 1'b1;
        end
        end
        3'b010: begin
            internal_states <= 3'b011;
        end
            3'b100: begin
          internal_states <= 3'b101;
        end
        3'b110: begin
          internal_states <= 3'b111;
        end

      
    endcase
      end

    1'b1: begin // aka negedge
  case(internal_states)
      3'b000:begin
  if(~key1) begin
        internal_states <= 3'b001;
        running <= 1'b1;
      end
    end
          3'b001: begin
        internal_states <= 3'b010;
      end
       3'b011: begin
          internal_states <= 3'b100;
      end
         3'b101: begin
        internal_states <= 3'b110;
      end
      3'b111: begin
        internal_states <= 3'b000;
        running <= 1'b0;
        go <= 1'b0;
      end

    endcase
    end
  endcase
end

/*



always @ ( posedge sck) begin
debug = 1;

   end


always @ ( negedge sck) begin
debug = 0;

 end

always @ (~key1) begin
  if (~running)begin
  go <= 1'b1;

      internal_states <= 3'b000;
end
end
*/
 endmodule
