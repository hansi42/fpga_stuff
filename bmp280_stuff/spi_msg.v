module spi_msg(input clk12MHz,
  input sdi,
  input go,
  output reg sck,
  output reg sdo,
  output reg csb,
  output reg [15:0] recv_message);


reg [32:0] sck_counter = 32'h00000000;

reg [3:0] states = 4'b1000;
reg [3:0] msg_bit_counter = 4'h0;
reg [3:0] recv_msg_bit_counter = 4'h0;
//reg [7:0] reg_address = 8'hFA; // TODO: ADressen übermittlung?
//reg [6:0] reg_address = 7'b1110110;
//
//reg [6:0] reg_address = 7'b1111000;
reg [6:0] reg_address = 7'b1010000; //chip id for testing reasons
//expected result= 0x60 01100000
//reg [15:0] recv_message = 16'b1;

//assign tmp = recv_message;
//

always @ (posedge clk12MHz) begin
  sck_counter <=  sck_counter + 1;
  sck <= sck_counter[20];
/*
      recv_message[15] <= ~states[3];
      recv_message[14] <= ~states[2];
      recv_message[13] <= ~states[1];
      recv_message[12] <= ~states[0];

      recv_message[0] <= ~msg_bit_counter[3];
      recv_message[1] <= ~msg_bit_counter[2];
      recv_message[2] <= ~msg_bit_counter[1];
      recv_message[3] <= ~msg_bit_counter[0];

*/

  case (sck)
    1'b1: begin
      case(states)
      4'b0000: begin
        csb <= 0;
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
        recv_message[15 - recv_msg_bit_counter] <= sdi;
        if(recv_msg_bit_counter == 15) begin
          states <= 4'b0111;
        end
        else begin
          states <= 4'b0110;
        end
      end

      4'b1000: begin
        csb <= 1;
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
        sdo <= 1; //rw bit
        states <= 4'b0010;
      end
      4'b0011: begin

        sdo <= reg_address[6 - msg_bit_counter];
        if(msg_bit_counter == 6) begin
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
        csb <= 1;
        recv_msg_bit_counter <= 0;
      end

      4'b1010: begin

       states <= 4'b0101;
      end

      

    endcase

    end

  endcase
end



/*
always @ ( posedge go) begin
      csb <= 1;
      states <= 3'b000;

end


always @ ( posedge sck) begin
      recv_message[15] <= states[2];
      recv_message[14] <= states[1];
      recv_message[13] <= states[0];

    case(states)
      3'b000: begin
        csb <= 0;
        states <= 3'b001;
        sdo <= 0; //rw bit
      end
      3'b001: begin
        states <= 3'b010;
      end
      3'b010: begin
        msg_bit_counter <= msg_bit_counter + 1;
      end
      3'b011: begin
        recv_message[15 - msg_bit_counter] <= sdi;
        if(msg_bit_counter == 15) begin
          states <= 3'b100;
        end
      end
      
    endcase
 end


always @ ( negedge sck) begin
    case(states)
      3'b001: begin
        sdo <= 1; //rw bit
      end
      3'b010: begin
        if(msg_bit_counter == 7) begin
          states <= 3'b011;
          msg_bit_counter = 0;
        end
        sdo <= reg_address[msg_bit_counter];
      end
      3'b011: begin
        msg_bit_counter <= msg_bit_counter + 1;

      end


    endcase

 end
*/

endmodule

