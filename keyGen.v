module keyGen(
	output wire [191:0] RK0,  RK1,  RK2,  RK3,  RK4,  RK5,  
							  RK6,  RK7,  RK8,  RK9,  RK10, RK11, 
							  RK12, RK13, RK14, RK15, RK16, RK17, 
							  RK18, RK19, RK20, RK21, RK22, RK23,  // 24 192-bit round sub-keys
	input  wire [127:0] key  // input key
);
	/*
	 * This module assembles all of the subfeatures of the key 
	 * generator. It also prepares the input key for processing
	 * 
	 * First the key is split into 4 32-bit parts (A, B, C, D),
	 * then each of those parts are rotated left by 8-bits. The 
	 * altered parts are then fed into processing modules that 
	 * produce the parts of the final 24 192-bit round keys
	 */


	wire[31:0] A, B, C, D;  // to be connected to the shifted sub-parts of the input key

	//shifting each group of 32-bit sub-words 
	assign A = {key[119: 96], key[127:120]};
	assign B = {key[ 87: 64], key[ 95: 88]};
	assign C = {key[ 55: 32], key[ 63: 56]};
	assign D = {key[ 23:  0], key[ 31: 24]};


	//To deliver the parts of the round keys
	wire [31:0] TA0,  TA1,  TA2,  TA3,  TA4,  TA5,  
					TA6,  TA7,  TA8,  TA9,  TA10, TA11, 
					TA12, TA13, TA14, TA15, TA16, TA17, 
					TA18, TA19, TA20, TA21, TA22, TA23;

	wire [31:0] TB0,  TB1,  TB2,  TB3,  TB4,  TB5,  
					TB6,  TB7,  TB8,  TB9,  TB10, TB11, 
					TB12, TB13, TB14, TB15, TB16, TB17, 
					TB18, TB19, TB20, TB21, TB22, TB23;

	wire [31:0] TC0,  TC1,  TC2,  TC3,  TC4,  TC5,  
					TC6,  TC7,  TC8,  TC9,  TC10, TC11, 
					TC12, TC13, TC14, TC15, TC16, TC17, 
					TC18, TC19, TC20, TC21, TC22, TC23;

	wire [31:0] TD0,  TD1,  TD2,  TD3,  TD4,  TD5,  
					TD6,  TD7,  TD8,  TD9,  TD10, TD11, 
					TD12, TD13, TD14, TD15, TD16, TD17, 
					TD18, TD19, TD20, TD21, TD22, TD23;
					
					
	//Grouping the previously mentioned wires to make them easier to use	
	wire [31:0] TA [0:23], TB [0:23], TC [0:23], TD [0:23];
	
	//bundeling related keys within the same wire vector
	assign TA[ 0] =  TA0,  TA[ 1] = TA1,  TA[ 2] = TA2,  TA[ 3] = TA3, 
			 TA[ 4] =  TA4,  TA[ 5] = TA5,  TA[ 6] = TA6,  TA[ 7] = TA7, 
			 TA[ 8] =  TA8,  TA[ 9] = TA9,  TA[10] = TA10, TA[11] = TA11, 
			 TA[12] =  TA12, TA[13] = TA13, TA[14] = TA14, TA[15] = TA15, 
			 TA[16] =  TA16, TA[17] = TA17, TA[18] = TA18, TA[19] = TA19, 
			 TA[20] =  TA20, TA[21] = TA21, TA[22] = TA22, TA[23] = TA23;

	assign TB[ 0] =  TB0,  TB[ 1] = TB1,  TB[ 2] = TB2,  TB[ 3] = TB3, 
			 TB[ 4] =  TB4,  TB[ 5] = TB5,  TB[ 6] = TB6,  TB[ 7] = TB7, 
			 TB[ 8] =  TB8,  TB[ 9] = TB9,  TB[10] = TB10, TB[11] = TB11, 
			 TB[12] =  TB12, TB[13] = TB13, TB[14] = TB14, TB[15] = TB15, 
			 TB[16] =  TB16, TB[17] = TB17, TB[18] = TB18, TB[19] = TB19, 
			 TB[20] =  TB20, TB[21] = TB21, TB[22] = TB22, TB[23] = TB23;
		
	assign TC[ 0] =  TC0,  TC[ 1] = TC1,  TC[ 2] = TC2,  TC[ 3] = TC3, 
			 TC[ 4] =  TC4,  TC[ 5] = TC5,  TC[ 6] = TC6,  TC[ 7] = TC7, 
			 TC[ 8] =  TC8,  TC[ 9] = TC9,  TC[10] = TC10, TC[11] = TC11, 
			 TC[12] =  TC12, TC[13] = TC13, TC[14] = TC14, TC[15] = TC15, 
			 TC[16] =  TC16, TC[17] = TC17, TC[18] = TC18, TC[19] = TC19, 
			 TC[20] =  TC20, TC[21] = TC21, TC[22] = TC22, TC[23] = TC23;

	assign TD[ 0] =  TD0,  TD[ 1] = TD1,  TD[ 2] = TD2,  TD[ 3] = TD3, 
			 TD[ 4] =  TD4,  TD[ 5] = TD5,  TD[ 6] = TD6,  TD[ 7] = TD7, 
			 TD[ 8] =  TD8,  TD[ 9] = TD9,  TD[10] = TD10, TD[11] = TD11, 
			 TD[12] =  TD12, TD[13] = TD13, TD[14] = TD14, TD[15] = TD15, 
			 TD[16] =  TD16, TD[17] = TD17, TD[18] = TD18, TD[19] = TD19, 
			 TD[20] =  TD20, TD[21] = TD21, TD[22] = TD22, TD[23] = TD23;

	//wiring and assembling the final keys  		 
	reg [191:0] RK [0:23];

	assign RK0  = RK[ 0], RK1  = RK[ 1], RK2  = RK[ 2], RK3  = RK[ 3],  
			 RK4  = RK[ 4], RK5  = RK[ 5], RK6  = RK[ 6], RK7  = RK[ 7],  
			 RK8  = RK[ 8], RK9  = RK[ 9], RK10 = RK[10], RK11 = RK[11],  
			 RK12 = RK[12], RK13 = RK[13], RK14 = RK[14], RK15 = RK[15],  
			 RK16 = RK[16], RK17 = RK[17], RK18 = RK[18], RK19 = RK[19],  
			 RK20 = RK[20], RK21 = RK[21], RK22 = RK[22], RK23 = RK[23];
			 
	//wiring the prepared wires to the processing modules
	processA PA(
		TA0,  TA1,  TA2,  TA3,  TA4,  TA5,  
		TA6,  TA7,  TA8,  TA9,  TA10, TA11, 
		TA12, TA13, TA14, TA15, TA16, TA17, 
		TA18, TA19, TA20, TA21, TA22, TA23,
		A
	);


	processB PB(
		TB0,  TB1,  TB2,  TB3,  TB4,  TB5,  
		TB6,  TB7, TB8,   TB9,  TB10, TB11, 
		TB12, TB13, TB14, TB15, TB16, TB17,
		TB18, TB19, TB20, TB21, TB22, TB23,
		B
	);

	processC PC(
		TC0,  TC1,  TC2,  TC3,  TC4,  TC5,  
		TC6,  TC7,  TC8,  TC9,  TC10, TC11, 
		TC12, TC13, TC14, TC15, TC16, TC17,
		TC18, TC19, TC20, TC21, TC22, TC23,
		C
	);


	processD PD(
		TD0,  TD1,  TD2,  TD3,  TD4,  TD5,  
		TD6,  TD7,  TD8,  TD9,  TD10, TD11, 
		TD12, TD13, TD14, TD15, TD16, TD17,
		TD18, TD19, TD20, TD21, TD22, TD23,
		D
	);
	
	//organizing the final result into 24 192-bit round keys
	always @(*) begin 
		integer i = 0;
		for (i = 0; i < 24; i = i + 1) 
			RK[i] = {TA[i],TB[i],TC[i],TB[i],TD[i],TB[i]};
	end

endmodule
