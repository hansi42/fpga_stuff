module dac_12bit_spi(
  input rst,
  input clk12MHz,
  input [11:0] digital_12bit_value,
output sdo = 0'b0, 
output cs, 
output sck,
output [3:0] debug_states,
output debug_sck_halfs);


reg [7:0] reg_address = 8'h9F; // 10011111
//reg [7:0] reg_address = 8'h9E; // 10011110
reg [3:0] prefix_bits = 4'b0011; 
reg [32:0] sck_counter = 32'h00000000;


reg [3:0] states = 4'b1000;
reg [3:0] msg_bit_counter = 4'h0;
reg [1:0] prefix_bit_counter = 2'b00;
reg sdo_internal = 1'b0; 
reg cs_internal = 1'b1;
reg sck_internal = 1'b0;
reg sck_internal_halfs =1'b0;
reg [7:0] recv_msg_internal = 8'h00;
reg running = 1'b0;

assign sdo = sdo_internal;
assign cs = cs_internal;
assign sck = running ? sck_internal : 1'b1;
assign recv_msg = recv_msg_internal;
assign debug_states = states;
assign debug_sck_halfs = sck_internal_halfs;

parameter SCK_COUNTER_SPEED  = 20; //needs to be > than one

always @ (posedge clk12MHz) begin
  sck_counter <=  sck_counter + 1;
  sck_internal <= sck_counter[SCK_COUNTER_SPEED];
  sck_internal_halfs <= sck_counter[SCK_COUNTER_SPEED - 1];
end

always @ (posedge sck_internal_halfs) begin
  case (sck_internal)
    1'b1: begin
      case(states)
      4'b0000: begin
        cs_internal <= 0;
        running <= 1;
        states <= 4'b0011;
      end
      /*
      4'b0010: begin // skipped
        states <= 4'b0011;
      end */
      4'b0100: begin
        prefix_bit_counter <= prefix_bit_counter+ 1;
        states <= 4'b0011;
      end
      4'b1000: begin
        cs_internal <= 1;

        if(~rst) begin
        states <= 4'b0000;
      end
      end
      4'b1001: begin
        states <= 4'b0101;

      end
      4'b0110: begin
       msg_bit_counter  <= msg_bit_counter + 1;
        states <= 4'b0101;

      end

    endcase
    end
    1'b0: begin
      case(states)
      /*4'b0001: begin // skipped
        states <= 4'b0010;
      end */
      4'b0011: begin

        sdo_internal <= prefix_bits[3 - prefix_bit_counter]; // MSB
        if(prefix_bit_counter == 3) begin
          states <= 4'b1001;
        end
        else begin
          states <= 4'b0100;
        end
      end
      4'b0111: begin
        cs_internal <= 1;
        running <= 0;
        recv_msg_bit_counter <= 0;

      end

      4'b0101: begin

        sdo_internal <= digital_12bit_value[11 - msg_bit_counter]; // MSB
        if(msg_bit_counter == 11) begin
          states <= 4'b0111;
        end
        else begin
          states <= 4'b0110;
        end
      end


      

    endcase

    end

  endcase
end
e
