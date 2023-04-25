module spi_msg(input clk12MHz,
  input reg [7:0] send_message,
  input sdi,
  output sdo,
  output csb,
  output sck,
  output reg [7:0] recv_message);

reg [3:0] states = 4'b0;
reg [1:0] clk_divider = 2'b0;
reg [2:0] msg_bit_counter = 3'b0;

always @ ( posedge clk12MHz) begin
  clk_divider <= clk_divider + 1;

  case (states) begin
    4'd0: begin //default state
      csb <= 1; 
    end

    4'd1: begin
      csb <= 0;
      states <= 4'd2;
    end

    4'd2: begin //starting to communicate

    
  end
      
      
    
  end

  endcase
end

endmodule

