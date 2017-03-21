module time_create(inNum,outdt0,outdt1);
	input inNum;
	output reg outdt0;
	output outdt1;
	
	assign outdt1 = inNum;

	always @ (posedge inNum)
		outdt0 <= ~outdt0;
	
	initial outdt0 <= 0;

endmodule
