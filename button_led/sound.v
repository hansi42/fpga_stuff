module Sound( input clk12MHz,
        input key1,
        input startPlaying,
        output reg debug,
        output reg note);



        reg [31:0] freq_counter = 32'b0; //frequency, 440hz means that it goes 440times on/off
        reg [31:0] note_length_counter = 32'b0; //length of the note
        reg [31:0] A = 32'd27272;
        reg [31:0] E = 32'd18202;
        reg [31:0] G = 32'd15306;
        reg [31:0] c = 32'd22933;
        //reg [31:0] C = 32'b0 ^ 24'b101101110001101100000000;
        reg playing = 1'b0;
        reg [32:0] note_length = 32'b0 ^ 24'b101101110001101100000000; //1 sec
        reg [1:0] states = 2'd3; //state machine
        //reg internal_note = 1'b0;
        //assign note = internal_note;





       always @ (posedge clk12MHz) begin
         freq_counter <= freq_counter + 1;
         note_length_counter <= note_length_counter + 1;

         case (states)
           2'd0: begin

           debug <= 1'b0;
             if (freq_counter >= A)
             begin
               //switch_note = note;
               note <= ~note;
               freq_counter <= 0;
             end

             if (note_length_counter >= note_length)
             begin
               states <= 2'd1;
               note_length_counter <= 32'b0;
             end

           end

           2'd1: begin
             if (freq_counter >= E)
             begin
               //switch_note <= note;
               //note <= !switch_note;
               note <= ~note;
               freq_counter <= 0;
             end

             if (note_length_counter >= note_length)
             begin
               states <= 2'd2;
               note_length_counter <= 32'b0;

             end



           end

           2'd2: begin

           if (freq_counter >= G)
             begin
               //switch_note <= note;
               //note <= !switch_note;
               note <= ~note;
               freq_counter <= 0;
             end

             if (note_length_counter >= note_length)
             begin
               states <= 2'd3;
               note_length_counter <= 32'b0;

             end



           end

           
           2'd3: begin // reset state //stale stage
           playing <= 1'b0;
           
           //freq_counter <= 0;
           //note_length_counter <= 0;

           end

     endcase
   end


   always @ (negedge key1) begin
     if (playing == 1'b0) begin
     playing <= 1'b1;
     states = 2'd0;
     debug <= 1'b1;
   end
     //freq_counter <= 32'b0;
     //note_length_counter <= 32'b0;

   end
       endmodule
