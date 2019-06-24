module roundU(
	output wire [127:0] out,  // output word
	input  wire [127:0] in,  // input word
	input  wire [191:0] RK  // round key
);

	/*
	 * This module does the work of a single encryption round.
	 * The input is first split into 4 32-bit parts A, B, C, D
	 * then are XOR'ed with the key parts K0..K5 according to the following list
	 * which also includes the full operation of the module
	 * A ^ RK0 + B ^ RK1 --> RL9 --> out0(32-bit)
	 * B ^ RK2 + C ^ RK3 --> RR5 --> out1(32-bit)
	 * C ^ RK4 + D ^ RK5 --> RR3 --> out2(32-bit)
	 * A               -->         out3(32-bit)
	 */
	 
	 
	//creating the rquired wires for splitting
	wire [31:0] A,    B,    C,    D;
	wire [31:0] out0, out1, out2, out3;
	wire [31:0] RK0,  RK1,  RK2,  RK3,  RK4,  RK5;
	wire [31:0] sum0, sum1, sum2;  // preshifted sum
	
	
	//splitting the input
	assign A    = in[127: 96],
			 B    = in[ 95: 64],
			 C    = in[ 63: 32],
			 D    = in[ 31:  0];
			 
	//assembling the output from its parts
	assign out[127: 96] = out0,
			 out[ 95: 64] = out1,
			 out[ 63: 32] = out2,
			 out[ 31:  0] = out3;
			 
	//splitting the key
	assign RK0 = RK[191:160],
			 RK1 = RK[159:128],
			 RK2 = RK[127: 96],
			 RK3 = RK[ 95: 64],
			 RK4 = RK[ 63: 32],
			 RK5 = RK[ 31:  0];
			 
	//finding the sums according to the description
	assign sum0 = (A ^ RK0) + (B ^ RK1),
			 sum1 = (B ^ RK2) + (C ^ RK3),
			 sum2 = (C ^ RK4) + (D ^ RK5);
			 
	//shifting and assigning the sums to the output
	assign out0 = {sum0[22:0], sum0[31:23]},
			 out1 = {sum1[4: 0], sum1[31: 5]},
			 out2 = {sum2[2: 0], sum2[31: 3]},
			 out3 = A;
			 
			 
endmodule
			 
			  
	