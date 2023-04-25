module basic_sound(input clk12MHz,
  output reg note);


//reg [31:0] C = 32'b0 ^ 24'b101101110001101100000000;
reg [31:0] C = 32'b0 ^ 15'b110101010001000;
reg [31:0] freq_counter = 32'b0; //frequency, 440hz means that it goes 440times on/off


always @ (posedge clk12MHz) begin
  freq_counter <= freq_counter + 1;
  /*if(freq_counter >= C) begin 
    note <= !note;
    freq_counter <= 32'b0;
  end
  else note <= note;
*/

  case(freq_counter)
    C: begin
      note <= !note;
      freq_counter <= 32'b0;
    end
  endcase



end
endmodule
