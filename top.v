module top(
	output wire [127:0] out,   // output placeholder (used for testing now)
	input  wire [127:0] key,  // 128-bit key
	input  wire [127:0] in,   // 128-bit input
	input  wire         decrypt  // if this was high, the input will be decrypted
										  // otherwise it will be encrypted
	
);

	/*
	 * This module is supposed to hold everything together.
	 * for testing purposes, the ouput has been set to be 
	 * the sub-key for the 0th round.
	 *
	 * This module takes a 128-bit input and key and is 
	 * supposed to return an encrypted output
	 */
	 
	// to be connected to the key generator output ports
	wire [191:0] RK0,  RK1,  RK2,  RK3,  RK4,  RK5, 
					 RK6,  RK7,  RK8,  RK9,  RK10, RK11, 
					 RK12, RK13, RK14, RK15, RK16, RK17, 
					 RK18, RK19, RK20, RK21, RK22, RK23;
								  
	//assign out = RK0;// for testing purposes /// TODO: assign this properly
	
	// key generator that produces 24 192-bit round keys
	keyGen KG(
		RK0,  RK1,  RK2,  RK3,  RK4,  RK5, 
		RK6,  RK7,  RK8,  RK9,  RK10, RK11, 
		RK12, RK13, RK14, RK15, RK16, RK17, 
		RK18, RK19, RK20, RK21, RK22, RK23,
		key
	);
	
	
	rounds r(
		out,
		RK0,  RK1,  RK2,  RK3,  RK4,  RK5,  
		RK6,  RK7,  RK8,  RK9,  RK10, RK11, 
		RK12, RK13, RK14, RK15, RK16, RK17, 
		RK18, RK19, RK20, RK21, RK22, RK23,  // 24 192-bit round sub-keys
		in,
		decrypt  // if this was high, the input will be decrypted
					// otherwise it will be encrypted
	);


endmodule
