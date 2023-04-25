module test;

reg clk12MHz = 0;
reg key1 = 1;
initial begin;
# 17 clk12MHz = 1;
# 11 clk12MHz = 0;
# 29 clk12MHz = 1;
# 11 clk12MHz = 0;
# 100 $stop;
end

module top(clk12MHz, key1,led1,led2, led3, led4, led5, led6, led7, led8,lcol1,lcol2,lcol3,lcol4,p1,p2);


initial $monitor ( "At time %t , value = %h (%0d ) " , $time , value , value);
endmodule
