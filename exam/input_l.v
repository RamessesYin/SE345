module input_l(inNum4,inNum3,inNum2,inNum1,inNum0,,outdt);
	input inNum4,inNum3,inNum2,inNum1,inNum0;
	output [31:0] outdt;
	assign outdt[4]=inNum4;
	assign outdt[3]=inNum3;
	assign outdt[2]=inNum2;
	assign outdt[1]=inNum1;
	assign outdt[0]=inNum0;
endmodule
