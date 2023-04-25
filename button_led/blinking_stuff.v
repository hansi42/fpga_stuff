module BlinkingStuff(input clk12MHz,
  input key1,
  output reg[3:0] column_leds,
  output reg[7:0] line_leds);

reg [31:0] delay = 32'b0 ^ 24'b101101110001101100000000;
reg [31:0] counter = 32'b0;
       reg [1:0] column_counter = 2'b0;



always @ (posedge clk12MHz) begin
        //end

              counter <= counter + 1; 
        //always @ (posedge clk12MHz) begin
        //
        case (counter[24:0])
            24'b101101110001101100000000: begin
              counter <= 32'b0;
              line_leds <= line_leds + 1;
          end
        endcase

        end

        always @ (negedge key1) begin
          column_counter <= column_counter + 1;

          case (column_counter[1:0])
            2'b00: column_leds <= 4'b1110;
            2'b01: column_leds <= 4'b1101;
            2'b10: column_leds <= 4'b1011;
            2'b11: column_leds <= 4'b0111;
          endcase
        end
        endmodule
