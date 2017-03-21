module time_create(inNum,outNum0,outNum1);
	//A14
	input inNum;
	output reg outNum0;
	output outNum1;
	
	assign outNum1 = inNum;

	always @ (posedge inNum)
		outNum0 <= ~outNum0;
	
	initial outNum0 <= 0;

endmodule
