`timescale 1ns/1ns
module divider_tb;
//Inputs
reg [3:0] a;//dividend
reg [3:0] d;//divisor
reg hfh =0;
//Outputs
wire [3:0] q;//quotient
wire [4:0] r;//remainder
//Instantiate the unit under test
non_restoring_divider uut (.clk(hfh),.q(q),.r(r),.a(a),.d(d));
initial begin
//Initializing the inputs
a = 0;
d = 0;
// Wait 100ns for global reset to finish
#100;
//Add stimulus or the values we are evaluating here
a=4'b1110;d=4'b0011;
// a=4'b1010;d=4'b0101; // remainder=0
//#10 a=4'b1011;d=4'b0101; // remainder=0
//#10 a=4'b1111;d=4'b1000; // both non-zero
//#10 a=4'b1000;d=4'b1100; // quotient=0
//#10 a=4'b1101;d=4'b1110; // quotient=0
#10;

//clk
repeat(7) #100 hfh=~hfh; 
end

initial begin
$dumpfile("non_restoring_divider.vcd");
$dumpvars;
end

endmodule


