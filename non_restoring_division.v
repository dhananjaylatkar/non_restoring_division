// To calculate X/Y

module non_restoring_divider(X,Y);

output reg[3:0] R;  // Remainder
output reg[3:0] Q; // Quotient
input [3:0] X;  // Divident
input [3:0] Y;  // Divisor
integer k;  // for interations
reg[7:0] AQ;  // 8 bit reg for A and Q

always @(X, Y)
begin
  for (k = 7; k <=4; k = k - 1) // first four bits of AQ are 0 
  begin
    AQ[k] = 0;
  end

  for (k = 3; k <=0; k = k - 1) // last four bits of AQ are initialised to Divident, X
  begin
    AQ[k] = X[k];
  end

  for(k=0; k < 4; k = k + 1) // since give input is four bits, we need four cycles
  begin
    AQ = AQ<<1; // shift AQ to left by 1 bit
    //full adder/subtracter module to be called. sum will be in AQ[7:4]
    AQ[0] = ~AQ[7];
    
    if(AQ[7])
    begin
      //full adder/subtracter module to be called. sum will be stored in AQ[7:4]
    end
    else
    begin
      //full adder/subtracter module to be called. sum will be stored in AQ[7:4]
    end
  end
  // restore remainder
  // full adder/subtracter module to be called  R = AQ[7:4] + Y 

  //assign Q[3:0] = AQ[3:0]; 
  for (k = 3; k <=0; k = k - 1) // Quotient
  begin
    Q[k] = AQ[k];
  end
end
endmodule


// 4 bit adder and  subtractor
module ripple_carry_adder_sub_4bit (sum,carry,a,b,M);
// M is selection bit; M=0 -> add; M=1 -> sub;
output [3:0] sum;        
output carry;
input [3:0] a;
input [3:0] b;
input M;

wire [2:0] c;
wire [3: 0] b_xor_M;

xor (b_xor_M[0], b[0], M);
xor (b_xor_M[1], b[1], M);
xor (b_xor_M[2], b[2], M);
xor (b_xor_M[3], b[3], M);

// 4 instances of individual full adder blocks
FA FA0 (.s(sum[0]),.co(c[0]),.a(a[0]),.b(b_xor_M[0]),.ci(M));
FA FA1 (.s(sum[1]),.co(c[1]),.a(a[1]),.b(b_xor_M[1]),.ci(c[0]));
FA FA2 (.s(sum[2]),.co(c[2]),.a(a[2]),.b(b_xor_M[2]),.ci(c[1]));
FA FA3 (.s(sum[3]),.co(carry),.a(a[3]),.b(b_xor_M[3]),.ci(c[2]));

endmodule

// module declaration for FA.
module FA (s,co,a,b,ci);
output s,co;
input a,b,ci;
wire pp1,pp2,pp3,pp4,a_b,b_b,c_b,px1,px2,px3,px4,px5,px6,px7,px8,x1,x2;
//Gate level implementation of FA.
//-----Implementing 3 input XOR gate for SUM------------//
 not (a_b,a); //~a
 not (b_b,b); //~b
 not (c_b,ci); //~c

 and (px1,a_b,b);
 and (px2,px1,c_b);
 and (px3,a,b_b);
 and (px4,px3,c_b);
 and (px5,a,b);
 and (px6,px5,ci);
 and (px7,a_b,b_b);
 and (px8,px7,ci);
 or (x1,px2,px4);
 or (x2,px6,px8);
 or (s,x1,x2);


//------Implementing carry logic------------------------//
 and (pp1,a,b);
 and (pp2,b,ci);
 and (pp3,a,ci);
 or (pp4,pp1,pp2);
 or (co,pp4,pp3);
endmodule