`include "non_restoring_divison.v"
module non_restoring_divider_tb;
//inputs
reg[3:0] X;  
reg[3:0] Y; 
//outputs
wire[4:0] R;
wire[3:0] Q; 
non_restoring_divider uut (.X(X),.Y(Y));
initial begin
//intialise inputs
  X=4'b0000; Y=4'b0000;
  //reset
  #200 X=4'b0110; Y=4'b0010;
  #200 X=4'b1100; Y=4'b0011; 
  #200 X=4'b1101; Y=4'b1100; 
  #200 X=4'b0101; Y=4'b1010; 
  #200 X=4'b1001; Y=4'b1100; 
  #200 X=4'b1110; Y=4'b1001; 
end
initial begin
	$dumpfile("non_restoring_divison.vcd");
	$dumpvars();
end
endmodule
