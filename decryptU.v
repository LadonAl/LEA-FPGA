module decryptU(
	output wire [127:0] out,  // output word
	input  wire [127:0] in,  // input word
	input  wire [191:0] RK  // round key
);

	/*
	 * This module does the work of a single encryption round.
	 * The input is first split into 4 32-bit parts A, B, C, D
	 * then are XOR'ed with the key parts K0..K5 according to the following list
	 * which also includes the full operation of the module
	 * D --> out0 (32-bit)
	 * A --> RR9 --> - (out0 ^ RK0) --> ^ RK1 --> out1 (32-bit)
	 * B --> RL5 --> - (out1 ^ RK2) --> ^ RK3 --> out2 (32-bit)
	 * C --> RL3 --> - (out2 ^ RK4) --> ^ RK5 --> out3 (32-bit)
	 */
	 
	 
	//creating the rquired wires for splitting
	wire [31:0] A,    B,    C,    D;
	wire [31:0] out0, out1, out2, out3;
	wire [31:0] RK0,  RK1,  RK2,  RK3,  RK4,  RK5;
	wire [31:0] s0, s1, s2, s3;  // shifted values
	
	
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
	assign s0 = {A[ 8:0], A[31: 9]},
			 s1 = {B[26:0], B[31:27]},
			 s2 = {C[28:0], C[31:29]},
			 s3 = D;
			 
	//shifting and assigning the sums to the output
	assign out0 = s3,
			 out1 = (s0 - (out0 ^ RK0)) ^ RK1,
			 out2 = (s1 - (out1 ^ RK2)) ^ RK3,
			 out3 = (s2 - (out2 ^ RK4)) ^ RK5;
			 
			 
endmodule
			 
			  
	