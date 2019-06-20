module shifter (
	output reg  [31:0] out,
	input  wire [31:0] in,
	input  wire [4: 0] shift
);
	/*
	 * A for-loop-friendly circular left shift module
	 * Shifts up to 23 times. Could be easily extended. 
	 */

	always @ (*) begin
			  if (shift ==  0) out =  in;
		else if (shift ==  1) out = {in[30:0], in[   31]};
		else if (shift ==  2) out = {in[29:0], in[31:30]};
		else if (shift ==  3) out = {in[28:0], in[31:29]};
		else if (shift ==  4) out = {in[27:0], in[31:28]};
		else if (shift ==  5) out = {in[26:0], in[31:27]};
		else if (shift ==  6) out = {in[25:0], in[31:26]};
		else if (shift ==  7) out = {in[24:0], in[31:25]};
		else if (shift ==  8) out = {in[23:0], in[31:24]};
		else if (shift ==  9) out = {in[22:0], in[31:23]};
		else if (shift == 10) out = {in[21:0], in[31:22]};
		else if (shift == 11) out = {in[20:0], in[31:21]};
		else if (shift == 12) out = {in[19:0], in[31:20]};
		else if (shift == 13) out = {in[18:0], in[31:19]};
		else if (shift == 14) out = {in[17:0], in[31:18]};
		else if (shift == 15) out = {in[16:0], in[31:17]};
		else if (shift == 16) out = {in[15:0], in[31:16]};
		else if (shift == 17) out = {in[14:0], in[31:15]};
		else if (shift == 18) out = {in[13:0], in[31:14]};
		else if (shift == 19) out = {in[12:0], in[31:13]};
		else if (shift == 20) out = {in[11:0], in[31:12]};
		else if (shift == 21) out = {in[10:0], in[31:11]};
		else if (shift == 22) out = {in[9: 0], in[31:10]};
		else                  out = {in[8: 0], in[31: 9]};
	end

endmodule 