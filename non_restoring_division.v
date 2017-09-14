// A initially has zero, Q initially has dividend
// A is of five bits, Q is of four bits
// Shift left by one bit
// Subtract divisor from it
// If last bit is one, add zero to Q and add divisor to A
// If last bit is zero, add one to Q
// Repeat four times
// Q has quotient
// A has remainder

module non_restoring_divider(D1,D2,Q,A);

output [3:0] Q;
output [4:0] A;
input [3:0] D1;
input [3:0] D2;

A = 5'b00000;
assign Q = D1;
integer i;
always @(A,Q)
begin
for(i=0;i<4;i++)
begin
A=A<<1;
A[0]=Q[3];
Q=Q<<1;
//full adder/subtracter module to be called. sum will be in A
Q[0]=~A[4];
if(A[4])
//full adder/subtracter module to be called. sum will be stored in A
else
//full adder/subtracter module to be called. sum will be stored in A
end
endmodule
