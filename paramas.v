module paramas(
	output wire [31: 0] out,
	input  wire [ 3: 0] in
);

	/*
	 * This module has been created to store parameters 
	 * in a clock-free ROM-like manor that is for-loop-
	 * -friendly.
	 * 
	 * It takes a 4 bit input and prdouces a 32-bit output 
	 * based on it.
	 */

	assign out = (in == 0) ? 32'hc3efe9db : (in == 1) ? 32'h44626b02: 
					 (in == 2) ? 32'h79e27c8a : (in == 3) ? 32'h78df30ec: 
					 (in == 4) ? 32'h715ea49e : (in == 5) ? 32'hc785da0a: 
					 (in == 6) ? 32'he04ef22a :             32'he5c40957; 
				 
endmodule 