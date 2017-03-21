module numTrans(inNum4,inNum3,inNum2,inNum1,inNum0,,outNum);
	input inNum4,inNum3,inNum2,inNum1,inNum0;
	output [31:0] outNum;
	assign outNum[4]=inNum4;
	assign outNum[3]=inNum3;
	assign outNum[2]=inNum2;
	assign outNum[1]=inNum1;
	assign outNum[0]=inNum0;
endmodule