`timescale 1ns/1ns

module non_restoring_divider (clk,q,r,a,d);
output [3:0] q;
output [4:0] r;
input [3:0] a;
input [3:0] d;
input clk;
reg [4:0] one;
reg [8:0] A;
reg [4:0] C;
reg [4:0] D;
reg [7:0] buffer;// extra utility reg
reg e;
wire [4:0] minus;//wire for subtracting
wire [4:0] plus;//wire for adding
integer i = 0;
reg [4:0] carry;
always@(a)
begin
carry = 5'b00000;
one[4:0] = 5'b00001;
buffer[3:0] = d;
buffer[7:4] = 4'b0000;
C = ~buffer[4:0]+one;//taking the twos complement
D = buffer[4:0];//divisor to add
A[8:4] = 5'b00000;
A[3:0] = a;
end

always@(posedge clk)
begin
e=A[8];
A = A<<1;//shifitng left
#20 if(e==1'b0)
 A[8:4] = minus; //subtraction depending on last bit
 else
A[8:4] = plus; //addition
A[0] = ~A[8];
#20 $display("%b",A);
end
assign q = A[3:0];

adder subtracter (.sum(minus),.carry(),.a(A[8:4]),.b(C),.cin(carry[0]));// for subtraction
adder adding (.sum(plus),.carry(),.a(A[8:4]),.b(D),.cin(carry[0]));// for addition
adder remainder (.sum(r),.carry(),.a(A[8:4]),.b(D),.cin(carry[0]));// for addition
endmodule

module adder (sum,carry,a,b,cin);
output [4:0] sum;
output carry;
input [4:0] a;
input [4:0] b;
input cin;
wire [3:0] c;
// 8 instances of individual full adder blocks
FA FA0 (.s(sum[0]),.co(c[0]),.a(a[0]),.b(b[0]),.ci(cin));
FA FA1 (.s(sum[1]),.co(c[1]),.a(a[1]),.b(b[1]),.ci(c[0]));
FA FA2 (.s(sum[2]),.co(c[2]),.a(a[2]),.b(b[2]),.ci(c[1]));
FA FA3 (.s(sum[3]),.co(c[3]),.a(a[3]),.b(b[3]),.ci(c[2]));
FA FA4 (.s(sum[4]),.co(carry),.a(a[4]),.b(b[4]),.ci(c[3]));
endmodule

module FA (s,co,a,b,ci);
output s,co;
input a,b,ci;
wire ps,pc0,pc1;
//2 instances of individual half adders
HA HA0 (.ip1(a),.ip2(b),.hs(ps),.hc(pc0));
HA HA1 (.ip1(ps),.ip2(ci),.hs(s),.hc(pc1));
or (co,pc0,pc1);
endmodule

module HA (ip1,ip2,hs,hc);
output hs,hc;
input ip1,ip2;
xor (hs,ip1,ip2);
and (hc,ip1,ip2);
endmodule
