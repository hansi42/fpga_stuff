module led_driver(input clk12MHz,
  input wire [7:0] l1,
  input wire [7:0] l2,
input wire [7:0] l3,
input wire [7:0] l4,
  output reg [7:0] line_leds,
  output reg [3:0] column_leds);


reg signal;
reg [1:0] states = 2'b0;
reg [31:0] counter = 32'b0;

always @ (posedge clk12MHz) begin
         counter <= counter + 1;
         signal <= counter[10];
       end

always @ (posedge signal) begin
          case (states)
            2'b00: begin
              column_leds <= 4'b1110;
              line_leds <= l1;
              states <= 2'b01;
            end
            2'b01: begin
              column_leds <= 4'b1101;
              line_leds <= l2;
              states <= 2'b10;
            end
            2'b10: begin
              column_leds <= 4'b1011;
              line_leds <= l3;
              states <= 2'b11;
            end
            2'b11: begin
              column_leds <= 4'b0111;
              line_leds <= l4;
              states <= 2'b00;
            end
          endcase
        end

      

        endmodule
