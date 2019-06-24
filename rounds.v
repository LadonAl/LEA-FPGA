module rounds(
	output wire [127:0] out,
	input  wire [191:0] RK0,  RK1,  RK2,  RK3,  RK4,  RK5,  
			 				  RK6,  RK7,  RK8,  RK9,  RK10, RK11, 
							  RK12, RK13, RK14, RK15, RK16, RK17, 
							  RK18, RK19, RK20, RK21, RK22, RK23,  // 24 192-bit round sub-keys
	input wire [127:0] in,
	input  wire        decrypt  // if this was high, the input will be decrypted
										 // otherwise it will be encrypted
);

	/*
	 * This module connects multiple roundU's in order to complete the encryption process
	 */
	
	//assembling the keys into a single vector
	wire [191:0] RK [0:23];
	
	assign RK[ 0]  = RK0,  RK[ 1] = RK1,  RK[ 2] = RK2,  RK[ 3] = RK3, 
			 RK[ 4]  = RK4,  RK[ 5] = RK5,  RK[ 6] = RK6,  RK[ 7] = RK7, 
			 RK[ 8]  = RK8,  RK[ 9] = RK9,  RK[10] = RK10, RK[11] = RK11, 
			 RK[12]  = RK12, RK[13] = RK13, RK[14] = RK14, RK[15] = RK15, 
			 RK[16]  = RK16, RK[17] = RK17, RK[18] = RK18, RK[19] = RK19, 
			 RK[20]  = RK20, RK[21] = RK21, RK[22] = RK22, RK[23] = RK23;
	
	
	//to be connected to the output of every round
	wire [127:0] round [0:23];
	
	//to be connected to the output of every round (decryption mode)
	wire [127:0] decryption [0:23];
	
	//assigning the result of the last round to the output
	assign out = (decrypt)? decryption[23]:round[23];
	
	//connecting the rounds
	roundU r0(
		round[0],  // output word
		in,  // input word
	   RK[0]  // round key
	);
	
	
	genvar i;  // parameter for iterations
	
	//a new instance of each declared wires is created in this block
	generate
		for (i = 5'd1; i < 5'd24; i = i + 1) begin:enc 
			roundU r (
				round[i],
				round[i-1],
				RK[i]
			);
		end
	endgenerate
	
	
	
	//connecting the rounds (decryption mode)
	decryptU d0(
		decryption[0],  // output word
		in,  // input word
	   RK[23]  // round key
	);
	
	
	genvar j;  // parameter for iterations
	
	//a new instance of each declared wires is created in this block
	generate
		for (j = 5'd1; j < 5'd24; j = j + 1) begin:dec
			decryptU d (
				decryption[j],
				decryption[j-1],
				RK[23-j]
			);
		end
	endgenerate
	
	
endmodule
