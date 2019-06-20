module processD(
	output wire [31:0] T0,  T1,  T2,  T3,  T4,  T5,  
							 T6,  T7,  T8,  T9,  T10, T11, 
							 T12, T13, T14, T15, T16, T17, 
							 T18, T19, T20, T21, T22, T23,  // 12 32-bit parts of the round key
	input wire  [31:0] D  // 32-bit part of the key 
);

	/*
	 * this module could be represented by an iterative
	 * diagram. Thus, it would be smart to generate those 
	 * iterations using a for loop with 24 iterations.
	 *
	 * in each of those iterations, a parameter is picked 
	 * based on the first 2 bits of the iteration 
	 * count (eq. to mod 4). The chosen parameter is 
	 * then shifted based on the iteration (i, i+1,
	 * i+2, i+3 for A, B, C, D respectively). The result
	 * is added to the input. The final result is shifted
	 * (1, 3, 6, 11 for A, B, C, D respectively) and is 
	 * connected to an appropriate output port 
	 */

	genvar i;  // parameter for iterations
	
	//a new instance of each declared wires is created in this block
	generate
		for (i = 5'd0; i < 5'd24; i = i + 1) begin:blk 
			wire [31:0] par;  // to be connected to the parameter generator
			paramas p  (par,{2'b0, i[1:0]});  // generating a parameter
			
			wire [31:0] spar;  // to be connected to the shifter that will shif the parameter
			shifter s  (spar, par, i + 3);  // shifting the parameter based on the iteration
			
			wire [31:0] isum;  // to be connected to the sum of a 32-bit part of the key and the shifted parameter
			assign isum = D + spar;  // adding the shifted parameter to the 32-bit part of the key
			
			wire [31:0] sum;  // to be connectd to the shifted sum  
			assign sum = {isum[20:0], isum[31:21]};  // shifting the sum
		end
	endgenerate

	// assigning the shifted sums to the 12 outputs
	assign T0  = blk[ 0].sum, T1  = blk[ 1].sum, T2  = blk[ 2].sum, 
			 T3  = blk[ 3].sum, T4 =  blk[ 4].sum, T5  = blk[ 5].sum, 
			 T6  = blk[ 6].sum, T7  = blk[ 7].sum, T8  = blk[ 8].sum, 
			 T9 =  blk[ 9].sum, T10 = blk[10].sum, T11 = blk[11].sum, 
			 T12 = blk[12].sum, T13 = blk[13].sum, T14 = blk[14].sum, 
			 T15 = blk[15].sum, T16 = blk[16].sum, T17 = blk[17].sum, 
			 T18 = blk[18].sum, T19 = blk[19].sum, T20 = blk[20].sum, 
			 T21 = blk[21].sum, T22 = blk[22].sum, T23 = blk[23].sum;

endmodule 
