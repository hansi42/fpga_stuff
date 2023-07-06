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


        assign {led8, led7, led6, led5, led4, led3, led2, led1} = line_leds; 
       assign {lcol4, lcol3, lcol2, lcol1} = column_leds[3:0];

       led_driver led_driver (.clk12MHz(clk12MHz), .l1(l1), .l2(l2), .l3(l3), .l4(l4), .line_leds(line_leds), .column_leds(column_leds));
       spi_getID spi_getID (.clk12MHz(clk12MHz), .sdi(sdi), .sdo(sdo), .cs(cs), .sck(sck), .recv_msg(recv_msg));




       always @ (*) begin

         l1 <= recv_msg;
         //l1 <= 8'h00;
         l2[0] <= sck;
         l3[0] <= cs;
         l4[0] <= sdo;
         l4[1] <= sdi;
       end


       endmodule

module spi_getID(input sdi,
  input clk12MHz,
output sdo, 
output cs, 
output sck,
output [7:0] recv_msg);




reg [7:0] reg_address = 8'h9F; // 10011111

reg [32:0] sck_counter = 32'h00000000;


reg [3:0] states = 4'b1000;
reg [3:0] msg_bit_counter = 4'h0;
reg [3:0] recv_msg_bit_counter = 4'h0;
reg sdo_internal; 
reg cs_internal;
reg sck_internal;
reg [7:0] recv_msg_internal = 8'h00;

assign sdo = sdo_internal;
assign cs = cs_internal;
assign sck = sck_internal;
assign recv_msg[7:0] = recv_msg_internal[7:0];

/*
always @ (posedge clk12MHz) begin
  sck_counter <=  sck_counter + 1;
  sck_internal <= sck_counter[23];

  case (sck_internal)
    1'b1: begin
      case(states)
      4'b0000: begin
        cs_internal <= 0;
        states <= 4'b0001;
      end
      4'b0010: begin
        states <= 4'b0011;
      end
      4'b0100: begin
        msg_bit_counter <= msg_bit_counter + 1;
        states <= 4'b0011;
      end
      4'b0101: begin

        msg_bit_counter <= 4'h0;
        recv_msg_internal[7- recv_msg_bit_counter] = sdi;
        if(recv_msg_bit_counter == 7) begin
          states <= 4'b0111;

        end
        else begin
          states <= 4'b0110;
        end
      end

      4'b1000: begin
        cs_internal <= 1;
        states <= 4'b0000;
      end
      4'b1001: begin
        states <= 4'b1010;

      end

    endcase
    end
    1'b0: begin
      case(states)
      4'b0001: begin
        sdo_internal <= 1; //rw bit
        states <= 4'b0010;
      end
      4'b0011: begin

        sdo_internal = reg_address[7 - msg_bit_counter]; // MSB
        if(msg_bit_counter == 7) begin
          states <= 4'b1001;
        end
        else begin
          states <= 4'b0100;
        end
      end
      4'b0110: begin
        recv_msg_bit_counter <= recv_msg_bit_counter + 1;
        states <= 4'b0101;

      end
      4'b0111: begin
        cs_internal <= 1;
        recv_msg_bit_counter <= 0;
      end

      4'b1010: begin

       states <= 4'b0101;
      end

      

    endcase

    end

  endcase
end
*/

endmodule
