`include "non_restoring_divison.v"
//`timescale 1ns / 1ps
module non_restoring_divider_tb;
//inputs
reg[3:0] X;  
reg[3:0] Y; 
//outputs
wire[4:0] R;
wire[3:0] Q; 
non_restoring_divider uut (.X(X),.Y(Y),.R(R),.Q(Q));
initial begin
  $dumpfile("non_restoring_division.vcd");
  $dumpvars(0, non_restoring_divider_tb);
//intialise inputs
  X=4'b0001; Y=4'b0001;
  //reset
  #20 X=4'b0110; Y=4'b0010;
  #20 X=4'b1100; Y=4'b0011; 
  #20 X=4'b1101; Y=4'b1100; 
  #20 X=4'b0101; Y=4'b1010; 
  #20 X=4'b1001; Y=4'b1100; 
  #20 X=4'b1110; Y=4'b1001; 
end
initial $monitor ($time,"remainder =%b,quotient=%b",R,Q);
endmodule
